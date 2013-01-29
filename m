From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 08/12, v2] rbd: use new code for notify ack
Date: Tue, 29 Jan 2013 02:58:18 -0800
Message-ID: <5107AB4A.7080803@inktank.com>
References: <50FF11EA.3000808@inktank.com> <50FF128B.1030405@inktank.com> <5101406E.4060602@inktank.com> <510162A3.9010705@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56750 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab3A2K6V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 05:58:21 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so327438pab.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 02:58:21 -0800 (PST)
In-Reply-To: <510162A3.9010705@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 01/24/2013 08:34 AM, Alex Elder wrote:
> Use the new object request tracking mechanism for handling a
> notify_ack request.
>
> Move the callback function below the definition of this so we don't
> have to do a pre-declaration.
>
> This resolves:
>      http://tracker.newdream.net/issues/3754
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   76
> +++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 55 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8f659f3..e2b6230 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1347,27 +1347,6 @@ static int rbd_req_sync_notify_ack(struct
> rbd_device *rbd_dev,
>   	return ret;
>   }
>
> -static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
> -{
> -	struct rbd_device *rbd_dev = (struct rbd_device *)data;
> -	u64 hver;
> -	int rc;
> -
> -	if (!rbd_dev)
> -		return;
> -
> -	dout("rbd_watch_cb %s notify_id=%llu opcode=%u\n",
> -		rbd_dev->header_name, (unsigned long long) notify_id,
> -		(unsigned int) opcode);
> -	rc = rbd_dev_refresh(rbd_dev, &hver);
> -	if (rc)
> -		rbd_warn(rbd_dev, "got notification but failed to "
> -			   " update snaps: %d\n", rc);
> -
> -	rbd_req_sync_notify_ack(rbd_dev, hver, notify_id);
> -}
> -
> -
>   /*
>    * Synchronous osd object method call
>    */
> @@ -1466,6 +1445,7 @@ static void rbd_osd_req_callback(struct
> ceph_osd_request *osd_req,
>   	case CEPH_OSD_OP_WRITE:
>   		rbd_osd_write_callback(obj_request, op);
>   		break;
> +	case CEPH_OSD_OP_NOTIFY_ACK:
>   	case CEPH_OSD_OP_WATCH:
>   		rbd_osd_trivial_callback(obj_request, op);
>   		break;
> @@ -1836,6 +1816,60 @@ static int rbd_img_request_submit(struct
> rbd_img_request *img_request)
>   	return 0;
>   }
>
> +static int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev,
> +				   u64 ver, u64 notify_id)
> +{
> +	struct rbd_obj_request *obj_request;
> +	struct ceph_osd_req_op *op;
> +	struct ceph_osd_client *osdc;
> +	int ret;
> +
> +	obj_request = rbd_obj_request_create(rbd_dev->header_name, 0, 0,
> +						obj_req_nodata);
> +	if (!obj_request)
> +		return -ENOMEM;
> +
> +	ret = -ENOMEM;
> +	op = rbd_osd_req_op_create(CEPH_OSD_OP_NOTIFY_ACK, notify_id, ver);
> +	if (!op)
> +		goto out;
> +	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false,
> +						obj_request, op);
> +	rbd_osd_req_op_destroy(op);
> +	if (!obj_request->osd_req)
> +		goto out;
> +
> +	osdc = &rbd_dev->rbd_client->client->osdc;
> +	ret = rbd_obj_request_submit(osdc, obj_request);
> +	if (!ret)
> +		ret = rbd_obj_request_wait(obj_request);
> +out:
> +	rbd_obj_request_put(obj_request);
> +
> +	return ret;
> +}
> +
> +static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
> +{
> +	struct rbd_device *rbd_dev = (struct rbd_device *)data;
> +	u64 hver;
> +	int rc;
> +
> +	if (!rbd_dev)
> +		return;
> +
> +	dout("rbd_watch_cb %s notify_id=%llu opcode=%u\n",
> +		rbd_dev->header_name, (unsigned long long) notify_id,
> +		(unsigned int) opcode);
> +	rc = rbd_dev_refresh(rbd_dev, &hver);
> +	if (rc)
> +		rbd_warn(rbd_dev, "got notification but failed to "
> +			   " update snaps: %d\n", rc);
> +
> +	(void) rbd_req_sync_notify_ack;	/* avoid a warning */
> +	rbd_obj_notify_ack_sync(rbd_dev, hver, notify_id);
> +}
> +
>   /*
>    * Request sync osd watch/unwatch.  The value of "start" determines
>    * whether a watch request is being initiated or torn down.
>

