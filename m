From: Guangliang Zhao <gzhao@suse.com>
Subject: Re: [PATCH v4] rbd: fix the memory leak of bio_chain_clone
Date: Thu, 6 Sep 2012 19:10:11 +0800
Message-ID: <20120906111011.GA5677@linux-glzhao.site>
References: <1344015188-11289-1-git-send-email-gzhao@suse.com>
 <5021D3B1.20401@inktank.com>
 <502297E3.7020007@inktank.com>
 <502313F9.2060009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from user.194.126.222.zhong-ren.net ([222.126.194.154]:48819 "EHLO
	linux-391i.site" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750985Ab2IFLKQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 07:10:16 -0400
Content-Disposition: inline
In-Reply-To: <502313F9.2060009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 08, 2012 at 06:35:53PM -0700, Alex Elder wrote:
> On 08/08/2012 09:46 AM, Alex Elder wrote:
> >On 08/07/2012 07:49 PM, Alex Elder wrote:
> >>On 08/03/2012 10:33 AM, Guangliang Zhao wrote:

Hi Alex,

Sorry for so late reply.

> However I think it would be preferable to have a solution that
> fixes the underlying problem with how we're using the result of
> a bio_split() call instead of what you've proposed here.  The
> whole purpose of bio_split() is to handle exactly the kind of
> situation we're facing here, and I think it's unwise to try to
> invent a different way of handling this scenario.

I quite agree with you, but there will be another problem with bio_split().

> Granted, it may not be easy to fix the rbd code to fit the model
> most other callers use when they call bio_split().  However if
> the result of bio_chain_clone() produced one bio chain that ended
> with bp->bio1 and a second chain that began with bp->bio2, and
> then called bio_pair_release() after either the rbd_req_write()
> or rbd_req_read() request, then there might no longer be the
> leak.

Good idea, but the callback functions of original bios would be called 
twice: one is from bio_pair_release(), and another is __blk_end_request(
called by rbd_req_cb finally).

> >>>The function bio_pair_release must be called three times for
> >>>releasing bio_pair, and the callback functions of bios on the
> >>>requests will be called when the last release time in bio_pair_release,
> >>>however, these functions will also be called in rbd_req_cb. In
> >>>other words, they will be called twice, and it may cause serious
> >>>consequences.
> >>>
> >>>This patch clones bio chain from the origin directly instead of
> >>>bio_split. The new bio chain can be released whenever we don't
> >>>need it.
> >>>
> >>>This patch can just handle the split of *single page* bios, but
> >>>it's enough here for the following reasons:
> >>>
> >>>Only bios span across multiple osds need to be split, and these bios
> >>>*must* be single page because of rbd_merge_bvec. With the function,
> >>>the new bvec will not permitted to merge, if it make the bio cross
> >>>the osd boundary, except it is the first one. In other words, there
> >>>are two types of bio:
> >>>
> >>>    - the bios don't cross the osd boundary
> >>>      They have one or more pages. The value of offset will
> >>>      always be 0 in this case, so nothing will be changed, and
> >>>      the code changes tmp bios doesn't take effact at all.
> >>>
> >>>    - the bios cross the osd boundary
> >>>      Each one have only one page. These bios need to be split,
> >>>      and the offset is used to indicate the next bio, it makes
> >>>      sense only in this instance.
> >>>
> >>>Signed-off-by: Guangliang Zhao <gzhao@suse.com>
> >>>---
> >>>  drivers/block/rbd.c |   73
> >>>+++++++++++++++++++++-----------------------------
> >>>  1 files changed, 31 insertions(+), 42 deletions(-)
> >>>
> >>>diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> >>>index 013c7a5..356657d 100644
> >>>--- a/drivers/block/rbd.c
> >>>+++ b/drivers/block/rbd.c
> >>>@@ -712,51 +712,46 @@ static void zero_bio_chain(struct bio *chain,
> >>>int start_ofs)
> >>>      }
> >>>  }
> >>>
> >>>-/*
> >>>- * bio_chain_clone - clone a chain of bios up to a certain length.
> >>>- * might return a bio_pair that will need to be released.
> >>>+/**
> >>>+ *      bio_chain_clone - clone a chain of bios up to a certain length.
> >>>+ *      @old: bio to clone
> >>>+ *      @offset: start point for bio clone
> >>>+ *      @len: length of bio chain
> >>>+ *      @gfp_mask: allocation priority
> >>>+ *
> >>>+ *      RETURNS:
> >>>+ *      Pointer to new bio chain on success, NULL on failure.
> >>>   */
> >>>-static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
> >>>-                   struct bio_pair **bp,
> >>>+static struct bio *bio_chain_clone(struct bio **old, int *offset,
> >>>                     int len, gfp_t gfpmask)
> >>>  {
> >>>      struct bio *tmp, *old_chain = *old, *new_chain = NULL, *tail =
> >>>NULL;
> >>>      int total = 0;
> >>>
> >>>-    if (*bp) {
> >>>-        bio_pair_release(*bp);
> >>>-        *bp = NULL;
> >>>-    }
> >>>-
> >>>      while (old_chain && (total < len)) {
> >>>+        int need = len - total;
> >>>+
> >>>          tmp = bio_kmalloc(gfpmask, old_chain->bi_max_vecs);
> >>>          if (!tmp)
> >>>              goto err_out;
> >>>
> >>>-        if (total + old_chain->bi_size > len) {
> >>>-            struct bio_pair *bp;
> >>>-
> >>>-            /*
> >>>-             * this split can only happen with a single paged bio,
> >>>-             * split_bio will BUG_ON if this is not the case
> >>>-             */
> >>>-            dout("bio_chain_clone split! total=%d remaining=%d"
> >>>-                 "bi_size=%d\n",
> >>>-                 (int)total, (int)len-total,
> >>>-                 (int)old_chain->bi_size);
> >>>-
> >>>-            /* split the bio. We'll release it either in the next
> >>>-               call, or it will have to be released outside */
> >>>-            bp = bio_split(old_chain, (len - total) / SECTOR_SIZE);
> >>>-            if (!bp)
> >>>-                goto err_out;
> >>>-
> >>>-            __bio_clone(tmp, &bp->bio1);
> >>>-
> >>>-            *next = &bp->bio2;
> >>>+        __bio_clone(tmp, old_chain);
> >>>+        tmp->bi_sector += *offset >> SECTOR_SHIFT;
> >>>+        tmp->bi_io_vec->bv_offset += *offset >> SECTOR_SHIFT;
> >>>+        /*
> >>>+         * The bios span across multiple osd objects must be
> >>>+         * single paged, rbd_merge_bvec would guarantee it.
> >>>+         * So we needn't worry about other things.
> >>>+         */
> >>>+        if (tmp->bi_size - *offset > need) {
> >>>+            tmp->bi_size = need;
> >>>+            tmp->bi_io_vec->bv_len = need;
> >>>+            *offset += need;
> 
> This is the splitting case.
> 
> You are updating the new bio (tmp) by making its size and
> iovec length be the number of bytes in the first part of
> the original bio--the part being split off.
> 
> But you are *not* updating the original bio to reflect this.
> That is, I think you need something like:
> 
> 		old_chain->bi_size -= need;
> 		old_chain->bi_io_vec->bv_offset += need;
> 		old_chain->bi_io_vec->bv_len -= need;
The original bios will be updated by __blk_end_request, we shouldn't touch 
anything belong to them.

I think I have found the issue of the patch, and will send the next version.

-- 
Best regards,
Guangliang
