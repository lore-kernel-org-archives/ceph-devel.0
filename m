From: femi anjorin <femi.anjorin@gmail.com>
Subject: CEPH HEALTH NOT OK ceph version 0.56.2.!!!
Date: Mon, 4 Feb 2013 13:21:28 +0100
Message-ID: <CAPhYxPy=HqwYgZ9RfW0a9-LtDB2nTMOB33Hc6KhGcJ+zYfEmxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:54146 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab3BDMV3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 07:21:29 -0500
Received: by mail-qa0-f54.google.com with SMTP id hg5so1234832qab.20
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 04:21:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The mon is ok
The mds is ok
The osds were properly mount by mkcephfs -mkfs

But "ceph health" wont respond  ok !!!




[root@testserver025 ~]# ceph -s
2013-02-04 13:11:02.301645 7f675d82a760  1 -- :/0 messenger.start
2013-02-04 13:11:02.302507 7f675d82a760  1 -- :/22779 -->
172.16.0.25:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0
0x1f1caf0 con 0x1f1c750
2013-02-04 13:11:02.302716 7f675d828700  1 -- 172.16.0.25:0/22779
learned my addr 172.16.0.25:0/22779
2013-02-04 13:11:02.303345 7f6758b6f700  1 -- 172.16.0.25:0/22779 <==
mon.0 172.16.0.25:6789/0 1 ==== mon_map v1 ==== 473+0+0 (1506918310 0
0) 0x7f6744000b10 con 0x1f1c750
2013-02-04 13:11:02.303471 7f6758b6f700  1 -- 172.16.0.25:0/22779 <==
mon.0 172.16.0.25:6789/0 2 ==== auth_reply(proto 2 0 Success) v1 ====
33+0+0 (209143387 0 0) 0x7f6744000eb0 con 0x1f1c750
2013-02-04 13:11:02.303646 7f6758b6f700  1 -- 172.16.0.25:0/22779 -->
172.16.0.25:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0
0x7f6748001620 con 0x1f1c750
2013-02-04 13:11:02.304003 7f6758b6f700  1 -- 172.16.0.25:0/22779 <==
mon.0 172.16.0.25:6789/0 3 ==== auth_reply(proto 2 0 Success) v1 ====
206+0+0 (1623998371 0 0) 0x7f6744000eb0 con 0x1f1c750
2013-02-04 13:11:02.304108 7f6758b6f700  1 -- 172.16.0.25:0/22779 -->
172.16.0.25:6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0
0x7f6748003720 con 0x1f1c750
2013-02-04 13:11:02.304548 7f6758b6f700  1 -- 172.16.0.25:0/22779 <==
mon.0 172.16.0.25:6789/0 4 ==== auth_reply(proto 2 0 Success) v1 ====
409+0+0 (664972904 0 0) 0x7f6744000eb0 con 0x1f1c750
2013-02-04 13:11:02.304632 7f6758b6f700  1 -- 172.16.0.25:0/22779 -->
172.16.0.25:6789/0 -- mon_subscribe({monmap=0+}) v2 -- ?+0 0x1f18db0
con 0x1f1c750
2013-02-04 13:11:02.304713 7f675d82a760  1 -- 172.16.0.25:0/22779 -->
172.16.0.25:6789/0 -- mon_command(status v 0) v1 -- ?+0 0x1f1caf0 con
0x1f1c750
2013-02-04 13:11:02.304917 7f6758b6f700  1 -- 172.16.0.25:0/22779 <==
mon.0 172.16.0.25:6789/0 5 ==== mon_map v1 ==== 473+0+0 (1506918310 0
0) 0x7f67440010e0 con 0x1f1c750
2013-02-04 13:11:02.305025 7f6758b6f700  1 -- 172.16.0.25:0/22779 <==
mon.0 172.16.0.25:6789/0 6 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0
(3271567554 0 0) 0x7f67440012c0 con 0x1f1c750
2013-02-04 13:11:02.306547 7f6758b6f700  1    health HEALTH_OK
   monmap e1: 3 mons at
{a=172.16.0.25:6789/0,b=172.16.0.26:6789/0,c=172.16.1.15:6789/0},
election epoch 8, quorum 0,1,2 a,b,c
   osdmap e24: 48 osds: 48 up, 48 in
    pgmap v621: 9408 pgs: 9408 active+clean; 8730 bytes data, 470 GB
