From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Impact of page cache on OSD read performance for SSD
Date: Tue, 23 Sep 2014 18:05:17 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F278492BA@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0093.outbound.protection.outlook.com ([157.56.110.93]:2082
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755777AbaIWSFW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Sep 2014 14:05:22 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
I have created the following setup in order to examine how a single OSD is behaving if say ~80-90% of ios hitting the SSDs.

My test includes the following steps.

        1. Created a single OSD cluster.
        2. Created two rbd images (110GB each) on 2 different pools.
        3. Populated entire image, so my working set is ~210GB. My system memory is ~16GB.
        4. Dumped page cache before every run.
        5. Ran fio_rbd (QD 32, 8 instances) in parallel on these two images.

Here is my disk iops/bandwidth..

        root@emsclient:~/fio_test# fio rad_resd_disk.job
        random-reads: (g=0): rw=randread, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=64
        2.0.8
        Starting 1 process
        Jobs: 1 (f=1): [r] [100.0% done] [154.1M/0K /s] [39.7K/0  iops] [eta 00m:00s]
        random-reads: (groupid=0, jobs=1): err= 0: pid=1431
        read : io=9316.4MB, bw=158994KB/s, iops=39748 , runt= 60002msec

My fio_rbd config..

[global]
ioengine=rbd
clientname=admin
pool=rbd1
rbdname=ceph_regression_test1
invalidate=0    # mandatory
rw=randread
bs=4k
direct=1
time_based
runtime=2m
size=109G
numjobs=8
[rbd_iodepth32]
iodepth=32

Now, I have run Giant Ceph on top of that..

1. OSD config with 25 shards/1 thread per shard :
-------------------------------------------------------

         avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          22.04    0.00   16.46   45.86    0.00   15.64

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     9.00    0.00    6.00     0.00    92.00    30.67     0.01    1.33    0.00    1.33   1.33   0.80
sdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sde               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdg               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdf               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdh             181.00     0.00 34961.00    0.00 176740.00     0.00    10.11   102.71    2.92    2.92    0.00   0.03 100.00
sdc               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00


ceph -s:
 ----------
root@emsclient:~# ceph -s
    cluster 94991097-7638-4240-b922-f525300a9026
     health HEALTH_OK
     monmap e1: 1 mons at {a=10.196.123.24:6789/0}, election epoch 1, quorum 0 a
     osdmap e498: 1 osds: 1 up, 1 in
      pgmap v386366: 832 pgs, 7 pools, 308 GB data, 247 kobjects
            366 GB used, 1122 GB / 1489 GB avail
                 832 active+clean
  client io 75215 kB/s rd, 18803 op/s

 cpu util:
----------
 Gradually decreases from ~21 core (serving from cache) to ~10 core (while serving from disks).

 My Analysis:
-----------------
 In this case "All is Well"  till ios are served from cache (XFS is smart enough to cache some data ) . Once started hitting disks and throughput is decreasing. As you can see, disk is giving ~35K iops , but, OSD throughput is only ~18.8K ! So, cache miss in case of buffered io seems to be very
 expensive.  Half of the iops are waste. Also, looking at the bandwidth, it is obvious, not everything is 4K read, May be kernel read_ahead is kicking (?).


Now, I thought of making ceph disk read as direct_io and do the same experiment. I have changed the FileStore::read to do the direct_io only. Rest kept as is. Here is the result with that.


Iostat:
-------

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          24.77    0.00   19.52   21.36    0.00   34.36

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sde               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdg               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdf               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdh               0.00     0.00 25295.00    0.00 101180.00     0.00     8.00    12.73    0.50    0.50    0.00   0.04 100.80
sdc               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

ceph -s:
 --------
root@emsclient:~/fio_test# ceph -s
    cluster 94991097-7638-4240-b922-f525300a9026
     health HEALTH_OK
     monmap e1: 1 mons at {a=10.196.123.24:6789/0}, election epoch 1, quorum 0 a
     osdmap e522: 1 osds: 1 up, 1 in
      pgmap v386711: 832 pgs, 7 pools, 308 GB data, 247 kobjects
            366 GB used, 1122 GB / 1489 GB avail
                 832 active+clean
  client io 100 MB/s rd, 25618 op/s

cpu util:
--------
  ~14 core while serving from disks.

 My Analysis:
 ---------------
No surprises here. Whatever is disk throughput ceph throughput is almost matching.


Let's tweak the shard/thread settings and see the impact.


2. OSD config with 36 shards and 1 thread/shard:
-----------------------------------------------------------

   Buffered read:
   ------------------
  No change, output is very similar to 25 shards.


  direct_io read:
  ------------------
       Iostat:
      ----------
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          33.33    0.00   28.22   23.11    0.00   15.34

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     0.00    0.00    2.00     0.00    12.00    12.00     0.00    0.00    0.00    0.00   0.00   0.00
sdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sde               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdg               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdf               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdh               0.00     0.00 31987.00    0.00 127948.00     0.00     8.00    18.06    0.56    0.56    0.00   0.03 100.40
sdc               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

       ceph -s:
    --------------
root@emsclient:~/fio_test# ceph -s
    cluster 94991097-7638-4240-b922-f525300a9026
     health HEALTH_OK
     monmap e1: 1 mons at {a=10.196.123.24:6789/0}, election epoch 1, quorum 0 a
     osdmap e525: 1 osds: 1 up, 1 in
      pgmap v386746: 832 pgs, 7 pools, 308 GB data, 247 kobjects
            366 GB used, 1122 GB / 1489 GB avail
                 832 active+clean
  client io 127 MB/s rd, 32763 op/s

        cpu util:
   --------------
       ~19 core while serving from disks.

         Analysis:
------------------
        It is scaling with increased number of shards/threads. The parallelism also increased significantly.


3. OSD config with 48 shards and 1 thread/shard:
 ----------------------------------------------------------
    Buffered read:
   -------------------
    No change, output is very similar to 25 shards.


   direct_io read:
    -----------------
       Iostat:
      --------

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          37.50    0.00   33.72   20.03    0.00    8.75

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sde               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdg               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdf               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdh               0.00     0.00 35360.00    0.00 141440.00     0.00     8.00    22.25    0.62    0.62    0.00   0.03 100.40
sdc               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

         ceph -s:
       --------------
root@emsclient:~/fio_test# ceph -s
    cluster 94991097-7638-4240-b922-f525300a9026
     health HEALTH_OK
     monmap e1: 1 mons at {a=10.196.123.24:6789/0}, election epoch 1, quorum 0 a
     osdmap e534: 1 osds: 1 up, 1 in
      pgmap v386830: 832 pgs, 7 pools, 308 GB data, 247 kobjects
            366 GB used, 1122 GB / 1489 GB avail
                 832 active+clean
  client io 138 MB/s rd, 35582 op/s

         cpu util:
 ----------------
        ~22.5 core while serving from disks.

          Analysis:
 --------------------
        It is scaling with increased number of shards/threads. The parallelism also increased significantly.



4. OSD config with 64 shards and 1 thread/shard:
 ---------------------------------------------------------
      Buffered read:
     ------------------
     No change, output is very similar to 25 shards.


     direct_io read:
     -------------------
       Iostat:
      ---------
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          40.18    0.00   34.84   19.81    0.00    5.18

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sde               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdg               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdf               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdh               0.00     0.00 39114.00    0.00 156460.00     0.00     8.00    35.58    0.90    0.90    0.00   0.03 100.40
sdc               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

       ceph -s:
 ---------------
root@emsclient:~/fio_test# ceph -s
    cluster 94991097-7638-4240-b922-f525300a9026
     health HEALTH_OK
     monmap e1: 1 mons at {a=10.196.123.24:6789/0}, election epoch 1, quorum 0 a
     osdmap e537: 1 osds: 1 up, 1 in
      pgmap v386865: 832 pgs, 7 pools, 308 GB data, 247 kobjects
            366 GB used, 1122 GB / 1489 GB avail
                 832 active+clean
  client io 153 MB/s rd, 39172 op/s

      cpu util:
----------------
    ~24.5 core while serving from disks. ~3% cpu left.

       Analysis:
------------------
      It is scaling with increased number of shards/threads. The parallelism also increased significantly. It is disk bound now.


Summary:

So, it seems buffered IO has significant impact on performance in case backend is SSD.
My question is,  if the workload is very random and storage(SSD) is very huge compare to system memory, shouldn't we always go for direct_io instead of buffered io from Ceph ?

Please share your thoughts/suggestion on this.

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

