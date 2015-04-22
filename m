From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: strange benchmark problem : restarting osd daemon improve
 performance from 100k iops to 300k iops
Date: Wed, 22 Apr 2015 10:40:05 +0200 (CEST)
Message-ID: <1232683114.515741917.1429692005478.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:59741 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934397AbbDVIkJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Apr 2015 04:40:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi,

I was doing some benchmarks,
I have found an strange behaviour.

Using fio with rbd engine, I was able to reach around 100k iops.
(osd datas in linux buffer, iostat show 0% disk access)

then after restarting all osd daemons,

the same fio benchmark show now around 300k iops.
(osd datas in linux buffer, iostat show 0% disk access)


any ideas?




before restarting osd
---------------------
rbd_iodepth32-test: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd, iodepth=32
...
fio-2.2.7-10-g51e9
Starting 10 processes
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
^Cbs: 10 (f=10): [r(10)] [2.9% done] [376.1MB/0KB/0KB /s] [96.6K/0/0 iops] [eta 14m:45s]
fio: terminating on signal 2

rbd_iodepth32-test: (groupid=0, jobs=10): err= 0: pid=17075: Wed Apr 22 10:00:04 2015
  read : io=11558MB, bw=451487KB/s, iops=112871, runt= 26215msec
    slat (usec): min=5, max=3685, avg=16.89, stdev=17.38
    clat (usec): min=5, max=62584, avg=2695.80, stdev=5351.23
     lat (usec): min=109, max=62598, avg=2712.68, stdev=5350.42
    clat percentiles (usec):
     |  1.00th=[  155],  5.00th=[  183], 10.00th=[  205], 20.00th=[  247],
     | 30.00th=[  294], 40.00th=[  354], 50.00th=[  446], 60.00th=[  660],
     | 70.00th=[ 1176], 80.00th=[ 3152], 90.00th=[ 9024], 95.00th=[14656],
     | 99.00th=[25984], 99.50th=[30336], 99.90th=[38656], 99.95th=[41728],
     | 99.99th=[47360]
    bw (KB  /s): min=23928, max=154416, per=10.07%, avg=45462.82, stdev=28809.95
    lat (usec) : 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=20.79%
    lat (usec) : 500=32.74%, 750=8.99%, 1000=5.03%
    lat (msec) : 2=8.37%, 4=6.21%, 10=8.90%, 20=6.60%, 50=2.37%
    lat (msec) : 100=0.01%
  cpu          : usr=15.90%, sys=3.01%, ctx=765446, majf=0, minf=8710
  IO depths    : 1=0.4%, 2=0.9%, 4=2.3%, 8=7.4%, 16=75.5%, 32=13.6%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=93.6%, 8=2.8%, 16=2.4%, 32=1.2%, 64=0.0%, >=64=0.0%
     issued    : total=r=2958935/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=11558MB, aggrb=451487KB/s, minb=451487KB/s, maxb=451487KB/s, mint=26215msec, maxt=26215msec

Disk stats (read/write):
  sdg: ios=0/29, merge=0/16, ticks=0/3, in_queue=3, util=0.01%
[root@ceph1-3 fiorbd]# ./fio fiorbd
rbd_iodepth32-test: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd, iodepth=32




AFTER RESTARTING OSDS
----------------------
[root@ceph1-3 fiorbd]# ./fio fiorbd
rbd_iodepth32-test: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd, iodepth=32
...
fio-2.2.7-10-g51e9
Starting 10 processes
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
rbd engine: RBD version: 0.1.9
^Cbs: 10 (f=10): [r(10)] [0.2% done] [1155MB/0KB/0KB /s] [296K/0/0 iops] [eta 01h:09m:27s]
fio: terminating on signal 2

