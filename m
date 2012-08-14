From: Tobias Florek <tobias.florek@bytesandbutter.de>
Subject: cannot mount cephfs (with rbd working)
Date: Tue, 14 Aug 2012 02:26:24 +0200
Message-ID: <50299B30.6060102@bytesandbutter.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bytesandbutter.de ([176.9.76.40]:57053 "EHLO
	mail.bytesandbutter.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab2HNAdK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Aug 2012 20:33:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,

i am evaluating ceph (for now on only one host) and could not get cephfs
to mount. rbd works and the cluster is health_ok_y.

on the server (debian wheezy, uname: 3.2.0-3-amd64) i get

# mount.ceph 10.0.0.5:/ /tmp/mnt
mount error 5 = Input/output error

on a fedora 16 (3.3.7-1.fc16.x86_64) i get

# mount -t ceph 10.0.0.5:/ /tmp/mnt
mount: 10.0.0.5:/: can't read superblock

the server show about the same logs for both:

==> /var/log/ceph/ceph.log <==
2012-08-14 02:23:30.713802 7f052f1ec700  0 -- 10.0.0.5:6789/0 >>
10.0.0.6:0/1342173434 pipe(0x2079b80 sd=19 pgs=0 cs=0 l=0).accept peer
addr is really 10.0.0.6:0/1342173434 (socket is 10.0.0.6:35447/0)
2012-08-14 02:25:09.180678 7f052fcf0700  0 log [INF] : pgmap v320: 384
pgs: 384 active+clean; 16 bytes data, 5840 MB used, 12221 MB / 18062 MB
avail

==> /var/log/ceph/ceph.log <==
2012-08-14 02:23:11.189653 mon.0 10.0.0.5:6789/0 68 : [INF] pgmap v319:
384 pgs: 384 active+clean; 16 bytes data, 5840 MB used, 12221 MB / 18062
MB avail

==> /var/log/ceph/ceph-mon.a.log <==
2012-08-14 02:25:09.234922 7f052fcf0700  1 mon.a@0(leader).log v406
check_sub sub mdsmap not log type
2012-08-14 02:25:09.235153 7f052fcf0700  1 mon.a@0(leader).log v406
check_sub sub monmap not log type
2012-08-14 02:25:09.235284 7f052fcf0700  1 mon.a@0(leader).log v406
check_sub sub monmap not log type
2012-08-14 02:25:09.235399 7f052fcf0700  1 mon.a@0(leader).log v406
check_sub sub monmap not log type
2012-08-14 02:25:09.235513 7f052fcf0700  1 mon.a@0(leader).log v406
check_sub sub osdmap not log type
2012-08-14 02:25:11.231924 7f052fcf0700  0 log [INF] : pgmap v321: 384
pgs: 384 active+clean; 16 bytes data, 5840 MB used, 12221 MB / 18062 MB
avail

==> /var/log/ceph/ceph.log <==
2012-08-14 02:25:09.180693 mon.0 10.0.0.5:6789/0 69 : [INF] pgmap v320:
384 pgs: 384 active+clean; 16 bytes data, 5840 MB used, 12221 MB / 18062
MB avail

==> /var/log/ceph/ceph-mon.a.log <==
2012-08-14 02:25:11.286714 7f052fcf0700  1 mon.a@0(leader).log v407
check_sub sub mdsmap not log type
2012-08-14 02:25:11.286815 7f052fcf0700  1 mon.a@0(leader).log v407
check_sub sub monmap not log type
2012-08-14 02:25:11.286873 7f052fcf0700  1 mon.a@0(leader).log v407
check_sub sub monmap not log type
2012-08-14 02:25:11.286927 7f052fcf0700  1 mon.a@0(leader).log v407
check_sub sub monmap not log type
2012-08-14 02:25:11.286980 7f052fcf0700  1 mon.a@0(leader).log v407
check_sub sub osdmap not log type

(it times out shortly after the last message...)



below is my config. if anything else is missing, please tell me.


# dpkg -l \*ceph\*|grep '^ii'
ii  ceph                               0.48argonaut-1~bpo70+1
distributed storage and file system
ii  ceph-common                        0.48argonaut-1~bpo70+1    common
utilities to mount and interact with a ceph storage cluster
ii  ceph-fs-common                     0.48argonaut-1~bpo70+1    common
utilities to mount and interact with a ceph file system
ii  ceph-fuse                          0.48argonaut-1~bpo70+1
FUSE-based client for the Ceph distributed file system
ii  ceph-mds                           0.48argonaut-1~bpo70+1
metadata server for the ceph distributed file system
ii  libcephfs1                         0.48argonaut-1~bpo70+1    Ceph
distributed file system client library

# ceph -s
   health HEALTH_OK
   monmap e1: 1 mons at {a=10.0.0.5:6789/0}, election epoch 0, quorum 0 a
   osdmap e13: 2 osds: 2 up, 2 in
    pgmap v309: 384 pgs: 384 active+clean; 16 bytes data, 5840 MB used,
12221 MB / 18062 MB avail
   mdsmap e1: 0/0/1 up

# cat /etc/ceph/ceph.conf
[osd]
    osd journal_size = 1000

[mon.a]
    host = storage1
    mon addr = 10.0.0.5:6789

[osd.0]
    host = storage1

[osd.1]
    host = storage1

[msd.a]
    host = storage1

[mount]
    allow = %everyone

# /etc/init.d/ceph status
=== mon.a ===
mon.a: running 0.48argonaut
=== osd.0 ===
osd.0: running 0.48argonaut
=== osd.1 ===
osd.1: running 0.48argonaut



thank you in advance for your help,
 tobias florek
