From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 2 Mar 2011 09:10:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com> <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov> <460F770CEB1C499F8B87593762171483@gmail.com>
 <1298489031.25491.250.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103011646140.32424@cobra.newdream.net>
 <1299079262.4750.19.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39634 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab1CBRIZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2011 12:08:25 -0500
In-Reply-To: <1299079262.4750.19.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 2 Mar 2011, Jim Schutt wrote:
> On Tue, 2011-03-01 at 17:53 -0700, Sage Weil wrote:
> > Hi Jim,
> > 
> > We've fixed a few different bugs over the last week that were causing 
> > heartbeat issues. 
> 
> Great!
> 
> >  Nothing that explains why we would see the hang that 
> > you did, but other problems that caused the same 'wrongly marked me down' 
> > issue.  Are you still seeing this problem with the latest 'next' and/or 
> > 'master' branch?
> 
> I've been trying to isolate this on the stable branch
> since my last posting - I can still reproduce at will
> with my 96 osd test, but I haven't made much progress
> at tracking down what is going wrong.
> 
> > 
> > Also, if you don't mind reproducing, can you post a larger segment of the 
> > log? 
> 
> Sure.  I've got some extra debug printing going in
> my tree - the most interesting is a patch to log
> queue, operation, and total elapsed times in
> dispatch_entry() - it makes is really easy to
> find when things go wrong.
>
> I'll try to reproduce with master and post logs.
> Is it OK for me to add my extra debug patches for
> that?  I'll post them with the logs if so.

Absolutely.

> >  The really interesting question is what the heartbeat thread 
> > (heartbeat_entry()) is doing during this period that tick() is blocked up, 
> > since that's the thread that's responsible for sending the ping messages 
> > to peer OSDs.
> 
> One of the things I am seeing is handle_osd_ping()
> getting stalled, but I haven't been able to track
> down why.
> 
> I'll see if I see the same signature with master,
> and post logs.

Thanks!  Keep us posted.
sage
