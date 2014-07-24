From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 1/8] rbd: show the entire chain of parent images
Date: Thu, 24 Jul 2014 07:31:40 -0500
Message-ID: <53D0FCAC.3030801@ieee.org>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com> <1406191369-6746-2-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35560 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbaGXMbk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 08:31:40 -0400
Received: by mail-ie0-f175.google.com with SMTP id x19so2211741ier.20
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 05:31:40 -0700 (PDT)
In-Reply-To: <1406191369-6746-2-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 07/24/2014 03:42 AM, Ilya Dryomov wrote:
> Make /sys/bus/rbd/devices/<id>/parent show the entire chain of parent
> images.  While at it, kernel sprintf() doesn't return negative values,
> casting to unsigned long long is no longer necessary and there is no
> good reason to split into multiple sprintf() calls.

I like the use of a single snprintf() call, it is much less
cumbersome.

The reason I always cast u64 values to (unsigned long long)
in printf() calls is because on some 64-bit architectures,
u64 is defined as simply (unsigned long), so without the
cast they spit out warnings.  I hate this, but it is reality
(see include/asm-generic/{int-l64.h,int-ll64.h}).  You can
alternatively use %PRIu64 rather than %llu in your format
strings, but I think I hate that more.  Anyway, if you want
to avoid warnings on all architectures you should fix that.

As another aside, I've been too timid to use the ?: conditional
expression without its middle operand.  I have no objection
to it at all, I like it.  I bring it up because I recently
got burned for using a gcc feature that wasn't supported
on older compilers (unnamed struct/union fields)--specifically
a version newer than gcc 3.2, which is the minimum supported
version for the kernel (see Documentation/Changes).

But fear not!  That extension is supported in gcc 3.2:

https://gcc.gnu.org/onlinedocs/gcc-3.2/gcc/Conditionals.html#Conditionals
Just FYI...

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-rbd |    4 +--
>  drivers/block/rbd.c                     |   56 +++++++++++++------------------
>  2 files changed, 25 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
> index 501adc2a9ec7..2ddd680929d8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-rbd
> +++ b/Documentation/ABI/testing/sysfs-bus-rbd
> @@ -94,5 +94,5 @@ current_snap
>  
>  parent
>  
> -	Information identifying the pool, image, and snapshot id for
> -	the parent image in a layered rbd image (format 2 only).
> +	Information identifying the chain of parent images in a layered rbd
> +	image.  Entries are separated by empty lines.
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 703b728e05fa..7847fbb949ff 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3685,46 +3685,36 @@ static ssize_t rbd_snap_show(struct device *dev,
>  }
>  
>  /*
> - * For an rbd v2 image, shows the pool id, image id, and snapshot id
> - * for the parent image.  If there is no parent, simply shows
> - * "(no parent image)".
> + * For a v2 image, shows the chain of parent images, separated by empty
> + * lines.  For v1 images or if there is no parent, shows "(no parent
> + * image)".
>   */
>  static ssize_t rbd_parent_show(struct device *dev,
> -			     struct device_attribute *attr,
> -			     char *buf)
> +			       struct device_attribute *attr,
> +			       char *buf)
>  {
>  	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
> -	struct rbd_spec *spec = rbd_dev->parent_spec;
> -	int count;
> -	char *bufp = buf;
> +	ssize_t count = 0;
>  
> -	if (!spec)
> +	if (!rbd_dev->parent)
>  		return sprintf(buf, "(no parent image)\n");
>  
> -	count = sprintf(bufp, "pool_id %llu\npool_name %s\n",
> -			(unsigned long long) spec->pool_id, spec->pool_name);
> -	if (count < 0)
> -		return count;
> -	bufp += count;
> -
> -	count = sprintf(bufp, "image_id %s\nimage_name %s\n", spec->image_id,
> -			spec->image_name ? spec->image_name : "(unknown)");
> -	if (count < 0)
> -		return count;
> -	bufp += count;
> -
> -	count = sprintf(bufp, "snap_id %llu\nsnap_name %s\n",
> -			(unsigned long long) spec->snap_id, spec->snap_name);
> -	if (count < 0)
> -		return count;
> -	bufp += count;
> -
> -	count = sprintf(bufp, "overlap %llu\n", rbd_dev->parent_overlap);
> -	if (count < 0)
> -		return count;
> -	bufp += count;
> -
> -	return (ssize_t) (bufp - buf);
> +	for ( ; rbd_dev->parent; rbd_dev = rbd_dev->parent) {
> +		struct rbd_spec *spec = rbd_dev->parent_spec;
> +
> +		count += sprintf(&buf[count], "%s"
> +			    "pool_id %llu\npool_name %s\n"
> +			    "image_id %s\nimage_name %s\n"
> +			    "snap_id %llu\nsnap_name %s\n"
> +			    "overlap %llu\n",
> +			    !count ? "" : "\n", /* first? */
> +			    spec->pool_id, spec->pool_name,
> +			    spec->image_id, spec->image_name ?: "(unknown)",
> +			    spec->snap_id, spec->snap_name,
> +			    rbd_dev->parent_overlap);
> +	}
> +
> +	return count;
>  }
>  
>  static ssize_t rbd_image_refresh(struct device *dev,
> 

