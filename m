From: Sage Weil <sweil@redhat.com>
Subject: Re: OSDMap checksums
Date: Fri, 22 Aug 2014 10:33:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408221029560.31169@cobra.newdream.net>
References: <alpine.DEB.2.00.1408191528070.28247@cobra.newdream.net> <CAPYLRziaU2R57axjLVmkSX6P7F9gwHhwHMBtHgmVq0a2pd=P3g@mail.gmail.com> <alpine.DEB.2.00.1408191723440.28244@cobra.newdream.net> <CAPYLRzioYDorFaruE5nnQgVZrxC9vDckT6Et6KmWhFaYt4fszw@mail.gmail.com>
 <alpine.DEB.2.00.1408192139210.28244@cobra.newdream.net> <CAPYLRzgU_vmOZVoGcnmVNch=adkd4WmUZbjYJ1E8JVDDrHj81Q@mail.gmail.com> <alpine.DEB.2.00.1408211709300.31169@cobra.newdream.net> <CAPYLRzhstbj-mVNxzcEi8QJdKh4wRQ9ZP4_ShRAAfz8Q2=HgCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53976 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbaHVRdk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Aug 2014 13:33:40 -0400
In-Reply-To: <CAPYLRzhstbj-mVNxzcEi8QJdKh4wRQ9ZP4_ShRAAfz8Q2=HgCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 22 Aug 2014, Gregory Farnum wrote:
> On Thu, Aug 21, 2014 at 5:38 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Tue, 19 Aug 2014, Gregory Farnum wrote:
> >> As far as I can tell, checksumming incrementals are good for two
> >> things besides detecting bit flips:
> >> 1) It's easy to extend to signing the Incremental, which is more secure
> >> 2) It protects against accidental divergence like we saw when we added
> >> the extra heartbeat IP fields
> >
> > Thinking back, the last time we really screwed this up was
> >
> >         http://tracker.ceph.com/issues/8738
> >
> > where the mons were distributing two versions of OSDMaps with different
> > crush tunable values encoded.  This was because they were encoding the
> > full maps locally and didn't all do it the same way (because we weren't
> > doing the right feature checks there).  That bug is fixed, of course, but
> > I'd like to have assurance that we won't hit similar ones--this was far
> > from the first time something like this has happened.
> 
> Huh, I actually can't think of any others which impacted mappings like
> this one did. That said, I agree...
> 
> > Having the OSDs
> > generate full maps locally is another tier down but essentially the same
> > problem.  Any manner of bugs could lead to violating the critical
> > invariant and we would be none the wiser.
> 
> ...but if we're really stuck on having bytewise-identical maps across
> all OSDs, that means that the OSDs (and whoever else is checking CRCs)
> *have* to all understand the entirety of the map well enough to decode
> it correctly. This is just another way of saying that they need to be
> new enough to understand every encoded feature of the OSDMap ? which
> is another way of saying that either the monitors must restrict what
> features they put in the maps, or the OSDs must all be at least as new
> as the monitors.
> 
> Now, sure, we could use this as insurance in development testing to
> make sure that monitors aren't encoding things their older OSDs won't
> understand, but we've in the past had situations where we *wanted* to
> let new OSDs see newer data that the old ones just ignored. (Namely,
> heartbeat addresses.) Maybe losing that option is a tradeoff worth
> making, but we're still going to need to have all the feature bit
> controls we presently rely on; this will just tell us (during upgrade
> testing, not earlier!) that we missed creating some.

Yeah, I think that's a great summary.

Perhaps then what we want is to make the OSD behavior in this case 
configurable:

 - warn (clog.warn(), so that teuthology notices)
 - fetch pristine maps from mon

Then we can decide later what we actually want to do here.  But all of the 
machinery to do the validation at least will be there.

Since we will still need to use the feature bits to carefully control how 
we encode these maps, but will have somewhat stricter controls on what is 
permissable, this will either accellerate our burn of feature bits or 
make us keep more info outside of OSDMap (probably a good thing, 
actually).  Anyway, point being, I think the day we need to move 
beyond 64 features is not too far off...

sage
