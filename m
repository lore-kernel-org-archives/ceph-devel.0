From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Wed, 23 Sep 2015 18:26:04 +0300
Message-ID: <5602C48C.4010009@mirantis.com>
References: <56018A05.6090100@mirantis.com>
 <alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net>
 <56029F66.3070503@mirantis.com>
 <alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
 <CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:36381 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506AbbIWP0K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 11:26:10 -0400
Received: by lacao8 with SMTP id ao8so31892231lac.3
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 08:26:07 -0700 (PDT)
In-Reply-To: <CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 23.09.2015 17:05, Gregory Farnum wrote:
> On Wed, Sep 23, 2015 at 6:15 AM, Sage Weil <sage@newdream.net> wrote:
>> On Wed, 23 Sep 2015, Igor Fedotov wrote:
>>> Hi Sage,
>>> thanks a lot for your feedback.
>>>
>>> Regarding issues with offset mapping and stripe size exposure.
>>> What's about the idea to apply compression in two-tier (cache+backi=
ng storage)
>>> model only ?
>> I'm not sure we win anything by making it a two-tier only thing... s=
imply
>> making it a feature of the EC pool means we can also address EC pool=
 users
>> like radosgw.
>>
>>> I doubt single-tier one is widely used for EC pools since there is =
no random
>>> write support in such mode. Thus this might be an acceptable limita=
tion.
>>> At the same time it seems that appends caused by cached object flus=
h have
>>> fixed block size (8Mb by default). And object is totally rewritten =
on the next
>>> flush if any. This makes offset mapping less tricky.
>>> Decompression should be applied in any model though as cache tier s=
hutdown and
>>> subsequent compressed data access is possibly  a valid use case.
>> Yeah, we need to handle random reads either way, so I think the offs=
et
>> mapping is going to be needed anyway.
> The idea of making the primary responsible for object compression
> really concerns me. It means for instance that a single random access
> will likely require access to multiple objects, and breaks many of th=
e
> optimizations we have right now or in the pipeline (for instance:
> direct client access).
Could you please elaborate why multiple objects access is required on=20
single random access?
In my opinion we need to access absolutely the same object set as=20
before: in EC pool each appended block is spitted into multiple shards=20
that go to respective OSDs. In general case one has to retrieve a set o=
f=20
adjacent shards from several OSDs on single read request. In case of=20
compression the only difference is in data range that compressed shard=20
set occupy. I.e. we simply need to translate requested data range to th=
e=20
actually stored one and retrieve that data from OSDs. What's missed?
> And apparently only the EC pool will support
> compression, which is frustrating for all the replicated pool users
> out there...
In my opinion  replicated pool users should consider EC pool usage firs=
t=20
if they care about space saving. They automatically gain 50% space=20
saving this way. Compression brings even more saving but that's rather=20
the second step on this way.
> Is there some reason we don't just want to apply encryption across an
> OSD store? Perhaps doing it on the filesystem level is the wrong way
> (for reasons named above) but there are other mechanisms like inline
> block device compression that I think are supposed to work pretty
> well.
If I understand the idea of inline block device compression correctly i=
t=20
has some of drawbacks similar to FS compression approach. Ones to menti=
on:
* Less flexibility - per device compression only, no way to have=20
per-pool compression. No control on the compression process.
* Potentially higher overhead when operating- There is no way to bypass=
=20
non-compressible data processing, e.g. shards with Erasure codes.
* Potentially higher overhead for recovery on OSD death - one needs to=20
decompress data at working OSDs and compress it at new OSD. That's not=20
necessary if compression takes place prior to EC though.
> The only thing that doesn't get us that I can see mentioned here
> is the over-the-wire compression =E2=80=94 and Haomai already has pat=
ches for
> that, which should be a lot easier to validate and will work at all
> levels of the stack!
> -Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