rbd_iodepth32-test: (groupid=0, jobs=10): err= 0: pid=18252: Wed Apr 22 10:02:28 2015
  read : io=7655.7MB, bw=1036.8MB/s, iops=265218, runt=  7389msec
    slat (usec): min=5, max=3406, avg=26.59, stdev=40.35
    clat (usec): min=8, max=684328, avg=930.43, stdev=6419.12
     lat (usec): min=154, max=684342, avg=957.02, stdev=6419.28
    clat percentiles (usec):
     |  1.00th=[  243],  5.00th=[  314], 10.00th=[  366], 20.00th=[  450],
     | 30.00th=[  524], 40.00th=[  604], 50.00th=[  692], 60.00th=[  796],
     | 70.00th=[  924], 80.00th=[ 1096], 90.00th=[ 1400], 95.00th=[ 1720],
     | 99.00th=[ 2672], 99.50th=[ 3248], 99.90th=[ 5920], 99.95th=[ 9792],
     | 99.99th=[436224]
    bw (KB  /s): min=32614, max=143160, per=10.19%, avg=108076.46, stdev=28263.82
    lat (usec) : 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=1.23%
    lat (usec) : 500=25.64%, 750=29.15%, 1000=18.84%
    lat (msec) : 2=22.19%, 4=2.69%, 10=0.21%, 20=0.02%, 50=0.01%
    lat (msec) : 250=0.01%, 500=0.02%, 750=0.01%
  cpu          : usr=44.06%, sys=11.26%, ctx=642620, majf=0, minf=6832
  IO depths    : 1=0.1%, 2=0.5%, 4=2.0%, 8=11.5%, 16=77.8%, 32=8.1%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=94.1%, 8=1.3%, 16=2.3%, 32=2.3%, 64=0.0%, >=64=0.0%
     issued    : total=r=1959697/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=7655.7MB, aggrb=1036.8MB/s, minb=1036.8MB/s, maxb=1036.8MB/s, mint=7389msec, maxt=7389msec

Disk stats (read/write):
  sdg: ios=0/21, merge=0/10, ticks=0/2, in_queue=2, util=0.03%




CEPH LOG
--------

before restarting osd
----------------------

2015-04-22 09:53:17.568095 mon.0 10.7.0.152:6789/0 2144 : cluster [INF] pgmap v11330: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 298 MB/s rd, 76465 op/s
2015-04-22 09:53:18.574524 mon.0 10.7.0.152:6789/0 2145 : cluster [INF] pgmap v11331: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 333 MB/s rd, 85355 op/s
2015-04-22 09:53:19.579351 mon.0 10.7.0.152:6789/0 2146 : cluster [INF] pgmap v11332: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 343 MB/s rd, 87932 op/s
2015-04-22 09:53:20.591586 mon.0 10.7.0.152:6789/0 2147 : cluster [INF] pgmap v11333: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 328 MB/s rd, 84151 op/s
2015-04-22 09:53:21.600650 mon.0 10.7.0.152:6789/0 2148 : cluster [INF] pgmap v11334: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 237 MB/s rd, 60855 op/s
2015-04-22 09:53:22.607966 mon.0 10.7.0.152:6789/0 2149 : cluster [INF] pgmap v11335: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 144 MB/s rd, 36935 op/s
2015-04-22 09:53:23.617780 mon.0 10.7.0.152:6789/0 2150 : cluster [INF] pgmap v11336: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 321 MB/s rd, 82334 op/s
2015-04-22 09:53:24.622341 mon.0 10.7.0.152:6789/0 2151 : cluster [INF] pgmap v11337: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 368 MB/s rd, 94211 op/s
2015-04-22 09:53:25.628432 mon.0 10.7.0.152:6789/0 2152 : cluster [INF] pgmap v11338: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 244 MB/s rd, 62644 op/s
2015-04-22 09:53:26.632855 mon.0 10.7.0.152:6789/0 2153 : cluster [INF] pgmap v11339: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 175 MB/s rd, 44997 op/s
2015-04-22 09:53:27.636573 mon.0 10.7.0.152:6789/0 2154 : cluster [INF] pgmap v11340: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 122 MB/s rd, 31259 op/s
2015-04-22 09:53:28.645784 mon.0 10.7.0.152:6789/0 2155 : cluster [INF] pgmap v11341: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 229 MB/s rd, 58674 op/s
2015-04-22 09:53:29.657128 mon.0 10.7.0.152:6789/0 2156 : cluster [INF] pgmap v11342: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 271 MB/s rd, 69501 op/s
2015-04-22 09:53:30.662796 mon.0 10.7.0.152:6789/0 2157 : cluster [INF] pgmap v11343: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 211 MB/s rd, 54020 op/s
2015-04-22 09:53:31.666421 mon.0 10.7.0.152:6789/0 2158 : cluster [INF] pgmap v11344: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 164 MB/s rd, 42001 op/s
2015-04-22 09:53:32.670842 mon.0 10.7.0.152:6789/0 2159 : cluster [INF] pgmap v11345: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 134 MB/s rd, 34380 op/s
2015-04-22 09:53:33.681357 mon.0 10.7.0.152:6789/0 2160 : cluster [INF] pgmap v11346: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 293 MB/s rd, 75213 op/s
2015-04-22 09:53:34.692177 mon.0 10.7.0.152:6789/0 2161 : cluster [INF] pgmap v11347: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 337 MB/s rd, 86353 op/s
2015-04-22 09:53:35.697401 mon.0 10.7.0.152:6789/0 2162 : cluster [INF] pgmap v11348: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 229 MB/s rd, 58839 op/s
2015-04-22 09:53:36.699309 mon.0 10.7.0.152:6789/0 2163 : cluster [INF] pgmap v11349: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 152 MB/s rd, 39117 op/s


