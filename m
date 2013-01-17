From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST] rbd: assign watch request more directly
Date: Wed, 16 Jan 2013 20:28:47 -0800
Message-ID: <50F77DFF.9050906@inktank.com>
References: <50E6F04B.8060102@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:50355 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758484Ab3AQE2v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 23:28:51 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so1224747pad.7
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 20:28:51 -0800 (PST)
In-Reply-To: <50E6F04B.8060102@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/04/2013 07:07 AM, Alex Elder wrote:
> Both rbd_req_sync_op() and rbd_do_request() have a "linger"
> parameter, which is the address of a pointer that should refer to
> the osd request structure used to issue a request to an osd.
>
> Only one case ever supplies a non-null "linger" argument: an
> CEPH_OSD_OP_WATCH start.  And in that one case it is assigned
> &rbd_dev->watch_request.
>
> Within rbd_do_request() (where the assignment ultimately gets made)
> we know the rbd_dev and therefore its watch_request field.  We
> also know whether the op being sent is CEPH_OSD_OP_WATCH start.
>
> Stop opaquely passing down the "linger" pointer, and instead just
> assign the value directly inside rbd_do_request() when it's needed.
>
> This makes it unnecessary for rbd_req_sync_watch() to make
> arrangements to hold a value that's not available until a
> bit later.  This more clearly separates setting up a watch
> request from submitting it.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>   drivers/block/rbd.c |   20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 21fbf82..02002b1 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1158,7 +1158,6 @@ static int rbd_do_request(struct request *rq,
>   			  int coll_index,
>   			  void (*rbd_cb)(struct ceph_osd_request *,
>   					 struct ceph_msg *),
> -			  struct ceph_osd_request **linger_req,
>   			  u64 *ver)
>   {
>   	struct ceph_osd_client *osdc;
> @@ -1210,9 +1209,9 @@ static int rbd_do_request(struct request *rq,
>   	ceph_osdc_build_request(osd_req, ofs, len, 1, op,
>   				snapc, snapid, &mtime);
>
> -	if (linger_req) {
> +	if (op->op == CEPH_OSD_OP_WATCH && op->watch.flag) {
>   		ceph_osdc_set_request_linger(osdc, osd_req);
> -		*linger_req = osd_req;
> +		rbd_dev->watch_request = osd_req;
>   	}
>
>   	ret = ceph_osdc_start_request(osdc, osd_req, false);
> @@ -1296,7 +1295,6 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
>   			   const char *object_name,
>   			   u64 ofs, u64 inbound_size,
>   			   char *inbound,
> -			   struct ceph_osd_request **linger_req,
>   			   u64 *ver)
>   {
>   	int ret;
> @@ -1317,7 +1315,7 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
>   			  op,
>   			  NULL, 0,
>   			  NULL,
> -			  linger_req, ver);
> +			  ver);
>   	if (ret < 0)
>   		goto done;
>
> @@ -1383,7 +1381,7 @@ static int rbd_do_op(struct request *rq,
>   			     flags,
>   			     op,
>   			     coll, coll_index,
> -			     rbd_req_cb, 0, NULL);
> +			     rbd_req_cb, NULL);
>   	if (ret < 0)
>   		rbd_coll_end_req_index(rq, coll, coll_index,
>   					(s32) ret, seg_len);
> @@ -1410,7 +1408,7 @@ static int rbd_req_sync_read(struct rbd_device
> *rbd_dev,
>   		return -ENOMEM;
>
>   	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ,
> -			       op, object_name, ofs, len, buf, NULL, ver);
> +			       op, object_name, ofs, len, buf, ver);
>   	rbd_osd_req_op_destroy(op);
>
>   	return ret;
> @@ -1436,7 +1434,7 @@ static int rbd_req_sync_notify_ack(struct
> rbd_device *rbd_dev,
>   			  CEPH_OSD_FLAG_READ,
>   			  op,
>   			  NULL, 0,
> -			  rbd_simple_req_cb, 0, NULL);
> +			  rbd_simple_req_cb, NULL);
>
>   	rbd_osd_req_op_destroy(op);
>
> @@ -1469,7 +1467,6 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
> u8 opcode, void *data)
>    */
>   static int rbd_req_sync_watch(struct rbd_device *rbd_dev, int start)
>   {
> -	struct ceph_osd_request **linger_req = NULL;
>   	struct ceph_osd_req_op *op;
>   	int ret = 0;
>
> @@ -1481,7 +1478,6 @@ static int rbd_req_sync_watch(struct rbd_device
> *rbd_dev, int start)
>   						&rbd_dev->watch_event);
>   		if (ret < 0)
>   			return ret;
> -		linger_req = &rbd_dev->watch_request;
>   	} else {
>   		rbd_assert(rbd_dev->watch_request != NULL);
>   	}
> @@ -1493,7 +1489,7 @@ static int rbd_req_sync_watch(struct rbd_device
> *rbd_dev, int start)
>   		ret = rbd_req_sync_op(rbd_dev,
>   			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
>   			      op, rbd_dev->header_name,
> -			      0, 0, NULL, linger_req, NULL);
> +			      0, 0, NULL, NULL);
>
>   	/* Cancel the event if we're tearing down, or on error */
>
> @@ -1537,7 +1533,7 @@ static int rbd_req_sync_exec(struct rbd_device
> *rbd_dev,
>
>   	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ, op,
>   			       object_name, 0, inbound_size, inbound,
> -			       NULL, ver);
> +			       ver);
>
>   	rbd_osd_req_op_destroy(op);
>

