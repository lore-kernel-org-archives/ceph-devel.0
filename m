From: Sage Weil <sage@newdream.net>
Subject: Re: 2 related bluestore questions
Date: Thu, 12 May 2016 13:09:56 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605121254410.23446@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605091417590.336@cpach.fuggernut.com> <b6240191-0849-d60c-ebb6-147b5785e3e7@mirantis.com> <alpine.DEB.2.11.1605101121090.15518@cpach.fuggernut.com> <alpine.DEB.2.11.1605102105260.15518@cpach.fuggernut.com>
 <2b5ebbd8-3e89-1fff-37f1-c6eb00bdcb1a@mirantis.com> <alpine.DEB.2.11.1605110901551.15518@cpach.fuggernut.com> <8b077a20-ace3-7824-4039-7b8e9adf88ce@mirantis.com> <alpine.DEB.2.11.1605110951570.15518@cpach.fuggernut.com> <alpine.DEB.2.11.1605111636390.15518@cpach.fuggernut.com>
 <BLUPR0201MB152437E90BED4AE3CA22310EE8720@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1605112249580.23446@cpach.fuggernut.com> <3403dbbc-9bf9-733f-1d4e-df66b5a2373d@mirantis.com> <alpine.DEB.2.11.1605121240060.23446@cpach.fuggernut.com>
 <17589c52-11d3-fed2-d0fd-05d38d8d9da7@mirantis.com> <alpine.DEB.2.11.1605121247520.23446@cpach.fuggernut.com> <5441ddd3-c37b-4594-632c-58aafd354fb6@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34061 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbcELRJn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2016 13:09:43 -0400
In-Reply-To: <5441ddd3-c37b-4594-632c-58aafd354fb6@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 12 May 2016, Igor Fedotov wrote:
> Well, it goes to the new space and updates all the maps.
> 
> Then WAL comes to action - where will it write? To the new location? And
> overwrite new data?

The the old location.  The modes I describe in the doc all are in terms of 
pextents (with the possible exception of E+F) for this reason... deferred 
IO, not deferred logical operations.

	https://github.com/liewegas/ceph/commit/c7cb76889669bf2c1abffd69f05d1c9e15c41e3c#commitcomment-17453409

For E+F, the source is always immutable (compressed blob or clone).  To 
avoid this sort of race on the destination... I'm not sure.  I'm sort of 
wondering, though, if we should even bother with the 'cow' part.  We used 
to have to do this because we didn't have a lextent mapping.  Now, if we 
have a small overwrite of a cloned/shared lextent/blob, we can

 - allocate a new min_alloc_size blob
 - write the new data into the relevant block in that blob
 - update lextent_t map *only for those bytes*

There's not write- or read-amp that way, and if we later get more random 
overwrites nearby they can just fill in the other unused parts of the blob 
and eventually the lextent mapping will merge/simplify to reference the 
whole thing.  (I'm assuming that if we wrote at, say, object offset 68k 
and min_alloc_size is 64k, we'd write at offset 4k in the new 64k blob, so 
that later when adjacent blocks get filled in it would be contiguous.)

Anyway, that would be *no* copy/cow type wal events at all.  The only 
read-like thing that would remain would be C, which is a pretty trivial 
case (no csum, no comp, just a read/modify/write of a partial block.)  I 
think it also means that no wal events would need to do metadata (csum) 
updates after all.

I pushed an update to that doc:

	https://github.com/liewegas/ceph/blob/76ab431ec2aed0b90f2f0354d89f4bccd23e7ae2/doc/dev/bluestore.rst

The D case may or may not be worth it.  It's nice for efficient small 
overwrites of big compressed blobs.  OTOH, E accomplishes the same thing 
at the expense of using a bit more disk space.  (For SSDs, E won't matter, 
since min_alloc_size would be 4K anyway.)

sage