restarting osd
---------------

2015-04-22 10:00:09.766906 mon.0 10.7.0.152:6789/0 2255 : cluster [INF] osd.0 marked itself down
2015-04-22 10:00:09.790212 mon.0 10.7.0.152:6789/0 2256 : cluster [INF] osdmap e849: 9 osds: 8 up, 9 in
2015-04-22 10:00:09.793050 mon.0 10.7.0.152:6789/0 2257 : cluster [INF] pgmap v11439: 964 pgs: 2 active+undersized+degraded, 8 stale+active+remapped, 106 stale+active+clean, 54 active+remapped, 794 active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail; 516 kB/s rd, 130 op/s
2015-04-22 10:00:10.795966 mon.0 10.7.0.152:6789/0 2258 : cluster [INF] osdmap e850: 9 osds: 8 up, 9 in
2015-04-22 10:00:10.796675 mon.0 10.7.0.152:6789/0 2259 : cluster [INF] pgmap v11440: 964 pgs: 2 active+undersized+degraded, 8 stale+active+remapped, 106 stale+active+clean, 54 active+remapped, 794 active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:11.798257 mon.0 10.7.0.152:6789/0 2260 : cluster [INF] pgmap v11441: 964 pgs: 2 active+undersized+degraded, 8 stale+active+remapped, 106 stale+active+clean, 54 active+remapped, 794 active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:12.339696 mon.0 10.7.0.152:6789/0 2262 : cluster [INF] osd.1 marked itself down
2015-04-22 10:00:12.800168 mon.0 10.7.0.152:6789/0 2263 : cluster [INF] osdmap e851: 9 osds: 7 up, 9 in
2015-04-22 10:00:12.806498 mon.0 10.7.0.152:6789/0 2264 : cluster [INF] pgmap v11443: 964 pgs: 1 active+undersized+degraded, 13 stale+active+remapped, 216 stale+active+clean, 49 active+remapped, 684 active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:13.804186 mon.0 10.7.0.152:6789/0 2265 : cluster [INF] osdmap e852: 9 osds: 7 up, 9 in
2015-04-22 10:00:13.805216 mon.0 10.7.0.152:6789/0 2266 : cluster [INF] pgmap v11444: 964 pgs: 1 active+undersized+degraded, 13 stale+active+remapped, 216 stale+active+clean, 49 active+remapped, 684 active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:14.781785 mon.0 10.7.0.152:6789/0 2268 : cluster [INF] osd.2 marked itself down
2015-04-22 10:00:14.810571 mon.0 10.7.0.152:6789/0 2269 : cluster [INF] osdmap e853: 9 osds: 6 up, 9 in
2015-04-22 10:00:14.813871 mon.0 10.7.0.152:6789/0 2270 : cluster [INF] pgmap v11445: 964 pgs: 1 active+undersized+degraded, 22 stale+active+remapped, 300 stale+active+clean, 40 active+remapped, 600 active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:15.810333 mon.0 10.7.0.152:6789/0 2271 : cluster [INF] osdmap e854: 9 osds: 6 up, 9 in
2015-04-22 10:00:15.811425 mon.0 10.7.0.152:6789/0 2272 : cluster [INF] pgmap v11446: 964 pgs: 1 active+undersized+degraded, 22 stale+active+remapped, 300 stale+active+clean, 40 active+remapped, 600 active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:16.395105 mon.0 10.7.0.152:6789/0 2273 : cluster [INF] HEALTH_WARN; 2 pgs degraded; 323 pgs stale; 2 pgs stuck degraded; 64 pgs stuck unclean; 2 pgs stuck undersized; 2 pgs undersized; 3/9 in osds are down; clock skew detected on mon.ceph1-2
2015-04-22 10:00:16.814432 mon.0 10.7.0.152:6789/0 2274 : cluster [INF] osd.1 10.7.0.152:6800/14848 boot
2015-04-22 10:00:16.814938 mon.0 10.7.0.152:6789/0 2275 : cluster [INF] osdmap e855: 9 osds: 7 up, 9 in
2015-04-22 10:00:16.815942 mon.0 10.7.0.152:6789/0 2276 : cluster [INF] pgmap v11447: 964 pgs: 1 active+undersized+degraded, 22 stale+active+remapped, 300 stale+active+clean, 40 active+remapped, 600 active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:17.222281 mon.0 10.7.0.152:6789/0 2278 : cluster [INF] osd.3 marked itself down
2015-04-22 10:00:17.819371 mon.0 10.7.0.152:6789/0 2279 : cluster [INF] osdmap e856: 9 osds: 6 up, 9 in
2015-04-22 10:00:17.822041 mon.0 10.7.0.152:6789/0 2280 : cluster [INF] pgmap v11448: 964 pgs: 1 active+undersized+degraded, 25 stale+active+remapped, 394 stale+active+clean, 37 active+remapped, 506 active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:18.551068 mon.0 10.7.0.152:6789/0 2282 : cluster [INF] osd.6 marked itself down
2015-04-22 10:00:18.819387 mon.0 10.7.0.152:6789/0 2283 : cluster [INF] osd.2 10.7.0.152:6812/15410 boot
2015-04-22 10:00:18.821134 mon.0 10.7.0.152:6789/0 2284 : cluster [INF] osdmap e857: 9 osds: 6 up, 9 in
2015-04-22 10:00:18.824440 mon.0 10.7.0.152:6789/0 2285 : cluster [INF] pgmap v11449: 964 pgs: 1 active+undersized+degraded, 30 stale+active+remapped, 502 stale+active+clean, 32 active+remapped, 398 active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:19.820947 mon.0 10.7.0.152:6789/0 2287 : cluster [INF] osdmap e858: 9 osds: 6 up, 9 in
2015-04-22 10:00:19.821853 mon.0 10.7.0.152:6789/0 2288 : cluster [INF] pgmap v11450: 964 pgs: 1 active+undersized+degraded, 30 stale+active+remapped, 502 stale+active+clean, 32 active+remapped, 398 active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:20.828047 mon.0 10.7.0.152:6789/0 2290 : cluster [INF] osd.3 10.7.0.152:6816/15971 boot
2015-04-22 10:00:20.828431 mon.0 10.7.0.152:6789/0 2291 : cluster [INF] osdmap e859: 9 osds: 7 up, 9 in
2015-04-22 10:00:20.829126 mon.0 10.7.0.152:6789/0 2292 : cluster [INF] pgmap v11451: 964 pgs: 1 active+undersized+degraded, 30 stale+active+remapped, 502 stale+active+clean, 32 active+remapped, 398 active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:20.991343 mon.0 10.7.0.152:6789/0 2294 : cluster [INF] osd.7 marked itself down
2015-04-22 10:00:21.830389 mon.0 10.7.0.152:6789/0 2295 : cluster [INF] osd.0 10.7.0.152:6804/14481 boot
2015-04-22 10:00:21.832518 mon.0 10.7.0.152:6789/0 2296 : cluster [INF] osdmap e860: 9 osds: 7 up, 9 in
2015-04-22 10:00:21.836129 mon.0 10.7.0.152:6789/0 2297 : cluster [INF] pgmap v11452: 964 pgs: 1 active+undersized+degraded, 35 stale+active+remapped, 608 stale+active+clean, 27 active+remapped, 292 active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:22.830456 mon.0 10.7.0.152:6789/0 2298 : cluster [INF] osd.6 10.7.0.153:6808/21955 boot
2015-04-22 10:00:22.832171 mon.0 10.7.0.152:6789/0 2299 : cluster [INF] osdmap e861: 9 osds: 8 up, 9 in
2015-04-22 10:00:22.836272 mon.0 10.7.0.152:6789/0 2300 : cluster [INF] pgmap v11453: 964 pgs: 3 active+undersized+degraded, 27 stale+active+remapped, 498 stale+active+clean, 2 peering, 28 active+remapped, 402 active+clean, 4 remapped+peering; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:23.420309 mon.0 10.7.0.152:6789/0 2302 : cluster [INF] osd.8 marked itself down
2015-04-22 10:00:23.833708 mon.0 10.7.0.152:6789/0 2303 : cluster [INF] osdmap e862: 9 osds: 7 up, 9 in
2015-04-22 10:00:23.836459 mon.0 10.7.0.152:6789/0 2304 : cluster [INF] pgmap v11454: 964 pgs: 3 active+undersized+degraded, 44 stale+active+remapped, 587 stale+active+clean, 2 peering, 11 active+remapped, 313 active+clean, 4 remapped+peering; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:24.832905 mon.0 10.7.0.152:6789/0 2305 : cluster [INF] osd.7 10.7.0.153:6804/22536 boot
2015-04-22 10:00:24.834381 mon.0 10.7.0.152:6789/0 2306 : cluster [INF] osdmap e863: 9 osds: 8 up, 9 in
2015-04-22 10:00:24.836977 mon.0 10.7.0.152:6789/0 2307 : cluster [INF] pgmap v11455: 964 pgs: 3 active+undersized+degraded, 31 stale+active+remapped, 503 stale+active+clean, 4 active+undersized+degraded+remapped, 5 peering, 13 active+remapped, 397 active+clean, 8 remapped+peering; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
2015-04-22 10:00:25.834459 mon.0 10.7.0.152:6789/0 2309 : cluster [INF] osdmap e864: 9 osds: 8 up, 9 in
2015-04-22 10:00:25.835727 mon.0 10.7.0.152:6789/0 2310 : cluster [INF] pgmap v11456: 964 pgs: 3 active+undersized+degraded, 31 stale+active+remapped, 503 stale+active+clean, 4 active+undersized+degraded+remapped, 5 peering, 13 active


