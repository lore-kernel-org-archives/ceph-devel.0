From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH] include: ceph: Fix encode and decode type conversions
Date: Tue, 16 Feb 2016 09:56 +0100
Message-ID: <6833154.QUCaxj5s9M@wuerfel>
References: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com> <6208883.1yJqoj6hbg@wuerfel> <CABeXuvoTX1Bq=3GEO7POgmgThOk8eCOOJPOKJFza5U3UrkGwog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:49968 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbcBPI4J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Feb 2016 03:56:09 -0500
In-Reply-To: <CABeXuvoTX1Bq=3GEO7POgmgThOk8eCOOJPOKJFza5U3UrkGwog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: y2038@lists.linaro.org, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Monday 15 February 2016 21:02:33 Deepa Dinamani wrote:
> > Actually I was thinking we'd do the opposite and document the
> > existing 64-bit behavior, and then make sure we do it the same
> > on 32-bit machines once we have the new syscalls.
> 
> I'm not sure I follow what is opposite here.
> You just want to document the behavior and fix it later when the time
> range is extended beyond 2038?

What I meant was that rather than changing the returned range from
1970..2106 to 1902..2038, I would make the current behavior explicit
and document that it is correct.

> >>  static inline void ceph_decode_timespec(struct timespec *ts,
> >>                                         const struct ceph_timespec *tv)
> >>  {
> >> -       ts->tv_sec = (__kernel_time_t)le32_to_cpu(tv->tv_sec);
> >> -       ts->tv_nsec = (long)le32_to_cpu(tv->tv_nsec);
> >> +       ts->tv_sec = (s32)(s64)le32_to_cpu(tv->tv_sec);
> >> +       ts->tv_nsec = (s32)(s64)le32_to_cpu(tv->tv_nsec);
> >>  }
> >
> > Why did you choose to express this as "(s32)(s64)..." rather than
> > "(s64)(s32)..."? The result is the same (just the s32 cast by itself
> > would be sufficient), I just don't see yet how it clarifies what is
> > going on.
> 
> Let's say we encode -1.
> so when you pass the same value to decode, ceph_timespec is {0xFFFFFFFF,0}.
> 0xFFFFFFFF is greater than INT_MAX. And, according to c99 the result
> is implementation dependent if this cast to a s32.
> 
> Quoting from http://c0x.coding-guidelines.com/6.3.1.3.html :
> 6.3.1.3 Signed and unsigned integers
> 1 When a value with integer type is converted to another integer type
> other than _Bool, if the value can be represented by the newtype, it
> is unchanged.
> 2 Otherwise, if the newtype is unsigned, the value is converted by
> repeatedly adding or subtracting one more than the maximum value that
> can be represented in the newtype until the value is in the range of
> the newtype.49)
> 3 Otherwise, the newtype is signed and the value cannot be represented
> in it; either the result is implementation-defined or an
> implementation-defined signal is raised
> 
> GCC does guarantee the behavior.
> Quoting from GCC manual
> (https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html):
> The result of, or the signal raised by, converting an integer to a
> signed integer type when the value cannot be represented in an object
> of that type (C90 6.2.1.2, C99 and C11 6.3.1.3).
> For conversion to a type of width N, the value is reduced modulo 2^N
> to be within range of the type; no signal is raised.
> 
> But, as the C standard suggests, behavior is implementation dependent.
> This is why I cast it to s64 before casting it to s32.
> I explained in the commit text, but missed GCC part.

Ok, fair enough. I always assumed that "implementation specific"
in this context meant that on any architectures that implement
negative numbers as twos-complement (anything that Linux runs on)
we get the expected result. I'm sure we rely on that behavior in
a lot of places in the kernel, but you are correct that the C
standard makes your code well-defined, and the other one not.

	Arnd