used, 88765 GB / 89235 GB avail
   mdsmap e6: 1/1/1 up {0=a=up:active}

-- 172.16.0.25:0/22779 <== mon.0 172.16.0.25:6789/0 7 ====
mon_command_ack([status]=0    health HEALTH_OK
   monmap e1: 3 mons at
{a=172.16.0.25:6789/0,b=172.16.0.26:6789/0,c=172.16.1.15:6789/0},
election epoch 8, quorum 0,1,2 a,b,c
   osdmap e24: 48 osds: 48 up, 48 in
    pgmap v621: 9408 pgs: 9408 active+clean; 8730 bytes data, 470 GB
used, 88765 GB / 89235 GB avail
   mdsmap e6: 1/1/1 up {0=a=up:active}
 v0) v1 ==== 364+0+0 (2352294466 0 0) 0x7f6744000eb0 con 0x1f1c750
2013-02-04 13:11:02.306632 7f675d82a760  1 -- 172.16.0.25:0/22779 mark_down_all
2013-02-04 13:11:02.306769 7f675d82a760  1 -- 172.16.0.25:0/22779
shutdown complete.



[root@testserver025 ~]# ceph health
2013-02-04 12:56:12.807832 7f14a7874760  1 -- :/0 messenger.start
2013-02-04 12:56:12.808727 7f14a7874760  1 -- :/22696 -->
172.16.1.15:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0
0x2311af0 con 0x2311750
2013-02-04 12:56:12.809303 7f14a7872700  1 -- 172.16.0.25:0/22696
learned my addr 172.16.0.25:0/22696
2013-02-04 12:56:15.808705 7f14a2bb9700  1 -- 172.16.0.25:0/22696
mark_down 0x2311750 -- 0x2311500
2013-02-04 12:56:15.808860 7f14a2bb9700  1 -- 172.16.0.25:0/22696 -->
172.16.0.26:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0
0x7f148c001340 con 0x7f148c000e50
2013-02-04 12:56:15.809926 7f149bfff700  1 -- 172.16.0.25:0/22696 <==
mon.1 172.16.0.26:6789/0 1 ==== mon_map v1 ==== 473+0+0 (1506918310 0
0) 0x7f1490000b10 con 0x7f148c000e50
2013-02-04 12:56:15.810159 7f149bfff700  1 -- 172.16.0.25:0/22696 <==
mon.1 172.16.0.26:6789/0 2 ==== auth_reply(proto 2 0 Success) v1 ====
33+0+0 (160457852 0 0) 0x7f1490000eb0 con 0x7f148c000e50
2013-02-04 12:56:15.810374 7f149bfff700  1 -- 172.16.0.25:0/22696 -->
172.16.0.26:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0
0x7f1484001620 con 0x7f148c000e50
2013-02-04 12:56:15.810861 7f149bfff700  1 -- 172.16.0.25:0/22696 <==
mon.1 172.16.0.26:6789/0 3 ==== auth_reply(proto 2 0 Success) v1 ====
206+0+0 (2949780099 0 0) 0x7f1490000eb0 con 0x7f148c000e50
2013-02-04 12:56:15.810971 7f149bfff700  1 -- 172.16.0.25:0/22696 -->
172.16.0.26:6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0
0x7f1484003720 con 0x7f148c000e50
2013-02-04 12:56:15.811670 7f149bfff700  1 -- 172.16.0.25:0/22696 <==
mon.1 172.16.0.26:6789/0 4 ==== auth_reply(proto 2 0 Success) v1 ====
409+0+0 (1777039547 0 0) 0x7f1490000eb0 con 0x7f148c000e50
2013-02-04 12:56:15.811769 7f149bfff700  1 -- 172.16.0.25:0/22696 -->
172.16.0.26:6789/0 -- mon_subscribe({monmap=0+}) v2 -- ?+0
0x7f148c0018d0 con 0x7f148c000e50
2013-02-04 12:56:15.811851 7f14a7874760  1 -- 172.16.0.25:0/22696 -->
172.16.0.26:6789/0 -- mon_command(health v 0) v1 -- ?+0 0x230bc40 con
0x7f148c000e50
2013-02-04 12:56:15.812085 7f149bfff700  1 -- 172.16.0.25:0/22696 <==
mon.1 172.16.0.26:6789/0 5 ==== mon_map v1 ==== 473+0+0 (1506918310 0
0) 0x7f14900010e0 con 0x7f148c000e50
2013-02-04 12:56:15.812139 7f149bfff700  1 -- 172.16.0.25:0/22696 <==
mon.1 172.16.0.26:6789/0 6 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0
(3271567554 0 0) 0x7f14900012c0 con 0x7f148c000e50
2013-02-04 12:56:15.818985 7f149bfff700  1 HEALTH_WARN 4987 pgs
peering; 4987 pgs stuck inactive; 5109 pgs stuck unclean
-- 172.16.0.25:0/22696 <== mon.1 172.16.0.26:6789/0 7 ====
mon_command_ack([health]=0 HEALTH_WARN 4987 pgs peering; 4987 pgs
stuck inactive; 5109 pgs stuck unclean v0) v1 ==== 117+0+0 (2764087526
0 0) 0x7f1490000eb0 con 0x7f148c000e50
2013-02-04 12:56:15.819062 7f14a7874760  1 -- 172.16.0.25:0/22696 mark_down_all
2013-02-04 12:56:15.819365 7f14a7874760  1 -- 172.16.0.25:0/22696
shutdown complete.