AFTER OSD RESTART
------------------


2015-04-22 10:09:27.609052 mon.0 10.7.0.152:6789/0 2339 : cluster [INF] pgmap v11478: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 786 MB/s rd, 196 kop/s
2015-04-22 10:09:28.618082 mon.0 10.7.0.152:6789/0 2340 : cluster [INF] pgmap v11479: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 1578 MB/s rd, 394 kop/s
2015-04-22 10:09:30.629067 mon.0 10.7.0.152:6789/0 2341 : cluster [INF] pgmap v11480: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 932 MB/s rd, 233 kop/s
2015-04-22 10:09:32.645890 mon.0 10.7.0.152:6789/0 2342 : cluster [INF] pgmap v11481: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 627 MB/s rd, 156 kop/s
2015-04-22 10:09:33.652634 mon.0 10.7.0.152:6789/0 2343 : cluster [INF] pgmap v11482: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 1034 MB/s rd, 258 kop/s
2015-04-22 10:09:35.655657 mon.0 10.7.0.152:6789/0 2344 : cluster [INF] pgmap v11483: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 529 MB/s rd, 132 kop/s
2015-04-22 10:09:37.674332 mon.0 10.7.0.152:6789/0 2345 : cluster [INF] pgmap v11484: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 770 MB/s rd, 192 kop/s
2015-04-22 10:09:38.679445 mon.0 10.7.0.152:6789/0 2346 : cluster [INF] pgmap v11485: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 1358 MB/s rd, 339 kop/s
2015-04-22 10:09:40.690037 mon.0 10.7.0.152:6789/0 2347 : cluster [INF] pgmap v11486: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 649 MB/s rd, 162 kop/s
2015-04-22 10:09:42.707164 mon.0 10.7.0.152:6789/0 2348 : cluster [INF] pgmap v11487: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 580 MB/s rd, 145 kop/s
2015-04-22 10:09:43.713736 mon.0 10.7.0.152:6789/0 2349 : cluster [INF] pgmap v11488: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 962 MB/s rd, 240 kop/s
2015-04-22 10:09:45.718658 mon.0 10.7.0.152:6789/0 2350 : cluster [INF] pgmap v11489: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 506 MB/s rd, 126 kop/s
2015-04-22 10:09:47.737358 mon.0 10.7.0.152:6789/0 2351 : cluster [INF] pgmap v11490: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 774 MB/s rd, 193 kop/s
2015-04-22 10:09:48.743338 mon.0 10.7.0.152:6789/0 2352 : cluster [INF] pgmap v11491: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 1363 MB/s rd, 340 kop/s
2015-04-22 10:09:50.746685 mon.0 10.7.0.152:6789/0 2353 : cluster [INF] pgmap v11492: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 662 MB/s rd, 165 kop/s
2015-04-22 10:09:52.762461 mon.0 10.7.0.152:6789/0 2354 : cluster [INF] pgmap v11493: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 593 MB/s rd, 148 kop/s
2015-04-22 10:09:53.767729 mon.0 10.7.0.152:6789/0 2355 : cluster [INF] pgmap v11494: 964 pgs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 938 MB/s rd, 234 kop/s