> 
> 
> On 12.05.2016 19:48, Sage Weil wrote:
> > On Thu, 12 May 2016, Igor Fedotov wrote:
> > > The second write in my example isn't processed through WAL - it's large
> > > and
> > > overwrites the whole blob...
> > If it's large, it wouldn't overwrite--it would go to newly allocated
> > space.  We can *never* overwrite without wal or else we corrupt previous
> > data...
> > 
> > sage
> > 
> > 
> > > 
> > > On 12.05.2016 19:43, Sage Weil wrote:
> > > > On Thu, 12 May 2016, Igor Fedotov wrote:
> > > > > Yet another potential issue with WAL I can imagine:
> > > > > 
> > > > > Let's have some small write going to WAL followed by an larger aligned
> > > > > overwrite to the same extent that bypasses WAL. Is it possible if the
> > > > > first
> > > > > write is processed later and overwrites the second one? I think so.
> > > > Yeah, that would be chaos.  The wal ops are already ordered by the
> > > > sequencer (or ordered globally, if bluestore_sync_wal_apply=true), so
> > > > this
> > > > can't happen.
> > > > 
> > > > sage
> > > > 
> > > > 
> > > > > This way we can probably come to the conclusion that all requests
> > > > > should
> > > > > be
> > > > > processed in-sequence. One should prohibit multiple flows for requests
> > > > > processing as this may eliminate their order.
> > > > > 
> > > > > Yeah - I'm attacking WAL concept this way...
> > > > > 
> > > > > 
> > > > > Thanks,
> > > > > Igor
> > > > > 
> > > > > On 12.05.2016 5:58, Sage Weil wrote:
> > > > > > On Wed, 11 May 2016, Allen Samuels wrote:
> > > > > > > Sorry, still on vacation and I haven't really wrapped my head
> > > > > > > around
> > > > > > > everything that's being discussed. However, w.r.t. wal operations,
> > > > > > > I
> > > > > > > would strongly favor an approach that minimizes the amount of
> > > > > > > "future"
> > > > > > > operations that are recorded (which I'll call intentions -- i.e.,
> > > > > > > non-binding hints about extra work that needs to get done). Much
> > > > > > > of
> > > > > > > the
> > > > > > > complexity here is because the intentions -- after being recorded
> > > > > > > --
> > > > > > > will need to be altered based on subsequent operations. Hence
> > > > > > > every
> > > > > > > write operation will need to digest the historical intentions and
> > > > > > > potentially update them -- this is VERY complex, potentially much
> > > > > > > more
> > > > > > > complex than code that simply examines the current state and
> > > > > > > re-determines the correct next operation (i.e., de-wal, gc, etc.)
> > > > > > > 
> > > > > > > Additional complexity arises because you're recording two sets of
> > > > > > > state
> > > > > > > that require consistency checking -- in my experience, this road
> > > > > > > leads
> > > > > > > to perdition....
> > > > > > I agree is has to be something manageable that we can reason about.
> > > > > > I
> > > > > > think the question for me is mostly about which path minimizes the
> > > > > > complexity while still getting us a reasonable level of performance.
> > > > > > 
> > > > > > I had one new thought, see below...
> > > > > > 
> > > > > > > > > The downside is that any logically conflicting request (an
> > > > > > > > > overlapping
> > > > > > > > > write or truncate or zero) needs to drain the wal events,
> > > > > > > > > whereas
> > > > > > > > > with
> > > > > > > > > a lower-level wal description there might be cases where we
> > > > > > > > > can
> > > > > > > > > ignore
> > > > > > > > > the wal operation.  I suspect the trivial solution of
> > > > > > > > > o->flush()
> > > > > > > > > on
> > > > > > > > > write/truncate/zero will be pretty visible in benchmarks.
> > > > > > > > > Tracking
> > > > > > > > > in-flight wal ops with an interval_set would probably work
> > > > > > > > > well
> > > > > > > > > enough.
> > > > > > > > Hmm, I'm not sure this will pan out.  The main problem is that
> > > > > > > > if we
> > > > > > > > call back
> > > > > > > > into the write code (with a sync flag), we will have to do write
> > > > > > > > IO,
> > > > > > > > and
> > > > > > > > this
> > > > > > > > wreaks havoc on our otherwise (mostly) orderly state machine.
> > > > > > > > I think it can be done if we build in a similar guard like
> > > > > > > > _txc_finish_io so that
> > > > > > > > we wait for the wal events to also complete IO in order before
> > > > > > > > committing
> > > > > > > > them.  I think.
> > > > > > > > 
> > > > > > > > But the other problem is the checksum thing that came up in
> > > > > > > > another
> > > > > > > > thread,
> > > > > > > > where the read-side of a read/modify/write might fail teh
> > > > > > > > checksum
> > > > > > > > because
> > > > > > > > the wal write hit disk but the kv portion didn't commit. I see a
> > > > > > > > few
> > > > > > > > options:
> > > > > > > > 
> > > > > > > >     1) If there are checksums and we're doing a sub-block
> > > > > > > > overwrite,
> > > > > > > > we
> > > > > > > > have to
> > > > > > > > write/cow it elsewhere.  This probably means min_alloc_size cow
> > > > > > > > operations
> > > > > > > > for small writes.  In which case we needn't bother doing a wal
> > > > > > > > even
> > > > > > > > in
> > > > > > > > the
> > > > > > > > first place--the whole point is to enable an overwrite.
> > > > > > > > 
> > > > > > > >     2) We do loose checksum validation that will accept either
> > > > > > > > the
> > > > > > > > old
> > > > > > > > checksum
> > > > > > > > or the expected new checksum for the read stage.  This handles
> > > > > > > > these
> > > > > > > > two
> > > > > > > > crash cases:
> > > > > > > > 
> > > > > > > >     * kv commit of op + wal event
> > > > > > > >       <crash here, or>
> > > > > > > >     * do wal io (completely)
> > > > > > > >       <crash before cleaning up wal event>
> > > > > > > >     * kv cleanup of wal event
> > > > > > > > 
> > > > > > > > but not the case where we only partially complete the wal io.
> > > > > > > > Which
> > > > > > > > means
> > > > > > > > there is a small probability is "corrupt" ourselves on crash
> > > > > > > > (not
> > > > > > > > really
> > > > > > > > corrupt,
> > > > > > > > but confuse ourselves such that we refuse to replay the wal
> > > > > > > > events
> > > > > > > > on
> > > > > > > > startup).
> > > > > > > > 
> > > > > > > >     3) Same as 2, but simply warn if we fail that read-side
> > > > > > > > checksum
> > > > > > > > on
> > > > > > > > replay.
> > > > > > > > This basically introduces a *very* small window which could
> > > > > > > > allow an
> > > > > > > > ondisk
> > > > > > > > corruption to get absorbed into our checksum.  This could just
> > > > > > > > be #2
> > > > > > > > + a
> > > > > > > > config option so we warn instead of erroring out.
> > > > > > > > 
> > > > > > > >     4) Same as 2, but we try every combination of old and new
> > > > > > > > data on
> > > > > > > > block/sector boundaries to find a valid checksum on the
> > > > > > > > read-side.
> > > > > > > > 
> > > > > > > > I think #1 is a non-starter because it turns a 4K write into a
> > > > > > > > 64K
> > > > > > > > read
> > > > > > > > + seek +
> > > > > > > > 64K write on an HDD.  Or forces us to run with min_alloc_size=4K
> > > > > > > > on
> > > > > > > > HDD,
> > > > > > > > which would risk very bad fragmentation.
> > > > > > > > 
> > > > > > > > Which makes we want #3 (initially) and then #4.  But... if we do
> > > > > > > > the
> > > > > > > > "wal is
> > > > > > > > just a logical write", that means this weird replay handling
> > > > > > > > logic
> > > > > > > > creeps into
> > > > > > > > the normal write path.
> > > > > > > > 
> > > > > > > > I'm currently leaning toward keeping the wal events special
> > > > > > > > (lower-level), but
> > > > > > > > doing what we can to make it work with the same mid- to
> > > > > > > > low-level
> > > > > > > > helper
> > > > > > > > functions (for reading and verifying blobs, etc.).
> > > > > > It occured to me that this checksum consistency issue only comes up
> > > > > > when
> > > > > > we are updating something that is smaller than the csum block size.
> > > > > > And
> > > > > > the real source of the problem is that you have a sequence of
> > > > > > 
> > > > > >     1- journal intent (kv wal item)
> > > > > >     2- do read io
> > > > > >     3- verify csum
> > > > > >     4- do write io
> > > > > >     5- cancel intent (remove kv wal item)
> > > > > > 
> > > > > > If we have an order like
> > > > > > 
> > > > > >     1- do read io
> > > > > >     2- journal intent for entire csum chunk (kv wal item)
> > > > > >     3- do write io
> > > > > >     4- cancel intent
> > > > > > 
> > > > > > Then the issue goes away.  And I'm thinking if the csum chunk is big
> > > > > > enough that the #2 step is too big of a wal item to perform well,
> > > > > > then
> > > > > > the
> > > > > > problem is your choice of csum block size, not the approach.  I.e.,
> > > > > > use
> > > > > > a
> > > > > > 4kb csum block size for rbd images, and use large blocks (128k,
> > > > > > 512k,
> > > > > > whatever) only for things that never see random overwrites (rgw
> > > > > > data).
> > > > > > 
> > > > > > If that is good enough, then it might also mean that we can make the
> > > > > > wal
> > > > > > operations never do reads--just (over)writes, further simplifying
> > > > > > things
> > > > > > on that end.  In the jewel bluestore the only times we do reads is
> > > > > > for
> > > > > > partial block updates (do we really care about these?  a buffer
> > > > > > cache
> > > > > > could absorb them when it matters) and for copy/cow operations
> > > > > > post-clone
> > > > > > (which i think are simple enough to be deal with separately).
> > > > > > 
> > > > > > sage
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > > > in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > > 
> > > > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> 
> 
