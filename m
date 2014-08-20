From: Sage Weil <sweil@redhat.com>
Subject: Re: OSDMap checksums
Date: Tue, 19 Aug 2014 17:32:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408191723440.28244@cobra.newdream.net>
References: <alpine.DEB.2.00.1408191528070.28247@cobra.newdream.net> <CAPYLRziaU2R57axjLVmkSX6P7F9gwHhwHMBtHgmVq0a2pd=P3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37435 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbaHTAcH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Aug 2014 20:32:07 -0400
In-Reply-To: <CAPYLRziaU2R57axjLVmkSX6P7F9gwHhwHMBtHgmVq0a2pd=P3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 19 Aug 2014, Gregory Farnum wrote:
> On Tue, Aug 19, 2014 at 3:43 PM, Sage Weil <sweil@redhat.com> wrote:
> > We have had a range of bugs come up in the past because OSDs or mons have
> > been running different versions of the code and have encoded different
> > variations of the same OSDMap epoch.  When two nodes in the system
> > disagree about what the data distribution is, all manner of things can go
> > wrong and the effects are very difficult to debug.
> >
> > Several times we've said that we should be adding a crc or checksum to the
> > canonical encoded OSDMap so that we'll know if we're getting the "right"
> > version or not.  One could imagine in a less trusted environment this
> > would be analogous to a signed version.
> >
> > I've started a wip-osdmap branch to do this, but have hit a few bumps.
> >
> > Generally speaking, we want only the mons (and only the leader mon) to
> > ever be allowed to encode (and checksum/sign) a new OSDMap or incremental.
> > (The only real exception here is that the MOSDMap message reencodes maps
> > with older encoding strategies for old clients, but those old clients
> > clearly won't support the new crc, so they get a free pass.)
> >
> > The trouble is that in general we share maps very liberally.  More
> > specifically, we share _incremental_ maps.  The incremental map will be
> > encoded so that it itself has a crc, and also it has the crc of what the
> > final OSDMap will have once the incremental has been applied, so that you
> > can verify you got the right answer.
> >
> > The problem is what to do if you don't.  This can happen for a few
> > different reasons, but usually it is just that we added a field to a data
> > structure that is included in the OSDMap.
> >
> > The main entity affected by this is the OSDs: they store a history of
> > incremntal maps *and* full maps, and share full and incremental maps with
> > clients and peers.  We don't want them to ever share a full map that did
> > not match the specified crc as it might different from the canonical
> > version in some subtle (but problematic) way.
> >
> > A simple strategy would be to simply go back to the mons if we ever run
> > into this and ask for original (full) copies of the OSDMaps whose
> > encodings we got wrong.  This works, but has a few potential problems:
> >
> >  - The general "upgrade mons first" strategy will mean mons will start
> > generating maps that older osds can't replicate, and suddently every will
> > be hammering them for full maps.
> >  - We could ask our peers, but there's no guarantee that they will be any
> > better off.
> >
> > We could:
> >
> >  - Have users upgrade OSDs before mons.  That way no 'new' osdmaps will
> > get generated before the osds are able to reencode them correctly.
> >  - Make the osd peers smarter about how they share maps with each other so
> > that they can also tell when they need full maps and not just
> > incrementals.
> >
> > ...or perhaps both.  The former avoids the problem, the latter copes with
> > it.  I'm a bit unsure how to do make the latter algorithm simple (mostly
> > stateless) and efficient, though.
> >
> > Any other ideas?
> 
> How stateless do we need it to be? I don't remember all the details of
> how OSDs generate their incrementals for sharing, but:
> 1) Going forward, we can make sure that OSDs share full maps (or
> Incrementals that they've received from the monitor instead of
> self-generated) whenever they didn't make use of all the data in the
> encoded bufferlist (or, perhaps, based on some supported feature bits
> in the OSDMap itself?)

I'd planned on doing a check after we receive and apply an incremental 
where we reencode our map and compare the crc to the one in the 
incremental.  If it doesn't match, we will know there is a problem.

> 2) We can set up OSDs so that they query the monitor (or, optionally,
> a peer with a sufficient set of feature bits?) whenever they see a
> checksum that doesn't match what they generate (...and eventually, do
> something more to check their prior maps?)

There isn't necessarily a 1:1 mapping onto feature bits.  We might add 
fields to encodable data structures that will subtley get reset to the 
default by older code.  Only if we plan on relying on us being very 
careful could we get away with feature bits...  That said, it would make 
our lives easier, because the mon could encode the map using the feature 
bits supported by all osds.  Only after they all restart will new stuff 
kick in.  (We probably want to do that anyway).  But I still worry 
think it would be nice to guarantee we have a bit-for-bit accurate 
version of the osdmap before we ever use or share it.

In any case, though, the problem is that we will eventaully reach a 
point where we just received an incremental and realized that it leads to 
a new OSDMap that we can't accurately recreate.  What do we do?  
Obviously, we throw it on the floor.  We could ask a mons, but that means 
overwhelming them.  We could ask every peer, but that means we get 100x 
copies of the full osdmap (which may be big).  We could ask 1 (or a small 
number of) peer(s), but then we need to have a semi-stateful thing that 
handles the case where that peer doesn't have it and we move on to ask 
someone else, maybe increase the breadth of our search, and when all else 
fails eventually give up and ask the mon.

> 3) We can set the monitors not to generate checksums until all the
> OSDs are actually updated to understand them at this first switchover
> point (which will prevent the OSDs from querying the monitors en masse
> on upgrade).
> 
> Is that insufficient? My recollection is that OSDs tend to regenerate
> the incrementals (based on cached full maps) rather than sending over
> the encoded bufferlists they received from the monitor, and that this
> is the real issue (because otherwise we wouldn't ever be losing data).

It's the other way around.  Generally the OSDs only ever get incrementals, 
and they apply those to generate full maps (and save them for future use).  
There isn't actually a way to recreate an incremental.

sage

