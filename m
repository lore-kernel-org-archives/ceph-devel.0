From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH v5] rbd: fix the memory leak of bio_chain_clone
Date: Tue, 11 Sep 2012 16:17:47 -0500
Message-ID: <504FAA7B.8080001@inktank.com>
References: <1346931051-8252-1-git-send-email-gzhao@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39178 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab2IKVRw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 17:17:52 -0400
Received: by iahk25 with SMTP id k25so749418iah.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 14:17:51 -0700 (PDT)
In-Reply-To: <1346931051-8252-1-git-send-email-gzhao@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <gzhao@suse.com>
Cc: ceph-devel@vger.kernel.org

On 09/06/2012 06:30 AM, Guangliang Zhao wrote:
> The bio_pair alloced in bio_chain_clone would not be freed,
> this will cause a memory leak. It could be freed actually only
> after 3 times release, because the reference count of bio_pair
> is initialized to 3 when bio_split and bio_pair_release only
> drops the reference count.
> 
> The function bio_pair_release must be called three times for
> releasing bio_pair, and the callback functions of bios on the
> requests will be called when the last release time in bio_pair_release,
> however, these functions will also be called in rbd_req_cb. In
> other words, they will be called twice, and it may cause serious
> consequences.


I just want you to know I'm looking at this patch now.  This is a
pretty complex bit of code though, so it may take me a bit to get
back to you.

					-Alex

