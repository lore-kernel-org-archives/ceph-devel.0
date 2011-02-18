From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 18 Feb 2011 11:41:19 -0700
Message-ID: <1298054479.25491.197.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102172312550.26016@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:40836 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab1BRSla (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 13:41:30 -0500
In-Reply-To: <Pine.LNX.4.64.1102172312550.26016@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Fri, 2011-02-18 at 00:13 -0700, Sage Weil wrote:
> On Thu, 17 Feb 2011, Jim Schutt wrote:
> > Check out the result:
> >
> > osd.68.log:256027:2011-02-17 15:44:50.141378 7fd42ad57940 osd68 5 tick
> > osd.68.log:256028:2011-02-17 15:44:50.141464 7fd42ad57940 osd68 5 tick getting read lock on map_lock
> > osd.68.log:256029:2011-02-17 15:44:50.141472 7fd42ad57940 osd68 5 tick got read lock on map_lock
> > osd.68.log:256031:2011-02-17 15:44:50.141612 7fd42ad57940 osd68 5 tick sending mon report
> > osd.68.log:256032:2011-02-17 15:44:50.141619 7fd42ad57940 osd68 5 tick removing stray pgs
> > osd.68.log:256033:2011-02-17 15:44:50.141626 7fd42ad57940 osd68 5 tick sending log to logclient
> > osd.68.log:256034:2011-02-17 15:44:50.141633 7fd42ad57940 osd68 5 tick arming timer for next tick     <==
> > osd.68.log:256277:2011-02-17 15:45:18.481656 7fd42ad57940 osd68 5 tick checking dispatch queue status <== 28 second gap
> > osd.68.log:256278:2011-02-17 15:45:18.481669 7fd42ad57940 osd68 5 tick done
> > osd.68.log:256279:2011-02-17 15:45:18.481691 7fd42ad57940 osd68 5 tick
> > osd.68.log:256280:2011-02-17 15:45:18.481705 7fd42ad57940 osd68 5 tick getting read lock on map_lock
> > osd.68.log:256281:2011-02-17 15:45:18.481712 7fd42ad57940 osd68 5 tick got read lock on map_lock
> > osd.68.log:256688:2011-02-17 15:45:20.010705 7fd42ad57940 osd68 5 tick sending mon report
> > osd.68.log:256753:2011-02-17 15:45:20.012950 7fd42ad57940 osd68 5 tick removing stray pgs
> > osd.68.log:256754:2011-02-17 15:45:20.012959 7fd42ad57940 osd68 5 tick sending log to logclient
> > osd.68.log:256755:2011-02-17 15:45:20.012965 7fd42ad57940 osd68 5 tick arming timer for next tick
> > osd.68.log:256756:2011-02-17 15:45:20.012976 7fd42ad57940 osd68 5 tick checking dispatch queue status
> > osd.68.log:256757:2011-02-17 15:45:20.012993 7fd42ad57940 osd68 5 tick done
> >
> > Why should it take 28 seconds to add a new timer event?
> 
> Huh.. that is pretty weird.  I see multiple sync in there, too, so it's
> not like something was somehow blocking on a btrfs commit.

Here's another run; the tick gap is in a different place:

osd.91.log:354239:2011-02-18 10:21:49.391986 7f012c6d7940 osd91 5 tick
osd.91.log:354240:2011-02-18 10:21:49.392059 7f012c6d7940 osd91 5 tick getting read lock on map_lock
osd.91.log:354241:2011-02-18 10:21:49.392067 7f012c6d7940 osd91 5 tick got read lock on map_lock
osd.91.log:354243:2011-02-18 10:21:49.392210 7f012c6d7940 osd91 5 tick sending mon report
osd.91.log:354244:2011-02-18 10:21:49.392217 7f012c6d7940 osd91 5 tick removing stray pgs
osd.91.log:354245:2011-02-18 10:21:49.392225 7f012c6d7940 osd91 5 tick sending log to logclient
osd.91.log:354246:2011-02-18 10:21:49.392231 7f012c6d7940 osd91 5 tick arming timer for next tick
osd.91.log:354247:2011-02-18 10:21:49.392241 7f012c6d7940 osd91 5 tick checking dispatch queue status
osd.91.log:354248:2011-02-18 10:21:49.392247 7f012c6d7940 osd91 5 tick done                              <==
osd.91.log:355120:2011-02-18 10:22:14.948941 7f012c6d7940 osd91 5 tick                                   <== 25 second gap
osd.91.log:355121:2011-02-18 10:22:14.948952 7f012c6d7940 osd91 5 tick getting read lock on map_lock
osd.91.log:355122:2011-02-18 10:22:14.948959 7f012c6d7940 osd91 5 tick got read lock on map_lock
osd.91.log:355338:2011-02-18 10:22:14.956905 7f012c6d7940 osd91 5 tick sending mon report
osd.91.log:355398:2011-02-18 10:22:14.958590 7f012c6d7940 osd91 5 tick removing stray pgs
osd.91.log:355399:2011-02-18 10:22:14.958598 7f012c6d7940 osd91 5 tick sending log to logclient
osd.91.log:355400:2011-02-18 10:22:14.958605 7f012c6d7940 osd91 5 tick arming timer for next tick
osd.91.log:355401:2011-02-18 10:22:14.958615 7f012c6d7940 osd91 5 tick checking dispatch queue status
osd.91.log:355402:2011-02-18 10:22:14.958625 7f012c6d7940 osd91 5 tick done


> Anybody else have ideas?  :/

Hmmm, when I started using 2.6.28-rc kernels I enabled cgroups:

CONFIG_CGROUPS=y
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_CGROUP_NS is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_NET_CLS_CGROUP is not set

Since I can't think of anything else to try, I'll
try turning them off.....

-- Jim

> 
> sage
> 


