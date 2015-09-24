From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Thu, 24 Sep 2015 18:13:34 +0300
Message-ID: <5604131E.2030408@mirantis.com>
References: <56018A05.6090100@mirantis.com>
 <alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net>
 <56029F66.3070503@mirantis.com>
 <alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
 <CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
 <5602C48C.4010009@mirantis.com>
 <CAJ4mKGZLc1AzAbhEKpjSdUd21dXWgVxiLjjETHuP+EwVCA8EoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:35999 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421AbbIXPNj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 11:13:39 -0400
Received: by lacao8 with SMTP id ao8so67259707lac.3
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 08:13:37 -0700 (PDT)
In-Reply-To: <CAJ4mKGZLc1AzAbhEKpjSdUd21dXWgVxiLjjETHuP+EwVCA8EoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On 23.09.2015 21:03, Gregory Farnum wrote:
> On Wed, Sep 23, 2015 at 6:15 AM, Sage Weil <sage@newdream.net> wrote:
>>>>
>>>> The idea of making the primary responsible for object compression
>>>> really concerns me. It means for instance that a single random acc=
ess
>>>> will likely require access to multiple objects, and breaks many of=
 the
>>>> optimizations we have right now or in the pipeline (for instance:
>>>> direct client access).
>> Could you please elaborate why multiple objects access is required o=
n single
>> random access?
> It sounds to me like you were planning to take an incoming object
> write, compress it, and then chunk it. If you do that, the symbols
> ("abcdefgh =3D a", "ijklmnop =3D b", etc) for the compression are lik=
ely
> to reside in the first object and need to be fetched for each read in
> other objects.
Gregory,
do you mean a kind of compressor dictionary under symbols "abcdefgh =3D=
=20
a", etc here.
And your assumption is that such dictionary is made on the first write,=
=20
saved and reused by any subsequent reads, right?
I think that's not the case - it's better to compress each write=20
independently.  Thus there is no need to access "dictionary" object (=20
i.e. the first object with these symbols) on every read operation,. The=
=20
latter uses compressed block data only.
Yes, this might affect total compression ratio but thinks that's accept=
abl.
>> In my opinion we need to access absolutely the same object set as be=
fore: in
>> EC pool each appended block is spitted into multiple shards that go =
to
>> respective OSDs. In general case one has to retrieve a set of adjace=
nt
>> shards from several OSDs on single read request.
> Usually we just need to get the object info from the primary and then
> read whichever object has the data for the requested region. If the
> region spans a stripe boundary we might need to get two, but often we
> don't...
With independent block compression mentioned above the scenario is the=20
same. The only thing we need to find proper compressed block is a=20
mapping from original data offset to the compressed ones. We can store=20
this as object metadata. Thus we need object metadata on each read only=
=2E
>> In case of compression the
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
> EC pools have important limitations that replicated pools don't, like
> not working for object classes or allowing random overwrites. You can
> stick a replicated cache pool in front but that comes with another
> whole can of worms. Anybody with a large enough proportion of active
> data won't find that solution suitable but might still want to reduce
> space required where they can, like with local compression.
Well I agree that have compression support for both replicated and EC=20
pools is better.
But random access ( and probably other advanced features ) requires muc=
h=20
more complex data handling that also brings additional overhead.=20
Actually I suppose EC pools have such limitations due to these reasons.=
=20
Thus my original idea was to simplify compression implementation from=20
one side and make it  in-line with EC usage from another. The latter=20
makes sense since compression and EC  have pretty the same reasons for=20
implementation.

And just for the sake of my education could you please mention or point=
=20
out existing issues in cache+EC pools usage.
How widely are EC pools used in production at all? Or that's rather=20
experimental/secondary option?
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
> What would the use case be here? I can imagine not wanting to slow
> down your cache pools with it or something (although realistically I
> don't think that's a concern unless the sheer CPU usage is a problem
> with frequent writes), but those would be on separate OSDs/volumes
> anyway
Well I can imagine the need to have compression for some specific=20
backing pools ( e.g. with seldom accessed or highly compressible data)=20
and disable it for others, e.g. where original data is non-compressible=
=20
( e.g. either already compressed  or encrypted).
Potentially we can even have some option to control compression on=20
per-object basis and provide some hints for clients to enable it for=20
specific use cases.
Another feature that might be useful - the ability to disable/re-enable=
=20
compression during OSD life-cycle. E.g. when Administrator realizes tha=
t=20
it's not appropriate for his use case. I doubt that's easy to do when=20
compression is performed at device level.

> Plus block device compression is also able to include all the *other*
> stuff that doesn't fit inside the object proper (xattrs and omap).
Yes, that's a good point but I suppose nothing prevents us from=20
compressing metadata by ourselves too.
>> * Potentially higher overhead when operating- There is no way to byp=
ass
>> non-compressible data processing, e.g. shards with Erasure codes.
> My information theory intuition has never been very good, but I don't
> think the coded chunks are any less compressible than the data they'r=
e
> coding for, in general...
Yes, my bad. I played with EC a bit - generated chunks are pretty=20
regular. I expected something absolutely random like encrypted data.

> ...I should note that I'm under the impression that transparent
> compression already exists at some level which can be stacked with
> regular filesystems, but I'm not finding it now, so maybe I'm
> misinformed and the tradeoffs are a little different than I thought.
I found some mentions about RBD device that performs inline compression=
=2E=20
But pretty limited information present on the Net makes me think that=20
this solution is far from production usage.

> But I still don't like the idea of doing it on a primary just for EC
> pools =E2=80=93 I think if we were going to take that approach it'd b=
e easier
> to compress somewhere before it reaches the EC/replicated split?
As I mentioned above the main reasons that pushed me to merge=20
compression with EC pools are similar handling issues and their mission=
s=20
( space for cpu)  they provide.
Moving compression to any different place raises many-many complication=
s..

Anyway will try to make some summary on the suggested approaches and=20
their Pros and Cons.

Thanks,
Igor

PS. Gregory I highly appreciate your feedback.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
