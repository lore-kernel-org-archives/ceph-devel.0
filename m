From: Mike <mike.almateia@gmail.com>
Subject: Cyclic performance drop
Date: Fri, 14 Oct 2016 20:58:25 +0300
Message-ID: <716f53fa-0fce-a7b2-1d2a-f4bd10ea9133@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36823 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbcJNR63 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Oct 2016 13:58:29 -0400
Received: by mail-lf0-f54.google.com with SMTP id b75so203111365lfg.3
        for <ceph-devel@vger.kernel.org>; Fri, 14 Oct 2016 10:58:28 -0700 (PDT)
Received: from mike.0xFFF ([185.51.156.255])
        by smtp.googlemail.com with ESMTPSA id e70sm5410687lji.30.2016.10.14.10.58.26
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Oct 2016 10:58:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello.
On the latest Jewel release I see a cyclic performance drop on read operations.
Performance significantly drops every 4-5 seconds from ~70k IOPS to ~20k IOPS.

It looks like this (some fields were truncated to fit in line length):
<CUT>
...
19:46:10.432125 4096 pgs: 4096 active+clean; 67378 MB data, 82433 kB/s rd, 20608 op/s
19:46:11.453338 4096 pgs: 4096 active+clean; 67378 MB data, 104 MB/s rd, 26857 op/s
19:46:12.486138 4096 pgs: 4096 active+clean; 67378 MB data, 276 MB/s rd, 70879 op/s
19:46:13.517175 4096 pgs: 4096 active+clean; 67378 MB data, 235 MB/s rd, 60375 op/s
19:46:15.530826 4096 pgs: 4096 active+clean; 67378 MB data, 81768 kB/s rd, 20442 op/s
19:46:16.561929 4096 pgs: 4096 active+clean; 67378 MB data, 132 MB/s rd, 33811 op/s
19:46:17.582495 4096 pgs: 4096 active+clean; 67378 MB data, 277 MB/s rd, 71027 op/s
19:46:18.614087 4096 pgs: 4096 active+clean; 67378 MB data, 200 MB/s rd, 51365 op/s
19:46:20.643567 4096 pgs: 4096 active+clean; 67378 MB data, 97849 kB/s rd, 24462 op/s
19:46:21.664988 4096 pgs: 4096 active+clean; 67378 MB data, 129 MB/s rd, 33108 op/s
19:46:22.693243 4096 pgs: 4096 active+clean; 67378 MB data, 270 MB/s rd, 69269 op/s
19:46:23.692111 4096 pgs: 4096 active+clean; 67378 MB data, 199 MB/s rd, 51186 op/s
19:46:25.725054 4096 pgs: 4096 active+clean; 67378 MB data, 84951 kB/s rd, 21238 op/s
19:46:26.746227 4096 pgs: 4096 active+clean; 67378 MB data, 132 MB/s rd, 33833 op/s
19:46:27.779780 4096 pgs: 4096 active+clean; 67378 MB data, 293 MB/s rd, 75189 op/s
19:46:28.775288 4096 pgs: 4096 active+clean; 67378 MB data, 204 MB/s rd, 52249 op/s
19:46:30.795561 4096 pgs: 4096 active+clean; 67378 MB data, 75260 kB/s rd, 18815 op/s
19:46:31.818544 4096 pgs: 4096 active+clean; 67378 MB data, 133 MB/s rd, 34243 op/s
19:46:32.851392 4096 pgs: 4096 active+clean; 67378 MB data, 295 MB/s rd, 75755 op/s
19:46:33.843960 4096 pgs: 4096 active+clean; 67378 MB data, 205 MB/s rd, 52649 op/s
19:46:34.861416 4096 pgs: 4096 active+clean; 67378 MB data, 69177 kB/s rd, 17294 op/s
19:46:35.872386 4096 pgs: 4096 active+clean; 67378 MB data, 85299 kB/s rd, 21324 op/s
19:46:36.898020 4096 pgs: 4096 active+clean; 67378 MB data, 155 MB/s rd, 39896 op/s
19:46:37.934147 4096 pgs: 4096 active+clean; 67378 MB data, 321 MB/s rd, 82209 op/s
19:46:39.966386 4096 pgs: 4096 active+clean; 67378 MB data, 163 MB/s rd, 41735 op/s
19:46:40.973110 4096 pgs: 4096 active+clean; 67378 MB data, 55481 kB/s rd, 13870 op/s
...
<CUT>

My test it's run 6 VM with RBD disk from SSD pool and start fio on them:
<CUT>
# cat aio-read.fio
[global]


ioengine=libaio


buffered=0


rw=randread


bs=4k


size=2g


directory=/backup


group_reporting


