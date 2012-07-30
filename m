From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 5/7] rbd: fixes in rbd_header_from_disk()
Date: Mon, 30 Jul 2012 14:23:51 -0700
Message-ID: <5016FB67.8030407@inktank.com>
References: <50119421.1090702@inktank.com> <501195CB.7050902@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51916 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab2G3VXy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 17:23:54 -0400
Received: by pbbrp8 with SMTP id rp8so10448651pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 14:23:53 -0700 (PDT)
In-Reply-To: <501195CB.7050902@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/26/2012 12:08 PM, Alex Elder wrote:
> This fixes a few issues in rbd_header_from_disk():
>      - There is a check intended to catch overflow, but it's wrong in
>        two ways.
> 	- First, the type we don't want to overflow is size_t, not
> 	  unsigned int, and there is now a SIZE_MAX we can use for
> 	  use with that type.
> 	- Second, we're allocating the snapshot ids and snapshot
> 	  image sizes separately (each has type u64; on disk they
>            grouped together as a rbd_image_header_ondisk structure).
> 	  So we can use the size of u64 in this overflow check.
>      - If there are no snapshots, then there should be no snapshot
>        names.  Enforce this, and issue a warning if we encounter a
>        header with no snapshots but a non-zero snap_names_len.
>      - When saving the snapshot names into the header, be more direct
>        in defining the offset in the on-disk structure from which
>        they're being copied by using "snap_count" rather than "i"
>        in the array index.
>      - If an error occurs, the "snapc" and "snap_names" fields are
>        freed at the end of the function.  Make those fields be null
>        pointers after they're freed, to be explicit that they are
>        no longer valid.

Why not do this for snap_sizes too?

>      - Finally, move the definition of the local variable "i" to the
>        innermost scope in which it's needed.
>
> Signed-off-by: Alex Elder <elder@inktank.com>

Looks good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> ---
>   drivers/block/rbd.c |   17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4584500..3daf8fb 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -494,14 +494,14 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>   				 struct rbd_image_header_ondisk *ondisk,
>   				 u32 allocated_snaps)
>   {
> -	u32 i, snap_count;
> +	u32 snap_count;
>
>   	if (!rbd_dev_ondisk_valid(ondisk))
>   		return -ENXIO;
>
>   	snap_count = le32_to_cpu(ondisk->snap_count);
> -	if (snap_count > (UINT_MAX - sizeof(struct ceph_snap_context))
> -			 / sizeof (*ondisk))
> +	if (snap_count > (SIZE_MAX - sizeof(struct ceph_snap_context))
> +				 / sizeof (u64))
>   		return -EINVAL;
>   	header->snapc = kmalloc(sizeof(struct ceph_snap_context) +
>   				snap_count * sizeof(u64),
> @@ -509,8 +509,8 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>   	if (!header->snapc)
>   		return -ENOMEM;
>
> -	header->snap_names_len = le64_to_cpu(ondisk->snap_names_len);
>   	if (snap_count) {
> +		header->snap_names_len = le64_to_cpu(ondisk->snap_names_len);
>   		header->snap_names = kmalloc(header->snap_names_len,
>   					     GFP_KERNEL);
>   		if (!header->snap_names)
> @@ -520,6 +520,8 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>   		if (!header->snap_sizes)
>   			goto err_names;
>   	} else {
> +		WARN_ON(ondisk->snap_names_len);
> +		header->snap_names_len = 0;
>   		header->snap_names = NULL;
>   		header->snap_sizes = NULL;
>   	}
> @@ -544,6 +546,8 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>   	header->total_snaps = snap_count;
>
>   	if (snap_count && allocated_snaps == snap_count) {
> +		int i;
> +
>   		for (i = 0; i < snap_count; i++) {
>   			header->snapc->snaps[i] =
>   				le64_to_cpu(ondisk->snaps[i].id);
> @@ -552,7 +556,7 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>   		}
>
>   		/* copy snapshot names */
> -		memcpy(header->snap_names, &ondisk->snaps[i],
> +		memcpy(header->snap_names, &ondisk->snaps[snap_count],
>   			header->snap_names_len);
>   	}
>
> @@ -562,8 +566,11 @@ err_sizes:
>   	kfree(header->snap_sizes);
>   err_names:
>   	kfree(header->snap_names);
> +	header->snap_names = NULL;
>   err_snapc:
>   	kfree(header->snapc);
> +	header->snapc = NULL;
> +
>   	return -ENOMEM;
>   }
>

