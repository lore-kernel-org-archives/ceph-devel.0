From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 8/9] rbd: define rbd_dev_v2_snapc_refresh()
Date: Wed, 19 Sep 2012 14:00:29 -0700
Message-ID: <505A326D.3050504@inktank.com>
References: <504A6273.7030807@inktank.com> <504A63F5.4070307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41915 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab2ISVAc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 17:00:32 -0400
Received: by pbbrr13 with SMTP id rr13so3397988pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Sep 2012 14:00:32 -0700 (PDT)
In-Reply-To: <504A63F5.4070307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org


On 09/07/2012 02:15 PM, Alex Elder wrote:
> Define a new function rbd_dev_v2_snapc_refresh() to update/refresh
> the snapshot context for a format version 2 rbd image.
>
> Update rbd_refresh_header() so it selects which function to use
> based on the image format.
>
> Rename __rbd_refresh_header() to be rbd_dev_v1_snapc_refresh()
> to be consistent with the naming of its version 2 counterpart.
> Similarly rename rbd_refresh_header to be rbd_dev_snapc_refresh().

rbd_refresh_header refreshes all fields that may have changed, not
just the snapshot context. The size of the image may also have changed,
and in the future there will be others. Advisory locks may have changed
(supporting those in the kernel is a separate issue, but it's another
thing stored in the header that may change).

Format 2 should reread the size just like format 1, although the
part of __rbd_refresh_header that checks for resizes could be
moved to a separate function called for both formats.

> Unrelated--we use rbd_image_format_valid() here.  Delete the other
> use of it, which was primarily put in place to ensure that function
> was referenced at the time it was defined.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   41 +++++++++++++++++++++++++++++++++--------
>   1 file changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index ad27be2..b466393 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -268,7 +268,8 @@ static void rbd_put_dev(struct rbd_device *rbd_dev)
>   	put_device(&rbd_dev->dev);
>   }
>
> -static int rbd_refresh_header(struct rbd_device *rbd_dev, u64 *hver);
> +static int rbd_dev_snapc_refresh(struct rbd_device *rbd_dev, u64 *hver);
> +static int rbd_dev_v2_snapc_refresh(struct rbd_device *rbd_dev, u64 *hver);
>
>   static int rbd_open(struct block_device *bdev, fmode_t mode)
>   {
> @@ -1303,7 +1304,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
> u8 opcode, void *data)
>   	dout("rbd_watch_cb %s notify_id=%llu opcode=%u\n",
>   		rbd_dev->header_name, (unsigned long long) notify_id,
>   		(unsigned int) opcode);
> -	rc = rbd_refresh_header(rbd_dev, &hver);
> +	rc = rbd_dev_snapc_refresh(rbd_dev, &hver);
>   	if (rc)
>   		pr_warning(RBD_DRV_NAME "%d got notification but failed to "
>   			   " update snaps: %d\n", rbd_dev->major, rc);
> @@ -1718,7 +1719,7 @@ static void __rbd_remove_all_snaps(struct
> rbd_device *rbd_dev)
>   /*
>    * only read the first part of the ondisk header, without the snaps info
>    */
> -static int __rbd_refresh_header(struct rbd_device *rbd_dev, u64 *hver)
> +static int rbd_dev_v1_snapc_refresh(struct rbd_device *rbd_dev, u64 *hver)
>   {
>   	int ret;
>   	struct rbd_image_header h;
> @@ -1767,12 +1768,16 @@ static int __rbd_refresh_header(struct
> rbd_device *rbd_dev, u64 *hver)
>   	return ret;
>   }
>
> -static int rbd_refresh_header(struct rbd_device *rbd_dev, u64 *hver)
> +static int rbd_dev_snapc_refresh(struct rbd_device *rbd_dev, u64 *hver)
>   {
>   	int ret;
>
> +	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
>   	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> -	ret = __rbd_refresh_header(rbd_dev, hver);
> +	if (rbd_dev->image_format == 1)
> +		ret = rbd_dev_v1_snapc_refresh(rbd_dev, hver);
> +	else
> +		ret = rbd_dev_v2_snapc_refresh(rbd_dev, hver);
>   	mutex_unlock(&ctl_mutex);
>
>   	return ret;
> @@ -1932,7 +1937,7 @@ static ssize_t rbd_image_refresh(struct device *dev,
>   	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
>   	int ret;
>
> -	ret = rbd_refresh_header(rbd_dev, NULL);
> +	ret = rbd_dev_snapc_refresh(rbd_dev, NULL);
>
>   	return ret < 0 ? ret : size;
>   }
> @@ -2389,6 +2394,27 @@ static char *rbd_dev_snap_info(struct rbd_device
> *rbd_dev, u32 which,
>   	return ERR_PTR(-EINVAL);
>   }
>
> +static int rbd_dev_v2_snapc_refresh(struct rbd_device *rbd_dev, u64 *hver)
> +{
> +	int ret;
> +
> +	down_write(&rbd_dev->header_rwsem);
> +	ret = rbd_dev_v2_snap_context(rbd_dev, hver);
> +	dout("rbd_dev_v2_snap_context returned %d\n", ret);
> +	if (ret)
> +		goto out;
> +	ret = rbd_dev_snaps_update(rbd_dev);
> +	dout("rbd_dev_snaps_update returned %d\n", ret);
> +	if (ret)
> +		goto out;
> +	ret = rbd_dev_snaps_register(rbd_dev);
> +	dout("rbd_dev_snaps_register returned %d\n", ret);
> +out:
> +	up_write(&rbd_dev->header_rwsem);
> +
> +	return 0;
> +}
> +
>   /*
>    * Scan the rbd device's current snapshot list and compare it to the
>    * newly-received snapshot context.  Remove any existing snapshots
> @@ -2551,7 +2577,7 @@ static int rbd_init_watch_dev(struct rbd_device
> *rbd_dev)
>   	do {
>   		ret = rbd_req_sync_watch(rbd_dev);
>   		if (ret == -ERANGE) {
> -			rc = rbd_refresh_header(rbd_dev, NULL);
> +			rc = rbd_dev_snapc_refresh(rbd_dev, NULL);
>   			if (rc < 0)
>   				return rc;
>   		}
> @@ -3034,7 +3060,6 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	rc = rbd_dev_probe(rbd_dev);
>   	if (rc < 0)
>   		goto err_out_client;
> -	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
>
>   	rc = rbd_dev_snaps_update(rbd_dev);
>   	if (rc)
>

