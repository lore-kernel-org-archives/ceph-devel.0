From: Sage Weil <sweil@redhat.com>
Subject: RE: Bluestore assert
Date: Fri, 2 Sep 2016 20:24:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609022024110.31624@piezo.us.to>
References: <BL2PR02MB2115443F5ACA3459E2CEBFBAF41D0@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608242042510.25681@piezo.us.to> <CY1PR02MB21235A07222322180C0E2BDFF4EA0@CY1PR02MB2123.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608242132460.25681@piezo.us.to>
    <BL2PR02MB21154C4E291C96D597444649F4E00@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608311318350.19032@piezo.us.to>  <BL2PR02MB21153A76E39772A143A638EEF4E50@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1609021627100.31624@piezo.us.to>
 <BL2PR02MB2115D290C0F978DB7B2D1DD4F4E50@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1609021749210.31624@piezo.us.to> <BL2PR02MB2115DE43126DFD3E07D18684F4E50@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1609021925520.31624@piezo.us.to>
 <BL2PR02MB211595930224CC5D83806B9BF4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbcIBUZC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Sep 2016 16:25:02 -0400
In-Reply-To: <BL2PR02MB211595930224CC5D83806B9BF4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 2 Sep 2016, Somnath Roy wrote:
> Sage,
> I am running with big runway values now (min 100 MB, max 400MB) and will keep you posted on this.
> One point, if I give this big runway values, the allocation will be very frequent (and probably unnecessarily for most of the cases) , no harm with that ?

I think it'll actually be less frequent, since it allocates 
bluefs_max_log_runway at a time.  Well, assuming you set that tunable as 
high well!

sage

> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com] 
> Sent: Friday, September 02, 2016 12:27 PM
> To: Somnath Roy
> Cc: Mark Nelson; ceph-devel
> Subject: RE: Bluestore assert
> 
> On Fri, 2 Sep 2016, Somnath Roy wrote:
> > Sage,
> > It is probably the universal compaction that is generating bigger files, other than that I don't see the following tuning will be generating large files.
> > I will try some universal compaction tuning related to file size and confirm.
> > Yeah, big bluefs_min_log_runway value will probably shield the assert for now , but, I am afraid since we don't have control to the file size , we can't possibly sure about the value we should be giving with bluefs_min_log_runway for assert not to hit in future long runs.
> > Can't we do like this ?
> > 
> > //Basically, checking the length of the log as well if (runway < 
> > g_conf->bluefs_min_log_runway) || (runway < log_writer 
> > ->buffer.length() {  //allocate }
> 
> Oh, I see what you mean.  Yeah, I'll add that in--certainly doesn't hurt.
> 
> And I think just configuring a long runway won't hurt either (e.g., 100MB).
> 
> That's probably enough to be safe, but once we fix the flush thing I mentioned that will make this go away.
> 
> s
> 
> > 
> > Thanks & Regards
> > Somnath
> > 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Friday, September 02, 2016 10:57 AM
> > To: Somnath Roy
> > Cc: Mark Nelson; ceph-devel
> > Subject: RE: Bluestore assert
> > 
> > On Fri, 2 Sep 2016, Somnath Roy wrote:
> > > Here is my rocksdb option :
> > > 
> > >         bluestore_rocksdb_options = "max_write_buffer_number=16,min_write_buffer_number_to_merge=2,recycle_log_file_num=16,compaction_threads=32,flusher_threads=8,max_background_compactions=32,max_background_flushes=8,max_bytes_for_level_base=5368709120,write_buffer_size=83886080,level0_file_num_compaction_trigger=4,level0_slowdown_writes_trigger=400,level0_stop_writes_trigger=800,stats_dump_period_sec=10,compaction_style=kCompactionStyleUniversal"
> > > 
> > > one discrepancy I can see here on max_bytes_for_level_base , it 
> > > should be same as level 0 size. Initially, I had bigger 
> > > min_write_buffer_number_to_merge and that's how I calculated. Now, 
> > > level 0 size is the following
> > > 
> > > write_buffer_size * min_write_buffer_number_to_merge * 
> > > level0_file_num_compaction_trigger = 80MB * 2 * 4 = ~640MB
> > > 
> > > I should adjust max_bytes_for_level_base to the similar value probably.
> > > 
> > > Please find the level 10 log here. The log I captured during replay (crashed again) after it crashed originally because of the same reason.
> > > 
> > > https://drive.google.com/file/d/0B7W-S0z_ymMJSnA3R2dyellYZ0U/view?us
> > > p=
> > > sharing
> > > 
> > > Thanks for the explanation , I got it now why it is trying to flush 
> > > inode 1.
> > > 
> > > But, shouldn't we check the length as well during runway check 
> > > rather than just relying on bluefs_min_log_runway only.
> > 
> > That's what this does:
> > 
> >   uint64_t runway = log_writer->file->fnode.get_allocated() - 
> > log_writer->pos;
> > 
> > Anyway, I think I see what's going on.  There are a ton of _fsync and _flush_range calls that have to flush the fnode, and the fnode is pretty big (maybe 5k?) because it has so many extents (your tunables are generating really big files).
> > 
> > I think this is just a matter of the runway configurable being too small for your configuration.  Try bumping bluefs_min_log_runway by 10x.
> > 
> > Well, actually, we could improve this a bit.  Right now rocksdb is calling lots of flush on a bit sst, and a final fsync at the end.  Bluefs is logging the updated fnode every time the flush changes the file size, and then only writing it to disk when the final fsync happens.  Instead, it could/should put the dirty fnode on a list and only at log flush time flush append the latest fnodes to the log and write it out.
> > 
> > I'll add it to the trello board.  I think it's not that big a deal.. 
> > except when you have really big files.
> > 
> > sage
> > 
> > 
> >  >
> > > Thanks & Regards
> > > Somnath
> > > 
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sweil@redhat.com]
> > > Sent: Friday, September 02, 2016 9:35 AM
> > > To: Somnath Roy
> > > Cc: Mark Nelson; ceph-devel
> > > Subject: RE: Bluestore assert
> > > 
> > > 
> > > 
> > > On Fri, 2 Sep 2016, Somnath Roy wrote:
> > > 
> > > > Sage,
> > > > Tried to do some analysis on the inode assert, following looks suspicious.
> > > > 
> > > >    -10> 2016-08-31 17:55:56.921075 7faf14fff700 10 bluefs _fsync 0x7faf12075140 file(ino 693 size 0x19c2c265 mtime 2016-08-31 17:55:56.919038 bdev 1 extents [1:0x6e500000+100000,1:0x6e700000+100000,1:0x6ea00000+200000,1:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000+200000,1:0x6f600000+200000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff00000+100000,1:0x70100000+200000,1:0x70400000+200000,1:0x70700000+200000,1:0x70a00000+100000,1:0x70c00000+200000,1:0x70f00000+100000,1:0x71100000+200000,1:0x71400000+200000,1:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000+100000,1:0x71e00000+100000,1:0x72000000+100000,1:0x72200000+200000,1:0x72500000+200000,1:0x72800000+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72f00000+100000,1:0x73100000+200000,1:0x73400000+100000,1:0x73600000+2
 00000,1:0x73900000+200000,1:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000+200000,1:0x74600000+200000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f00000+100000,1:0x75100000+100000,1:0!
 x7!
>  53!
> >  00!
> > >  000+100000,1:0x75600000+100000,1:0x75800000+100000,1:0x75a00000+200000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x76100000+100000,1:0x76400000+200000,1:0x76700000+200000,1:0x76a00000+300000,1:0x76e00000+200000,1:0x77100000+100000,1:0x77300000+100000,1:0x77500000+100000,1:0x77700000+300000,1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000+100000,1:0x78300000+200000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c00000+100000,1:0x78e00000+100000,1:0x79000000+100000,1:0x79200000+100000,1:0x79400000+200000,1:0x79700000+100000,1:0x79900000+200000,1:0x79c00000+200000,1:0x79f00000+100000,1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000+100000,1:0x7a900000+200000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b000000+100000,1:0x7b200000+200000,1:0x7b500000+100000,1:0x7b800000+200000,1:
 0x7bb00000+100000,1:0x7bd00000+200000,1:0x7c000000+100000,1:0x7c200000+200000,1:0x7c500000+100000,1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+100000,1:0x7ce00000+100000,1:0x7d00000!
 0+!
>  10!
> >  00!
> > >  
> > > 00,1:0x7d200000+100000,1:0x7d400000+100000,1:0x7d600000+100000,1:0x7
> > > d8
> > > 00000+10e00000])
> > > >     -9> 2016-08-31 17:55:56.921117 7faf14fff700 10 bluefs _flush 0x7faf12075140 no dirty data on file(ino 693 size 0x19c2c265 mtime 2016-08-31 17:55:56.919038 bdev 1 extents [1:0x6e500000+100000,1:0x6e700000+100000,1:0x6ea00000+200000,1:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000+200000,1:0x6f600000+200000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff00000+100000,1:0x70100000+200000,1:0x70400000+200000,1:0x70700000+200000,1:0x70a00000+100000,1:0x70c00000+200000,1:0x70f00000+100000,1:0x71100000+200000,1:0x71400000+200000,1:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000+100000,1:0x71e00000+100000,1:0x72000000+100000,1:0x72200000+200000,1:0x72500000+200000,1:0x72800000+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72f00000+100000,1:0x73100000+200000,1:0x73400000+1000
 00,1:0x73600000+200000,1:0x73900000+200000,1:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000+200000,1:0x74600000+200000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f00000+100000,1:0x75!
 10!
>  00!
> >  00!
> > >  +100000,1:0x75300000+100000,1:0x75600000+100000,1:0x75800000+100000,1:0x75a00000+200000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x76100000+100000,1:0x76400000+200000,1:0x76700000+200000,1:0x76a00000+300000,1:0x76e00000+200000,1:0x77100000+100000,1:0x77300000+100000,1:0x77500000+100000,1:0x77700000+300000,1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000+100000,1:0x78300000+200000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c00000+100000,1:0x78e00000+100000,1:0x79000000+100000,1:0x79200000+100000,1:0x79400000+200000,1:0x79700000+100000,1:0x79900000+200000,1:0x79c00000+200000,1:0x79f00000+100000,1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000+100000,1:0x7a900000+200000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b000000+100000,1:0x7b200000+200000,1:0x7b500000+100000,1:0x7
 b800000+200000,1:0x7bb00000+100000,1:0x7bd00000+200000,1:0x7c000000+100000,1:0x7c200000+200000,1:0x7c500000+100000,1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+100000,1:0x7ce00000+1!
 00!
>  00!
> >  0,!
> > >  
> > > 1:0x7d000000+100000,1:0x7d200000+100000,1:0x7d400000+100000,1:0x7d60
> > > 00
> > > 00+100000,1:0x7d800000+10e00000])
> > > >     -8> 2016-08-31 17:55:56.921137 7faf14fff700 10 bluefs wait_for_aio 0x7faf12075140
> > > >     -7> 2016-08-31 17:55:56.931541 7faf14fff700 10 bluefs wait_for_aio 0x7faf12075140 done in 0.010402
> > > >     -6> 2016-08-31 17:55:56.931551 7faf14fff700 20 bluefs _fsync file metadata was dirty (31278) on file(ino 693 size 0x19c2c265 mtime 2016-08-31 17:55:56.919038 bdev 1 extents [1:0x6e500000+100000,1:0x6e700000+100000,1:0x6ea00000+200000,1:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000+200000,1:0x6f600000+200000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff00000+100000,1:0x70100000+200000,1:0x70400000+200000,1:0x70700000+200000,1:0x70a00000+100000,1:0x70c00000+200000,1:0x70f00000+100000,1:0x71100000+200000,1:0x71400000+200000,1:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000+100000,1:0x71e00000+100000,1:0x72000000+100000,1:0x72200000+200000,1:0x72500000+200000,1:0x72800000+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72f00000+100000,1:0x73100000+200000,1:0x73400000+1
 00000,1:0x73600000+200000,1:0x73900000+200000,1:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000+200000,1:0x74600000+200000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f00000+100000,1:0!
 x7!
>  51!
> >  00!
> > >  000+100000,1:0x75300000+100000,1:0x75600000+100000,1:0x75800000+100000,1:0x75a00000+200000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x76100000+100000,1:0x76400000+200000,1:0x76700000+200000,1:0x76a00000+300000,1:0x76e00000+200000,1:0x77100000+100000,1:0x77300000+100000,1:0x77500000+100000,1:0x77700000+300000,1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000+100000,1:0x78300000+200000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c00000+100000,1:0x78e00000+100000,1:0x79000000+100000,1:0x79200000+100000,1:0x79400000+200000,1:0x79700000+100000,1:0x79900000+200000,1:0x79c00000+200000,1:0x79f00000+100000,1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000+100000,1:0x7a900000+200000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b000000+100000,1:0x7b200000+200000,1:0x7b500000+100000,1:
 0x7b800000+200000,1:0x7bb00000+100000,1:0x7bd00000+200000,1:0x7c000000+100000,1:0x7c200000+200000,1:0x7c500000+100000,1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+100000,1:0x7ce0000!
 0+!
>  10!
> >  00!
> > >  
> > > 00,1:0x7d000000+100000,1:0x7d200000+100000,1:0x7d400000+100000,1:0x7
> > > d6
> > > 00000+100000,1:0x7d800000+10e00000]), flushing log
> > > > 
> > > > The above looks good, it is about to call _flush_and_sync_log() after this.
> > > 
> > > Yes, although this file is huge (0x19c2c265 = 432194149 ~ 400MB)... What rocksdb options did you pass in?  I'm guessing this is a log file, but we generally want those smallish (maybe 16MB - 64MB, so that L0 SST generation isn't too slow).
> > > 
> > > >     -5> 2016-08-31 17:55:56.931588 7faf14fff700 10 bluefs _flush_and_sync_log txn(seq 31278 len 0x50e146 crc 0x58a6b9ab)
> > > >     -4> 2016-08-31 17:55:56.933951 7faf14fff700 10 bluefs _pad_bl padding with 0xe94 zeros
> > > >     -3> 2016-08-31 17:55:56.934079 7faf14fff700 20 bluefs flush_bdev
> > > >     -2> 2016-08-31 17:55:56.934257 7faf14fff700 10 bluefs _flush 0x7faf2e824140 0xce9000~50f000 to file(ino 1 size 0xce9000 mtime 0.000000 bdev 0 extents [0:0xba00000+500000,0:0xfd00000+c00000])
> > > >     -1> 2016-08-31 17:55:56.934274 7faf14fff700 10 bluefs _flush_range 0x7faf2e824140 pos 0xce9000 0xce9000~50f000 to file(ino 1 size 0xce9000 mtime 0.000000 bdev 0 extents [0:0xba00000+500000,0:0xfd00000+c00000])
> > > >      0> 2016-08-31 17:55:56.939745 7faf14fff700 -1
> > > > os/bluestore/BlueFS.cc: In function 'int 
> > > > BlueFS::_flush_range(BlueFS::FileWriter*, uint64_t, uint64_t)'
> > > > thread
> > > > 7faf14fff700 time 2016-08-31 17:55:56.934282
> > > > os/bluestore/BlueFS.cc: 1390: FAILED assert(h->file->fnode.ino != 
> > > > 1)
> > > > 
> > > >  ceph version 11.0.0-1946-g9a5cfe2
> > > > (9a5cfe2e8e8c79b976c34e593993d74b58fce885)
> > > >  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > > > const*)+0x80) [0x56073c27c7d0]
> > > >  2: (BlueFS::_flush_range(BlueFS::FileWriter*, unsigned long, 
> > > > unsigned
> > > > long)+0x1d69) [0x56073bf4e109]
> > > >  3: (BlueFS::_flush(BlueFS::FileWriter*, bool)+0xa7) 
> > > > [0x56073bf4e2d7]
> > > >  4: (BlueFS::_flush_and_sync_log(std::unique_lock<std::mutex>&,
> > > > unsigned long, unsigned long)+0x443) [0x56073bf4fe13]
> > > >  5: (BlueFS::_fsync(BlueFS::FileWriter*,
> > > > std::unique_lock<std::mutex>&)+0x35b) [0x56073bf5140b]
> > > >  6: (BlueRocksWritableFile::Sync()+0x62) [0x56073bf68be2]
> > > >  7: (rocksdb::WritableFileWriter::SyncInternal(bool)+0x2d1)
> > > > [0x56073c0f24b1]
> > > >  8: (rocksdb::WritableFileWriter::Sync(bool)+0xf0) 
> > > > [0x56073c0f3960]
> > > >  9: 
> > > > (rocksdb::CompactionJob::FinishCompactionOutputFile(rocksdb::Statu
> > > > s const&, rocksdb::CompactionJob::SubcompactionState*)+0x4e6)
> > > > [0x56073c1354c6]
> > > >  10: 
> > > > (rocksdb::CompactionJob::ProcessKeyValueCompaction(rocksdb::Compac
> > > > ti
> > > > on
> > > > Job::SubcompactionState*)+0x14ea) [0x56073c137c8a]
> > > >  11: (rocksdb::CompactionJob::Run()+0x479) [0x56073c138c09]
> > > >  12: (rocksdb::DBImpl::BackgroundCompaction(bool*,
> > > > rocksdb::JobContext*, rocksdb::LogBuffer*, void*)+0x9c0) 
> > > > [0x56073c0275d0]
> > > >  13: (rocksdb::DBImpl::BackgroundCallCompaction(void*)+0xbf)
> > > > [0x56073c03443f]
> > > >  14: (rocksdb::ThreadPool::BGThread(unsigned long)+0x1d9) 
> > > > [0x56073c0eb039]
> > > >  15: (()+0x9900d3) [0x56073c0eb0d3]
> > > >  16: (()+0x76fa) [0x7faf3d1106fa]
> > > >  17: (clone()+0x6d) [0x7faf3af70b5d]
> > > > 
> > > > 
> > > > Now, as you can see it is calling _flush() with inode 1 , why ? is this expected ?
> > > 
> > > Yes.  The metadata for the log file is dirty (the file size changed), so bluefs is flushing it's journal (ino 1) to update the fnode.
> > > 
> > > But this is very concerning:
> > > 
> > > >     -2> 2016-08-31 17:55:56.934257 7faf14fff700 10 bluefs _flush
> > > > 0x7faf2e824140 0xce9000~50f000 to file(ino 1 size 0xce9000 mtime
> > > > 0.000000 bdev 0 extents [0:0xba00000+500000,0:0xfd00000+c00000])
> > > 
> > > 0xce9000~50f000 is a ~5 MB write.  Why would we ever write that much to the bluefs metadata journal at once?  That's why it's blowign the runway.  
> > > We have ~17MB allocated (0:0xba00000+500000,0:0xfd00000+c00000), we're at offset ~13MB, and we're writing ~5MB.
> > > 
> > > > Question :
> > > > ------------
> > > > 
> > > > 1. Why we are using the existing log_write to do a runway check ?
> > > > 
> > > > https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueFS.c
> > > > c#
> > > > L1
> > > > 280
> > > > 
> > > > Shouldn't the log_writer needs to be reinitialed with the FileWriter rocksdb sent with sync call ?
> > > 
> > > It's the bluefs journal writer.. that's the runway we're worried about.
> > > 
> > > > 2. The runway check is not considering the request length , so, 
> > > > why it is not expecting to allocate here 
> > > > (https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueFS.
> > > > cc
> > > > #L
> > > > 1388)
> > > > 
> > > > If the snippet is not sufficient, let me know if you want me to upload the level 10 log or need 20/20 log to proceed further.
> > > 
> > > The level 10 log is probably enough...
> > > 
> > > Thanks!
> > > sage
> > > 
> > > > 
> > > > Thanks & Regards
> > > > Somnath
> > > > 
> > > > 
> > > > -----Original Message-----
> > > > From: Somnath Roy
> > > > Sent: Thursday, September 01, 2016 3:59 PM
> > > > To: 'Sage Weil'
> > > > Cc: Mark Nelson; ceph-devel
> > > > Subject: RE: Bluestore assert
> > > > 
> > > > Sage,
> > > > Created the following pull request on rocksdb repo, please take a look.
> > > > 
> > > > https://github.com/facebook/rocksdb/pull/1313
> > > > 
> > > > The fix is working fine for me.
> > > > 
> > > > Thanks & Regards
> > > > Somnath
> > > > 
> > > > -----Original Message-----
> > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > Sent: Wednesday, August 31, 2016 6:20 AM
> > > > To: Somnath Roy
> > > > Cc: Mark Nelson; ceph-devel
> > > > Subject: RE: Bluestore assert
> > > > 
> > > > On Tue, 30 Aug 2016, Somnath Roy wrote:
> > > > > Sage,
> > > > > I did some debugging on the rocksdb bug., here is my findings.
> > > > > 
> > > > > 1. The log file number is added to log_recycle_files and *not* in log_delete_files from the following if loop, which is expected.
> > > > > 
> > > > > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698
> > > > > f4
> > > > > 60
> > > > > 60
> > > > > 9bf7cea4b63/db/db_impl.cc#L854
> > > > > 
> > > > > 2. But, it is there in the candidate list in the following loop.
> > > > > 
> > > > > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698
> > > > > f4
> > > > > 60
> > > > > 60
> > > > > 9bf7cea4b63/db/db_impl.cc#L1000
> > > > > 
> > > > > 
> > > > > 3. This means it is added in full_scan_candidate_files from the 
> > > > > following  from a full scan (?)
> > > > > 
> > > > > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698
> > > > > f4
> > > > > 60
> > > > > 60
> > > > > 9bf7cea4b63/db/db_impl.cc#L834
> > > > > 
> > > > > Added some log entries to verify , need to wait 6 hours :-(
> > > > > 
> > > > > 4. Probably, #3 is not unusual , but the check in the following seems not sufficient to keep the file.
> > > > > 
> > > > > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698
> > > > > f4
> > > > > 60
> > > > > 60
> > > > > 9bf7cea4b63/db/db_impl.cc#L1013
> > > > > 
> > > > > Again, added some log to see the state.log_number during that time. BTW, I have seen the following check probably noop as state.prev_log_number is always coming 0.
> > > > > 
> > > > > (number == state.prev_log_number)
> > > > > 
> > > > > 5. So, the quick solution I am thinking is to put a check to see if the log is in recycle list and avoid deleting from the above part (?).
> > > > 
> > > > That seems reasonable.  I suggest coding this up and submitting a PR to github.com/facebook/rocksdb, and ask in the comment if there is a better solution.
> > > > 
> > > > Probably the recycle list should be turned into a set so that the check is O(log n)...
> > > > 
> > > > Thanks!
> > > > sage
> > > > 
> > > > 
> > > > > 
> > > > > Let me know what you think.
> > > > > 
> > > > > Thanks & Regards
> > > > > Somnath
> > > > > -----Original Message-----
> > > > > From: Somnath Roy
> > > > > Sent: Sunday, August 28, 2016 7:37 AM
> > > > > To: 'Sage Weil'
> > > > > Cc: 'Mark Nelson'; 'ceph-devel'
> > > > > Subject: RE: Bluestore assert
> > > > > 
> > > > > Sage,
> > > > > Some updates on this.
> > > > > 
> > > > > 1. The issue is reproduced with the latest rocksdb master as well.
> > > > > 
> > > > > 2. The issue is *not happening* if I run disabling rocksdb log recycling. This proves our root cause is right.
> > > > > 
> > > > > 3. Running some more performance tests by disabling log recycling , but, initial impression is, it is introducing spikes and output is not as stable as enabling log recycling.
> > > > > 
> > > > > 4. Created a rocksdb issue for this
> > > > > (https://github.com/facebook/rocksdb/issues/1303)
> > > > > 
> > > > > Thanks & Regards
> > > > > Somnath
> > > > > 
> > > > > 
> > > > > -----Original Message-----
> > > > > From: Somnath Roy
> > > > > Sent: Thursday, August 25, 2016 2:35 PM
> > > > > To: 'Sage Weil'
> > > > > Cc: 'Mark Nelson'; 'ceph-devel'
> > > > > Subject: RE: Bluestore assert
> > > > > 
> > > > > Sage,
> > > > > Hope you are able to download the log I shared via google doc.
> > > > > It seems the bug is around this portion.
> > > > > 
> > > > > 2016-08-25 00:44:03.348710 7f7c117ff700  4 rocksdb: adding log 
> > > > > 254 to recycle list
> > > > > 
> > > > > 2016-08-25 00:44:03.348722 7f7c117ff700  4 rocksdb: adding log 
> > > > > 256 to recycle list
> > > > > 
> > > > > 2016-08-25 00:44:03.348725 7f7c117ff700  4 rocksdb: (Original 
> > > > > Log Time
> > > > > 2016/08/25-00:44:03.347467) [default] Level-0 commit table #258 
> > > > > started
> > > > > 2016-08-25 00:44:03.348727 7f7c117ff700  4 rocksdb: (Original 
> > > > > Log Time
> > > > > 2016/08/25-00:44:03.348225) [default] Level-0 commit table #258: 
> > > > > memtable #1 done
> > > > > 2016-08-25 00:44:03.348729 7f7c117ff700  4 rocksdb: (Original 
> > > > > Log Time
> > > > > 2016/08/25-00:44:03.348227) [default] Level-0 commit table #258: 
> > > > > memtable #2 done
> > > > > 2016-08-25 00:44:03.348730 7f7c117ff700  4 rocksdb: (Original 
> > > > > Log Time
> > > > > 2016/08/25-00:44:03.348239) EVENT_LOG_v1 {"time_micros": 
> > > > > 1472111043348233, "job": 88, "event": "flush_finished", "lsm_state": 
> > > > > [3, 4, 0, 0, 0, 0, 0], "immutable_memtables": 0}
> > > > > 2016-08-25 00:44:03.348735 7f7c117ff700  4 rocksdb: (Original 
> > > > > Log Time
> > > > > 2016/08/25-00:44:03.348297) [default] Level summary: base level 
> > > > > 1 max bytes base 5368709120 files[3 4 0 0 0 0 0] max score 0.75
> > > > > 
> > > > > 2016-08-25 00:44:03.348751 7f7c117ff700  4 rocksdb: [JOB 88] Try to delete WAL files size 131512372, prev total WAL file size 131834601, number of live WAL files 3.
> > > > > 
> > > > > 2016-08-25 00:44:03.348761 7f7c117ff700 10 bluefs unlink 
> > > > > db.wal/000256.log
> > > > > 2016-08-25 00:44:03.348766 7f7c117ff700 20 bluefs _drop_link had 
> > > > > refs
> > > > > 1 on file(ino 19 size 0x3f3ddd9 mtime 2016-08-25 00:41:26.298423 
> > > > > bdev
> > > > > 0 extents
> > > > > [0:0xc500000+200000,0:0xcb00000+800000,0:0xd700000+700000,0:0xe2
> > > > > 00
> > > > > 00
> > > > > 0+
> > > > > 800000,0:0xee00000+800000,0:0xfa00000+800000,0:0x10600000+700000
> > > > > ,0
> > > > > :0
> > > > > x1
> > > > > 1100000+700000,0:0x11c00000+800000,0:0x12800000+100000])
> > > > > 2016-08-25 00:44:03.348775 7f7c117ff700 20 bluefs _drop_link 
> > > > > destroying file(ino 19 size 0x3f3ddd9 mtime 2016-08-25
> > > > > 00:41:26.298423 bdev 0 extents
> > > > > [0:0xc500000+200000,0:0xcb00000+800000,0:0xd700000+700000,0:0xe2
> > > > > 00
> > > > > 00
> > > > > 0+
> > > > > 800000,0:0xee00000+800000,0:0xfa00000+800000,0:0x10600000+700000
> > > > > ,0
> > > > > :0
> > > > > x1
> > > > > 1100000+700000,0:0x11c00000+800000,0:0x12800000+100000])
> > > > > 2016-08-25 00:44:03.348794 7f7c117ff700 10 bluefs unlink 
> > > > > db.wal/000254.log
> > > > > 2016-08-25 00:44:03.348796 7f7c117ff700 20 bluefs _drop_link had 
> > > > > refs
> > > > > 1 on file(ino 18 size 0x3f3d402 mtime 2016-08-25 00:41:26.299110 
> > > > > bdev
> > > > > 0 extents
> > > > > [0:0x6500000+400000,0:0x6d00000+700000,0:0x7800000+800000,0:0x84
> > > > > 00
> > > > > 00
> > > > > 0+
> > > > > 800000,0:0x9000000+800000,0:0x9c00000+700000,0:0xa700000+900000,0:
> > > > > 0x
> > > > > b4
> > > > > 00000+800000,0:0xc000000+500000])
> > > > > 2016-08-25 00:44:03.348803 7f7c117ff700 20 bluefs _drop_link 
> > > > > destroying file(ino 18 size 0x3f3d402 mtime 2016-08-25
> > > > > 00:41:26.299110 bdev 0 extents
> > > > > [0:0x6500000+400000,0:0x6d00000+700000,0:0x7800000+800000,0:0x84
> > > > > 00
> > > > > 00
> > > > > 0+
> > > > > 800000,0:0x9000000+800000,0:0x9c00000+700000,0:0xa700000+900000,0:
> > > > > 0x
> > > > > b4
> > > > > 00000+800000,0:0xc000000+500000])
> > > > > 
> > > > > So, log 254 is added to the recycle list and at the same time it is added for deletion. It seems there is a race condition in this portion (?).
> > > > > 
> > > > > I was going through the rocksdb code and I found the following.
> > > > > 
> > > > > 1. DBImpl::FindObsoleteFiles is the one that is responsible for populating log_recycle_files and log_delete_files. It is also deleting entries from alive_log_files_. But, this is always under mutex_ lock.
> > > > > 
> > > > > 2. Log is deleted from DBImpl::DeleteObsoleteFileImpl which is *not* under lock , but iterating over log_delete_files. This is fishy but it shouldn't be the reason for same log number end up in two list.
> > > > > 
> > > > > 3. I saw all the places but the following  place alive_log_files_ (within DBImpl::WriteImpl)  is accessed without lock.
> > > > > 
> > > > > 4625       alive_log_files_.back().AddSize(log_entry.size());   
> > > > > 
> > > > > Can it be reintroducing the same log number (254) , I am not sure.
> > > > > 
> > > > > Summary, it seems a rocksb bug and making recycle_log_file_num = 0 should *bypass* that. I need to check the performance impact for this though.
> > > > > 
> > > > > Should I post this to rocksdb community or any other place from where I can get response from rocksdb folks ?
> > > > > 
> > > > > Thanks & Regards
> > > > > Somnath
> > > > > 
> > > > > 
> > > > > -----Original Message-----
> > > > > From: Somnath Roy
> > > > > Sent: Wednesday, August 24, 2016 2:52 PM
> > > > > To: 'Sage Weil'
> > > > > Cc: Mark Nelson; ceph-devel
> > > > > Subject: RE: Bluestore assert
> > > > > 
> > > > > Sage,
> > > > > Thanks for looking , glad that we figured out something :-)..
> > > > > So, you want me to reproduce this with only debug_bluefs = 20/20 ? Don't need bluestore log ?
> > > > > Hope my root partition doesn't get full , this crash happened 
> > > > > after
> > > > > 6 hours :-) ,
> > > > > 
> > > > > Thanks & Regards
> > > > > Somnath
> > > > > 
> > > > > -----Original Message-----
> > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > Sent: Wednesday, August 24, 2016 2:34 PM
> > > > > To: Somnath Roy
> > > > > Cc: Mark Nelson; ceph-devel
> > > > > Subject: RE: Bluestore assert
> > > > > 
> > > > > On Wed, 24 Aug 2016, Somnath Roy wrote:
> > > > > > Sage, It is there in the following github link I posted 
> > > > > > earlier..You can see 3 logs there..
> > > > > > 
> > > > > > https://github.com/somnathr/ceph/commit/b69811eb2b87f25cf017b3
> > > > > > 9c
> > > > > > 68
> > > > > > 7d
> > > > > > 88
> > > > > > a1b28fcc39
> > > > > 
> > > > > Ah sorry, got it.
> > > > > 
> > > > > And looking at the crash and code the weird error you're getting makes perfect sense: it's coming from the ReuseWritableFile() function (which gets and error on rename and returns that).  It shouldn't ever fail, so there is either a bug in the bluefs code or the rocksdb recycling code.
> > > > > 
> > > > > I think we need a full bluefs log leading up to the crash so we can find out what happened to the file that is missing...
> > > > > 
> > > > > sage
> > > > > 
> > > > > 
> > > > > 
> > > > >  >
> > > > > > Thanks & Regards
> > > > > > Somnath
> > > > > > 
> > > > > > 
> > > > > > -----Original Message-----
> > > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > > Sent: Wednesday, August 24, 2016 1:43 PM
> > > > > > To: Somnath Roy
> > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > Subject: RE: Bluestore assert
> > > > > > 
> > > > > > On Wed, 24 Aug 2016, Somnath Roy wrote:
> > > > > > > Sage,
> > > > > > > I got the db assert log from submit_transaction in the following location.
> > > > > > > 
> > > > > > > https://github.com/somnathr/ceph/commit/b69811eb2b87f25cf017
> > > > > > > b3
> > > > > > > 9c
> > > > > > > 68
> > > > > > > 7d
> > > > > > > 88
> > > > > > > a1b28fcc39
> > > > > > > 
> > > > > > > This is the log with level 1/20 and with my hook of printing rocksdb::writebatch transaction. I have uploaded 3 osd logs and a common pattern before crash is the following.
> > > > > > > 
> > > > > > >    -34> 2016-08-24 02:37:22.074321 7ff151fff700  4 rocksdb: 
> > > > > > > reusing log 266 from recycle list
> > > > > > > 
> > > > > > >    -33> 2016-08-24 02:37:22.074332 7ff151fff700 10 bluefs rename db.wal/000266.log -> db.wal/000271.log
> > > > > > >    -32> 2016-08-24 02:37:22.074338 7ff151fff700 20 bluefs rename dir db.wal (0x7ff18bdfdec0) file 000266.log not found
> > > > > > >    -31> 2016-08-24 02:37:22.074341 7ff151fff700  4 rocksdb: [default] New memtable created with log file: #271. Immutable memtables: 0.
> > > > > > > 
> > > > > > > It is trying to rename the wal file it seems and old file is not found. You can see the transaction printed in the log along with error code like this.
> > > > > > 
> > > > > > How much of the log do you have? Can you post what you have somewhere?
> > > > > > 
> > > > > > Thanks!
> > > > > > sage
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > >    -30> 2016-08-24 02:37:22.074486 7ff151fff700 -1 rocksdb: 
> > > > > > > submit_transaction error: NotFound:  code = 1 
> > > > > > > rocksdb::WriteBatch = Put( Prefix = M key =
> > > > > > > 0x0000000000001483'.0000000087.00000000000000035303')
> > > > > > > Put( Prefix = M key = 0x0000000000001483'._info') Put( 
> > > > > > > Prefix = O key =
> > > > > > > '--'0x800000000000000137863de5'.!=rbd_data.105b6b8b4567.0000
> > > > > > > 00
> > > > > > > 00
> > > > > > > 00
> > > > > > > 89
> > > > > > > ac
> > > > > > > e7!'0xfffffffffffffffeffffffffffffffff)
> > > > > > > Delete( Prefix = B key = 0x000004e73ae72000) Put( Prefix = B 
> > > > > > > key =
> > > > > > > 0x000004e73af72000) Merge( Prefix = T key =
> > > > > > > 'bluestore_statfs')
> > > > > > > 
> > > > > > > Hope my decoding of the key is proper, I have reused pretty_binary_string() of Bluestore after removing 1st 2 bytes of the key which is prefix and a '0'.
> > > > > > > 
> > > > > > > Any suggestion on the next step of root causing this db assert if log rename is not enough hint ?
> > > > > > > 
> > > > > > > BTW, I ran this time with bluefs_compact_log_sync = true and without commenting the inode number asserts. I didn't hit those asserts as well as no corruption  so far. Seems like bug of async compaction. Will try to reproduce with verbose log that one later.
> > > > > > > 
> > > > > > > Thanks & Regards
> > > > > > > Somnath
> > > > > > > 
> > > > > > > -----Original Message-----
> > > > > > > From: Somnath Roy
> > > > > > > Sent: Tuesday, August 23, 2016 7:46 AM
> > > > > > > To: 'Sage Weil'
> > > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > > Subject: RE: Bluestore assert
> > > > > > > 
> > > > > > > I was running my tests for 2 hours and it happened within that time.
> > > > > > > I will try to reproduce with 1/20.
> > > > > > > 
> > > > > > > Thanks & Regards
> > > > > > > Somnath
> > > > > > > 
> > > > > > > -----Original Message-----
> > > > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > > > Sent: Tuesday, August 23, 2016 6:46 AM
> > > > > > > To: Somnath Roy
> > > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > > Subject: RE: Bluestore assert
> > > > > > > 
> > > > > > > On Mon, 22 Aug 2016, Somnath Roy wrote:
> > > > > > > > Sage,
> > > > > > > > I think there are some bug introduced recently in the 
> > > > > > > > BlueFS and I am getting the corruption like this which I was not facing earlier.
> > > > > > > 
> > > > > > > My guess is the async bluefs compaction.  You can set 'bluefs compact log sync = true' to disable it.
> > > > > > > 
> > > > > > > Any idea how long do you have to run to reproduce?  I'd love to see a bluefs log leading up to it.  If it eats too much disk space, you could do debug bluefs = 1/20 so that it only dumps recent history on crash.
> > > > > > > 
> > > > > > > Thanks!
> > > > > > > sage
> > > > > > > 
> > > > > > > > 
> > > > > > > >    -5> 2016-08-22 15:55:21.248558 7fb68f7ff700  4 rocksdb: EVENT_LOG_v1 {"time_micros": 1471906521248538, "job": 3, "event": "compaction_started", "files_L0": [2115, 2102, 2087, 2069, 2046], "files_L1": [], "files_L2": [], "files_L3": [], "files_L4": [], "files_L5": [], "files_L6": [1998, 2007, 2013, 2019, 2026, 2032, 2039, 2043, 2052, 2060], "score": 1.5, "input_data_size": 1648188401}
> > > > > > > >     -4> 2016-08-22 15:55:27.209944 7fb6ba94d8c0  0 <cls> cls/hello/cls_hello.cc:305: loading cls_hello
> > > > > > > >     -3> 2016-08-22 15:55:27.213612 7fb6ba94d8c0  0 <cls> cls/cephfs/cls_cephfs.cc:202: loading cephfs_size_scan
> > > > > > > >     -2> 2016-08-22 15:55:27.213627 7fb6ba94d8c0  0 _get_class not permitted to load kvs
> > > > > > > >     -1> 2016-08-22 15:55:27.214620 7fb6ba94d8c0 -1 osd.0 0 failed to load OSD map for epoch 321, got 0 bytes
> > > > > > > >      0> 2016-08-22 15:55:27.216111 7fb6ba94d8c0 -1 osd/OSD.h: 
> > > > > > > > In function 'OSDMapRef OSDService::get_map(epoch_t)' 
> > > > > > > > thread
> > > > > > > > 7fb6ba94d8c0 time 2016-08-22 15:55:27.214638
> > > > > > > > osd/OSD.h: 999: FAILED assert(ret)
> > > > > > > > 
> > > > > > > >  ceph version 11.0.0-1688-g6f48ee6
> > > > > > > > (6f48ee6bc5c85f44d7ca4c984f9bef1339c2bea4)
> > > > > > > >  1: (ceph::__ceph_assert_fail(char const*, char const*, 
> > > > > > > > int, char
> > > > > > > > const*)+0x80) [0x5617f2a99e80]
> > > > > > > >  2: (OSDService::get_map(unsigned int)+0x5d) 
> > > > > > > > [0x5617f2395fdd]
> > > > > > > >  3: (OSD::init()+0x1f7e) [0x5617f233d3ce]
> > > > > > > >  4: (main()+0x2fe0) [0x5617f229d1f0]
> > > > > > > >  5: (__libc_start_main()+0xf0) [0x7fb6b7196830]
> > > > > > > >  6: (_start()+0x29) [0x5617f22eb909]
> > > > > > > > 
> > > > > > > > OSDs are not coming up (after a restart) and eventually I had to recreate the cluster.
> > > > > > > > 
> > > > > > > > Thanks & Regards
> > > > > > > > Somnath
> > > > > > > > 
> > > > > > > > -----Original Message-----
> > > > > > > > From: Somnath Roy
> > > > > > > > Sent: Monday, August 22, 2016 3:01 PM
> > > > > > > > To: 'Sage Weil'
> > > > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > > > Subject: RE: Bluestore assert
> > > > > > > > 
> > > > > > > > "compaction_style=kCompactionStyleUniversal"  in the bluestore_rocksdb_options .
> > > > > > > > Here is the option I am using..
> > > > > > > > 
> > > > > > > >         bluestore_rocksdb_options = "max_write_buffer_number=16,min_write_buffer_number_to_merge=2,recycle_log_file_num=16,compaction_threads=32,flusher_threads=8,max_background_compactions=32,max_background_flushes=8,max_bytes_for_level_base=5368709120,write_buffer_size=83886080,level0_file_num_compaction_trigger=4,level0_slowdown_writes_trigger=400,level0_stop_writes_trigger=800,stats_dump_period_sec=10,compaction_style=kCompactionStyleUniversal"
> > > > > > > > 
> > > > > > > > Here is another one after 4 hours of 4K RW :-)...Sorry to bombard you with all these , I am adding more log for the next time if I hit it..
> > > > > > > > 
> > > > > > > > 
> > > > > > > >      0> 2016-08-22 17:37:24.730817 7f8e7afff700 -1
> > > > > > > > os/bluestore/BlueFS.cc: In function 'int 
> > > > > > > > BlueFS::_read_random(BlueFS::FileReader*, uint64_t, size_t, char*)'
> > > > > > > > thread 7f8e7afff700 time 2016-08-22 17:37:24.722706
> > > > > > > > os/bluestore/BlueFS.cc: 845: FAILED assert(r == 0)
> > > > > > > > 
> > > > > > > >  ceph version 11.0.0-1688-g3fcc89c
> > > > > > > > (3fcc89c7ab4c92e6c4564e29f4e1a663db36acc0)
> > > > > > > >  1: (ceph::__ceph_assert_fail(char const*, char const*, 
> > > > > > > > int, char
> > > > > > > > const*)+0x80) [0x5581ed453cb0]
> > > > > > > >  2: (BlueFS::_read_random(BlueFS::FileReader*, unsigned 
> > > > > > > > long, unsigned long, char*)+0x836) [0x5581ed11c1b6]
> > > > > > > >  3: (BlueRocksRandomAccessFile::Read(unsigned long, 
> > > > > > > > unsigned long, rocksdb::Slice*, char*) const+0x20) 
> > > > > > > > [0x5581ed13f840]
> > > > > > > >  4: (rocksdb::RandomAccessFileReader::Read(unsigned long, 
> > > > > > > > unsigned long, rocksdb::Slice*, char*) const+0x83f) 
> > > > > > > > [0x5581ed2c6f4f]
> > > > > > > >  5: 
> > > > > > > > (rocksdb::ReadBlockContents(rocksdb::RandomAccessFileReade
> > > > > > > > r* , rocksdb::Footer const&, rocksdb::ReadOptions const&, 
> > > > > > > > rocksdb::BlockHandle const&, rocksdb::BlockContents*, 
> > > > > > > > rocksdb::Env*, bool, rocksdb::Slice const&, 
> > > > > > > > rocksdb::PersistentCacheOptions const&,
> > > > > > > > rocksdb::Logger*)+0x358) [0x5581ed291c18]
> > > > > > > >  6: (()+0x94fd54) [0x5581ed282d54]
> > > > > > > >  7: 
> > > > > > > > (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb::B
> > > > > > > > lo ck Ba se dT ab le::Rep*, rocksdb::ReadOptions const&, 
> > > > > > > > rocksdb::Slice const&,
> > > > > > > > rocksdb::BlockIter*)+0x60c) [0x5581ed284b3c]
> > > > > > > >  8: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions
> > > > > > > > const&, rocksdb::Slice const&, rocksdb::GetContext*,
> > > > > > > > bool)+0x508) [0x5581ed28ba68]
> > > > > > > >  9: (rocksdb::TableCache::Get(rocksdb::ReadOptions const&, 
> > > > > > > > rocksdb::InternalKeyComparator const&, 
> > > > > > > > rocksdb::FileDescriptor const&, rocksdb::Slice const&, 
> > > > > > > > rocksdb::GetContext*, rocksdb::HistogramImpl*, bool,
> > > > > > > > int)+0x158) [0x5581ed252118]
> > > > > > > >  10: (rocksdb::Version::Get(rocksdb::ReadOptions const&, 
> > > > > > > > rocksdb::LookupKey const&, 
> > > > > > > > std::__cxx11::basic_string<char, std::char_traits<char>, 
> > > > > > > > std::allocator<char> >*, rocksdb::Status*, 
> > > > > > > > rocksdb::MergeContext*, bool*, bool*, unsigned
> > > > > > > > long*)+0x4f8) [0x5581ed25c458]
> > > > > > > >  11: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions 
> > > > > > > > const&, rocksdb::ColumnFamilyHandle*, rocksdb::Slice 
> > > > > > > > const&, std::__cxx11::basic_string<char, 
> > > > > > > > std::char_traits<char>, std::allocator<char> >*, 
> > > > > > > > bool*)+0x5fa) [0x5581ed1f3f7a]
> > > > > > > >  12: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&, 
> > > > > > > > rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&, 
> > > > > > > > std::__cxx11::basic_string<char, std::char_traits<char>, 
> > > > > > > > std::allocator<char> >*)+0x22) [0x5581ed1f4182]
> > > > > > > >  13: (RocksDBStore::get(std::__cxx11::basic_string<char,
> > > > > > > > std::char_traits<char>, std::allocator<char> > const&, 
> > > > > > > > std::__cxx11::basic_string<char, std::char_traits<char>, 
> > > > > > > > std::allocator<char> > const&, ceph::buffer::list*)+0x157) 
> > > > > > > > [0x5581ed1d21d7]
> > > > > > > >  14: (BlueStore::Collection::get_onode(ghobject_t const&,
> > > > > > > > bool)+0x55b) [0x5581ed02802b]
> > > > > > > >  15: 
> > > > > > > > (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
> > > > > > > > ObjectStore::Transaction*)+0x1e49) [0x5581ed0318a9]
> > > > > > > >  16: 
> > > > > > > > (BlueStore::queue_transactions(ObjectStore::Sequencer*,
> > > > > > > > std::vector<ObjectStore::Transaction,
> > > > > > > > std::allocator<ObjectStore::Transaction> >&, 
> > > > > > > > std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x362) 
> > > > > > > > [0x5581ed032bc2]
> > > > > > > >  17: 
> > > > > > > > (ReplicatedPG::queue_transactions(std::vector<ObjectStore:
> > > > > > > > :T ra ns ac ti on , 
> > > > > > > > std::allocator<ObjectStore::Transaction>
> > > > > > > > >&,
> > > > > > > > std::shared_ptr<OpRequest>)+0x81) [0x5581ecea5e51]
> > > > > > > >  18: 
> > > > > > > > (ReplicatedBackend::sub_op_modify(std::shared_ptr<OpReques
> > > > > > > > t>
> > > > > > > > )+
> > > > > > > > 0x
> > > > > > > > d3
> > > > > > > > 9)
> > > > > > > > [0x5581ecef89e9]
> > > > > > > >  19: 
> > > > > > > > (ReplicatedBackend::handle_message(std::shared_ptr<OpReque
> > > > > > > > st
> > > > > > > > >)
> > > > > > > > +0
> > > > > > > > x2
> > > > > > > > fb
> > > > > > > > )
> > > > > > > > [0x5581ecefeb4b]
> > > > > > > >  20: 
> > > > > > > > (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
> > > > > > > > ThreadPool::TPHandle&)+0xbd) [0x5581ece4c63d]
> > > > > > > >  21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
> > > > > > > > std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x409) 
> > > > > > > > [0x5581eccdd2e9]
> > > > > > > >  22: 
> > > > > > > > (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest
> > > > > > > > >
> > > > > > > > const&)+0x52) [0x5581eccdd542]
> > > > > > > >  23: (OSD::ShardedOpWQ::_process(unsigned int,
> > > > > > > > ceph::heartbeat_handle_d*)+0x73f) [0x5581eccfd30f]
> > > > > > > >  24: (ShardedThreadPool::shardedthreadpool_worker(unsigned
> > > > > > > > int)+0x89f) [0x5581ed440b2f]
> > > > > > > >  25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10)
> > > > > > > > [0x5581ed4441f0]
> > > > > > > >  26: (Thread::entry_wrapper()+0x75) [0x5581ed4335c5]
> > > > > > > >  27: (()+0x76fa) [0x7f8ed9e4e6fa]
> > > > > > > >  28: (clone()+0x6d) [0x7f8ed7caeb5d]
> > > > > > > >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Thanks & Regards
> > > > > > > > Somnath
> > > > > > > > 
> > > > > > > > -----Original Message-----
> > > > > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > > > > Sent: Monday, August 22, 2016 2:57 PM
> > > > > > > > To: Somnath Roy
> > > > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > > > Subject: RE: Bluestore assert
> > > > > > > > 
> > > > > > > > On Mon, 22 Aug 2016, Somnath Roy wrote:
> > > > > > > > > FYI, I was running rocksdb by enabling universal style 
> > > > > > > > > compaction during this time.
> > > > > > > > 
> > > > > > > > How are you selecting universal compaction?
> > > > > > > > 
> > > > > > > > sage
> > > > > > > > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> > > > > > > > --
> > > > > > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > > > > > > > in the body of a message to majordomo@vger.kernel.org More 
> > > > > > > > majordomo info at 
> > > > > > > > http://vger.kernel.org/majordomo-info.html
> > > > > > > > 
> > > > > > > > 
> > > > > > > --
> > > > > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > > > > > > in the body of a message to majordomo@vger.kernel.org More 
> > > > > > > majordomo info at  
> > > > > > > http://vger.kernel.org/majordomo-info.html
> > > > > > > 
> > > > > > > 
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > > > > > in the body of a message to majordomo@vger.kernel.org More 
> > > > > > majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > > > 
> > > > > > 
> > > > > 
> > > > > 
> > > > 
> > > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > > info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > 
> > 
> 
> 
