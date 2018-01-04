From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: New ObjectStore
Date: Thu, 4 Jan 2018 14:22:24 -0800
Message-ID: <CAJ4mKGYpn0xQLn7jguCJK-uZcwnBtvqowh1g3ycuXexh=3gBcw@mail.gmail.com>
References: <MWHPR04MB08304BB565252C3A684CB216F10D0@MWHPR04MB0830.namprd04.prod.outlook.com>
 <alpine.DEB.2.11.1712211637520.24928@piezo.novalocal> <MWHPR04MB08304A297CEC67D9130B6B1DF10D0@MWHPR04MB0830.namprd04.prod.outlook.com>
 <alpine.DEB.2.11.1712211744440.24928@piezo.novalocal> <MWHPR04MB08302A858CFF9215C32F3859F10D0@MWHPR04MB0830.namprd04.prod.outlook.com>
 <alpine.DEB.2.11.1801040334020.8186@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:37852 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeADWW0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jan 2018 17:22:26 -0500
Received: by mail-io0-f171.google.com with SMTP id n14so3808255iob.4
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jan 2018 14:22:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801040334020.8186@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Allen Samuels <Allen.Samuels@wdc.com>, Sage Weil <sweil@redhat.com>

On Thu, Jan 4, 2018 at 8:21 AM, Sage Weil <sweil@redhat.com> wrote:
> Adding ceph-devel.
>
> This is a discussion Allen and I were having earlier about what the future
> post-BlueStore native SPDK, nvme-focused ObjectStore backend could look
> like.  The short description is something like "log-structured btree", the
> idea being that we would do the cleaning in the software layer so that the
> nvme's garbage collection generally has nothing to do.
>
> I would like to start thinking about this sooner rather than later so that
> we have a good idea of what we want to build and, hopefully, can time
> having a testable backend prototype with the futures-ified OSD IO path.

The below sounds like a pretty standard log-structured storage system
to me. That has its benefits, but the main drawback of any
log-structured system persists — it's a data fragmentation nightmare.

Now, I agree this is the way to go, and I think we can control the
input and IO scheduling enough to handle the issues. But we have to
figure out how to do so — successful log-structured systems right I
know of are carefully restricted and designed so that the
fragmentation isn't an issue. I'm not sure how we can make that happen
against eg RBD where we know we're going to get a lot of random 4K
IOs, some of which overwrite repeatedly but a bunch of which won't on
any useful timescale. When I've blue-skied this myself in the past,
it's involved fundamental changes to RADOS like making all objects
append-only, with compaction rules that both clients and OSDs know
about and can coordinate on.

Taking a step back, I'm wary of doing this to early. As I mentioned in
CDM, I'm not sure we'll have a good idea what kind of interface we
want until we're farther along with working on the OSD, and I think
that may have a big impact on how the storage system should look. And
I'm not just talking about whether we want callbacks or polling,
whether we want both readable and committed notifications, etc. If
we're *really* targeting this to NVMe and faster storage, we should
think about how we'll use persistent memory technologies. (This may
sound familiar to a few of you...) Maybe they become an integral part
of our persistence story, and in NVRAM we maintain a very simple
journal of client IO in the form of incoming messages that is used for
"commit", and we flush that out to a backing NVMe device in giant
efficient batches, and the allowed ObjectStore write latency is in the
range of a second. A system for doing that has very different
requirements from one where we need to persist data via the
ObjectStore and send back a client commit within 100 microseconds.

