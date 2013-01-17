From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH, v2] rbd: define and use rbd_warn()
Date: Thu, 17 Jan 2013 09:33:11 -0800
Message-ID: <50F835D7.2050907@inktank.com>
References: <50E5D7A9.6040101@inktank.com> <50E5D7E7.40609@inktank.com> <50E701CF.40707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56693 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab3AQRdU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 12:33:20 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so213418pab.33
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 09:33:19 -0800 (PST)
In-Reply-To: <50E701CF.40707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/04/2013 08:22 AM, Alex Elder wrote:
> Define a new function rbd_warn() that produces a boilerplate warning
> message, identifying in the resulting message the affected rbd
> device in the best way available.  Use it in a few places that now
> use pr_warning().
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> Reviewed-by: Dan Mick <dan.mick@inktank.com>
> ---

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> v2: Added function name to warning message, as suggested by Dan.
>
>   drivers/block/rbd.c |   46 ++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 414052d..86e60eb 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -294,6 +294,36 @@ static struct device rbd_root_dev = {
>   	.release =      rbd_root_dev_release,
>   };
>
> +#define rbd_warn(rbd_dev, fmt, ...) \
> +		_rbd_warn(__func__, (rbd_dev), (fmt), ##__VA_ARGS__)
> +
> +static __printf(3, 4) void
> +_rbd_warn(const char *func, struct rbd_device *rbd_dev, const char
> *fmt, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +
> +	if (!rbd_dev)
> +		printk(KERN_WARNING RBD_DRV_NAME ": %s: %pV\n", func, &vaf);
> +	else if (rbd_dev->disk)
> +		printk(KERN_WARNING RBD_DRV_NAME ": %s: %s: %pV\n",
> +			func, rbd_dev->disk->disk_name, &vaf);
> +	else if (rbd_dev->spec && rbd_dev->spec->image_name)
> +		printk(KERN_WARNING RBD_DRV_NAME ": %s: image %s: %pV\n",
> +			func, rbd_dev->spec->image_name, &vaf);
> +	else if (rbd_dev->spec && rbd_dev->spec->image_id)
> +		printk(KERN_WARNING RBD_DRV_NAME ": %s: id %s: %pV\n",
> +			func, rbd_dev->spec->image_id, &vaf);
> +	else	/* punt */
> +		printk(KERN_WARNING RBD_DRV_NAME ": %s: rbd_dev %p: %pV\n",
> +			func, rbd_dev, &vaf);
> +	va_end(args);
> +}
> +
>   #ifdef RBD_DEBUG
>   #define rbd_assert(expr)						\
>   		if (unlikely(!(expr))) {				\
> @@ -1407,8 +1437,8 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
> u8 opcode, void *data)
>   		(unsigned int) opcode);
>   	rc = rbd_dev_refresh(rbd_dev, &hver);
>   	if (rc)
> -		pr_warning(RBD_DRV_NAME "%d got notification but failed to "
> -			   " update snaps: %d\n", rbd_dev->major, rc);
> +		rbd_warn(rbd_dev, "got notification but failed to "
> +			   " update snaps: %d", rc);
>
>   	rbd_req_sync_notify_ack(rbd_dev, hver, notify_id);
>   }
> @@ -1771,15 +1801,13 @@ rbd_dev_v1_header_read(struct rbd_device
> *rbd_dev, u64 *version)
>   			goto out_err;
>   		if (WARN_ON((size_t) ret < size)) {
>   			ret = -ENXIO;
> -			pr_warning("short header read for image %s"
> -					" (want %zd got %d)\n",
> -				rbd_dev->spec->image_name, size, ret);
> +			rbd_warn(rbd_dev, "short header read (want %zd got %d)",
> +				size, ret);
>   			goto out_err;
>   		}
>   		if (!rbd_dev_ondisk_valid(ondisk)) {
>   			ret = -ENXIO;
> -			pr_warning("invalid header for image %s\n",
> -				rbd_dev->spec->image_name);
> +			rbd_warn(rbd_dev, "invalid header");
>   			goto out_err;
>   		}
>
> @@ -2634,9 +2662,7 @@ static int rbd_dev_probe_update_spec(struct
> rbd_device *rbd_dev)
>   	if (name)
>   		rbd_dev->spec->image_name = (char *) name;
>   	else
> -		pr_warning(RBD_DRV_NAME "%d "
> -			"unable to get image name for image id %s\n",
> -			rbd_dev->major, rbd_dev->spec->image_id);
> +		rbd_warn(rbd_dev, "unable to get image name");
>
>   	/* Look up the snapshot name. */
>

