From: deming jia <jiademing.dd@gmail.com>
Subject: =?UTF-8?Q?=EF=BC=88krbd=EF=BC=89rbd_map_failed_on_aarch64_by_jewel?=
Date: Sat, 24 Dec 2016 15:58:01 +0800
Message-ID: <CABmAqEJQWQm-eP2akTPjwqZaKV5TkXw-rUBHqQRtQcAsFm9mvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36228 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbcLXH6D (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Dec 2016 02:58:03 -0500
Received: by mail-it0-f49.google.com with SMTP id 75so130805512ite.1
        for <ceph-devel@vger.kernel.org>; Fri, 23 Dec 2016 23:58:02 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi=EF=BC=8Call=EF=BC=9A

   I test ceph-10.2.5.tar.gz (download on download.ceph.com/tarballs)
on AARCH64.

  ceph cluster is OK=EF=BC=9A

    cluster 7bb94b46-1111-42e9-aaca-6ed9832b73a5
     health HEALTH_OK
     monmap e1: 1 mons at {openSUSE=3D10.10.109.23:6789/0}
            election epoch 4, quorum 0 openSUSE
     osdmap e29: 4 osds: 4 up, 4 in
            flags sortbitwise,require_jewel_osds
      pgmap v135: 64 pgs, 1 pools, 14512 kB data, 11 objects
            16609 MB used, 1845 GB / 1862 GB avail
                  64 active+clean

 the rbd create hello --size 10240
I can put data into hello by rados=EF=BC=8C then
rbd map hello=EF=BC=8C but failed=EF=BC=9A
 rbd: sysfs write failed
In some cases useful info is found in syslog - try "dmesg | tail" or so.
rbd: map failed: (110) Connection timed out
at that time=EF=BC=8Cthe ceph cluster also is OK.

kernel:
Linux openSUSE 4.4.2 #77 SMP Sat Dec 24 14:56:18 CST 2016 aarch64
aarch64 aarch64 GNU/Linux

dmesg=EF=BC=9A
[  117.694839] libceph: mon0 10.10.109.23:6789 socket closed (con state OPE=
N)
[  127.694839] libceph: mon0 10.10.109.23:6789 socket closed (con state OPE=
N)
[  137.694833] libceph: mon0 10.10.109.23:6789 socket closed (con state OPE=
N)
[  147.694874] libceph: mon0 10.10.109.23:6789 socket closed (con state OPE=
N)
[ 1674.235228] libceph: mon0 10.10.109.23:6789 socket closed (con state OPE=
N)

mon.log:
2016-12-24 15:31:09.302965 ffffb0628310  0
mon.openSUSE@0(leader).data_health(4) update_stats avail 39% total
100664 MB, used 55489 MB, avail 40039 MB
2016-12-24 15:31:13.770264 ffffad618310  0 -- 10.10.109.23:6789/0 >>
10.10.103.23:0/2754914976 pipe(0xaaaaf9904800 sd=3D24 :6789 s=3D2 pgs=3D863
cs=3D1 l=3D1 c=3D0xaaaaf965ce80).reader got bad header crc 0 !=3D 167937641=
6
2016-12-24 15:31:23.770307 ffffad618310  0 -- 10.10.109.23:6789/0 >>
10.10.103.23:0/2754914976 pipe(0xaaaaf9904800 sd=3D24 :6789 s=3D2 pgs=3D864
cs=3D1 l=3D1 c=3D0xaaaaf97cad00).reader got bad header crc 0 !=3D 167937641=
6
2016-12-24 15:31:33.770205 ffffad618310  0 -- 10.10.109.23:6789/0 >>
10.10.103.23:0/2754914976 pipe(0xaaaaf9903400 sd=3D24 :6789 s=3D2 pgs=3D865
cs=3D1 l=3D1 c=3D0xaaaaf97cab80).reader got bad header crc 0 !=3D 167937641=
6
2016-12-24 15:31:43.770321 ffffad618310  0 -- 10.10.109.23:6789/0 >>
10.10.103.23:0/2754914976 pipe(0xaaaaf9903400 sd=3D24 :6789 s=3D2 pgs=3D866
cs=3D1 l=3D1 c=3D0xaaaaf97ca700).reader got bad header crc 0 !=3D 167937641=
6
2016-12-24 15:31:53.770259 ffffad618310  0 -- 10.10.109.23:6789/0 >>
10.10.103.23:0/2754914976 pipe(0xaaaaf9904800 sd=3D24 :6789 s=3D2 pgs=3D867
cs=3D1 l=3D1 c=3D0xaaaaf97c8d80).reader got bad header crc 0 !=3D 167937641=
6
2016-12-24 15:32:03.770263 ffffad618310  0 -- 10.10.109.23:6789/0 >>
10.10.103.23:0/2754914976 pipe(0xaaaaf9904800 sd=3D24 :6789 s=3D2 pgs=3D868
cs=3D1 l=3D1 c=3D0xaaaaf97cb480).reader got bad header crc 0 !=3D 167937641=
6
2016-12-24 15:32:09.303148 ffffb0628310  0
mon.openSUSE@0(leader).data_health(4) update_stats avail 39% total
100664 MB, used 55489 MB, avail 40039 MB
2016-12-24 15:32:13.770223 ffffad618310  0 -- 10.10.109.23:6789/0 >>
10.10.103.23:0/2754914976 pipe(0xaaaaf9903400 sd=3D24 :6789 s=3D2 pgs=3D869
cs=3D1 l=3D1 c=3D0xaaaaf97ca280).reader got bad header crc 0 !=3D 167937641=
6
2016-12-24 15:32:23.770156 ffffad618310  0 -- 10.10.109.23:6789/0 >>
10.10.103.23:0/2754914976 pipe(0xaaaaf9903400 sd=3D24 :6789 s=3D2 pgs=3D870
cs=3D1 l=3D1 c=3D0xaaaaf97c9f80).reader got bad header crc 0 !=3D 167937641=
6

I test v0.94 installed by ceph-deploy, then rbd map is OK! Why? How
can I solve it?
Thanks.
