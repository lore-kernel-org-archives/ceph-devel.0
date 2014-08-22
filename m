From: Sage Weil <sweil@redhat.com>
Subject: Re: OSDMap checksums
Date: Thu, 21 Aug 2014 17:38:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408211709300.31169@cobra.newdream.net>
References: <alpine.DEB.2.00.1408191528070.28247@cobra.newdream.net> <CAPYLRziaU2R57axjLVmkSX6P7F9gwHhwHMBtHgmVq0a2pd=P3g@mail.gmail.com> <alpine.DEB.2.00.1408191723440.28244@cobra.newdream.net> <CAPYLRzioYDorFaruE5nnQgVZrxC9vDckT6Et6KmWhFaYt4fszw@mail.gmail.com>
 <alpine.DEB.2.00.1408192139210.28244@cobra.newdream.net> <CAPYLRzgU_vmOZVoGcnmVNch=adkd4WmUZbjYJ1E8JVDDrHj81Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49871 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648AbaHVAif (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 20:38:35 -0400
In-Reply-To: <CAPYLRzgU_vmOZVoGcnmVNch=adkd4WmUZbjYJ1E8JVDDrHj81Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 19 Aug 2014, Gregory Farnum wrote:
> As far as I can tell, checksumming incrementals are good for two
> things besides detecting bit flips:
> 1) It's easy to extend to signing the Incremental, which is more secure
> 2) It protects against accidental divergence like we saw when we added
> the extra heartbeat IP fields

Thinking back, the last time we really screwed this up was

	http://tracker.ceph.com/issues/8738

where the mons were distributing two versions of OSDMaps with different 
crush tunable values encoded.  This was because they were encoding the 
full maps locally and didn't all do it the same way (because we weren't 
doing the right feature checks there).  That bug is fixed, of course, but 
I'd like to have assurance that we won't hit similar ones--this was far 
from the first time something like this has happened.  Having the OSDs 
generate full maps locally is another tier down but essentially the same 
problem.  Any manner of bugs could lead to violating the critical 
invariant and we would be none the wiser.

> Trying to get anything more out of it seems like attacking a problem
> at very much the wrong layer.

I don't think that this is so much the solution to the problem as 
insurance that if we miss something it won't cause irreparable damage.

Here's the branch I have so far:

	https://github.com/ceph/ceph/pull/2300

The thing I was missing (and just added) is validation of the full OSDMap 
crc in the monitor.  I think it is actually much harder to cope with in 
the mon, though.  I think our only real option there is to assert.  Not 
graceful, but it means we did something wrong by generating an incremental 
that not all mons (let alone OSDs) could rebuild.  The OSDs, OTOH, can 
request pristine maps from the mon if they need them.

We could make a distinction between OSDMaps that vary in encoding but not 
mapping, but I worry that is going to make things overly complex.  We get 
a lot of certainty with a crc over the whole thing.  OTOH, it means that 
adding simple features like 87722a42c286d4d12190b86b6d06d388e2953ba0 
(remember previous weight when auto-marking osd out) that are only useful 
on the mons (tho to be fair, that data probably is better of being stored 
in the mon store and not the OSDMap, so bad example).

Hrm...

sage



> 
> >  The fact that it's shared with clients is secondary to that.
> >
> >> So then we just have the upgrade issue to deal with. I think if we
> >> prevent the monitors from enabling checksums until all the OSDs
> >> support it, and then just have the OSDs query the monitors for any
> >> non-conforming maps on upgrade, we should be good ? divergent OSDMaps
> >> are pretty rare.
> >
> > So, maybe:
> >
> >  - In general, the OSDs will fetch full maps from the mon if they find
> > they can't generate them correctly from the incremental.
> >  - We make that an exceptional case:
> >    - When there is an actual bit flip
> >    - On upgrade when we discover the maps went divergent ages ago
> >    - When the mons are careless and encode an OSDMap that OSDs
> > can't generate themselves.
> >
> > It's the third on I'm worried about.  We can spend a feature bit every
> > time we change a structure in the OSDMap, but it will be expensive (in
> > terms of feature bits) and a bit fragile (easy for a dev to modify one of
> > those structs and not realize they also need to guard it being used)
> > because the generic struct encoding stuff is so forgiving.
> >
> > I think the options are:
> >
> >  1- Whatever, be careful and use feature bits when needed.
> >  2- Make the OSDs do something smart about getting full maps from peers.
> >  3- Always have users upgrade OSDs before mons
> >  4- Completely change the nature of incremental maps so that we patch the
> > previous map's encoding.  This will be immune to differences in encode
> > behavior, but will probably double the size of the incrementals (assuming
> > we keep both the semantic and bitwise diff).
> 
> As long as the field isn't changing how the mapping of data works (and
> if it is, you *need* the full guards) then I think we can just have
> feature bits or some equivalent *within* the OSDMap encoding. If an
> Incremental arrives with stuff you don't understand, but you meet the
> minimum requirements to even look at it, you just stop worrying about
> the generated checksums, and make sure not to send out any full maps
> which you encoded yourself from that point on.
> Right?
> 
> 
