From: Samuel Just <sjust@redhat.com>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Wed, 23 Sep 2015 10:31:53 -0700
Message-ID: <CAN=+7FXXLVn=8kLJcD0ZC-2nfN8n4HL1V1_XuyjzpsLZOXG2dQ@mail.gmail.com>
References: <56018A05.6090100@mirantis.com>
	<alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net>
	<56029F66.3070503@mirantis.com>
	<alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
	<CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
	<5602C48C.4010009@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33983 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942AbbIWRby convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 13:31:54 -0400
Received: by iofb144 with SMTP id b144so50680858iof.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 10:31:54 -0700 (PDT)
In-Reply-To: <5602C48C.4010009@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

I think before moving forward with any sort of implementation, the
design would need to be pretty much completely mapped out --
particularly how the offset mapping will be handled and stored.  The
right thing to do would be to produce a blueprint and submit it to the
list.  I also would vastly prefer to do it on the client side if
possible.  Certainly, radosgw could do the compression just as easily
as the osds (except for the load on the radosgw heads, I suppose).
-Sam

On Wed, Sep 23, 2015 at 8:26 AM, Igor Fedotov <ifedotov@mirantis.com> w=
rote:
>
>
> On 23.09.2015 17:05, Gregory Farnum wrote:
>>
>> On Wed, Sep 23, 2015 at 6:15 AM, Sage Weil <sage@newdream.net> wrote=
:
>>>
>>> On Wed, 23 Sep 2015, Igor Fedotov wrote:
>>>>
>>>> Hi Sage,
>>>> thanks a lot for your feedback.
>>>>
>>>> Regarding issues with offset mapping and stripe size exposure.
>>>> What's about the idea to apply compression in two-tier (cache+back=
ing
>>>> storage)
>>>> model only ?
>>>
>>> I'm not sure we win anything by making it a two-tier only thing... =
simply
>>> making it a feature of the EC pool means we can also address EC poo=
l
>>> users
>>> like radosgw.
>>>
>>>> I doubt single-tier one is widely used for EC pools since there is=
 no
>>>> random
>>>> write support in such mode. Thus this might be an acceptable limit=
ation.
>>>> At the same time it seems that appends caused by cached object flu=
sh
>>>> have
>>>> fixed block size (8Mb by default). And object is totally rewritten=
 on
>>>> the next
>>>> flush if any. This makes offset mapping less tricky.
>>>> Decompression should be applied in any model though as cache tier
>>>> shutdown and
>>>> subsequent compressed data access is possibly  a valid use case.
>>>
>>> Yeah, we need to handle random reads either way, so I think the off=
set
>>> mapping is going to be needed anyway.
>>
>> The idea of making the primary responsible for object compression
>> really concerns me. It means for instance that a single random acces=
s
>> will likely require access to multiple objects, and breaks many of t=
he
>> optimizations we have right now or in the pipeline (for instance:
>> direct client access).
>
> Could you please elaborate why multiple objects access is required on=
 single
> random access?
> In my opinion we need to access absolutely the same object set as bef=
ore: in
> EC pool each appended block is spitted into multiple shards that go t=
o
> respective OSDs. In general case one has to retrieve a set of adjacen=
t
> shards from several OSDs on single read request. In case of compressi=
on the
> only difference is in data range that compressed shard set occupy. I.=
e. we
> simply need to translate requested data range to the actually stored =
one and
> retrieve that data from OSDs. What's missed?
>>
>> And apparently only the EC pool will support
>> compression, which is frustrating for all the replicated pool users
>> out there...
>
> In my opinion  replicated pool users should consider EC pool usage fi=
rst if
> they care about space saving. They automatically gain 50% space savin=
g this
> way. Compression brings even more saving but that's rather the second=
 step
> on this way.
>>
>> Is there some reason we don't just want to apply encryption across a=
n
>> OSD store? Perhaps doing it on the filesystem level is the wrong way
>> (for reasons named above) but there are other mechanisms like inline
>> block device compression that I think are supposed to work pretty
>> well.
>
> If I understand the idea of inline block device compression correctly=
 it has
> some of drawbacks similar to FS compression approach. Ones to mention=
:
> * Less flexibility - per device compression only, no way to have per-=
pool
> compression. No control on the compression process.
> * Potentially higher overhead when operating- There is no way to bypa=
ss
> non-compressible data processing, e.g. shards with Erasure codes.
> * Potentially higher overhead for recovery on OSD death - one needs t=
o
> decompress data at working OSDs and compress it at new OSD. That's no=
t
> necessary if compression takes place prior to EC though.
>
>> The only thing that doesn't get us that I can see mentioned here
>> is the over-the-wire compression =E2=80=94 and Haomai already has pa=
tches for
>> that, which should be a lot easier to validate and will work at all
>> levels of the stack!
>> -Greg
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
