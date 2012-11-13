From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Performance problems or expected behavior?
Date: Tue, 13 Nov 2012 14:17:58 +0100
Message-ID: <CAOLwVUkVRd=_oWeJsULbnNhFQszQnmNU+wbkAsKepAWRiiRgow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55829 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab2KMNSV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 08:18:21 -0500
Received: by mail-lb0-f174.google.com with SMTP id gp3so166173lbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 05:18:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

I performed some benchmarks with fio with a block size of 4K. I guess
I experienced some performance problems, I can hardly imagine that the
IOPS can be so low...

My setup:

- 4 servers HP DL 360 G7 :
    - E5606/ 2.13GHz 4C
    - 6GB RAM
    - root fs: HP 72GB 15K SAS RAID 1
    - Controller JBOD with writeback enable
    - 3 OSDs per server = 11 in total
    - 3 MONs
    - OSD disk: 600GB 10K SAS on XFS mounted with the following options:
            * rw,noexec,nodev,noatime,nodiratime,barrier=0
    - ubuntu 12.04.1 LTS
    - ceph 0.48.2
    - journals are stored on an SSD (journal on file not on block
device), with over-provisioning. The SSD is an OCZ vertex 4
    - pg num 450 for each pool
    - replica count of 2

- network:
    - 1GB
    - separate network for client and replication
    - no network bottleneck, iperf test has been performed

Ceph conf relevant sections:

- auth supported = none
- osd journal size = 2048
- osd op threads = 24
- osd disk threads = 24
- filestore op threads = 6
- filestore queue max ops = 24
- filestore_flusher = false

RADOS Benchmarks (writes) with default options:

2012-10-31 22:46:54.133042min lat: 0.088034 max lat: 2.64786 avg lat: 0.425305
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
   100      16      3767      3751   150.016       152   0.19291  0.425305
 Total time run:         100.326526
Total writes made:      3767
Write size:             4194304
Bandwidth (MB/sec):     150.190

Stddev Bandwidth:       15.8426
Max bandwidth (MB/sec): 200
Min bandwidth (MB/sec): 108
Average Latency:        0.425902
Stddev Latency:         0.322846
Max latency:            2.64786
Min latency:            0.088034

For information, a DD with a block size of 1G shows 110MB/sec with
direct I/O. It's not so relevant nor a real life scenario but it's
something...

RADOS bench with 4K:

# rados -p bench bench 300 write -b 4096 -t 32 --no-cleanup
2012-11-13 09:38:44.485547min lat: 0.001807 max lat: 2.77526 avg lat: 0.0423748
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
   300      31    226546    226515   2.94867   6.35156  0.003276 0.0423748
 Total time run:         300.108349
Total writes made:      226546
Write size:             4096
Bandwidth (MB/sec):     2.949

Stddev Bandwidth:       1.93903
Max bandwidth (MB/sec): 12.2188
Min bandwidth (MB/sec): 0.015625
Average Latency:        0.0423857
Stddev Latency:         0.130588
Max latency:            2.77526
Min latency:            0.001807

Then seq:

# rados -p bench bench 300 seq -b 4096 -t 32
2012-11-13 09:40:09.465216min lat: 0.000678 max lat: 0.226029 avg lat:
0.00714306
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
    40      31    179179    179148   17.4924   32.3945   0.001880.00714306
    41      31    188937    188906   17.9953   38.1172  0.001151 0.0069414
    42      32    196223    196191   18.2443    28.457  0.0012570.00684898
    43      32    205245    205213    18.638   35.2422  0.0014290.00670422
    44      31    214193    214162   19.0088    34.957  0.0014850.00657379
    45      31    223028    222997   19.3532   34.5117  0.0012870.00645649
 Total time run:        45.368758
Total reads made:     226546
Read size:            4096
Bandwidth (MB/sec):    19.506

Average Latency:       0.00640665
Max latency:           0.226029
Min latency:           0.000672

Fio template used to bench the rbd device:

[global]
ioengine=libaio
iodepth=100
size=1g
direct=1
runtime=60
filename=/dev/rbd2

[seq-read]
rw=read
bs=4M
stonewall

[rand-read]
rw=randread
bs=4k
stonewall

[seq-write]
rw=write
bs=4M
stonewall

[rand-write]
rw=randwrite
bs=4K
stonewall

Results:

