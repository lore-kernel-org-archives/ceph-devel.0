From: Wei Zhao <zhao6305@gmail.com>
Subject: [ceph-osd ] osd can not boot
Date: Sun, 19 Jan 2020 17:46:15 +0800
Message-ID: <CAGOEmcPkeBcw3dMDWxPKEHb0w=8Gc4fZc6ZkEZRepcCyOgDCqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot1-f42.google.com ([209.85.210.42]:44474 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgASJq2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Jan 2020 04:46:28 -0500
Received: by mail-ot1-f42.google.com with SMTP id h9so26130902otj.11
        for <ceph-devel@vger.kernel.org>; Sun, 19 Jan 2020 01:46:27 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Users <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org

Hi :
    A server was just rebooted and the osd cant boot .The log is the follow=
ing.
-3> 2020-01-19 17:39:25.904673 7f5b8e5e9d80 -1
bluestore(/var/lib/ceph/osd/ceph-44) _verify_csum bad crc32c/0x1000
checksum at blob offset 0x0, got 0xd2acc81f, expected 0x62cf539d,
device location [0xaee7c0000~1000], logical extent 0x0~1000, object
#-1:1406dc50:::osdmap.7390:0#
    -2> 2020-01-19 17:39:25.904758 7f5b8e5e9d80 -1 osd.44 0 failed to
load OSD map for epoch 7390, got 0 bytes
    -1> 2020-01-19 17:39:25.904788 7f5b8e5e9d80 -1 osd.44 7396
load_pgs: have pgid 9.58 at epoch 7390, but missing map.  Crashing.
     0> 2020-01-19 17:39:25.909760 7f5b8e5e9d80 -1
/home/zhaowei/release/rpmbuild/BUILD/ceph/src/osd/OSD.cc: In function
'void OSD::load_pgs()' thread 7f5b8e5e9d80 time 2020-01-19
17:39:25.904801
/home/zhaowei/release/rpmbuild/BUILD/ceph/src/osd/OSD.cc: 4099: FAILED
assert(0 =3D=3D "Missing map in load_pgs")

so I tried to use ceph-objectstore-tool to look if I can find some clue
dump meta info
  ["meta",{"oid":"osdmap.7387","key":"","snapid":0,"hash":171666792,"max":0=
,"pool":-1,"namespace":"","max":0}]
["meta",{"oid":"osdmap.7388","key":"","snapid":0,"hash":171663928,"max":0,"=
pool":-1,"namespace":"","max":0}]
["meta",{"oid":"osdmap.7389","key":"","snapid":0,"hash":171664328,"max":0,"=
pool":-1,"namespace":"","max":0}]
["meta",{"oid":"osdmap.7390","key":"","snapid":0,"hash":171663400,"max":0,"=
pool":-1,"namespace":"","max":0}]
["meta",{"oid":"osdmap.7391","key":"","snapid":0,"hash":171663864,"max":0,"=
pool":-1,"namespace":"","max":0}]
["meta",{"oid":"osdmap.7392","key":"","snapid":0,"hash":171665032,"max":0,"=
pool":-1,"namespace":"","max":0}]
["meta",{"oid":"osdmap.7393","key":"","snapid":0,"hash":171664984,"max":0,"=
pool":-1,"namespace":"","max":0}]
["meta",{"oid":"osdmap.7394","key":"","snapid":0,"hash":171665384,"max":0,"=
pool":-1,"namespace":"","max":0}]
["meta",{"oid":"osdmap.7395","key":"","snapid":0,"hash":171664568,"max":0,"=
pool":-1,"namespace":"","max":0}]
["meta",{"oid":"osdmap.7396","key":"","snapid":0,"hash":171664456,"max":0,"=
pool":-1,"namespace":"","max":0}]

trying to get osdmap.7396 , and it is ok. But since the epoch in
superblock is  7390 ,  it is failed. I don't know what can cause this
issue?   If the  osdmap.7396 have been writen to disk successfully, so
why the older map was failed.  The ceph version is 12.2.4=E3=80=82
