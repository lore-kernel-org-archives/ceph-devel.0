From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Odd WAL traffic for BlueStore
Date: Mon, 22 Aug 2016 16:46:32 +0300
Message-ID: <6efcdfb2-e25b-bceb-b10c-0669c813d917@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34301 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755614AbcHVNkj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 09:40:39 -0400
Received: by mail-lf0-f49.google.com with SMTP id l89so77997767lfi.1
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 06:40:39 -0700 (PDT)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id l19sm3765856lfi.24.2016.08.22.06.40.36
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2016 06:40:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi All,

While testing BlueStore as a standalone storage via FIO plugin I'm 
observing huge traffic to a WAL device.

Bluestore is configured to use 2 450 Gb Intel's SSD: INTEL SSDSC2BX480G4L

The first SSD is split into 2 partitions (200 & 250 Gb) for Block DB and 
Block WAL.

The second is split similarly and first 200Gb partition allocated for 
Raw Block data.

RocksDB settings are set as Somnath suggested in his 'RocksDB tuning' . 
No much difference comparing to default settings though...

As a result when doing 4k sequential write (8Gb total) to a fresh 
storage I'm observing (using nmon and other disk mon tools) significant 
write traffic to WAL device. And it grows eventually from ~10Mbs to 
~170Mbs. Raw Block device traffic is pretty stable at ~30 Mbs.

Additionally I inserted an output for BlueFS perf counters on 
umount(l_bluefs_bytes_written_wal & l_bluefs_bytes_written_sst).

The resulting values are very frustrating: ~28Gb and 4Gb for 
l_bluefs_bytes_written_wal & l_bluefs_bytes_written_sst respectively.


Doing 64K changes the picture dramatically:

WAL traffic is stable at 10-12 Mbs and RAW Block one is at ~400Mbs
BlueFS counters are ~140Mb and 1K respectively.

Surely write completes much faster in the second case.

No WAL is reported in logs at BlueStore level for both cases.


High BlueFS WAL traffic is observed when running subsequent random 4K RW 
over the store propagated this way too.

I'm wondering why WAL device is involved in the process at all ( writes 
happen in min_alloc_size blocks) operate and why the traffic and written 
data volume is so high?

Don't we have some fault affecting 4K performance here?


Here are my settings and FIO job specification:

###########################

[global]
         debug bluestore = 0/0
         debug bluefs = 1/0
         debug bdev = 0/0
         debug rocksdb = 0/0

         # spread objects over 8 collections
         osd pool default pg num = 32
         log to stderr = false

[osd]
         osd objectstore = bluestore
         bluestore_block_create = true
         bluestore_block_db_create = true
         bluestore_block_wal_create = true
         bluestore_min_alloc_size = 4096
         #bluestore_max_alloc_size = #or 4096
         bluestore_fsck_on_mount = false

         bluestore_block_path=/dev/sdi1
         bluestore_block_db_path=/dev/sde1
         bluestore_block_wal_path=/dev/sde2

         enable experimental unrecoverable data corrupting features = 
bluestore rocksdb memdb

         bluestore_rocksdb_options = 
"max_write_buffer_number=16,min_write_buffer_number_to_merge=2,recycle_log_file_num=16,compaction_threads=32,flusher_threads=8,max_background_compactions=32,max_background_flushes=8,max_bytes_for_level_base=5368709120,write_buffer_size=83886080,level0_file_num_compaction_trigger=4,level0_slowdown_writes_trigger=400,level0_stop_writes_trigger=800"

         rocksdb_cache_size = 4294967296
         bluestore_csum = false
         bluestore_csum_type = none
         bluestore_bluefs_buffered_io = false
         bluestore_max_ops = 30000
         bluestore_max_bytes = 629145600
         bluestore_buffer_cache_size = 104857600
         bluestore_block_wal_size = 0

         # use directory= option from fio job file
         osd data = ${fio_dir}

         # log inside fio_dir
         log file = ${fio_dir}/log
####################################

#FIO jobs
#################
# Runs a 4k random write test against the ceph BlueStore.
[global]
ioengine=/usr/local/lib/libfio_ceph_objectstore.so # must be found in 
your LD_LIBRARY_PATH

conf=ceph-bluestore-somnath.conf # must point to a valid ceph 
configuration file
directory=./fio-bluestore # directory for osd_data

rw=write
iodepth=16
size=256m

[bluestore]
nr_files=63
bs=4k        # or 64k
numjobs=32
#############


