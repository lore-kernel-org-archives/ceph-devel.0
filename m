From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH v4] rbd: fix the memory leak of bio_chain_clone
Date: Tue, 07 Aug 2012 19:49:21 -0700
Message-ID: <5021D3B1.20401@inktank.com>
References: <1344015188-11289-1-git-send-email-gzhao@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60644 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972Ab2HHCtY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 22:49:24 -0400
Received: by pbbrr13 with SMTP id rr13so677148pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Aug 2012 19:49:24 -0700 (PDT)
In-Reply-To: <1344015188-11289-1-git-send-email-gzhao@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <gzhao@suse.com>
Cc: yehuda@inktank.com, ceph-devel@vger.kernel.org

On 08/03/2012 10:33 AM, Guangliang Zhao wrote:
> The bio_pair alloced in bio_chain_clone would not be freed,
> this will cause a memory leak. It could be freed actually only
> after 3 times release, because the reference count of bio_pair
> is initialized to 3 when bio_split and bio_pair_release only
> drops the reference count.

Last Friday I added this patch to the testing branch and
ran the xfstests-on-rbd suite on it, and it triggered some
new errors.  I did not have time to investigate them though.

I am taking this latest version and will apply it and will
run it through the same series of tests.

I also had hoped to give your patch a careful review, but
so far I haven't managed to do that (yet).

I just want you to know you haven't been forgotten...

					-Alex
>
> The function bio_pair_release must be called three times for
> releasing bio_pair, and the callback functions of bios on the
> requests will be called when the last release time in bio_pair_release,
> however, these functions will also be called in rbd_req_cb. In
> other words, they will be called twice, and it may cause serious
> consequences.
>
> This patch clones bio chain from the origin directly instead of
> bio_split. The new bio chain can be released whenever we don't
> need it.
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
> Signed-off-by: Guangliang Zhao <gzhao@suse.com>
> ---
>   drivers/block/rbd.c |   73 +++++++++++++++++++++-----------------------------
>   1 files changed, 31 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 013c7a5..356657d 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -712,51 +712,46 @@ static void zero_bio_chain(struct bio *chain, int start_ofs)
>   	}
>   }
>
> -/*
> - * bio_chain_clone - clone a chain of bios up to a certain length.
> - * might return a bio_pair that will need to be released.
> +/**
> + *      bio_chain_clone - clone a chain of bios up to a certain length.
> + *      @old: bio to clone
> + *      @offset: start point for bio clone
> + *      @len: length of bio chain
> + *      @gfp_mask: allocation priority
> + *
> + *      RETURNS:
> + *      Pointer to new bio chain on success, NULL on failure.
>    */
> -static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
> -				   struct bio_pair **bp,
> +static struct bio *bio_chain_clone(struct bio **old, int *offset,
>   				   int len, gfp_t gfpmask)
>   {
>   	struct bio *tmp, *old_chain = *old, *new_chain = NULL, *tail = NULL;
>   	int total = 0;
>
> -	if (*bp) {
> -		bio_pair_release(*bp);
> -		*bp = NULL;
> -	}
> -
>   	while (old_chain && (total < len)) {
> +		int need = len - total;
> +
>   		tmp = bio_kmalloc(gfpmask, old_chain->bi_max_vecs);
>   		if (!tmp)
>   			goto err_out;
>
> -		if (total + old_chain->bi_size > len) {
> -			struct bio_pair *bp;
> -
> -			/*
> -			 * this split can only happen with a single paged bio,
> -			 * split_bio will BUG_ON if this is not the case
> -			 */
> -			dout("bio_chain_clone split! total=%d remaining=%d"
> -			     "bi_size=%d\n",
> -			     (int)total, (int)len-total,
> -			     (int)old_chain->bi_size);
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
>   		} else {
> -			__bio_clone(tmp, old_chain);
> -			*next = old_chain->bi_next;
> +			old_chain = old_chain->bi_next;
> +			tmp->bi_size -= *offset;
> +			tmp->bi_io_vec->bv_len -= *offset;
> +			*offset = 0;
>   		}
>
>   		tmp->bi_bdev = NULL;
> @@ -769,7 +764,6 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
>   			tail->bi_next = tmp;
>   			tail = tmp;
>   		}
> -		old_chain = old_chain->bi_next;
>
>   		total += tmp->bi_size;
>   	}
> @@ -1447,13 +1441,12 @@ static void rbd_rq_fn(struct request_queue *q)
>   {
>   	struct rbd_device *rbd_dev = q->queuedata;
>   	struct request *rq;
> -	struct bio_pair *bp = NULL;
>
>   	while ((rq = blk_fetch_request(q))) {
>   		struct bio *bio;
> -		struct bio *rq_bio, *next_bio = NULL;
> +		struct bio *rq_bio;
>   		bool do_write;
> -		int size, op_size = 0;
> +		int size, op_size = 0, offset = 0;
>   		u64 ofs;
>   		int num_segs, cur_seg = 0;
>   		struct rbd_req_coll *coll;
> @@ -1503,7 +1496,7 @@ static void rbd_rq_fn(struct request_queue *q)
>   						  ofs, size,
>   						  NULL, NULL);
>   			kref_get(&coll->kref);
> -			bio = bio_chain_clone(&rq_bio, &next_bio, &bp,
> +			bio = bio_chain_clone(&rq_bio, &offset,
>   					      op_size, GFP_ATOMIC);
>   			if (!bio) {
>   				rbd_coll_end_req_index(rq, coll, cur_seg,
> @@ -1531,12 +1524,8 @@ next_seg:
>   			ofs += op_size;
>
>   			cur_seg++;
> -			rq_bio = next_bio;
>   		} while (size > 0);
>   		kref_put(&coll->kref, rbd_coll_release);
> -
> -		if (bp)
> -			bio_pair_release(bp);
>   		spin_lock_irq(q->queue_lock);
>   	}
>   }
>

