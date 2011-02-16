From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 16 Feb 2011 13:40:47 -0800
Message-ID: <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57103 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab1BPVkv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Feb 2011 16:40:51 -0500
Received: by iwn9 with SMTP id 9so1782081iwn.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 Feb 2011 13:40:50 -0800 (PST)
In-Reply-To: <1297891508.25491.120.camel@sale659.sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>


On Wednesday, February 16, 2011 at 1:25 PM, Jim Schutt wrote: 
> Hi,
> 
> I've been testing v0.24.3 w/ 64 clients against
> 1 mon, 1 mds, 96 osds. Under heavy write load I
> see:
>  [WRN] map e7 wrongly marked me down or wrong addr
> 
> I was able to sort through the logs and discover that when 
> this happens I have large gaps (10 seconds or more) in osd 
> heatbeat processing. In those heartbeat gaps I've discovered 
> long periods (5-15 seconds) where an osd logs nothing, even 
> though I am running with debug osd/filestore/journal = 20.
> 
> Is this a known issue?

You're running on btrfs? We've come across some issues involving very long sync times that I believe manifest like this. Sage is looking into them, although it's delayed at the moment thanks to FAST 11. :)
-Greg

> 
> 
> Below is what I've culled from my logs that show these gaps.
> Full logs available on request.
> 
> -- Jim
> 
> 
> # grep -n "wrongly" osd*.log | dshbak -c
> ----------------
> osd.17.log
> ----------------
> 472230:2011-02-16 11:40:29.340076 7fb6863d4940 log [WRN] : map e17 wrongly marked me down or wrong addr
> ----------------
> osd.46.log
> ----------------
> 489102:2011-02-16 11:40:45.756536 7f949e98c940 log [WRN] : map e25 wrongly marked me down or wrong addr
> ----------------
> osd.87.log
> ----------------
> 406661:2011-02-16 11:40:18.805586 7f0dfe3a7940 log [WRN] : map e7 wrongly marked me down or wrong addr
> ----------------
> osd.40.log
> ----------------
> 495401:2011-02-16 11:40:38.057711 7fa6681c5940 log [WRN] : map e21 wrongly marked me down or wrong addr
> 
> 
> # grep -n "no heartbeat from osd87" osd*.log | head -20 | dshbak -c
> ----------------
> osd.95.log
> ----------------
> 443261:2011-02-16 11:40:10.886318 7f4e5b53b940 osd95 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:49.424639 (cutoff 2011-02-16 11:39:50.886145)
> 443308:2011-02-16 11:40:10.887379 7f4e63f4e940 osd95 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:49.424639 (cutoff 2011-02-16 11:39:50.887216)
> 443865:2011-02-16 11:40:14.680998 7f4e5b53b940 osd95 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:49.424639 (cutoff 2011-02-16 11:39:54.680931)
> 443893:2011-02-16 11:40:14.681824 7f4e63f4e940 osd95 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:49.424639 (cutoff 2011-02-16 11:39:54.681752)
> ----------------
> osd.17.log
> ----------------
> 440651:2011-02-16 11:40:13.740999 7fb6821ca940 osd17 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:53.724161 (cutoff 2011-02-16 11:39:53.740937)
> 440763:2011-02-16 11:40:13.744726 7fb68abdd940 osd17 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:53.724161 (cutoff 2011-02-16 11:39:53.744673)
> ----------------
> osd.46.log
> ----------------
> 439491:2011-02-16 11:40:08.860936 7f9495ffb940 osd46 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:48.265285 (cutoff 2011-02-16 11:39:48.860878)
> ----------------
> osd.33.log
> ----------------
> 428947:2011-02-16 11:40:26.894541 7ffbed20c940 osd33 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:40:05.244130 (cutoff 2011-02-16 11:40:06.894512)
> 428950:2011-02-16 11:40:26.894686 7ffbf5c1f940 osd33 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:40:05.244130 (cutoff 2011-02-16 11:40:06.894669)
> ----------------
> osd.73.log
> ----------------
> 394823:2011-02-16 11:40:08.649240 7f47b060d940 osd73 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:46.962027 (cutoff 2011-02-16 11:39:48.649213)
> 394835:2011-02-16 11:40:08.655061 7f47b9020940 osd73 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:46.962027 (cutoff 2011-02-16 11:39:48.655034)
> 395138:2011-02-16 11:40:12.720296 7f47b060d940 osd73 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:46.962027 (cutoff 2011-02-16 11:39:52.720253)
> ----------------
> osd.0.log
> ----------------
> 418554:2011-02-16 11:40:11.534834 7fd5d3bd7940 osd0 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:46.939692 (cutoff 2011-02-16 11:39:51.534770)
> 418686:2011-02-16 11:40:11.568725 7fd5dc5ea940 osd0 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:46.939692 (cutoff 2011-02-16 11:39:51.549753)
> 418964:2011-02-16 11:40:13.380898 7fd5d3bd7940 osd0 5 heartbeat_check: no heartbeat from osd87 since 2011-02-16 11:39:46.939692 (cutoff 2011-02-16 11:39:53.380831)
> 
> 
> # grep -nH tick osd.87.log | egrep "11:(39:[3-9]|40:[0-2])"
> osd.87.log:379692:2011-02-16 11:39:30.678342 7f0e033b1940 osd87 5 tick
> osd.87.log:380284:2011-02-16 11:39:31.678652 7f0e033b1940 osd87 5 tick
> osd.87.log:380974:2011-02-16 11:39:32.681217 7f0e033b1940 osd87 5 tick
> osd.87.log:381406:2011-02-16 11:39:33.681646 7f0e033b1940 osd87 5 tick
> osd.87.log:382004:2011-02-16 11:39:34.681930 7f0e033b1940 osd87 5 tick
> osd.87.log:382660:2011-02-16 11:39:35.682177 7f0e033b1940 osd87 5 tick
> osd.87.log:383068:2011-02-16 11:39:36.686511 7f0e033b1940 osd87 5 tick
> osd.87.log:383849:2011-02-16 11:39:37.686750 7f0e033b1940 osd87 5 tick
> osd.87.log:384487:2011-02-16 11:39:38.687127 7f0e033b1940 osd87 5 tick
> osd.87.log:384561:2011-02-16 11:39:39.687908 7f0e033b1940 osd87 5 tick
> osd.87.log:386015:2011-02-16 11:39:41.936988 7f0e033b1940 osd87 5 tick
> osd.87.log:386467:2011-02-16 11:39:44.322215 7f0e033b1940 osd87 5 tick
> osd.87.log:388404:2011-02-16 11:39:46.399688 7f0e033b1940 osd87 5 tick
> osd.87.log:389153:2011-02-16 11:39:47.400058 7f0e033b1940 osd87 5 tick
> osd.87.log:389484:2011-02-16 11:39:48.403479 7f0e033b1940 osd87 5 tick <==
> osd.87.log:392292:2011-02-16 11:40:00.338113 7f0e033b1940 osd87 5 tick <== 12 second gap
> osd.87.log:392903:2011-02-16 11:40:01.339041 7f0e033b1940 osd87 5 tick
> osd.87.log:392948:2011-02-16 11:40:02.339450 7f0e033b1940 osd87 5 tick
> osd.87.log:394922:2011-02-16 11:40:04.740211 7f0e033b1940 osd87 5 tick
> osd.87.log:395597:2011-02-16 11:40:06.063388 7f0e033b1940 osd87 5 tick
> osd.87.log:395623:2011-02-16 11:40:07.063841 7f0e033b1940 osd87 5 tick <==
> osd.87.log:398449:2011-02-16 11:40:16.109719 7f0e033b1940 osd87 5 tick <== 9 second gap
> osd.87.log:400131:2011-02-16 11:40:17.934761 7f0e033b1940 osd87 5 tick
> osd.87.log:410005:2011-02-16 11:40:21.725596 7f0e033b1940 osd87 7 tick
> osd.87.log:412432:2011-02-16 11:40:22.725940 7f0e033b1940 osd87 11 tick
> osd.87.log:427258:2011-02-16 11:40:24.524376 7f0e033b1940 osd87 14 tick
> osd.87.log:432187:2011-02-16 11:40:25.524614 7f0e033b1940 osd87 14 tick
> osd.87.log:434222:2011-02-16 11:40:26.524970 7f0e033b1940 osd87 14 tick
> osd.87.log:438352:2011-02-16 11:40:27.525224 7f0e033b1940 osd87 15 tick
> osd.87.log:444226:2011-02-16 11:40:28.526490 7f0e033b1940 osd87 17 tick
> osd.87.log:447127:2011-02-16 11:40:29.529372 7f0e033b1940 osd87 17 tick
> 
> 
> # egrep -nHe "--> osd0 " osd.87.log | grep osd_ping | egrep "11:(39:[3-9]|40:[0-2])"
> osd.87.log:379735:2011-02-16 11:39:30.930841 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0de40c7e50
> osd.87.log:380819:2011-02-16 11:39:32.232412 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0df86c2df0
> osd.87.log:381277:2011-02-16 11:39:33.233895 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0de4041c20
> osd.87.log:381924:2011-02-16 11:39:34.638658 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0de401dda0
> osd.87.log:382680:2011-02-16 11:39:35.842033 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0de404baf0
> osd.87.log:383126:2011-02-16 11:39:36.845583 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0de406dc20
> osd.87.log:384121:2011-02-16 11:39:38.047605 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0de4039c20
> osd.87.log:384547:2011-02-16 11:39:38.949228 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x786c470
> osd.87.log:386105:2011-02-16 11:39:42.216853 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0de411f380
> osd.87.log:386366:2011-02-16 11:39:42.826071 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0df808ac20
> osd.87.log:387864:2011-02-16 11:39:45.928938 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0dc8401010
> osd.87.log:388691:2011-02-16 11:39:46.935489 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0dd800d910 <==
> osd.87.log:389579:2011-02-16 11:39:58.999668 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0dd800dd50 <== 12 second gap
> osd.87.log:391811:2011-02-16 11:39:59.604130 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0df82b1e50
> osd.87.log:392297:2011-02-16 11:40:00.405855 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x23121e0
> osd.87.log:392926:2011-02-16 11:40:02.098362 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0dd800b1d0
> osd.87.log:393945:2011-02-16 11:40:04.239303 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0dd803d6d0
> osd.87.log:395329:2011-02-16 11:40:05.240611 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0dd8033c80
> osd.87.log:395607:2011-02-16 11:40:06.142020 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0de40c7e50 <==
> osd.87.log:398446:2011-02-16 11:40:16.109618 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0de40c7e50 <== 10 second gap
> osd.87.log:399593:2011-02-16 11:40:16.712331 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0de40d8e90
> osd.87.log:400034:2011-02-16 11:40:17.913637 7f0df67fc940 -- 172.17.40.31:6823/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f0de41b2c30
> osd.87.log:424702:2011-02-16 11:40:24.116636 7f0df67fc940 -- 172.17.40.31:6825/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e0 as_of 14) v1 -- ?+0 0x7f0de404baf0
> osd.87.log:430175:2011-02-16 11:40:24.619852 7f0df67fc940 -- 172.17.40.31:6825/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e14 as_of 14) v1 -- ?+0 0x7f0de40cec30
> osd.87.log:431874:2011-02-16 11:40:25.221671 7f0df67fc940 -- 172.17.40.31:6825/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e14 as_of 14) v1 -- ?+0 0x7f0de404baf0
> osd.87.log:433563:2011-02-16 11:40:26.123080 7f0df67fc940 -- 172.17.40.31:6825/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e14 as_of 14) v1 -- ?+0 0x7f0de40cfc00
> osd.87.log:438357:2011-02-16 11:40:27.525371 7f0df67fc940 -- 172.17.40.31:6825/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e15 as_of 15) v1 -- ?+0 0x7f0de412dc20
> osd.87.log:443114:2011-02-16 11:40:28.226793 7f0df67fc940 -- 172.17.40.31:6825/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e17 as_of 17) v1 -- ?+0 0x7f0de40d3e10
> osd.87.log:445140:2011-02-16 11:40:28.829473 7f0df67fc940 -- 172.17.40.31:6825/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e17 as_of 17) v1 -- ?+0 0x7f0de412ee20
> osd.87.log:446889:2011-02-16 11:40:29.431710 7f0df67fc940 -- 172.17.40.31:6825/23945 --> osd0 172.17.40.21:6802/10701 -- osd_ping(e17 as_of 17) v1 -- ?+0 0x7f0de40d3e10
> 
> 
> # grep -nH "<== osd87 " osd.0.log | grep osd_ping | egrep "11:(39:[3-9]|40:[0-2])"
> osd.0.log:405348:2011-02-16 11:39:30.934972 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 836 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (3409844043 0 0) 0x2ce8260 con 0x7fd5cc0eb4e0
> osd.0.log:406113:2011-02-16 11:39:32.243478 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 837 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (2347402994 0 0) 0x2d08250 con 0x7fd5cc0eb4e0
> osd.0.log:407084:2011-02-16 11:39:33.315517 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 838 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (1541899367 0 0) 0x2ce8260 con 0x7fd5cc0eb4e0
> osd.0.log:407879:2011-02-16 11:39:34.643198 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 839 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (3930157039 0 0) 0x2cb6990 con 0x7fd5cc0eb4e0
> osd.0.log:408685:2011-02-16 11:39:35.847410 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 840 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (3997131881 0 0) 0x2cd0430 con 0x7fd5cc0eb4e0
> osd.0.log:409558:2011-02-16 11:39:36.850722 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 841 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (2880002961 0 0) 0x2933750 con 0x7fd5cc0eb4e0
> osd.0.log:410150:2011-02-16 11:39:38.058936 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 842 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (422669297 0 0) 0x7fd5b4026b80 con 0x7fd5cc0eb4e0
> osd.0.log:410785:2011-02-16 11:39:38.951966 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 843 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (2887960658 0 0) 0x7fd5b406d7e0 con 0x7fd5cc0eb4e0
> osd.0.log:412279:2011-02-16 11:39:42.328051 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 844 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (888536454 0 0) 0x7fd5c4434bf0 con 0x7fd5cc0eb4e0
> osd.0.log:413248:2011-02-16 11:39:44.591247 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 845 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (3942869391 0 0) 0x7fd5c4422da0 con 0x7fd5cc0eb4e0
> osd.0.log:414564:2011-02-16 11:39:46.587410 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 846 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (536010906 0 0) 0x2d0cc70 con 0x7fd5cc0eb4e0
> osd.0.log:415059:2011-02-16 11:39:46.939610 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 847 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (1952944560 0 0) 0x2cac660 con 0x7fd5cc0eb4e0 <==
> osd.0.log:418969:2011-02-16 11:40:13.382178 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 848 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (1901796990 0 0) 0x7fd5a0016010 con 0x7fd5cc0eb4e0 <== 26 second gap
> osd.0.log:419358:2011-02-16 11:40:13.423453 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 849 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (687989221 0 0) 0x7fd5a0018160 con 0x7fd5cc0eb4e0
> osd.0.log:419573:2011-02-16 11:40:13.426088 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 850 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (1942960184 0 0) 0x7fd5a0018340 con 0x7fd5cc0eb4e0
> osd.0.log:420236:2011-02-16 11:40:13.599647 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 851 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (1582392597 0 0) 0x7fd5a0018760 con 0x7fd5cc0eb4e0
> osd.0.log:420431:2011-02-16 11:40:13.638125 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 852 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (652463144 0 0) 0x7fd5a00189f0 con 0x7fd5cc0eb4e0
> osd.0.log:420737:2011-02-16 11:40:13.731877 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 853 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (3298612745 0 0) 0x7fd5a0018d20 con 0x7fd5cc0eb4e0
> osd.0.log:420907:2011-02-16 11:40:13.743052 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 854 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (3389558799 0 0) 0x7fd5a1024010 con 0x7fd5cc0eb4e0
> osd.0.log:423056:2011-02-16 11:40:20.484117 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 855 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (4197551345 0 0) 0x7fd5c4001b20 con 0x7fd5cc0eb4e0
> osd.0.log:423342:2011-02-16 11:40:20.522679 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 856 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (2447834242 0 0) 0x7fd5c40bac90 con 0x7fd5cc0eb4e0
> osd.0.log:423565:2011-02-16 11:40:20.551600 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6823/23945 857 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (3477883131 0 0) 0x7fd5c4456cb0 con 0x7fd5cc0eb4e0
> osd.0.log:431891:2011-02-16 11:40:24.336220 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6825/23945 1 ==== osd_ping(e0 as_of 14) v1 ==== 61+0+0 (981970893 0 0) 0x2b90d50 con 0x29a5e90
> osd.0.log:431957:2011-02-16 11:40:24.620956 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6825/23945 2 ==== osd_ping(e14 as_of 14) v1 ==== 61+0+0 (2171246889 0 0) 0x29069e0 con 0x29a5e90
> osd.0.log:432146:2011-02-16 11:40:25.223233 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6825/23945 3 ==== osd_ping(e14 as_of 14) v1 ==== 61+0+0 (2197848278 0 0) 0x8e7aa60 con 0x29a5e90
> osd.0.log:432373:2011-02-16 11:40:26.126494 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6825/23945 4 ==== osd_ping(e14 as_of 14) v1 ==== 61+0+0 (2473034353 0 0) 0x2caec80 con 0x29a5e90
> osd.0.log:434792:2011-02-16 11:40:27.531515 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6825/23945 5 ==== osd_ping(e15 as_of 15) v1 ==== 61+0+0 (1656259643 0 0) 0x2e10370 con 0x29a5e90
> osd.0.log:436542:2011-02-16 11:40:28.267676 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6825/23945 6 ==== osd_ping(e17 as_of 17) v1 ==== 61+0+0 (414112261 0 0) 0x2931800 con 0x29a5e90
> osd.0.log:437755:2011-02-16 11:40:28.830618 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd87 172.17.40.31:6825/23945 7 ==== osd_ping(e17 as_of 17) v1 ==== 61+0+0 (1206729933 0 0) 0x29b5d80 con 0x29a5e90
> 
> 
> 
> # grep -nH -A 10000 "11:39:49.712017" osd.87.log | grep -B 10000 "11:39:58.813658"
> osd.87.log:389490:2011-02-16 11:39:49.712017 7f0e01bae940 filestore(/ram/mnt/ceph/data.osd.0087) sync_entry committing 2101 sync_epoch 114
> osd.87.log-389491-2011-02-16 11:39:49.712521 7f0e01bae940 filestore(/ram/mnt/ceph/data.osd.0087) taking async snap 'snap_2101'
> osd.87.log-389492-2011-02-16 11:39:49.750398 7f0e01bae940 filestore(/ram/mnt/ceph/data.osd.0087) async snap create 'snap_2101' transid 134 got 0 Success
> osd.87.log-389493-2011-02-16 11:39:49.750455 7f0e01bae940 journal commit_started committing 2101, unblocking
> osd.87.log-389494-2011-02-16 11:39:49.750463 7f0e01bae940 filestore(/ram/mnt/ceph/data.osd.0087) waiting for transid 134 to complete
> osd.87.log-389495-2011-02-16 11:39:49.813245 7f0e01bae940 filestore(/ram/mnt/ceph/data.osd.0087) done waiting for transid 134 to complete
> osd.87.log-389496-2011-02-16 11:39:49.813306 7f0e01bae940 filestore(/ram/mnt/ceph/data.osd.0087) sync_entry commit took 0.101289
> osd.87.log-389497-2011-02-16 11:39:49.813313 7f0e01bae940 journal commit_finish thru 2101
> osd.87.log-389498-2011-02-16 11:39:49.813320 7f0e01bae940 journal committed_thru 2101 (last_committed_seq 2073) <==
> osd.87.log-389499-2011-02-16 11:39:58.800113 7f0dffbaa940 osd87 5 pg[0.14bc( v 5'3 (5'1,5'3] n=3 ec=2 les=4 3/3/3) [87,72] r=0 luod=5'2 lcod 5'2 mlcod 5'1 active+clean] update_stats 3'16 <== 9 second gap
> osd.87.log-389500-2011-02-16 11:39:58.800198 7f0dffbaa940 osd87 5 pg[0.14bc( v 5'3 (5'1,5'3] n=3 ec=2 les=4 3/3/3) [87,72] r=0 luod=5'2 lcod 5'2 mlcod 5'1 active+clean] eval_repop repgather(0x11493c30 applied 5'3 rep_tid=462 wfack=72 wfdisk=72,87 op=osd_op(client4232.1:72 10000009496.00000047 [write 0~4194304 [1@-1]] 0.94bc snapc 1=[])) wants=d
> osd.87.log-389501-2011-02-16 11:39:58.800233 7f0dffbaa940 osd87 5 pg[0.379( v 5'2 (0'0,5'2] n=2 ec=3 les=4 3/3/3) [77,87] r=1 luod=0'0 lcod 0'0 active] sub_op_modify_applied on 0x2298400 op osd_sub_op(client4236.1:14 0.379 10000004a4b.0000000d/head [] v 5'2 snapset=0=[]:[] snapc=0=[]) v3
> osd.87.log-389502-2011-02-16 11:39:58.813597 7f0e01bae940 journal header: block_size 4096 alignment 4096 max_size 526385152
> osd.87.log-389503-2011-02-16 11:39:58.813614 7f0e01bae940 journal header: start 86712320
> osd.87.log-389504-2011-02-16 11:39:58.813620 7f0e01bae940 journal write_pos 86712320
> osd.87.log-389505-2011-02-16 11:39:58.813626 7f0e01bae940 journal queue_completions_thru seq 2101 queueing seq 2084 0x7f0df86a0cc0
> osd.87.log-389506-2011-02-16 11:39:58.813643 7f0e01bae940 journal queue_completions_thru seq 2101 queueing seq 2085 0x7f0df8237e80
> osd.87.log-389507-2011-02-16 11:39:58.813651 7f0e01bae940 journal queue_completions_thru seq 2101 queueing seq 2086 0x7f0df81b6c90
> osd.87.log-389508-2011-02-16 11:39:58.813658 7f0e01bae940 journal queue_completions_thru seq 2101 queueing seq 2087 0x7f0df8150fb0
> 
> 
> # grep -nH -A 10000 "11:40:09.777220" osd.87.log | grep -B 10000 "11:40:14.633381"
> osd.87.log:395664:2011-02-16 11:40:09.777220 7f0e01bae940 journal queue_completions_thru seq 2138 queueing seq 2129 0x7f0dd804f630
> osd.87.log-395665-2011-02-16 11:40:09.777227 7f0e01bae940 journal queue_completions_thru seq 2138 queueing seq 2130 0x7f0dc000b230
> osd.87.log-395666-2011-02-16 11:40:09.777233 7f0e01bae940 journal queue_completions_thru seq 2138 queueing seq 2131 0x7f0dd8000b40
> osd.87.log-395667-2011-02-16 11:40:09.777239 7f0e01bae940 journal queue_completions_thru seq 2138 queueing seq 2132 0x7f0dd80a5fe0
> osd.87.log-395668-2011-02-16 11:40:09.777245 7f0e01bae940 journal queue_completions_thru seq 2138 queueing seq 2133 0x7f0dd8013fe0
> osd.87.log-395669-2011-02-16 11:40:09.777250 7f0e01bae940 journal queue_completions_thru seq 2138 queueing seq 2134 0x7f0dd8055560
> osd.87.log-395670-2011-02-16 11:40:09.777258 7f0e01bae940 journal queue_completions_thru seq 2138 queueing seq 2135 0x7f0dd801da40
> osd.87.log-395671-2011-02-16 11:40:09.777264 7f0e01bae940 journal queue_completions_thru seq 2138 queueing seq 2136 0x7f0dc0013fe0
> osd.87.log-395672-2011-02-16 11:40:09.777270 7f0e01bae940 journal queue_completions_thru seq 2138 queueing seq 2137 0x7f0dd8005290
> osd.87.log-395673-2011-02-16 11:40:09.777277 7f0e01bae940 journal queue_completions_thru seq 2138 queueing seq 2138 0x7f0dd84c23f0
> osd.87.log-395674-2011-02-16 11:40:09.777285 7f0e01bae940 journal dropping committed but unwritten seq 2124 len 4195464
> osd.87.log-395675-2011-02-16 11:40:09.777312 7f0e01bae940 journal dropping committed but unwritten seq 2125 len 4195507
> osd.87.log-395676-2011-02-16 11:40:09.777339 7f0df7fff940 journal throttle: waited for bytes
> osd.87.log-395677-2011-02-16 11:40:09.777426 7f0e023af940 osd87 5 pg[0.f90( v 5'2 (0'0,5'2] n=2 ec=3 les=4 3/3/3) [45,87] r=1 luod=0'0 lcod 0'0 active] sub_op_modify_commit on op osd_sub_op(client4196.1:130 0.f90 100000007d2.00000081/head [] v 5'2 snapset=0=[]:[] snapc=0=[]) v3, sending commit to osd45
> osd.87.log-395678-2011-02-16 11:40:09.777493 7f0dfc9a2940 journal throttle: waited for bytes <==
> osd.87.log-395679-2011-02-16 11:40:14.407019 7f0df36d9940 -- 172.17.40.31:6821/23945 >> 172.17.40.35:6800/20993 pipe(0x22b7660 sd=42 pgs=5 cs=1 l=1).reader couldn't read tag, Success <== 5 second gap
> osd.87.log-395680-2011-02-16 11:40:14.628871 7f0de3afa940 -- 172.17.40.31:6821/23945 >> 172.17.40.42:0/4169731470 pipe(0x22e9880 sd=129 pgs=6 cs=1 l=1).reader couldn't read tag, Success
> osd.87.log-395681-2011-02-16 11:40:14.628926 7f0dd41c3940 -- 172.17.40.31:6821/23945 >> 172.17.40.61:0/2426953348 pipe(0x2377140 sd=190 pgs=56 cs=1 l=1).reader couldn't read tag, Success
> osd.87.log-395682-2011-02-16 11:40:14.631264 7f0dd41c3940 -- 172.17.40.31:6821/23945 >> 172.17.40.61:0/2426953348 pipe(0x2377140 sd=190 pgs=56 cs=1 l=1).fault 0: Success
> osd.87.log-395683-2011-02-16 11:40:14.633050 7f0dd3fc1940 -- 172.17.40.31:6821/23945 >> 172.17.40.63:0/179283478 pipe(0x23776b0 sd=191 pgs=64 cs=1 l=1).reader couldn't read tag, Success
> osd.87.log-395684-2011-02-16 11:40:14.633130 7f0dd3fc1940 -- 172.17.40.31:6821/23945 >> 172.17.40.63:0/179283478 pipe(0x23776b0 sd=191 pgs=64 cs=1 l=1).fault 0: Success
> osd.87.log-395685-2011-02-16 11:40:14.633210 7f0dde2aa940 -- 172.17.40.31:6821/23945 >> 172.17.40.56:0/193342550 pipe(0x2385620 sd=154 pgs=15 cs=1 l=1).reader couldn't read tag, Success
> osd.87.log-395686-2011-02-16 11:40:14.633238 7f0dde2aa940 -- 172.17.40.31:6821/23945 >> 172.17.40.56:0/193342550 pipe(0x2385620 sd=154 pgs=15 cs=1 l=1).fault 0: Success
> osd.87.log-395687-2011-02-16 11:40:14.633308 7f0dde0a8940 -- 172.17.40.31:6821/23945 >> 172.17.40.66:0/2716831927 pipe(0x2317b20 sd=155 pgs=16 cs=1 l=1).reader couldn't read tag, Success
> osd.87.log-395688-2011-02-16 11:40:14.633335 7f0dde0a8940 -- 172.17.40.31:6821/23945 >> 172.17.40.66:0/2716831927 pipe(0x2317b20 sd=155 pgs=16 cs=1 l=1).fault 0: Success
> osd.87.log-395689-2011-02-16 11:40:14.633381 7f0dd65e5940 -- 172.17.40.31:6821/23945 >> 172.17.40.54:0/3922929349 pipe(0x22d49e0 sd=174 pgs=45 cs=1 l=1).reader couldn't read tag, Success
> 
> 
> # grep -nH -A 10000 "11:39:56.765107" osd.0.log | grep -B 10000 "11:40:11.526593"
> osd.0.log:418422:2011-02-16 11:39:56.765107 7fd5d75e0940 osd0 5 pg[0.c26( v 5'5 (5'3,5'5] n=5 ec=2 les=4 3/3/3) [25,0] r=1 luod=0'0 lcod 5'4 active] enqueue_op 0x7fd5c404d300 osd_sub_op(client4210.1:231 0.c26 10000002b03.000000e4/head [] v 5'6 snapset=0=[]:[] snapc=0=[]) v3
> osd.0.log-418423-2011-02-16 11:39:56.765131 7fd5d75e0940 -- 172.17.40.21:6801/10701 <== osd39 172.17.40.25:6822/18259 44 ==== osd_sub_op_reply(client4237.1:85 0.f51 1000000cf3d.00000054/head [] ondisk = 0) v1 ==== 127+0+0 (699474326 0 0) 0x2bfe000 con 0x7fd5c40f5280
> osd.0.log-418424-2011-02-16 11:39:56.765144 7fd5d75e0940 osd0 5 _dispatch 0x2bfe000 osd_sub_op_reply(client4237.1:85 0.f51 1000000cf3d.00000054/head [] ondisk = 0) v1
> osd.0.log-418425-2011-02-16 11:39:56.765153 7fd5d75e0940 osd0 5 require_same_or_newer_map 5 (i am 5) 0x2bfe000
> osd.0.log-418426-2011-02-16 11:39:56.765160 7fd5d75e0940 osd0 5 _share_map_incoming osd39 172.17.40.25:6822/18259 5
> osd.0.log-418427-2011-02-16 11:39:56.765171 7fd5d75e0940 osd0 5 pg[0.f51( v 5'3 (0'0,5'3] n=3 ec=3 les=4 3/3/3) [0,39] r=0 luod=5'2 lcod 5'2 mlcod 0'0 active+clean] enqueue_op 0x2bfe000 osd_sub_op_reply(client4237.1:85 0.f51 1000000cf3d.00000054/head [] ondisk = 0) v1
> osd.0.log-418428-2011-02-16 11:39:56.765195 7fd5d75e0940 -- 172.17.40.21:6801/10701 <== osd69 172.17.40.29:6816/32415 36 ==== osd_sub_op(client4239.1:93 0.5d7 1000000f26e.0000005c/head [] v 5'2 snapset=0=[]:[] snapc=0=[]) v3 ==== 532+0+4194764 (1547976727 0 29215660) 0x7fd5b40750d0 con 0x2c91590
> osd.0.log-418429-2011-02-16 11:39:56.765210 7fd5d75e0940 osd0 5 _dispatch 0x7fd5b40750d0 osd_sub_op(client4239.1:93 0.5d7 1000000f26e.0000005c/head [] v 5'2 snapset=0=[]:[] snapc=0=[]) v3
> osd.0.log-418430-2011-02-16 11:39:56.765230 7fd5d75e0940 osd0 5 handle_sub_op osd_sub_op(client4239.1:93 0.5d7 1000000f26e.0000005c/head [] v 5'2 snapset=0=[]:[] snapc=0=[]) v3 epoch 5
> osd.0.log-418431-2011-02-16 11:39:56.765239 7fd5d75e0940 osd0 5 require_same_or_newer_map 5 (i am 5) 0x7fd5b40750d0
> osd.0.log-418432-2011-02-16 11:39:56.765247 7fd5d75e0940 osd0 5 _share_map_incoming osd69 172.17.40.29:6816/32415 5
> osd.0.log-418433-2011-02-16 11:39:56.767977 7fd5db5e8940 osd0 5 pg[0.b68( v 5'1 (0'0,5'1] n=1 ec=2 les=4 3/3/3) [51,0] r=1 luod=0'0 lcod 0'0 active] sub_op_modify_commit on op osd_sub_op(client4257.1:265 0.b68 10000006d7c.00000103/head [] v 5'1 snapset=0=[]:[] snapc=0=[]) v3, sending commit to osd51
> osd.0.log-418434-2011-02-16 11:40:11.526201 7fd5dbde9940 journal queue_completions_thru seq 2253 queueing seq 2252 0x7fd5a0000ec0 <== 15 second gap
> osd.0.log-418435-2011-02-16 11:40:11.526229 7fd5dbde9940 journal queue_completions_thru seq 2253 queueing seq 2253 0x7fd59800f790
> osd.0.log-418436-2011-02-16 11:40:11.526242 7fd5dbde9940 journal write_thread throttle finished 3 ops and 12586409 bytes, now 5 ops and 20977433 bytes
> osd.0.log-418437-2011-02-16 11:40:11.526278 7fd5dbde9940 journal room 501166079 max_size 526385152 pos 127389696 header.start 102174720 top 4096
> osd.0.log-418438-2011-02-16 11:40:11.526285 7fd5dbde9940 journal check_for_full at 127389696 : 4202496 < 501166079
> osd.0.log-418439-2011-02-16 11:40:11.526291 7fd5dbde9940 journal prepare_single_write 1 will write 127389696 : seq 2254 len 4195516 -> 4202496 (head 40 pre_pad 3891 ebl 4195516 post_pad 3009 tail 40) (ebl alignment 3931)
> osd.0.log-418440-2011-02-16 11:40:11.526309 7fd5dbde9940 journal room 496963583 max_size 526385152 pos 131592192 header.start 102174720 top 4096
> osd.0.log-418441-2011-02-16 11:40:11.526316 7fd5dbde9940 journal check_for_full at 131592192 : 4202496 < 496963583
> osd.0.log-418442-2011-02-16 11:40:11.526321 7fd5dbde9940 journal prepare_single_write 2 will write 131592192 : seq 2255 len 4195464 -> 4202496 (head 40 pre_pad 3891 ebl 4195464 post_pad 3061 tail 40) (ebl alignment 3931)
> osd.0.log-418443-2011-02-16 11:40:11.526331 7fd5dbde9940 journal room 492761087 max_size 526385152 pos 135794688 header.start 102174720 top 4096
> osd.0.log-418444-2011-02-16 11:40:11.526337 7fd5dbde9940 journal check_for_full at 135794688 : 4202496 < 492761087
> osd.0.log-418445-2011-02-16 11:40:11.526343 7fd5dbde9940 journal prepare_single_write 3 will write 135794688 : seq 2256 len 4195446 -> 4202496 (head 40 pre_pad 3895 ebl 4195446 post_pad 3075 tail 40) (ebl alignment 3935)
> osd.0.log-418446-2011-02-16 11:40:11.526593 7fd5d6ddf940 -- 172.17.40.21:6802/10701 <== osd42 172.17.40.26:6808/8729 877 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (3742513708 0 0) 0x7fd5c43e1c30 con 0x7fd5cc0e3d90
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

