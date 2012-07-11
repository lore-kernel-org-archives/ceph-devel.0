From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 11/16] rbd: dynamically allocate snapshot name
Date: Wed, 11 Jul 2012 13:53:41 -0700
Message-ID: <4FFDE7D5.3080106@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8773.4020402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:44373 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030191Ab2GKUxo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 16:53:44 -0400
Received: by ghrr11 with SMTP id r11so1718353ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 13:53:43 -0700 (PDT)
In-Reply-To: <4FFD8773.4020402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 07/11/2012 07:02 AM, Alex Elder wrote:
> There is no need to impose a small limit the length of the snapshot
> name recorded for an rbd image in a struct rbd_dev.  Remove the
> limitation by allocating space for the snapshot name dynamically.
>
> Signed-off-by: Alex Elder<elder@inktank.com>
> ---
>   drivers/block/rbd.c |   26 ++++++++++++++++----------
>   1 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 28afff9..90fb388 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -171,7 +171,7 @@ struct rbd_device {
>
>   	/* protects updating the header */
>   	struct rw_semaphore     header_rwsem;
> -	char                    snap_name[RBD_MAX_SNAP_NAME_LEN];
> +	char                    *snap_name;
>   	u64                     snap_id;	/* current snapshot id */
>   	int read_only;
>
> @@ -587,8 +587,6 @@ static int rbd_header_set_snap(struct rbd_device
> *dev, u64 *size)
>   	struct ceph_snap_context *snapc = header->snapc;
>   	int ret = -ENOENT;
>
> -	BUILD_BUG_ON(sizeof (dev->snap_name)<  sizeof (RBD_SNAP_HEAD_NAME));
> -
>   	down_write(&dev->header_rwsem);
>
>   	if (!memcmp(dev->snap_name, RBD_SNAP_HEAD_NAME,
> @@ -2381,16 +2379,22 @@ static char *rbd_add_parse_args(struct
> rbd_device *rbd_dev,
>   	sprintf(rbd_dev->obj_md_name, "%s%s", rbd_dev->obj, RBD_SUFFIX);
>
>   	/*
> -	 * The snapshot name is optional, but it's an error if it's
> -	 * too long.  If no snapshot is supplied, fill in the default.
> +	 * The snapshot name is optional.  If none is is supplied,
> +	 * we use the default value.
>   	 */
> -	len = copy_token(&buf, rbd_dev->snap_name, sizeof (rbd_dev->snap_name));
> -	if (!len)
> +	rbd_dev->snap_name = dup_token(&buf,&len);
> +	if (!rbd_dev->snap_name)
> +		goto out_err;
> +	if (!len) {
> +		/* Replace the empty name with the default */
> +		kfree(rbd_dev->snap_name);
> +		rbd_dev->snap_name
> +			= kmalloc(sizeof (RBD_SNAP_HEAD_NAME), GFP_KERNEL);
> +		if (!rbd_dev->snap_name)
> +			goto out_err;
> +
>   		memcpy(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
>   			sizeof (RBD_SNAP_HEAD_NAME));
> -	else if (len>= sizeof (rbd_dev->snap_name)) {
> -		ret = -EINVAL;
> -		goto out_err;
>   	}
>
>   	return pool_name;
> @@ -2505,6 +2509,7 @@ err_out_client:
>   	rbd_put_client(rbd_dev);
>   err_put_id:
>   	if (pool_name) {
> +		kfree(rbd_dev->snap_name);
>   		kfree(rbd_dev->obj_md_name);
>   		kfree(rbd_dev->obj);
>   		kfree(pool_name);
> @@ -2557,6 +2562,7 @@ static void rbd_dev_release(struct device *dev)
>   	unregister_blkdev(rbd_dev->major, rbd_dev->name);
>
>   	/* done with the id, and with the rbd_dev */
> +	kfree(rbd_dev->snap_name);
>   	kfree(rbd_dev->obj_md_name);
>   	kfree(rbd_dev->obj);
>   	rbd_id_put(rbd_dev);

