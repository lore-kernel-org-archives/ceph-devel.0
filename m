From: Martin Mailand <martin@tuxadero.com>
Subject: Strange write behavior on an osd
Date: Tue, 24 Apr 2012 16:32:17 +0200
Message-ID: <4F96B971.5050806@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:60722 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab2DXOcX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Apr 2012 10:32:23 -0400
Received: from [172.30.1.184] ([192.166.201.59])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3OEWHut027475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 24 Apr 2012 16:32:21 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I have a strange behavior on the osd, the cluster is a two node system, 
on one machine 50 qemu/rbd vm's are running (idling) the other machine 
is a osd with four osd processes and one mon processes.

The osd disk are as follow

sda is root
sdb is journal four partitions
sd{c,d,e,f) each three disk via a raid controler.

/dev/sdc on /data/osd.0 type btrfs 
(rw,noatime,nodiratime,nodatacow,autodefrag)
/dev/sdd on /data/osd.1 type btrfs 
(rw,noatime,nodiratime,nodatacow,autodefrag)
/dev/sde on /data/osd.2 type btrfs 
(rw,noatime,nodiratime,nodatacow,autodefrag)
/dev/sdf on /data/osd.3 type btrfs 
(rw,noatime,nodiratime,nodatacow,autodefrag)


There is almost no network traffic, but the osd writes huge amount to 
the disk for around 90 sec and then its almost idle for 30 sec, the 
writes always goes to sde.

Why is it so bursty?


-martin


## Busy Log ##


----total-cpu-usage---- -dsk/total- -net/total- ---paging-- ---system--
usr sys idl wai hiq siq| read  writ| recv  send|  in   out | int   csw
   1   2  89   8   0   0|1632k   88M|   0     0 | 475B 1234B|1553    10k
   0   0  88  12   0   0|   0   147M| 856B 2974B|   0     0 |2056  1789
   0   0  88  12   0   0|   0   164M|  85k 6771B|   0     0 |2227  3104
   0   1  84  15   0   0|   0   152M| 193k   17k|   0     0 |2805  6116
   1   2  83  14   0   0|2704k  183M| 314k   23k|   0     0 |3184  7942
   0   1  84  15   0   0|2072k  183M| 213k   16k|   0     0 |3142  6798
   0   0  88  12   0   0|   0   167M|  27k 5571B|   0     0 |2418  2608
   1   1  80  18   0   0|  96k  207M| 443k   26k|   0     0 |3267  9278
   1   2  81  15   0   0|   0   180M| 682k   43k|   0     0 |3941    13k
   1   1  80  17   0   0|2736k  153M| 573k   35k|   0     0 |3229    11k
   1   1  84  14   0   0|9564k  163M| 242k   22k|   0     0 |2988  7054
   0   1  75  24   0   0| 160k  166M|  40k 5331B|   0     0 |2187  2759
   0   1  85  14   0   0|  32k  176M|  85k 6730B|   0     0 |2244  3198
   0   1  83  16   0   0|   0   183M| 137k   12k|   0     0 |2590  5254
   0   1  84  15   0   0|2688k  170M| 179k   15k|   0     0 |2780  5461
   0   1  86  13   0   0|2692k  166M| 185k   17k|   0     0 |2638  6242
   1   1  83  15   0   0|   0   179M| 149k   17k|   0     0 |3165  5695
   1   2  81  17   0   0|   0   186M| 484k   33k|   0     0 |3512    11k
   0   1  82  16   0   0|   0   177M| 523k   33k|   0     0 |3177    11k
   1   1  82  16   0   0|  36k  179M| 603k   39k|   0     0 |3006    11k
   1   1  79  19   0   0|3332k  210M| 332k   28k|   0     0 |3555  8813
   0   0  89  11   0   0|   0   167M|  53k 7553B|   0     0 |2423  3136
   0   0  87  12   0   0|   0   139M| 129k   11k|   0     0 |2073  3888
   0   2  80  18   0   0|  32k  170M| 293k   26k|   0     0 |2950  8825
   0   0  88  12   0   0| 772k  175M|  95k 8765B|   0     0 |2512  3640
   0   2  86  12   0   0|  28k  197M| 199k   12k|   0     0 |2435  5194
   0   0  87  13   0   0|  20k  179M| 111k 7843B|   0     0 |2310  3064


avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0.77    0.00    1.44   15.81    0.00   81.99

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s 
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00    71.80    0.00   17.80     0.00     0.35 
40.27     0.03    1.57    0.00    1.57   0.54   0.96
sdb               0.00     0.00    0.00  188.40     0.00     1.51 
16.37     0.49    2.59    0.00    2.59   0.70  13.20
sdc               0.00     0.00    4.00   61.00     0.53     2.34 
90.34     0.36    5.61   46.20    2.95   1.00   6.48
sde               0.00  1542.00    0.40 2172.00     0.01   165.82 
156.34   143.39   65.76  214.00   65.73   0.46 100.00
sdd               0.00     0.00    3.40   59.60     0.53     1.25 
57.85     0.20    3.19   32.47    1.52   0.88   5.52
sdf               0.00     0.00    8.40   75.40     1.35     1.75 
75.59     0.51    6.13   42.10    2.12   1.37  11.44

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0.23    0.00    0.77   15.96    0.00   83.03

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s 
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00    72.20    0.00   18.20     0.00     0.35 
39.74     0.02    1.32    0.00    1.32   0.57   1.04
sdb               0.00     0.00    0.00   72.00     0.00     0.52 
14.80     0.19    2.58    0.00    2.58   0.73   5.28
sdc               0.00     0.00    0.20   38.00     0.00     1.64 
88.17     0.36    9.36   16.00    9.33   1.09   4.16
sde               0.00  1554.80    1.20 2058.20     0.04   163.24 
162.37   143.50   69.50  296.67   69.37   0.49 100.00
sdd               0.00     0.00    3.40   39.00     0.53     2.90 
165.51     0.36    8.49   67.53    3.34   1.04   4.40
sdf               0.00     0.00    3.20   53.40     0.53     4.16 
169.41     0.83   14.66   53.00   12.36   1.58   8.96

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0.65    0.00    1.36   16.56    0.00   81.43

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s 
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00    72.00    0.00   18.40     0.00     0.35 
39.30     0.02    1.13    0.00    1.13   0.57   1.04
sdb               0.00     0.20    0.00  199.80     0.00     1.57 
16.13     0.49    2.47    0.00    2.47   0.69  13.84
sdc               0.00     0.00    1.80   57.40     0.13     1.76 
65.49     0.19    3.16   12.00    2.89   1.05   6.24
sde               0.00  1720.00    0.00 2220.20     0.00   178.49 
164.65   143.30   64.93    0.00   64.93   0.45 100.00
sdd               0.00     0.00    0.20   73.60     0.00     2.44 
67.64     0.22    3.02   12.00    3.00   0.94   6.96
sdf               0.00     0.00    3.20   74.00     0.53     1.94 
65.35     0.47    6.08   54.50    3.99   1.07   8.24

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0.30    0.00    0.87   12.90    0.00   85.92

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s 
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00    71.60    0.00   18.40     0.00     0.35 
39.13     0.03    1.70    0.00    1.70   0.65   1.20
sdb               0.00     0.40    0.00   88.00     0.00     0.61 
14.25     0.22    2.55    0.00    2.55   0.67   5.92
sdc               0.00    65.80    0.60   80.60     0.00     7.89 
199.05     1.40   17.23   78.67   16.77   0.83   6.72
sde               0.00  1550.80    0.20 2028.40     0.01   161.00 
162.55   142.95   70.39  272.00   70.37   0.49 100.00
sdd               0.00     0.00    1.60   37.40     0.15     1.43 
82.99     0.14    3.47   23.50    2.61   0.80   3.12
sdf               0.00     0.00    0.80   32.00     0.01     1.01 
63.61     0.09    2.63   23.00    2.12   1.12   3.68



