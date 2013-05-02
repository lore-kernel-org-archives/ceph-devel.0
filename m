From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/4] rbd: allocate image object names with a slab allocator
Date: Thu, 02 May 2013 09:24:34 -0700
Message-ID: <51829342.10900@inktank.com>
References: <51818A5C.1080903@inktank.com> <51818ACF.5010202@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:63732 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758873Ab3EBQYO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 May 2013 12:24:14 -0400
Received: by mail-da0-f47.google.com with SMTP id k13so382500dae.34
        for <ceph-devel@vger.kernel.org>; Thu, 02 May 2013 09:24:14 -0700 (PDT)
In-Reply-To: <51818ACF.5010202@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/01/2013 02:36 PM, Alex Elder wrote:
> The names of objects used for image object requests are always fixed
> size.  So create a slab cache to manage them.  Define a new function
> rbd_segment_name_free() to match rbd_segment_name() (which is what
> supplies the dynamically-allocated name buffer).
>
> This is part of:
>      http://tracker.ceph.com/issues/3926
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   34 ++++++++++++++++++++++++++++++----
>   1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 28a5ea3..8d9aeef 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -345,8 +345,11 @@ static DEFINE_SPINLOCK(rbd_dev_list_lock);
>   static LIST_HEAD(rbd_client_list);		/* clients */
>   static DEFINE_SPINLOCK(rbd_client_list_lock);
>
> +/* Slab caches for frequently-allocated structures */
> +
>   static struct kmem_cache	*rbd_img_request_cache;
>   static struct kmem_cache	*rbd_obj_request_cache;
> +static struct kmem_cache	*rbd_segment_name_cache;
>
>   static int rbd_img_request_submit(struct rbd_img_request *img_request);
>
> @@ -985,7 +988,7 @@ static const char *rbd_segment_name(struct
> rbd_device *rbd_dev, u64 offset)
>   	u64 segment;
>   	int ret;
>
> -	name = kmalloc(MAX_OBJ_NAME_SIZE + 1, GFP_NOIO);
> +	name = kmem_cache_alloc(rbd_segment_name_cache, GFP_NOIO);
>   	if (!name)
>   		return NULL;
>   	segment = offset >> rbd_dev->header.obj_order;
> @@ -1001,6 +1004,13 @@ static const char *rbd_segment_name(struct
> rbd_device *rbd_dev, u64 offset)
>   	return name;
>   }
>
> +static void rbd_segment_name_free(const char *name)
> +{
> +	/* The explicit cast here is needed to drop the const qualifier */
> +
> +	kmem_cache_free(rbd_segment_name_cache, (void *)name);
> +}
> +
>   static u64 rbd_segment_offset(struct rbd_device *rbd_dev, u64 offset)
>   {
>   	u64 segment_size = (u64) 1 << rbd_dev->header.obj_order;
> @@ -2033,7 +2043,8 @@ static int rbd_img_request_fill(struct
> rbd_img_request *img_request,
>   		length = rbd_segment_length(rbd_dev, img_offset, resid);
>   		obj_request = rbd_obj_request_create(object_name,
>   						offset, length, type);
> -		kfree(object_name);	/* object request has its own copy */
> +		/* object request has its own copy of the object name */
> +		rbd_segment_name_free(object_name);
>   		if (!obj_request)
>   			goto out_unwind;
>
> @@ -5018,17 +5029,32 @@ static int rbd_slab_init(void)
>   					sizeof (struct rbd_obj_request),
>   					__alignof__(struct rbd_obj_request),
>   					0, NULL);
> -	if (rbd_obj_request_cache)
> -		return 0;
> +	if (!rbd_obj_request_cache)
> +		goto out_err;
>
> +	rbd_assert(!rbd_segment_name_cache);
> +	rbd_segment_name_cache = kmem_cache_create("rbd_segment_name",
> +					MAX_OBJ_NAME_SIZE + 1, 1, 0, NULL);
> +	if (rbd_segment_name_cache)
> +		return 0;
> +out_err:
>   	kmem_cache_destroy(rbd_img_request_cache);
>   	rbd_img_request_cache = NULL;
>
> +	if (rbd_img_request_cache) {
> +		kmem_cache_destroy(rbd_obj_request_cache);
> +		rbd_img_request_cache = NULL;

Should be rbd_obj_request_cache here and in the condition two lines up.
With that fixed: Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> +	}
> +
>   	return -ENOMEM;
>   }
>
>   static void rbd_slab_exit(void)
>   {
> +	rbd_assert(rbd_segment_name_cache);
> +	kmem_cache_destroy(rbd_segment_name_cache);
> +	rbd_segment_name_cache = NULL;
> +
>   	rbd_assert(rbd_obj_request_cache);
>   	kmem_cache_destroy(rbd_obj_request_cache);
>   	rbd_obj_request_cache = NULL;
>

