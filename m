From: Sage Weil <sage@inktank.com>
Subject: Re: v0.75 released
Date: Sat, 18 Jan 2014 21:27:11 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401182125150.17005@cobra.newdream.net>
References: <alpine.DEB.2.00.1401141941070.8325@cobra.newdream.net> <ord2jpvl4e.fsf@livre.home> <alpine.DEB.2.00.1401182057250.17005@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41873 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbaASF1M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Jan 2014 00:27:12 -0500
In-Reply-To: <alpine.DEB.2.00.1401182057250.17005@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

On Sat, 18 Jan 2014, Sage Weil wrote:
> On Sat, 18 Jan 2014, Alexandre Oliva wrote:
> > On Jan 15, 2014, Sage Weil <sage@inktank.com> wrote:
> > 
> > >  v0.75 291 files changed, 82713 insertions(+), 33495 deletions(-)
> > 
> > > Upgrading
> > > ~~~~~~~~~
> > 
> > I suggest adding:
> > 
> >   * All (replicated?) pools will likely fail scrubbing because the
> >     per-pool dirty object counts, introduced in 0.75, won't match.  This
> >     inconsistency is cleared by a pg repair; unfortunately this is about
> >     as expensive as a a deep-scrub, and it's not automatically scheduled
> >     or retried, like scrubs and deep-scrubs.
> > 
> > I suppose after the dirty counts are brought to sync, the next scrub
> > won't find inconsistent counts again, but I haven't got to that point
> > yet.
> 
> Whoops!  Yeah...
> 
> > What surprised me was the huge number of objects marked as dirty!  It
> > was at least 14k out of 70k objects in each data pool, and even more in
> > metadata pools, but it's not like I have messed with this many objects
> > recently.  Could something be amiss there?
> 
> The dirty state was introduced back in 0.71.  It's just the stats total 
> that was added in this release... that probably explains your situation.  
> 
> Which also means this will bite anybody who ran emperor, too.  I think I 
> need to introduce some pool flag or something indicating whether the dirty 
> stats should be scrubbed or not, set only on new pools?

Pushed wip-7184.  This still needs to be tested, but I probably won't get 
to it until Monday.  If someone wants to give it a go (on a non-production 
cluster), that'd be great!

sage