>
> sage
>
>
> On Thu, 21 Dec 2017, Allen Samuels wrote:
>> Yes. But you mix the data AND the b-tree into the same log.
>>
>> Essentially, each ObjectStore transaction generates a single contiguous
>> write to the log. Data and metadata are intermixed and formatted such
>> that you can re-read the last open stripe on a restart to restore. In
>> the log you have data pages, whole metadata pages (b-tree pages) and
>> metadata deltas (transactional edits) intermixed such that you can
>> always read the stripe from the beginning and discern which is which (as
>> well as torn stripe-writes....).
>>
>> Logically, a write consists of modifying a number of in-memory blocks
>> (some data and some metadata). The data written to the log is ALWAYS the
>> deltas, thus conceptually after the log write we are left with some
>> number of "dirty" memory blocks that can only be reconstructed by going
>> back to the last non-delta version and applying the deltas from the log
>> since that time. [As a key optimization, whole block writes/deltas leave
>> you with a memory block that's NOT dirty once the log is written ;) ]
>> When memory is "full", you can bulk-up a log write with some
>> un-associated dirty blocks which allows them to be cleaned and
>> discarded. By writing deltas, you automatically get the "combining"
>> behavior (this is a strength of LSM algos) but only on the individual
>> B-tree blocks (not the entire tree), in essence, if you have multiple
>> transactions on metadata that's within the same B-tree block [a VERY
>> frequent situation] this system automatically combines those like what
>> you get with Rocks-ish LSM stuff.
>>
>> You need to limit how long the delta chain for a metadata block becomes
>> (to improve restart times by bounding the amount of data that needs to
>> be read in to reconstruct the dirty block from it's accumulated deltas).
>> The cheapest thing to do is to simply ensure that all blocks get flushed
>> across a backing store stripe change. That's relatively easy to do by
>> regulating the maximum amount of dirty blocks and then simply writing
>> all dirty blocks at the start of each stripe (when you close one stripe
>> and open up the next one).
>>
>> Log cleaning/compaction is relatively easy, you just read each stripe
>> from from to end, parsing as you go. You'll need to lookup each object
>> to determine if this is an old, version of the object or if it's the
>> "live" object. If it's live, you just mark it dirty (in the in-memory
>> buffer) and go on, it'll get dumped with the next write (which you might
>> have to artificially trigger).
>>
>> One key issue is how you address blocks. Some schemes use physical
>> addresses for blocks, this forces the cleaning activity to dirty
>> additional metadata (the pointer to this object), however for data this
>> tends to be localized (the pointer to the data is typically writing in
>> the same stripe). Alternatively, you can create a logical/physical
>> address mapping table so that you can move blocks and update this
>> micro-table without affecting the logical addresses in the upper level
>> metadata blocks. However, this does create an additional mapping table
>> which needs to be checkpointed/recovered (separate from the other data)
>> and is frequently implemented as an in-memory table, costing 6-ish bytes
>> of DRAM per page.
>>
>> Allen Samuels
>> R&D Engineering Fellow
>>
>> Western Digital(r)
>> Email:  allen.samuels@wdc.com
>> Office:  +1-408-801-7030
>> Mobile: +1-408-780-6416
>>
>>
>> -----Original Message-----
>> From: Sage Weil [mailto:sweil@redhat.com]
>> Sent: Thursday, December 21, 2017 9:45 AM
>> To: Allen Samuels <Allen.Samuels@wdc.com>
>> Subject: RE: New ObjectStore
>>
>> log structured b-tree thing?
>>
>> On Thu, 21 Dec 2017, Allen Samuels wrote:
>>
>> > Whew.
>> >
>> > Stay away from LSM. They optimize for developer time at the expense of run-time resource consumption.
>> >
>> > Allen Samuels
>> > R&D Engineering Fellow
>> >
>> > Western Digital(r)
>> > Email:  allen.samuels@wdc.com
>> > Office:  +1-408-801-7030
>> > Mobile: +1-408-780-6416
>> >
>> >
>> > -----Original Message-----
>> > From: Sage Weil [mailto:sweil@redhat.com]
>> > Sent: Thursday, December 21, 2017 8:41 AM
>> > To: Allen Samuels <Allen.Samuels@wdc.com>
>> > Subject: Re: New ObjectStore
>> >
>> > On Thu, 21 Dec 2017, Allen Samuels wrote:
>> > > w.r.t. today's discussion about a new ObjectStore. Moving the
>> > > fast-paths of the OSD into a reactive framework (SeaStar) is great and
>> > > will certainly improve performance significantly for small object I/O.
>> > >
>> > > However, IMO, using RocksDB (LSM) as a foundational building block is
>> > > a severely sub-optimal choice and will likely serve to severely limit
>> > > the performance boost that you'll achieve with the re-write. For
>> > > large-scale systems, I'm going to make a wild-speculation and suggest
>> > > that you won't see any actual throughput improvement from the
>> > > re-write, because the write-amp for metadata will end up being the
>> > > limiting factor - you'll have PLENTY of CPU that's idle waiting for
>> > > your I/O subsystem and end up running at the same speed as today.

Just a note, while this would obviously never be an endpoint, I would
consider that outcome a HUGE success. Idling CPUs mean fewer people
running into recovery cost inflation issues (and probably
better-scaling recovery from our having made everything discrete and
countable anyway), the ability to pack more drives into a single
system for better economics, etc. Let's not discourage ourselves from
climbing Mount Denali first just because we want to make it to Mt
Everest! ;)
-Greg

>> >
>> > Yeah, completely agree.. the seastar objectstore (SeaStore for maximum
>> > confusion) won't use rocksdb.  We're talking about the futures kv
>> > interface possibility as a glue layer to allow a mid-term
>> > semi-futures-based bluestore.  Not sure it'll make sense, but it's an
>> > option.
>> >
>> > So the new thing won't use rocksdb at all.  There don't appear to be
>> > any existing kv choices, but that's probably a good thing as it'll
>> > force us to build metadata capabilities specific to our needs.  That
>> > might be something LSM-ish, might not, I don't have a very clear
>> > picture of this yet (beyond that it should be log structured :).
>> >
>> > sage
>> >
>> >
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
