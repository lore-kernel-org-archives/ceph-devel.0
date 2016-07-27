From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Bluestore tuning
Date: Wed, 27 Jul 2016 15:40:37 +0000
Message-ID: <BL2PR02MB21154CABD62BAD59D1E8CD5FF40F0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0056.outbound.protection.outlook.com ([104.47.33.56]:39616
	"EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751918AbcG0Pkl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2016 11:40:41 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Mark Nelson (mnelson@redhat.com)" <mnelson@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

As discussed in performance meeting, I am sharing the latest Bluestore tuning findings that is giving me better and most importantly stable result in my environment.

Setup :
-------

2 OSD nodes with 8 OSDs (on 8 TB SSD) each.
Single 4TB image (with exclusive lock disabled) from single client running 10 fio jobs and each job is with 128 QD.
Replication = 2.
Fio rbd ran for 30 min.

Ceph.conf
------------
        osd_op_num_threads_per_shard = 2
        osd_op_num_shards = 25

        bluestore_rocksdb_options = "max_write_buffer_number=16,min_write_buffer_number_to_merge=2,recycle_log_file_num=16,compaction_threads=32,flusher_threads=8,max_background_compactions=32,max_background_flushes=8,max_bytes_for_level_base=5368709120,write_buffer_size=83886080,level0_file_num_compaction_trigger=4,level0_slowdown_writes_trigger=400,level0_stop_writes_trigger=800"

        rocksdb_cache_size = 4294967296
        bluestore_csum = false
        bluestore_csum_type = none
        bluestore_bluefs_buffered_io = false
        bluestore_max_ops = 30000
        bluestore_max_bytes = 629145600
        bluestore_buffer_cache_size = 104857600
        bluestore_block_wal_size = 0

[osd.0]
       host = emsnode12
       devs = /dev/sdb1
       #osd_journal = /dev/sdb1
       bluestore_block_db_path = /dev/sdb2
       #bluestore_block_wal_path = /dev/nvme0n1p1
       bluestore_block_wal_path = /dev/sdb3
       bluestore_block_path = /dev/sdb4

I have separate partition for block/db/wal..

Result:
--------
No preconditioning of rbd images , started writing 4K RW from the beginning.

Jobs: 10 (f=10): [w(10)] [100.0% done] [0KB/150.3MB/0KB /s] [0/38.5K/0 iops] [eta 00m:00s]
rbd_iodepth32: (groupid=0, jobs=10): err= 0: pid=883598: Fri Jul 22 19:43:41 2016
  write: io=282082MB, bw=160473KB/s, iops=40118, runt=1800007msec
    slat (usec): min=25, max=2578, avg=51.73, stdev=15.99
    clat (usec): min=585, max=2096.7K, avg=3913.59, stdev=9871.73
     lat (usec): min=806, max=2096.7K, avg=3965.32, stdev=9871.71
    clat percentiles (usec):
     |  1.00th=[ 1208],  5.00th=[ 1480], 10.00th=[ 1672], 20.00th=[ 1992],
     | 30.00th=[ 2288], 40.00th=[ 2608], 50.00th=[ 2992], 60.00th=[ 3440],
     | 70.00th=[ 4048], 80.00th=[ 4960], 90.00th=[ 6624], 95.00th=[ 8384],
     | 99.00th=[15680], 99.50th=[25984], 99.90th=[55552], 99.95th=[64256],
     | 99.99th=[87552]
    bw (KB  /s): min=    7, max=33864, per=10.08%, avg=16183.08, stdev=1401.82
    lat (usec) : 750=0.01%, 1000=0.10%
    lat (msec) : 2=20.39%, 4=48.81%, 10=27.70%, 20=2.30%, 50=0.55%
    lat (msec) : 100=0.14%, 250=0.01%, 2000=0.01%, >=2000=0.01%
  cpu          : usr=20.18%, sys=3.67%, ctx=96626924, majf=0, minf=166692
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=27.0%, 16=73.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.1%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=72213031/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=16

*Significantly better latency/throughput than similar setup filestore*.


This is based on my experiment on all SSD , HDD case will be different.
Tuning also depends on your cpu complex/memory, I am running with 48 core (HT enabled) dual socket Xeon on each node with 64GB of memory..

Thanks & Regards
Somnath

-----Original Message-----
From: Somnath Roy
Sent: Monday, July 11, 2016 8:04 AM
To: Mark Nelson (mnelson@redhat.com)
Cc: 'ceph-devel@vger.kernel.org'
Subject: Rocksdb tuning on Bluestore

Mark,
With the following tuning it seems rocksdb is performing better in my environment. Basically, doing aggressive compaction to reduce the write stalls.

bluestore_rocksdb_options = "max_write_buffer_number=16,min_write_buffer_number_to_merge=16,recycle_log_file_num=16,compaction_threads=32,flusher_threads=4,max_background_compactions=32,max_background_flushes=8,max_bytes_for_level_base=5368709120,write_buffer_size=83886080,level0_file_num_compaction_trigger=4,level0_slowdown_writes_trigger=400,level0_stop_writes_trigger=800"


BTW, I am not able to run BlueStore more than 2 hour at a stretch due to memory issues. It is filling up my system memory (2 node of 64 G memory , running 8 OSDS on each) fast.
The following operation I did and it started swapping.

1. Created a 4TB image and did 1M sequential preconditioning (took ~1 hour)

2. Followed by two 30 min 4k RW with QD 128 (numjob = 10) and in the 2nd run memory started swapping.

Let me know how this rocksdb option works for you.

Thanks & Regards
Somnath

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
