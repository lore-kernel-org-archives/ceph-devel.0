From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Thu, 24 Sep 2015 11:10:27 -0700
Message-ID: <CAJ4mKGaJY31=WbTPFfpWkNho0zSb__dYMbjN6W9jeQTKiGvxyw@mail.gmail.com>
References: <56018A05.6090100@mirantis.com>
	<alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net>
	<56029F66.3070503@mirantis.com>
	<alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
	<CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
	<5602C48C.4010009@mirantis.com>
	<CAJ4mKGZLc1AzAbhEKpjSdUd21dXWgVxiLjjETHuP+EwVCA8EoA@mail.gmail.com>
	<5604131E.2030408@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35494 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123AbbIXSK3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 14:10:29 -0400
Received: by wicge5 with SMTP id ge5so263502993wic.0
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 11:10:27 -0700 (PDT)
In-Reply-To: <5604131E.2030408@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 24, 2015 at 8:13 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> On 23.09.2015 21:03, Gregory Farnum wrote:
>>
>> On Wed, Sep 23, 2015 at 6:15 AM, Sage Weil <sage@newdream.net> wrote:
>>>>>
>>>>>
>>>>> The idea of making the primary responsible for object compression
>>>>> really concerns me. It means for instance that a single random access
>>>>> will likely require access to multiple objects, and breaks many of the
>>>>> optimizations we have right now or in the pipeline (for instance:
>>>>> direct client access).
>>>
>>> Could you please elaborate why multiple objects access is required on
>>> single
>>> random access?
>>
>> It sounds to me like you were planning to take an incoming object
>> write, compress it, and then chunk it. If you do that, the symbols
>> ("abcdefgh = a", "ijklmnop = b", etc) for the compression are likely
>> to reside in the first object and need to be fetched for each read in
>> other objects.
>
> Gregory,
> do you mean a kind of compressor dictionary under symbols "abcdefgh = a",
> etc here.
> And your assumption is that such dictionary is made on the first write,
> saved and reused by any subsequent reads, right?
> I think that's not the case - it's better to compress each write
> independently.  Thus there is no need to access "dictionary" object ( i.e.
> the first object with these symbols) on every read operation,. The latter
> uses compressed block data only.
> Yes, this might affect total compression ratio but thinks that's acceptabl.
>>>
>>> In my opinion we need to access absolutely the same object set as before:
>>> in
>>> EC pool each appended block is spitted into multiple shards that go to
>>> respective OSDs. In general case one has to retrieve a set of adjacent
>>> shards from several OSDs on single read request.
>>
>> Usually we just need to get the object info from the primary and then
>> read whichever object has the data for the requested region. If the
>> region spans a stripe boundary we might need to get two, but often we
>> don't...
>
> With independent block compression mentioned above the scenario is the same.
> The only thing we need to find proper compressed block is a mapping from
> original data offset to the compressed ones. We can store this as object
> metadata. Thus we need object metadata on each read only.

Okay, that's acceptable, but that metadata then gets pretty large. You
would need to store an offset, for each chunk in the PG, and for each
individual write. (And even then you'd have to read an entire write at
a time to make sure you get the data requested, even if they only want
a small portion of it.)
If you're doing it this way, then realize we've also got a problem
with recovery: we can't lose those offsets. Which means they need to
be preserved at all costs. So that means for each stripe unit you'd
store them on the primary (for easy access) and on the replica (so
they have the same lifecycle as the data they're mapping), which means
the replicas need to be compression-aware. Which is good, since I
think they'd need to be compression-aware for scrubbing and things as
well. And then when you lose the primary the next guy who's
reconstructing would need to, uh, ask each shard for the uncompressed
version of the data?

If we were going to limit this to EC pools I think we should just do
it at the replica in the FileStore or something, transparently to the
wire and recovery protocols. While the compression would help on 1GigE
networks, on 10GigE I think the CPU costs of compression outweigh any
bandwidth efficiencies we'd get...


>>>
>>> In case of compression the
>>> only difference is in data range that compressed shard set occupy. I.e.
>>> we
>>> simply need to translate requested data range to the actually stored one
>>> and
>>> retrieve that data from OSDs. What's missed?
>>>>
>>>> And apparently only the EC pool will support
>>>> compression, which is frustrating for all the replicated pool users
>>>> out there...
>>>
>>> In my opinion  replicated pool users should consider EC pool usage first
>>> if
>>> they care about space saving. They automatically gain 50% space saving
>>> this
>>> way. Compression brings even more saving but that's rather the second
>>> step
>>> on this way.
>>
>> EC pools have important limitations that replicated pools don't, like
>> not working for object classes or allowing random overwrites. You can
>> stick a replicated cache pool in front but that comes with another
>> whole can of worms. Anybody with a large enough proportion of active
>> data won't find that solution suitable but might still want to reduce
>> space required where they can, like with local compression.
>
> Well I agree that have compression support for both replicated and EC pools
> is better.
> But random access ( and probably other advanced features ) requires much
> more complex data handling that also brings additional overhead. Actually I
> suppose EC pools have such limitations due to these reasons. Thus my
> original idea was to simplify compression implementation from one side and
> make it  in-line with EC usage from another. The latter makes sense since
> compression and EC  have pretty the same reasons for implementation.

Well, EC pools still support random reads, I think? Or at least
reading along stripes, which for the purpose of this discussion is
almost the same.

>
> And just for the sake of my education could you please mention or point out
> existing issues in cache+EC pools usage.
> How widely are EC pools used in production at all? Or that's rather
> experimental/secondary option?

Promotes are expensive. Work is ongoing to make cache pools work
better, but promotes will always be expensive. So they're only
suitable if you have a hot data set which is very small compared to
your total storage needs (and you need the cache tier to be a little
larger than that hot set). I'm not sure what the deployment of EC
pools looks like.

>>>>
>>>> Is there some reason we don't just want to apply encryption across an
>>>> OSD store? Perhaps doing it on the filesystem level is the wrong way
>>>> (for reasons named above) but there are other mechanisms like inline
>>>> block device compression that I think are supposed to work pretty
>>>> well.
>>>
>>> If I understand the idea of inline block device compression correctly it
>>> has
>>> some of drawbacks similar to FS compression approach. Ones to mention:
>>> * Less flexibility - per device compression only, no way to have per-pool
>>> compression. No control on the compression process.
>>
>> What would the use case be here? I can imagine not wanting to slow
>> down your cache pools with it or something (although realistically I
>> don't think that's a concern unless the sheer CPU usage is a problem
>> with frequent writes), but those would be on separate OSDs/volumes
>> anyway
>
> Well I can imagine the need to have compression for some specific backing
> pools ( e.g. with seldom accessed or highly compressible data) and disable
> it for others, e.g. where original data is non-compressible ( e.g. either
> already compressed  or encrypted).

Good compression algorithms already handle this, IIUC.

> Potentially we can even have some option to control compression on
> per-object basis and provide some hints for clients to enable it for
> specific use cases.

Mmmm, I'm not sure I'm comfortable exposing that to clients. If
they're compression-aware it's probably best to do it using them.

> Another feature that might be useful - the ability to disable/re-enable
> compression during OSD life-cycle. E.g. when Administrator realizes that
> it's not appropriate for his use case. I doubt that's easy to do when
> compression is performed at device level.

I confess I've no idea about this one.

In any case, as Sam said I think judging these proposals well will
require actually going through the data structure and algorithms
design work for each one and comparing. Unfortunately I've no time to
do that, but I'd definitely like to see two real approaches
well-sketched-out before any work is spent on coding one.
-Greg
