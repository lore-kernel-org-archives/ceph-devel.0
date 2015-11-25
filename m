From: Sage Weil <sage@newdream.net>
Subject: RE: Cache Tiering Investigation and Potential Patch
Date: Wed, 25 Nov 2015 12:40:57 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511251240010.11017@cobra.newdream.net>
References: <3196669f.9Ro.9Gf.11.jZLaYO@mailjet.com> <alpine.DEB.2.00.1511250936470.11017@cobra.newdream.net> <2f99090c.9Ro.9Gf.24.jZU57B@mailjet.com> <alpine.DEB.2.00.1511251137390.11017@cobra.newdream.net> <af1c2841.9Ro.9Gf.22.jZVKGJ@mailjet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48619 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbbKYUk6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Nov 2015 15:40:58 -0500
In-Reply-To: <af1c2841.9Ro.9Gf.22.jZVKGJ@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: 'ceph-users' <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org, 'Mark Nelson' <mnelson@redhat.com>

On Wed, 25 Nov 2015, Nick Fisk wrote:
> > > Yes I think that should definitely be an improvement. I can't quite
> > > get my head around how it will perform in instances where you miss 1
> > > hitset but all others are a hit. Like this:
> > >
> > > H H H M H H H H H H H H
> > >
> > > And recency is set to 8 for example. It maybe that it doesn't have
> > > much effect on the overall performance. It might be that there is a
> > > strong separation of really hot blocks and hot blocks, but this could
> > > turn out to be a good thing.
> > 
> > Yeah... In the above case recency 3 would be enough (or 9, depending on
> > whether that's chronological or reverse chronological order).  Doing an N out
> > of M or similar is a bit more flexible and probably something we should add
> > on top.  (Or, we could change recency to be N/M instead of just
> > N.)
> 
> N out of M, is that similar to what I came up with but combined with the 
> N most recent sets?

Yeah

> If you can wait a couple of days I will run the PR 
> in its current state through my test box and see how it looks.

Sounds great, thanks.

> Just a quick question, is there a way to just make+build the changed 
> files/package or select just to build the main ceph.deb. I'm just using 
> " sudo dpkg-buildpackage" at the moment and its really slowing down any 
> testing I'm doing waiting for everything to rebuild.

You can probably 'make ceph-osd' and manualy copy that binary into 
place, assuming distro matches your build and test environments...

sage
