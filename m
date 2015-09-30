From: Sage Weil <sweil@redhat.com>
Subject: Re: branches! infernalis vs master, RIP next
Date: Tue, 29 Sep 2015 17:12:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509291712230.21582@cobra.newdream.net>
References: <alpine.DEB.2.00.1509291310470.4617@cobra.newdream.net> <560B0E17.9070709@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36636 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbbI3AMe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 Sep 2015 20:12:34 -0400
In-Reply-To: <560B0E17.9070709@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

On Wed, 30 Sep 2015, Loic Dachary wrote:
> On 29/09/2015 23:12, Sage Weil wrote:
> > Having master and infernalis branches follow each other is preventing some 
> > folks from moving forward with post-infernalis work.  And it's confusing.  
> > So, we're proposing a new world order... and this time it should keep 
> > things consistent both during regular development and stabilization 
> > periods:
> > 
> >  master - where new feature work is merged
> >  infernalis ($next_stable) - where bug fixes are merged
> >  hammer, firefly ($previous_stable) - where bug fixes are merged
> > 
> > Previously we had a 'next' branch that was whatever the next pending 
> > release would be.  This will henceforth be named after the next major 
> > release (currently infernalis).  This let's us avoid having next sometimes 
> > during regular development periods and not during stabilization periods.  
> > It also means that we needn't know ahead of time whether the next release 
> > is going to be a development release, rc, or the initial (x.2.0) release 
> > of the next stable series.
> > 
> > That $next_stable branch (currently infernalis) will periodically get 
> > merged back into master, just like next did.  We will stop doing that when 
> > the release is made.  From that point forward, any stable series backports 
> > will be cherry-picked.
> > 
> > The only real difference then between the development and stabilization 
> > periods is that during development we pull in new stuff from master each 
> > time we release, and releases are x.0.z.  During stabilization, we do rc 
> > releases that look like x.1.z, and we don't merge in anything new from 
> > master.
> > 
> > So:
> > 
> >  1- Target any pull request with a bug fix that should go into infernalis 
> > at the infernalis branch.
> > 
> >  2- Before merging anything, make sure it is targetting the right branch.  
> > If it isn't, merge it manually, and verify it isn't pulling in a bunch of 
> > extra stuff (e.g., because a bug fix for infernalis was based on the 
> > current master branch).
> > 
> >  3- We will periodically merge infernalis back into master until the first 
> > infernalis (9.2.0) release.  After that we'll cherry-pick -x.
> > 
> >  4- At that point we'll create a jewel branch that will work the same way.  
> > (It will be regularly merged into master, will eventually result in 10.0.z 
> > releases, and will pull lumps of new stuff from master in each time that 
> > happens.)
> 
> When 10.0.0 is released, the jewel branch is reset to master and will 
> eventually be 10.0.1 etc. Is that right ?

Right!

sage
