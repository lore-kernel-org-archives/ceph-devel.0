From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH] include: ceph: Fix encode and decode type conversions
Date: Mon, 15 Feb 2016 12:17:34 +0100
Message-ID: <6208883.1yJqoj6hbg@wuerfel>
References: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:49476 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcBOLRl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Feb 2016 06:17:41 -0500
In-Reply-To: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: y2038@lists.linaro.org
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On Sunday 14 February 2016 19:01:53 Deepa Dinamani wrote:
> long/ kernel_time_t is 32 bit on a 32 bit system and
> 64 bit on a 64 bit system.
> 
> ceph_encode_timespec() encodes only the lower 32 bits on
> a 64 bit system and encodes all of 32 bits on a 32bit
> system.
> 
> ceph_decode_timespec() decodes 32 bit tv_sec and tv_nsec
> into kernel_time_t/ long.
> 
> The encode and decode functions do not match when the
> values are negative:
> 
> Consider the following scenario on a 32 bit system:
> When a negative number is cast to u32 as encode does, the
> value is positive and is greater than INT_MAX. Decode reads
> back this value. And, this value cannot be represented by
> long on 32 bit systems. So by section 6.3.1.3 of the
> C99 standard, the result is implementation defined.
> 
> Consider the following scenario on a 64 bit system:
> When a negative number is cast to u32 as encode does, the
> value is positive. This value is later assigned by decode
> function by a cast to long. Since this value can be
> represented in long data type, this becomes a positive
> value greater than INT_MAX. But, the value encoded was
> negative, so the encode and decode functions do not match.
> 
> Change the decode function as follows to overcome the above
> bug:
> The decode should first cast the value to a s64 this will
> be positive value greater than INT_MAX(in case of a negative
> encoded value)and then cast this value again as s32, which
> drops the higher order 32 bits.
> On 32 bit systems, this is the right value in kernel_time_t/
> long.
> On 64 bit systems, assignment to kernel_time_t/ long
> will sign extend this value to reflect the signed bit encoded.
> 
> Assume ceph timestamp ranges permitted are 1902..2038.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---

Actually I was thinking we'd do the opposite and document the
existing 64-bit behavior, and then make sure we do it the same
on 32-bit machines once we have the new syscalls.

The most important part of course is to document what the file
system is expected to do. Having this in the changelog is important
here, but I'd also like to see a comment in the code to ensure
readers can see that the behavior is intentional.
 
> diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
> index a6ef9cc..e777e99 100644
> --- a/include/linux/ceph/decode.h
> +++ b/include/linux/ceph/decode.h
> @@ -137,8 +137,8 @@ bad:
>  static inline void ceph_decode_timespec(struct timespec *ts,
>                                         const struct ceph_timespec *tv)
>  {
> -       ts->tv_sec = (__kernel_time_t)le32_to_cpu(tv->tv_sec);
> -       ts->tv_nsec = (long)le32_to_cpu(tv->tv_nsec);
> +       ts->tv_sec = (s32)(s64)le32_to_cpu(tv->tv_sec);
> +       ts->tv_nsec = (s32)(s64)le32_to_cpu(tv->tv_nsec);
>  }

Why did you choose to express this as "(s32)(s64)..." rather than
"(s64)(s32)..."? The result is the same (just the s32 cast by itself
would be sufficient), I just don't see yet how it clarifies what is
going on.

	Arnd
