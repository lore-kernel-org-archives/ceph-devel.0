From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 2 Mar 2011 21:03:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103022102240.32695@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com> <1297893011.25491.124.camel@sale659.sandia.gov>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45207 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab1CCFBT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 00:01:19 -0500
In-Reply-To: <1299106628.4750.62.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jim,

On Wed, 2 Mar 2011, Jim Schutt wrote:

> 
> On Wed, 2011-03-02 at 14:59 -0700, Jim Schutt wrote:
> > 
> > On Wed, 2011-03-02 at 14:45 -0700, Sage Weil wrote:
> > > On Wed, 2 Mar 2011, Jim Schutt wrote:
> > > > 
> > > > On Wed, 2011-03-02 at 10:10 -0700, Sage Weil wrote:
> > > > > > I'll see if I see the same signature with master,
> > > > > > and post logs.
> > > > > 
> > > > > Thanks!  Keep us posted.
> > > > 
> > > > Hmmm, I'm not having much luck with master (commit 
> > > > 0fb5ef2ce92 + extra debugging) on a 96-osd filesystem;
> > > > lots of dead OSDs during startup.
> > > 
> > > Commit c916905a8a14029653aae45f0a9fb6c9b4c39e05 (master) should fix this.
> > 
> > I try it out, thanks!
> 
> I don't get any more core files with master commit 67355779ecc.
> Now my cosds just die - no stack trace in the log, no core
> file, nothing in syslog or dmesg ...
> 
> I'm not sure how to track down what's happening here...

Hmm.  I'm not able to reproduce this here (tho I only have ~15 nodes 
available at the moment).  Seeing the last bit of the logs on the crashed 
nodes will help.

I pushed a fix for the chdir issue, though!

Thanks-
sage