[root@testserver025 ~]# ceph -w
2013-02-04 13:03:08.082951 7fc2bf991760  1 -- :/0 messenger.start
2013-02-04 13:03:08.083874 7fc2bf991760  1 -- :/22739 -->
172.16.0.26:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0
0x13a5af0 con 0x13a5750
2013-02-04 13:03:08.084345 7fc2bf98f700  1 -- 172.16.0.25:0/22739
learned my addr 172.16.0.25:0/22739
2013-02-04 13:03:08.085059 7fc2b3fff700  1 -- 172.16.0.25:0/22739 <==
mon.1 172.16.0.26:6789/0 1 ==== mon_map v1 ==== 473+0+0 (1506918310 0
0) 0x7fc2a4000b10 con 0x13a5750
2013-02-04 13:03:08.085186 7fc2b3fff700  1 -- 172.16.0.25:0/22739 <==
mon.1 172.16.0.26:6789/0 2 ==== auth_reply(proto 2 0 Success) v1 ====
33+0+0 (2216157222 0 0) 0x7fc2a4000eb0 con 0x13a5750
2013-02-04 13:03:08.085342 7fc2b3fff700  1 -- 172.16.0.25:0/22739 -->
172.16.0.26:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0
0x7fc2a8001620 con 0x13a5750
2013-02-04 13:03:08.085900 7fc2b3fff700  1 -- 172.16.0.25:0/22739 <==
mon.1 172.16.0.26:6789/0 3 ==== auth_reply(proto 2 0 Success) v1 ====
206+0+0 (4026924408 0 0) 0x7fc2a4000eb0 con 0x13a5750
2013-02-04 13:03:08.086027 7fc2b3fff700  1 -- 172.16.0.25:0/22739 -->
172.16.0.26:6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0
0x7fc2a8003720 con 0x13a5750
2013-02-04 13:03:08.086555 7fc2b3fff700  1 -- 172.16.0.25:0/22739 <==
mon.1 172.16.0.26:6789/0 4 ==== auth_reply(proto 2 0 Success) v1 ====
409+0+0 (1918653217 0 0) 0x7fc2a4000eb0 con 0x13a5750
2013-02-04 13:03:08.086640 7fc2b3fff700  1 -- 172.16.0.25:0/22739 -->
172.16.0.26:6789/0 -- mon_subscribe({monmap=0+}) v2 -- ?+0 0x13a1db0
con 0x13a5750
2013-02-04 13:03:08.086716 7fc2bf991760  1 -- 172.16.0.25:0/22739 -->
172.16.0.26:6789/0 -- mon_command(status v 0) v1 -- ?+0 0x13a5af0 con
0x13a5750
2013-02-04 13:03:08.086977 7fc2b3fff700  1 -- 172.16.0.25:0/22739 <==
mon.1 172.16.0.26:6789/0 5 ==== mon_map v1 ==== 473+0+0 (1506918310 0
0) 0x7fc2a40010e0 con 0x13a5750
2013-02-04 13:03:08.087028 7fc2b3fff700  1 -- 172.16.0.25:0/22739 <==
mon.1 172.16.0.26:6789/0 6 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0
(3271567554 0 0) 0x7fc2a40012c0 con 0x13a5750
   health HEALTH_OK
   monmap e1: 3 mons at
{a=172.16.0.25:6789/0,b=172.16.0.26:6789/0,c=172.16.1.15:6789/0},
election epoch 8, quorum 0,1,2 a,b,c
   osdmap e24: 48 osds: 48 up, 48 in
    pgmap v436: 9408 pgs: 9408 active+clean; 8730 bytes data, 470 GB
