From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 9 Mar 2011 09:07:51 -0800
Message-ID: <2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
 <1299686572.4750.329.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59761 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757066Ab1CIRIF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2011 12:08:05 -0500
Received: by qwd7 with SMTP id 7so547072qwd.19
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2011 09:08:05 -0800 (PST)
In-Reply-To: <1299686572.4750.329.camel@sale659.sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@newdream.net>, "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Wednesday, March 9, 2011 at 8:02 AM, Jim Schutt wrote:
> Heh. Evidently I didn't do the instrumentation right.
> Or more specifically, I didn't look in the right places
> for the result I needed.
> 
> Once I understood the code/logging enough to write a
> script to look for delayed osd_ping message processing,
> I found evidence that the heartbeat lock is contended:
> 
> osd.62.log:798249:2011-03-09 08:23:46.710315 7f361bb09940 -- 172.17.40.29:6820/28024 >> 172.17.40.32:6802/28608 pipe(0x25e3c40 sd=117 pgs=70 cs=1 l=0).reader got message 254 0x290c040 osd_ping(e5 as_of 5) v1
> osd.62.log:798254:2011-03-09 08:23:46.710380 7f3633682940 -- 172.17.40.29:6820/28024 dispatch_entry pipe 0x25e3c40 dequeued 0x290c040
> osd.62.log:798255:2011-03-09 08:23:46.710393 7f3633682940 -- 172.17.40.29:6820/28024 <== osd80 172.17.40.32:6802/28608 254 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (757971450 0 0) 0x290c040 con 0x25e3ec0
> osd.62.log:798256:2011-03-09 08:23:46.710401 7f3633682940 osd62 5 heartbeat_dispatch 0x290c040
> osd.62.log:798257:2011-03-09 08:23:46.710415 7f3633682940 osd62 5 handle_osd_ping from osd80 got stat stat(2011-03-09 08:23:46.703991 oprate=7.91906 qlen=4.5 recent_qlen=4.43333 rdlat=0 / 0 fshedin=0)
> osd.62.log:798258:2011-03-09 08:23:46.710422 7f3633682940 osd62 5 handle_osd_ping wants heartbeat_lock
> osd.62.log:804833:2011-03-09 08:23:59.549923 7f3633682940 osd62 5 handle_osd_ping got heartbeat_lock
> osd.62.log:804834:2011-03-09 08:23:59.549940 7f3633682940 osd62 5 handle_osd_ping wants read on map_lock
> osd.62.log:804835:2011-03-09 08:23:59.549947 7f3633682940 osd62 5 handle_osd_ping got read on map_lock
> osd.62.log:804836:2011-03-09 08:23:59.549965 7f3633682940 osd62 5 _share_map_incoming osd80 172.17.40.32:6802/28608 5
> osd.62.log:804837:2011-03-09 08:23:59.549980 7f3633682940 osd62 5 take_peer_stat wants peer_stat_lock
> osd.62.log:804838:2011-03-09 08:23:59.549986 7f3633682940 osd62 5 take_peer_stat got peer_stat_lock
> osd.62.log:804839:2011-03-09 08:23:59.550001 7f3633682940 osd62 5 take_peer_stat peer osd80 stat(2011-03-09 08:23:46.703991 oprate=7.91906 qlen=4.5 recent_qlen=4.43333 rdlat=0 / 0 fshedin=0)
> osd.62.log:804840:2011-03-09 08:23:59.550009 7f3633682940 osd62 5 take_peer_stat dropping peer_stat_lock
> osd.62.log:804841:2011-03-09 08:23:59.550036 7f3633682940 osd62 5 handle_osd_ping dropping read on map_lock
> osd.62.log:804842:2011-03-09 08:23:59.550043 7f3633682940 osd62 5 handle_osd_ping dropping heartbeat_lock
> osd.62.log:804843:2011-03-09 08:23:59.550062 7f3633682940 -- 172.17.40.29:6820/28024 dispatch_throttle_release 61 to dispatch throttler 26840/35000000
> osd.62.log:804844:2011-03-09 08:23:59.550073 7f3633682940 -- 172.17.40.29:6820/28024 dispatch_entry done with 0x290c040 que_et 0.000078 op_et 12.839669 tot_et 12.839747
> 
> I still need to gather evidence on who is holding heartbeat_lock
> in cases like this. Still digging.....
> 
> I'm sorry it took me so long to find some evidence about what 
> was going on.
> 
> -- Jim
> Are you going through map spam at this point? If so, I'd pay special attention to update_heartbeat_peers, which is going to iterate through each PG (...in the cluster. Hmm, I thought that was never supposed to happen) on every map update. This has been known to take a bit of time (how many PGs does your cluster have at this point?), although it may be a case of the debugging taking up more time than the actual processing here.
-Greg



