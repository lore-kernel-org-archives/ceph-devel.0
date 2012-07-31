From: Guangliang Zhao <gzhao@suse.com>
Subject: Re: [PATCH v3] rbd: fix the memory leak of bio_chain_clone
Date: Wed, 1 Aug 2012 00:42:39 +0800
Message-ID: <20120731164239.GA24447@linux-b964.site>
References: <1343370017-8794-1-git-send-email-gzhao@suse.com>
 <CAC-hyiH=HQVfGz-GQAMyymttMsW2NuuCjpZpwKec=O6T5B1Lgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [106.3.63.68] ([106.3.63.68]:12721 "EHLO linux-b964.site"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755683Ab2GaQmm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 Jul 2012 12:42:42 -0400
Content-Disposition: inline
In-Reply-To: <CAC-hyiH=HQVfGz-GQAMyymttMsW2NuuCjpZpwKec=O6T5B1Lgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 30, 2012 at 02:54:44PM -0700, Yehuda Sadeh wrote:
> On Thu, Jul 26, 2012 at 11:20 PM, Guangliang Zhao <gzhao@suse.com> wrote:
> > The bio_pair alloced in bio_chain_clone would not be freed,
> > this will cause a memory leak. It could be freed actually only
> > after 3 times release, because the reference count of bio_pair
> > is initialized to 3 when bio_split and bio_pair_release only
> > drops the reference count.
> >
> > The function bio_pair_release must be called three times for
> > releasing bio_pair, and the callback functions of bios on the
> > requests will be called when the last release time in bio_pair_release,
> > however, these functions will also be called in rbd_req_cb. In
> > other words, they will be called twice, and it may cause serious
> > consequences.
> >
> > This patch clones bio chian from the origin directly, doesn't use
> > bio_split(without bio_pair). The new bio chain can be release
> > whenever we don't need it.
> >
> > Signed-off-by: Guangliang Zhao <gzhao@suse.com>
> > ---
> >  drivers/block/rbd.c |   73 +++++++++++++++++++++-----------------------------
> >  1 files changed, 31 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index 013c7a5..356657d 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -712,51 +712,46 @@ static void zero_bio_chain(struct bio *chain, int start_ofs)
> >         }
> >  }
> >
> > -/*
> > - * bio_chain_clone - clone a chain of bios up to a certain length.
> > - * might return a bio_pair that will need to be released.
> > +/**
> > + *      bio_chain_clone - clone a chain of bios up to a certain length.
> > + *      @old: bio to clone
> > + *      @offset: start point for bio clone
> > + *      @len: length of bio chain
> > + *      @gfp_mask: allocation priority
> > + *
> > + *      RETURNS:
> > + *      Pointer to new bio chain on success, NULL on failure.
> >   */
> > -static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
> > -                                  struct bio_pair **bp,
> > +static struct bio *bio_chain_clone(struct bio **old, int *offset,
> >                                    int len, gfp_t gfpmask)
> >  {
> >         struct bio *tmp, *old_chain = *old, *new_chain = NULL, *tail = NULL;
> >         int total = 0;
> >
> > -       if (*bp) {
> > -               bio_pair_release(*bp);
> > -               *bp = NULL;
> > -       }
> > -
> >         while (old_chain && (total < len)) {
> > +               int need = len - total;
> > +
> >                 tmp = bio_kmalloc(gfpmask, old_chain->bi_max_vecs);
> >                 if (!tmp)
> >                         goto err_out;
> >
> > -               if (total + old_chain->bi_size > len) {
> > -                       struct bio_pair *bp;
> > -
> > -                       /*
> > -                        * this split can only happen with a single paged bio,
> > -                        * split_bio will BUG_ON if this is not the case
> > -                        */
> > -                       dout("bio_chain_clone split! total=%d remaining=%d"
> > -                            "bi_size=%d\n",
> > -                            (int)total, (int)len-total,
> > -                            (int)old_chain->bi_size);
> > -
> > -                       /* split the bio. We'll release it either in the next
> > -                          call, or it will have to be released outside */
> > -                       bp = bio_split(old_chain, (len - total) / SECTOR_SIZE);
> > -                       if (!bp)
> > -                               goto err_out;
> > -
> > -                       __bio_clone(tmp, &bp->bio1);
> > -
> > -                       *next = &bp->bio2;
> > +               __bio_clone(tmp, old_chain);
> > +               tmp->bi_sector += *offset >> SECTOR_SHIFT;
> > +               tmp->bi_io_vec->bv_offset += *offset >> SECTOR_SHIFT;
> > +               /*
> > +                * The bios span across multiple osd objects must be
> > +                * single paged, rbd_merge_bvec would guarantee it.
> > +                * So we needn't worry about other things.
> > +                */
> > +               if (tmp->bi_size - *offset > need) {
> > +                       tmp->bi_size = need;
> > +                       tmp->bi_io_vec->bv_len = need;
> > +                       *offset += need;
> >                 } else {
> > -                       __bio_clone(tmp, old_chain);
> > -                       *next = old_chain->bi_next;
> > +                       old_chain = old_chain->bi_next;
> > +                       tmp->bi_size -= *offset;
> > +                       tmp->bi_io_vec->bv_len -= *offset;
> > +                       *offset = 0;
> >                 }
> >
> There's still some inherent issue here, which is it assumes
> tmp->bi_io_vec points to the only iovec for this bio. I don't think
> that is necessarily true, there may be multiple iovecs, 

Yes, the bios on the requests may have one or more pages, but the ones span across
multiple osds *must* be single page bios because of rbd_merge_bvec.

With rbd_merge_bvec, the new bvec will not permitted to merge, if it make the bio cross 
the osd boundary, except the bvec is the first one. In other words, there are two 
types of bio:

1) The bios don't cross the osd boundary, they may have several iovecs. 
The value of offset will always be 0 in this case, so nothing will be changed, and
the code changes tmp bios doesn't take effact at all.

2) The bios cross the osd boundary, each one have only one page.
These bios need to be split in this case, and the offset is used to indicate the next bio, 
it makes sense only in this instance. The orgin code use bio_split which can only handle 
single page bios too.

So, you maybe worry about the multiple iovecs bios. They wouldn't cross the osd boundary,
offset is always 0, so tmp bios are as same as the orgins. The needn't and wouldn't to 
be changed. 

Thanks for your reply :).

-- 
Best regards,
Guangliang
