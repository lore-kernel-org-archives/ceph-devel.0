From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH v2 07/16] rbd: dynamically allocate object prefix
Date: Thu, 12 Jul 2012 10:42:13 -0700
Message-ID: <4FFF0C75.6050209@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8750.7010407@inktank.com> <4FFF083A.30903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42545 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285Ab2GLRmR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 13:42:17 -0400
Received: by yhmm54 with SMTP id m54so2984835yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 10:42:16 -0700 (PDT)
In-Reply-To: <4FFF083A.30903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 07/12/2012 10:24 AM, Alex Elder wrote:
> There is no need to impose a small limit the length of the object
> prefix recorded for an rbd image in a struct rbd_image_header.
> Remove the limitation by allocating space for the object prefix
> dynamically.
>
> Signed-off-by: Alex Elder<elder@inktank.com>
> v2: The object prefix shouldn't change when the header is refreshed.
>      Verify that (but still free the extra copy that gets allocated
>      when the header is re-read).
> ---
>   drivers/block/rbd.c |   34 ++++++++++++++++++++++++++--------
>   1 file changed, 26 insertions(+), 8 deletions(-)
>
> Index: b/drivers/block/rbd.c
> ===================================================================
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -77,7 +77,7 @@
>    */
>   struct rbd_image_header {
>   	u64 image_size;
> -	char object_prefix[32];
> +	char *object_prefix;
>   	__u8 obj_order;
>   	__u8 crypt_type;
>   	__u8 comp_type;
> @@ -517,8 +517,15 @@ static int rbd_header_from_disk(struct r
>   		header->snap_names = NULL;
>   		header->snap_sizes = NULL;
>   	}
> +
> +	header->object_prefix = kmalloc(sizeof (ondisk->block_name) + 1,
> +					gfp_flags);
> +	if (!header->object_prefix)
> +		goto err_sizes;
> +
>   	memcpy(header->object_prefix, ondisk->block_name,
>   	       sizeof(ondisk->block_name));
> +	header->object_prefix[sizeof (ondisk->block_name)] = '\0';
>
>   	header->image_size = le64_to_cpu(ondisk->image_size);
>   	header->obj_order = ondisk->options.order;
> @@ -545,6 +552,8 @@ static int rbd_header_from_disk(struct r
>
>   	return 0;
>
> +err_sizes:
> +	kfree(header->snap_sizes);
>   err_names:
>   	kfree(header->snap_names);
>   err_snapc:
> @@ -610,9 +619,10 @@ done:
>
>   static void rbd_header_free(struct rbd_image_header *header)
>   {
> -	kfree(header->snapc);
> -	kfree(header->snap_names);
> +	kfree(header->object_prefix);
>   	kfree(header->snap_sizes);
> +	kfree(header->snap_names);
> +	kfree(header->snapc);
>   }
>
>   /*
> @@ -1710,15 +1720,20 @@ static int __rbd_refresh_header(struct r
>   		   if head moves */
>   		follow_seq = 1;
>
> -	kfree(rbd_dev->header.snapc);
> -	kfree(rbd_dev->header.snap_names);
> +	/* rbd_dev->header.object_prefix shouldn't change */
>   	kfree(rbd_dev->header.snap_sizes);
> +	kfree(rbd_dev->header.snap_names);
> +	kfree(rbd_dev->header.snapc);
>
>   	rbd_dev->header.total_snaps = h.total_snaps;
>   	rbd_dev->header.snapc = h.snapc;
>   	rbd_dev->header.snap_names = h.snap_names;
>   	rbd_dev->header.snap_names_len = h.snap_names_len;
>   	rbd_dev->header.snap_sizes = h.snap_sizes;
> +	/* Free the extra copy of the object prefix */
> +	WARN_ON(strcmp(rbd_dev->header.object_prefix, h.object_prefix));
> +	kfree(h.object_prefix);
> +
>   	if (follow_seq)
>   		rbd_dev->header.snapc->seq = rbd_dev->header.snapc->snaps[0];
>   	else
> @@ -2361,10 +2376,11 @@ static int rbd_add_parse_args(struct rbd
>   	if (!rbd_dev->pool_name)
>   		return -ENOMEM;
>
> -	ret = -EINVAL;
>   	len = copy_token(&buf, rbd_dev->obj, sizeof (rbd_dev->obj));
> -	if (!len || len>= sizeof (rbd_dev->obj))
> +	if (!len || len>= sizeof (rbd_dev->obj)) {
> +		ret = -EINVAL;
>   		goto out_err;
> +	}
>
>   	/* We have the object length in hand, save it. */
>
> @@ -2382,8 +2398,10 @@ static int rbd_add_parse_args(struct rbd
>   	if (!len)
>   		memcpy(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
>   			sizeof (RBD_SNAP_HEAD_NAME));
> -	else if (len>= sizeof (rbd_dev->snap_name))
> +	else if (len>= sizeof (rbd_dev->snap_name)) {
> +		ret = -EINVAL;
>   		goto out_err;
> +	}
>
>   	return 0;
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

