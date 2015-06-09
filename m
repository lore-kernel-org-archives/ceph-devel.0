From: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Subject: rbd_cache, limiting read on high iops around 40k
Date: Tue, 9 Jun 2015 07:51:46 +0200 (CEST)
Message-ID: <1684793881.1564583.1433829106394.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

I'm doing benchmark (ceph master branch), with randread 4k qdepth=32,
and rbd_cache=true seem to limit the iops around 40k


no cache
--------
1 client - rbd_cache=false - 1osd : 38300 iops
1 client - rbd_cache=false - 2osd : 69073 iops
1 client - rbd_cache=false - 3osd : 78292 iops


cache
-----
1 client - rbd_cache=true - 1osd : 38100 iops
1 client - rbd_cache=true - 2osd : 42457 iops
1 client - rbd_cache=true - 3osd : 45823 iops



Is it expected ? 



fio result rbd_cache=false 3 osd
--------------------------------
rbd_iodepth32-test: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd, iodepth=32
fio-2.1.11
Starting 1 process
rbd engine: RBD version: 0.1.9
Jobs: 1 (f=1): [r(1)] [100.0% done] [307.5MB/0KB/0KB /s] [78.8K/0/0 iops] [eta 00m:00s]
rbd_iodepth32-test: (groupid=0, jobs=1): err= 0: pid=113548: Tue Jun  9 07:48:42 2015
  read : io=10000MB, bw=313169KB/s, iops=78292, runt= 32698msec
    slat (usec): min=5, max=530, avg=11.77, stdev= 6.77
    clat (usec): min=70, max=2240, avg=336.08, stdev=94.82
     lat (usec): min=101, max=2247, avg=347.84, stdev=95.49
    clat percentiles (usec):
     |  1.00th=[  173],  5.00th=[  209], 10.00th=[  231], 20.00th=[  262],
     | 30.00th=[  282], 40.00th=[  302], 50.00th=[  322], 60.00th=[  346],
     | 70.00th=[  370], 80.00th=[  402], 90.00th=[  454], 95.00th=[  506],
     | 99.00th=[  628], 99.50th=[  692], 99.90th=[  860], 99.95th=[  948],
     | 99.99th=[ 1176]
    bw (KB  /s): min=238856, max=360448, per=100.00%, avg=313402.34, stdev=25196.21
    lat (usec) : 100=0.01%, 250=15.94%, 500=78.60%, 750=5.19%, 1000=0.23%
    lat (msec) : 2=0.03%, 4=0.01%
  cpu          : usr=74.48%, sys=13.25%, ctx=703225, majf=0, minf=12452
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.8%, 16=87.0%, 32=12.1%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=91.6%, 8=3.4%, 16=4.5%, 32=0.4%, 64=0.0%, >=64=0.0%
     issued    : total=r=2560000/w=0/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=10000MB, aggrb=313169KB/s, minb=313169KB/s, maxb=313169KB/s, mint=32698msec, maxt=32698msec

Disk stats (read/write):
    dm-0: ios=0/45, merge=0/0, ticks=0/0, in_queue=0, util=0.00%, aggrios=0/24, aggrmerge=0/21, aggrticks=0/0, aggrin_queue=0, aggrutil=0.00%
  sda: ios=0/24, merge=0/21, ticks=0/0, in_queue=0, util=0.00%




fio result rbd_cache=true 3osd
------------------------------

rbd_iodepth32-test: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd, iodepth=32
fio-2.1.11
Starting 1 process
rbd engine: RBD version: 0.1.9
Jobs: 1 (f=1): [r(1)] [100.0% done] [171.6MB/0KB/0KB /s] [43.1K/0/0 iops] [eta 00m:00s]
rbd_iodepth32-test: (groupid=0, jobs=1): err= 0: pid=113389: Tue Jun  9 07:47:30 2015
  read : io=10000MB, bw=183296KB/s, iops=45823, runt= 55866msec
    slat (usec): min=7, max=805, avg=21.26, stdev=15.84
    clat (usec): min=101, max=4602, avg=478.55, stdev=143.73
     lat (usec): min=123, max=4669, avg=499.80, stdev=146.03
    clat percentiles (usec):
     |  1.00th=[  227],  5.00th=[  274], 10.00th=[  306], 20.00th=[  350],
     | 30.00th=[  390], 40.00th=[  430], 50.00th=[  470], 60.00th=[  506],
     | 70.00th=[  548], 80.00th=[  596], 90.00th=[  660], 95.00th=[  724],
     | 99.00th=[  844], 99.50th=[  908], 99.90th=[ 1112], 99.95th=[ 1288],
     | 99.99th=[ 2192]
    bw (KB  /s): min=115280, max=204416, per=100.00%, avg=183315.10, stdev=15079.93
    lat (usec) : 250=2.42%, 500=55.61%, 750=38.48%, 1000=3.28%
    lat (msec) : 2=0.19%, 4=0.01%, 10=0.01%
  cpu          : usr=60.27%, sys=12.01%, ctx=2995393, majf=0, minf=14100
  IO depths    : 1=0.1%, 2=0.1%, 4=0.2%, 8=13.5%, 16=81.0%, 32=5.3%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=95.0%, 8=0.1%, 16=1.0%, 32=4.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=2560000/w=0/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=10000MB, aggrb=183295KB/s, minb=183295KB/s, maxb=183295KB/s, mint=55866msec, maxt=55866msec

Disk stats (read/write):
    dm-0: ios=0/61, merge=0/0, ticks=0/8, in_queue=8, util=0.01%, aggrios=0/29, aggrmerge=0/32, aggrticks=0/8, aggrin_queue=8, aggrutil=0.01%
  sda: ios=0/29, merge=0/32, ticks=0/8, in_queue=8, util=0.01%