fio rbd-bench.fio
seq-read: (g=0): rw=read, bs=4M-4M/4M-4M, ioengine=libaio, iodepth=100
rand-read: (g=1): rw=randread, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=100
seq-write: (g=2): rw=write, bs=4M-4M/4M-4M, ioengine=libaio, iodepth=100
rand-write: (g=3): rw=randwrite, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=100
fio 1.59
Starting 4 processes
Jobs: 1 (f=1): [___w] [75.0% done] [0K/0K /s] [0 /0  iops] [eta 00m:33s]
seq-read: (groupid=0, jobs=1): err= 0: pid=6302
  read : io=1024.0MB, bw=104879KB/s, iops=25 , runt=  9998msec
    slat (usec): min=298 , max=409745 , avg=36384.06, stdev=68708.48
    clat (msec): min=681 , max=5488 , avg=3383.33, stdev=1108.83
     lat (msec): min=682 , max=5637 , avg=3419.71, stdev=1109.07
    bw (KB/s) : min=    0, max=114975, per=8.97%, avg=9410.35, stdev=29174.91
  cpu          : usr=0.00%, sys=2.28%, ctx=1644, majf=0, minf=102423
  IO depths    : 1=0.4%, 2=0.8%, 4=1.6%, 8=3.1%, 16=6.2%, 32=12.5%, >=64=75.4%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.4%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.6%
     issued r/w/d: total=256/0/0, short=0/0/0

     lat (msec): 750=1.56%, 1000=3.12%, 2000=9.38%, >=2000=85.94%
rand-read: (groupid=1, jobs=1): err= 0: pid=6547
  read : io=1024.0MB, bw=65263KB/s, iops=16315 , runt= 16067msec
    slat (usec): min=11 , max=244 , avg=24.82, stdev= 6.13
    clat (usec): min=487 , max=44231 , avg=6100.85, stdev=6567.64
     lat (usec): min=518 , max=44254 , avg=6125.99, stdev=6567.76
    bw (KB/s) : min=29232, max=98960, per=100.23%, avg=65413.25, stdev=29122.39
  cpu          : usr=5.83%, sys=32.89%, ctx=346477, majf=0, minf=122
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued r/w/d: total=262144/0/0, short=0/0/0
     lat (usec): 500=0.01%, 750=2.55%, 1000=5.85%
     lat (msec): 2=25.49%, 4=27.47%, 10=14.39%, 20=19.13%, 50=5.12%
seq-write: (groupid=2, jobs=1): err= 0: pid=6845
  write: io=1024.0MB, bw=114386KB/s, iops=27 , runt=  9167msec
    slat (usec): min=449 , max=187559 , avg=33082.90, stdev=59961.36
    clat (msec): min=695 , max=5848 , avg=3062.17, stdev=948.73
     lat (msec): min=696 , max=5848 , avg=3095.26, stdev=948.11
    bw (KB/s) : min=    0, max=134945, per=8.89%, avg=10166.26, stdev=32757.63
  cpu          : usr=1.09%, sys=0.61%, ctx=195, majf=0, minf=21
  IO depths    : 1=0.4%, 2=0.8%, 4=1.6%, 8=3.1%, 16=6.2%, 32=12.5%, >=64=75.4%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.4%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.6%
     issued r/w/d: total=0/256/0, short=0/0/0

     lat (msec): 750=1.56%, 1000=3.12%, 2000=10.94%, >=2000=84.38%
rand-write: (groupid=3, jobs=1): err= 0: pid=7054
  write: io=189480KB, bw=3053.3KB/s, iops=763 , runt= 62063msec
    slat (usec): min=11 , max=250 , avg=50.78, stdev=11.57
    clat (msec): min=1 , max=4592 , avg=130.92, stdev=388.57
     lat (msec): min=1 , max=4592 , avg=130.97, stdev=388.57
    bw (KB/s) : min=    0, max=10408, per=58.69%, avg=1791.67, stdev=2133.80
  cpu          : usr=0.49%, sys=2.54%, ctx=80620, majf=0, minf=19
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued r/w/d: total=0/47370/0, short=0/0/0

     lat (msec): 2=22.08%, 4=43.68%, 10=2.50%, 20=1.72%, 50=5.01%
     lat (msec): 100=6.45%, 250=6.44%, 500=3.89%, 750=2.70%, 1000=1.76%
     lat (msec): 2000=2.83%, >=2000=0.93%

Run status group 0 (all jobs):
   READ: io=1024.0MB, aggrb=104878KB/s, minb=107395KB/s,
maxb=107395KB/s, mint=9998msec, maxt=9998msec

Run status group 1 (all jobs):
   READ: io=1024.0MB, aggrb=65262KB/s, minb=66829KB/s, maxb=66829KB/s,
mint=16067msec, maxt=16067msec

Run status group 2 (all jobs):
  WRITE: io=1024.0MB, aggrb=114385KB/s, minb=117131KB/s,
maxb=117131KB/s, mint=9167msec, maxt=9167msec

Run status group 3 (all jobs):
  WRITE: io=189480KB, aggrb=3053KB/s, minb=3126KB/s, maxb=3126KB/s,
mint=62063msec, maxt=62063msec

Disk stats (read/write):
  rbd2: ios=264358/49408, merge=0/0, ticks=2983236/7311972,
in_queue=10315204, util=98.99%

The RBD has been mapped on a client machine, connected to the ceph
cluster via the public network.

If you need more information, please ask.

Thanks in advance. Performance Gurus, it's all yours :)

Cheers!
