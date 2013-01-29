From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 07/12, v2] rbd: get rid of rbd_req_sync_watch()
Date: Tue, 29 Jan 2013 02:54:16 -0800
Message-ID: <5107AA58.40004@inktank.com>
References: <50FF11EA.3000808@inktank.com> <50FF128B.1030405@inktank.com> <5101406E.4060602@inktank.com> <5101628D.9040607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:64927 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3A2KyZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 05:54:25 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so169999dak.14
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 02:54:24 -0800 (PST)
In-Reply-To: <5101628D.9040607@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 01/24/2013 08:34 AM, Alex Elder wrote:
> Get rid of rbd_req_sync_watch(), because it is no longer used.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   42 ------------------------------------------
>   1 file changed, 42 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 7b1eddc..8f659f3 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1367,47 +1367,6 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
> u8 opcode, void *data)
>   	rbd_req_sync_notify_ack(rbd_dev, hver, notify_id);
>   }
>
> -/*
> - * Request sync osd watch/unwatch.  The value of "start" determines
> - * whether a watch request is being initiated or torn down.
> - */
> -static int rbd_req_sync_watch(struct rbd_device *rbd_dev, int start)
> -{
> -	struct ceph_osd_req_op *op;
> -	int ret = 0;
> -
> -	rbd_assert(start ^ !!rbd_dev->watch_event);
> -	rbd_assert(start ^ !!rbd_dev->watch_request);
> -
> -	if (start) {
> -		struct ceph_osd_client *osdc;
> -
> -		osdc = &rbd_dev->rbd_client->client->osdc;
> -		ret = ceph_osdc_create_event(osdc, rbd_watch_cb, 0, rbd_dev,
> -						&rbd_dev->watch_event);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	op = rbd_osd_req_op_create(CEPH_OSD_OP_WATCH,
> -				rbd_dev->watch_event->cookie,
> -				rbd_dev->header.obj_version, start);
> -	if (op)
> -		ret = rbd_req_sync_op(rbd_dev,
> -			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
> -			      op, rbd_dev->header_name,
> -			      0, 0, NULL, NULL);
> -
> -	/* Cancel the event if we're tearing down, or on error */
> -
> -	if (!start || !op || ret < 0) {
> -		ceph_osdc_cancel_event(rbd_dev->watch_event);
> -		rbd_dev->watch_event = NULL;
> -	}
> -	rbd_osd_req_op_destroy(op);
> -
> -	return ret;
> -}
>
>   /*
>    * Synchronous osd object method call
> @@ -3960,7 +3919,6 @@ static int rbd_dev_probe_finish(struct rbd_device
> *rbd_dev)
>   	if (ret)
>   		goto err_out_bus;
>
> -	(void) rbd_req_sync_watch;	/* avoid a warning */
>   	ret = rbd_dev_header_watch_sync(rbd_dev, 1);
>   	if (ret)
>   		goto err_out_bus;
>