## Idle Log ##


   0   3  78  19   0   0|1260k  151M| 236k   20k|   0     0 |2711    22k
   1  39  58   3   0   0| 448k   11M| 209k   15k|   0     0 |2986   174k
   0  25  74   1   0   0| 320k 1388k|  59k 4932B|   0     0 |2046   134k
   1   1  97   0   0   0| 184k 4680k| 294k   23k|   0     0 |1001  6614
   0   0 100   0   0   0|4096B  876k|9835B 2644B|   0     0 | 191   738
   1   2  97   0   0   0|   0    13M| 365k   26k|   0     0 |1121  7863
   1   2  97   0   0   0|   0    17M| 515k   37k|   0     0 |1532    10k
   1   2  97   0   0   0|   0  5372k| 458k   38k|   0     0 |1531  9604
   1   2  96   0   0   0|   0  6248k| 477k   37k|   0     0 |1429    10k
   0   0 100   0   0   0|   0   996k|  36k 5589B|   0     0 | 331  1249
   0   1  99   0   0   0|   0  5976k|  44k 5190B|   0     0 | 277  1528
   1   2  97   0   0   0|   0    21M| 231k   19k|   0     0 | 958  5783
   0   1  98   0   0   0|   0  3820k| 304k   24k|   0     0 | 993  6885
----total-cpu-usage---- -dsk/total- -net/total- ---paging-- ---system--
usr sys idl wai hiq siq| read  writ| recv  send|  in   out | int   csw
   1   3  96   0   0   0|  68k 4760k| 403k   30k|   0     0 |1339  8696
   0   1  98   1   0   0| 288k 3636k| 114k   14k|   0     0 | 658  3824
   1   1  98   0   0   0|   0  8168k| 301k   23k|   0     0 | 950  6343
   1   2  96   0   0   0|   0    19M| 523k   35k|   0     0 |1474    10k
   1   2  98   0   0   0|   0  3848k| 409k   29k|   0     0 |1160  7438
   1   2  96   0   0   0|  24k 6404k| 529k   37k|   0     0 |1456    10k
   1   2  97   0   0   0| 140k 2456k| 197k   16k|   0     0 | 806  5249
   0   0 100   0   0   0|   0  9564k| 395B  994B|   0     0 | 168   650
   0   2  98   0   0   0|   0    23M| 253k   22k|   0     0 |1066  7496
   0   1  99   0   0   0|   0  2084k| 185k   18k|   0     0 | 745  4849
   1   2  97   1   0   0|   0  3988k| 315k   27k|   0     0 |1101  7490
   0   1  99   1   0   0| 280k   10M|  48k 5700B|   0     0 | 347  1845
   1   2  97   0   0   0|   0    36M| 384k   26k|   0     0 |1203  9123
   1   2  96   0   0   0|   0    17M| 631k   41k|   0     0 |1691    12k
   1   1  98   0   0   0|   0  4432k| 394k   29k|   0     0 |1202  7722
   1   2  97   1   0   0|   0    43M| 428k   32k|   0     0 |1264  9039
   0   1  98   1   0   0|   0    41M| 140k   11k|   0     0 | 601  3105
   0   3  96   1   0   0| 320k   10M|  85k 7575B|   0     0 | 545  6786
----total-cpu-usage---- -dsk/total- -net/total- ---paging-- ---system--
usr sys idl wai hiq siq| read  writ| recv  send|  in   out | int   csw
   0  12  86   2   0   0| 832k   31M|  74k 8659B|   0     0 |1490    49k
   0  18  78   4   0   0|   0   270M|  73k 8459B|   0     0 |1937  8869
