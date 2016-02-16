From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [Y2038] [PATCH] include: ceph: Fix encode and decode type conversions
Date: Mon, 15 Feb 2016 21:02:33 -0800
Message-ID: <CABeXuvoTX1Bq=3GEO7POgmgThOk8eCOOJPOKJFza5U3UrkGwog@mail.gmail.com>
References: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com>
	<6208883.1yJqoj6hbg@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32910 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbcBPFCd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Feb 2016 00:02:33 -0500
Received: by mail-ig0-f173.google.com with SMTP id y8so89260110igp.0
        for <ceph-devel@vger.kernel.org>; Mon, 15 Feb 2016 21:02:33 -0800 (PST)
In-Reply-To: <6208883.1yJqoj6hbg@wuerfel>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

> Actually I was thinking we'd do the opposite and document the
> existing 64-bit behavior, and then make sure we do it the same
> on 32-bit machines once we have the new syscalls.

I'm not sure I follow what is opposite here.
You just want to document the behavior and fix it later when the time
range is extended beyond 2038?

> The most important part of course is to document what the file
> system is expected to do. Having this in the changelog is important
> here, but I'd also like to see a comment in the code to ensure
> readers can see that the behavior is intentional.

Will add this comment in the code.

>> diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
>> index a6ef9cc..e777e99 100644
>> --- a/include/linux/ceph/decode.h
>> +++ b/include/linux/ceph/decode.h
>> @@ -137,8 +137,8 @@ bad:
>>  static inline void ceph_decode_timespec(struct timespec *ts,
>>                                         const struct ceph_timespec *tv)
>>  {
>> -       ts->tv_sec = (__kernel_time_t)le32_to_cpu(tv->tv_sec);
>> -       ts->tv_nsec = (long)le32_to_cpu(tv->tv_nsec);
>> +       ts->tv_sec = (s32)(s64)le32_to_cpu(tv->tv_sec);
>> +       ts->tv_nsec = (s32)(s64)le32_to_cpu(tv->tv_nsec);
>>  }
>
> Why did you choose to express this as "(s32)(s64)..." rather than
> "(s64)(s32)..."? The result is the same (just the s32 cast by itself
> would be sufficient), I just don't see yet how it clarifies what is
> going on.

Let's say we encode -1.
so when you pass the same value to decode, ceph_timespec is {0xFFFFFFFF,0}.
0xFFFFFFFF is greater than INT_MAX. And, according to c99 the result
is implementation dependent if this cast to a s32.

Quoting from http://c0x.coding-guidelines.com/6.3.1.3.html :
6.3.1.3 Signed and unsigned integers
1 When a value with integer type is converted to another integer type
other than _Bool, if the value can be represented by the newtype, it
is unchanged.
2 Otherwise, if the newtype is unsigned, the value is converted by
repeatedly adding or subtracting one more than the maximum value that
can be represented in the newtype until the value is in the range of
the newtype.49)
3 Otherwise, the newtype is signed and the value cannot be represented
in it; either the result is implementation-defined or an
implementation-defined signal is raised

GCC does guarantee the behavior.
Quoting from GCC manual
(https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html):
The result of, or the signal raised by, converting an integer to a
signed integer type when the value cannot be represented in an object
of that type (C90 6.2.1.2, C99 and C11 6.3.1.3).
For conversion to a type of width N, the value is reduced modulo 2^N
to be within range of the type; no signal is raised.

But, as the C standard suggests, behavior is implementation dependent.
This is why I cast it to s64 before casting it to s32.
I explained in the commit text, but missed GCC part.
Quoting from commit text:

>> Consider the following scenario on a 32 bit system:
>> When a negative number is cast to u32 as encode does, the
>> value is positive and is greater than INT_MAX. Decode reads
>> back this value. And, this value cannot be represented by
>> long on 32 bit systems. So by section 6.3.1.3 of the
>> C99 standard, the result is implementation defined.
>>
>> Consider the following scenario on a 64 bit system:
>> When a negative number is cast to u32 as encode does, the
>> value is positive. This value is later assigned by decode
>> function by a cast to long. Since this value can be
>> represented in long data type, this becomes a positive
>> value greater than INT_MAX. But, the value encoded was
>> negative, so the encode and decode functions do not match.
>>
>> Change the decode function as follows to overcome the above
>> bug:
>> The decode should first cast the value to a s64 this will
>> be positive value greater than INT_MAX(in case of a negative
>> encoded value)and then cast this value again as s32, which
>> drops the higher order 32 bits.
>> On 32 bit systems, this is the right value in kernel_time_t/
>> long.
>> On 64 bit systems, assignment to kernel_time_t/ long
>> will sign extend this value to reflect the signed bit encoded

-Deepa
