From: Wei Jin <wjin.cn@gmail.com>
Subject: pg inconsistent and repair doesn't work
Date: Wed, 25 Oct 2017 12:05:59 +0800
Message-ID: <CAPpSHbWxLApYjY-McF6UXOku9ABKoeNR1ru5U6=xHhGWgrL=bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:50884 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdJYEGA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Oct 2017 00:06:00 -0400
Received: by mail-wm0-f49.google.com with SMTP id u138so19167981wmu.5
        for <ceph-devel@vger.kernel.org>; Tue, 24 Oct 2017 21:06:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.com

Hi, list,

We ran into pg deep scrub error. And we tried to repair it by `ceph pg
repair pgid`. But it didn't work. We also verified object files,  and
found both 3 replicas were zero size. What's the problem, whether it
is a bug? And how to fix the inconsistent? I haven't restarted the
osds so far as I am not sure whether it works.

ceph version: 10.2.9
user case: cephfs
kernel client: 4.4/4.9

Error info from primary osd:

root@n10-075-019:~# grep -Hn 'ERR' /var/log/ceph/ceph-osd.27.log.1
/var/log/ceph/ceph-osd.27.log.1:3038:2017-10-25 04:47:34.460536
7f39c4829700 -1 log_channel(cluster) log [ERR] : 1.fcd shard 27: soid
1:b3f61048:fsvolumens_87c46348-9869-11e7-8525-3497f65a8415::1000003528d.00000058:head
size 0 != size 3461120 from auth oi
1:b3f61048:fsvolumens_87c46348-9869-11e7-8525-3497f65a8415::1000003528d.00000058:head(2401'147490
client.901549.1:33749 dirty|omap_digest s 3461120 uv 147490 od
ffffffff alloc_hint [0 0])
/var/log/ceph/ceph-osd.27.log.1:3039:2017-10-25 04:47:34.460722
7f39c4829700 -1 log_channel(cluster) log [ERR] : 1.fcd shard 62: soid
1:b3f61048:fsvolumens_87c46348-9869-11e7-8525-3497f65a8415::1000003528d.00000058:head
size 0 != size 3461120 from auth oi
1:b3f61048:fsvolumens_87c46348-9869-11e7-8525-3497f65a8415::1000003528d.00000058:head(2401'147490
client.901549.1:33749 dirty|omap_digest s 3461120 uv 147490 od
ffffffff alloc_hint [0 0])
/var/log/ceph/ceph-osd.27.log.1:3040:2017-10-25 04:47:34.460725
7f39c4829700 -1 log_channel(cluster) log [ERR] : 1.fcd shard 133: soid
1:b3f61048:fsvolumens_87c46348-9869-11e7-8525-3497f65a8415::1000003528d.00000058:head
size 0 != size 3461120 from auth oi
1:b3f61048:fsvolumens_87c46348-9869-11e7-8525-3497f65a8415::1000003528d.00000058:head(2401'147490
client.901549.1:33749 dirty|omap_digest s 3461120 uv 147490 od
ffffffff alloc_hint [0 0])
/var/log/ceph/ceph-osd.27.log.1:3041:2017-10-25 04:47:34.460800
7f39c4829700 -1 log_channel(cluster) log [ERR] : 1.fcd soid
1:b3f61048:fsvolumens_87c46348-9869-11e7-8525-3497f65a8415::1000003528d.00000058:head:
failed to pick suitable auth object
/var/log/ceph/ceph-osd.27.log.1:3042:2017-10-25 04:47:34.461458
7f39c4829700 -1 log_channel(cluster) log [ERR] : deep-scrub 1.fcd
1:b3f61048:fsvolumens_87c46348-9869-11e7-8525-3497f65a8415::1000003528d.00000058:head
on disk size (0) does not match object info size (3461120) adjusted
for ondisk to (3461120)
/var/log/ceph/ceph-osd.27.log.1:3043:2017-10-25 04:47:44.645934
7f39c4829700 -1 log_channel(cluster) log [ERR] : 1.fcd deep-scrub 4
errors


Object file info:

root@n10-075-019:/var/lib/ceph/osd/ceph-27/current/1.fcd_head# find .
-name "1000003528d.00000058__head_12086FCD*"
./DIR_D/DIR_C/DIR_F/DIR_6/DIR_8/1000003528d.00000058__head_12086FCD_fsvolumens\u87c46348-9869-11e7-8525-3497f65a8415_1
root@n10-075-019:/var/lib/ceph/osd/ceph-27/current/1.fcd_head# ls -al
./DIR_D/DIR_C/DIR_F/DIR_6/DIR_8/1000003528d.00000058__head_12086FCD*
-rw-r--r-- 1 ceph ceph 0 Oct 24 22:04
./DIR_D/DIR_C/DIR_F/DIR_6/DIR_8/1000003528d.00000058__head_12086FCD_fsvolumens\u87c46348-9869-11e7-8525-3497f65a8415_1
root@n10-075-019:/var/lib/ceph/osd/ceph-27/current/1.fcd_head#


root@n10-075-028:/var/lib/ceph/osd/ceph-62/current/1.fcd_head# find .
-name "1000003528d.00000058__head_12086FCD*"
./DIR_D/DIR_C/DIR_F/DIR_6/DIR_8/1000003528d.00000058__head_12086FCD_fsvolumens\u87c46348-9869-11e7-8525-3497f65a8415_1
root@n10-075-028:/var/lib/ceph/osd/ceph-62/current/1.fcd_head# ls -al
./DIR_D/DIR_C/DIR_F/DIR_6/DIR_8/1000003528d.00000058__head_12086FCD*
-rw-r--r-- 1 ceph ceph 0 Oct 24 22:04
./DIR_D/DIR_C/DIR_F/DIR_6/DIR_8/1000003528d.00000058__head_12086FCD_fsvolumens\u87c46348-9869-11e7-8525-3497f65a8415_1
root@n10-075-028:/var/lib/ceph/osd/ceph-62/current/1.fcd_head#


root@n10-075-040:/var/lib/ceph/osd/ceph-133/current/1.fcd_head# find .
-name "1000003528d.00000058__head_12086FCD*"
./DIR_D/DIR_C/DIR_F/DIR_6/DIR_8/1000003528d.00000058__head_12086FCD_fsvolumens\u87c46348-9869-11e7-8525-3497f65a8415_1
root@n10-075-040:/var/lib/ceph/osd/ceph-133/current/1.fcd_head# ls -al
./DIR_D/DIR_C/DIR_F/DIR_6/DIR_8/1000003528d.00000058__head_12086FCD*
-rw-r--r-- 1 ceph ceph 0 Oct 24 22:04
./DIR_D/DIR_C/DIR_F/DIR_6/DIR_8/1000003528d.00000058__head_12086FCD_fsvolumens\u87c46348-9869-11e7-8525-3497f65a8415_1
root@n10-075-040:/var/lib/ceph/osd/ceph-133/current/1.fcd_head#
