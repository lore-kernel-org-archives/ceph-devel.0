From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 3 Mar 2011 10:51:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103031049550.25732@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov> <460F770CEB1C499F8B87593762171483@gmail.com>
 <1298489031.25491.250.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103011646140.32424@cobra.newdream.net>
 <1299079262.4750.19.camel@sale659.sandia.gov> <Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
 <1299099295.4750.41.camel@sale659.sandia.gov> <Pine.LNX.4.64.1103021342540.27567@cobra.newdream.net>
 <1299103144.4750.49.camel@sale659.sandia.gov> <1299106628.4750.62.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103022102240.32695@cobra.newdream.net>
 <1299173302.4750.98.camel@sale659.sandia.gov> <Pine.LNX.4.64.1103031003350.25732@cobra.newdream.net>
 <1299177730.4750.106.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57000 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758483Ab1CCSt5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 13:49:57 -0500
In-Reply-To: <1299177730.4750.106.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 3 Mar 2011, Jim Schutt wrote:
> On Thu, 2011-03-03 at 11:04 -0700, Sage Weil wrote:
> > On Thu, 3 Mar 2011, Jim Schutt wrote:
> > > 
> > > On Wed, 2011-03-02 at 22:03 -0700, Sage Weil wrote:
> > > > > I'm not sure how to track down what's happening here...
> > > > 
> > > > Hmm.  I'm not able to reproduce this here (tho I only have ~15 nodes 
> > > > available at the moment).  Seeing the last bit of the logs on the crashed 
> > > > nodes will help.
> > > > 
> > 
> > Can you confirm that the chdir is working now?  Maybe put an assert(0) in 
> > tick() so we can verify core dumps are working in general?
> 
> Great idea, and chdir is definitely working; got 96 core 
> files as expected.

Can you put an assert(0) at the top of OSD::shutdown() so we can verify 
that the OSD isn't trying to shut itself down cleanly?  (There are a few 
cases where it might do that.)  The logs you had make it look a bit like 
that could be the case.  Or that it is crashing in an unpleasant way in 
the messenger pipe teardown.

Thanks!
sage
