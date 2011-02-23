From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 23 Feb 2011 10:12:01 -0800
Message-ID: <460F770CEB1C499F8B87593762171483@gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39795 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab1BWSOM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 13:14:12 -0500
Received: by yxs7 with SMTP id 7so1384630yxs.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2011 10:14:11 -0800 (PST)
In-Reply-To: <1298483538.25491.233.camel@sale659.sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>


On Wednesday, February 23, 2011 at 9:52 AM, Jim Schutt wrote: 
> 
> On Thu, 2011-02-17 at 09:11 -0700, Sage Weil wrote:
> > On Thu, 17 Feb 2011, Jim Schutt wrote:
> > > Hi Sage,
> > > 
> > > On Wed, 2011-02-16 at 17:54 -0700, Sage Weil wrote:
> > > > On Wed, 16 Feb 2011, Sage Weil wrote:
> > > > > shouldn't affect anything. We may have missed something.. do you have a 
> > > > > log showing this in action?
> > > > 
> > > > Obviously yes, looking at your original email. :) At the beginning of 
> > > > each log line we include a thread id. What would be really helpful would 
> > > > be to narrow down where in OSD::heartbeat_entry() and heartbeat() things 
> > > > are blocking, either based on the existing output, or by adding additional 
> > > > dout lines at interesting points in time.
> > > 
> > > I'll take a deeper look at my existing logs with
> > > that in mind; let me know if you'd like me to
> > > send you some.
> > > 
> > > I have also been looking at map_lock, as it seems
> > > to be shared between the heartbeat and map update
> > > threads.
> > > 
> > > Would instrumenting acquiring/releasing that lock
> > > be helpful? Is there some other lock that may
> > > be more fruitful to instrument? I can reproduce 
> > > pretty reliably, so adding instrumentation is 
> > > no problem.
> > 
> > The heartbeat thread is doing a map_lock.try_get_read() because it 
> > frequently is held by another thread, so that shouldn't ever block. 
> > 
> > The possibilities I see are:
> >  - peer_stat_lock
> >  - the monc->sub_want / renew_subs calls (monc has an internal lock), 
> > although that code should only trigger with a single osd. :/
> >  - heartbeat_lock itself could be held by another thread; i'd instrument 
> > all locks/unlocks there, along with the wakeup in heartbeat().
> 
> I think the culprit is osd_lock.
> 
> The OSD tick timer needs to acquire the osd_lock mutex to
> wake up, right? So if osd_lock is ever held for an excessive 
> time, the tick will be delayed.
> 
> I used debug lockdep = 20 on my osds, and saw this via
> egrep "10:07:(2[2-9]|3[0-3])" osd.70.log | egrep "tick|osd_lock" | grep -v "tick .*"
> 
> 2011-02-23 10:07:23.454954 0x7f51a17fa940 lockdep: _will_lock OSD::osd_lock (9)
> 2011-02-23 10:07:23.455118 0x7f51a37fe940 lockdep: _will_unlock OSD::osd_lock
> 2011-02-23 10:07:23.455254 0x7f51a37fe940 lockdep: _will_lock OSD::osd_lock (9)
> 2011-02-23 10:07:23.455262 0x7f51a37fe940 lockdep: _locked OSD::osd_lock
> 2011-02-23 10:07:33.008092 0x7f51a37fe940 lockdep: _will_unlock OSD::osd_lock
> 2011-02-23 10:07:33.009135 0x7f51a17fa940 lockdep: _locked OSD::osd_lock
> 2011-02-23 10:07:33.009217 0x7f51a17fa940 lockdep: _will_unlock OSD::osd_lock
> 2011-02-23 10:07:33.009307 0x7f51ad89d940 osd70 149 tick
> 
> I've attached a full log of the 10 second period that osd_lock
> was held.
> 
> Is it possible to separate out the parts of tick() that
> need to covered by osd_lock and do them somewhere else, 
> so that a new lock, say tick_lock, can be used to
> protect the tick timer?
> 
> -- Jim
> 

tick() isn't involved in heartbeats, actually, so any blocks there should be unrelated to heartbeat bugs (and once you're in tick() or functions it calls, there's no losing the heartbeat!). 
I have managed to get OSDs wrongly marking each other down during startup when they're peering large numbers of PGs/pools, as they disagree on who they need to be heartbeating (due to the slow handling of new osd maps and pg creates); if you're mostly seeing OSDs get incorrectly marked down during low epochs (your original email said epoch 7) this is probably what you're finding. 

We still have no idea what could be causing the stall *inside* of tick(), though. :/
-Greg



