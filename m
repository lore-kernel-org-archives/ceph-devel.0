From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 6/6] rbd: use rbd_obj_method_sync() return value
Date: Mon, 29 Apr 2013 08:22:43 -0700
Message-ID: <517E9043.7050401@inktank.com>
References: <517A6D39.80000@inktank.com> <517A6DE0.5080305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:36896 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab3D2PWY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:22:24 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so1994897pbc.23
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:22:24 -0700 (PDT)
In-Reply-To: <517A6DE0.5080305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 05:06 AM, Alex Elder wrote:
> Now that rbd_obj_method_sync() returns the number of bytes
> returned by the method call, that value should be used by
> callers to ensure we don't overrun the valid portion of the
> buffer.
>
> Fix the two spots that remained that weren't doing that,
> rbd_dev_image_name() and rbd_dev_v2_snap_name().
>
> Rearrange the error path slightly in rbd_dev_v2_snap_name().
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 2b5ba50..dcd8e58 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2614,7 +2614,8 @@ out_cancel:
>   }
>
>   /*
> - * Synchronous osd object method call
> + * Synchronous osd object method call.  Returns the number of bytes
> + * returned in the outbound buffer, or a negative error code.
>    */
>   static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
>   			     const char *object_name,
> @@ -3740,7 +3741,8 @@ static char *rbd_dev_image_name(struct rbd_device
> *rbd_dev)
>   	if (ret < 0)
>   		goto out;
>   	p = reply_buf;
> -	end = reply_buf + size;
> +	end = reply_buf + ret;
> +
>   	image_name = ceph_extract_encoded_string(&p, end, &len, GFP_KERNEL);
>   	if (IS_ERR(image_name))
>   		image_name = NULL;
> @@ -3913,26 +3915,23 @@ static char *rbd_dev_v2_snap_name(struct
> rbd_device *rbd_dev, u32 which)
>   				&snap_id, sizeof (snap_id),
>   				reply_buf, size, NULL);
>   	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		snap_name = ERR_PTR(ret);
>   		goto out;
> +	}
>
>   	p = reply_buf;
> -	end = reply_buf + size;
> +	end = reply_buf + ret;
>   	snap_name = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
> -	if (IS_ERR(snap_name)) {
> -		ret = PTR_ERR(snap_name);
> +	if (IS_ERR(snap_name))
>   		goto out;
> -	} else {
> -		dout("  snap_id 0x%016llx snap_name = %s\n",
> -			(unsigned long long)le64_to_cpu(snap_id), snap_name);
> -	}
> -	kfree(reply_buf);
>
> -	return snap_name;
> +	dout("  snap_id 0x%016llx snap_name = %s\n",
> +		(unsigned long long)le64_to_cpu(snap_id), snap_name);
>   out:
>   	kfree(reply_buf);
>
> -	return ERR_PTR(ret);
> +	return snap_name;
>   }
>
>   static char *rbd_dev_v2_snap_info(struct rbd_device *rbd_dev, u32 which,
>

