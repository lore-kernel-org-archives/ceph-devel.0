From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 02/10] ceph: add start/finish encoding helpers
Date: Thu, 30 Apr 2015 07:22:15 -0500
Message-ID: <55421E77.1040707@ieee.org>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com> <1430258747-12506-3-git-send-email-mchristi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36180 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbD3MWT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Apr 2015 08:22:19 -0400
Received: by igblo3 with SMTP id lo3so11002385igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 30 Apr 2015 05:22:18 -0700 (PDT)
In-Reply-To: <1430258747-12506-3-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mchristi@redhat.com, ceph-devel@vger.kernel.org

On 04/28/2015 05:05 PM, mchristi@redhat.com wrote:
> From: Mike Christie <michaelc@cs.wisc.edu>
>
> This patch adds helpers to encode/decode the starting blocks
> locking code. They are the equivalent of ENCODE_START and
> DECODE_START_LEGACY_COMPAT_LEN in the userspace ceph code.

Your subject line says "start/finish encoding" but really it's just
encode/decode.

I have a few suggestions and questions, below.

					-Alex

(I'm sorry if this got sent twice, I found it in my drafts folder
this morning so it seems it did not get sent.)

> Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
> ---
>   include/linux/ceph/decode.h | 55 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>
> diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
> index a6ef9cc..96ec43d 100644
> --- a/include/linux/ceph/decode.h
> +++ b/include/linux/ceph/decode.h
> @@ -217,6 +217,61 @@ static inline void ceph_encode_string(void **p, void *end,
>   	*p += len;
>   }
>
> +/*
> + * version and length starting block encoders/decoders
> + */
> +
> +/* current code version (u8) + compat code version (u8) + len of struct (u32) */
> +#define CEPH_ENCODING_START_BLK_LEN 6

I don't see this used. (I'm sure it will be soon though.)

Why not just explain what it is in code?

#define CEPH_ENCODING_START_BLK_LEN \
		(sizeof(u8) + sizeof(u8) + sizeof(u32))

> +/**
> + * ceph_start_encoding - start encoding block
> + * @p: buffer to encode data in
> + * @curr_ver: current (code) version of the encoding
> + * @compat_ver: oldest code version that can decode it
> + * @len: length of data that will be encoded in buffer
> + */
> +static inline void ceph_start_encoding(void **p, u8 curr_ver, u8 compat_ver,
> +				       u32 len)
> +{
> +	ceph_encode_8(p, curr_ver);
> +	ceph_encode_8(p, compat_ver);
> +	ceph_encode_32(p, len);
> +}
> +
> +/**
> + * ceph_start_decoding_compat - decode block with legacy support for older schemes
> + * @p: buffer to decode
> + * @end: end of decode buffer
> + * @curr_ver: current version of the encoding that the code supports/encode
> + * @compat_ver: oldest version that includes a __u8 compat version field
> + * @len_ver: oldest version that includes a __u32 length wrapper
> + * @len: buffer to return len of data in buffer
> + */
> +static inline int ceph_start_decoding_compat(void **p, void *end, u8 curr_ver,
> +					     u8 compat_ver, u8 len_ver, u32 *len)
> +{
> +	u8 struct_ver, struct_compat;
> +
> +	ceph_decode_8_safe(p, end, struct_ver, fail);
> +	if (struct_ver >= curr_ver) {

It seems to me it doesn't matter whether the current code
supports the struct compat version or not.  What matters
is whether the encoded header contains the compat field
or not.  I'm not sure what determines that.

> +		ceph_decode_8_safe(p, end, struct_compat, fail);
> +		if (curr_ver < struct_compat)
> +			return -EINVAL;
> +	}
> +
> +	if (struct_ver >= len_ver) {
> +		ceph_decode_32_safe(p, end, *len, fail);
> +	} else {
> +		*len = 0;
> +	}
> +
> +	return 0;
> +fail:
> +	return -ERANGE;
> +}
> +
> +
>   #define ceph_encode_need(p, end, n, bad)			\
>   	do {							\
>   		if (!likely(ceph_has_room(p, end, n)))		\
>

