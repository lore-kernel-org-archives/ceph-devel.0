From: Sage Weil <sage@inktank.com>
Subject: Re: Release/branch naming; input requested
Date: Fri, 18 May 2012 09:32:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205180918190.8006@cobra.newdream.net>
References: <CAORUGqBxO=n_7xkDEFr_gi=y=+7abo0mErYSDOwVTq+zaA_cTw@mail.gmail.com>
 <CAC-hyiFdGudQSfby7QkJZRBhGDBQeWGiA7LwtFWhmevUMa_2bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58170 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758059Ab2ERQdC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 12:33:02 -0400
In-Reply-To: <CAC-hyiFdGudQSfby7QkJZRBhGDBQeWGiA7LwtFWhmevUMa_2bw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 26 Apr 2012, Yehuda Sadeh Weinraub wrote:
> > Now, here are my actual questions:
> >
> > 1. What should the "relative" names of the branches be? "stable" vs
> > "latest" etc. I especially don't like "integration", but I do see a
> > time where it is not ready for "stable" but still needs to branch off
> > of "latest".
> 
> reallyold
> old
> current
> next
> latest/experimental

I think we can limit the relative branches to:

 master = integration, unstable, tip, bleeding edge (same as now)
 [next] = next upcoming release (same as now)
 current = most recent release
 stable = most recent stable release

> > 2. Do we want to use cutesy codenames? Alphabetical? Based on what theme?
> 
> Yes. Theme should be voted on.

I like Yehuda's suggestion of cephalopods, or other interesting sea 
creatures.  As he points out, though,

  http://www.thecephalopodpage.org/taxa.php

suggests that there may not be enough good choices that are strictly 
cephalopods, though.  Although it might be ok?

 argonaut
 bobtail
 cuttlefish
 dispar? dofleini?
 e?
 flamboyant
 ...
 kraken
 ...
 vampire, vulgaris

> > 3. Do we want to use calendar based names? "I'm using Ceph branch
> > 2012.04"? (Or spell it 2012-04 to avoid confusing with 0.41 style
> > versions?)
> 
> No. I don't think it makes much sense. Not at this point at least.

No calendar names.

> > 3. What do we do with version numbers? With a 2-3 week iteration,
> > we'll end up with something like 0.41.x, 0.56.x for Folsom integration
> > (less than a year from now), and 0.57, 0.58 etc for "latest".
> 
> We can keep those, they are completely orthogonal. These are exactly
> what they are: dev cycle numbers. I'm not too afraid of big numbers
> there, as they become uninteresting once you have the other naming
> scheme. They have the nice property of monotonically increasing which
> is useful internally.

Yeah, let's keep the versioning orthogonal.  I think it's important that 
the package versions are meaningful and sort well.

The one thing that might be nice is to tag the version codes with the 
stable release name, e.g.

	v0.45argonaut
	v0.45argonaut-1-gf83ca243
	...

so that you can see what you have.  This is just a matter of creating a 
git tag with the appropriate name.  If we do point releases, they could be

	v0.45argonaut.1
	v0.45argonaut.1-1-g3172a72
	...

?

> > 4. What will be worthy of 1.0? Is it when the distributed file system
> > is solid? Getting out of 0.x would help with separating the different
> > branches based on major numbers, but I fear that window has closed
> > already.
> >
> 
> Do we need to have 1.0? I'd say that for the first release that
> becomes 'current' with the voted naming scheme we adjust the build
> version number to 1.0. After that, every release (not every dev
> cycle!) we'd decide whether it's worthy of a major number upgrade or
> not. Minor releases can increase the minor version. Fixes on top of
> that would go to the 3rd level.
> I'm not sure whether it'd work nicely with dev cycle numbering though.

Someday there will be 1.0, but I don't think we need to worry about it 
here.  Personally, I think it should happen when the file system is 
deemed supportable.

sage
