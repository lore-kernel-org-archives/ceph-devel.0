From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH v3 2/5] rbd: make rbd_obj_notify_ack() synchronous
Date: Mon, 09 Sep 2013 07:06:23 -0500
Message-ID: <522DB9BF.1050206@linaro.org>
References: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com> <1378711022-20158-3-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36565 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab3IIMGS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 08:06:18 -0400
Received: by mail-ie0-f175.google.com with SMTP id u16so11947891iet.6
        for <ceph-devel@vger.kernel.org>; Mon, 09 Sep 2013 05:06:17 -0700 (PDT)
In-Reply-To: <1378711022-20158-3-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/09/2013 02:16 AM, Josh Durgin wrote:
> The only user of rbd_obj_notify_ack() is rbd_watch_cb(). It used
> asynchronously with no tracking of when the notify ack completes, so
> it may still be in progress when the osd_client is shut down.  This
> results in a BUG() since the osd client assumes no requests are in
> flight when it stops. Since all notifies are flushed before the
> osd_client is stopped, waiting for the notify ack to complete before
> returning from the watch callback ensures there are no notify acks in
> flight during shutdown.
> 
> Rename rbd_obj_notify_ack() to rbd_obj_notify_ack_sync() to reflect
> its new synchronous nature.
> 
> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>

Looks great.  Nice description.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index bf89e34..9e5f07f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2808,7 +2808,7 @@ out_err:
>  	obj_request_done_set(obj_request);
>  }
>  
> -static int rbd_obj_notify_ack(struct rbd_device *rbd_dev, u64 notify_id)
> +static int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev, u64 notify_id)
>  {
>  	struct rbd_obj_request *obj_request;
>  	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
> @@ -2823,16 +2823,17 @@ static int rbd_obj_notify_ack(struct rbd_device *rbd_dev, u64 notify_id)
>  	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
>  	if (!obj_request->osd_req)
>  		goto out;
> -	obj_request->callback = rbd_obj_request_put;
>  
>  	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_NOTIFY_ACK,
>  					notify_id, 0, 0);
>  	rbd_osd_req_format_read(obj_request);
>  
>  	ret = rbd_obj_request_submit(osdc, obj_request);
> -out:
>  	if (ret)
> -		rbd_obj_request_put(obj_request);
> +		goto out;
> +	ret = rbd_obj_request_wait(obj_request);
> +out:
> +	rbd_obj_request_put(obj_request);
>  
>  	return ret;
>  }
> @@ -2852,7 +2853,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
>  	if (ret)
>  		rbd_warn(rbd_dev, "header refresh error (%d)\n", ret);
>  
> -	rbd_obj_notify_ack(rbd_dev, notify_id);
> +	rbd_obj_notify_ack_sync(rbd_dev, notify_id);
>  }
>  
>  /*
> 

