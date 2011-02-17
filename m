From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 17 Feb 2011 08:11:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com> <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56177 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086Ab1BQQKF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Feb 2011 11:10:05 -0500
In-Reply-To: <1297957574.25491.152.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 17 Feb 2011, Jim Schutt wrote:
> Hi Sage,
> 
> On Wed, 2011-02-16 at 17:54 -0700, Sage Weil wrote:
> > On Wed, 16 Feb 2011, Sage Weil wrote:
> > > shouldn't affect anything.  We may have missed something.. do you have a 
> > > log showing this in action?
> > 
> > Obviously yes, looking at your original email.  :)  At the beginning of 
> > each log line we include a thread id.  What would be really helpful would 
> > be to narrow down where in OSD::heartbeat_entry() and heartbeat() things 
> > are blocking, either based on the existing output, or by adding additional 
> > dout lines at interesting points in time.
> 
> I'll take a deeper look at my existing logs with
> that in mind; let me know if you'd like me to
> send you some.
> 
> I have also been looking at map_lock, as it seems
> to be shared between the heartbeat and map update
> threads.
> 
> Would instrumenting acquiring/releasing that lock
> be helpful?  Is there some other lock that may
> be more fruitful to instrument?  I can reproduce 
> pretty reliably, so adding instrumentation is 
> no problem.

The heartbeat thread is doing a map_lock.try_get_read() because it 
frequently is held by another thread, so that shouldn't ever block. 

The possibilities I see are:
 - peer_stat_lock
 - the monc->sub_want / renew_subs calls (monc has an internal lock), 
although that code should only trigger with a single osd.  :/
 - heartbeat_lock itself could be held by another thread; i'd instrument 
all locks/unlocks there, along with the wakeup in heartbeat().

Thanks for looking at this!
sage



> 
> -- Jim
> 
> > 
> > sage
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
