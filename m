From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 09/12, v2] rbd: get rid of rbd_req_sync_notify_ack()
Date: Tue, 29 Jan 2013 02:59:11 -0800
Message-ID: <5107AB7F.9050900@inktank.com>
References: <50FF11EA.3000808@inktank.com> <50FF128B.1030405@inktank.com> <5101406E.4060602@inktank.com> <510162BD.20800@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:44927 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab3A2K7O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 05:59:14 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so171151dak.11
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 02:59:13 -0800 (PST)
In-Reply-To: <510162BD.20800@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 01/24/2013 08:35 AM, Alex Elder wrote:
> Get rid rbd_req_sync_notify_ack() because it is no longer used.
> As a result rbd_simple_req_cb() becomes unreferenced, so get rid
> of that too.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   33 ---------------------------------
>   1 file changed, 33 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index e2b6230..b952b2f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1240,12 +1240,6 @@ done_err:
>   	return ret;
>   }
>
> -static void rbd_simple_req_cb(struct ceph_osd_request *osd_req,
> -				struct ceph_msg *msg)
> -{
> -	ceph_osdc_put_request(osd_req);
> -}
> -
>   /*
>    * Do a synchronous ceph osd operation
>    */
> @@ -1322,32 +1316,6 @@ static void rbd_obj_request_complete(struct
> rbd_obj_request *obj_request)
>   }
>
>   /*
> - * Request sync osd watch
> - */
> -static int rbd_req_sync_notify_ack(struct rbd_device *rbd_dev,
> -				   u64 ver,
> -				   u64 notify_id)
> -{
> -	struct ceph_osd_req_op *op;
> -	int ret;
> -
> -	op = rbd_osd_req_op_create(CEPH_OSD_OP_NOTIFY_ACK, notify_id, ver);
> -	if (!op)
> -		return -ENOMEM;
> -
> -	ret = rbd_do_request(NULL, rbd_dev, NULL, CEPH_NOSNAP,
> -			  rbd_dev->header_name, 0, 0, NULL,
> -			  NULL, 0,
> -			  CEPH_OSD_FLAG_READ,
> -			  op,
> -			  rbd_simple_req_cb, NULL);
> -
> -	rbd_osd_req_op_destroy(op);
> -
> -	return ret;
> -}
> -
> -/*
>    * Synchronous osd object method call
>    */
>   static int rbd_req_sync_exec(struct rbd_device *rbd_dev,
> @@ -1866,7 +1834,6 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
> u8 opcode, void *data)
>   		rbd_warn(rbd_dev, "got notification but failed to "
>   			   " update snaps: %d\n", rc);
>
> -	(void) rbd_req_sync_notify_ack;	/* avoid a warning */
>   	rbd_obj_notify_ack_sync(rbd_dev, hver, notify_id);
>   }
>

