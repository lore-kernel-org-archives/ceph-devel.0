From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 6/7] rbd: return obj version in __rbd_refresh_header()
Date: Mon, 30 Jul 2012 14:32:44 -0700
Message-ID: <5016FD7C.2040306@inktank.com>
References: <50119421.1090702@inktank.com> <501195D6.4000609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41468 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab2G3Vcr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 17:32:47 -0400
Received: by pbbrp8 with SMTP id rp8so10459595pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 14:32:46 -0700 (PDT)
In-Reply-To: <501195D6.4000609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/26/2012 12:09 PM, Alex Elder wrote:
> Add a new parameter to __rbd_refresh_header() through which the
> version of the header object is passed back to the caller.  In most
> cases this isn't needed.  The main motivation is to normalize
> (almost) all calls to __rbd_refresh_header() so they are all
> wrapped immediately by mutex_lock()/mutex_unlock().
>
> Signed-off-by: Alex Elder <elder@inktank.com>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> ---
>   drivers/block/rbd.c |   25 +++++++++++--------------
>   1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 3daf8fb..31be4ca 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -240,7 +240,7 @@ static void rbd_put_dev(struct rbd_device *rbd_dev)
>   	put_device(&rbd_dev->dev);
>   }
>
> -static int __rbd_refresh_header(struct rbd_device *rbd_dev);
> +static int __rbd_refresh_header(struct rbd_device *rbd_dev, u64 *hver);
>
>   static int rbd_open(struct block_device *bdev, fmode_t mode)
>   {
> @@ -1223,8 +1223,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
> u8 opcode, void *data)
>   	dout("rbd_watch_cb %s notify_id=%lld opcode=%d\n",
>   		rbd_dev->header_name, notify_id, (int) opcode);
>   	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> -	rc = __rbd_refresh_header(rbd_dev);
> -	hver = rbd_dev->header.obj_version;
> +	rc = __rbd_refresh_header(rbd_dev, &hver);
>   	mutex_unlock(&ctl_mutex);
>   	if (rc)
>   		pr_warning(RBD_DRV_NAME "%d got notification but failed to "
> @@ -1702,7 +1701,7 @@ static void __rbd_remove_all_snaps(struct
> rbd_device *rbd_dev)
>   /*
>    * only read the first part of the ondisk header, without the snaps info
>    */
> -static int __rbd_refresh_header(struct rbd_device *rbd_dev)
> +static int __rbd_refresh_header(struct rbd_device *rbd_dev, u64 *hver)
>   {
>   	int ret;
>   	struct rbd_image_header h;
> @@ -1727,6 +1726,8 @@ static int __rbd_refresh_header(struct rbd_device
> *rbd_dev)
>   	/* osd requests may still refer to snapc */
>   	ceph_put_snap_context(rbd_dev->header.snapc);
>
> +	if (hver)
> +		*hver = h.obj_version;
>   	rbd_dev->header.obj_version = h.obj_version;
>   	rbd_dev->header.image_size = h.image_size;
>   	rbd_dev->header.total_snaps = h.total_snaps;
> @@ -1896,17 +1897,13 @@ static ssize_t rbd_image_refresh(struct device *dev,
>   				 size_t size)
>   {
>   	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
> -	int rc;
> -	int ret = size;
> +	int ret;
>
>   	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> -
> -	rc = __rbd_refresh_header(rbd_dev);
> -	if (rc < 0)
> -		ret = rc;
> -
> +	ret = __rbd_refresh_header(rbd_dev, NULL);
>   	mutex_unlock(&ctl_mutex);
> -	return ret;
> +
> +	return ret < 0 ? ret : size;
>   }
>
>   static DEVICE_ATTR(size, S_IRUGO, rbd_size_show, NULL);
> @@ -2195,7 +2192,7 @@ static int rbd_init_watch_dev(struct rbd_device
> *rbd_dev)
>   		ret = rbd_req_sync_watch(rbd_dev);
>   		if (ret == -ERANGE) {
>   			mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> -			rc = __rbd_refresh_header(rbd_dev);
> +			rc = __rbd_refresh_header(rbd_dev, NULL);
>   			mutex_unlock(&ctl_mutex);
>   			if (rc < 0)
>   				return rc;
> @@ -2645,7 +2642,7 @@ static ssize_t rbd_snap_add(struct device *dev,
>   	if (ret < 0)
>   		goto err_unlock;
>
> -	ret = __rbd_refresh_header(rbd_dev);
> +	ret = __rbd_refresh_header(rbd_dev, NULL);
>   	if (ret < 0)
>   		goto err_unlock;
>

