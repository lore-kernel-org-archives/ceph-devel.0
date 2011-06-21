From: Sage Weil <sage@newdream.net>
Subject: Re: MDS Stuck In Replay
Date: Tue, 21 Jun 2011 15:48:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106211545340.28760@cobra.newdream.net>
References: <B828A4C02BE12543ACDFCF7EB0C693C67886252F0F@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53661 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665Ab1FUWqI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2011 18:46:08 -0400
In-Reply-To: <B828A4C02BE12543ACDFCF7EB0C693C67886252F0F@NC-SVR-09.netelligent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 21 Jun 2011, Mark Nigh wrote:
> I am currently testing Ceph on Debian v6.0 (2.6.32) on the following system:
> 
> 2 servers each with 2 HDD and 1 osd per HDD for a total of 4 OSD
> The 1st server has a one (1) mds and mon.
> 
> Ceph gets built and functioning correctly but I think it is when I 
> change my crushmap so that no data is stored on a single server that I 
> get my mds in replay. I also get some pgs in peering. See below.

If there are PGs in peering it will block MDS replay, so that's the core 
issue. 

Can you include the 'ceph osd dump -o -' output so we can verify the 
object pools are using the data and metadata crush rules?

You can also verify that the individual crush rules are working with 
something like

$ ceph osd getcrushmap -o cm
2011-06-21 15:44:09.434742 mon <- [osd,getcrushmap]
2011-06-21 15:44:09.435168 mon0 -> 'got crush map from osdmap epoch 2' (0)
2011-06-21 15:44:09.435370 7f8fd5b22720  wrote 320 byte payload to cm
$ crushtool -i cm --test --rule 0
devices weights (hex): [10000]
rule 0 (data), x = 0..9999
 device 0:      10000
 num results 1: 10000
$ crushtool -i cm --test --rule 1
devices weights (hex): [10000]
rule 1 (metadata), x = 0..9999
 device 0:      10000
 num results 1: 10000

In your case you should see the objects split between 4 OSDs, not the 1 I 
currently have running on my dev box.

sage


> 
> 2011-06-21 16:49:01.551129    pg v1497: 396 pgs: 272 active+clean, 124 peering; 374 MB data, 773 MB used, 11117 GB / 11118 GB avail
> 2011-06-21 16:49:01.551817   mds e10: 1/1/1 up {0=0=up:replay}
> 2011-06-21 16:49:01.551836   osd e602: 4 osds: 4 up, 4 in
> 2011-06-21 16:49:01.551898   log 2011-06-21 16:41:46.966074 mon0 10.6.1.80:6789/0 1 : [INF] mon.0@0 won leader election with quorum 0
> 2011-06-21 16:49:01.551947   mon e1: 1 mons at {0=10.6.1.80:6789/0}
> 
> My crushmap is as follows:
> 
> # begin crush map
> 
> # devices
> device 0 device0
> device 1 device1
> device 2 device2
> device 3 device3
> 
> # types
> type 0 device
> type 1 host
> type 2 root
> 
> # buckets
> host host0 {
>         id -1           # do not change unnecessarily
>         # weight 2.000
>         alg straw
>         hash 0  # rjenkins1
>         item device0 weight 1.000
>         item device1 weight 1.000
> }
> host host1 {
>         id -2           # do not change unnecessarily
>         # weight 2.000
>         alg straw
>         hash 0  # rjenkins1
>         item device2 weight 1.000
>         item device3 weight 1.000
> }
> root root {
>         id -3           # do not change unnecessarily
>         # weight 2.000
>         alg straw
>         hash 0  # rjenkins1
>         item host0 weight 1.000
>         item host1 weight 1.000
> }
> 
> # rules
> rule data {
>         ruleset 0
>         type replicated
>         min_size 1
>         max_size 10
>         step take root
>         step chooseleaf firstn 0 type host
>         step emit
> }
> rule metadata {
>         ruleset 1
>         type replicated
>         min_size 1
>         max_size 10
>         step take root
>         step choose firstn 0 type device
>         step emit
> }
> 
> I tried to restart the mds daemon with no luck. Here are a few lines of the mds log. Let me know if there is anything else I can provide.
> 
> 2011-06-21 16:50:44.047829 7f2fa8483700 -- 10.6.1.80:6800/19997 >> 10.6.1.80:6789/0 pipe(0x281d280 sd=10 pgs=1 cs=1 l=1).reader got message 141 0x283e780 mdsbeacon(4221/0 up:replay seq 141 v10) v2
> 2011-06-21 16:50:44.047892 7f2fac6fe700 -- 10.6.1.80:6800/19997 >> 10.6.1.80:6789/0 pipe(0x281d280 sd=10 pgs=1 cs=1 l=1).writer: state = 2 policy.server=0
> 2011-06-21 16:50:44.047918 7f2fac6fe700 -- 10.6.1.80:6800/19997 >> 10.6.1.80:6789/0 pipe(0x281d280 sd=10 pgs=1 cs=1 l=1).write_ack 141
> 2011-06-21 16:50:44.047944 7f2fac6fe700 -- 10.6.1.80:6800/19997 >> 10.6.1.80:6789/0 pipe(0x281d280 sd=10 pgs=1 cs=1 l=1).writer: state = 2 policy.server=0
> 2011-06-21 16:50:44.047969 7f2fa9485700 -- 10.6.1.80:6800/19997 <== mon0 10.6.1.80:6789/0 141 ==== mdsbeacon(4221/0 up:replay seq 141 v10) v2 ==== 103+0+0 (2350252520 0 0) 0x283e780 con 0x283d140
> 2011-06-21 16:50:44.047986 7f2fa9485700 -- 10.6.1.80:6800/19997 dispatch_throttle_release 103 to dispatch throttler 103/104857600
> 2011-06-21 16:50:44.058654 7f2fa8382700 -- 10.6.1.80:6800/19997 --> osd2 10.6.1.81:6800/1826 -- ping v1 -- ?+0 0x2841300
> 2011-06-21 16:50:44.058677 7f2fa8382700 -- 10.6.1.80:6800/19997 --> osd0 10.6.1.80:6801/1891 -- ping v1 -- ?+0 0x2841180
> 2011-06-21 16:50:44.058701 7f2fa6d7a700 -- 10.6.1.80:6800/19997 >> 10.6.1.81:6800/1826 pipe(0x2836a00 sd=9 pgs=7 cs=1 l=1).writer: state = 2 policy.server=0
> 2011-06-21 16:50:44.058730 7f2fa6d7a700 -- 10.6.1.80:6800/19997 >> 10.6.1.81:6800/1826 pipe(0x2836a00 sd=9 pgs=7 cs=1 l=1).writer: state = 2 policy.server=0
> 2011-06-21 16:50:44.058765 7f2fa727f700 -- 10.6.1.80:6800/19997 >> 10.6.1.80:6801/1891 pipe(0x281dc80 sd=7 pgs=6 cs=1 l=1).writer: state = 2 policy.server=0
> 2011-06-21 16:50:44.058810 7f2fa727f700 -- 10.6.1.80:6800/19997 >> 10.6.1.80:6801/1891 pipe(0x281dc80 sd=7 pgs=6 cs=1 l=1).writer: state = 2 policy.server=0
> 
> Mark Nigh
> Systems Architect
> Netelligent Corporation
> 
> 
> 
> This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
