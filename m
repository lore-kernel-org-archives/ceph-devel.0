From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 5/8] rbd: harden rbd_dev_refresh() caller
Date: Thu, 24 Jul 2014 08:09:17 -0500
Message-ID: <53D1057D.4060006@ieee.org>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com> <1406191369-6746-6-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:48196 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758825AbaGXNJR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 09:09:17 -0400
Received: by mail-ig0-f174.google.com with SMTP id c1so6434003igq.7
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 06:09:17 -0700 (PDT)
In-Reply-To: <1406191369-6746-6-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 07/24/2014 03:42 AM, Ilya Dryomov wrote:
> Recently discovered watch/notify problems showed that we really can't
> ignore errors in anything refresh related.  Alas, currently there is
> not much we can do in response to those errors, except print warnings.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>


> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |   17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 23df1773ef77..5dd6f5057ef4 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2963,11 +2963,20 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
>  	dout("%s: \"%s\" notify_id %llu opcode %u\n", __func__,
>  		rbd_dev->header_name, (unsigned long long)notify_id,
>  		(unsigned int)opcode);
> +
> +	/*
> +	 * Until adequate refresh error handling is in place, there is
> +	 * not much we can do here, except warn.
> +	 *
> +	 * See http://tracker.ceph.com/issues/5040
> +	 */
>  	ret = rbd_dev_refresh(rbd_dev);
>  	if (ret)
> -		rbd_warn(rbd_dev, "header refresh error (%d)\n", ret);
> +		rbd_warn(rbd_dev, "refresh failed: %d\n", ret);
>  
> -	rbd_obj_notify_ack_sync(rbd_dev, notify_id);
> +	ret = rbd_obj_notify_ack_sync(rbd_dev, notify_id);
> +	if (ret)
> +		rbd_warn(rbd_dev, "notify_ack ret %d\n", ret);
>  }
>  
>  /*
> @@ -3724,9 +3733,9 @@ static ssize_t rbd_image_refresh(struct device *dev,
>  
>  	ret = rbd_dev_refresh(rbd_dev);
>  	if (ret)
> -		rbd_warn(rbd_dev, ": manual header refresh error (%d)\n", ret);
> +		return ret;
>  
> -	return ret < 0 ? ret : size;
> +	return size;
>  }
>  
>  static DEVICE_ATTR(size, S_IRUGO, rbd_size_show, NULL);
> 

