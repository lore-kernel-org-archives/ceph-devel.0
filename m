From: Denis Fondras <ceph@ledeuns.net>
Subject: Ceph performance improvement
Date: Wed, 22 Aug 2012 10:54:58 +0200
Message-ID: <50349E62.90405@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmenez.pck.nerim.net ([213.41.245.173]:19606 "EHLO
	mail.ledeuns.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab2HVJL1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 05:11:27 -0400
Received: from [IPv6:2a01:728:103:1::21] (unknown [IPv6:2a01:728:103:1::21])
	by mail.ledeuns.net (Postfix) with ESMTPSA id 6439793281
	for <ceph-devel@vger.kernel.org>; Wed, 22 Aug 2012 10:55:01 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all,

I'm currently testing Ceph. So far it seems that HA and recovering are 
very good.
The only point that prevents my from using it at datacenter-scale is 
performance.

First of all, here is my setup :
- 1 OSD/MDS/MON on a Supermicro X9DR3-F/X9DR3-F (1x Intel Xeon E5-2603 - 
4 cores and 8GB RAM) running Debian Sid/Wheezy and Ceph version 0.49 
(commit:ca6265d0f4d68a5eb82b5bfafb450e8e696633ac).  It  has 1x 320GB 
drive for the system, 1x 64GB SSD (Crucial C300 - /dev/sda) for the 
journal and 4x 3TB drive (Western Digital WD30EZRX). Everything but the 
boot partition is BTRFS-formated and 4K-aligned.
- 1 client (P4 3.00GHz dual-core, 1GB RAM) running Debian Sid/Wheezy and 
Ceph version 0.49 (commit:ca6265d0f4d68a5eb82b5bfafb450e8e696633ac).
Both servers are linked over a 1Gb Ethernet switch (iperf shows about 
960Mb/s).

Here is my ceph.conf :
------cut-here------
[global]
         auth supported = cephx
         keyring = /etc/ceph/keyring
         journal dio = true
         osd op threads = 24
         osd disk threads = 24
         filestore op threads = 6
         filestore queue max ops = 24
         osd client message size cap = 14000000
         ms dispatch throttle bytes =  17500000

[mon]
         mon data = /home/mon.$id
         keyring = /etc/ceph/keyring.$name

[mon.a]
         host = ceph-osd-0
         mon addr = 192.168.0.132:6789

[mds]
         keyring = /etc/ceph/keyring.$name

[mds.a]
         host = ceph-osd-0

[osd]
         osd data = /home/osd.$id
         osd journal = /home/osd.$id.journal
         osd journal size = 1000
         keyring = /etc/ceph/keyring.$name

[osd.0]
         host = ceph-osd-0
         btrfs devs = 
/dev/disk/by-id/scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152201
         btrfs options = rw,noatime
------cut-here------

Here are some figures :
* Test with "dd" on the OSD server (on drive 
/dev/disk/by-id/scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152201) :
# dd if=/dev/zero of=testdd bs=4k count=4M
17179869184 bytes (17 GB) written, 123,746 s, 139 MB/s

=> iostat (on the OSD server) :
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,00    0,00    0,52   41,99    0,00   57,48

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdf             247,00         0,00    125520,00          0     125520

* Test with unpacking and deleting OpenBSD/5.1 src.tar.gz to the OSD 
server (on drive 
/dev/disk/by-id/scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152201) :
# time tar xzf src.tar.gz
real    0m9.669s
user    0m8.405s
sys     0m4.736s

# time rm -rf *
real    0m3.647s
user    0m0.036s
sys     0m3.552s

=> iostat (on the OSD server) :
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           10,83    0,00   28,72   16,62    0,00   43,83

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdf            1369,00         0,00      9300,00          0       9300

* Test with "dd" from the client using RBD :
# dd if=/dev/zero of=testdd bs=4k count=4M
17179869184 bytes (17 GB) written, 406,941 s, 42,2 MB/s

=> iostat (on the OSD server) :
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            4,57    0,00   30,46   27,66    0,00   37,31

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sda             317,00         0,00     57400,00          0      57400
sdf             237,00         0,00     88336,00          0      88336

* Test with unpacking and deleting OpenBSD/5.1 src.tar.gz from the 
client using RBD :
# time tar xzf src.tar.gz
real    0m26.955s
user    0m9.233s
sys     0m11.425s

# time rm -rf *
real    0m8.545s
user    0m0.128s
sys     0m8.297s

=> iostat (on the OSD server) :
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            4,59    0,00   24,74   30,61    0,00   40,05

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sda             239,00         0,00     54772,00          0      54772
sdf             441,00         0,00     50836,00          0      50836

* Test with "dd" from the client using CephFS :
# dd if=/dev/zero of=testdd bs=4k count=4M
17179869184 bytes (17 GB) written, 338,29 s, 50,8 MB/s

=> iostat (on the OSD server) :
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            2,26    0,00   20,30   27,07    0,00   50,38

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sda             710,00         0,00     58836,00          0      58836
sdf             722,00         0,00     32768,00          0      32768


* Test with unpacking and deleting OpenBSD/5.1 src.tar.gz from the 
client using CephFS :
# time tar xzf src.tar.gz
real    3m55.260s
user    0m8.721s
sys     0m11.461s

# time rm -rf *
real    9m2.319s
user    0m0.320s
sys     0m4.572s

=> iostat (on the OSD server) :
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           14,40    0,00   15,94    2,31    0,00   67,35

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sda             174,00         0,00     10772,00          0      10772
sdf             527,00         0,00      3636,00          0       3636

=> from top :
   PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+  COMMAND
  4070 root      20   0  992m 237m 4384 S  90,5  3,0  18:40.50 ceph-osd
  3975 root      20   0  777m 635m 4368 S  59,7  8,0   7:08.27 ceph-mds


Adding an OSD doesn't change much of these figures (and it is always for 
a lower end when it does).
Neither does migrating the MON+MDS on the client machine.

Are these figures right for this kind of hardware ? What could I try to 
make it a bit faster (essentially on the CephFS multiple little files 
side of things like uncompressing Linux kernel source or OpenBSD sources) ?

I see figures of hundreds of megabits on some mailing-list threads, I'd 
really like to see this kind of numbers :D

Thank you in advance for any pointer,
Denis
