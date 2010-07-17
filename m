From: =?ISO-8859-1?Q?S=E9bastien_Paolacci?=
	<sebastien.paolacci@gmail.com>
Subject: client released lease on dn which does not exist
Date: Sat, 17 Jul 2010 19:07:19 +0200
Message-ID: <AANLkTikmuytto8kwi4fNN1xUtNkAR_cIDPhd65xrLwkZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62788 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab0GQRHU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Jul 2010 13:07:20 -0400
Received: by wyb42 with SMTP id 42so2960017wyb.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Jul 2010 10:07:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all,

I'm getting some warnings that I've not been able to find informations
for when running dbench on a newly setup box (nettop, atom dual core
2.5" very low-end hdd). Seems however to be easily reproducible
(unstable server and kernel client from yesterday) :

srv:# mkcephfs -c ceph.conf --allhosts --mkbtrfs
srv:# for srv in cosd cmon cmds; do $srv -c ceph.conf -i 0; done

client:# mount -t ceph srv:/ /mnt/
client:# dbench -D /mnt/ 1

Few seconds later:
srv:# ceph -w
10.07.17_18:40:12.797372    pg v7: 264 pgs: 264 active+clean+degraded;
69 KB data, 508 KB used, 450 GB / 450 GB avail; 10/20 degraded
(50.000%)
10.07.17_18:40:12.800218   mds e4: 1/1/1 up {0=up:active}
10.07.17_18:40:12.800303   osd e3: 1 osds: 1 up, 1 in
10.07.17_18:40:12.800448   log 10.07.17_18:39:56.072957 mon0
192.168.0.3:6789/0 4 : [INF] mds0 192.168.0.3:6802/6754 up:active
10.07.17_18:40:12.800598   mon e1: 1 mons at 192.168.0.3:6789/0
10.07.17_18:40:14.234588    pg v8: 264 pgs: 264 active+clean+degraded;
1166 KB data, 1280 KB used, 450 GB / 450 GB avail; 28/56 degraded
(50.000%)
10.07.17_18:40:18.159014   log 10.07.17_18:40:12.067141 mds0
192.168.0.3:6802/6754 1 : [WRN] client4099 released lease on dn
1000000000c/RESULTS3.PRN which dne
10.07.17_18:40:19.199284    pg v9: 264 pgs: 264 active+clean+degraded;
2103 KB data, 2536 KB used, 450 GB / 450 GB avail; 33/66 degraded
(50.000%)

Does anyone know how "severe" the warning is and what could I
undertake to get rid of it?

Thanks,
Sebastien

ps: I can (separately) provide the 90MB mds log file should it be needed.

[global]
[mon]
        mon data = /data/mon$id
[mon0]
        host = srv
        mon addr = 192.168.0.3:6789
[mds]
        debug ms = 1
        debug mds = 20
[mds0]
        host = srv
[osd]
        osd data = /data/osd$id
        osd journal = /dev/sda3
[osd0]
        host = srv
        btrfs devs = /dev/sda4
