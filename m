From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [PATCH REPOST] ceph: define ceph_encode_8_safe()
Date: Fri, 04 Jan 2013 21:04:43 -0800
Message-ID: <50E7B46B.4050907@inktank.com>
References: <50E5D6E3.5090309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:53301 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3AEFEr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 00:04:47 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so7846914dak.28
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 21:04:46 -0800 (PST)
In-Reply-To: <50E5D6E3.5090309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Dan Mick <dan.mick@inktank.com>

On 01/03/2013 11:07 AM, Alex Elder wrote:
> It's kind of a silly macro, but ceph_encode_8_safe() is the only one
> missing from an otherwise pretty complete set.  It's not used, but
> neither are a couple of the others in this set.
>
> While in there, insert some whitespace to tidy up the alignment of
> the line-terminating backslashes in some of the macro definitions.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/decode.h |   29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
> index 4bbf2db..cd679f2 100644
> --- a/include/linux/ceph/decode.h
> +++ b/include/linux/ceph/decode.h
> @@ -52,10 +52,10 @@ static inline int ceph_has_room(void **p, void *end,
> size_t n)
>   	return end >= *p && n <= end - *p;
>   }
>
> -#define ceph_decode_need(p, end, n, bad)		\
> -	do {						\
> -		if (!likely(ceph_has_room(p, end, n)))	\
> -			goto bad;			\
> +#define ceph_decode_need(p, end, n, bad)			\
> +	do {							\
> +		if (!likely(ceph_has_room(p, end, n)))		\
> +			goto bad;				\
>   	} while (0)
>
>   #define ceph_decode_64_safe(p, end, v, bad)			\
> @@ -99,8 +99,8 @@ static inline int ceph_has_room(void **p, void *end,
> size_t n)
>    *
>    * There are two possible failures:
>    *   - converting the string would require accessing memory at or
> - *     beyond the "end" pointer provided (-E
> - *   - memory could not be allocated for the result
> + *     beyond the "end" pointer provided (-ERANGE)
> + *   - memory could not be allocated for the result (-ENOMEM)
>    */
>   static inline char *ceph_extract_encoded_string(void **p, void *end,
>   						size_t *lenp, gfp_t gfp)
> @@ -217,10 +217,10 @@ static inline void ceph_encode_string(void **p,
> void *end,
>   	*p += len;
>   }
>
> -#define ceph_encode_need(p, end, n, bad)		\
> -	do {						\
> -		if (!likely(ceph_has_room(p, end, n)))	\
> -			goto bad;			\
> +#define ceph_encode_need(p, end, n, bad)			\
> +	do {							\
> +		if (!likely(ceph_has_room(p, end, n)))		\
> +			goto bad;				\
>   	} while (0)
>
>   #define ceph_encode_64_safe(p, end, v, bad)			\
> @@ -231,12 +231,17 @@ static inline void ceph_encode_string(void **p,
> void *end,
>   #define ceph_encode_32_safe(p, end, v, bad)			\
>   	do {							\
>   		ceph_encode_need(p, end, sizeof(u32), bad);	\
> -		ceph_encode_32(p, v);			\
> +		ceph_encode_32(p, v);				\
>   	} while (0)
>   #define ceph_encode_16_safe(p, end, v, bad)			\
>   	do {							\
>   		ceph_encode_need(p, end, sizeof(u16), bad);	\
> -		ceph_encode_16(p, v);			\
> +		ceph_encode_16(p, v);				\
> +	} while (0)
> +#define ceph_encode_8_safe(p, end, v, bad)			\
> +	do {							\
> +		ceph_encode_need(p, end, sizeof(u8), bad);	\
> +		ceph_encode_8(p, v);				\
>   	} while (0)
>
>   #define ceph_encode_copy_safe(p, end, pv, n, bad)		\
>
