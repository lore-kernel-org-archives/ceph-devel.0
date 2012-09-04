From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [PATCH] rbd: rename block_name -> object_prefix
Date: Tue, 04 Sep 2012 13:59:54 -0700
Message-ID: <50466BCA.1040508@inktank.com>
References: <504643B7.1060507@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48585 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757621Ab2IDU77 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 16:59:59 -0400
Received: by pbbrr13 with SMTP id rr13so10077803pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Sep 2012 13:59:59 -0700 (PDT)
In-Reply-To: <504643B7.1060507@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Dan Mick <dan.mick@inktank.com>

On 09/04/2012 11:08 AM, Alex Elder wrote:
> In the on-disk image header structure there is a field "block_name"
> which represents what we now call the "object prefix" for an rbd
> image.  Rename this field "object_prefix" to be consistent with
> modern usage.
>
> This appears to be the only remaining vestige of the use of "block"
> in symbols that represent objects in the rbd code.
>
> This addresses http://tracker.newdream.net/issues/1761
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c       |    4 ++--
>   drivers/block/rbd_types.h |    2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index fd51f9d..2b40a4a 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -522,11 +522,11 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>
>   	snap_count = le32_to_cpu(ondisk->snap_count);
>
> -	size = sizeof (ondisk->block_name) + 1;
> +	size = sizeof (ondisk->object_prefix) + 1;
>   	header->object_prefix = kmalloc(size, GFP_KERNEL);
>   	if (!header->object_prefix)
>   		return -ENOMEM;
> -	memcpy(header->object_prefix, ondisk->block_name, size - 1);
> +	memcpy(header->object_prefix, ondisk->object_prefix, size - 1);
>   	header->object_prefix[size - 1] = '\0';
>
>   	if (snap_count) {
> diff --git a/drivers/block/rbd_types.h b/drivers/block/rbd_types.h
> index 0924e9e..d9d8a77 100644
> --- a/drivers/block/rbd_types.h
> +++ b/drivers/block/rbd_types.h
> @@ -47,7 +47,7 @@ struct rbd_image_snap_ondisk {
>
>   struct rbd_image_header_ondisk {
>   	char text[40];
> -	char block_name[24];
> +	char object_prefix[24];
>   	char signature[4];
>   	char version[8];
>   	struct {
>
