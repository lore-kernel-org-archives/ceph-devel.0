From: Sage Weil <sweil@redhat.com>
Subject: RE: Bluestore assert
Date: Wed, 31 Aug 2016 13:20:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608311318350.19032@piezo.us.to>
References: <BL2PR02MB2115443F5ACA3459E2CEBFBAF41D0@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608112226280.17762@piezo.us.to> <BL2PR02MB2115BB77EA5BA38BCF48E52DF4110@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608151952230.14754@piezo.us.to>
 <BL2PR02MB21150BE782012D52DBB8FF26F4130@BL2PR02MB2115.namprd02.prod.outlook.com> <BL2PR02MB2115FFBBBF5A04D62910A239F4E80@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608222156580.25681@piezo.us.to>  <BL2PR02MB2115C713F6AF6B989B4DC536F4E80@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231343530.25678@piezo.us.to>  <CY1PR02MB2123D6119409C1F61BF39A46F4EA0@CY1PR02MB2123.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608242042510.25681@piezo.us.to> <CY1PR02MB21235A07222322180C0E2BDFF4EA0@CY1PR02MB2123.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608242132460.25681@piezo.us.to>    <BL2PR02MB21154C4E291C96D597444649F4E00@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751128AbcHaNUR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 09:20:17 -0400
