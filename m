From: Sage Weil <sage@newdream.net>
Subject: Re: Odd WAL traffic for BlueStore
Date: Mon, 22 Aug 2016 16:55:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608221653450.2394@piezo.us.to>
References: <6efcdfb2-e25b-bceb-b10c-0669c813d917@mirantis.com> <alpine.DEB.2.11.1608221503560.2394@piezo.us.to> <f131f407-0a93-50c0-eab0-3cad3a0009bd@mirantis.com> <alpine.DEB.2.11.1608221512080.2394@piezo.us.to>
 <1cca0540-16e2-fbc7-b6fe-e373affd59de@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60037 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755228AbcHVQ4J (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 12:56:09 -0400
In-Reply-To: <1cca0540-16e2-fbc7-b6fe-e373affd59de@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 22 Aug 2016, Igor Fedotov wrote:
> Sage,
> 
> here it is
> 
> https://drive.google.com/open?id=0B-4q9QFReegLZmxrd19VYTc2aVU
> 
> 
> debug bluestore was set to 10 to reduce the log's size.
> 
> nr_files=8
> 
> numjobs=1
> 
> 
> Total 89Mb was written from fio.
> 
> Please note following lines at the end
> 
> 2016-08-22 15:53:01.717433 7fbf42ffd700  0 bluefs umount
> 2016-08-22 15:53:01.717440 7fbf42ffd700  0 bluefs 859013499 1069409
> 
> These are mentioned bluefs perf counters.
> 
> 859Mb for 'wal_bytes_written'!
> 
> Please let me know if you need anything else.

1) We get about 60% of the way through teh workload before rocksdb logs 
start getting recycled.  I just pushed a PR that preconditions rocksdb on 
mkfs to get rid of this weirdness:

	https://github.com/ceph/ceph/pull/10814

2) Each 4K is generating a ~10K rocksdb write.  I think this is just the 
size of the onode.  So, same thing we've been working on optimizing.

I don't think there is anything else odd going on...

sage



