From: Guangliang Zhao <gzhao@suse.com>
Subject: Re: [PATCH v2] rbd: fix the memory leak of bio_chain_clone
Date: Fri, 27 Jul 2012 14:17:50 +0800
Message-ID: <20120727061749.GA7422@linux-b964.site>
References: <1343110007-10922-1-git-send-email-gzhao@suse.com>
 <CAC-hyiFcUsu-q3-PosCb_4WdA7RXAuPy2vLsBRpRJZNKSiYUgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from user.194.126.222.zhong-ren.net ([222.126.194.154]:38566 "EHLO
	linux-b964.site" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751208Ab2G0GSU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jul 2012 02:18:20 -0400
Content-Disposition: inline
In-Reply-To: <CAC-hyiFcUsu-q3-PosCb_4WdA7RXAuPy2vLsBRpRJZNKSiYUgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jul 24, 2012 at 12:28:47PM -0700, Yehuda Sadeh wrote:
> On Mon, Jul 23, 2012 at 11:06 PM, Guangliang Zhao <gzhao@suse.com> wrote:
> >
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
> >  drivers/block/rbd.c |   73
> > +++++++++++++++++++++-----------------------------
> >  1 files changed, 31 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index 013c7a5..5aa45fa 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -712,51 +712,46 @@ static void zero_bio_chain(struct bio *chain, int
> > start_ofs)
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
> >         struct bio *tmp, *old_chain = *old, *new_chain = NULL, *tail =
> > NULL;
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
> > -                        * this split can only happen with a single paged
> > bio,
> > -                        * split_bio will BUG_ON if this is not the case
> > -                        */
> > -                       dout("bio_chain_clone split! total=%d
> > remaining=%d"
> > -                            "bi_size=%d\n",
> > -                            (int)total, (int)len-total,
> > -                            (int)old_chain->bi_size);
> > -
> > -                       /* split the bio. We'll release it either in the
> > next
> > -                          call, or it will have to be released outside */
> > -                       bp = bio_split(old_chain, (len - total) /
> > SECTOR_SIZE);
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
> > +                       tmp->bi_io_vec->bv_offset -= *offset;
> 
> offset is the position within the bio chain, bv_offset is the offset
> within the specific page. Does this make sense?

Sorry for that mistake, it should be:
tmp->bi_io_vec->bv_len -= *offset;

> 
> 
> > +                       *offset = 0;
> >                 }
> >
> >                 tmp->bi_bdev = NULL;
> > @@ -769,7 +764,6 @@ static struct bio *bio_chain_clone(struct bio **old,
> > struct bio **next,
> >                         tail->bi_next = tmp;
> >                         tail = tmp;
> >                 }
> > -               old_chain = old_chain->bi_next;
> >
> >                 total += tmp->bi_size;
> >         }
> > @@ -1447,13 +1441,12 @@ static void rbd_rq_fn(struct request_queue *q)
> >  {
> >         struct rbd_device *rbd_dev = q->queuedata;
> >         struct request *rq;
> > -       struct bio_pair *bp = NULL;
> >
> >         while ((rq = blk_fetch_request(q))) {
> >                 struct bio *bio;
> > -               struct bio *rq_bio, *next_bio = NULL;
> > +               struct bio *rq_bio;
> >                 bool do_write;
> > -               int size, op_size = 0;
> > +               int size, op_size = 0, offset = 0;
> >                 u64 ofs;
> >                 int num_segs, cur_seg = 0;
> >                 struct rbd_req_coll *coll;
> > @@ -1503,7 +1496,7 @@ static void rbd_rq_fn(struct request_queue *q)
> >                                                   ofs, size,
> >                                                   NULL, NULL);
> >                         kref_get(&coll->kref);
> > -                       bio = bio_chain_clone(&rq_bio, &next_bio, &bp,
> > +                       bio = bio_chain_clone(&rq_bio, &offset,
> >                                               op_size, GFP_ATOMIC);
> >                         if (!bio) {
> >                                 rbd_coll_end_req_index(rq, coll, cur_seg,
> > @@ -1531,12 +1524,8 @@ next_seg:
> >                         ofs += op_size;
> >
> >                         cur_seg++;
> > -                       rq_bio = next_bio;
> >                 } while (size > 0);
> >                 kref_put(&coll->kref, rbd_coll_release);
> > -
> > -               if (bp)
> > -                       bio_pair_release(bp);
> >                 spin_lock_irq(q->queue_lock);
> >         }
> >  }
> > --
> > 1.7.3.4
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks for you reply.

-- 
Best regards,
Guangliang