In-Reply-To: <BL2PR02MB21154C4E291C96D597444649F4E00@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 30 Aug 2016, Somnath Roy wrote:
> Sage,
> I did some debugging on the rocksdb bug., here is my findings.
> 
> 1. The log file number is added to log_recycle_files and *not* in log_delete_files from the following if loop, which is expected.
> 
> https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698f460609bf7cea4b63/db/db_impl.cc#L854
> 
> 2. But, it is there in the candidate list in the following loop.
> 
> https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698f460609bf7cea4b63/db/db_impl.cc#L1000
> 
> 
> 3. This means it is added in full_scan_candidate_files from the following  from a full scan (?)
> 
> https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698f460609bf7cea4b63/db/db_impl.cc#L834
> 
> Added some log entries to verify , need to wait 6 hours :-(
> 
> 4. Probably, #3 is not unusual , but the check in the following seems not sufficient to keep the file.
> 
> https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698f460609bf7cea4b63/db/db_impl.cc#L1013
> 
> Again, added some log to see the state.log_number during that time. BTW, I have seen the following check probably noop as state.prev_log_number is always coming 0.
> 
> (number == state.prev_log_number)
> 
> 5. So, the quick solution I am thinking is to put a check to see if the log is in recycle list and avoid deleting from the above part (?).

That seems reasonable.  I suggest coding this up and submitting a PR to 
github.com/facebook/rocksdb, and ask in the comment if there is a better 
solution.

Probably the recycle list should be turned into a set so that the check is 
O(log n)...

Thanks!
sage


> 
> Let me know what you think.
> 
> Thanks & Regards
> Somnath
> -----Original Message-----
> From: Somnath Roy 
> Sent: Sunday, August 28, 2016 7:37 AM
> To: 'Sage Weil'
> Cc: 'Mark Nelson'; 'ceph-devel'
> Subject: RE: Bluestore assert
> 
> Sage,
> Some updates on this.
> 
> 1. The issue is reproduced with the latest rocksdb master as well.
> 
> 2. The issue is *not happening* if I run disabling rocksdb log recycling. This proves our root cause is right.
> 
> 3. Running some more performance tests by disabling log recycling , but, initial impression is, it is introducing spikes and output is not as stable as enabling log recycling.
> 
> 4. Created a rocksdb issue for this (https://github.com/facebook/rocksdb/issues/1303)
> 
> Thanks & Regards
> Somnath
> 
> 
> -----Original Message-----
> From: Somnath Roy
> Sent: Thursday, August 25, 2016 2:35 PM
> To: 'Sage Weil'
> Cc: 'Mark Nelson'; 'ceph-devel'
> Subject: RE: Bluestore assert
> 
> Sage,
> Hope you are able to download the log I shared via google doc.
> It seems the bug is around this portion.
> 
> 2016-08-25 00:44:03.348710 7f7c117ff700  4 rocksdb: adding log 254 to recycle list
> 
> 2016-08-25 00:44:03.348722 7f7c117ff700  4 rocksdb: adding log 256 to recycle list
> 
> 2016-08-25 00:44:03.348725 7f7c117ff700  4 rocksdb: (Original Log Time 2016/08/25-00:44:03.347467) [default] Level-0 commit table #258 started
> 2016-08-25 00:44:03.348727 7f7c117ff700  4 rocksdb: (Original Log Time 2016/08/25-00:44:03.348225) [default] Level-0 commit table #258: memtable #1 done
> 2016-08-25 00:44:03.348729 7f7c117ff700  4 rocksdb: (Original Log Time 2016/08/25-00:44:03.348227) [default] Level-0 commit table #258: memtable #2 done
> 2016-08-25 00:44:03.348730 7f7c117ff700  4 rocksdb: (Original Log Time 2016/08/25-00:44:03.348239) EVENT_LOG_v1 {"time_micros": 1472111043348233, "job": 88, "event": "flush_finished", "lsm_state": [3, 4, 0, 0, 0, 0, 0], "immutable_memtables": 0}
> 2016-08-25 00:44:03.348735 7f7c117ff700  4 rocksdb: (Original Log Time 2016/08/25-00:44:03.348297) [default] Level summary: base level 1 max bytes base 5368709120 files[3 4 0 0 0 0 0] max score 0.75
> 
> 2016-08-25 00:44:03.348751 7f7c117ff700  4 rocksdb: [JOB 88] Try to delete WAL files size 131512372, prev total WAL file size 131834601, number of live WAL files 3.
> 
> 2016-08-25 00:44:03.348761 7f7c117ff700 10 bluefs unlink db.wal/000256.log
> 2016-08-25 00:44:03.348766 7f7c117ff700 20 bluefs _drop_link had refs 1 on file(ino 19 size 0x3f3ddd9 mtime 2016-08-25 00:41:26.298423 bdev 0 extents [0:0xc500000+200000,0:0xcb00000+800000,0:0xd700000+700000,0:0xe200000+800000,0:0xee00000+800000,0:0xfa00000+800000,0:0x10600000+700000,0:0x11100000+700000,0:0x11c00000+800000,0:0x12800000+100000])
> 2016-08-25 00:44:03.348775 7f7c117ff700 20 bluefs _drop_link destroying file(ino 19 size 0x3f3ddd9 mtime 2016-08-25 00:41:26.298423 bdev 0 extents [0:0xc500000+200000,0:0xcb00000+800000,0:0xd700000+700000,0:0xe200000+800000,0:0xee00000+800000,0:0xfa00000+800000,0:0x10600000+700000,0:0x11100000+700000,0:0x11c00000+800000,0:0x12800000+100000])
> 2016-08-25 00:44:03.348794 7f7c117ff700 10 bluefs unlink db.wal/000254.log
> 2016-08-25 00:44:03.348796 7f7c117ff700 20 bluefs _drop_link had refs 1 on file(ino 18 size 0x3f3d402 mtime 2016-08-25 00:41:26.299110 bdev 0 extents [0:0x6500000+400000,0:0x6d00000+700000,0:0x7800000+800000,0:0x8400000+800000,0:0x9000000+800000,0:0x9c00000+700000,0:0xa700000+900000,0:0xb400000+800000,0:0xc000000+500000])
> 2016-08-25 00:44:03.348803 7f7c117ff700 20 bluefs _drop_link destroying file(ino 18 size 0x3f3d402 mtime 2016-08-25 00:41:26.299110 bdev 0 extents [0:0x6500000+400000,0:0x6d00000+700000,0:0x7800000+800000,0:0x8400000+800000,0:0x9000000+800000,0:0x9c00000+700000,0:0xa700000+900000,0:0xb400000+800000,0:0xc000000+500000])
> 
> So, log 254 is added to the recycle list and at the same time it is added for deletion. It seems there is a race condition in this portion (?).
> 
> I was going through the rocksdb code and I found the following.
> 
> 1. DBImpl::FindObsoleteFiles is the one that is responsible for populating log_recycle_files and log_delete_files. It is also deleting entries from alive_log_files_. But, this is always under mutex_ lock.
> 
> 2. Log is deleted from DBImpl::DeleteObsoleteFileImpl which is *not* under lock , but iterating over log_delete_files. This is fishy but it shouldn't be the reason for same log number end up in two list.
> 
> 3. I saw all the places but the following  place alive_log_files_ (within DBImpl::WriteImpl)  is accessed without lock.
> 
> 4625       alive_log_files_.back().AddSize(log_entry.size());   
> 
> Can it be reintroducing the same log number (254) , I am not sure.
> 
> Summary, it seems a rocksb bug and making recycle_log_file_num = 0 should *bypass* that. I need to check the performance impact for this though.
> 
> Should I post this to rocksdb community or any other place from where I can get response from rocksdb folks ?
> 
> Thanks & Regards
> Somnath
> 
> 
> -----Original Message-----
> From: Somnath Roy
> Sent: Wednesday, August 24, 2016 2:52 PM
> To: 'Sage Weil'
> Cc: Mark Nelson; ceph-devel
> Subject: RE: Bluestore assert
> 
> Sage,
> Thanks for looking , glad that we figured out something :-)..
> So, you want me to reproduce this with only debug_bluefs = 20/20 ? Don't need bluestore log ?
> Hope my root partition doesn't get full , this crash happened after 6 hours :-) , 
> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Wednesday, August 24, 2016 2:34 PM
> To: Somnath Roy
> Cc: Mark Nelson; ceph-devel
> Subject: RE: Bluestore assert
> 
> On Wed, 24 Aug 2016, Somnath Roy wrote:
> > Sage, It is there in the following github link I posted earlier..You 
> > can see 3 logs there..
> > 
> > https://github.com/somnathr/ceph/commit/b69811eb2b87f25cf017b39c687d88
> > a1b28fcc39
> 
> Ah sorry, got it.
> 
> And looking at the crash and code the weird error you're getting makes perfect sense: it's coming from the ReuseWritableFile() function (which gets and error on rename and returns that).  It shouldn't ever fail, so there is either a bug in the bluefs code or the rocksdb recycling code.
> 
> I think we need a full bluefs log leading up to the crash so we can find out what happened to the file that is missing...
> 
> sage
> 
> 
> 
>  > 
> > Thanks & Regards
> > Somnath
> > 
> > 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Wednesday, August 24, 2016 1:43 PM
> > To: Somnath Roy
> > Cc: Mark Nelson; ceph-devel
> > Subject: RE: Bluestore assert
> > 
> > On Wed, 24 Aug 2016, Somnath Roy wrote:
> > > Sage,
> > > I got the db assert log from submit_transaction in the following location.
> > > 
> > > https://github.com/somnathr/ceph/commit/b69811eb2b87f25cf017b39c687d
> > > 88
> > > a1b28fcc39
> > > 
> > > This is the log with level 1/20 and with my hook of printing rocksdb::writebatch transaction. I have uploaded 3 osd logs and a common pattern before crash is the following.
> > > 
> > >    -34> 2016-08-24 02:37:22.074321 7ff151fff700  4 rocksdb: reusing 
> > > log 266 from recycle list
> > > 
> > >    -33> 2016-08-24 02:37:22.074332 7ff151fff700 10 bluefs rename db.wal/000266.log -> db.wal/000271.log
> > >    -32> 2016-08-24 02:37:22.074338 7ff151fff700 20 bluefs rename dir db.wal (0x7ff18bdfdec0) file 000266.log not found
> > >    -31> 2016-08-24 02:37:22.074341 7ff151fff700  4 rocksdb: [default] New memtable created with log file: #271. Immutable memtables: 0.
> > > 
> > > It is trying to rename the wal file it seems and old file is not found. You can see the transaction printed in the log along with error code like this.
> > 
> > How much of the log do you have? Can you post what you have somewhere?
> > 
> > Thanks!
> > sage
> > 
> > 
> > > 
> > >    -30> 2016-08-24 02:37:22.074486 7ff151fff700 -1 rocksdb: 
> > > submit_transaction error: NotFound:  code = 1 rocksdb::WriteBatch = 
> > > Put( Prefix = M key =
> > > 0x0000000000001483'.0000000087.00000000000000035303')
> > > Put( Prefix = M key = 0x0000000000001483'._info') Put( Prefix = O 
> > > key =
> > > '--'0x800000000000000137863de5'.!=rbd_data.105b6b8b4567.000000000089
> > > ac
> > > e7!'0xfffffffffffffffeffffffffffffffff)
> > > Delete( Prefix = B key = 0x000004e73ae72000) Put( Prefix = B key =
> > > 0x000004e73af72000) Merge( Prefix = T key = 'bluestore_statfs')
> > > 
> > > Hope my decoding of the key is proper, I have reused pretty_binary_string() of Bluestore after removing 1st 2 bytes of the key which is prefix and a '0'.
> > > 
> > > Any suggestion on the next step of root causing this db assert if log rename is not enough hint ?
> > > 
> > > BTW, I ran this time with bluefs_compact_log_sync = true and without commenting the inode number asserts. I didn't hit those asserts as well as no corruption  so far. Seems like bug of async compaction. Will try to reproduce with verbose log that one later.
> > > 
> > > Thanks & Regards
> > > Somnath
> > > 
> > > -----Original Message-----
> > > From: Somnath Roy
> > > Sent: Tuesday, August 23, 2016 7:46 AM
> > > To: 'Sage Weil'
> > > Cc: Mark Nelson; ceph-devel
> > > Subject: RE: Bluestore assert
> > > 
> > > I was running my tests for 2 hours and it happened within that time.
> > > I will try to reproduce with 1/20.
> > > 
> > > Thanks & Regards
> > > Somnath
> > > 
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sweil@redhat.com]
> > > Sent: Tuesday, August 23, 2016 6:46 AM
> > > To: Somnath Roy
> > > Cc: Mark Nelson; ceph-devel
> > > Subject: RE: Bluestore assert
> > > 
> > > On Mon, 22 Aug 2016, Somnath Roy wrote:
> > > > Sage,
> > > > I think there are some bug introduced recently in the BlueFS and I 
> > > > am getting the corruption like this which I was not facing earlier.
> > > 
> > > My guess is the async bluefs compaction.  You can set 'bluefs compact log sync = true' to disable it.
> > > 
> > > Any idea how long do you have to run to reproduce?  I'd love to see a bluefs log leading up to it.  If it eats too much disk space, you could do debug bluefs = 1/20 so that it only dumps recent history on crash.
> > > 
> > > Thanks!
> > > sage
> > > 
> > > > 
> > > >    -5> 2016-08-22 15:55:21.248558 7fb68f7ff700  4 rocksdb: EVENT_LOG_v1 {"time_micros": 1471906521248538, "job": 3, "event": "compaction_started", "files_L0": [2115, 2102, 2087, 2069, 2046], "files_L1": [], "files_L2": [], "files_L3": [], "files_L4": [], "files_L5": [], "files_L6": [1998, 2007, 2013, 2019, 2026, 2032, 2039, 2043, 2052, 2060], "score": 1.5, "input_data_size": 1648188401}
> > > >     -4> 2016-08-22 15:55:27.209944 7fb6ba94d8c0  0 <cls> cls/hello/cls_hello.cc:305: loading cls_hello
> > > >     -3> 2016-08-22 15:55:27.213612 7fb6ba94d8c0  0 <cls> cls/cephfs/cls_cephfs.cc:202: loading cephfs_size_scan
> > > >     -2> 2016-08-22 15:55:27.213627 7fb6ba94d8c0  0 _get_class not permitted to load kvs
> > > >     -1> 2016-08-22 15:55:27.214620 7fb6ba94d8c0 -1 osd.0 0 failed to load OSD map for epoch 321, got 0 bytes
> > > >      0> 2016-08-22 15:55:27.216111 7fb6ba94d8c0 -1 osd/OSD.h: In 
> > > > function 'OSDMapRef OSDService::get_map(epoch_t)' thread
> > > > 7fb6ba94d8c0 time 2016-08-22 15:55:27.214638
> > > > osd/OSD.h: 999: FAILED assert(ret)
> > > > 
> > > >  ceph version 11.0.0-1688-g6f48ee6
> > > > (6f48ee6bc5c85f44d7ca4c984f9bef1339c2bea4)
> > > >  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > > > const*)+0x80) [0x5617f2a99e80]
> > > >  2: (OSDService::get_map(unsigned int)+0x5d) [0x5617f2395fdd]
> > > >  3: (OSD::init()+0x1f7e) [0x5617f233d3ce]
> > > >  4: (main()+0x2fe0) [0x5617f229d1f0]
> > > >  5: (__libc_start_main()+0xf0) [0x7fb6b7196830]
> > > >  6: (_start()+0x29) [0x5617f22eb909]
> > > > 
> > > > OSDs are not coming up (after a restart) and eventually I had to recreate the cluster.
> > > > 
> > > > Thanks & Regards
> > > > Somnath
> > > > 
> > > > -----Original Message-----
> > > > From: Somnath Roy
> > > > Sent: Monday, August 22, 2016 3:01 PM
> > > > To: 'Sage Weil'
> > > > Cc: Mark Nelson; ceph-devel
> > > > Subject: RE: Bluestore assert
> > > > 
> > > > "compaction_style=kCompactionStyleUniversal"  in the bluestore_rocksdb_options .
> > > > Here is the option I am using..
> > > > 
> > > >         bluestore_rocksdb_options = "max_write_buffer_number=16,min_write_buffer_number_to_merge=2,recycle_log_file_num=16,compaction_threads=32,flusher_threads=8,max_background_compactions=32,max_background_flushes=8,max_bytes_for_level_base=5368709120,write_buffer_size=83886080,level0_file_num_compaction_trigger=4,level0_slowdown_writes_trigger=400,level0_stop_writes_trigger=800,stats_dump_period_sec=10,compaction_style=kCompactionStyleUniversal"
> > > > 
> > > > Here is another one after 4 hours of 4K RW :-)...Sorry to bombard you with all these , I am adding more log for the next time if I hit it..
> > > > 
> > > > 
> > > >      0> 2016-08-22 17:37:24.730817 7f8e7afff700 -1
> > > > os/bluestore/BlueFS.cc: In function 'int 
> > > > BlueFS::_read_random(BlueFS::FileReader*, uint64_t, size_t, char*)'
> > > > thread 7f8e7afff700 time 2016-08-22 17:37:24.722706
> > > > os/bluestore/BlueFS.cc: 845: FAILED assert(r == 0)
> > > > 
> > > >  ceph version 11.0.0-1688-g3fcc89c
> > > > (3fcc89c7ab4c92e6c4564e29f4e1a663db36acc0)
> > > >  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > > > const*)+0x80) [0x5581ed453cb0]
> > > >  2: (BlueFS::_read_random(BlueFS::FileReader*, unsigned long, 
> > > > unsigned long, char*)+0x836) [0x5581ed11c1b6]
> > > >  3: (BlueRocksRandomAccessFile::Read(unsigned long, unsigned long, 
> > > > rocksdb::Slice*, char*) const+0x20) [0x5581ed13f840]
> > > >  4: (rocksdb::RandomAccessFileReader::Read(unsigned long, unsigned 
> > > > long, rocksdb::Slice*, char*) const+0x83f) [0x5581ed2c6f4f]
> > > >  5: (rocksdb::ReadBlockContents(rocksdb::RandomAccessFileReader*,
> > > > rocksdb::Footer const&, rocksdb::ReadOptions const&, 
> > > > rocksdb::BlockHandle const&, rocksdb::BlockContents*, 
> > > > rocksdb::Env*, bool, rocksdb::Slice const&, 
> > > > rocksdb::PersistentCacheOptions const&,
> > > > rocksdb::Logger*)+0x358) [0x5581ed291c18]
> > > >  6: (()+0x94fd54) [0x5581ed282d54]
> > > >  7: 
> > > > (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb::BlockBase
> > > > dT ab le::Rep*, rocksdb::ReadOptions const&, rocksdb::Slice 
> > > > const&,
> > > > rocksdb::BlockIter*)+0x60c) [0x5581ed284b3c]
> > > >  8: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions const&, 
> > > > rocksdb::Slice const&, rocksdb::GetContext*, bool)+0x508) 
> > > > [0x5581ed28ba68]
> > > >  9: (rocksdb::TableCache::Get(rocksdb::ReadOptions const&, 
> > > > rocksdb::InternalKeyComparator const&, rocksdb::FileDescriptor 
> > > > const&, rocksdb::Slice const&, rocksdb::GetContext*, 
> > > > rocksdb::HistogramImpl*, bool, int)+0x158) [0x5581ed252118]
> > > >  10: (rocksdb::Version::Get(rocksdb::ReadOptions const&, 
> > > > rocksdb::LookupKey const&, std::__cxx11::basic_string<char, 
> > > > std::char_traits<char>, std::allocator<char> >*, rocksdb::Status*, 
> > > > rocksdb::MergeContext*, bool*, bool*, unsigned long*)+0x4f8) 
> > > > [0x5581ed25c458]
> > > >  11: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions const&, 
> > > > rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&, 
> > > > std::__cxx11::basic_string<char, std::char_traits<char>, 
> > > > std::allocator<char> >*, bool*)+0x5fa) [0x5581ed1f3f7a]
> > > >  12: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&, 
> > > > rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&, 
> > > > std::__cxx11::basic_string<char, std::char_traits<char>, 
> > > > std::allocator<char> >*)+0x22) [0x5581ed1f4182]
> > > >  13: (RocksDBStore::get(std::__cxx11::basic_string<char,
> > > > std::char_traits<char>, std::allocator<char> > const&, 
> > > > std::__cxx11::basic_string<char, std::char_traits<char>, 
> > > > std::allocator<char> > const&, ceph::buffer::list*)+0x157) 
> > > > [0x5581ed1d21d7]
> > > >  14: (BlueStore::Collection::get_onode(ghobject_t const&,
> > > > bool)+0x55b) [0x5581ed02802b]
> > > >  15: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
> > > > ObjectStore::Transaction*)+0x1e49) [0x5581ed0318a9]
> > > >  16: (BlueStore::queue_transactions(ObjectStore::Sequencer*,
> > > > std::vector<ObjectStore::Transaction,
> > > > std::allocator<ObjectStore::Transaction> >&, 
> > > > std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x362) 
> > > > [0x5581ed032bc2]
> > > >  17: 
> > > > (ReplicatedPG::queue_transactions(std::vector<ObjectStore::Transac
> > > > ti on , std::allocator<ObjectStore::Transaction> >&,
> > > > std::shared_ptr<OpRequest>)+0x81) [0x5581ecea5e51]
> > > >  18: 
> > > > (ReplicatedBackend::sub_op_modify(std::shared_ptr<OpRequest>)+0xd3
> > > > 9)
> > > > [0x5581ecef89e9]
> > > >  19: 
> > > > (ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>)+0x2
> > > > fb
> > > > )
> > > > [0x5581ecefeb4b]
> > > >  20: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
> > > > ThreadPool::TPHandle&)+0xbd) [0x5581ece4c63d]
> > > >  21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
> > > > std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x409) 
> > > > [0x5581eccdd2e9]
> > > >  22: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>
> > > > const&)+0x52) [0x5581eccdd542]
> > > >  23: (OSD::ShardedOpWQ::_process(unsigned int,
> > > > ceph::heartbeat_handle_d*)+0x73f) [0x5581eccfd30f]
> > > >  24: (ShardedThreadPool::shardedthreadpool_worker(unsigned
> > > > int)+0x89f) [0x5581ed440b2f]
> > > >  25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10)
> > > > [0x5581ed4441f0]
> > > >  26: (Thread::entry_wrapper()+0x75) [0x5581ed4335c5]
> > > >  27: (()+0x76fa) [0x7f8ed9e4e6fa]
> > > >  28: (clone()+0x6d) [0x7f8ed7caeb5d]
> > > >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> > > > 
> > > > 
> > > > Thanks & Regards
> > > > Somnath
> > > > 
> > > > -----Original Message-----
> > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > Sent: Monday, August 22, 2016 2:57 PM
> > > > To: Somnath Roy
> > > > Cc: Mark Nelson; ceph-devel
> > > > Subject: RE: Bluestore assert
> > > > 
> > > > On Mon, 22 Aug 2016, Somnath Roy wrote:
> > > > > FYI, I was running rocksdb by enabling universal style 
> > > > > compaction during this time.
> > > > 
> > > > How are you selecting universal compaction?
> > > > 
> > > > sage
> > > > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > > > in the body of a message to majordomo@vger.kernel.org More 
> > > > majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > 
> > > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > > info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> 
