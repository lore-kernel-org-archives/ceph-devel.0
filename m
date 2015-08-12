From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: bufferlist allocation optimization ideas
Date: Wed, 12 Aug 2015 12:53:00 +0800
Message-ID: <CACJqLyb7FW11944whyxNa+=2qAaMp0oQ=aXuJrj4jhU8usM=Yg@mail.gmail.com>
References: <alpine.DEB.2.00.1508101208510.26854@cobra.newdream.net>
	<alpine.DEB.2.00.1508111307540.22099@cobra.newdream.net>
	<90559C83A9C7FA45B5846C975DFA612DDB53561F31@ABGEX73E.FSC.NET>
	<CACJqLyYrd4eZVfaW07ahF5m8C9DQOOHjDh0fj9XixePUkXa_tQ@mail.gmail.com>
	<90559C83A9C7FA45B5846C975DFA612DDB53561F34@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34708 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbbHLExB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Aug 2015 00:53:01 -0400
Received: by ykdt205 with SMTP id t205so5223902ykd.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2015 21:53:00 -0700 (PDT)
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB53561F34@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sure, so we could introduce it to async messenger. We could create a
buffer pool, then bufferlist's api could use passing in buffer pool to
alloc memory.

On Wed, Aug 12, 2015 at 12:43 PM, Da=C5=82ek, Piotr
<Piotr.Dalek@ts.fujitsu.com> wrote:
>> -----Original Message-----
>> From: Haomai Wang [mailto:haomaiwang@gmail.com]
>> Sent: Wednesday, August 12, 2015 4:56 AM
>> To: Da=C5=82ek, Piotr
>>
>> On Wed, Aug 12, 2015 at 5:48 AM, Da=C5=82ek, Piotr <Piotr.Dalek@ts.f=
ujitsu.com>
>> wrote:
>> >> -----Original Message-----
>> >> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> >> owner@vger.kernel.org] On Behalf Of Sage Weil
>> >> Sent: Tuesday, August 11, 2015 10:11 PM
>> >>
>> >> I went ahead and implemented both of these pieces.  See
>> >>
>> >>       https://github.com/ceph/ceph/pull/5534
>> >>
>> >> My benchmark numbers are highly suspect, but the approximate
>> takeaway
>> >> is that it's 2x faster for the simple microbenchmarks and does 1/=
3rd
>> >> the allocations.  But there is some weird interaction with the
>> >> allocator going on for 16k allocations that I saw, so it needs so=
me more
>> careful benchmarking.
>> >
>> > 16k allocations aren't that common, actually.
>> > Some time ago I took an alloc profile for raw_char and posix_align=
ed
>> buffers, and...
>> >
>> > [root@storage1 /]# sort buffer::raw_char-2143984.dat | uniq -c | s=
ort -g
>> >       1 12
>> >       1 33
>> >       1 393
>> >       1 41
>> >       2 473
>> >       2 66447
>> >       3 190
>> >       3 20
>> >       3 64
>> >       4 16
>> >      36 206
>> >      88 174
>> >      88 48
>> >      89 272
>> >      89 36
>> >      90 34
>> >     312 207
>> >    3238 208
>> >   32403 209
>> >  196300 210
>> >  360164 45
>>
>> Since size is centralization, we could use a fixed size buffer pool =
to optimize
>> this. The performance is outstanding as I perf.
>
> Idea is great, but execution is tricky, especially in case of simple =
messenger -- we have a lot of threads allocing and freeing memory, so p=
ool must be aware of that and not become a bottleneck itself.
>
>
> With best regards / Pozdrawiam
> Piotr Da=C5=82ek



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
