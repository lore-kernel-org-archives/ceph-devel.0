From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Thu, 24 Sep 2015 18:34:22 +0300
Message-ID: <560417FE.5000403@mirantis.com>
References: <56018A05.6090100@mirantis.com>
 <alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net>
 <56029F66.3070503@mirantis.com>
 <alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
 <CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
 <5602C48C.4010009@mirantis.com>
 <CAN=+7FXXLVn=8kLJcD0ZC-2nfN8n4HL1V1_XuyjzpsLZOXG2dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:33829 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbbIXPe0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 11:34:26 -0400
Received: by lacdq2 with SMTP id dq2so12830175lac.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 08:34:24 -0700 (PDT)
In-Reply-To: <CAN=+7FXXLVn=8kLJcD0ZC-2nfN8n4HL1V1_XuyjzpsLZOXG2dQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

Samuel,
I completely agree about the need to have a blueprint before the=20
implementation. But I think we should fix what approach to use ( when=20
and how to perform the compression) first.
I'll summarize existing suggestions and their Pros and Cons shortly.=20
Thus we'll be able to discuss them more productively.

Regarding performing the compression at the client side - I'm afraid=20
it's not that easy given the fact that we have multiple clients with=20
different use patterns and random data access.

Thanks,
Igor.

On 23.09.2015 20:31, Samuel Just wrote:
> I think before moving forward with any sort of implementation, the
> design would need to be pretty much completely mapped out --
> particularly how the offset mapping will be handled and stored.  The
> right thing to do would be to produce a blueprint and submit it to th=
e
> list.  I also would vastly prefer to do it on the client side if
> possible.  Certainly, radosgw could do the compression just as easily
> as the osds (except for the load on the radosgw heads, I suppose).
> -Sam
>
> On Wed, Sep 23, 2015 at 8:26 AM, Igor Fedotov <ifedotov@mirantis.com>=
 wrote:
>>
>> On 23.09.2015 17:05, Gregory Farnum wrote:
>>> On Wed, Sep 23, 2015 at 6:15 AM, Sage Weil <sage@newdream.net> wrot=
e:
>>>> On Wed, 23 Sep 2015, Igor Fedotov wrote:
>>>>> Hi Sage,
>>>>> thanks a lot for your feedback.
>>>>>
>>>>> Regarding issues with offset mapping and stripe size exposure.
>>>>> What's about the idea to apply compression in two-tier (cache+bac=
king
>>>>> storage)
>>>>> model only ?
>>>> I'm not sure we win anything by making it a two-tier only thing...=
 simply
>>>> making it a feature of the EC pool means we can also address EC po=
ol
>>>> users
>>>> like radosgw.
>>>>
>>>>> I doubt single-tier one is widely used for EC pools since there i=
s no
>>>>> random
>>>>> write support in such mode. Thus this might be an acceptable limi=
tation.
>>>>> At the same time it seems that appends caused by cached object fl=
ush
>>>>> have
>>>>> fixed block size (8Mb by default). And object is totally rewritte=
n on
>>>>> the next
>>>>> flush if any. This makes offset mapping less tricky.
>>>>> Decompression should be applied in any model though as cache tier
>>>>> shutdown and
>>>>> subsequent compressed data access is possibly  a valid use case.
>>>> Yeah, we need to handle random reads either way, so I think the of=
fset
>>>> mapping is going to be needed anyway.
>>> The idea of making the primary responsible for object compression
>>> really concerns me. It means for instance that a single random acce=
ss
>>> will likely require access to multiple objects, and breaks many of =
the
>>> optimizations we have right now or in the pipeline (for instance:
>>> direct client access).
>> Could you please elaborate why multiple objects access is required o=
n single
>> random access?
>> In my opinion we need to access absolutely the same object set as be=
fore: in
>> EC pool each appended block is spitted into multiple shards that go =
to
>> respective OSDs. In general case one has to retrieve a set of adjace=
nt
>> shards from several OSDs on single read request. In case of compress=
ion the
>> only difference is in data range that compressed shard set occupy. I=
=2Ee. we
>> simply need to translate requested data range to the actually stored=
 one and
>> retrieve that data from OSDs. What's missed?
>>> And apparently only the EC pool will support
>>> compression, which is frustrating for all the replicated pool users
>>> out there...
>> In my opinion  replicated pool users should consider EC pool usage f=
irst if
>> they care about space saving. They automatically gain 50% space savi=
ng this
>> way. Compression brings even more saving but that's rather the secon=
d step
>> on this way.
>>> Is there some reason we don't just want to apply encryption across =
an
>>> OSD store? Perhaps doing it on the filesystem level is the wrong wa=
y
>>> (for reasons named above) but there are other mechanisms like inlin=
e
>>> block device compression that I think are supposed to work pretty
>>> well.
>> If I understand the idea of inline block device compression correctl=
y it has
>> some of drawbacks similar to FS compression approach. Ones to mentio=
n:
>> * Less flexibility - per device compression only, no way to have per=
-pool
>> compression. No control on the compression process.
>> * Potentially higher overhead when operating- There is no way to byp=
ass
>> non-compressible data processing, e.g. shards with Erasure codes.
>> * Potentially higher overhead for recovery on OSD death - one needs =
to
>> decompress data at working OSDs and compress it at new OSD. That's n=
ot
>> necessary if compression takes place prior to EC though.
>>
>>> The only thing that doesn't get us that I can see mentioned here
>>> is the over-the-wire compression =E2=80=94 and Haomai already has p=
atches for
>>> that, which should be a lot easier to validate and will work at all
>>> levels of the stack!
>>> -Greg
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