used, 88765 GB / 89235 GB avail
   mdsmap e6: 1/1/1 up {0=a=up:active}

2013-02-04 13:03:08.088078 7fc2b3fff700  1 -- 172.16.0.25:0/22739 <==
mon.1 172.16.0.26:6789/0 7 ==== mon_command_ack([status]=0    health
HEALTH_OK
   monmap e1: 3 mons at
{a=172.16.0.25:6789/0,b=172.16.0.26:6789/0,c=172.16.1.15:6789/0},
election epoch 8, quorum 0,1,2 a,b,c
   osdmap e24: 48 osds: 48 up, 48 in
    pgmap v436: 9408 pgs: 9408 active+clean; 8730 bytes data, 470 GB
used, 88765 GB / 89235 GB avail
   mdsmap e6: 1/1/1 up {0=a=up:active}
 v0) v1 ==== 364+0+0 (1157259799 0 0) 0x7fc2a4000eb0 con 0x13a5750
2013-02-04 13:03:08.088153 7fc2bf991760  1 -- 172.16.0.25:0/22739 -->
172.16.0.26:6789/0 -- mon_subscribe({log-info=0+,monmap=2+}) v2 -- ?+0
0x13a5db0 con 0x13a5750
2013-02-04 13:03:06.042936 osd.21 [INF] 2.a79 deep-scrub ok
2013-02-04 13:03:08.088445 7fc2b3fff700  1 -- 172.16.0.25:0/22739 <==
mon.1 172.16.0.26:6789/0 8 ==== log(1 entries) v1 ==== 230+0+0
(3847198442 0 0) 0x7fc2a4001270 con 0x13a5750
2013-02-04 13:03:08.088475 7fc2b3fff700  1 -- 172.16.0.25:0/22739 <==
mon.1 172.16.0.26:6789/0 9 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0
(3271567554 0 0) 0x7fc2a4001480 con 0x13a5750
2013-02-04 13:02:57.247144 osd.36 [INF] 2.48e deep-scrub ok
2013-02-04 13:02:57.747104 osd.0 [INF] 2.242 deep-scrub ok
2013-02-04 13:02:57.864480 2013-02-04 13:03:09.275718 7fc2b3fff700  1
-- 172.16.0.25:0/22739 <== mon.1 172.16.0.26:6789/0 10 ==== log(39
entries) v1 ==== 7603+0+0 (363759634 0 0) 0x7fc2a4003240 con
0x13a5750osd.34 [INF] 1.1bc deep-scrub ok
2013-02-04 13:02:57.916455
osd.33 [INF] 2.15b deep-scrub ok
2013-02-04 13:02:57.923913 osd.23 [INF] 2.95f deep-scrub ok
2013-02-04 13:02:57.931456 osd.16 [INF] 2.5d5 deep-scrub ok
2013-02-04 13:02:58.864651 osd.34 [INF] 1.1cc deep-scrub ok
2013-02-04 13:02:59.352026 osd.50 [INF] 2.960 deep-scrub ok
2013-02-04 13:02:59.745652 osd.0 [INF] 2.24a deep-scrub ok
2013-02-04 13:02:59.865961 osd.34 [INF] 1.1fa deep-scrub ok
2013-02-04 13:02:59.885396 osd.71 [INF] 2.8eb deep-scrub ok
2013-02-04 13:03:00.102724 osd.48 [INF] 2.9c1 deep-scrub ok
2013-02-04 13:03:00.301870 osd.22 [INF] 1.c35 deep-scrub ok
2013-02-04 13:03:00.746011 osd.0 [INF] 2.27b deep-scrub ok
2013-02-04 13:03:00.872559 osd.55 [INF] 2.6a2 deep-scrub ok
2013-02-04 13:03:00.886897 osd.71 [INF] 2.918 deep-scrub ok
2013-02-04 13:03:00.979419 osd.2 [INF] 2.889 deep-scrub ok
2013-02-04 13:03:01.916959 osd.33 [INF] 2.163 deep-scrub ok
2013-02-04 13:03:01.934435 osd.16 [INF] 2.5da deep-scrub ok
2013-02-04 13:03:01.979941 osd.2 [INF] 2.8ef deep-scrub ok
2013-02-04 13:03:02.249065 osd.36 [INF] 2.4bd deep-scrub ok
2013-02-04 13:03:02.353631 osd.50 [INF] 2.9c9 deep-scrub ok
2013-02-04 13:03:02.867474 osd.34 [INF] 1.1fd deep-scrub ok
2013-02-04 13:03:02.873493 osd.55 [INF] 2.6a8 deep-scrub ok
2013-02-04 13:03:03.104359 osd.48 [INF] 2.9c4 deep-scrub ok
2013-02-04 13:03:03.250735 osd.36 [INF] 2.50a deep-scrub ok
2013-02-04 13:03:03.888246 osd.71 [INF] 2.923 deep-scrub ok
2013-02-04 13:03:04.106118 osd.48 [INF] 2.a1f deep-scrub ok
2013-02-04 13:03:04.250515 osd.36 [INF] 2.52a deep-scrub ok
2013-02-04 13:03:04.302511 osd.22 [INF] 1.c3d deep-scrub ok
2013-02-04 13:03:04.354593 osd.50 [INF] 2.a2b deep-scrub ok
2013-02-04 13:03:04.867924 osd.34 [INF] 1.250 deep-scrub ok
2013-02-04 13:03:04.916978 osd.33 [INF] 2.168 deep-scrub ok
2013-02-04 13:03:05.106740 osd.48 [INF] 2.a7d deep-scrub ok
2013-02-04 13:03:05.889018 osd.71 [INF] 2.94a deep-scrub ok
2013-02-04 13:03:05.926357 osd.23 [INF] 2.9a2 deep-scrub ok
2013-02-04 13:03:05.983809 osd.2 [INF] 2.97c deep-scrub ok
2013-02-04 13:03:06.240362 mon.0 [INF] pgmap v435: 9408 pgs: 9408
active+clean; 8730 bytes data, 470 GB used, 88765 GB / 89235 GB avail
2013-02-04 13:03:06.252814 osd.36 [INF] 2.530 deep-scrub ok
2013-02-04 13:03:00.089605 osd.80 [INF] 2.6d3 deep-scrub ok
2013-02-04 13:03:00.814241 osd.38 [INF] 2.18c deep-scrub ok
2013-02-04 13:03:00.905999 2013-02-04 13:03:10.532962 7fc2b3fff700  1
osd.6 [INF] -- 172.16.0.25:0/22739 <== mon.1 172.16.0.26:6789/0 11
==== log(26 entries) v1 ==== 5106+0+0 (1596090593 0 0) 0x7fc2a4007100
con 0x13a5750
2.480 deep-scrub ok
2013-02-04 13:03:01.291570 osd.20 [INF] 2.80d deep-scrub ok
2013-02-04 13:03:01.463081 osd.17 [INF] 2.533 deep-scrub ok
2013-02-04 13:03:02.052528 osd.81 [INF] 2.ff deep-scrub ok
2013-02-04 13:03:02.814473 osd.38 [INF] 2.1b3 deep-scrub ok
2013-02-04 13:03:02.905738 osd.6 [INF] 2.4a3 deep-scrub ok
2013-02-04 13:03:03.052891 osd.81 [INF] 2.128 deep-scrub ok
2013-02-04 13:03:03.091407 osd.80 [INF] 2.6e2 deep-scrub ok
2013-02-04 13:03:03.463558 osd.17 [INF] 2.547 deep-scrub ok
2013-02-04 13:03:03.906652 osd.6 [INF] 2.4c4 deep-scrub ok
2013-02-04 13:03:04.053139 osd.81 [INF] 2.139 deep-scrub ok
2013-02-04 13:03:04.291827 osd.20 [INF] 2.812 deep-scrub ok
2013-02-04 13:03:04.907389 osd.6 [INF] 2.4c9 deep-scrub ok
2013-02-04 13:03:04.967291 osd.3 [INF] 2.2ed deep-scrub ok
2013-02-04 13:03:05.091859 osd.80 [INF] 2.6ed deep-scrub ok
2013-02-04 13:03:05.464345 osd.17 [INF] 2.55a deep-scrub ok
2013-02-04 13:03:05.815375 osd.38 [INF] 2.1c8 deep-scrub ok
2013-02-04 13:03:06.053986 osd.81 [INF] 2.146 deep-scrub ok
2013-02-04 13:03:06.292407 osd.20 [INF] 2.839 deep-scrub ok
2013-02-04 13:03:06.816639 osd.38 [INF] 2.1e3 deep-scrub ok
2013-02-04 13:03:06.908237 osd.6 [INF] 2.4fe deep-scrub ok
2013-02-04 13:03:07.054183 osd.81 [INF] 2.1e2 deep-scrub ok
2013-02-04 13:03:07.600264 mon.0 [INF] pgmap v436: 9408 pgs: 9408
active+clean; 8730 bytes data, 470 GB used, 88765 GB / 89235 GB avail
2013-02-04 13:03:07.968273 osd.3 [INF] 2.336 deep-scrub ok
2013-02-04 13:03:00.422927 osd.4 [INF] 2.1e4 deep-scrub ok
2013-02-04 13:03:01.423157 osd.4 [INF] 2.1fb deep-scrub ok
2013-02-04 13:03:01.494387 osd.82 [INF] 2.9f2 deep-scrub ok
2013-02-04 13:03:02.166499 osd.64 [INF] 2.731 deep-scrub ok
2013-02-04 13:03:02.793589 osd.54 [INF] 2.804 deep-scrub ok
2013-02-04 13:03:03.422729 osd.4 [INF] 2.209 deep-scrub ok
2013-02-04 13:03:04.167297 osd.64 [INF] 2.772 deep-scrub ok
2013-02-04 13:03:05.794297 osd.54 [INF] 2.814 deep-scrub ok
2013-02-04 13:03:11.688642 7fc2b3fff700  1 2013-02-04 13:03:06.794912
osd.54 [INF] 2.817 deep-scrub ok
2013-02-04 13:03:07.424067 osd-- 172.16.0.25:0/22739 <== mon.1
172.16.0.26:6789/0 12 ==== log(15 entries) v1 ==== 2995+0+0 (802021449
0 0) 0x7fc2a4009d30 con 0x13a5750.
4 [INF] 2.236 deep-scrub ok
2013-02-04 13:03:07.795495 osd.54 [INF] 2.887 deep-scrub ok
2013-02-04 13:03:08.887857 mon.0 [INF] pgmap v437: 9408 pgs: 9408
active+clean; 8730 bytes data, 470 GB used, 88765 GB / 89235 GB avail
2013-02-04 13:03:09.169404 osd.64 [INF] 2.785 deep-scrub ok
2013-02-04 13:03:09.495438 osd.82 [INF] 2.a1d deep-scrub ok
2013-02-04 13:03:09.797321 osd.54 [INF] 2.8a4 deep-scrub ok
2013-02-04 13:03:01.084946 osd.83 [INF] 2.ae6 deep-scrub ok
2013-02-04 132013-02-04 13:03:13.067513 7fc2b3fff700  1 :--
172.16.0.25:0/22739 <== mon.1 172.16.0.26:6789/0 13 ==== log(7
entries) v1 ==== 1459+0+0 (2642462470 0 0) 0x7fc2a400b530 con
0x13a575003:03.085609
osd.83 [INF] 2.b0c deep-scrub ok
2013-02-04 13:03:05.168109 osd.37 [INF] 2.356 deep-scrub ok
2013-02-04 13:03:08.087807 osd.83 [INF] 2.b4d deep-scrub ok
2013-02-04 13:03:08.862441 osd.66 [INF] 2.12f deep-scrub ok
2013-02-04 13:03:09.170310 osd.37 [INF] 2.3ba deep-scrub ok
2013-02-04 13:03:10.080788 mon.0 [INF] pgmap v438: 9408 pgs: 9408
active+clean; 8730 bytes data, 470 GB used, 88765 GB / 89235 GB avail
2013-02-04 13:03:03.733755 osd.67 [INF] 2.241 deep-scrub ok
2013-02-04 13:2013-02-04 13:03:14.234095 7fc2b3fff700  1 --
172.16.0.25:0/22739 <== mon.1 172.16.0.26:6789/0 14 ==== log(7
entries) v1 ==== 1459+0+0 (1497805353 0 0) 0x7fc2a400c690 con
0x13a5750
03:05.641857 osd.85 [INF] 2.1a0 deep-scrub ok
2013-02-04 13:03:05.735643 osd.67 [INF] 2.255 deep-scrub ok
2013-02-04 13:03:06.736322 osd.67 [INF] 2.2b6 deep-scrub ok
2013-02-04 13:03:09.642869 osd.85 [INF] 2.1f2 deep-scrub ok
2013-02-04 13:03:11.308557 mon.0 [INF] pgmap v439: 9408 pgs: 9408
active+clean; 8730 bytes data, 470 GB used, 88765 GB / 89235 GB avail
2013-02-04 13:03:11.737292 osd.67 [INF] 2.2f1 deep-scrub ok
2013-02-04 13:03:03.958281 osd.86 [INF] 2.639 deep-scrub ok
.....
.....
.....
ceph.conf :

