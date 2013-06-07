From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/5] rbd: use rwsem to protect header updates
Date: Fri, 07 Jun 2013 11:25:46 -0700
Message-ID: <51B225AA.6050306@inktank.com>
References: <51A94BC0.4080703@inktank.com> <51A94C6B.4000102@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:64110 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667Ab3FGS0B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jun 2013 14:26:01 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so1603419pad.28
        for <ceph-devel@vger.kernel.org>; Fri, 07 Jun 2013 11:26:00 -0700 (PDT)
In-Reply-To: <51A94C6B.4000102@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 05/31/2013 06:20 PM, Alex Elder wrote:
> Updating an image header needs to be protected to ensure it's
> done consistently.  However distinct headers can be updated
> concurrently without a problem.  Instead of using the global
> control lock to serialize headder updates, just rely on the header
> semaphore.  (It's already used, this just moves it out to cover
> a broader section of the code.)
>
> That leaves the control mutex protecting only the creation of rbd
> clients, so rename it.
>
> This resolves:
>      http://tracker.ceph.com/issues/5222
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 9c81a5c..107e1e5 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -372,7 +372,7 @@ enum rbd_dev_flags {
>   	RBD_DEV_FLAG_REMOVING,	/* this mapping is being removed */
>   };
>
> -static DEFINE_MUTEX(ctl_mutex);	  /* Serialize open/close/setup/teardown */
> +static DEFINE_MUTEX(client_mutex);	/* Serialize client creation */
>
>   static LIST_HEAD(rbd_dev_list);    /* devices */
>   static DEFINE_SPINLOCK(rbd_dev_list_lock);
> @@ -518,7 +518,7 @@ static const struct block_device_operations
> rbd_bd_ops = {
>
>   /*
>    * Initialize an rbd client instance.  Success or not, this function
> - * consumes ceph_opts.  Caller holds ctl_mutex.
> + * consumes ceph_opts.  Caller holds client_mutex.
>    */
>   static struct rbd_client *rbd_client_create(struct ceph_options *ceph_opts)
>   {
> @@ -675,13 +675,13 @@ static struct rbd_client *rbd_get_client(struct
> ceph_options *ceph_opts)
>   {
>   	struct rbd_client *rbdc;
>
> -	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> +	mutex_lock_nested(&client_mutex, SINGLE_DEPTH_NESTING);
>   	rbdc = rbd_client_find(ceph_opts);
>   	if (rbdc)	/* using an existing client */
>   		ceph_destroy_options(ceph_opts);
>   	else
>   		rbdc = rbd_client_create(ceph_opts);
> -	mutex_unlock(&ctl_mutex);
> +	mutex_unlock(&client_mutex);
>
>   	return rbdc;
>   }
> @@ -835,7 +835,6 @@ static int rbd_header_from_disk(struct rbd_device
> *rbd_dev,
>
>   	/* We won't fail any more, fill in the header */
>
> -	down_write(&rbd_dev->header_rwsem);
>   	if (first_time) {
>   		header->object_prefix = object_prefix;
>   		header->obj_order = ondisk->options.order;
> @@ -864,8 +863,6 @@ static int rbd_header_from_disk(struct rbd_device
> *rbd_dev,
>   		if (rbd_dev->mapping.size != header->image_size)
>   			rbd_dev->mapping.size = header->image_size;
>
> -	up_write(&rbd_dev->header_rwsem);
> -
>   	return 0;
>   out_2big:
>   	ret = -EIO;
> @@ -3349,17 +3346,17 @@ static int rbd_dev_refresh(struct rbd_device
> *rbd_dev)
>   	int ret;
>
>   	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
> -	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> +	down_write(&rbd_dev->header_rwsem);
>   	mapping_size = rbd_dev->mapping.size;
>   	if (rbd_dev->image_format == 1)
>   		ret = rbd_dev_v1_header_info(rbd_dev);
>   	else
>   		ret = rbd_dev_v2_header_info(rbd_dev);
> +	up_write(&rbd_dev->header_rwsem);

I think this needs to happen after rbd_exists_validate() so that
reading the snapshot context via rbd_dev_snap_index() is protected.

Looks good otherwise.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>
>   	/* If it's a mapped snapshot, validate its EXISTS flag */
>
>   	rbd_exists_validate(rbd_dev);
> -	mutex_unlock(&ctl_mutex);
>   	if (mapping_size != rbd_dev->mapping.size) {
>   		sector_t size;
>
> @@ -4288,12 +4285,10 @@ static int rbd_dev_v2_header_info(struct
> rbd_device *rbd_dev)
>   	bool first_time = rbd_dev->header.object_prefix == NULL;
>   	int ret;
>
> -	down_write(&rbd_dev->header_rwsem);
> -
>   	if (first_time) {
>   		ret = rbd_dev_v2_header_onetime(rbd_dev);
>   		if (ret)
> -			goto out;
> +			return ret;
>   	}
>
>   	/*
> @@ -4308,7 +4303,7 @@ static int rbd_dev_v2_header_info(struct
> rbd_device *rbd_dev)
>
>   		ret = rbd_dev_v2_parent_info(rbd_dev);
>   		if (ret)
> -			goto out;
> +			return ret;
>
>   		/*
>   		 * Print a warning if this is the initial probe and
> @@ -4325,7 +4320,7 @@ static int rbd_dev_v2_header_info(struct
> rbd_device *rbd_dev)
>
>   	ret = rbd_dev_v2_image_size(rbd_dev);
>   	if (ret)
> -		goto out;
> +		return ret;
>
>   	if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
>   		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
> @@ -4333,8 +4328,6 @@ static int rbd_dev_v2_header_info(struct
> rbd_device *rbd_dev)
>
>   	ret = rbd_dev_v2_snap_context(rbd_dev);
>   	dout("rbd_dev_v2_snap_context returned %d\n", ret);
> -out:
> -	up_write(&rbd_dev->header_rwsem);
>
>   	return ret;
>   }
>

