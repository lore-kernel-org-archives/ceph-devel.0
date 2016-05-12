From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: 2 related bluestore questions
Date: Thu, 12 May 2016 11:54:33 +0000
Message-ID: <BLUPR0201MB152476A72C243279DEEEA8A1E8730@BLUPR0201MB1524.namprd02.prod.outlook.com>
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
 <BLUPR0201MB152437E90BED4AE3CA22310EE8720@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1605112249580.23446@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0055.outbound.protection.outlook.com ([65.55.169.55]:62304
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752216AbcELLyg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2016 07:54:36 -0400
In-Reply-To: <alpine.DEB.2.11.1605112249580.23446@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Igor Fedotov <ifedotov@mirantis.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ok, I hope I'm starting to understand. 

The real source of the problem is the desire to "write in place". The kv wal item (intention) and the associated complexity are associated with the need to recognize that a chunk may have an incorrect checksum for a transient period of time because of an in-place update operation.

One simple solution to this is to eliminate write-in-place. You're already reading a bunch of data, computing the new checksums and then writing out the correct data. If you cow the write, then all of the torn page stuff goes away and you cut down the number of kv updates significantly (no intention is required, only a single kv update is required for the entire cow process). Then the only thing that's required to make this perform more or less equivalent to the complicated logic that you're dealing with now is to make sure that the COW destination location is "close" to the original source data location. Basically, you'll want to modify the allocation algorithm so as to leave some "space" in each cylinder so that the COW destination can always be close to the source (you only need a few p
 er cylinder since each COW frees up another one). This is a tiny bit ugly, but much much simpler than all of the machinations that you're going through now. 

I would point out that one important optimization is to do a good job of handling append log files. These will look like multiple-write-in-places that will have to get merged. I believe that this optimization is particularly easy to handle with the COW approach that I described.

I would point out that nothing prevents an addition of a non-COW update-in-place at a future time. 

Allen Samuels
Software Architect, Fellow, Systems and Software Solutions 

2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com

> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Thursday, May 12, 2016 12:58 PM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: Igor Fedotov <ifedotov@mirantis.com>; ceph-devel@vger.kernel.org
> Subject: RE: 2 related bluestore questions
> 
> On Wed, 11 May 2016, Allen Samuels wrote:
> > Sorry, still on vacation and I haven't really wrapped my head around
> > everything that's being discussed. However, w.r.t. wal operations, I
> > would strongly favor an approach that minimizes the amount of "future"
> > operations that are recorded (which I'll call intentions -- i.e.,
> > non-binding hints about extra work that needs to get done). Much of
> > the complexity here is because the intentions -- after being recorded
> > -- will need to be altered based on subsequent operations. Hence every
> > write operation will need to digest the historical intentions and
> > potentially update them -- this is VERY complex, potentially much more
> > complex than code that simply examines the current state and
> > re-determines the correct next operation (i.e., de-wal, gc, etc.)
> >
> > Additional complexity arises because you're recording two sets of
> > state that require consistency checking -- in my experience, this road
> > leads to perdition....
> 
> I agree is has to be something manageable that we can reason about.  I think
> the question for me is mostly about which path minimizes the complexity
> while still getting us a reasonable level of performance.
> 
> I had one new thought, see below...
> 
> > > > The downside is that any logically conflicting request (an
> > > > overlapping write or truncate or zero) needs to drain the wal
> > > > events, whereas with a lower-level wal description there might be
> > > > cases where we can ignore the wal operation.  I suspect the
> > > > trivial solution of o->flush() on write/truncate/zero will be
> > > > pretty visible in benchmarks.  Tracking in-flight wal ops with an
> interval_set would probably work well enough.
> > >
> > > Hmm, I'm not sure this will pan out.  The main problem is that if we
> > > call back into the write code (with a sync flag), we will have to do
> > > write IO, and this wreaks havoc on our otherwise (mostly) orderly state
> machine.
> > > I think it can be done if we build in a similar guard like
> > > _txc_finish_io so that we wait for the wal events to also complete
> > > IO in order before committing them.  I think.
> > >
> > > But the other problem is the checksum thing that came up in another
> > > thread, where the read-side of a read/modify/write might fail teh
> > > checksum because the wal write hit disk but the kv portion didn't commit.
> I see a few options:
> > >
> > >  1) If there are checksums and we're doing a sub-block overwrite, we
> > > have to write/cow it elsewhere.  This probably means min_alloc_size
> > > cow operations for small writes.  In which case we needn't bother
> > > doing a wal even in the first place--the whole point is to enable an
> overwrite.
> > >
> > >  2) We do loose checksum validation that will accept either the old
> > > checksum or the expected new checksum for the read stage.  This
> > > handles these two crash cases:
> > >
> > >  * kv commit of op + wal event
> > >    <crash here, or>
> > >  * do wal io (completely)
> > >    <crash before cleaning up wal event>
> > >  * kv cleanup of wal event
> > >
> > > but not the case where we only partially complete the wal io.  Which
> > > means there is a small probability is "corrupt" ourselves on crash
> > > (not really corrupt, but confuse ourselves such that we refuse to
> > > replay the wal events on startup).
> > >
> > >  3) Same as 2, but simply warn if we fail that read-side checksum on
> replay.
> > > This basically introduces a *very* small window which could allow an
> > > ondisk corruption to get absorbed into our checksum.  This could
> > > just be #2 + a config option so we warn instead of erroring out.
> > >
> > >  4) Same as 2, but we try every combination of old and new data on
> > > block/sector boundaries to find a valid checksum on the read-side.
> > >
> > > I think #1 is a non-starter because it turns a 4K write into a 64K
> > > read + seek + 64K write on an HDD.  Or forces us to run with
> > > min_alloc_size=4K on HDD, which would risk very bad fragmentation.
> > >
> > > Which makes we want #3 (initially) and then #4.  But... if we do the
> > > "wal is just a logical write", that means this weird replay handling
> > > logic creeps into the normal write path.
> > >
> > > I'm currently leaning toward keeping the wal events special
> > > (lower-level), but doing what we can to make it work with the same
> > > mid- to low-level helper functions (for reading and verifying blobs, etc.).
> 
> It occured to me that this checksum consistency issue only comes up when
> we are updating something that is smaller than the csum block size.  And the
> real source of the problem is that you have a sequence of
> 
>  1- journal intent (kv wal item)
>  2- do read io
>  3- verify csum
>  4- do write io
>  5- cancel intent (remove kv wal item)
> 
> If we have an order like
> 
>  1- do read io
>  2- journal intent for entire csum chunk (kv wal item)
>  3- do write io
>  4- cancel intent
> 
> Then the issue goes away.  And I'm thinking if the csum chunk is big enough
> that the #2 step is too big of a wal item to perform well, then the problem is
> your choice of csum block size, not the approach.  I.e., use a 4kb csum block
> size for rbd images, and use large blocks (128k, 512k,
> whatever) only for things that never see random overwrites (rgw data).
> 
> If that is good enough, then it might also mean that we can make the wal
> operations never do reads--just (over)writes, further simplifying things on
> that end.  In the jewel bluestore the only times we do reads is for partial
> block updates (do we really care about these?  a buffer cache could absorb
> them when it matters) and for copy/cow operations post-clone (which i think
> are simple enough to be deal with separately).
> 
> sage
