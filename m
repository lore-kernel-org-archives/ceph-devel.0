From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: ceph osd memory free problem
Date: Mon, 12 Jun 2017 06:12:45 +0000
Message-ID: <robbat2-20170612T060139-811827739Z@orbis-terrarum.net>
References: <CAE5T3Nw4Ok6xcpWgOsRCj+NC5AiswUGShQmXRzxrJ_cNSPgCHw@mail.gmail.com>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:39786 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752022AbdFLGMr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Jun 2017 02:12:47 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 62665341A05
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 06:12:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAE5T3Nw4Ok6xcpWgOsRCj+NC5AiswUGShQmXRzxrJ_cNSPgCHw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?5LqO55u45rSL?= <penglaiyxy@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jun 12, 2017 at 10:45:52AM +0800, 于相洋 wrote:
> Hi cephers,
> 
> I have met a memory problem in ceph rados server nodes.
> 
> Total memory size is 64GB and used 56GB, only 8GB is left, cached and
> buffers takes few memory,   my swap space is used up, as shown below:
> If free memory is too low, there may occur OOM problem, since swap is
> used up, there may be some performance problems.
It's going to XFS.

You didn't post the OOM, but this sounds very much like the XFS memory
fragmentation issue as seen here:
https://serverfault.com/questions/642883/cause-of-page-fragmentation-on-large-server-with-xfs-20-disks-and-ceph

I regularly see it on our systems w/ 36x 6T OSD and 256GB of RAM as seen below,
a dmesg capture from a few days ago. All OSDs are 40-60% full.

The best mitigation so far is 'echo 2 > /proc/sys/vm/drop_caches' run nightly
during off-peak. The other suggestions in the above link reduced the frequency
of the problem for us, but didn't make it go away.

Timestamp for all of it: [Thu Jun  8 01:41:59 2017]
=====
tp_osd_tp invoked oom-killer: gfp_mask=0x240c2c0, order=3, oom_score_adj=0
tp_osd_tp cpuset=/ mems_allowed=0-1
CPU: 15 PID: 1085880 Comm: tp_osd_tp Tainted: G        W       4.4.0-59-generic #80~14.04.1-Ubuntu
Hardware name: Supermicro SSG-6048R-E1CR36L/X10DRH-iT, BIOS 2.0a 06/30/2016
 0000000000000000 ffff882a471f3a30 ffffffff813dbd6c ffff882a471f3be8
 0000000000000000 ffff882a471f3ac0 ffffffff811fafc6 ffff882a471f3be8
 ffff882a471f3af8 ffff8832ad0ac600 0000000000000000 0000000000000000
Call Trace:
 [<ffffffff813dbd6c>] dump_stack+0x63/0x87
 [<ffffffff811fafc6>] dump_header+0x5b/0x1d5
 [<ffffffff81188b35>] oom_kill_process+0x205/0x3d0
 [<ffffffff8118916b>] out_of_memory+0x40b/0x460
 [<ffffffff811fba7f>] __alloc_pages_slowpath.constprop.87+0x742/0x7ad
 [<ffffffff8118e167>] __alloc_pages_nodemask+0x237/0x240
 [<ffffffffc03df681>] ? xfs_da_state_free+0x21/0x30 [xfs]
 [<ffffffff811d3e18>] alloc_pages_current+0x88/0x120
 [<ffffffff8118ccc9>] alloc_kmem_pages+0x19/0x90
 [<ffffffff811a7868>] kmalloc_order+0x18/0x50
 [<ffffffff811a78c6>] kmalloc_order_trace+0x26/0xb0
 [<ffffffff811df331>] __kmalloc+0x251/0x270
 [<ffffffff812253de>] getxattr+0x8e/0x1b0
 [<ffffffffc04380f5>] ? posix_acl_access_exists+0x15/0x20 [xfs]
 [<ffffffffc041e602>] ? xfs_vn_listxattr+0xf2/0x160 [xfs]
 [<ffffffff811b5580>] ? handle_mm_fault+0x250/0x540
 [<ffffffff81225dee>] SyS_fgetxattr+0x5e/0xb0
 [<ffffffff81802c76>] entry_SYSCALL_64_fastpath+0x16/0x75
