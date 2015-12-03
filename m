From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: Re: ceph encoding optimization
Date: Thu, 3 Dec 2015 17:17:51 +0800
Message-ID: <CANE=7sUj7_YgPS0w7Vx9-Es0u8avrMpcFdu4PRYok7G7r+0GMw@mail.gmail.com>
References: <CANE=7sURCs6VHCGAYMjXr2LMD7E6CfwqWkjYQopCOaQ-OzW65g@mail.gmail.com>
	<CAJ4mKGYeEHiVL+6V0BQFq4bcZU1nP9Q0YAd2_OkiP8ZR9h+9Jw@mail.gmail.com>
	<CANE=7sVGYGX1fPoHETWnXCBDtGEB2DivQVowor77CEKVtXH1Ew@mail.gmail.com>
	<34ee94ce6bc34f318148d87490880bb3@R01UKEXCASM111.r01.fujitsu.local>
	<CACJqLyYOcRNa4xXj5FDB74XVtBZwN_TqoNzMXBdZV7HJB2DC3w@mail.gmail.com>
	<CACJqLyZdBw_xVoXUfqoKYdrQj3606EWBRowzDdyP0DqWLG7KZg@mail.gmail.com>
	<alpine.DEB.2.00.1511080627300.27153@cobra.newdream.net>
	<CAJ4mKGbGSz_G-A=uEDSxSZrREWYu2CnoHMCjVS8tDW_Yd3HKXg@mail.gmail.com>
	<alpine.DEB.2.00.1511090719050.27153@cobra.newdream.net>
	<CANP1eJF+36VKM3difYJmXCfh=-fjHVAyd1VSoGGXbrNAUxYr7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35535 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932380AbbLCJRx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 04:17:53 -0500
Received: by wmuu63 with SMTP id u63so12395566wmu.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 01:17:51 -0800 (PST)
In-Reply-To: <CANP1eJF+36VKM3difYJmXCfh=-fjHVAyd1VSoGGXbrNAUxYr7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Dan Mick <dmick@redhat.com>, Haomai Wang <haomai@xsky.com>, "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I write a new patch about this
https://github.com/XinzeChi/ceph/commit/06eb471e463a4687e251273d0b5dfe170acbef2d

If you use __attribute__ ((packed)) after struct, we could encode many
struct member in a batch. There is not compatibility problem if we
keep the order of members defined in struct.

Wait for your comment.

2015-11-10 1:54 GMT+08:00 Milosz Tanski <milosz@adfin.com>:
> On Mon, Nov 9, 2015 at 10:24 AM, Sage Weil <sweil@redhat.com> wrote:
>> On Mon, 9 Nov 2015, Gregory Farnum wrote:
>>> On Wed, Nov 4, 2015 at 7:07 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> > The problem with this approach is that the encoded versions need to be
>>> > platform-independent ? they are shared over the wire and written to
>>> > disks that might get transplanted to different machines. Apart from
>>> > padding bytes, we also need to worry about endianness of the machine,
>>> > etc. *And* we often mutate structures across versions in order to add
>>> > new abilities, relying on the encode-decode process to deal with any
>>> > changes to the system. How could we deal with that if just dumping the
>>> > raw memory?
>>> >
>>> > Now, maybe we could make these changes on some carefully-selected
>>> > structs, I'm not sure. But we'd need a way to pick them out, guarantee
>>> > that we aren't breaking interoperability concerns, etc; and it would
>>> > need to be something we can maintain as a group going forward. I'm not
>>> > sure how to satisfy those constraints without burning a little extra
>>> > CPU. :/
>>> > -Greg
>>>
>>> So it turns out we've actually had issues with this. Sage merged
>>> (wrote?) some little-endian-only optimizations to the cephx code that
>>> broke big-endian systems by doing a direct memcpy. Apparently our
>>> tests don't find these issues, which makes me even more nervous about
>>> taking that sort of optimization into the tree. :(
>>
>> I think the way to make this maintainable will be to
>>
>> 1) Find a clean approach with a simple #if or #ifdef condition for
>> little endian and/or architectures that can handle unaligned int pointer
>> access.
>>
>
> In C++ you can also do that with a template <bool Endian> or using
> std::enable_if. The upside is the same as the downside (depending on
> how you look at it). So it'll add to compile time checks (because it
> won't be discarded by the processor) and it'll take longer to build,
> but you get extra checks and the compiler will later discard the
> unused code.
>
> If you do that, it should be easier to write unit tests for the functionality.
>
>> 2) Maintain the parallel optimized implementation next to the generic
>> encode/decode in a way that makes it as easy as possible to make changes
>> and keep them in sync.
>>
>> 3) Optimize *only* the most recent encoding to minimize complexity.
>>
>> 4) Ensure that there is a set of encode/decode tests that verify they both
>> work, triggered by make check (so that a simple make check on a big
>> endian box will catch errors).  Ideally this'd be part of the
>> test/encoding/readable.sh so that we run it over the entire corpus of old
>> encodings..
>>
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Milosz Tanski
> CTO
> 16 East 34th Street, 15th floor
> New York, NY 10016
>
> p: 646-253-9055
> e: milosz@adfin.com



-- 
Regards,
Xinze Chi