thread





[file1]


iodepth=4


numjobs=4
#
<CUT>

What it's? it's bug or wrong configuration?


P.S. About a cluster.

Cluster is HEALTH_OK:
<CUT>
# ceph -s
    cluster 1894d33c-d75b-49d3-bf28-b28467d1754d
     health HEALTH_OK
     monmap e1: 5 mons at
{c1=10.22.11.20:6789/0,c2=10.22.11.21:6789/0,c3=10.22.11.22:6789/0,c4=10.22.11.23:6789/0,c5=10.22.11.24:6789/0}
            election epoch 944, quorum 0,1,2,3,4 c1,c2,c3,c4,c5
     osdmap e5431: 80 osds: 80 up, 80 in
            flags sortbitwise
      pgmap v3607661: 4096 pgs, 2 pools, 67378 MB data, 16879 objects
            467 GB used, 221 TB / 221 TB avail
                4096 active+clean

[root@c1 current]#
<CUT>

I have 5 OSD nodes (monitors are located on this nodes, but use dedicated ssd (that not
use as OSD drive)). Each OSD node:
* 6 SSD Intel DC S3700 200Gb (SSDSC2BA200G3). 2 connected to SATA Intel controller and
another 4 - SAS RAID LSI 9261-8i, RAID 0 created on it.
* 12 HDD SAS (not using in this test)
* 2 x CPU Intel(R) Xeon(R) CPU E5-2620 v2 @ 2.10GHz
* 64Gb RAM
* 2 x 2port Mellanox ConnectX-3 Pro EN 10gbit NIC. Make 2 bonds for - cluster and client
networks.

I made two pools: hot and data. The "hot" - all SSD, the "data" - only HDD.
Crush map:
<CUT>
...
host c5-ssd {
        id -11          # do not change unnecessarily
        # weight 0.688
        alg straw2
        hash 0  # rjenkins1
        item osd.76 weight 0.172
        item osd.77 weight 0.172
        item osd.78 weight 0.172
        item osd.79 weight 0.172
}
root ssd {
        id -12          # do not change unnecessarily
        # weight 1.376
        alg straw2
        hash 0  # rjenkins1
        item c1-ssd weight 0.000
        item c2-ssd weight 0.000
        item c3-ssd weight 0.000
        item c4-ssd weight 0.688
        item c5-ssd weight 0.688
}

# rules
rule replicated_ruleset {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take ssd
        step chooseleaf firstn 0 type host
        step emit
}
rule data {
        ruleset 1
        type erasure
        min_size 3
        max_size 5
        step set_chooseleaf_tries 5
        step set_choose_tries 100
        step take default
        step chooseleaf indep 0 type host
        step emit
}

# end crush map
<CUT>

I also have some kernel tuning parameters:
<CUT>
# cat /etc/sysctl.d/02-kernel.conf
## Kernel PID max
kernel.pid_max = 4194303
fs.file-max = 26234859
## VM swappiness
vm.swappiness = 0
vm.vfs_cache_pressure = 50
vm.min_free_kbytes = 1978336
<CUT>

Each SSD have configurations in the ceph.conf (osd with 60+ ids - it's SSD disks):
<CUT>
# cat /etc/ceph/ceph.conf
[global]
fsid = 1894d33c-d75b-49d3-bf28-b28467d1754d
mon initial members = c1, c2, c3, c4, c5
mon host = 10.22.11.20,10.22.11.21,10.22.11.22,10.22.11.23,10.22.11.24
auth cluster required = cephx
auth service required = cephx
auth client required = cephx
osd pool default size = 2
mon osd full ratio = .90
mon osd nearfull ratio = .85
public network = 10.22.11.0/24
cluster network = 10.22.10.0/24
admin socket = /var/run/ceph/$cluster-$name.asok
filestore btrfs snap = true
filestore btrfs clone range = true
filestore xattr use omap = true
filestore op threads = 4
filestore seek data hole = true

[osd]
osd crush update on start = false
osd mount options xfs = rw,noatime,logbsize=256k,logbufs=8,inode64,allocsize=4M
osd mount options btrfs = rw,noatime,autodefrag,user_subvol_rm_allowed
osd op threads = 4
journal block align = true
journal dio = true
journal aio = true

....

[osd.64]
filestore journal writeahead = true
osd op threads = 32
osd op num shards = 16
osd op num threads per shard = 2
filestore fd cache shards = 64
filestore fd cache size = 10240
filestore op threads = 16
filestore queue max ops = 5000
filestore queue committing max ops = 5000
journal queue max ops = 3000
journal queue max bytes = 10485760000
journal max write entries = 1000

....
<CUT>

-- 
Mike, run.

