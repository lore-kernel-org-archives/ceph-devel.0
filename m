From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 10/12, v2] rbd: send notify ack asynchronously
Date: Tue, 29 Jan 2013 03:01:23 -0800
Message-ID: <5107AC03.70002@inktank.com>
References: <50FF11EA.3000808@inktank.com> <50FF128B.1030405@inktank.com> <5101406E.4060602@inktank.com> <510162E0.1040403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:55646 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab3A2LB0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 06:01:26 -0500
Received: by mail-pb0-f43.google.com with SMTP id jt11so216029pbb.30
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 03:01:26 -0800 (PST)
In-Reply-To: <510162E0.1040403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 01/24/2013 08:35 AM, Alex Elder wrote:
> When we receive notification of a change to an rbd image's header
> object we need to refresh our information about the image (its
> size and snapshot context).  Once we have refreshed our rbd image
> we need to acknowledge the notification.
>
> This acknowledgement was previously done synchronously, but there's
> really no need to wait for it to complete.
>
> Change it so the caller doesn't wait for the notify acknowledgement
> request to complete.  And change the name to reflect it's no longer
> synchronous.
>
> This resolves:
>      http://tracker.newdream.net/issues/3877
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b952b2f..48650d1 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1784,7 +1784,7 @@ static int rbd_img_request_submit(struct
> rbd_img_request *img_request)
>   	return 0;
>   }
>
> -static int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev,
> +static int rbd_obj_notify_ack(struct rbd_device *rbd_dev,
>   				   u64 ver, u64 notify_id)
>   {
>   	struct rbd_obj_request *obj_request;
> @@ -1808,11 +1808,11 @@ static int rbd_obj_notify_ack_sync(struct
> rbd_device *rbd_dev,
>   		goto out;
>
>   	osdc = &rbd_dev->rbd_client->client->osdc;
> +	obj_request->callback = rbd_obj_request_put;
>   	ret = rbd_obj_request_submit(osdc, obj_request);
> -	if (!ret)
> -		ret = rbd_obj_request_wait(obj_request);
>   out:
> -	rbd_obj_request_put(obj_request);
> +	if (ret)
> +		rbd_obj_request_put(obj_request);
>
>   	return ret;
>   }
> @@ -1834,7 +1834,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
> u8 opcode, void *data)
>   		rbd_warn(rbd_dev, "got notification but failed to "
>   			   " update snaps: %d\n", rc);
>
> -	rbd_obj_notify_ack_sync(rbd_dev, hver, notify_id);
> +	rbd_obj_notify_ack(rbd_dev, hver, notify_id);
>   }
>
>   /*
>

