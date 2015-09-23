From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Wed, 23 Sep 2015 11:03:41 -0700
Message-ID: <CAJ4mKGZLc1AzAbhEKpjSdUd21dXWgVxiLjjETHuP+EwVCA8EoA@mail.gmail.com>
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
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33820 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbbIWSDn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 14:03:43 -0400
Received: by wicfx3 with SMTP id fx3so250552228wic.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 11:03:41 -0700 (PDT)
In-Reply-To: <5602C48C.4010009@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

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

It sounds to me like you were planning to take an incoming object
write, compress it, and then chunk it. If you do that, the symbols
("abcdefgh =3D a", "ijklmnop =3D b", etc) for the compression are likel=
y
to reside in the first object and need to be fetched for each read in
other objects.

> In my opinion we need to access absolutely the same object set as bef=
ore: in
> EC pool each appended block is spitted into multiple shards that go t=
o
> respective OSDs. In general case one has to retrieve a set of adjacen=
t
> shards from several OSDs on single read request.

Usually we just need to get the object info from the primary and then
read whichever object has the data for the requested region. If the
region spans a stripe boundary we might need to get two, but often we
don't...

> In case of compression the
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

EC pools have important limitations that replicated pools don't, like
not working for object classes or allowing random overwrites. You can
stick a replicated cache pool in front but that comes with another
whole can of worms. Anybody with a large enough proportion of active
data won't find that solution suitable but might still want to reduce
space required where they can, like with local compression.

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

What would the use case be here? I can imagine not wanting to slow
down your cache pools with it or something (although realistically I
don't think that's a concern unless the sheer CPU usage is a problem
with frequent writes), but those would be on separate OSDs/volumes
anyway
Plus block device compression is also able to include all the *other*
stuff that doesn't fit inside the object proper (xattrs and omap).

> * Potentially higher overhead when operating- There is no way to bypa=
ss
> non-compressible data processing, e.g. shards with Erasure codes.

My information theory intuition has never been very good, but I don't
think the coded chunks are any less compressible than the data they're
coding for, in general...

> * Potentially higher overhead for recovery on OSD death - one needs t=
o
> decompress data at working OSDs and compress it at new OSD. That's no=
t
> necessary if compression takes place prior to EC though.

Hmm, that is an interesting point. I guess I'm just not sure about the
labor and validation tradeoffs involved in obtaining this (it really
seems like the only advantage to me).


=2E..I should note that I'm under the impression that transparent
compression already exists at some level which can be stacked with
regular filesystems, but I'm not finding it now, so maybe I'm
misinformed and the tradeoffs are a little different than I thought.
But I still don't like the idea of doing it on a primary just for EC
pools =E2=80=93 I think if we were going to take that approach it'd be =
easier
to compress somewhere before it reaches the EC/replicated split?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
