From: femi anjorin <femi.anjorin@gmail.com>
Subject: HEALTH_ERR 18624 pgs stuck inactive; 18624 pgs stuck unclean; no osds
Date: Wed, 30 Jan 2013 17:12:32 +0100
Message-ID: <CAPhYxPzj_XkjqjJ+8GMM5m_GnmH-cfFyZmCgyPV4npg16XZ8ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51]:64301 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709Ab3A3QMe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 11:12:34 -0500
Received: by mail-qe0-f51.google.com with SMTP id 6so783581qea.24
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 08:12:33 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Can anyone help with this?

I am running a cluster of 6 servers. Each with 16 hard drives. I
mounted all the hard drives on the recommended mount point
/var/lib/ceph/osd/ceph-n . look like this:
/dev/sda1 on /var/lib/ceph/osd/ceph-0
/dev/sdb1 on /var/lib/ceph/osd/ceph-1
/dev/sdc1 on /var/lib/ceph/osd/ceph-2
/dev/sdd1 on /var/lib/ceph/osd/ceph-3
/dev/sde1 on /var/lib/ceph/osd/ceph-4
/dev/sdf1 on /var/lib/ceph/osd/ceph-5
/dev/sdg1 on /var/lib/ceph/osd/ceph-6
/dev/sdh1 on /var/lib/ceph/osd/ceph-7
/dev/sdi1 on /var/lib/ceph/osd/ceph-8
/dev/sdj1 on /var/lib/ceph/osd/ceph-9
/dev/sdk1 on /var/lib/ceph/osd/ceph-10
/dev/sdl1 on /var/lib/ceph/osd/ceph-11
/dev/sdm1 on /var/lib/ceph/osd/ceph-12
/dev/sdn1 on /var/lib/ceph/osd/ceph-13
/dev/sdo1 on /var/lib/ceph/osd/ceph-14
/dev/sdp1 on /var/lib/ceph/osd/ceph-15


Below is a summarized copy of my  ceph.conf file. Since i have 16
drive on each server ...so i did a configuration of osd.0 - osd.95.
While I did configuration of 3 monitors and 1 mds server.
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
[global]
                auth cluster required = cephx
                auth service required = cephx
                auth client required = cephx
                debug ms = 1
[osd]
                osd journal size = 10000
                filestore xattr use omap = true

[osd.0]
                hostname = testserver109
                devs = /dev/sda1
[osd.1]
                hostname = testserver109
                devs = /dev/sdb1
.
.
.
[osd.16]
                hostname = testserver110
                devs = /dev/sda1
.
.
[osd.95]
                hostname = testserver114
                devs = /dev/sdp1

[mon]
                mon data = /var/lib/ceph/mon/$cluster-$id

[mon.a]
                host = testserver109
                mon addr = 172.16.1.9:6789

[mon.b]
                host = testserver110
                mon addr = 172.16.1.10:6789

[mon.c]
                host = testserver111
                mon addr = 172.16.1.11:6789
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
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

Steps:
1. I did mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyring
temp dir is /tmp/mkcephfs.G5cBEIaS1o
preparing monmap in /tmp/mkcephfs.G5cBEIaS1o/monmap
/usr/bin/monmaptool --create --clobber --add a 172.16.1.9:6789 --add b
172.16.1.10:6789 --add c 172.16.1.11:6789 --print
/tmp/mkcephfs.G5cBEIaS1o/monmap
/usr/bin/monmaptool: monmap file /tmp/mkcephfs.G5cBEIaS1o/monmap
/usr/bin/monmaptool: generated fsid 3dd34cbf-e228-4ced-850c-68cde0a7d8b5
epoch 0
fsid 3dd34cbf-e228-4ced-850c-68cde0a7d8b5
last_changed 2013-01-30 12:38:14.564735
created 2013-01-30 12:38:14.564735
0: 172.16.1.9:6789/0 mon.a
1: 172.16.1.10:6789/0 mon.b
2: 172.16.1.11:6789/0 mon.c
/usr/bin/monmaptool: writing epoch 0 to
/tmp/mkcephfs.G5cBEIaS1o/monmap (3 monitors)
=== mds.a ===
creating private key for mds.a keyring /var/lib/ceph/mds/ceph-a/keyring
creating /var/lib/ceph/mds/ceph-a/keyring
Building generic osdmap from /tmp/mkcephfs.G5cBEIaS1o/conf
/usr/bin/osdmaptool: osdmap file '/tmp/mkcephfs.G5cBEIaS1o/osdmap'
/usr/bin/osdmaptool: writing epoch 1 to /tmp/mkcephfs.G5cBEIaS1o/osdmap
Generating admin key at /tmp/mkcephfs.G5cBEIaS1o/keyring.admin
creating /tmp/mkcephfs.G5cBEIaS1o/keyring.admin
Building initial monitor keyring
added entity mds.a auth auth(auid = 18446744073709551615
key=AQAnBglRaGP7MxAANo/xsy5P9NxMzCZGmHQDCw== with 0 caps)
=== mon.a ===
pushing everything to testserver109
/usr/bin/ceph-mon: created monfs at /var/lib/ceph/mon/ceph-a for mon.a
=== mon.b ===
pushing everything to testserver110
/usr/bin/ceph-mon: created monfs at /var/lib/ceph/mon/ceph-b for mon.b
=== mon.c ===
pushing everything to testserver111
/usr/bin/ceph-mon: created monfs at /var/lib/ceph/mon/ceph-c for mon.c
placing client.admin keyring in ceph.keyring

