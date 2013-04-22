From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/2] libceph: add signed type limits
Date: Mon, 22 Apr 2013 15:55:59 -0700
Message-ID: <5175BFFF.5090303@inktank.com>
References: <51745629.7080207@inktank.com> <51745656.60504@inktank.com> <517456CA.7040408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:62953 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab3DVW4n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 18:56:43 -0400
Received: by mail-pa0-f42.google.com with SMTP id kl13so60095pab.15
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 15:56:43 -0700 (PDT)
In-Reply-To: <517456CA.7040408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/21/2013 02:14 PM, Alex Elder wrote:
> (Sorry, the subject line didn't match the content.
> Please ignore the previous one--this is the right
> patch.)
>
>
> Flesh out the limits defined in <linux/ceph/decode.h> to include the
> maximum and minimum values for signed type S8, S16, S32, and S64.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/decode.h |   18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
> index 689f1df..9575a52 100644
> --- a/include/linux/ceph/decode.h
> +++ b/include/linux/ceph/decode.h
> @@ -10,10 +10,20 @@
>
>   /* This seemed to be the easiest place to define these */
>
> -#define	U8_MAX	((u8)  (~0U))
> -#define	U16_MAX	((u16) (~0U))
> -#define	U32_MAX	((u32) (~0U))
> -#define	U64_MAX	((u64) (~0ULL))
> +#define	U8_MAX	((u8)(~0U))
> +#define	U16_MAX	((u16)(~0U))
> +#define	U32_MAX	((u32)(~0U))
> +#define	U64_MAX	((u64)(~0ULL))
> +
> +#define	S8_MAX	((s8)(U8_MAX >> 1))
> +#define	S16_MAX	((s16)(U16_MAX >> 1))
> +#define	S32_MAX	((s32)(U32_MAX >> 1))
> +#define	S64_MAX	((s64)(U64_MAX >> 1LL))
> +
> +#define	S8_MIN	((s8)(-S8_MAX - 1))
> +#define	S16_MIN	((s16)(-S16_MAX - 1))
> +#define	S32_MIN	((s32)(-S32_MAX - 1))
> +#define	S64_MIN	((s64)(-S64_MAX - 1LL))
>
>   /*
>    * in all cases,
>

