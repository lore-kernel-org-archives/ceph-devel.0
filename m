From: Masuko Tomoya <tomoya.masuko@gmail.com>
Subject: couldn't use rbd
Date: Thu, 2 Feb 2012 01:49:58 -0800
Message-ID: <CAM2zNoOyURtLAzh=DNcPjazj1RpgEY7WeJ_-QVjOWzbTp+qSUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38086 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755007Ab2BBJuA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 04:50:00 -0500
Received: by lagu2 with SMTP id u2so1172268lag.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2012 01:49:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, all.

When I execute "rbd" command, it is not success.

root@ceph01:~# rbd list
(no response)

/var/log/ceph/mon.0.log
-----
2012-02-02 17:58:19.801762 7ff4bbfb1710 -- 10.68.119.191:6789/0 <==
client.? 10.68.119.191:0/1002580 1 ==== auth(proto 0 30 bytes) v1 ====
56+0+0 (625540289 0 0) 0x1619a00 con 0x1615a00
2012-02-02 17:58:19.801919 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
10.68.119.191:0/1002580 -- auth_reply(proto 2 0 Success) v1 -- ?+0
0x1619c00 con 0x1615a00
2012-02-02 17:58:19.802505 7ff4bbfb1710 -- 10.68.119.191:6789/0 <==
client.? 10.68.119.191:0/1002580 2 ==== auth(proto 2 32 bytes) v1 ====
58+0+0 (346146289 0 0) 0x161fc00 con 0x1615a00
2012-02-02 17:58:19.802673 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
10.68.119.191:0/1002580 -- auth_reply(proto 2 0 Success) v1 -- ?+0
0x1619a00 con 0x1615a00
2012-02-02 17:58:19.803473 7ff4bbfb1710 -- 10.68.119.191:6789/0 <==
client.? 10.68.119.191:0/1002580 3 ==== auth(proto 2 165 bytes) v1
==== 191+0+0 (3737796417 0 0) 0x1619600 con 0x1615a00
2012-02-02 17:58:19.803745 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
10.68.119.191:0/1002580 -- auth_reply(proto 2 0 Success) v1 -- ?+0
0x161fc00 con 0x1615a00
2012-02-02 17:58:19.804425 7ff4bbfb1710 -- 10.68.119.191:6789/0 <==
client.? 10.68.119.191:0/1002580 4 ==== mon_subscribe({monmap=0+}) v2
==== 23+0+0 (1620593354 0 0) 0x1617380 con 0x1615a00
2012-02-02 17:58:19.804488 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
10.68.119.191:0/1002580 -- mon_map v1 -- ?+0 0x1635700 con 0x1615a00
2012-02-02 17:58:19.804517 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
client.? 10.68.119.191:0/1002580 -- mon_subscribe_ack(300s) v1 -- ?+0
0x163d780
2012-02-02 17:58:19.804550 7ff4bbfb1710 -- 10.68.119.191:6789/0 <==
client.4112 10.68.119.191:0/1002580 5 ====
mon_subscribe({monmap=0+,osdmap=0}) v2 ==== 42+0+0 (982583713 0 0)
0x1617a80 con 0x1615a00
2012-02-02 17:58:19.804578 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
10.68.119.191:0/1002580 -- mon_map v1 -- ?+0 0x1617380 con 0x1615a00
2012-02-02 17:58:19.804656 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
client.? 10.68.119.191:0/1002580 -- osd_map(3..3 src has 1..3) v1 --
?+0 0x1619600
2012-02-02 17:58:19.804744 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
client.4112 10.68.119.191:0/1002580 -- mon_subscribe_ack(300s) v1 --
?+0 0x163d900
2012-02-02 17:58:19.804778 7ff4bbfb1710 -- 10.68.119.191:6789/0 <==
client.4112 10.68.119.191:0/1002580 6 ====
mon_subscribe({monmap=0+,osdmap=0}) v2 ==== 42+0+0 (982583713 0 0)
0x16178c0 con 0x1615a00
2012-02-02 17:58:19.804811 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
10.68.119.191:0/1002580 -- mon_map v1 -- ?+0 0x1617a80 con 0x1615a00
2012-02-02 17:58:19.804855 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
client.? 10.68.119.191:0/1002580 -- osd_map(3..3 src has 1..3) v1 --
?+0 0x1619400
2012-02-02 17:58:19.804884 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
client.4112 10.68.119.191:0/1002580 -- mon_subscribe_ack(300s) v1 --
?+0 0x161d300
-----

BTW, I could execute "rados lspools".

root@ceph01:~# rados lspools
data
metadata
rbd

I would like to use rbd volume and attach it as virtual device for VM
guest on KVM.

Could you advice to me ?


My environment is below.

*ceph cluster is configured on single server.
*server is ubuntu 10.10 maverick.
*ceph, librados2 and librbd1 packages are installed.
 (version: 0.38-1maverick)
*apparmor is disable.
*root@ceph01:/# ls -l /etc/ceph
total 16
-rw-r--r-- 1 root root 340 2012-02-02 17:28 ceph.conf
-rw------- 1 root root  92 2012-02-02 17:28 client.admin.keyring
-rw------- 1 root root  85 2012-02-02 17:28 mds.0.keyring
-rw------- 1 root root  85 2012-02-02 17:28 osd.0.keyring
*/var/lib/ceph/tmp is exists.
root@ceph01:/var/log# ls -l /var/lib/ceph/
total 4
drwxrwxrwx 2 root root 4096 2011-11-11 09:28 tmp

*/etc/ceph/ceph.conf
[global]
        auth supported = cephx
        keyring = /etc/ceph/$name.keyring
[mon]
        mon data = /data/data/mon$id
        debug ms = 1
[mon.0]
        host = ceph01
        mon addr = 10.68.119.191:6789
[mds]

[mds.0]
        host = ceph01
[osd]
        osd data = /data/osd$id
        osd journal = /data/osd$id/journal
        osd journal size = 512
        osd class tmp = /var/lib/ceph/tmp
[osd.0]
        host = ceph01
        btrfs devs = /dev/sdb1


Waiting for your reply,

Tomoya.
