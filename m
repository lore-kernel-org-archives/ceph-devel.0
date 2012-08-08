From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH v4] rbd: fix the memory leak of bio_chain_clone
Date: Wed, 08 Aug 2012 09:46:27 -0700
Message-ID: <502297E3.7020007@inktank.com>
References: <1344015188-11289-1-git-send-email-gzhao@suse.com> <5021D3B1.20401@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47979 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758853Ab2HHQqb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Aug 2012 12:46:31 -0400
Received: by yhmm54 with SMTP id m54so974102yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 08 Aug 2012 09:46:31 -0700 (PDT)
In-Reply-To: <5021D3B1.20401@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <gzhao@suse.com>
Cc: yehuda@inktank.com, ceph-devel@vger.kernel.org

On 08/07/2012 07:49 PM, Alex Elder wrote:
> On 08/03/2012 10:33 AM, Guangliang Zhao wrote:
>> The bio_pair alloced in bio_chain_clone would not be freed,
>> this will cause a memory leak. It could be freed actually only
>> after 3 times release, because the reference count of bio_pair
>> is initialized to 3 when bio_split and bio_pair_release only
>> drops the reference count.
>
> Last Friday I added this patch to the testing branch and
> ran the xfstests-on-rbd suite on it, and it triggered some
> new errors.  I did not have time to investigate them though.
>
> I am taking this latest version and will apply it and will
> run it through the same series of tests.


Testing again, test 013 in the xfstests suite failed.  (Sorry
I don't have a record of where failures occurred on Friday;
maybe Yehuda does.)  The failure was that xfs_repair found an
inconsistent file system after running fsstress (I believe it
was running 20 concurrent copies).

I ran through the tests again, and the second time it did not
encounter a problem on test 013.  It hit a similar problem
on test 269, which also runs fsstress, as well as a series
of "dd" commands.  Again the problem was that the XFS
filesystem running over an rbd device was found to be corrupt
after the test.

I will review the patch today to see if I can offer any
insights about why we might be hitting these apparently
timing-sensitive errors.

					-Alex



