From: Sage Weil <sage@newdream.net>
Subject: Re: osd: terminate called after throwing an instance of 'std::bad_alloc'
Date: Wed, 9 Jun 2010 10:29:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006091025500.28853@cobra.newdream.net>
References: <Pine.LNX.4.64.1006011025090.14408@cobra.newdream.net>
 <20100602081044.GY1212@skl-net.de> <Pine.LNX.4.64.1006021115240.1269@cobra.newdream.net>
 <20100604084521.GO1211@skl-net.de> <Pine.LNX.4.64.1006040944331.2384@cobra.newdream.net>
 <20100607080754.GU1211@skl-net.de> <20100607080932.GV1211@skl-net.de>
 <Pine.LNX.4.64.1006071016470.20365@cobra.newdream.net> <20100608122838.GA9152@skl-net.de>
 <Pine.LNX.4.64.1006082246540.3595@cobra.newdream.net> <20100609081604.GG9152@skl-net.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35646 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab0FIR22 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jun 2010 13:28:28 -0400
In-Reply-To: <20100609081604.GG9152@skl-net.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: ceph-devel@vger.kernel.org

> > I've added a 'scripts/check_pglog.sh $osddatadir' script that will just 
> > look for any corruption.  Running that periodically will let you verify 
> > that you haven't hit the same corruption without having to restart cosd.  
> 
> Goodie. I'll set up a cron job to run this automatically. Should I
> do this on each osd?

Yeah, that would be ideal.

> > Ideally we can figure out what kind of workloads are triggering the 
> > problem, and then reproduce it with sufficient logging enabled to find 
> > where the race is taking place.
> >
> > If you have any details about the workload or any failure/recovery 
> > activity that may have been going on at the time that may shed some light 
> > on it...
> 
> Funny enough, the problem occurred while the fs was idle. I ran
> some simple tests a few days earlier and these completed with no
> problems. From that point on, nobody ever accessed it.
>
> I'll let you know if I can trigger it reliably. If you have any
> suggestions for a workload that is likely to trigger the race, I'm
> happy to give it a try. Otherwise, I'll just use "stress" again to
> write to the cephfs from a couple of clients simultaneously.

I think the corruption can happen when the osd map updates.  The problem 
is that the corrupt data is never read until cosd is restarted, usually a 
long time after the actual problem occurred, so adding that cron job 
should help narrow it down.

I would just proceed with your usual testing and see what happens.

Thanks!
sage

