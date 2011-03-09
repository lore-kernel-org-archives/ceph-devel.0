From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 9 Mar 2011 11:36:49 -0700
Message-ID: <1299695809.4750.346.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
 <1299686572.4750.329.camel@sale659.sandia.gov>
 <2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:60466 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab1CISg5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2011 13:36:57 -0500
In-Reply-To: <2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 2011-03-09 at 10:07 -0700, Gregory Farnum wrote:
> On Wednesday, March 9, 2011 at 8:02 AM, Jim Schutt wrote:
> > Heh. Evidently I didn't do the instrumentation right.
> > Or more specifically, I didn't look in the right places
> > for the result I needed.
> > 
> > Once I understood the code/logging enough to write a
> > script to look for delayed osd_ping message processing,
> > I found evidence that the heartbeat lock is contended:

[snip]
> > 
> > I still need to gather evidence on who is holding heartbeat_lock
> > in cases like this. Still digging.....
> > 
> > I'm sorry it took me so long to find some evidence about what 
> > was going on.
> > 
> > -- Jim
> > Are you going through map spam at this point? If so, I'd pay 
> special attention to update_heartbeat_peers, which is going to 
> iterate through each PG (...in the cluster. Hmm, I thought that 
> was never supposed to happen) on every map update. This has been 
> known to take a bit of time (how many PGs does your cluster have 
> at this point?), although it may be a case of the debugging 
> taking up more time than the actual processing here.

Here's another example with more debugging.  The
PG count during this interval is:

2011-03-09 10:35:58.306942    pg v379: 25344 pgs: 25344 active+clean; 12119 MB data, 12025 MB used, 44579 GB / 44787 GB avail
2011-03-09 10:36:42.177728    pg v462: 25344 pgs: 25344 active+clean; 46375 MB data, 72672 MB used, 44520 GB / 44787 GB avail

Check out the interval 10:36:23.473356 -- 10:36:27.922262

It looks to me like a heartbeat message submission is 
waiting on something?

I still need to see if all my stalls exhibit this pattern,
or if this is an isolated instance.

