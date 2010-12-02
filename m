From: Christian Brunner <chb@muc.de>
Subject: crashed+down+peering
Date: Thu, 2 Dec 2010 16:28:19 +0100
Message-ID: <AANLkTi=qVPB4ouEySHKAbRZLo7YgSyq6MdyY3LkT5JfS@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65023 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab0LBP2T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 10:28:19 -0500
Received: by iwn42 with SMTP id 42so1073168iwn.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Dec 2010 07:28:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We have simulated the simultanious crash of multiple osds in our
environment. After starting all the cosd again, we have the following
situation:

2010-12-02 16:18:33.944436    pg v724432: 3712 pgs: 1 active, 3605
active+clean, 1 crashed+peering, 46 down+peering, 56
crashed+down+peering, 3 active+clean+inconsistent; 177 GB data, 365 GB
used, 83437 GB / 83834 GB avail; 1/93704 degraded (0.001%)

When I set of an "rbd rm" command for one of our rbd volumes, it seems
to hit the the "crashed+down+peering" pg. After that the command is
stuck.

When I turn on "debug ms = 1" on the client side I can see the
following messages:

2010-12-02 16:24:06.364081 7f7f67c887e0 -- 10.255.0.130:0/7505 -->
osd14 10.255.0.63:6804/2175 -- osd_op(client97429.0:3
rb.0.4b.000000000001 [delete] 3.2c79) v1 -- ?+0 0x191c720
2010-12-02 16:24:21.358572 7f7f66683710 -- 10.255.0.130:0/7505 -->
mon1 10.255.0.21:6789/0 -- mon_subscribe({monmap=2+,osdmap=1730}) v1
-- ?+0 0x7f7f38000a90
2010-12-02 16:24:21.358633 7f7f66683710 -- 10.255.0.130:0/7505 -->
osd14 10.255.0.63:6804/2175 -- ping v1 -- ?+0 0x7f7f38000d30
2010-12-02 16:24:21.359298 7f7f67c87710 -- 10.255.0.130:0/7505 <==
mon1 10.255.0.21:6789/0 10 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0
(844714770 0 0) 0x7f7f58000d70
2010-12-02 16:24:26.358836 7f7f66683710 -- 10.255.0.130:0/7505 -->
osd14 10.255.0.63:6804/2175 -- ping v1 -- ?+0 0x7f7f38000d30
[...]

The "ping v1" continues forever. When I turn on "debug ms = 1" and
"debug osd = 10" on the cosd side, I can see which pg causes the
problem:

2010-12-02 16:04:25.701914 7f024363c710 -- 10.255.0.63:6800/19612 <==
client98231 10.255.0.130:0/7161 3 ==== osd_op(client9
8231.0:41 rb.0.4a.000000000027 [delete] 3.2dab) v1 ==== 128+0+0
(4170532710 0 0) 0x7f0154000e10
2010-12-02 16:04:25.701954 7f024363c710 osd12 1718 request for pool=3
(rbd) owner=0 perm=7 may_read=0 may_write=1 may_exec=
0 require_exec_caps=0
2010-12-02 16:04:25.701971 7f024363c710 osd12 1718 pg[3.1ab( v
630'8247 (630'8241,630'8247] n=78 ec=2 les=814 1712/1712/1712) [12,10]
r=0 lcod 0'0 mlcod 0'0 !hml crashed+down+peering] not active (yet)


What would be the correct way to resolve this situation?

Thanks, Christian
