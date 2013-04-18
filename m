From: Malcolm Haak <malcolm@sgi.com>
Subject: RBD Read performance
Date: Thu, 18 Apr 2013 14:35:11 +1000
Message-ID: <516F77FF.4060401@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3.sgi.com ([192.48.152.1]:49566 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752618Ab3DREfQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Apr 2013 00:35:16 -0400
Received: from xmail.sgi.com (pv-excas1-dc21.corp.sgi.com [137.38.102.116])
	by relay3.corp.sgi.com (Postfix) with ESMTP id 965BEAC003
	for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 21:35:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I jumped into the IRC channel yesterday and they said to email 
ceph-devel. I have been having some read performance issues. With Reads 
being slower than writes by a factor of ~5-8.

First info:
Server
SLES 11 SP2
Ceph 0.56.4.
12 OSD's  that are Hardware Raid 5 each of the twelve is made from 5 
NL-SAS disks for a total of 60 disks (Each lun can do around 320MB/s 
stream write and the same if not better read) Connected via 2xQDR IB
OSD's/MDS and such all on same box (for testing)
Box is a Quad AMD Opteron 6234
Ram is 256Gb
10GB Journals
osd_op_theads: 8
osd_disk_threads:2
Filestore_op_threads:4
OSD's are all XFS

All nodes are connected via QDR IB using IP_O_IB. We get 1.7GB/s on TCP 
performance tests between the nodes.

Clients: One is FC17 the other us Ubuntu 12.10 they only have around 
32GB-70GB ram.

We ran into an odd issue were the OSD's would all start in the same NUMA 
node and pretty much on the same processor core. We fixed that up with 
some cpuset magic.

Performance testing we have done: (Note oflag=direct was yielding 
results within 5% of cached results)


root@ty3:~# dd if=/dev/zero of=/test-rbd-fs/DELETEME bs=10M count=3200
3200+0 records in
3200+0 records out
33554432000 bytes (34 GB) copied, 47.6685 s, 704 MB/s
root@ty3:~#
root@ty3:~# rm /test-rbd-fs/DELETEME
root@ty3:~#
root@ty3:~# dd if=/dev/zero of=/test-rbd-fs/DELETEME bs=10M count=4800
4800+0 records in
4800+0 records out
50331648000 bytes (50 GB) copied, 69.5527 s, 724 MB/s

[root@dogbreath ~]# dd of=/test-rbd-fs/DELETEME if=/dev/zero bs=10M 
count=2400
2400+0 records in
2400+0 records out
25165824000 bytes (25 GB) copied, 26.3593 s, 955 MB/s
[root@dogbreath ~]# rm -f /test-rbd-fs/DELETEME
[root@dogbreath ~]# dd of=/test-rbd-fs/DELETEME if=/dev/zero bs=10M 
count=9600
9600+0 records in
9600+0 records out
100663296000 bytes (101 GB) copied, 145.212 s, 693 MB/s

Both clients each doing a 140GB write (2x dogbreath's RAM) at the same 
time to two different rbds in the same pool.

root@ty3:~# rm /test-rbd-fs/DELETEME
root@ty3:~# dd if=/dev/zero of=/test-rbd-fs/DELETEME bs=10M count=14000
14000+0 records in
14000+0 records out
146800640000 bytes (147 GB) copied, 412.404 s, 356 MB/s
root@ty3:~#

[root@dogbreath ~]# rm -f /test-rbd-fs/DELETEME
[root@dogbreath ~]# dd of=/test-rbd-fs/DELETEME if=/dev/zero bs=10M 
count=14000
14000+0 records in
14000+0 records out
146800640000 bytes (147 GB) copied, 433.351 s, 339 MB/s
[root@dogbreath ~]#

Onto reads...
Also we found that doing iflag=direct increased read performance.

[root@dogbreath ~]# dd of=/dev/null if=/test-rbd-fs/DELETEME bs=10M 
count=160
160+0 records in
160+0 records out
1677721600 bytes (1.7 GB) copied, 29.4242 s, 57.0 MB/s
[root@dogbreath ~]#
[root@dogbreath ~]# echo 1 > /proc/sys/vm/drop_caches
[root@dogbreath ~]# dd if=/test-rbd-fs/DELETEME of=/dev/null bs=4M 
count=10000
10000+0 records in
10000+0 records out
41943040000 bytes (42 GB) copied, 382.334 s, 110 MB/s
[root@dogbreath ~]#
[root@dogbreath ~]# echo 1 > /proc/sys/vm/drop_caches
[root@dogbreath ~]# dd if=/test-rbd-fs/DELETEME of=/dev/null bs=4M 
count=10000 iflag=direct
10000+0 records in
10000+0 records out
41943040000 bytes (42 GB) copied, 150.774 s, 278 MB/s
[root@dogbreath ~]#


So what info do you want/where do I start hunting for my wumpus?

Regards

Malcolm Haak