osd.0.log:812629:2011-03-09 10:36:23.472432 7f7e427e7940 -- 172.17.40.21:6802/17592 >> 172.17.40.29:6811/15398 pipe(0xf0c920 sd=44 pgs=89 cs=1 l=0).reader got message 267 0xfd0560 osd_ping(e5 as_of 5) v1
osd.0.log:812643:2011-03-09 10:36:23.472839 7f7e4fc00940 -- 172.17.40.21:6802/17592 dispatch_entry pipe 0xf0c920 dequeued 0xfd0560
osd.0.log:812644:2011-03-09 10:36:23.472866 7f7e4fc00940 -- 172.17.40.21:6802/17592 <== osd59 172.17.40.29:6811/15398 267 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (3590659439 0 0) 0xfd0560 con 0xee85a0
osd.0.log:812645:2011-03-09 10:36:23.472894 7f7e4fc00940 osd0 5 heartbeat_dispatch 0xfd0560
osd.0.log:812646:2011-03-09 10:36:23.472928 7f7e4fc00940 osd0 5 handle_osd_ping from osd59 got stat stat(2011-03-09 10:36:23.471405 oprate=1.57375 qlen=0 recent_qlen=1.66667 rdlat=0 / 0 fshedin=0)
osd.0.log:812647:2011-03-09 10:36:23.472943 7f7e4fc00940 osd0 5 handle_osd_ping wants heartbeat_lock
osd.0.log:812648:2011-03-09 10:36:23.473008 7f7e4c9f8940 osd0 5 update_osd_stat osd_stat(594 MB used, 463 GB avail, 466 GB total, peers [9,11,14,15,16,17,19,24,25,29,31,32,36,37,38,39,40,42,43,46,47,51,53,54,56,58,59,61,62,64,65,67,68,70,72,73,77,80,81,87,90,91,93,94]/[8,9,12,14,15,16,17,18,21,22,23,24,25,26,27,29,31,32,34,36,37,38,39,40,42,43,44,46,49,50,51,58,60,65,66,69,70,71,74,75,77,78,79,81,82,86,88,89,90,91,93])
osd.0.log:812649:2011-03-09 10:36:23.473046 7f7e4c9f8940 osd0 5 _refresh_my_stat stat(2011-03-09 10:36:23.472606 oprate=3.55328 qlen=0 recent_qlen=3.33333 rdlat=0 / 0 fshedin=0)
osd.0.log:812650:2011-03-09 10:36:23.473099 7f7e4c9f8940 osd0 5 heartbeat: stat(2011-03-09 10:36:23.472606 oprate=3.55328 qlen=0 recent_qlen=3.33333 rdlat=0 / 0 fshedin=0)
osd.0.log:812651:2011-03-09 10:36:23.473128 7f7e4c9f8940 osd0 5 heartbeat: osd_stat(594 MB used, 463 GB avail, 466 GB total, peers [9,11,14,15,16,17,19,24,25,29,31,32,36,37,38,39,40,42,43,46,47,51,53,54,56,58,59,61,62,64,65,67,68,70,72,73,77,80,81,87,90,91,93,94]/[8,9,12,14,15,16,17,18,21,22,23,24,25,26,27,29,31,32,34,36,37,38,39,40,42,43,44,46,49,50,51,58,60,65,66,69,70,71,74,75,77,78,79,81,82,86,88,89,90,91,93])
osd.0.log:812652:2011-03-09 10:36:23.473137 7f7e4c9f8940 osd0 5 heartbeat map_locked=1
osd.0.log:812653:2011-03-09 10:36:23.473149 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd8
osd.0.log:812654:2011-03-09 10:36:23.473161 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd8
osd.0.log:812655:2011-03-09 10:36:23.473177 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd8 172.17.40.22:6802/20244 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e446fbc10
osd.0.log:812656:2011-03-09 10:36:23.473195 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.22:6802/20244, have pipe.
osd.0.log:812657:2011-03-09 10:36:23.473216 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd9
osd.0.log:812658:2011-03-09 10:36:23.473230 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd9
osd.0.log:812659:2011-03-09 10:36:23.473247 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd9 172.17.40.22:6805/20349 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e441d7270
osd.0.log:812661:2011-03-09 10:36:23.473288 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.22:6805/20349, have pipe.
osd.0.log:812663:2011-03-09 10:36:23.473325 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd12
osd.0.log:812664:2011-03-09 10:36:23.473338 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd12
osd.0.log:812665:2011-03-09 10:36:23.473356 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd12 172.17.40.22:6814/20653 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4428ad40
osd.0.log:812893:2011-03-09 10:36:24.052769 7f7e5640d940 osd0 5 tick getting read lock on map_lock
osd.0.log:812894:2011-03-09 10:36:24.052779 7f7e5640d940 osd0 5 tick got read lock on map_lock
osd.0.log:812896:2011-03-09 10:36:24.052856 7f7e5640d940 osd0 5 tick wants heatbeat_lock
osd.0.log:813027:2011-03-09 10:36:24.507893 7f7e54c0a940 osd0 5 get_my_stat_for wants heartbeat_lock
osd.0.log:813992:2011-03-09 10:36:27.922262 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.22:6814/20653, have pipe.
osd.0.log:813993:2011-03-09 10:36:27.922299 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd14
osd.0.log:813994:2011-03-09 10:36:27.922309 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd14
osd.0.log:813995:2011-03-09 10:36:27.922322 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd14 172.17.40.22:6820/20861 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e442c9620
osd.0.log:813996:2011-03-09 10:36:27.922336 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.22:6820/20861, have pipe.
osd.0.log:813997:2011-03-09 10:36:27.922367 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd15
osd.0.log:813998:2011-03-09 10:36:27.922376 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd15
osd.0.log:813999:2011-03-09 10:36:27.922388 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd15 172.17.40.22:6823/20953 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e442bb420
osd.0.log:814000:2011-03-09 10:36:27.922402 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.22:6823/20953, have pipe.
osd.0.log:814001:2011-03-09 10:36:27.922412 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd16
osd.0.log:814002:2011-03-09 10:36:27.922421 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd16
osd.0.log:814003:2011-03-09 10:36:27.922432 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd16 172.17.40.23:6802/11814 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4427ef80
osd.0.log:814241:2011-03-09 10:36:27.930775 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.23:6802/11814, have pipe.
osd.0.log:814242:2011-03-09 10:36:27.930805 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd17
osd.0.log:814243:2011-03-09 10:36:27.930815 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd17
osd.0.log:814244:2011-03-09 10:36:27.930828 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd17 172.17.40.23:6805/11921 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e441797e0
osd.0.log:814245:2011-03-09 10:36:27.930840 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.23:6805/11921, have pipe.
osd.0.log:814246:2011-03-09 10:36:27.930855 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd18
osd.0.log:814247:2011-03-09 10:36:27.930863 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd18
osd.0.log:814248:2011-03-09 10:36:27.930873 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd18 172.17.40.23:6808/12026 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e442bac90
osd.0.log:814249:2011-03-09 10:36:27.930884 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.23:6808/12026, have pipe.
osd.0.log:814250:2011-03-09 10:36:27.930902 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd21
osd.0.log:814251:2011-03-09 10:36:27.930913 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd21
osd.0.log:814252:2011-03-09 10:36:27.930923 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd21 172.17.40.23:6817/12326 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e442bb260
osd.0.log:814423:2011-03-09 10:36:27.944270 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.23:6817/12326, have pipe.
osd.0.log:814424:2011-03-09 10:36:27.944291 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd22
osd.0.log:814425:2011-03-09 10:36:27.944318 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd22
osd.0.log:814426:2011-03-09 10:36:27.944330 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd22 172.17.40.23:6820/12418 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e441ded40
osd.0.log:814427:2011-03-09 10:36:27.944343 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.23:6820/12418, have pipe.
osd.0.log:814428:2011-03-09 10:36:27.944358 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd23
osd.0.log:814429:2011-03-09 10:36:27.944367 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd23
osd.0.log:814430:2011-03-09 10:36:27.944376 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd23 172.17.40.23:6823/12534 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e441afaa0
osd.0.log:814431:2011-03-09 10:36:27.944388 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.23:6823/12534, have pipe.
osd.0.log:814432:2011-03-09 10:36:27.944401 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd24
osd.0.log:814433:2011-03-09 10:36:27.944411 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd24
osd.0.log:814434:2011-03-09 10:36:27.944421 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd24 172.17.40.24:6802/7915 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4417fd50
osd.0.log:814435:2011-03-09 10:36:27.944431 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.24:6802/7915, have pipe.
osd.0.log:814436:2011-03-09 10:36:27.944448 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd25
osd.0.log:814437:2011-03-09 10:36:27.944457 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd25
osd.0.log:814438:2011-03-09 10:36:27.944468 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd25 172.17.40.24:6805/8007 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4473d410
osd.0.log:814439:2011-03-09 10:36:27.944479 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.24:6805/8007, have pipe.
osd.0.log:814440:2011-03-09 10:36:27.944494 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd26
osd.0.log:814441:2011-03-09 10:36:27.944503 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd26
osd.0.log:814442:2011-03-09 10:36:27.944514 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd26 172.17.40.24:6808/8112 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e441a70a0
osd.0.log:814443:2011-03-09 10:36:27.944525 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.24:6808/8112, have pipe.
osd.0.log:814444:2011-03-09 10:36:27.944538 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd27
osd.0.log:814445:2011-03-09 10:36:27.944547 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd27
osd.0.log:814446:2011-03-09 10:36:27.944557 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd27 172.17.40.24:6811/8215 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44080b70
osd.0.log:814447:2011-03-09 10:36:27.944567 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.24:6811/8215, have pipe.
osd.0.log:814448:2011-03-09 10:36:27.944582 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd29
osd.0.log:814449:2011-03-09 10:36:27.944592 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd29
osd.0.log:814450:2011-03-09 10:36:27.944602 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd29 172.17.40.24:6817/8412 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44231f10
osd.0.log:814451:2011-03-09 10:36:27.944613 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.24:6817/8412, have pipe.
osd.0.log:814452:2011-03-09 10:36:27.944627 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd31
osd.0.log:814453:2011-03-09 10:36:27.944635 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd31
osd.0.log:814454:2011-03-09 10:36:27.944646 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd31 172.17.40.24:6823/8620 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44064bd0
osd.0.log:814455:2011-03-09 10:36:27.944657 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.24:6823/8620, have pipe.
osd.0.log:814456:2011-03-09 10:36:27.944677 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd32
osd.0.log:814457:2011-03-09 10:36:27.944686 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd32
osd.0.log:814458:2011-03-09 10:36:27.944695 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd32 172.17.40.25:6802/16712 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e446fbdd0
osd.0.log:814459:2011-03-09 10:36:27.944706 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.25:6802/16712, have pipe.
osd.0.log:814460:2011-03-09 10:36:27.944722 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd34
osd.0.log:814461:2011-03-09 10:36:27.944744 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd34
osd.0.log:814462:2011-03-09 10:36:27.944755 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd34 172.17.40.25:6808/16908 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44222a70
osd.0.log:814463:2011-03-09 10:36:27.944765 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.25:6808/16908, have pipe.
osd.0.log:814464:2011-03-09 10:36:27.944781 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd36
osd.0.log:814465:2011-03-09 10:36:27.944790 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd36
osd.0.log:814466:2011-03-09 10:36:27.944799 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd36 172.17.40.25:6814/17105 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e441776d0
osd.0.log:814467:2011-03-09 10:36:27.944810 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.25:6814/17105, have pipe.
osd.0.log:814468:2011-03-09 10:36:27.944828 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd37
osd.0.log:814469:2011-03-09 10:36:27.944837 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd37
osd.0.log:814470:2011-03-09 10:36:27.944847 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd37 172.17.40.25:6817/17208 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4400c970
osd.0.log:814471:2011-03-09 10:36:27.944861 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.25:6817/17208, have pipe.
osd.0.log:814472:2011-03-09 10:36:27.944878 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd38
osd.0.log:814473:2011-03-09 10:36:27.944887 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd38
osd.0.log:814474:2011-03-09 10:36:27.944897 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd38 172.17.40.25:6820/17313 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e446f1b90
osd.0.log:814475:2011-03-09 10:36:27.944907 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.25:6820/17313, have pipe.
osd.0.log:814476:2011-03-09 10:36:27.944920 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd39
osd.0.log:814477:2011-03-09 10:36:27.944929 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd39
osd.0.log:814478:2011-03-09 10:36:27.944940 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd39 172.17.40.25:6823/17405 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e446cb210
osd.0.log:814701:2011-03-09 10:36:27.958449 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.25:6823/17405, have pipe.
osd.0.log:814702:2011-03-09 10:36:27.958490 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd40
osd.0.log:814703:2011-03-09 10:36:27.958501 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd40
osd.0.log:814704:2011-03-09 10:36:27.958514 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd40 172.17.40.27:6802/15995 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e446cb7b0
osd.0.log:814705:2011-03-09 10:36:27.958533 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.27:6802/15995, have pipe.
osd.0.log:814706:2011-03-09 10:36:27.958553 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd42
osd.0.log:814707:2011-03-09 10:36:27.958560 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd42
osd.0.log:814708:2011-03-09 10:36:27.958571 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd42 172.17.40.27:6808/16203 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e446cb970
osd.0.log:814709:2011-03-09 10:36:27.958582 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.27:6808/16203, have pipe.
osd.0.log:814710:2011-03-09 10:36:27.958595 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd43
osd.0.log:814711:2011-03-09 10:36:27.958605 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd43
osd.0.log:814712:2011-03-09 10:36:27.958614 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd43 172.17.40.27:6811/16295 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e446cbb30
osd.0.log:814713:2011-03-09 10:36:27.958625 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.27:6811/16295, have pipe.
osd.0.log:814714:2011-03-09 10:36:27.958654 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd44
osd.0.log:814715:2011-03-09 10:36:27.958665 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd44
osd.0.log:814716:2011-03-09 10:36:27.958681 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd44 172.17.40.27:6814/16403 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44173010
osd.0.log:814718:2011-03-09 10:36:27.958761 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.27:6814/16403, have pipe.
osd.0.log:814719:2011-03-09 10:36:27.958780 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd46
osd.0.log:814720:2011-03-09 10:36:27.958789 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd46
osd.0.log:814721:2011-03-09 10:36:27.958799 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd46 172.17.40.27:6820/16595 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44173250
osd.0.log:814722:2011-03-09 10:36:27.958809 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.27:6820/16595, have pipe.
osd.0.log:814723:2011-03-09 10:36:27.958823 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd49
osd.0.log:814724:2011-03-09 10:36:27.958832 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd49
osd.0.log:814725:2011-03-09 10:36:27.958843 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd49 172.17.40.28:6805/14276 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44173490
osd.0.log:814853:2011-03-09 10:36:27.978244 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.28:6805/14276, have pipe.
osd.0.log:814854:2011-03-09 10:36:27.978282 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd50
osd.0.log:814855:2011-03-09 10:36:27.978293 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd50
osd.0.log:814857:2011-03-09 10:36:27.978494 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd50 172.17.40.28:6808/14368 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44173810
osd.0.log:814858:2011-03-09 10:36:27.978526 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.28:6808/14368, have pipe.
osd.0.log:814859:2011-03-09 10:36:27.978560 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd51
osd.0.log:814860:2011-03-09 10:36:27.978571 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd51
osd.0.log:814861:2011-03-09 10:36:27.978582 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd51 172.17.40.28:6811/14484 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e441739d0
osd.0.log:814862:2011-03-09 10:36:27.978592 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.28:6811/14484, have pipe.
osd.0.log:814863:2011-03-09 10:36:27.978607 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd58
osd.0.log:814864:2011-03-09 10:36:27.978629 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd58
osd.0.log:814865:2011-03-09 10:36:27.978639 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd58 172.17.40.29:6808/15293 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44173b90
osd.0.log:814866:2011-03-09 10:36:27.978651 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.29:6808/15293, have pipe.
osd.0.log:814867:2011-03-09 10:36:27.978748 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd60
osd.0.log:814868:2011-03-09 10:36:27.978758 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd60
osd.0.log:814869:2011-03-09 10:36:27.978771 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd60 172.17.40.29:6814/15490 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44173d50
osd.0.log:814870:2011-03-09 10:36:27.978784 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.29:6814/15490, have pipe.
osd.0.log:814871:2011-03-09 10:36:27.978801 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd65
osd.0.log:814872:2011-03-09 10:36:27.978814 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd65
osd.0.log:814873:2011-03-09 10:36:27.978827 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd65 172.17.40.30:6805/17025 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4460d050
osd.0.log:814874:2011-03-09 10:36:27.978839 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.30:6805/17025, have pipe.
osd.0.log:814875:2011-03-09 10:36:27.978860 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd66
osd.0.log:814876:2011-03-09 10:36:27.978871 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd66
osd.0.log:814877:2011-03-09 10:36:27.978881 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd66 172.17.40.30:6808/17117 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4460d250
osd.0.log:814878:2011-03-09 10:36:27.978894 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.30:6808/17117, have pipe.
osd.0.log:814879:2011-03-09 10:36:27.978931 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd69
osd.0.log:814880:2011-03-09 10:36:27.978940 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd69
osd.0.log:814881:2011-03-09 10:36:27.978951 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd69 172.17.40.30:6817/17417 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4460d490
osd.0.log:814882:2011-03-09 10:36:27.978966 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.30:6817/17417, have pipe.
osd.0.log:814883:2011-03-09 10:36:27.978986 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd70
osd.0.log:814884:2011-03-09 10:36:27.978995 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd70
osd.0.log:814885:2011-03-09 10:36:27.979005 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd70 172.17.40.30:6820/17522 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4460d6d0
osd.0.log:814886:2011-03-09 10:36:27.979017 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.30:6820/17522, have pipe.
osd.0.log:814887:2011-03-09 10:36:27.979040 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd71
osd.0.log:814888:2011-03-09 10:36:27.979049 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd71
osd.0.log:814889:2011-03-09 10:36:27.979060 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd71 172.17.40.30:6823/17625 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4460d910
osd.0.log:814890:2011-03-09 10:36:27.979072 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.30:6823/17625, have pipe.
osd.0.log:814891:2011-03-09 10:36:27.979090 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd74
osd.0.log:814892:2011-03-09 10:36:27.979099 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd74
osd.0.log:814893:2011-03-09 10:36:27.979109 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd74 172.17.40.31:6808/15828 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4460db50
osd.0.log:814894:2011-03-09 10:36:27.979120 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.31:6808/15828, have pipe.
osd.0.log:814895:2011-03-09 10:36:27.979139 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd75
osd.0.log:814896:2011-03-09 10:36:27.979148 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd75
osd.0.log:814897:2011-03-09 10:36:27.979159 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd75 172.17.40.31:6811/15931 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4460ddb0
osd.0.log:814898:2011-03-09 10:36:27.979170 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.31:6811/15931, have pipe.
osd.0.log:814899:2011-03-09 10:36:27.979221 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd77
osd.0.log:814900:2011-03-09 10:36:27.979232 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd77
osd.0.log:814901:2011-03-09 10:36:27.979243 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd77 172.17.40.31:6817/16128 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44663010
osd.0.log:814902:2011-03-09 10:36:27.979255 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.31:6817/16128, have pipe.
osd.0.log:814903:2011-03-09 10:36:27.979272 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd78
osd.0.log:814904:2011-03-09 10:36:27.979281 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd78
osd.0.log:814905:2011-03-09 10:36:27.979292 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd78 172.17.40.31:6820/16233 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44663230
osd.0.log:814906:2011-03-09 10:36:27.979303 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.31:6820/16233, have pipe.
osd.0.log:814907:2011-03-09 10:36:27.979321 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd79
osd.0.log:814908:2011-03-09 10:36:27.979331 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd79
osd.0.log:814909:2011-03-09 10:36:27.979341 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd79 172.17.40.31:6823/16340 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44663490
osd.0.log:814910:2011-03-09 10:36:27.979354 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.31:6823/16340, have pipe.
osd.0.log:814911:2011-03-09 10:36:27.979375 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd81
osd.0.log:814912:2011-03-09 10:36:27.979384 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd81
osd.0.log:814913:2011-03-09 10:36:27.979395 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd81 172.17.40.32:6805/15965 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e446636f0
osd.0.log:814914:2011-03-09 10:36:27.979407 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.32:6805/15965, have pipe.
osd.0.log:814915:2011-03-09 10:36:27.979428 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd82
osd.0.log:814916:2011-03-09 10:36:27.979449 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd82
osd.0.log:814917:2011-03-09 10:36:27.979461 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd82 172.17.40.32:6808/16068 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44663950
osd.0.log:814918:2011-03-09 10:36:27.979475 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.32:6808/16068, have pipe.
osd.0.log:815022:2011-03-09 10:36:27.984720 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd86
osd.0.log:815023:2011-03-09 10:36:27.984741 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd86
osd.0.log:815024:2011-03-09 10:36:27.984756 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd86 172.17.40.32:6820/16464 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44663bb0
osd.0.log:815025:2011-03-09 10:36:27.984772 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.32:6820/16464, have pipe.
osd.0.log:815026:2011-03-09 10:36:27.984791 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd88
osd.0.log:815027:2011-03-09 10:36:27.984799 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd88
osd.0.log:815028:2011-03-09 10:36:27.984828 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd88 172.17.40.33:6802/23728 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e44663d70
osd.0.log:815029:2011-03-09 10:36:27.984839 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.33:6802/23728, have pipe.
osd.0.log:815030:2011-03-09 10:36:27.984854 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd89
osd.0.log:815031:2011-03-09 10:36:27.984862 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd89
osd.0.log:815032:2011-03-09 10:36:27.984872 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd89 172.17.40.33:6805/23820 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4466d010
osd.0.log:815033:2011-03-09 10:36:27.984882 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.33:6805/23820, have pipe.
osd.0.log:815034:2011-03-09 10:36:27.984895 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd90
osd.0.log:815035:2011-03-09 10:36:27.984903 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd90
osd.0.log:815036:2011-03-09 10:36:27.984912 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd90 172.17.40.33:6808/23912 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4466d250
osd.0.log:815037:2011-03-09 10:36:27.984922 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.33:6808/23912, have pipe.
osd.0.log:815038:2011-03-09 10:36:27.984936 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd91
osd.0.log:815039:2011-03-09 10:36:27.984943 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd91
osd.0.log:815040:2011-03-09 10:36:27.984952 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd91 172.17.40.33:6811/24028 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4466d490
osd.0.log:815041:2011-03-09 10:36:27.984962 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.33:6811/24028, have pipe.
osd.0.log:815042:2011-03-09 10:36:27.984975 7f7e4c9f8940 osd0 5 heartbeat allocating ping for osd93
osd.0.log:815043:2011-03-09 10:36:27.984983 7f7e4c9f8940 osd0 5 heartbeat sending ping to osd93
osd.0.log:815044:2011-03-09 10:36:27.984992 7f7e4c9f8940 -- 172.17.40.21:6802/17592 --> osd93 172.17.40.33:6817/24229 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f7e4466d6d0
osd.0.log:815045:2011-03-09 10:36:27.985002 7f7e4c9f8940 -- 172.17.40.21:6802/17592 submit_message osd_ping(e5 as_of 5) v1 remote, 172.17.40.33:6817/24229, have pipe.
osd.0.log:815046:2011-03-09 10:36:27.985014 7f7e4c9f8940 osd0 5 heartbeat check
osd.0.log:815047:2011-03-09 10:36:27.985048 7f7e4c9f8940 osd0 5 heartbeat lonely?
osd.0.log:815048:2011-03-09 10:36:27.985054 7f7e4c9f8940 osd0 5 heartbeat put map_lock
osd.0.log:815049:2011-03-09 10:36:27.985060 7f7e4c9f8940 osd0 5 heartbeat done, dropping heatbeat_lock
osd.0.log:815050:2011-03-09 10:36:27.985066 7f7e4c9f8940 osd0 5 heartbeat dropping peer_stat_lock
osd.0.log:815051:2011-03-09 10:36:27.985078 7f7e4c9f8940 osd0 5 heartbeat_entry sleeping via heatbeat_lock for 0.9
osd.0.log:815082:2011-03-09 10:36:27.985534 7f7e4fc00940 osd0 5 handle_osd_ping got heartbeat_lock
osd.0.log:815083:2011-03-09 10:36:27.985542 7f7e4fc00940 osd0 5 handle_osd_ping wants read on map_lock
osd.0.log:815084:2011-03-09 10:36:27.985548 7f7e4fc00940 osd0 5 handle_osd_ping got read on map_lock
osd.0.log:815085:2011-03-09 10:36:27.985560 7f7e4fc00940 osd0 5 _share_map_incoming osd59 172.17.40.29:6811/15398 5
osd.0.log:815086:2011-03-09 10:36:27.985569 7f7e4fc00940 osd0 5 take_peer_stat wants peer_stat_lock
osd.0.log:815087:2011-03-09 10:36:27.985575 7f7e4fc00940 osd0 5 take_peer_stat got peer_stat_lock
osd.0.log:815088:2011-03-09 10:36:27.985599 7f7e4fc00940 osd0 5 take_peer_stat peer osd59 stat(2011-03-09 10:36:23.471405 oprate=1.57375 qlen=0 recent_qlen=1.66667 rdlat=0 / 0 fshedin=0)
osd.0.log:815089:2011-03-09 10:36:27.985606 7f7e4fc00940 osd0 5 take_peer_stat dropping peer_stat_lock
osd.0.log:815090:2011-03-09 10:36:27.985614 7f7e4fc00940 osd0 5 handle_osd_ping dropping read on map_lock
osd.0.log:815091:2011-03-09 10:36:27.985620 7f7e4fc00940 osd0 5 handle_osd_ping dropping heartbeat_lock
osd.0.log:815092:2011-03-09 10:36:27.985634 7f7e4fc00940 -- 172.17.40.21:6802/17592 dispatch_throttle_release 61 to dispatch throttler 7625/35000000
osd.0.log:815093:2011-03-09 10:36:27.985643 7f7e4fc00940 -- 172.17.40.21:6802/17592 dispatch_entry done with 0xfd0560 que_et 0.000449 op_et 4.512749 tot_et 4.513198

-- Jim

> -Greg
> 
> 
> 
> 


