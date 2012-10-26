From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 3/3] rbd: consolidate rbd_do_op() calls
Date: Fri, 26 Oct 2012 16:58:35 -0500
Message-ID: <508B078B.9010808@inktank.com>
References: <50762C54.40101@inktank.com> <50762CCB.5040007@inktank.com> <5088260B.7030308@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42652 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966528Ab2JZV6t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 17:58:49 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4430017iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 14:58:47 -0700 (PDT)
In-Reply-To: <5088260B.7030308@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/24/2012 12:31 PM, Josh Durgin wrote:
> This cleanup makes sense. We should probably check
> the return code now as well, as I note below.
> 
> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

I'm going to do this as a followup patch, next week.

					-Alex

> 
> On 10/10/2012 07:19 PM, Alex Elder wrote:
>> The two calls to rbd_do_op() from rbd_rq_fn() differ only in the
>> value passed for the snapshot id and the snapshot context.
>>
>> For reads the snapshot always comes from the mapping, and for writes
>> the snapshot id is always CEPH_NOSNAP.
>>
>> The snapshot context is always null for reads.  For writes, the
>> snapshot context always comes from the rbd header, but it is
>> acquired under protection of header semaphore and could change
>> thereafter, so we can't simply use what's available inside
>> rbd_do_op().
>>
>> Eliminate the snapid parameter from rbd_do_op(), and set it
>> based on the I/O direction inside that function instead.  Always
>> pass the snapshot context acquired in the caller, but reset it
>> to a null pointer inside rbd_do_op() if the operation is a read.
>>
>> As a result, there is no difference in the read and write calls
>> to rbd_do_op() made in rbd_rq_fn(), so just call it unconditionally.
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   drivers/block/rbd.c |   26 +++++++++-----------------
>>   1 file changed, 9 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 396af14..ca28036 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -1163,7 +1163,6 @@ done:
>>   static int rbd_do_op(struct request *rq,
>>                struct rbd_device *rbd_dev,
>>                struct ceph_snap_context *snapc,
>> -             u64 snapid,
>>                u64 ofs, u64 len,
>>                struct bio *bio,
>>                struct rbd_req_coll *coll,
>> @@ -1177,6 +1176,7 @@ static int rbd_do_op(struct request *rq,
>>       u32 payload_len;
>>       int opcode;
>>       int flags;
>> +    u64 snapid;
>>
>>       seg_name = rbd_segment_name(rbd_dev, ofs);
>>       if (!seg_name)
>> @@ -1187,10 +1187,13 @@ static int rbd_do_op(struct request *rq,
>>       if (rq_data_dir(rq) == WRITE) {
>>           opcode = CEPH_OSD_OP_WRITE;
>>           flags = CEPH_OSD_FLAG_WRITE|CEPH_OSD_FLAG_ONDISK;
>> +        snapid = CEPH_NOSNAP;
>>           payload_len = seg_len;
>>       } else {
>>           opcode = CEPH_OSD_OP_READ;
>>           flags = CEPH_OSD_FLAG_READ;
>> +        snapc = NULL;
>> +        snapid = rbd_dev->mapping.snap_id;
>>           payload_len = 0;
>>       }
>>
>> @@ -1518,24 +1521,13 @@ static void rbd_rq_fn(struct request_queue *q)
>>               kref_get(&coll->kref);
>>               bio = bio_chain_clone(&rq_bio, &next_bio, &bp,
>>                             op_size, GFP_ATOMIC);
>> -            if (!bio) {
>> +            if (bio)
>> +                (void) rbd_do_op(rq, rbd_dev, snapc,
>> +                        ofs, op_size,
>> +                        bio, coll, cur_seg);
> 
> We could check the error code here pretty easily now.
> 
>> +            else
>>                   rbd_coll_end_req_index(rq, coll, cur_seg,
>>                                  -ENOMEM, op_size);
>> -                goto next_seg;
>> -            }
>> -
>> -            /* init OSD command: write or read */
>> -            if (do_write)
>> -                (void) rbd_do_op(rq, rbd_dev,
>> -                        snapc, CEPH_NOSNAP,
>> -                        ofs, op_size, bio,
>> -                        coll, cur_seg);
>> -            else
>> -                (void) rbd_do_op(rq, rbd_dev,
>> -                        NULL, rbd_dev->mapping.snap_id,
>> -                        ofs, op_size, bio,
>> -                        coll, cur_seg);
>> -next_seg:
>>               size -= op_size;
>>               ofs += op_size;
>>
> 

