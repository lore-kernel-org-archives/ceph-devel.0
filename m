From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Cannot create an rbd image
Date: Mon, 05 Dec 2011 17:57:42 +0100
Message-ID: <3559228.m2Jnrzo7Vd@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:53143 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932551Ab1LEQ5p (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Dec 2011 11:57:45 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id A4E5B10C866
	for <ceph-devel@vger.kernel.org>; Mon,  5 Dec 2011 17:57:43 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I cannot create a new rbd image in a newly created ceph cluster. When I try 
it, I get these messages:

# rbd create testimage1 --size 10000
2011-12-05 17:41:00.987352 7ffe8b5c3760 -- :/0 messenger.start
2011-12-05 17:41:00.987542 7ffe8b5c3760 -- :/1011427 --> 10.3.1.33:6789/0 -- 
auth(proto 0 30 bytes) v1 -- ?+0 0x14f2540 con 0x14f22c0
2011-12-05 17:41:00.987769 7ffe8b5bf700 -- 10.3.1.33:0/1011427 learned my addr 
10.3.1.33:0/1011427
2011-12-05 17:41:00.988165 7ffe88952700 -- 10.3.1.33:0/1011427 <== mon.0 
10.3.1.33:6789/0 1 ==== auth_reply(proto 1 0 Success) v1 ==== 24+0+0 
(1391608787 0 0) 0x7ffe78000940 con 0x14f22c0
2011-12-05 17:41:00.988194 7ffe88952700 -- 10.3.1.33:0/1011427 --> 
10.3.1.33:6789/0 -- mon_subscribe({monmap=0+}) v1 -- ?+0 0x14f2720 con 
0x14f22c0
2011-12-05 17:41:00.988280 7ffe8b5c3760 -- 10.3.1.33:0/1011427 --> 
10.3.1.33:6789/0 -- mon_subscribe({monmap=0+,osdmap=0}) v1 -- ?+0 0x14f3050 
con 0x14f22c0
2011-12-05 17:41:00.988303 7ffe8b5c3760 -- 10.3.1.33:0/1011427 --> 
10.3.1.33:6789/0 -- mon_subscribe({monmap=0+,osdmap=0}) v1 -- ?+0 0x14f31f0 
con 0x14f22c0
2011-12-05 17:41:00.988409 7ffe88952700 -- 10.3.1.33:0/1011427 <== mon.0 
10.3.1.33:6789/0 2 ==== mon_map v1 ==== 191+0+0 (2396840036 0 0) 0x7ffe78000c50 
con 0x14f22c0
2011-12-05 17:41:00.988438 7ffe88952700 -- 10.3.1.33:0/1011427 <== mon.0 
10.3.1.33:6789/0 3 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0 (1991728371 0 
0) 0x7ffe78000e10 con 0x14f22c0
2011-12-05 17:41:00.988547 7ffe88952700 -- 10.3.1.33:0/1011427 <== mon.0 
10.3.1.33:6789/0 4 ==== mon_map v1 ==== 191+0+0 (2396840036 0 0) 0x7ffe78000bd0 
con 0x14f22c0
2011-12-05 17:41:00.988618 7ffe88952700 -- 10.3.1.33:0/1011427 <== mon.0 
10.3.1.33:6789/0 5 ==== osd_map(4..4 src has 1..4) v2 ==== 1749+0+0 
(3625543752 0 0) 0x7ffe78001470 con 0x14f22c0
2011-12-05 17:41:00.988714 7ffe88952700 -- 10.3.1.33:0/1011427 <== mon.0 
10.3.1.33:6789/0 6 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0 (1991728371 0 
0) 0x7ffe78000bd0 con 0x14f22c0
2011-12-05 17:41:00.988731 7ffe88952700 -- 10.3.1.33:0/1011427 <== mon.0 
10.3.1.33:6789/0 7 ==== mon_map v1 ==== 191+0+0 (2396840036 0 0) 0x7ffe78001760 
con 0x14f22c0
2011-12-05 17:41:00.988750 7ffe88952700 -- 10.3.1.33:0/1011427 <== mon.0 
10.3.1.33:6789/0 8 ==== osd_map(4..4 src has 1..4) v2 ==== 1749+0+0 
(3625543752 0 0) 0x7ffe78002080 con 0x14f22c0
2011-12-05 17:41:00.988835 7ffe8b5c3760 -- 10.3.1.33:0/1011427 --> 
10.3.1.33:6801/10713 -- osd_op(client.4123.0:1 testimage1.rbd [stat 0~0] 
2.829e9147) v1 -- ?+0 0x14f39f0 con 0x14f3770
2011-12-05 17:41:00.988869 7ffe88952700 -- 10.3.1.33:0/1011427 <== mon.0 
10.3.1.33:6789/0 9 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0 (1991728371 0 
0) 0x7ffe780023c0 con 0x14f22c0
2011-12-05 17:41:00.989373 7ffe88952700 -- 10.3.1.33:0/1011427 <== osd.0 
10.3.1.33:6801/10713 1 ==== osd_op_reply(1 testimage1.rbd [stat 0~0] = -2 (No 
such file or directory)) v2 ==== 105+0+0 (1064476462 0 0) 0x7ffe740009a0 con 
0x14f3770
2011-12-05 17:41:00.989454 7ffe8b5c3760 -- 10.3.1.33:0/1011427 --> 
10.3.1.33:6804/10780 -- osd_op(client.4123.0:2 rbd_info [write 0~0] 
2.ac0e573a) v1 -- ?+0 0x14f3fd0 con 0x14f3cb0
2011-12-05 17:41:00.993769 7ffe88952700 -- 10.3.1.33:0/1011427 <== osd.1 
10.3.1.33:6804/10780 1 ==== osd_op_reply(2 rbd_info [write 0~0] ack = 0) v2 
==== 99+0+0 (2612771120 0 0) 0x7ffe6c000990 con 0x14f3cb0
2011-12-05 17:41:00.993858 7ffe8b5c3760 -- 10.3.1.33:0/1011427 --> 
10.3.1.33:6804/10780 -- osd_op(client.4123.0:3 rbd_info [call rbd.assign_bid] 
2.ac0e573a) v1 -- ?+0 0x14f5140 con 0x14f3cb0
2011-12-05 17:41:00.994047 7ffe88952700 -- 10.3.1.33:0/1011427 <== osd.1 
10.3.1.33:6804/10780 2 ==== osd_op_reply(3 rbd_info [call] = -5 (Input/output 
error)) v2 ==== 99+0+0 (445480430 0 0) 0x7ffe6c000990 con 0x14f3cb0
2011-12-05 17:41:00.994075 7ffe8b5c3760 librbd: failed to assign a block name 
for image
create error: error 5: Input/output error

Anybody know what the problem is here?

	Guido

