From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] ceph: move max constant definitions
Date: Wed, 03 Apr 2013 11:38:46 -0700
Message-ID: <515C7736.30203@inktank.com>
References: <5156067F.7070404@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:56928 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759936Ab3DCSjF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 14:39:05 -0400
Received: by mail-pb0-f53.google.com with SMTP id un15so1000316pbc.12
        for <ceph-devel@vger.kernel.org>; Wed, 03 Apr 2013 11:39:04 -0700 (PDT)
In-Reply-To: <5156067F.7070404@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 03/29/2013 02:24 PM, Alex Elder wrote:
> Move some definitions for max integer values out of the rbd code and
> into the more central "decode.h" header file.  These really belong
> in a Linux (or libc) header somewhere, but I haven't gotten around
> to proposing that yet.
>
> This is in preparation for moving some code out of rbd.c and into
> the osd client.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c         |    7 -------
>   include/linux/ceph/decode.h |    7 +++++++
>   2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index d54a045..9c97204 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -52,13 +52,6 @@
>   #define	SECTOR_SHIFT	9
>   #define	SECTOR_SIZE	(1ULL << SECTOR_SHIFT)
>
> -/* It might be useful to have these defined elsewhere */
> -
> -#define	U8_MAX	((u8)	(~0U))
> -#define	U16_MAX	((u16)	(~0U))
> -#define	U32_MAX	((u32)	(~0U))
> -#define	U64_MAX	((u64)	(~0ULL))
> -
>   #define RBD_DRV_NAME "rbd"
>   #define RBD_DRV_NAME_LONG "rbd (rados block device)"
>
> diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
> index 360d9d0..689f1df 100644
> --- a/include/linux/ceph/decode.h
> +++ b/include/linux/ceph/decode.h
> @@ -8,6 +8,13 @@
>
>   #include <linux/ceph/types.h>
>
> +/* This seemed to be the easiest place to define these */
> +
> +#define	U8_MAX	((u8)  (~0U))
> +#define	U16_MAX	((u16) (~0U))
> +#define	U32_MAX	((u32) (~0U))
> +#define	U64_MAX	((u64) (~0ULL))
> +
>   /*
>    * in all cases,
>    *   void **p     pointer to position pointer
>

