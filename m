From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [PATCH REPOST] rbd: be picky about osd request status type
Date: Fri, 04 Jan 2013 21:07:01 -0800
Message-ID: <50E7B4F5.7010800@inktank.com>
References: <50E608F0.3010501@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:47880 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab3AEFHG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 00:07:06 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so9708111pac.29
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 21:07:04 -0800 (PST)
In-Reply-To: <50E608F0.3010501@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I personally dislike "spaces after cast", but I haven't checked the 
kernel style guide.  Otherwise:

Reviewed-by: Dan Mick <dan.mick@inktank.com>

On 01/03/2013 02:40 PM, Alex Elder wrote:
> The result field in a ceph osd reply header is a signed 32-bit type,
> but rbd code often casually uses int to represent it.
>
> The following changes the types of variables that handle this result
> value to be "s32" instead of "int" to be completely explicit about
> it.  Only at the point we pass that result to __blk_end_request()
> does the type get converted to the plain old int defined for that
> interface.
>
> There is almost certainly no binary impact of this change, but I
> prefer to show the exact size and signedness of the value since we
> know it.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 85131de..8b79a5b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -171,7 +171,7 @@ struct rbd_client {
>    */
>   struct rbd_req_status {
>   	int done;
> -	int rc;
> +	s32 rc;
>   	u64 bytes;
>   };
>
> @@ -1053,13 +1053,13 @@ static void rbd_destroy_ops(struct
> ceph_osd_req_op *ops)
>   static void rbd_coll_end_req_index(struct request *rq,
>   				   struct rbd_req_coll *coll,
>   				   int index,
> -				   int ret, u64 len)
> +				   s32 ret, u64 len)
>   {
>   	struct request_queue *q;
>   	int min, max, i;
>
>   	dout("rbd_coll_end_req_index %p index %d ret %d len %llu\n",
> -	     coll, index, ret, (unsigned long long) len);
> +	     coll, index, (int) ret, (unsigned long long) len);
>
>   	if (!rq)
>   		return;
> @@ -1080,7 +1080,7 @@ static void rbd_coll_end_req_index(struct request *rq,
>   		max++;
>
>   	for (i = min; i<max; i++) {
> -		__blk_end_request(rq, coll->status[i].rc,
> +		__blk_end_request(rq, (int) coll->status[i].rc,
>   				  coll->status[i].bytes);
>   		coll->num_done++;
>   		kref_put(&coll->kref, rbd_coll_release);
> @@ -1089,7 +1089,7 @@ static void rbd_coll_end_req_index(struct request *rq,
>   }
>
>   static void rbd_coll_end_req(struct rbd_request *rbd_req,
> -			     int ret, u64 len)
> +			     s32 ret, u64 len)
>   {
>   	rbd_coll_end_req_index(rbd_req->rq,
>   				rbd_req->coll, rbd_req->coll_index,
> @@ -1129,7 +1129,7 @@ static int rbd_do_request(struct request *rq,
>   	if (!rbd_req) {
>   		if (coll)
>   			rbd_coll_end_req_index(rq, coll, coll_index,
> -					       -ENOMEM, len);
> +					       (s32) -ENOMEM, len);
>   		return -ENOMEM;
>   	}
>
> @@ -1206,7 +1206,7 @@ done_err:
>   	bio_chain_put(rbd_req->bio);
>   	ceph_osdc_put_request(osd_req);
>   done_pages:
> -	rbd_coll_end_req(rbd_req, ret, len);
> +	rbd_coll_end_req(rbd_req, (s32) ret, len);
>   	kfree(rbd_req);
>   	return ret;
>   }
> @@ -1219,7 +1219,7 @@ static void rbd_req_cb(struct ceph_osd_request
> *osd_req, struct ceph_msg *msg)
>   	struct rbd_request *rbd_req = osd_req->r_priv;
>   	struct ceph_osd_reply_head *replyhead;
>   	struct ceph_osd_op *op;
> -	__s32 rc;
> +	s32 rc;
>   	u64 bytes;
>   	int read_op;
>
> @@ -1227,14 +1227,14 @@ static void rbd_req_cb(struct ceph_osd_request
> *osd_req, struct ceph_msg *msg)
>   	replyhead = msg->front.iov_base;
>   	WARN_ON(le32_to_cpu(replyhead->num_ops) == 0);
>   	op = (void *)(replyhead + 1);
> -	rc = le32_to_cpu(replyhead->result);
> +	rc = (s32) le32_to_cpu(replyhead->result);
>   	bytes = le64_to_cpu(op->extent.length);
>   	read_op = (le16_to_cpu(op->op) == CEPH_OSD_OP_READ);
>
>   	dout("rbd_req_cb bytes=%llu readop=%d rc=%d\n",
>   		(unsigned long long) bytes, read_op, (int) rc);
>
> -	if (rc == -ENOENT && read_op) {
> +	if (rc == (s32) -ENOENT && read_op) {
>   		zero_bio_chain(rbd_req->bio, 0);
>   		rc = 0;
>   	} else if (rc == 0 && read_op && bytes < rbd_req->len) {
> @@ -1679,7 +1679,8 @@ static void rbd_rq_fn(struct request_queue *q)
>   						bio_chain, coll, cur_seg);
>   			else
>   				rbd_coll_end_req_index(rq, coll, cur_seg,
> -						       -ENOMEM, chain_size);
> +						       (s32) -ENOMEM,
> +						       chain_size);
>   			size -= chain_size;
>   			ofs += chain_size;
>