> This patch clones bio chain from the origin directly instead of
> bio_split. The old bios which will be split may be modified by
> the callback fn, so their copys need to be saved(called split_bio).
> The new bio chain can be released whenever we don't need it.
> 
> This patch can just handle the split of *single page* bios, but
> it's enough here for the following reasons:
> 
> Only bios span across multiple osds need to be split, and these bios
> *must* be single page because of rbd_merge_bvec. With the function,
> the new bvec will not permitted to merge, if it make the bio cross
> the osd boundary, except it is the first one. In other words, there
> are two types of bio:
> 
> 	- the bios don't cross the osd boundary
> 	  They have one or more pages. The value of offset will
> 	  always be 0 in this case, so nothing will be changed, and
> 	  the code changes tmp bios doesn't take effact at all.
> 
> 	- the bios cross the osd boundary
> 	  Each one have only one page. These bios need to be split,
> 	  and the offset is used to indicate the next bio, it makes
> 	  sense only in this instance.
> 
> The original bios may be modifid by the callback fn before the next 
> bio_chain_clone() called, when a bio need to be split, so its copy 
> will be saved.
> 
> Signed-off-by: Guangliang Zhao <gzhao@suse.com>
> ---
> 
>  drivers/block/rbd.c |  102 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 60 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 9917943..a605e1c 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -717,50 +717,70 @@ static void zero_bio_chain(struct bio *chain, int start_ofs)
>  	}
>  }
>  
> -/*
> +/**
>   * bio_chain_clone - clone a chain of bios up to a certain length.
> - * might return a bio_pair that will need to be released.
> + * @old: bio to clone
> + * @split_bio: bio which will be split
> + * @offset: start point for bio clone
> + * @len: length of bio chain
> + * @gfp_mask: allocation priority
> + *
> + * Value of split_bio will be !NULL only when there is a bio need to be
> + * split. NULL otherwise.
> + *
> + * RETURNS:
> + * Pointer to new bio chain on success, NULL on failure.
>   */
> -static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
> -				   struct bio_pair **bp,
> -				   int len, gfp_t gfpmask)
> +static struct bio *bio_chain_clone(struct bio **old, struct bio **split_bio,
> +				   int *offset, int len, gfp_t gfpmask)
>  {
> -	struct bio *tmp, *old_chain = *old, *new_chain = NULL, *tail = NULL;
> -	int total = 0;
> -
> -	if (*bp) {
> -		bio_pair_release(*bp);
> -		*bp = NULL;
> -	}
> +	struct bio *tmp, *old_chain, *split, *new_chain = NULL, *tail = NULL;
> +	int total = 0, need = len;
>  
> +	split = *split_bio;
> +	old_chain = split ? split : *old;
>  	while (old_chain && (total < len)) {
>  		tmp = bio_kmalloc(gfpmask, old_chain->bi_max_vecs);
>  		if (!tmp)
>  			goto err_out;
>  
> -		if (total + old_chain->bi_size > len) {
> -			struct bio_pair *bp;
> -
> -			/*
> -			 * this split can only happen with a single paged bio,
> -			 * split_bio will BUG_ON if this is not the case
> -			 */
> -			dout("bio_chain_clone split! total=%d remaining=%d"
> -			     "bi_size=%u\n",
> -			     total, len - total, old_chain->bi_size);
> -
> -			/* split the bio. We'll release it either in the next
> -			   call, or it will have to be released outside */
> -			bp = bio_split(old_chain, (len - total) / SECTOR_SIZE);
> -			if (!bp)
> -				goto err_out;
> -
> -			__bio_clone(tmp, &bp->bio1);
> -
> -			*next = &bp->bio2;
> +		__bio_clone(tmp, old_chain);
> +		tmp->bi_sector += *offset >> SECTOR_SHIFT;
> +		tmp->bi_io_vec->bv_offset += *offset >> SECTOR_SHIFT;
> +		/*
> +		 * The bios span across multiple osd objects must be
> +		 * single paged, rbd_merge_bvec would guarantee it.
> +		 * So we needn't worry about other things.
> +		 */
> +		if (tmp->bi_size - *offset > need) {
> +			tmp->bi_size = need;
> +			tmp->bi_io_vec->bv_len = need;
> +			*offset += need;
> +			if (!split) {
> +				/*
> +				 * Because the old bio may be modified by the
> +				 * callback function, its copy should be saved.
> +				 */
> +				split = bio_clone(old_chain, gfpmask);
> +				/*
> +				 * This is always the last allocation in this
> +				 * loop, so we only need release the bio chain
> +				 * when failed.
> +				 */
> +				if (!split)
> +					goto err_out;
> +
> +				split->bi_next = old_chain->bi_next;
> +			}
>  		} else {
> -			__bio_clone(tmp, old_chain);
> -			*next = old_chain->bi_next;
> +			old_chain = old_chain->bi_next;
> +			tmp->bi_size -= *offset;
> +			tmp->bi_io_vec->bv_len -= *offset;
> +			*offset = 0;
> +			if (split) {
> +				bio_put(split);
> +				split = NULL;
> +			}
>  		}
>  
>  		tmp->bi_bdev = NULL;
> @@ -773,9 +793,9 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
>  			tail->bi_next = tmp;
>  			tail = tmp;
>  		}
> -		old_chain = old_chain->bi_next;
>  
>  		total += tmp->bi_size;
> +		need -= tmp->bi_size;
>  	}
>  
>  	BUG_ON(total < len);
> @@ -784,6 +804,7 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
>  		tail->bi_next = NULL;
>  
>  	*old = old_chain;
> +	*split_bio = split;
>  
>  	return new_chain;
>  
> @@ -1434,16 +1455,15 @@ static void rbd_rq_fn(struct request_queue *q)
>  {
>  	struct rbd_device *rbd_dev = q->queuedata;
>  	struct request *rq;
> -	struct bio_pair *bp = NULL;
>  
>  	while ((rq = blk_fetch_request(q))) {
>  		struct bio *bio;
> -		struct bio *rq_bio, *next_bio = NULL;
> +		struct bio *rq_bio, *split_bio = NULL;
>  		bool do_write;
>  		unsigned int size;
>  		u64 op_size = 0;
>  		u64 ofs;
> -		int num_segs, cur_seg = 0;
> +		int num_segs, cur_seg = 0, offset = 0;
>  		struct rbd_req_coll *coll;
>  		struct ceph_snap_context *snapc;
>  
> @@ -1507,7 +1527,7 @@ static void rbd_rq_fn(struct request_queue *q)
>  						  ofs, size,
>  						  NULL, NULL);
>  			kref_get(&coll->kref);
> -			bio = bio_chain_clone(&rq_bio, &next_bio, &bp,
> +			bio = bio_chain_clone(&rq_bio, &split_bio, &offset,
>  					      op_size, GFP_ATOMIC);
>  			if (!bio) {
>  				rbd_coll_end_req_index(rq, coll, cur_seg,
> @@ -1535,12 +1555,10 @@ next_seg:
>  			ofs += op_size;
>  
>  			cur_seg++;
> -			rq_bio = next_bio;
>  		} while (size > 0);
>  		kref_put(&coll->kref, rbd_coll_release);
>  
> -		if (bp)
> -			bio_pair_release(bp);
> +		BUG_ON(split_bio);
>  		spin_lock_irq(q->queue_lock);
>  
>  		ceph_put_snap_context(snapc);
> 

