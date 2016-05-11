From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: 2 related bluestore questions
Date: Wed, 11 May 2016 16:45:49 +0300
Message-ID: <8b077a20-ace3-7824-4039-7b8e9adf88ce@mirantis.com>
References: <alpine.DEB.2.11.1605091417590.336@cpach.fuggernut.com>
 <6168022b-e3c0-b8f2-e8c7-3b4b82f9dc6e@mirantis.com>
 <alpine.DEB.2.11.1605100841400.15518@cpach.fuggernut.com>
 <b6240191-0849-d60c-ebb6-147b5785e3e7@mirantis.com>
 <alpine.DEB.2.11.1605101121090.15518@cpach.fuggernut.com>
 <alpine.DEB.2.11.1605102105260.15518@cpach.fuggernut.com>
 <2b5ebbd8-3e89-1fff-37f1-c6eb00bdcb1a@mirantis.com>
 <alpine.DEB.2.11.1605110901551.15518@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33449 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbcEKNpx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 09:45:53 -0400
Received: by mail-lf0-f42.google.com with SMTP id y84so50195251lfc.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2016 06:45:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605110901551.15518@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: allen.samuels@sandisk.com, ceph-devel@vger.kernel.org


On 11.05.2016 16:10, Sage Weil wrote:
> On Wed, 11 May 2016, Igor Fedotov wrote:
>>> I took a stab at a revised wal_op_t here:
>>>
>>> 	https://github.com/liewegas/ceph/blob/wip-bluestore-write/src/os/bluestore/bluestore_types.h#L595-L605
>>>
>>> This is enough to implement the basic wal overwrite case here:
>>>
>>> 	https://github.com/liewegas/ceph/blob/wip-bluestore-write/src/os/bluestore/BlueStore.cc#L5522-L5578
>>>
>>> It's overkill for that, but something like this ought to be sufficiently
>>> general to express the more complicated wal (and compaction/gc/cleanup)
>>> operations, where we are reading bits of data from lots of different
>>> previous blobs, verifying checksums, and then assembling the results into
>>> a new buffer that gets written somewhere else.  The read_extent_map and
>>> write_map offsets are logical offsets in a buffer we assemble and then
>>> write to b_off~b_len in the specific blob.  I didn't get to the _do_wal_op
>>> part that actually does it, but it would do the final write, csum
>>> calculation, and metadata update.  Probably... the allocation would happen
>>> then too, if the specified blob didn't already have pextents.  Tha way
>>> we can do compression at that stage as well?
>>>
>>> What do you think?
>> Not completely sure that it's a good idea to have read stage description
>> stored in WAL record? Wouldn't that produce any conflicts/inconsistencies when
>> multiple WAL records deal with the same or close lextents and previous WAL
>> updates lextents to read. May be it's better to prepare such a description
>> exactly when WAL is applied? And WAL record to have just a basic write info?
> Yeah, I think this is a problem.  I see two basic paths:
>
>   - We do a wal flush before queueing a new wal event to avoid races like
> this. Or perhaps we only do it when the wal event(s) touch the same
> blob(s).  That's simple to reason about, but means that a series
> of small IOs to the same object (or blob) will serialize the kv commit and
> wal r/m/w operations.  (Note that this is no worse than the naive approach
> of doing the read part up front, and it only happens when you have
> successive wal ops on the same object (or blob)).
>
>   - We describe the wal read-side in terms of the current onode state.  For
> example, 'read object offset 0..100, use provided buffer for 100..4096,
> overwrite block'.  That can be pipelined.  But there are other
> operations that would require we flush the wal events, like a truncate or
> zero or other write that clobbers that region of the object.
> Maybe/hopefully in those cases we don't care (it no longer matters that
> this wal event do the write we originally intended) but we'd need
> to think pretty carefully about it.  FWIW, truncate already does an
> o->flush().
I'd prefer the second approach. Probably with some modification...
As far as I understand with the approach above you are trying to locate 
all write logic at a single place and have WAL machinery as a 
straightforward executor for already prepared tasks. Not sure this is 
beneficial enough. But definitely it's more complex and error-prone. And 
potentially you will need extend WAL machinery task description from 
time to time...
As an alternative one can eliminate that read description in WAL record 
at all. Let's simply record what loffset we are going to write to and 
data itself. Thus we have simple write request description.
And when WAL is applied corresponding code should determine how to do 
the write properly using the current lextent/blob maps state. This way 
Write Op apply can be just a regular write handling that performs sync 
RMW or any other implementation depending on the current state, some 
policy, or whatever else that fits the best at the specific moment.

>> And for GC/cleanup process this becomes even more important as the task
>> may be deferred for a while and lextent map may be significantly
>> altered.
> I get the feeling that the GC process can either (1) write new blobs in
> new locations and do an atomic transition, without interacting with the
> wal events at all, or (2) we just do the work once we committed to it. I
> think the potential benefit of committing to do wal work and then changing
> our mind is pretty small.
Yes that's probably true. My concern was regarding the attempt to 
describe GC tasks using wal_op struct with read description embedded. 
IMHO for GC that's even more inappropriate than for WAL as GC alters 
lextent map more massively.

>
>> And I suppose blob id should be 2 not 1 here:
>> https://github.com/liewegas/ceph/blob/wip-bluestore-write/src/os/bluestore/BlueStore.cc#L5545
> Ah, yes, thanks!
> sage

