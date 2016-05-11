From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: 2 related bluestore questions
Date: Wed, 11 May 2016 21:38:04 +0000
Message-ID: <BLUPR0201MB152437E90BED4AE3CA22310EE8720@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1605091417590.336@cpach.fuggernut.com>
 <6168022b-e3c0-b8f2-e8c7-3b4b82f9dc6e@mirantis.com>
 <alpine.DEB.2.11.1605100841400.15518@cpach.fuggernut.com>
 <b6240191-0849-d60c-ebb6-147b5785e3e7@mirantis.com>
 <alpine.DEB.2.11.1605101121090.15518@cpach.fuggernut.com>
 <alpine.DEB.2.11.1605102105260.15518@cpach.fuggernut.com>
 <2b5ebbd8-3e89-1fff-37f1-c6eb00bdcb1a@mirantis.com>
 <alpine.DEB.2.11.1605110901551.15518@cpach.fuggernut.com>
 <8b077a20-ace3-7824-4039-7b8e9adf88ce@mirantis.com>
 <alpine.DEB.2.11.1605110951570.15518@cpach.fuggernut.com>
 <alpine.DEB.2.11.1605111636390.15518@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0054.outbound.protection.outlook.com ([65.55.169.54]:55808
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751766AbcEKViH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 17:38:07 -0400
In-Reply-To: <alpine.DEB.2.11.1605111636390.15518@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sorry, still on vacation and I haven't really wrapped my head around everything that's being discussed. However, w.r.t. wal operations, I would strongly favor an approach that minimizes the amount of "future" operations that are recorded (which I'll call intentions -- i.e., non-binding hints about extra work that needs to get done). Much of the complexity here is because the intentions -- after being recorded -- will need to be altered based on subsequent operations. Hence every write operation will need to digest the historical intentions and potentially update them -- this is VERY complex, potentially much more complex than code that simply examines the current state and re-determines the correct next operation (i.e., de-wal, gc, etc.)

Additional complexity arises because you're recording two sets of state that require consistency checking -- in my experience, this road leads to perdition....

Maybe I've missed something critical (vacation-headed) if so, please ignore.


Allen Samuels
Software Architect, Fellow, Systems and Software Solutions 

2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Thursday, May 12, 2016 6:54 AM
> To: Igor Fedotov <ifedotov@mirantis.com>
> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; ceph-
> devel@vger.kernel.org
> Subject: Re: 2 related bluestore questions
> 
> On Wed, 11 May 2016, Sage Weil wrote:
> > On Wed, 11 May 2016, Igor Fedotov wrote:
> > > On 11.05.2016 16:10, Sage Weil wrote:
> > > > On Wed, 11 May 2016, Igor Fedotov wrote:
> > > > > > I took a stab at a revised wal_op_t here:
> > > > > >
> > > > > >
> > > > > > https://github.com/liewegas/ceph/blob/wip-bluestore-write/src/
> > > > > > os/bluestore/bluestore_types.h#L595-L605
> > > > > >
> > > > > > This is enough to implement the basic wal overwrite case here:
> > > > > >
> > > > > >
> > > > > > https://github.com/liewegas/ceph/blob/wip-bluestore-write/src/
> > > > > > os/bluestore/BlueStore.cc#L5522-L5578
> > > > > >
> > > > > > It's overkill for that, but something like this ought to be
> > > > > > sufficiently general to express the more complicated wal (and
> > > > > > compaction/gc/cleanup) operations, where we are reading bits
> > > > > > of data from lots of different previous blobs, verifying
> > > > > > checksums, and then assembling the results into a new buffer
> > > > > > that gets written somewhere else.  The read_extent_map and
> > > > > > write_map offsets are logical offsets in a buffer we assemble
> > > > > > and then write to b_off~b_len in the specific blob.  I didn't
> > > > > > get to the _do_wal_op part that actually does it, but it would
> > > > > > do the final write, csum calculation, and metadata update.
> > > > > > Probably... the allocation would happen then too, if the
> > > > > > specified blob didn't already have pextents.  Tha way we can
> > > > > > do compression at that stage as well?
> > > > > >
> > > > > > What do you think?
> > > > > Not completely sure that it's a good idea to have read stage
> > > > > description stored in WAL record? Wouldn't that produce any
> > > > > conflicts/inconsistencies when multiple WAL records deal with
> > > > > the same or close lextents and previous WAL updates lextents to
> > > > > read. May be it's better to prepare such a description exactly
> > > > > when WAL is applied? And WAL record to have just a basic write
> > > > > info?
> > > > Yeah, I think this is a problem.  I see two basic paths:
> > > >
> > > >   - We do a wal flush before queueing a new wal event to avoid
> > > > races like this. Or perhaps we only do it when the wal event(s)
> > > > touch the same blob(s).  That's simple to reason about, but means
> > > > that a series of small IOs to the same object (or blob) will
> > > > serialize the kv commit and wal r/m/w operations.  (Note that this
> > > > is no worse than the naive approach of doing the read part up
> > > > front, and it only happens when you have successive wal ops on the
> same object (or blob)).
> > > >
> > > >   - We describe the wal read-side in terms of the current onode
> > > > state.  For example, 'read object offset 0..100, use provided
> > > > buffer for 100..4096, overwrite block'.  That can be pipelined.
> > > > But there are other operations that would require we flush the wal
> > > > events, like a truncate or zero or other write that clobbers that region
> of the object.
> > > > Maybe/hopefully in those cases we don't care (it no longer matters
> > > > that this wal event do the write we originally intended) but we'd
> > > > need to think pretty carefully about it.  FWIW, truncate already
> > > > does an
> > > > o->flush().
> > > I'd prefer the second approach. Probably with some modification...
> > > As far as I understand with the approach above you are trying to
> > > locate all write logic at a single place and have WAL machinery as a
> > > straightforward executor for already prepared tasks. Not sure this
> > > is beneficial enough. But definitely it's more complex and
> > > error-prone. And potentially you will need extend WAL machinery task
> description from time to time...
> > > As an alternative one can eliminate that read description in WAL
> > > record at all. Let's simply record what loffset we are going to
> > > write to and data itself. Thus we have simple write request description.
> > > And when WAL is applied corresponding code should determine how to
> > > do the write properly using the current lextent/blob maps state.
> > > This way Write Op apply can be just a regular write handling that
> > > performs sync RMW or any other implementation depending on the
> > > current state, some policy, or whatever else that fits the best at the
> specific moment.
> >
> > I like that way better!  We can just add a force_sync argument to
> > _do_write.  That also lets us trivially disable wal (by forcing sync
> > w/ a config option or whatever).
> >
> > The downside is that any logically conflicting request (an overlapping
> > write or truncate or zero) needs to drain the wal events, whereas with
> > a lower-level wal description there might be cases where we can ignore
> > the wal operation.  I suspect the trivial solution of o->flush() on
> > write/truncate/zero will be pretty visible in benchmarks.  Tracking
> > in-flight wal ops with an interval_set would probably work well enough.
> 
> Hmm, I'm not sure this will pan out.  The main problem is that if we call back
> into the write code (with a sync flag), we will have to do write IO, and this
> wreaks havoc on our otherwise (mostly) orderly state machine.
> I think it can be done if we build in a similar guard like _txc_finish_io so that
> we wait for the wal events to also complete IO in order before committing
> them.  I think.
> 
> But the other problem is the checksum thing that came up in another thread,
> where the read-side of a read/modify/write might fail teh checksum because
> the wal write hit disk but the kv portion didn't commit. I see a few options:
> 
>  1) If there are checksums and we're doing a sub-block overwrite, we have to
> write/cow it elsewhere.  This probably means min_alloc_size cow operations
> for small writes.  In which case we needn't bother doing a wal even in the
> first place--the whole point is to enable an overwrite.
> 
>  2) We do loose checksum validation that will accept either the old checksum
> or the expected new checksum for the read stage.  This handles these two
> crash cases:
> 
>  * kv commit of op + wal event
>    <crash here, or>
>  * do wal io (completely)
>    <crash before cleaning up wal event>
>  * kv cleanup of wal event
> 
> but not the case where we only partially complete the wal io.  Which means
> there is a small probability is "corrupt" ourselves on crash (not really corrupt,
> but confuse ourselves such that we refuse to replay the wal events on
> startup).
> 
>  3) Same as 2, but simply warn if we fail that read-side checksum on replay.
> This basically introduces a *very* small window which could allow an ondisk
> corruption to get absorbed into our checksum.  This could just be #2 + a
> config option so we warn instead of erroring out.
> 
>  4) Same as 2, but we try every combination of old and new data on
> block/sector boundaries to find a valid checksum on the read-side.
> 
> I think #1 is a non-starter because it turns a 4K write into a 64K read + seek +
> 64K write on an HDD.  Or forces us to run with min_alloc_size=4K on HDD,
> which would risk very bad fragmentation.
> 
> Which makes we want #3 (initially) and then #4.  But... if we do the "wal is
> just a logical write", that means this weird replay handling logic creeps into
> the normal write path.
> 
> I'm currently leaning toward keeping the wal events special (lower-level), but
> doing what we can to make it work with the same mid- to low-level helper
> functions (for reading and verifying blobs, etc.).
> 
> sage
