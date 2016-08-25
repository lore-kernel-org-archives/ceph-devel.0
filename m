From: Haomai Wang <haomai@xsky.com>
Subject: Re: pg_stat_t is 500+ bytes
Date: Thu, 25 Aug 2016 20:56:23 +0800
Message-ID: <CACJqLyY3H5cQ9=s6uwUtJrGNygWg-ChifuSCNtbJ+0819dhkzw@mail.gmail.com>
References: <alpine.DEB.2.11.1608231807270.25681@piezo.us.to>
 <CACJqLyYaXy81jvFj2jiofucYLPY4cmQQtDohJwRTb5ddLzOedA@mail.gmail.com>
 <CACJqLybzJHWrVF-gOZy6nvUTb0weZJRtqt4rJBO_Nn1viBjDgw@mail.gmail.com>
 <alpine.DEB.2.11.1608241607360.25681@piezo.us.to> <e20c13f4-ae6f-e06a-ac1b-c5736737e642@redhat.com>
 <20160824162031.GA26181@predictor> <CACJqLyagS94AefE3vj6pEb5F7J74XTn5zLT+Sm65hHvzSXfqwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0111.outbound.protection.outlook.com ([104.47.124.111]:17222
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932252AbcHYM4d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 25 Aug 2016 08:56:33 -0400
Received: by mail-ua0-f171.google.com with SMTP id m60so41509506uam.3
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2016 05:56:29 -0700 (PDT)
In-Reply-To: <CACJqLyagS94AefE3vj6pEb5F7J74XTn5zLT+Sm65hHvzSXfqwg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <branch@predictor.org.pl>
Cc: Mark Nelson <mnelson@redhat.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 25, 2016 at 8:54 PM, Haomai Wang <haomai@xsky.com> wrote:
> I think there exists a lot of fields can't be discarded via judging
> 0s, like utime_t, epoch_t. A simple way is to compare with previous
> pg_info_t.

Oh, sorry. We may could use a fresh pg_info_t to indicate. But below
also could apply this way.

>
> BTW, I want to mentiond pg_info_t encoding occurs 6.05% cpu time in pg
> thread(thread level not process level).
>
> looks we have three optimization from mark and Piotr:
>
> 1. reconstruct pg_info_t and make high frequent fields together.
> 2. change some fields to smaller bits
> 3. uses SIMD to optimize low frequency fields difference comparison(optio=
nal)
>
> intel SSE4.2 pcmpistrm instructive could do very good 128bytes
> comparison, pg_info_t is above 700bytes:
>
> inline const char *skip_same_128_bytes_SIMD(const char* p, const char* p2=
) {
>     const __m128i w =3D _mm_load_si128((const __m128i *)p2);
>
>     for (;; p +=3D 16) {
>         const __m128i s =3D _mm_load_si128((const __m128i *)p);
>         const unsigned r =3D _mm_cvtsi128_si32(_mm_cmpistrm(w, s,
>             _SIDD_UBYTE_OPS | _SIDD_CMP_EQUAL_ANY |
>             _SIDD_BIT_MASK | _SIDD_NEGATIVE_POLARITY));
>
>         if (r !=3D 0) // some of characters isn't equal
>             return p + __builtin_ffs(r) - 1;
>     }
> }
>
> On Thu, Aug 25, 2016 at 12:20 AM, Piotr Da=C5=82ek <branch@predictor.org.=
pl> wrote:
>> On Wed, Aug 24, 2016 at 11:12:24AM -0500, Mark Nelson wrote:
>>>
>>>
>>> On 08/24/2016 11:09 AM, Sage Weil wrote:
>>> >On Wed, 24 Aug 2016, Haomai Wang wrote:
>>> >>On Wed, Aug 24, 2016 at 11:01 AM, Haomai Wang <haomai@xsky.com> wrote=
:
>>> >>>On Wed, Aug 24, 2016 at 2:13 AM, Sage Weil <sweil@redhat.com> wrote:
>>> >>>>This is huge.  It takes the pg_info_t str from 306 bytes to 847 byt=
es, and
>>> >>>>this _info omap key is rewritten on *every* IO.
>>> >>>>
>>> >>>>We could shrink this down significant with varint and/or delta enco=
ding
>>> >>>>since a huge portion of it is just a bunch of uint64_t counters.  T=
his
>>> >>>>will probably cost some CPU time, but OTOH it'll also shrink our me=
tadata
>>> >>>>down a fair bit too which will pay off later.
>>> >>>>
>>> >>>>Anybody want to tackle this?
>>> >>>
>>> >>>what about separating "object_stat_collection_t stats" from pg_stat_=
t?
>>> >>>pg info should be unchanged for most of times, we could only update
>>> >>>object related stats. This may help to reduce half bytes.
>>> >
>>> >I don't think this will work, since every op changes last_update in
>>> >pg_info_t *and* the stats (write op count, total bytes, objects, etc.)=
.
>>> >
>>> >>Or we only store increment values and keep the full in memory(may
>>> >>reduce to 20-30bytes). In period time we store the full structure(onl=
y
>>> >>hundreds of bytes)....
>>> >
>>> >A delta is probably very compressible (only a few fields in the stats
>>> >struct change).  The question is how fast can we make it in CPU time.
>>> >Probably a simple delta (which will be almost all 0's) and a trivial
>>> >run-length-encoding scheme that just gets rid of the 0's would do well
>>> >enough...
>>>
>>> Do we have any rough idea of how many/often consecutive 0s we end up
>>> with in the current encoding?
>>
>> Or how high these counters get? We could try transposing the matrix made=
 of
>> those counters. At least the two most significant bytes in most of those
>> counters are mostly zeros, and after transposing, simple RLE would be
>> feasible. In any case, I'm not sure if *all* of these fields need to be
>> uint64_t.
>>
>> --
>> Piotr Da=C5=82ek
>> branch@predictor.org.pl
>> http://blog.predictor.org.pl
