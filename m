From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Mon, 11 Apr 2011 09:25:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104110924090.7812@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com> <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net> <4D9F367B.1070904@sandia.gov>
 <Pine.LNX.4.64.1104081343460.15928@cobra.newdream.net> <4D9F87F7.6090203@sandia.gov>
 <BANLkTimUZJhzCcC1AGTC73vi4ELVdy5H3w@mail.gmail.com> <4DA31312.4060206@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37594 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab1DKQVu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 12:21:50 -0400
In-Reply-To: <4DA31312.4060206@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 11 Apr 2011, Jim Schutt wrote:
> > > > I guess the other thing that would help to confirm this is to just halve
> > > > the number of OSDs on your machines in a test and see if the problem
> > > > goes
> > > > away.
> > > I was going to try this first, exactly because it seems like
> > > a definitive test.
> > > 
> > > > > If my analysis above is correct, do you think anything
> > > > > can be gained by running the heartbeat and heartbeat
> > > > > dispatcher threads as SCHED_RR threads?  Since tick() runs
> > > > > heartbeat_check(), that would also need to be SCHED_RR,
> > > > > or the heartbeats could arrive on time, but not checked
> > > > > until it was too late.
> > 
> > Thanks for the ideas. However, I doubt that making the OSD::tick()
> > thread SCHED_RR would really work.
> > 
> > The OSD::tick() code is taking locks all over the place. Since a bunch
> > of other threads besides the tick thread can be holding those locks,
> > this would soon result in priority inversion. Not to mention,
> > heartbeat_messenger has its own thread(s) which actually perform the
> > work of sending the heartbeat messages.
> 
> Yes, I think I understand.

We could set the priority for those threads as well, but I'm not sure that 
really addresses the problem: we may end up with a situation where cosd is 
responding to heartbeats but not doing useful work.  At some point you 
have to consider highly degraded service a failure.

Let's see if we can fix it without adjusting priorities first!

sage
