From: =?UTF-8?B?5LqO55u45rSL?= <penglaiyxy@gmail.com>
Subject: ceph osd memory free problem
Date: Mon, 12 Jun 2017 10:45:52 +0800
Message-ID: <CAE5T3Nw4Ok6xcpWgOsRCj+NC5AiswUGShQmXRzxrJ_cNSPgCHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35319 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbdFLCpz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Jun 2017 22:45:55 -0400
Received: by mail-wr0-f175.google.com with SMTP id q97so81320683wrb.2
        for <ceph-devel@vger.kernel.org>; Sun, 11 Jun 2017 19:45:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi cephers,

I have met a memory problem in ceph rados server nodes.

Total memory size is 64GB and used 56GB, only 8GB is left, cached and
buffers takes few memory,   my swap space is used up, as shown below:
If free memory is too low, there may occur OOM problem, since swap is
used up, there may be some performance problems.

[root@localhost ~]# free -m
                                   total          used           free
   shared    buffers     cached
Mem:                          64417       56768       7648          0
      114        443
-/+ buffers/cache:                       56211       8206
Swap:                          8191         8191          0

From the /proc/meminfo,  slab reclaim takes only 2GB memory,

[root@wzdx48 ~]# cat /proc/meminfo
MemTotal:       65963088 kB
MemFree:         7750100 kB
Buffers:          116776 kB
Cached:           453988 kB
SwapCached:       813692 kB
Active:         12835884 kB
Inactive:        2184952 kB
Active(anon):   12480640 kB
Inactive(anon):  1971280 kB
Active(file):     355244 kB
Inactive(file):   213672 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       8388604 kB
SwapFree:            128 kB
Dirty:               928 kB
Writeback:             0 kB
AnonPages:      13636556 kB
Mapped:            38184 kB
Shmem:              1840 kB
Slab:            6074272 kB
SReclaimable:    2310640 kB
SUnreclaim:      3763632 kB
KernelStack:       42936 kB
PageTables:        71748 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    41370148 kB
Committed_AS:   39673248 kB
VmallocTotal:   34359738367 kB
VmallocUsed:      390436 kB
VmallocChunk:   34324779316 kB
HardwareCorrupted:     0 kB
AnonHugePages:   4503552 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:        5504 kB
DirectMap2M:     2082816 kB
DirectMap1G:    65011712 kB

But when I run echo 3 > /proc/sys/vm/drop_caches, I can get 40GB free
memory back.

[root@wzdx48 ~]# echo 3 > /proc/sys/vm/drop_caches
[root@wzdx48 ~]# free -m
             total       used       free     shared    buffers     cached
Mem:         64417      15566      48850          0         10         59
-/+ buffers/cache:      15496      48920
Swap:         8191       8191          0

I just can't understand where are the 40GB memory used???


OSD node  background:

[root@localhost ~]# ceph -s
     health HEALTH_WARN
            too many PGs per OSD (438 > max 300)
            noout,nodeep-scrub flag(s) set
     monmap e3: 3 mons at
{60=192.168.2.60:6789/0,61=192.168.2.61:6789/0,62=192.168.2.62:6789/0}
            election epoch 2720, quorum 0,1,2 60,61,62
     osdmap e37148: 695 osds: 671 up, 671 in
            nodeep-scrub
      pgmap v12910815: 98064 pgs, 21 pools, 612 TB data, 757 Mobjects
            1862 TB used, 2357 TB / 4220 TB avail
               98015 active+clean
                  49 active+clean+scrubbing
  client io 9114 kB/s rd, 94051 kB/s wr, 6553 op/s

[root@wzdx48 ~]# df -i
Filesystem        Inodes   IUsed     IFree IUse% Mounted on
/dev/sda3       60489728  112915  60376813    1% /
tmpfs            8245386      36   8245350    1% /dev/shm
/dev/sda1         128016      43    127973    1% /boot
/dev/sdb2      445376512 2792942 442583570    1% /data/osd/osd.660
/dev/sdc2      445376512 3056681 442319831    1% /data/osd/osd.661
/dev/sdd2      445376512 3008902 442367610    1% /data/osd/osd.662
/dev/sde2      445376512 2941672 442434840    1% /data/osd/osd.663
/dev/sdf2      445376512 3167379 442209133    1% /data/osd/osd.664
/dev/sdg2      445376512 3097866 442278646    1% /data/osd/osd.665
/dev/sdh2      445376512 3096104 442280408    1% /data/osd/osd.666
/dev/sdi2      445376512 2919437 442457075    1% /data/osd/osd.667
/dev/sdj2      445376512 2987967 442388545    1% /data/osd/osd.668
/dev/sdk2      445376512 2911681 442464831    1% /data/osd/osd.669
/dev/sdl2      136724480    3405 136721075    1% /data/osd/osd.690

[root@wzdx48 ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda3       909G   30G  871G   4% /
tmpfs            32G  1.1M   32G   1% /dev/shm
/dev/sda1       477M   57M  396M  13% /boot
/dev/sdb2       425G  118G  307G  28% /data/osd/osd.660
/dev/sdc2       425G  130G  296G  31% /data/osd/osd.661
/dev/sdd2       425G  128G  298G  30% /data/osd/osd.662
/dev/sde2       425G  125G  301G  30% /data/osd/osd.663
/dev/sdf2       425G  134G  292G  32% /data/osd/osd.664
/dev/sdg2       425G  131G  294G  31% /data/osd/osd.665
/dev/sdh2       425G  131G  295G  31% /data/osd/osd.666
/dev/sdi2       425G  124G  302G  30% /data/osd/osd.667
/dev/sdj2       425G  126G  299G  30% /data/osd/osd.668
/dev/sdk2       425G  123G  302G  29% /data/osd/osd.669
/dev/sdl2       131G  351M  130G   1% /data/osd/osd.690

There is no active client writing or reading files.

top - 10:28:13 up 272 days, 17:43,  1 user,  load average: 0.28, 0.39, 0.44
Tasks: 664 total,   1 running, 648 sleeping,   7 stopped,   8 zombie
Cpu(s):  0.4%us,  0.7%sy,  0.0%ni, 98.3%id,  0.6%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:  65963088k total, 58901700k used,  7061388k free,   117148k buffers
Swap:  8388604k total,  8387936k used,      668k free,   457360k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
10166 root      20   0 3726m 1.2g 6096 S  1.7  2.0  13340:55 ceph-osd
10251 root      20   0 3589m 1.2g 6064 S  1.7  2.0  12949:25 ceph-osd
65247 root      20   0 1955m  16m 3424 S  1.7  0.0 164:03.68 ama
10115 root      20   0 3671m 1.2g 6088 S  1.3  2.0  13342:35 ceph-osd
10234 root      20   0 3637m 1.2g 6088 S  1.3  1.9  12848:57 ceph-osd
10200 root      20   0 3707m 1.2g 6092 S  1.0  2.0  13687:07 ceph-osd
10217 root      20   0 3624m 1.2g 6088 S  1.0  1.9  12568:55 ceph-osd
10107 root      20   0 3556m 1.2g 6088 S  0.7  1.9  12198:33 ceph-osd
10132 root      20   0 3643m 1.3g 6088 S  0.7  2.0  12992:18 ceph-osd
10149 root      20   0 3599m 1.2g 6076 S  0.7  2.0  12101:59 ceph-osd
12317 root      20   0 15436 1704  932 R  0.7  0.0   0:00.05 top

Appreciate to receive any reply.

Best Regards,
Brandy

-- 
Software Engineer, ChinaNetCenter Co., ShenZhen, Guangdong Province, China
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde
--