[global]

                auth cluster required = cephx
                auth service required = cephx
                auth client required = cephx
                debug ms = 1




[osd]
                osd journal size = 10000
                filestore xattr use omap = true
                osd mkfs type = xfs
                osd mkfs options xfs = -f
                osd mount options xfs = rw,noatime,inode64



[osd.0]
                host = iltapp109
                devs = /dev/sda1
[osd.1]
                host = iltapp109
                devs = /dev/sdb1
[osd.2]
                host = iltapp109
                devs = /dev/sdc1
[osd.3]
                host = iltapp109
                devs = /dev/sdd1
[osd.4]
                host = iltapp109
                devs = /dev/sde1
[osd.5]
                host = iltapp109
                devs = /dev/sdf1
[osd.6]
                host = iltapp109
                devs = /dev/sdg1

[osd.7]
                host = iltapp109
                devs = /dev/sdh1

...
...
[mon]
                mon data = /var/lib/ceph/mon/$cluster-$id

[mon.a]
                host = testserver025
                mon addr = 172.16.0.25:6789


[mon.b]
                host = testserver3
                mon addr = 172.16.0.26:6789

[mon.c]
                host = iltapp115
                mon addr = 172.16.1.15:6789

[mds.a]
                host = testserver025



[mon]
        debug mon = 20
        debug paxos = 20
        debug auth = 20

[osd]
        debug osd = 20
        debug filestore = 20
        debug journal = 20
        debug monc = 20

[mds]
        debug mds = 20
        debug mds balancer = 20
        debug mds log = 20
        debug mds migrator = 20





Regards

Femi.
