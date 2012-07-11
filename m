From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 07/16] rbd: dynamically allocate object prefix
Date: Wed, 11 Jul 2012 12:12:20 -0700
Message-ID: <4FFDD014.9090208@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8750.7010407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f52.google.com ([209.85.213.52]:53920 "EHLO
	mail-yw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932198Ab2GKTMX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 15:12:23 -0400
Received: by yhpp61 with SMTP id p61so1849732yhp.11
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 12:12:23 -0700 (PDT)
In-Reply-To: <4FFD8750.7010407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/11/2012 07:01 AM, Alex Elder wrote:
> There is no need to impose a small limit the length of the object
> prefix recorded for an rbd image in a struct rbd_image_header.
> Remove the limitation by allocating space for the object prefix
> dynamically.
>
> Signed-off-by: Alex Elder<elder@inktank.com>
> ---
>   drivers/block/rbd.c |   22 +++++++++++++++++-----
>   1 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 57d264c..3aa0ca0 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -78,7 +78,7 @@
>    */
>   struct rbd_image_header {
>   	u64 image_size;
> -	char object_prefix[32];
> +	char *object_prefix;
>   	__u8 obj_order;
>   	__u8 crypt_type;
>   	__u8 comp_type;
> @@ -518,8 +518,15 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
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
> @@ -546,6 +553,8 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>
>   	return 0;
>
> +err_sizes:
> +	kfree(header->snap_sizes);
>   err_names:
>   	kfree(header->snap_names);
>   err_snapc:
> @@ -611,9 +620,10 @@ done:
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
> @@ -1711,15 +1721,17 @@ static int __rbd_refresh_header(struct
> rbd_device *rbd_dev)
>   		   if head moves */
>   		follow_seq = 1;
>
> -	kfree(rbd_dev->header.snapc);
> -	kfree(rbd_dev->header.snap_names);
> +	kfree(rbd_dev->header.object_prefix);

Object prefix isn't going to change, so it doesn't need to be reset
here. Otherwise looks good.

>   	kfree(rbd_dev->header.snap_sizes);
> +	kfree(rbd_dev->header.snap_names);
> +	kfree(rbd_dev->header.snapc);
>
>   	rbd_dev->header.total_snaps = h.total_snaps;
>   	rbd_dev->header.snapc = h.snapc;
>   	rbd_dev->header.snap_names = h.snap_names;
>   	rbd_dev->header.snap_names_len = h.snap_names_len;
>   	rbd_dev->header.snap_sizes = h.snap_sizes;
> +	rbd_dev->header.object_prefix = h.object_prefix;
>   	if (follow_seq)
>   		rbd_dev->header.snapc->seq = rbd_dev->header.snapc->snaps[0];
>   	else