> I also had hoped to give your patch a careful review, but
> so far I haven't managed to do that (yet).
>
> I just want you to know you haven't been forgotten...
>
>                      -Alex
>>
>> The function bio_pair_release must be called three times for
>> releasing bio_pair, and the callback functions of bios on the
>> requests will be called when the last release time in bio_pair_release,
>> however, these functions will also be called in rbd_req_cb. In
>> other words, they will be called twice, and it may cause serious
>> consequences.
>>
>> This patch clones bio chain from the origin directly instead of
>> bio_split. The new bio chain can be released whenever we don't
>> need it.
>>
>> This patch can just handle the split of *single page* bios, but
>> it's enough here for the following reasons:
>>
>> Only bios span across multiple osds need to be split, and these bios
>> *must* be single page because of rbd_merge_bvec. With the function,
>> the new bvec will not permitted to merge, if it make the bio cross
>> the osd boundary, except it is the first one. In other words, there
>> are two types of bio:
>>
>>     - the bios don't cross the osd boundary
>>       They have one or more pages. The value of offset will
>>       always be 0 in this case, so nothing will be changed, and
>>       the code changes tmp bios doesn't take effact at all.
>>
>>     - the bios cross the osd boundary
>>       Each one have only one page. These bios need to be split,
>>       and the offset is used to indicate the next bio, it makes
>>       sense only in this instance.
>>
>> Signed-off-by: Guangliang Zhao <gzhao@suse.com>
>> ---
>>   drivers/block/rbd.c |   73
>> +++++++++++++++++++++-----------------------------
>>   1 files changed, 31 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 013c7a5..356657d 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -712,51 +712,46 @@ static void zero_bio_chain(struct bio *chain,
>> int start_ofs)
>>       }
>>   }
>>
>> -/*
>> - * bio_chain_clone - clone a chain of bios up to a certain length.
>> - * might return a bio_pair that will need to be released.
>> +/**
>> + *      bio_chain_clone - clone a chain of bios up to a certain length.
>> + *      @old: bio to clone
>> + *      @offset: start point for bio clone
>> + *      @len: length of bio chain
>> + *      @gfp_mask: allocation priority
>> + *
>> + *      RETURNS:
>> + *      Pointer to new bio chain on success, NULL on failure.
>>    */
>> -static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
>> -                   struct bio_pair **bp,
>> +static struct bio *bio_chain_clone(struct bio **old, int *offset,
>>                      int len, gfp_t gfpmask)
>>   {
>>       struct bio *tmp, *old_chain = *old, *new_chain = NULL, *tail =
>> NULL;
>>       int total = 0;
>>
>> -    if (*bp) {
>> -        bio_pair_release(*bp);
>> -        *bp = NULL;
>> -    }
>> -
>>       while (old_chain && (total < len)) {
>> +        int need = len - total;
>> +
>>           tmp = bio_kmalloc(gfpmask, old_chain->bi_max_vecs);
>>           if (!tmp)
>>               goto err_out;
>>
>> -        if (total + old_chain->bi_size > len) {
>> -            struct bio_pair *bp;
>> -
>> -            /*
>> -             * this split can only happen with a single paged bio,
>> -             * split_bio will BUG_ON if this is not the case
>> -             */
>> -            dout("bio_chain_clone split! total=%d remaining=%d"
>> -                 "bi_size=%d\n",
>> -                 (int)total, (int)len-total,
>> -                 (int)old_chain->bi_size);
>> -
>> -            /* split the bio. We'll release it either in the next
>> -               call, or it will have to be released outside */
>> -            bp = bio_split(old_chain, (len - total) / SECTOR_SIZE);
>> -            if (!bp)
>> -                goto err_out;
>> -
>> -            __bio_clone(tmp, &bp->bio1);
>> -
>> -            *next = &bp->bio2;
>> +        __bio_clone(tmp, old_chain);
>> +        tmp->bi_sector += *offset >> SECTOR_SHIFT;
>> +        tmp->bi_io_vec->bv_offset += *offset >> SECTOR_SHIFT;
>> +        /*
>> +         * The bios span across multiple osd objects must be
>> +         * single paged, rbd_merge_bvec would guarantee it.
>> +         * So we needn't worry about other things.
>> +         */
>> +        if (tmp->bi_size - *offset > need) {
>> +            tmp->bi_size = need;
>> +            tmp->bi_io_vec->bv_len = need;
>> +            *offset += need;
>>           } else {
>> -            __bio_clone(tmp, old_chain);
>> -            *next = old_chain->bi_next;
>> +            old_chain = old_chain->bi_next;
>> +            tmp->bi_size -= *offset;
>> +            tmp->bi_io_vec->bv_len -= *offset;
>> +            *offset = 0;
>>           }
>>
>>           tmp->bi_bdev = NULL;
>> @@ -769,7 +764,6 @@ static struct bio *bio_chain_clone(struct bio
>> **old, struct bio **next,
>>               tail->bi_next = tmp;
>>               tail = tmp;
>>           }
>> -        old_chain = old_chain->bi_next;
>>
>>           total += tmp->bi_size;
>>       }
>> @@ -1447,13 +1441,12 @@ static void rbd_rq_fn(struct request_queue *q)
>>   {
>>       struct rbd_device *rbd_dev = q->queuedata;
>>       struct request *rq;
>> -    struct bio_pair *bp = NULL;
>>
>>       while ((rq = blk_fetch_request(q))) {
>>           struct bio *bio;
>> -        struct bio *rq_bio, *next_bio = NULL;
>> +        struct bio *rq_bio;
>>           bool do_write;
>> -        int size, op_size = 0;
>> +        int size, op_size = 0, offset = 0;
>>           u64 ofs;
>>           int num_segs, cur_seg = 0;
>>           struct rbd_req_coll *coll;
>> @@ -1503,7 +1496,7 @@ static void rbd_rq_fn(struct request_queue *q)
>>                             ofs, size,
>>                             NULL, NULL);
>>               kref_get(&coll->kref);
>> -            bio = bio_chain_clone(&rq_bio, &next_bio, &bp,
>> +            bio = bio_chain_clone(&rq_bio, &offset,
>>                             op_size, GFP_ATOMIC);
>>               if (!bio) {
>>                   rbd_coll_end_req_index(rq, coll, cur_seg,
>> @@ -1531,12 +1524,8 @@ next_seg:
>>               ofs += op_size;
>>
>>               cur_seg++;
>> -            rq_bio = next_bio;
>>           } while (size > 0);
>>           kref_put(&coll->kref, rbd_coll_release);
>> -
>> -        if (bp)
>> -            bio_pair_release(bp);
>>           spin_lock_irq(q->queue_lock);
>>       }
>>   }
>>
>