Mem-Info:
active_anon:8807118 inactive_anon:870763 isolated_anon:0
 active_file:5614956 inactive_file:4123432 isolated_file:0
 unevictable:8 dirty:4323 writeback:0 unstable:0
 slab_reclaimable:1921141 slab_unreclaimable:4002171
 mapped:6716850 shmem:6631 pagetables:82513 bounce:0
 free:758377 free_pcp:2615 free_cma:0
Node 0 DMA free:15320kB min:28kB low:32kB high:40kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:15960kB managed:15832kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 1842 128815 128815 128815
Node 0 DMA32 free:511832kB min:3744kB low:4680kB high:5616kB active_anon:8kB inactive_anon:8kB active_file:8kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:1967272kB managed:1886840kB mlocked:0kB dirty:0kB writeback:0kB mapped:8kB shmem:0kB slab_reclaimable:282060kB slab_unreclaimable:461284kB kernel_stack:13264kB pagetables:1848kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 126972 126972 126972
Node 0 Normal free:915268kB min:258172kB low:322712kB high:387256kB active_anon:19050184kB inactive_anon:1735572kB active_file:12163768kB inactive_file:8400128kB unevictable:32kB isolated(anon):0kB isolated(file):0kB present:132120576kB managed:130020328kB mlocked:32kB dirty:16060kB writeback:0kB mapped:13404324kB shmem:12012kB slab_reclaimable:4971164kB slab_unreclaimable:8497080kB kernel_stack:467504kB pagetables:170296kB unstable:0kB bounce:0kB free_pcp:5476kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:16 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:1591088kB min:262336kB low:327920kB high:393504kB active_anon:16178280kB inactive_anon:1747472kB active_file:10296048kB inactive_file:8093600kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:134217728kB managed:132116736kB mlocked:0kB dirty:1232kB writeback:0kB mapped:13463068kB shmem:14512kB slab_reclaimable:2431340kB slab_unreclaimable:7050320kB kernel_stack:563280kB pagetables:157908kB unstable:0kB bounce:0kB free_pcp:4984kB local_pcp:8kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 1*8kB (U) 1*16kB (U) 0*32kB 1*64kB (U) 1*128kB (U) 1*256kB (U) 1*512kB (U) 0*1024kB 1*2048kB (M) 3*4096kB (M) = 15320kB
Node 0 DMA32: 391*4kB (UME) 278*8kB (UM) 1027*16kB (UME) 683*32kB (UMEH) 504*64kB (UMEH) 396*128kB (UMH) 387*256kB (MEH) 178*512kB (MEH) 44*1024kB (MH) 74*2048kB (MH) 0*4096kB = 511836kB
Node 0 Normal: 52559*4kB (UME) 88630*8kB (UME) 1*16kB (H) 0*32kB 1*64kB (H) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 919356kB
Node 1 Normal: 127175*4kB (UME) 87936*8kB (UME) 23906*16kB (UMEH) 11*32kB (H) 6*64kB (H) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1595420kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
9783120 total pagecache pages
38289 pages in swap cache
Swap cache stats: add 19895227, delete 19856938, find 11143389/14461125
Free swap  = 7758284kB
Total swap = 8388604kB
67080384 pages RAM
0 pages HighMem/MovableOnly
1070450 pages reserved
0 pages cma reserved
0 pages hwpoisoned
[ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds swapents oom_score_adj name
[ 1007]     0  1007     5068      483      13       3      194             0 upstart-udev-br
[ 1013]     0  1013    12887      578      27       3      102         -1000 systemd-udevd
[ 1049]     0  1049     3820      304      13       3       24             0 upstart-file-br
[ 1052]   102  1052    80730    14806      62       4     3742             0 rsyslogd
[ 1798]     0  1798    12164      728      27       3      101             0 lldpd
[ 1869]   105  1869    12164      419      25       3       98             0 lldpd
[ 1879]     0  1879     3816      242      12       3       35             0 upstart-socket-
[ 2750]   103  2750     7866      797      20       3      102             0 ntpd
[ 2999]     0  2999     3635      431      12       3       38             0 getty
[ 3000]     0  3000     3635      448      12       3       37             0 getty
[ 3003]     0  3003     3635      436      12       3       39             0 getty
[ 3004]     0  3004     3635      435      12       3       40             0 getty
[ 3006]     0  3006     3635      450      12       3       39             0 getty
[ 3022]     0  3022    15346      927      34       3      140         -1000 sshd
[ 3024]     0  3024     5914      543      17       3       40             0 cron
[ 3224]     0  3224     1083      209       8       3       22             0 collectdmon
[ 3225]     0  3225   195966     1083      47       4       42             0 collectd
[ 3253]     0  3253    46081     1709      24       3     1019             0 fail2ban-server
[ 3408]     0  3408     6336      667      16       3       49             0 master
[ 3419]   104  3419     6893      698      18       3       44             0 qmgr
[ 3476]     0  3476     3318      282      10       3       24             0 mdadm
[ 3509]     0  3509     3635      439      12       3       37             0 getty
[ 3510]     0  3510     3197      439      12       3       35             0 getty
[ 3511]     0  3511     3197      445      12       3       34             0 getty
[2021121]   106 2021121     5835      474      16       3      123             0 nrpe
[1061740]     0 1061740  1193840   428081    2126       8     1069             0 ceph-osd
[1062045]     0 1062045  1580279   528454    3160      10     1199             0 ceph-osd
[1062547]     0 1062547  1051761   370552    1826       7     1870             0 ceph-osd
[1062915]     0 1062915  1174510   411056    2062       8     1590             0 ceph-osd
[1063396]     0 1063396  1400646   581974    2551       8      905             0 ceph-osd
[1064669]     0 1064669  1231068   386831    2184       7      767             0 ceph-osd
[1064973]     0 1064973  1358184   428018    2480       8      831             0 ceph-osd
[1065390]     0 1065390  1205864   439471    2121       9     1399             0 ceph-osd
[1065609]     0 1065609  1302914   479849    2331       8      698             0 ceph-osd
[1065968]     0 1065968  1376198   481664    2471       8      543             0 ceph-osd
[1066275]     0 1066275  1225083   439472    2185       8      810             0 ceph-osd
[1066575]     0 1066575  1285168   446490    2272       8      721             0 ceph-osd
[1066876]     0 1066876  1275062   448917    2278       8     5928             0 ceph-osd
[1067225]     0 1067225  1142918   402708    1991       7      966             0 ceph-osd
[1067581]     0 1067581  1084617   390226    1900       8     1192             0 ceph-osd
[1067867]     0 1067867  1306584   465829    2324       8     1140             0 ceph-osd
[1068359]     0 1068359  1143859   419061    2038       8      486             0 ceph-osd
[1068712]     0 1068712  1356145   482163    2482       8      703             0 ceph-osd
[1068945]     0 1068945  1464922   511993    2684      10     1054             0 ceph-osd
[1069202]     0 1069202  1314611   466149    2343       8      373             0 ceph-osd
[1077729]     0 1077729  1236855   474960    2196       8     2141             0 ceph-osd
[1077994]     0 1077994  1343678   511317    2422       8     3687             0 ceph-osd
[1078712]     0 1078712  1305742   547914    2328       8    14576             0 ceph-osd
[1079898]     0 1079898  1095581   443459    1913       7     1961             0 ceph-osd
[1081804]     0 1081804  1032092   369817    1789       7     6281             0 ceph-osd
[1082066]     0 1082066  1561346   536779    2734      10     7147             0 ceph-osd
[1083961]     0 1083961  1134121   445427    1976       7    20826             0 ceph-osd
[1086089]     0 1086089  1273552   473015    2271       8     4362             0 ceph-osd
[1088670]     0 1088670  1114051   402725    1973       7     8050             0 ceph-osd
[1092038]     0 1092038  1125645   435613    1976       7     9110             0 ceph-osd
[1096756]     0 1096756  1298374   431037    2313       8     3579             0 ceph-osd
[1097216]     0 1097216  1287326   460129    2289       8     8807             0 ceph-osd
[1101156]     0 1101156  1175688   429388    2065       8     7705             0 ceph-osd
[1107340]     0 1107340  1428037   468276    2626      10     3232             0 ceph-osd
[1107953]     0 1107953  1256050   459764    2239       8     2232             0 ceph-osd
[2432806]     0 2432806  1533549   440887    2734      10     2175             0 ceph-osd
[507551]     0 507551    28175     9661      60       3      108             0 ruby
[3159966]   999 3159966    91561    54449     141       3      978          1000 netdata
[3159992]   999 3159992    25706     4617      40       3        0          1000 python
[3615506]   999 3615506    18141     3880      29       3        0          1000 apps.plugin
[3644773]   104 3644773     6852      701      18       3        0             0 pickup
[3703623]   999 3703623     4572      820      14       3        0          1000 bash
[3709023]   104 3709023     6852      708      17       3        0             0 showq
Out of memory: Kill process 3159966 (netdata) score 1000 or sacrifice child
Killed process 3159992 (python) total-vm:102824kB, anon-rss:11528kB, file-rss:6940kB
=====



> 
> [root@localhost ~]# free -m
>                                    total          used           free
>    shared    buffers     cached
> Mem:                          64417       56768       7648          0
>       114        443
> -/+ buffers/cache:                       56211       8206
> Swap:                          8191         8191          0
> 
> >From the /proc/meminfo,  slab reclaim takes only 2GB memory,
> 
> [root@wzdx48 ~]# cat /proc/meminfo
> MemTotal:       65963088 kB
> MemFree:         7750100 kB
> Buffers:          116776 kB
> Cached:           453988 kB
> SwapCached:       813692 kB
> Active:         12835884 kB
> Inactive:        2184952 kB
> Active(anon):   12480640 kB
> Inactive(anon):  1971280 kB
> Active(file):     355244 kB
> Inactive(file):   213672 kB
> Unevictable:           0 kB
> Mlocked:               0 kB
> SwapTotal:       8388604 kB
> SwapFree:            128 kB
> Dirty:               928 kB
> Writeback:             0 kB
> AnonPages:      13636556 kB
> Mapped:            38184 kB
> Shmem:              1840 kB
> Slab:            6074272 kB
> SReclaimable:    2310640 kB
> SUnreclaim:      3763632 kB
> KernelStack:       42936 kB
> PageTables:        71748 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:    41370148 kB
> Committed_AS:   39673248 kB
> VmallocTotal:   34359738367 kB
> VmallocUsed:      390436 kB
> VmallocChunk:   34324779316 kB
> HardwareCorrupted:     0 kB
> AnonHugePages:   4503552 kB
> HugePages_Total:       0
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> DirectMap4k:        5504 kB
> DirectMap2M:     2082816 kB
> DirectMap1G:    65011712 kB
> 
> But when I run echo 3 > /proc/sys/vm/drop_caches, I can get 40GB free
> memory back.
> 
> [root@wzdx48 ~]# echo 3 > /proc/sys/vm/drop_caches
> [root@wzdx48 ~]# free -m
>              total       used       free     shared    buffers     cached
> Mem:         64417      15566      48850          0         10         59
> -/+ buffers/cache:      15496      48920
> Swap:         8191       8191          0
> 
> I just can't understand where are the 40GB memory used???
> 
> 
> OSD node  background:
> 
> [root@localhost ~]# ceph -s
>      health HEALTH_WARN
>             too many PGs per OSD (438 > max 300)
>             noout,nodeep-scrub flag(s) set
>      monmap e3: 3 mons at
> {60=192.168.2.60:6789/0,61=192.168.2.61:6789/0,62=192.168.2.62:6789/0}
>             election epoch 2720, quorum 0,1,2 60,61,62
>      osdmap e37148: 695 osds: 671 up, 671 in
>             nodeep-scrub
>       pgmap v12910815: 98064 pgs, 21 pools, 612 TB data, 757 Mobjects
>             1862 TB used, 2357 TB / 4220 TB avail
>                98015 active+clean
>                   49 active+clean+scrubbing
>   client io 9114 kB/s rd, 94051 kB/s wr, 6553 op/s
> 
> [root@wzdx48 ~]# df -i
> Filesystem        Inodes   IUsed     IFree IUse% Mounted on
> /dev/sda3       60489728  112915  60376813    1% /
> tmpfs            8245386      36   8245350    1% /dev/shm
> /dev/sda1         128016      43    127973    1% /boot
11
> 
> [root@wzdx48 ~]# df -h
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/sda3       909G   30G  871G   4% /
> tmpfs            32G  1.1M   32G   1% /dev/shm
> /dev/sda1       477M   57M  396M  13% /boot
> /dev/sdb2       425G  118G  307G  28% /data/osd/osd.660
> /dev/sdc2       425G  130G  296G  31% /data/osd/osd.661
> /dev/sdd2       425G  128G  298G  30% /data/osd/osd.662
> /dev/sde2       425G  125G  301G  30% /data/osd/osd.663
> /dev/sdf2       425G  134G  292G  32% /data/osd/osd.664
> /dev/sdg2       425G  131G  294G  31% /data/osd/osd.665
> /dev/sdh2       425G  131G  295G  31% /data/osd/osd.666
> /dev/sdi2       425G  124G  302G  30% /data/osd/osd.667
> /dev/sdj2       425G  126G  299G  30% /data/osd/osd.668
> /dev/sdk2       425G  123G  302G  29% /data/osd/osd.669
> /dev/sdl2       131G  351M  130G   1% /data/osd/osd.690
> 
> There is no active client writing or reading files.
> 
> top - 10:28:13 up 272 days, 17:43,  1 user,  load average: 0.28, 0.39, 0.44
> Tasks: 664 total,   1 running, 648 sleeping,   7 stopped,   8 zombie
> Cpu(s):  0.4%us,  0.7%sy,  0.0%ni, 98.3%id,  0.6%wa,  0.0%hi,  0.0%si,  0.0%st
> Mem:  65963088k total, 58901700k used,  7061388k free,   117148k buffers
> Swap:  8388604k total,  8387936k used,      668k free,   457360k cached
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> 10166 root      20   0 3726m 1.2g 6096 S  1.7  2.0  13340:55 ceph-osd
> 10251 root      20   0 3589m 1.2g 6064 S  1.7  2.0  12949:25 ceph-osd
> 65247 root      20   0 1955m  16m 3424 S  1.7  0.0 164:03.68 ama
> 10115 root      20   0 3671m 1.2g 6088 S  1.3  2.0  13342:35 ceph-osd
> 10234 root      20   0 3637m 1.2g 6088 S  1.3  1.9  12848:57 ceph-osd
> 10200 root      20   0 3707m 1.2g 6092 S  1.0  2.0  13687:07 ceph-osd
> 10217 root      20   0 3624m 1.2g 6088 S  1.0  1.9  12568:55 ceph-osd
> 10107 root      20   0 3556m 1.2g 6088 S  0.7  1.9  12198:33 ceph-osd
> 10132 root      20   0 3643m 1.3g 6088 S  0.7  2.0  12992:18 ceph-osd
> 10149 root      20   0 3599m 1.2g 6076 S  0.7  2.0  12101:59 ceph-osd
> 12317 root      20   0 15436 1704  932 R  0.7  0.0   0:00.05 top
> 
> Appreciate to receive any reply.
> 
> Best Regards,
> Brandy
> 
> -- 
> Software Engineer, ChinaNetCenter Co., ShenZhen, Guangdong Province, China
> "Experience is the name everyone gives to their mistakes." -- Oscar Wilde
> --
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
