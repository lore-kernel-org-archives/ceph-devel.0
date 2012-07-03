From: Guangliang Zhao <gzhao@suse.com>
Subject: Re: [PATCH] rbd: fix the memory leak of bio_chain_clone
Date: Tue, 3 Jul 2012 23:31:34 +0800
Message-ID: <20120703153134.GA3223@linux-b964.site>
References: <1340609863-10971-1-git-send-email-gzhao@suse.com>
 <CAC-hyiFJSDtmgbSXn=N-mNKcuWuqiE9fPxtVz1fRFw4Q-j7HMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [106.3.63.5] ([106.3.63.5]:5834 "EHLO linux-b964.site"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754426Ab2GCPjw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 Jul 2012 11:39:52 -0400
Content-Disposition: inline
In-Reply-To: <CAC-hyiFJSDtmgbSXn=N-mNKcuWuqiE9fPxtVz1fRFw4Q-j7HMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org, Guangliang Zhao <gzhao@suse.com>

On Mon, Jul 02, 2012 at 03:48:14PM -0700, Yehuda Sadeh wrote:
> On Mon, Jun 25, 2012 at 12:37 AM, Guangliang Zhao <gzhao@suse.com> wrote:
> > Signed-off-by: Guangliang Zhao <gzhao@suse.com>
> > ---
> >  drivers/block/rbd.c |   10 ++++------
> >  1 files changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index 65665c9..3d6dfc8 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -719,8 +719,6 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
> >                         goto err_out;
> >
> >                 if (total + old_chain->bi_size > len) {
> > -                       struct bio_pair *bp;
> > -
> >                         /*
> >                          * this split can only happen with a single paged bio,
> >                          * split_bio will BUG_ON if this is not the case
> > @@ -732,13 +730,13 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
> >
> >                         /* split the bio. We'll release it either in the next
> >                            call, or it will have to be released outside */
> > -                       bp = bio_split(old_chain, (len - total) / SECTOR_SIZE);
> > -                       if (!bp)
> > +                       *bp = bio_split(old_chain, (len - total) / SECTOR_SIZE);
> > +                       if (!*bp)
> >                                 goto err_out;
> >
> > -                       __bio_clone(tmp, &bp->bio1);
> > +                       __bio_clone(tmp, &(*bp)->bio1);
> >
> > -                       *next = &bp->bio2;
> > +                       *next = &(*bp)->bio2;
> >                 } else {
> >                         __bio_clone(tmp, old_chain);
> >                         *next = old_chain->bi_next;
> 
> The above patch looks right, that is, fixes a leak. However, I'm not
> too sure that we're not missing some bigger problem that was hidden
> (due to the leak). Effectively we never called bio_pair_release() on
> the bio_pair that we created in bio_chain_clone(). However, I think we
> should only call that after we're done with sending the data. 
The bio_pair is only used to split the orgin bio and clone them to the tmps,
no one will touch it again, so I think it is safe release it here. 

The bio_pair could be freed actually only after 3 times release, because 
the reference count of bio_pair is initialized to 3 when bio_split and 
bio_pair_release only drops the reference count. There are not enough
release times for the bio_pair even apply either of these patches.

I think transferring data with bio1 and bio2 of bio_pair instead of the 
tmp bio chain is a better way. It can not only save mem(for tmp bio chain),
but also manage the reference count of bio_pair more comfortably(with callback 
of the bio1 and bio2). We can slove the above problems more easily with this
approach.

Thanks for you reply:)

-- 
Best regards,
Guangliang
