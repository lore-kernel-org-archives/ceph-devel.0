From: Upendra Moturi <upendra.m@hexagrid.com>
Subject: Issue with replication level.
Date: Tue, 8 Mar 2011 14:22:21 +0530
Message-ID: <AANLkTin_M1Bx878=Avkm5+p1mhvJoYg1R87xjZSc4e=b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43654 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756681Ab1CHIwW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Mar 2011 03:52:22 -0500
Received: by bwz15 with SMTP id 15so4398107bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 Mar 2011 00:52:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>, Saurav Lahiri <saurav.lahiri@hexagrid.com>

Hi

I am having issue witrh replication levels.
Even though i have set data @2x and mds@1x replication,the data copied
is occupying 4x space

I have used default crush map rules.

2) how to see how much space does a mon,mds,data,casdata and rbd
occupied individually.

My ceph.conf

    [global]
       pid file = /var/run/ceph/$name.pid
       debug ms = 1
[mon]
        mon data = /data/mon$id
[mon.0]
        host = ceph1
        mon addr = 192.168.155.5:6789
[mon.1]
        host = ceph2
        mon addr = 192.168.155.6:6789
[mon.2]
        host = ceph3
        mon addr = 192.168.155.7:6789
[mds]

[mds0]
        host = ceph1
[mds1]
        host = ceph2

[osd]
        sudo = true
        osd data = /data/osd$id
        osd journal = /data/osd$id/journal
        osd journal size = 512
        osd use stale snap = true
[osd0]
        host = ceph1
        btrfs devs = /dev/sdb
[osd1]
        host = ceph2
        btrfs devs = /dev/sdb
[osd2]
        host = ceph3
        btrfs devs = /dev/sdb



My pg_data settings

pg_pool 0 'data' pg_pool(rep pg_size 2 crush_ruleset 0 object_hash
rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 1
owner 0)
pg_pool 1 'metadata' pg_pool(rep pg_size 1 crush_ruleset 1 object_hash
rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 10
owner 0)
pg_pool 2 'casdata' pg_pool(rep pg_size 1 crush_ruleset 2 object_hash
rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 12
owner 0)
pg_pool 3 'rbd' pg_pool(rep pg_size 1 crush_ruleset 3 object_hash
rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 15
owner 0)





--
Thanks and Regards,
Upendra.M
