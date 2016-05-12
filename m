From: Sage Weil <sage@newdream.net>
Subject: RE: 2 related bluestore questions
Date: Wed, 11 May 2016 22:58:02 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605112249580.23446@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605091417590.336@cpach.fuggernut.com> <6168022b-e3c0-b8f2-e8c7-3b4b82f9dc6e@mirantis.com> <alpine.DEB.2.11.1605100841400.15518@cpach.fuggernut.com> <b6240191-0849-d60c-ebb6-147b5785e3e7@mirantis.com>
 <alpine.DEB.2.11.1605101121090.15518@cpach.fuggernut.com> <alpine.DEB.2.11.1605102105260.15518@cpach.fuggernut.com> <2b5ebbd8-3e89-1fff-37f1-c6eb00bdcb1a@mirantis.com> <alpine.DEB.2.11.1605110901551.15518@cpach.fuggernut.com> <8b077a20-ace3-7824-4039-7b8e9adf88ce@mirantis.com>
 <alpine.DEB.2.11.1605110951570.15518@cpach.fuggernut.com> <alpine.DEB.2.11.1605111636390.15518@cpach.fuggernut.com> <BLUPR0201MB152437E90BED4AE3CA22310EE8720@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58871 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbcELC5u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 22:57:50 -0400
In-Reply-To: <BLUPR0201MB152437E90BED4AE3CA22310EE8720@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Igor Fedotov <ifedotov@mirantis.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 11 May 2016, Allen Samuels wrote:
> Sorry, still on vacation and I haven't really wrapped my head around 
> everything that's being discussed. However, w.r.t. wal operations, I 
> would strongly favor an approach that minimizes the amount of "future" 
> operations that are recorded (which I'll call intentions -- i.e., 
> non-binding hints about extra work that needs to get done). Much of the 
> complexity here is because the intentions -- after being recorded -- 
> will need to be altered based on subsequent operations. Hence every 
> write operation will need to digest the historical intentions and 
> potentially update them -- this is VERY complex, potentially much more 
> complex than code that simply examines the current state and 
> re-determines the correct next operation (i.e., de-wal, gc, etc.)
> 
> Additional complexity arises because you're recording two sets of state 
> that require consistency checking -- in my experience, this road leads 
> to perdition....

I agree is has to be something manageable that we can reason about.  I
think the question for me is mostly about which path minimizes the 
complexity while still getting us a reasonable level of performance.

I had one new thought, see below...

> > > The downside is that any logically conflicting request (an overlapping
> > > write or truncate or zero) needs to drain the wal events, whereas with
> > > a lower-level wal description there might be cases where we can ignore
> > > the wal operation.  I suspect the trivial solution of o->flush() on
> > > write/truncate/zero will be pretty visible in benchmarks.  Tracking
> > > in-flight wal ops with an interval_set would probably work well enough.
> > 
> > Hmm, I'm not sure this will pan out.  The main problem is that if we call back
> > into the write code (with a sync flag), we will have to do write IO, and this
> > wreaks havoc on our otherwise (mostly) orderly state machine.
> > I think it can be done if we build in a similar guard like _txc_finish_io so that
> > we wait for the wal events to also complete IO in order before committing
> > them.  I think.
> > 
> > But the other problem is the checksum thing that came up in another thread,
> > where the read-side of a read/modify/write might fail teh checksum because
> > the wal write hit disk but the kv portion didn't commit. I see a few options:
> > 
> >  1) If there are checksums and we're doing a sub-block overwrite, we have to
> > write/cow it elsewhere.  This probably means min_alloc_size cow operations
> > for small writes.  In which case we needn't bother doing a wal even in the
> > first place--the whole point is to enable an overwrite.
> > 
> >  2) We do loose checksum validation that will accept either the old checksum
> > or the expected new checksum for the read stage.  This handles these two
> > crash cases:
> > 
> >  * kv commit of op + wal event
> >    <crash here, or>
> >  * do wal io (completely)
> >    <crash before cleaning up wal event>
> >  * kv cleanup of wal event
> > 
> > but not the case where we only partially complete the wal io.  Which means
> > there is a small probability is "corrupt" ourselves on crash (not really corrupt,
> > but confuse ourselves such that we refuse to replay the wal events on
> > startup).
> > 
> >  3) Same as 2, but simply warn if we fail that read-side checksum on replay.
> > This basically introduces a *very* small window which could allow an ondisk
> > corruption to get absorbed into our checksum.  This could just be #2 + a
> > config option so we warn instead of erroring out.
> > 
> >  4) Same as 2, but we try every combination of old and new data on
> > block/sector boundaries to find a valid checksum on the read-side.
> > 
> > I think #1 is a non-starter because it turns a 4K write into a 64K read + seek +
> > 64K write on an HDD.  Or forces us to run with min_alloc_size=4K on HDD,
> > which would risk very bad fragmentation.
> > 
> > Which makes we want #3 (initially) and then #4.  But... if we do the "wal is
> > just a logical write", that means this weird replay handling logic creeps into
> > the normal write path.
> > 
> > I'm currently leaning toward keeping the wal events special (lower-level), but
> > doing what we can to make it work with the same mid- to low-level helper
> > functions (for reading and verifying blobs, etc.).

It occured to me that this checksum consistency issue only comes up when 
we are updating something that is smaller than the csum block size.  And 
the real source of the problem is that you have a sequence of

 1- journal intent (kv wal item)
 2- do read io
 3- verify csum
 4- do write io
 5- cancel intent (remove kv wal item)

If we have an order like

 1- do read io
 2- journal intent for entire csum chunk (kv wal item)
 3- do write io
 4- cancel intent

Then the issue goes away.  And I'm thinking if the csum chunk is big 
enough that the #2 step is too big of a wal item to perform well, then the 
problem is your choice of csum block size, not the approach.  I.e., use a 
4kb csum block size for rbd images, and use large blocks (128k, 512k, 
whatever) only for things that never see random overwrites (rgw data).

If that is good enough, then it might also mean that we can make the wal 
operations never do reads--just (over)writes, further simplifying things 
on that end.  In the jewel bluestore the only times we do reads is for 
partial block updates (do we really care about these?  a buffer cache 
could absorb them when it matters) and for copy/cow operations post-clone 
(which i think are simple enough to be deal with separately).

sage
