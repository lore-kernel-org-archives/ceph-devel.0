From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] include: ceph: Fix encode and decode type conversions
Date: Thu, 18 Feb 2016 18:22:55 +0100
Message-ID: <CAOi1vP9n2UiYPj+EC6FsofG5kdCwpNv1CVK=AuKuOSUXqmMRcg@mail.gmail.com>
References: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com>
	<CABeXuvqAgzCYGDh51rZK-MEh88T0gsxO4dRcFZVL-JWYXjtQzg@mail.gmail.com>
	<CAOi1vP8NycKxd2sp2qMS7AoZxTSnFSGdxOj9_sXU=sykqsR6hw@mail.gmail.com>
	<12201396.FPdHi0skie@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36353 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946259AbcBRRW4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Feb 2016 12:22:56 -0500
Received: by mail-wm0-f48.google.com with SMTP id g62so39160760wme.1
        for <ceph-devel@vger.kernel.org>; Thu, 18 Feb 2016 09:22:56 -0800 (PST)
In-Reply-To: <12201396.FPdHi0skie@wuerfel>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>

On Thu, Feb 18, 2016 at 5:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 18 February 2016 17:02:25 Ilya Dryomov wrote:
>>
>> If we are going to touch this function at all, let's drop all casts and
>> just add a comment along the lines of "the lack of cast/sign-extension
>> here is intentional, this function has a counterpart on the server side
>> which also lacks cast/sign-extension, etc".  To someone who is not up
>> on these subtleties, the __u64 cast is going to be more confusing than
>> explicit...
>
> We certainly a comment, I was just suggesting to add the cast as well.
>
> Again, it's not the lack of the cast on the server that is important
> here, it's whether it gets interpreted as signed or unsigned at the
> point where the timestamp is actually used for comparison or
> printing. Let me suggest a comment here:

I'd argue it's important to have encode/decode code look the same.

I mentioned before that at least in some places it's interpreted as
signed and that the interpretation is not totally up to the client.
The printing (at least some of it) is right there in the same file
(src/include/utime.h) and you can see ... + 1900.

>
> /*
>  * ceph timestamps are unsigned 32-bit starting at 1970, which is
>  * different from a signed 32-bit or 64-bit time_t. On 64-bit
>  * architectures, this gets interpreted as a subset of time_t
>  * in the range from 1970 to 2106.
>  * Machines with a 32-bit time_t will incorrectly interpret the
>  * timestamps with years 2038-2106 as negative numbers in the
>  * 1902-1969 range, until both kernel and glibc are change to
>  * using 64-bit time_t.
>  */

I think a more accurate description would be "ceph timestamps are
signed 32-bit, with the caveat that something somewhere is likely to
break on a negative timestamp".

We are not looking at trying to reuse that extra bit for 1970..2106.
As I said earlier, utime_t is used in quite a lot of places throughout
the code base and is part of both in-core and on-disk data structures.
Auditing all those sites for that is probably never going to happen.
I think the plan is to live with what we've got until a proper 64-bit
sec/nsec conversion is done in a way that was described earlier
(message versions, ceph feature bit, etc).  Any vfs timespec-handling
changes should simply preserve the existing behavior, for now.

Thanks,

                Ilya
