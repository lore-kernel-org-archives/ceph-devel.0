From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: dynamically allocate pool name
Date: Thu, 12 Jul 2012 10:21:57 -0700
Message-ID: <4FFF07B5.7010103@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD875B.3060608@inktank.com> <4FFF03D7.6000605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:45120 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161288Ab2GLRWA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 13:22:00 -0400
Received: by ghrr11 with SMTP id r11so2662155ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 10:22:00 -0700 (PDT)
In-Reply-To: <4FFF03D7.6000605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 07/12/2012 10:05 AM, Alex Elder wrote:
> There is no need to impose a small limit the length of the pool name
> recorded for an rbd image in a struct rbd_device.  Remove the
> limitation by allocating space for the pool name ynamically.
>
> Signed-off-by: Alex Elder<elder@inktank.com>
> ---
>   drivers/block/rbd.c |   27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
>
> Index: b/drivers/block/rbd.c
> ===================================================================
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -56,7 +56,6 @@
>   #define RBD_MINORS_PER_MAJOR	256		/* max minors per blkdev */
>
>   #define RBD_MAX_MD_NAME_LEN	(RBD_MAX_OBJ_NAME_LEN + sizeof(RBD_SUFFIX))
> -#define RBD_MAX_POOL_NAME_LEN	64
>   #define RBD_MAX_SNAP_NAME_LEN	32
>   #define RBD_MAX_OPT_LEN		1024
>
> @@ -166,7 +165,7 @@ struct rbd_device {
>   	char			obj[RBD_MAX_OBJ_NAME_LEN]; /* rbd image name */
>   	int			obj_len;
>   	char			obj_md_name[RBD_MAX_MD_NAME_LEN]; /* hdr nm. */
> -	char			pool_name[RBD_MAX_POOL_NAME_LEN];
> +	char			*pool_name;
>   	int			pool_id;
>
>   	struct ceph_osd_event   *watch_event;
> @@ -2331,6 +2330,8 @@ static inline char *dup_token(const char
>    * rbd_dev, rbd_md_name, and name fields of the given rbd_dev, based
>    * on the list of monitor addresses and other options provided via
>    * /sys/bus/rbd/add.
> + *
> + * Note: rbd_dev is assumed to have been initially zero-filled.
>    */
>   static int rbd_add_parse_args(struct rbd_device *rbd_dev,
>   			      const char *buf,
> @@ -2339,7 +2340,8 @@ static int rbd_add_parse_args(struct rbd
>   			      char *options,
>   			      size_t options_size)
>   {
> -	size_t	len;
> +	size_t len;
> +	int ret;
>
>   	/* The first four tokens are required */
>
> @@ -2355,13 +2357,14 @@ static int rbd_add_parse_args(struct rbd
>   	if (!len || len>= options_size)
>   		return -EINVAL;
>
> -	len = copy_token(&buf, rbd_dev->pool_name, sizeof (rbd_dev->pool_name));
> -	if (!len || len>= sizeof (rbd_dev->pool_name))
> -		return -EINVAL;
> +	rbd_dev->pool_name = dup_token(&buf, NULL);
> +	if (!rbd_dev->pool_name)
> +		return -ENOMEM;
>
> +	ret = -EINVAL;
>   	len = copy_token(&buf, rbd_dev->obj, sizeof (rbd_dev->obj));
>   	if (!len || len>= sizeof (rbd_dev->obj))
> -		return -EINVAL;
> +		goto out_err;
>
>   	/* We have the object length in hand, save it. */
>
> @@ -2380,9 +2383,15 @@ static int rbd_add_parse_args(struct rbd
>   		memcpy(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
>   			sizeof (RBD_SNAP_HEAD_NAME));
>   	else if (len>= sizeof (rbd_dev->snap_name))
> -		return -EINVAL;
> +		goto out_err;
>
>   	return 0;
> +
> +out_err:
> +	kfree(rbd_dev->pool_name);
> +	rbd_dev->pool_name = NULL;
> +
> +	return ret;
>   }
>
>   static ssize_t rbd_add(struct bus_type *bus,
> @@ -2480,6 +2489,7 @@ err_out_blkdev:
>   err_out_client:
>   	rbd_put_client(rbd_dev);
>   err_put_id:
> +	kfree(rbd_dev->pool_name);
>   	rbd_id_put(rbd_dev);
>   err_nomem:
>   	kfree(options);
> @@ -2528,6 +2538,7 @@ static void rbd_dev_release(struct devic
>   	unregister_blkdev(rbd_dev->major, rbd_dev->name);
>
>   	/* done with the id, and with the rbd_dev */
> +	kfree(rbd_dev->pool_name);
>   	rbd_id_put(rbd_dev);
>   	kfree(rbd_dev);
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