> 
> Thanks,
> Igor
> 
> On 22.08.2016 18:12, Sage Weil wrote:
> > debug bluestore = 20
> > debug bluefs = 20
> > debug rocksdb = 5
> > 
> > Thanks!
> > sage
> > 
> > 
> > On Mon, 22 Aug 2016, Igor Fedotov wrote:
> > 
> > > Will prepare shortly. Any suggestions on desired levels and components?
> > > 
> > > 
> > > On 22.08.2016 18:08, Sage Weil wrote:
> > > > On Mon, 22 Aug 2016, Igor Fedotov wrote:
> > > > > Hi All,
> > > > > 
> > > > > While testing BlueStore as a standalone storage via FIO plugin I'm
> > > > > observing
> > > > > huge traffic to a WAL device.
> > > > > 
> > > > > Bluestore is configured to use 2 450 Gb Intel's SSD: INTEL
> > > > > SSDSC2BX480G4L
> > > > > 
> > > > > The first SSD is split into 2 partitions (200 & 250 Gb) for Block DB
> > > > > and
> > > > > Block
> > > > > WAL.
> > > > > 
> > > > > The second is split similarly and first 200Gb partition allocated for
> > > > > Raw
> > > > > Block data.
> > > > > 
> > > > > RocksDB settings are set as Somnath suggested in his 'RocksDB tuning'
> > > > > . No
> > > > > much difference comparing to default settings though...
> > > > > 
> > > > > As a result when doing 4k sequential write (8Gb total) to a fresh
> > > > > storage
> > > > > I'm
> > > > > observing (using nmon and other disk mon tools) significant write
> > > > > traffic
> > > > > to
> > > > > WAL device. And it grows eventually from ~10Mbs to ~170Mbs. Raw Block
> > > > > device
> > > > > traffic is pretty stable at ~30 Mbs.
> > > > > 
> > > > > Additionally I inserted an output for BlueFS perf counters on
> > > > > umount(l_bluefs_bytes_written_wal & l_bluefs_bytes_written_sst).
> > > > > 
> > > > > The resulting values are very frustrating: ~28Gb and 4Gb for
> > > > > l_bluefs_bytes_written_wal & l_bluefs_bytes_written_sst respectively.
> > > > Yeah, this doesn't seem right.  Have you generated a log to see what is
> > > > actually happening on each write?  I don't have any bright ideas about
> > > > what is going wrong here.
> > > > 
> > > > sage
> > > > 
> > > > > Doing 64K changes the picture dramatically:
> > > > > 
> > > > > WAL traffic is stable at 10-12 Mbs and RAW Block one is at ~400Mbs
> > > > > BlueFS counters are ~140Mb and 1K respectively.
> > > > > 
> > > > > Surely write completes much faster in the second case.
> > > > > 
> > > > > No WAL is reported in logs at BlueStore level for both cases.
> > > > > 
> > > > > 
> > > > > High BlueFS WAL traffic is observed when running subsequent random 4K
> > > > > RW
> > > > > over
> > > > > the store propagated this way too.
> > > > > 
> > > > > I'm wondering why WAL device is involved in the process at all (
> > > > > writes
> > > > > happen
> > > > > in min_alloc_size blocks) operate and why the traffic and written data
> > > > > volume
> > > > > is so high?
> > > > > 
> > > > > Don't we have some fault affecting 4K performance here?
> > > > > 
> > > > > 
> > > > > Here are my settings and FIO job specification:
> > > > > 
> > > > > ###########################
> > > > > 
> > > > > [global]
> > > > >           debug bluestore = 0/0
> > > > >           debug bluefs = 1/0
> > > > >           debug bdev = 0/0
> > > > >           debug rocksdb = 0/0
> > > > > 
> > > > >           # spread objects over 8 collections
> > > > >           osd pool default pg num = 32
> > > > >           log to stderr = false
> > > > > 
> > > > > [osd]
> > > > >           osd objectstore = bluestore
> > > > >           bluestore_block_create = true
> > > > >           bluestore_block_db_create = true
> > > > >           bluestore_block_wal_create = true
> > > > >           bluestore_min_alloc_size = 4096
> > > > >           #bluestore_max_alloc_size = #or 4096
> > > > >           bluestore_fsck_on_mount = false
> > > > > 
> > > > >           bluestore_block_path=/dev/sdi1
> > > > >           bluestore_block_db_path=/dev/sde1
> > > > >           bluestore_block_wal_path=/dev/sde2
> > > > > 
> > > > >           enable experimental unrecoverable data corrupting features =
> > > > > bluestore
> > > > > rocksdb memdb
> > > > > 
> > > > >           bluestore_rocksdb_options =
> > > > > "max_write_buffer_number=16,min_write_buffer_number_to_merge=2,recycle_log_file_num=16,compaction_threads=32,flusher_threads=8,max_background_compactions=32,max_background_flushes=8,max_bytes_for_level_base=5368709120,write_buffer_size=83886080,level0_file_num_compaction_trigger=4,level0_slowdown_writes_trigger=400,level0_stop_writes_trigger=800"
> > > > > 
> > > > >           rocksdb_cache_size = 4294967296
> > > > >           bluestore_csum = false
> > > > >           bluestore_csum_type = none
> > > > >           bluestore_bluefs_buffered_io = false
> > > > >           bluestore_max_ops = 30000
> > > > >           bluestore_max_bytes = 629145600
> > > > >           bluestore_buffer_cache_size = 104857600
> > > > >           bluestore_block_wal_size = 0
> > > > > 
> > > > >           # use directory= option from fio job file
> > > > >           osd data = ${fio_dir}
> > > > > 
> > > > >           # log inside fio_dir
> > > > >           log file = ${fio_dir}/log
> > > > > ####################################
> > > > > 
> > > > > #FIO jobs
> > > > > #################
> > > > > # Runs a 4k random write test against the ceph BlueStore.
> > > > > [global]
> > > > > ioengine=/usr/local/lib/libfio_ceph_objectstore.so # must be found in
> > > > > your
> > > > > LD_LIBRARY_PATH
> > > > > 
> > > > > conf=ceph-bluestore-somnath.conf # must point to a valid ceph
> > > > > configuration
> > > > > file
> > > > > directory=./fio-bluestore # directory for osd_data
> > > > > 
> > > > > rw=write
> > > > > iodepth=16
> > > > > size=256m
> > > > > 
> > > > > [bluestore]
> > > > > nr_files=63
> > > > > bs=4k        # or 64k
> > > > > numjobs=32
> > > > > #############
> > > > > 
> > > > > 
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > > > in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > > 
> > > > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