---------------------------------------------------------------------------------------------------------------------------------------
Apparently the monitor and mds got created and the ceph.keyring was
created BUT the OSDs were not created.

----------------------------------------------------------------------------------------------------------------------------------------
2. I copied to ceph.keyring to all node
3. I did a "service ceph -a start" command  (on all node)
4. I did a "ceph health"  (on the node where i used the mkcephfs)

2013-01-30 13:12:18.822022 7f80ea476760  1 -- :/0 messenger.start
2013-01-30 13:12:18.822911 7f80ea476760  1 -- :/3458 -->
172.16.1.9:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0
0x131aae0 con 0x131a700
2013-01-30 13:12:18.823439 7f80ea474700  1 -- 172.16.0.25:0/3458
learned my addr 172.16.0.25:0/3458
2013-01-30 13:12:18.824574 7f80dd7bb700  1 -- 172.16.0.25:0/3458 <==
mon.0 172.16.1.9:6789/0 1 ==== mon_map v1 ==== 473+0+0 (3454127086 0
0) 0x7f80d0000b10 con 0x131a700
2013-01-30 13:12:18.824687 7f80dd7bb700  1 -- 172.16.0.25:0/3458 <==
mon.0 172.16.1.9:6789/0 2 ==== auth_reply(proto 2 0 Success) v1 ====
33+0+0 (3089139024 0 0) 0x7f80d0000eb0 con 0x131a700
2013-01-30 13:12:18.824847 7f80dd7bb700  1 -- 172.16.0.25:0/3458 -->
172.16.1.9:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0
0x7f80d4001620 con 0x131a700
2013-01-30 13:12:18.826010 7f80dd7bb700  1 -- 172.16.0.25:0/3458 <==
mon.0 172.16.1.9:6789/0 3 ==== auth_reply(proto 2 0 Success) v1 ====
206+0+0 (3859488439 0 0) 0x7f80d0000eb0 con 0x131a700
2013-01-30 13:12:18.826130 7f80dd7bb700  1 -- 172.16.0.25:0/3458 -->
172.16.1.9:6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0
0x7f80d4003720 con 0x131a700
2013-01-30 13:12:18.827557 7f80dd7bb700  1 -- 172.16.0.25:0/3458 <==
mon.0 172.16.1.9:6789/0 4 ==== auth_reply(proto 2 0 Success) v1 ====
409+0+0 (4218726993 0 0) 0x7f80d0000eb0 con 0x131a700
2013-01-30 13:12:18.827654 7f80dd7bb700  1 -- 172.16.0.25:0/3458 -->
172.16.1.9:6789/0 -- mon_subscribe({monmap=0+}) v2 -- ?+0 0x131adc0
con 0x131a700
2013-01-30 13:12:18.827715 7f80ea476760  1 -- 172.16.0.25:0/3458 -->
172.16.1.9:6789/0 -- mon_command(health v 0) v1 -- ?+0 0x13188d0 con
0x131a700
2013-01-30 13:12:18.828343 7f80dd7bb700  1 -- 172.16.0.25:0/3458 <==
mon.0 172.16.1.9:6789/0 5 ==== mon_map v1 ==== 473+0+0 (3454127086 0
0) 0x7f80d00010e0 con 0x131a700
2013-01-30 13:12:18.828394 7f80dd7bb700  1 -- 172.16.0.25:0/3458 <==
mon.0 172.16.1.9:6789/0 6 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0
(3529768468 0 0) 0x7f80d00012c0 con 0x131a700
HEALTH_ERR 18624 pgs stuck inactive; 18624 pgs stuck unclean; no osds
2013-01-30 13:12:18.906689 7f80dd7bb700  1 -- 172.16.0.25:0/3458 <==
mon.0 172.16.1.9:6789/0 7 ==== mon_command_ack([health]=0 HEALTH_ERR
18624 pgs stuck inactive; 18624 pgs stuck unclean; no osds v0) v1 ====
109+0+0 (1820397562 0 0) 0x7f80d0000eb0 con 0x131a700
2013-01-30 13:12:18.906749 7f80ea476760  1 -- 172.16.0.25:0/3458 mark_down_all
2013-01-30 13:12:18.906826 7f80ea476760  1 -- 172.16.0.25:0/3458
shutdown complete.

----------------------------------------------------------------------------------------------------------------------------------
Issues:
" HEALTH_ERR 18624 pgs stuck inactive; 18624 pgs stuck unclean; no osds"
"mark_down_all"
"shutdown complete"
