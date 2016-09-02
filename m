From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore assert
Date: Fri, 2 Sep 2016 17:23:47 +0000
Message-ID: <BL2PR02MB2115D290C0F978DB7B2D1DD4F4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB2115443F5ACA3459E2CEBFBAF41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608151952230.14754@piezo.us.to>
 <BL2PR02MB21150BE782012D52DBB8FF26F4130@BL2PR02MB2115.namprd02.prod.outlook.com>
 <BL2PR02MB2115FFBBBF5A04D62910A239F4E80@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222156580.25681@piezo.us.to>
  <BL2PR02MB2115C713F6AF6B989B4DC536F4E80@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231343530.25678@piezo.us.to>
  <CY1PR02MB2123D6119409C1F61BF39A46F4EA0@CY1PR02MB2123.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608242042510.25681@piezo.us.to>
 <CY1PR02MB21235A07222322180C0E2BDFF4EA0@CY1PR02MB2123.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608242132460.25681@piezo.us.to>
    <BL2PR02MB21154C4E291C96D597444649F4E00@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608311318350.19032@piezo.us.to>
  <BL2PR02MB21153A76E39772A143A638EEF4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1609021627100.31624@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam01on0049.outbound.protection.outlook.com ([104.47.32.49]:48032
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932495AbcIBRXu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Sep 2016 13:23:50 -0400
In-Reply-To: <alpine.DEB.2.11.1609021627100.31624@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Here is my rocksdb option :

        bluestore_rocksdb_options =3D "max_write_buffer_number=3D16,min_wri=
te_buffer_number_to_merge=3D2,recycle_log_file_num=3D16,compaction_threads=
=3D32,flusher_threads=3D8,max_background_compactions=3D32,max_background_fl=
ushes=3D8,max_bytes_for_level_base=3D5368709120,write_buffer_size=3D8388608=
0,level0_file_num_compaction_trigger=3D4,level0_slowdown_writes_trigger=3D4=
00,level0_stop_writes_trigger=3D800,stats_dump_period_sec=3D10,compaction_s=
tyle=3DkCompactionStyleUniversal"

one discrepancy I can see here on max_bytes_for_level_base , it should be s=
ame as level 0 size. Initially, I had bigger min_write_buffer_number_to_mer=
ge and that's how I calculated. Now, level 0 size is the following

write_buffer_size * min_write_buffer_number_to_merge * level0_file_num_comp=
action_trigger =3D 80MB * 2 * 4 =3D ~640MB

I should adjust max_bytes_for_level_base to the similar value probably.

Please find the level 10 log here. The log I captured during replay (crashe=
d again) after it crashed originally because of the same reason.

https://drive.google.com/file/d/0B7W-S0z_ymMJSnA3R2dyellYZ0U/view?usp=3Dsha=
ring

Thanks for the explanation , I got it now why it is trying to flush inode 1=
.

But, shouldn't we check the length as well during runway check rather than =
just relying on bluefs_min_log_runway only.

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]=20
Sent: Friday, September 02, 2016 9:35 AM
To: Somnath Roy
Cc: Mark Nelson; ceph-devel
Subject: RE: Bluestore assert



On Fri, 2 Sep 2016, Somnath Roy wrote:

> Sage,
> Tried to do some analysis on the inode assert, following looks suspicious=
.
>=20
>    -10> 2016-08-31 17:55:56.921075 7faf14fff700 10 bluefs _fsync 0x7faf12=
075140 file(ino 693 size 0x19c2c265 mtime 2016-08-31 17:55:56.919038 bdev 1=
 extents [1:0x6e500000+100000,1:0x6e700000+100000,1:0x6ea00000+200000,1:0x6=
ed00000+200000,1:0x6f000000+200000,1:0x6f300000+200000,1:0x6f600000+200000,=
1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff00000+100000,1:0x70100000+20=
0000,1:0x70400000+200000,1:0x70700000+200000,1:0x70a00000+100000,1:0x70c000=
00+200000,1:0x70f00000+100000,1:0x71100000+200000,1:0x71400000+200000,1:0x7=
1700000+200000,1:0x71a00000+100000,1:0x71c00000+100000,1:0x71e00000+100000,=
1:0x72000000+100000,1:0x72200000+200000,1:0x72500000+200000,1:0x72800000+10=
0000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72f00000+100000,1:0x731000=
00+200000,1:0x73400000+100000,1:0x73600000+200000,1:0x73900000+200000,1:0x7=
3c00000+200000,1:0x73f00000+200000,1:0x74300000+200000,1:0x74600000+200000,=
1:0x74900000+200000,1:0x74c00000+200000,1:0x74f00000+100000,1:0x75100000+10=
0000,1:0x75300!
 000+100000,1:0x75600000+100000,1:0x75800000+100000,1:0x75a00000+200000,1:0=
x75d00000+100000,1:0x75f00000+100000,1:0x76100000+100000,1:0x76400000+20000=
0,1:0x76700000+200000,1:0x76a00000+300000,1:0x76e00000+200000,1:0x77100000+=
100000,1:0x77300000+100000,1:0x77500000+100000,1:0x77700000+300000,1:0x77b0=
0000+200000,1:0x77e00000+200000,1:0x78100000+100000,1:0x78300000+200000,1:0=
x78600000+200000,1:0x78900000+100000,1:0x78c00000+100000,1:0x78e00000+10000=
0,1:0x79000000+100000,1:0x79200000+100000,1:0x79400000+200000,1:0x79700000+=
100000,1:0x79900000+200000,1:0x79c00000+200000,1:0x79f00000+100000,1:0x7a10=
0000+200000,1:0x7a400000+200000,1:0x7a700000+100000,1:0x7a900000+200000,1:0=
x7ac00000+100000,1:0x7ae00000+100000,1:0x7b000000+100000,1:0x7b200000+20000=
0,1:0x7b500000+100000,1:0x7b800000+200000,1:0x7bb00000+100000,1:0x7bd00000+=
200000,1:0x7c000000+100000,1:0x7c200000+200000,1:0x7c500000+100000,1:0x7c70=
0000+100000,1:0x7c900000+200000,1:0x7cc00000+100000,1:0x7ce00000+100000,1:0=
x7d000000+1000!
 00,1:0x7d200000+100000,1:0x7d400000+100000,1:0x7d600000+100000,1:0x7d80000=
0+10e00000])
>     -9> 2016-08-31 17:55:56.921117 7faf14fff700 10 bluefs _flush 0x7faf12=
075140 no dirty data on file(ino 693 size 0x19c2c265 mtime 2016-08-31 17:55=
:56.919038 bdev 1 extents [1:0x6e500000+100000,1:0x6e700000+100000,1:0x6ea0=
0000+200000,1:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000+200000,1:0=
x6f600000+200000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff00000+10000=
0,1:0x70100000+200000,1:0x70400000+200000,1:0x70700000+200000,1:0x70a00000+=
100000,1:0x70c00000+200000,1:0x70f00000+100000,1:0x71100000+200000,1:0x7140=
0000+200000,1:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000+100000,1:0=
x71e00000+100000,1:0x72000000+100000,1:0x72200000+200000,1:0x72500000+20000=
0,1:0x72800000+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72f00000+=
100000,1:0x73100000+200000,1:0x73400000+100000,1:0x73600000+200000,1:0x7390=
0000+200000,1:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000+200000,1:0=
x74600000+200000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f00000+10000=
0,1:0x75100000!
 +100000,1:0x75300000+100000,1:0x75600000+100000,1:0x75800000+100000,1:0x75=
a00000+200000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x76100000+100000,1=
:0x76400000+200000,1:0x76700000+200000,1:0x76a00000+300000,1:0x76e00000+200=
000,1:0x77100000+100000,1:0x77300000+100000,1:0x77500000+100000,1:0x7770000=
0+300000,1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000+100000,1:0x78=
300000+200000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c00000+100000,1=
:0x78e00000+100000,1:0x79000000+100000,1:0x79200000+100000,1:0x79400000+200=
000,1:0x79700000+100000,1:0x79900000+200000,1:0x79c00000+200000,1:0x79f0000=
0+100000,1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000+100000,1:0x7a=
900000+200000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b000000+100000,1=
:0x7b200000+200000,1:0x7b500000+100000,1:0x7b800000+200000,1:0x7bb00000+100=
000,1:0x7bd00000+200000,1:0x7c000000+100000,1:0x7c200000+200000,1:0x7c50000=
0+100000,1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+100000,1:0x7c=
e00000+100000,!
 1:0x7d000000+100000,1:0x7d200000+100000,1:0x7d400000+100000,1:0x7d600000+1=
00000,1:0x7d800000+10e00000])
>     -8> 2016-08-31 17:55:56.921137 7faf14fff700 10 bluefs wait_for_aio 0x=
7faf12075140
>     -7> 2016-08-31 17:55:56.931541 7faf14fff700 10 bluefs wait_for_aio 0x=
7faf12075140 done in 0.010402
>     -6> 2016-08-31 17:55:56.931551 7faf14fff700 20 bluefs _fsync file met=
adata was dirty (31278) on file(ino 693 size 0x19c2c265 mtime 2016-08-31 17=
:55:56.919038 bdev 1 extents [1:0x6e500000+100000,1:0x6e700000+100000,1:0x6=
ea00000+200000,1:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000+200000,=
1:0x6f600000+200000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff00000+10=
0000,1:0x70100000+200000,1:0x70400000+200000,1:0x70700000+200000,1:0x70a000=
00+100000,1:0x70c00000+200000,1:0x70f00000+100000,1:0x71100000+200000,1:0x7=
1400000+200000,1:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000+100000,=
1:0x71e00000+100000,1:0x72000000+100000,1:0x72200000+200000,1:0x72500000+20=
0000,1:0x72800000+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72f000=
00+100000,1:0x73100000+200000,1:0x73400000+100000,1:0x73600000+200000,1:0x7=
3900000+200000,1:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000+200000,=
1:0x74600000+200000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f00000+10=
0000,1:0x75100!
 000+100000,1:0x75300000+100000,1:0x75600000+100000,1:0x75800000+100000,1:0=
x75a00000+200000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x76100000+10000=
0,1:0x76400000+200000,1:0x76700000+200000,1:0x76a00000+300000,1:0x76e00000+=
200000,1:0x77100000+100000,1:0x77300000+100000,1:0x77500000+100000,1:0x7770=
0000+300000,1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000+100000,1:0=
x78300000+200000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c00000+10000=
0,1:0x78e00000+100000,1:0x79000000+100000,1:0x79200000+100000,1:0x79400000+=
200000,1:0x79700000+100000,1:0x79900000+200000,1:0x79c00000+200000,1:0x79f0=
0000+100000,1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000+100000,1:0=
x7a900000+200000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b000000+10000=
0,1:0x7b200000+200000,1:0x7b500000+100000,1:0x7b800000+200000,1:0x7bb00000+=
100000,1:0x7bd00000+200000,1:0x7c000000+100000,1:0x7c200000+200000,1:0x7c50=
0000+100000,1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+100000,1:0=
x7ce00000+1000!
 00,1:0x7d000000+100000,1:0x7d200000+100000,1:0x7d400000+100000,1:0x7d60000=
0+100000,1:0x7d800000+10e00000]), flushing log
>=20
> The above looks good, it is about to call _flush_and_sync_log() after thi=
s.

Yes, although this file is huge (0x19c2c265 =3D 432194149 ~ 400MB)... What =
rocksdb options did you pass in?  I'm guessing this is a log file, but we g=
enerally want those smallish (maybe 16MB - 64MB, so that L0 SST generation =
isn't too slow).

>     -5> 2016-08-31 17:55:56.931588 7faf14fff700 10 bluefs _flush_and_sync=
_log txn(seq 31278 len 0x50e146 crc 0x58a6b9ab)
>     -4> 2016-08-31 17:55:56.933951 7faf14fff700 10 bluefs _pad_bl padding=
 with 0xe94 zeros
>     -3> 2016-08-31 17:55:56.934079 7faf14fff700 20 bluefs flush_bdev
>     -2> 2016-08-31 17:55:56.934257 7faf14fff700 10 bluefs _flush 0x7faf2e=
824140 0xce9000~50f000 to file(ino 1 size 0xce9000 mtime 0.000000 bdev 0 ex=
tents [0:0xba00000+500000,0:0xfd00000+c00000])
>     -1> 2016-08-31 17:55:56.934274 7faf14fff700 10 bluefs _flush_range 0x=
7faf2e824140 pos 0xce9000 0xce9000~50f000 to file(ino 1 size 0xce9000 mtime=
 0.000000 bdev 0 extents [0:0xba00000+500000,0:0xfd00000+c00000])
>      0> 2016-08-31 17:55:56.939745 7faf14fff700 -1=20
> os/bluestore/BlueFS.cc: In function 'int=20
> BlueFS::_flush_range(BlueFS::FileWriter*, uint64_t, uint64_t)' thread=20
> 7faf14fff700 time 2016-08-31 17:55:56.934282
> os/bluestore/BlueFS.cc: 1390: FAILED assert(h->file->fnode.ino !=3D 1)
>=20
>  ceph version 11.0.0-1946-g9a5cfe2=20
> (9a5cfe2e8e8c79b976c34e593993d74b58fce885)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char=20
> const*)+0x80) [0x56073c27c7d0]
>  2: (BlueFS::_flush_range(BlueFS::FileWriter*, unsigned long, unsigned=20
> long)+0x1d69) [0x56073bf4e109]
>  3: (BlueFS::_flush(BlueFS::FileWriter*, bool)+0xa7) [0x56073bf4e2d7]
>  4: (BlueFS::_flush_and_sync_log(std::unique_lock<std::mutex>&,=20
> unsigned long, unsigned long)+0x443) [0x56073bf4fe13]
>  5: (BlueFS::_fsync(BlueFS::FileWriter*,=20
> std::unique_lock<std::mutex>&)+0x35b) [0x56073bf5140b]
>  6: (BlueRocksWritableFile::Sync()+0x62) [0x56073bf68be2]
>  7: (rocksdb::WritableFileWriter::SyncInternal(bool)+0x2d1)=20
> [0x56073c0f24b1]
>  8: (rocksdb::WritableFileWriter::Sync(bool)+0xf0) [0x56073c0f3960]
>  9:=20
> (rocksdb::CompactionJob::FinishCompactionOutputFile(rocksdb::Status=20
> const&, rocksdb::CompactionJob::SubcompactionState*)+0x4e6)=20
> [0x56073c1354c6]
>  10:=20
> (rocksdb::CompactionJob::ProcessKeyValueCompaction(rocksdb::Compaction
> Job::SubcompactionState*)+0x14ea) [0x56073c137c8a]
>  11: (rocksdb::CompactionJob::Run()+0x479) [0x56073c138c09]
>  12: (rocksdb::DBImpl::BackgroundCompaction(bool*,=20
> rocksdb::JobContext*, rocksdb::LogBuffer*, void*)+0x9c0)=20
> [0x56073c0275d0]
>  13: (rocksdb::DBImpl::BackgroundCallCompaction(void*)+0xbf)=20
> [0x56073c03443f]
>  14: (rocksdb::ThreadPool::BGThread(unsigned long)+0x1d9)=20
> [0x56073c0eb039]
>  15: (()+0x9900d3) [0x56073c0eb0d3]
>  16: (()+0x76fa) [0x7faf3d1106fa]
>  17: (clone()+0x6d) [0x7faf3af70b5d]
>=20
>=20
> Now, as you can see it is calling _flush() with inode 1 , why ? is this e=
xpected ?

Yes.  The metadata for the log file is dirty (the file size changed), so bl=
uefs is flushing it's journal (ino 1) to update the fnode.

But this is very concerning:

>     -2> 2016-08-31 17:55:56.934257 7faf14fff700 10 bluefs _flush=20
> 0x7faf2e824140 0xce9000~50f000 to file(ino 1 size 0xce9000 mtime=20
> 0.000000 bdev 0 extents [0:0xba00000+500000,0:0xfd00000+c00000])

0xce9000~50f000 is a ~5 MB write.  Why would we ever write that much to the=
 bluefs metadata journal at once?  That's why it's blowign the runway. =20
We have ~17MB allocated (0:0xba00000+500000,0:0xfd00000+c00000), we're at o=
ffset ~13MB, and we're writing ~5MB.

> Question :
> ------------
>=20
> 1. Why we are using the existing log_write to do a runway check ?
>=20
> https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueFS.cc#L1
> 280
>=20
> Shouldn't the log_writer needs to be reinitialed with the FileWriter rock=
sdb sent with sync call ?

It's the bluefs journal writer.. that's the runway we're worried about.

> 2. The runway check is not considering the request length , so, why it=20
> is not expecting to allocate here=20
> (https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueFS.cc#L
> 1388)
>=20
> If the snippet is not sufficient, let me know if you want me to upload th=
e level 10 log or need 20/20 log to proceed further.

The level 10 log is probably enough...

Thanks!
sage

>=20
> Thanks & Regards
> Somnath
>=20
>=20
> -----Original Message-----
> From: Somnath Roy
> Sent: Thursday, September 01, 2016 3:59 PM
> To: 'Sage Weil'
> Cc: Mark Nelson; ceph-devel
> Subject: RE: Bluestore assert
>=20
> Sage,
> Created the following pull request on rocksdb repo, please take a look.
>=20
> https://github.com/facebook/rocksdb/pull/1313
>=20
> The fix is working fine for me.
>=20
> Thanks & Regards
> Somnath
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Wednesday, August 31, 2016 6:20 AM
> To: Somnath Roy
> Cc: Mark Nelson; ceph-devel
> Subject: RE: Bluestore assert
>=20
> On Tue, 30 Aug 2016, Somnath Roy wrote:
> > Sage,
> > I did some debugging on the rocksdb bug., here is my findings.
> >=20
> > 1. The log file number is added to log_recycle_files and *not* in log_d=
elete_files from the following if loop, which is expected.
> >=20
> > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698f460
> > 60
> > 9bf7cea4b63/db/db_impl.cc#L854
> >=20
> > 2. But, it is there in the candidate list in the following loop.
> >=20
> > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698f460
> > 60
> > 9bf7cea4b63/db/db_impl.cc#L1000
> >=20
> >=20
> > 3. This means it is added in full_scan_candidate_files from the=20
> > following  from a full scan (?)
> >=20
> > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698f460
> > 60
> > 9bf7cea4b63/db/db_impl.cc#L834
> >=20
> > Added some log entries to verify , need to wait 6 hours :-(
> >=20
> > 4. Probably, #3 is not unusual , but the check in the following seems n=
ot sufficient to keep the file.
> >=20
> > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698f460
> > 60
> > 9bf7cea4b63/db/db_impl.cc#L1013
> >=20
> > Again, added some log to see the state.log_number during that time. BTW=
, I have seen the following check probably noop as state.prev_log_number is=
 always coming 0.
> >=20
> > (number =3D=3D state.prev_log_number)
> >=20
> > 5. So, the quick solution I am thinking is to put a check to see if the=
 log is in recycle list and avoid deleting from the above part (?).
>=20
> That seems reasonable.  I suggest coding this up and submitting a PR to g=
ithub.com/facebook/rocksdb, and ask in the comment if there is a better sol=
ution.
>=20
> Probably the recycle list should be turned into a set so that the check i=
s O(log n)...
>=20
> Thanks!
> sage
>=20
>=20
> >=20
> > Let me know what you think.
> >=20
> > Thanks & Regards
> > Somnath
> > -----Original Message-----
> > From: Somnath Roy
> > Sent: Sunday, August 28, 2016 7:37 AM
> > To: 'Sage Weil'
> > Cc: 'Mark Nelson'; 'ceph-devel'
> > Subject: RE: Bluestore assert
> >=20
> > Sage,
> > Some updates on this.
> >=20
> > 1. The issue is reproduced with the latest rocksdb master as well.
> >=20
> > 2. The issue is *not happening* if I run disabling rocksdb log recyclin=
g. This proves our root cause is right.
> >=20
> > 3. Running some more performance tests by disabling log recycling , but=
, initial impression is, it is introducing spikes and output is not as stab=
le as enabling log recycling.
> >=20
> > 4. Created a rocksdb issue for this
> > (https://github.com/facebook/rocksdb/issues/1303)
> >=20
> > Thanks & Regards
> > Somnath
> >=20
> >=20
> > -----Original Message-----
> > From: Somnath Roy
> > Sent: Thursday, August 25, 2016 2:35 PM
> > To: 'Sage Weil'
> > Cc: 'Mark Nelson'; 'ceph-devel'
> > Subject: RE: Bluestore assert
> >=20
> > Sage,
> > Hope you are able to download the log I shared via google doc.
> > It seems the bug is around this portion.
> >=20
> > 2016-08-25 00:44:03.348710 7f7c117ff700  4 rocksdb: adding log 254=20
> > to recycle list
> >=20
> > 2016-08-25 00:44:03.348722 7f7c117ff700  4 rocksdb: adding log 256=20
> > to recycle list
> >=20
> > 2016-08-25 00:44:03.348725 7f7c117ff700  4 rocksdb: (Original Log=20
> > Time
> > 2016/08/25-00:44:03.347467) [default] Level-0 commit table #258=20
> > started
> > 2016-08-25 00:44:03.348727 7f7c117ff700  4 rocksdb: (Original Log=20
> > Time
> > 2016/08/25-00:44:03.348225) [default] Level-0 commit table #258:=20
> > memtable #1 done
> > 2016-08-25 00:44:03.348729 7f7c117ff700  4 rocksdb: (Original Log=20
> > Time
> > 2016/08/25-00:44:03.348227) [default] Level-0 commit table #258:=20
> > memtable #2 done
> > 2016-08-25 00:44:03.348730 7f7c117ff700  4 rocksdb: (Original Log=20
> > Time
> > 2016/08/25-00:44:03.348239) EVENT_LOG_v1 {"time_micros":=20
> > 1472111043348233, "job": 88, "event": "flush_finished", "lsm_state":=20
> > [3, 4, 0, 0, 0, 0, 0], "immutable_memtables": 0}
> > 2016-08-25 00:44:03.348735 7f7c117ff700  4 rocksdb: (Original Log=20
> > Time
> > 2016/08/25-00:44:03.348297) [default] Level summary: base level 1=20
> > max bytes base 5368709120 files[3 4 0 0 0 0 0] max score 0.75
> >=20
> > 2016-08-25 00:44:03.348751 7f7c117ff700  4 rocksdb: [JOB 88] Try to del=
ete WAL files size 131512372, prev total WAL file size 131834601, number of=
 live WAL files 3.
> >=20
> > 2016-08-25 00:44:03.348761 7f7c117ff700 10 bluefs unlink=20
> > db.wal/000256.log
> > 2016-08-25 00:44:03.348766 7f7c117ff700 20 bluefs _drop_link had=20
> > refs
> > 1 on file(ino 19 size 0x3f3ddd9 mtime 2016-08-25 00:41:26.298423=20
> > bdev
> > 0 extents
> > [0:0xc500000+200000,0:0xcb00000+800000,0:0xd700000+700000,0:0xe20000
> > 0+
> > 800000,0:0xee00000+800000,0:0xfa00000+800000,0:0x10600000+700000,0:0
> > x1
> > 1100000+700000,0:0x11c00000+800000,0:0x12800000+100000])
> > 2016-08-25 00:44:03.348775 7f7c117ff700 20 bluefs _drop_link=20
> > destroying file(ino 19 size 0x3f3ddd9 mtime 2016-08-25=20
> > 00:41:26.298423 bdev 0 extents=20
> > [0:0xc500000+200000,0:0xcb00000+800000,0:0xd700000+700000,0:0xe20000
> > 0+
> > 800000,0:0xee00000+800000,0:0xfa00000+800000,0:0x10600000+700000,0:0
> > x1
> > 1100000+700000,0:0x11c00000+800000,0:0x12800000+100000])
> > 2016-08-25 00:44:03.348794 7f7c117ff700 10 bluefs unlink=20
> > db.wal/000254.log
> > 2016-08-25 00:44:03.348796 7f7c117ff700 20 bluefs _drop_link had=20
> > refs
> > 1 on file(ino 18 size 0x3f3d402 mtime 2016-08-25 00:41:26.299110=20
> > bdev
> > 0 extents
> > [0:0x6500000+400000,0:0x6d00000+700000,0:0x7800000+800000,0:0x840000
> > 0+
> > 800000,0:0x9000000+800000,0:0x9c00000+700000,0:0xa700000+900000,0:0x
> > b4
> > 00000+800000,0:0xc000000+500000])
> > 2016-08-25 00:44:03.348803 7f7c117ff700 20 bluefs _drop_link=20
> > destroying file(ino 18 size 0x3f3d402 mtime 2016-08-25=20
> > 00:41:26.299110 bdev 0 extents=20
> > [0:0x6500000+400000,0:0x6d00000+700000,0:0x7800000+800000,0:0x840000
> > 0+
> > 800000,0:0x9000000+800000,0:0x9c00000+700000,0:0xa700000+900000,0:0x
> > b4
> > 00000+800000,0:0xc000000+500000])
> >=20
> > So, log 254 is added to the recycle list and at the same time it is add=
ed for deletion. It seems there is a race condition in this portion (?).
> >=20
> > I was going through the rocksdb code and I found the following.
> >=20
> > 1. DBImpl::FindObsoleteFiles is the one that is responsible for populat=
ing log_recycle_files and log_delete_files. It is also deleting entries fro=
m alive_log_files_. But, this is always under mutex_ lock.
> >=20
> > 2. Log is deleted from DBImpl::DeleteObsoleteFileImpl which is *not* un=
der lock , but iterating over log_delete_files. This is fishy but it should=
n't be the reason for same log number end up in two list.
> >=20
> > 3. I saw all the places but the following  place alive_log_files_ (with=
in DBImpl::WriteImpl)  is accessed without lock.
> >=20
> > 4625       alive_log_files_.back().AddSize(log_entry.size());  =20
> >=20
> > Can it be reintroducing the same log number (254) , I am not sure.
> >=20
> > Summary, it seems a rocksb bug and making recycle_log_file_num =3D 0 sh=
ould *bypass* that. I need to check the performance impact for this though.
> >=20
> > Should I post this to rocksdb community or any other place from where I=
 can get response from rocksdb folks ?
> >=20
> > Thanks & Regards
> > Somnath
> >=20
> >=20
> > -----Original Message-----
> > From: Somnath Roy
> > Sent: Wednesday, August 24, 2016 2:52 PM
> > To: 'Sage Weil'
> > Cc: Mark Nelson; ceph-devel
> > Subject: RE: Bluestore assert
> >=20
> > Sage,
> > Thanks for looking , glad that we figured out something :-)..
> > So, you want me to reproduce this with only debug_bluefs =3D 20/20 ? Do=
n't need bluestore log ?
> > Hope my root partition doesn't get full , this crash happened after=20
> > 6 hours :-) ,
> >=20
> > Thanks & Regards
> > Somnath
> >=20
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Wednesday, August 24, 2016 2:34 PM
> > To: Somnath Roy
> > Cc: Mark Nelson; ceph-devel
> > Subject: RE: Bluestore assert
> >=20
> > On Wed, 24 Aug 2016, Somnath Roy wrote:
> > > Sage, It is there in the following github link I posted=20
> > > earlier..You can see 3 logs there..
> > >=20
> > > https://github.com/somnathr/ceph/commit/b69811eb2b87f25cf017b39c68
> > > 7d
> > > 88
> > > a1b28fcc39
> >=20
> > Ah sorry, got it.
> >=20
> > And looking at the crash and code the weird error you're getting makes =
perfect sense: it's coming from the ReuseWritableFile() function (which get=
s and error on rename and returns that).  It shouldn't ever fail, so there =
is either a bug in the bluefs code or the rocksdb recycling code.
> >=20
> > I think we need a full bluefs log leading up to the crash so we can fin=
d out what happened to the file that is missing...
> >=20
> > sage
> >=20
> >=20
> >=20
> >  >
> > > Thanks & Regards
> > > Somnath
> > >=20
> > >=20
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sweil@redhat.com]
> > > Sent: Wednesday, August 24, 2016 1:43 PM
> > > To: Somnath Roy
> > > Cc: Mark Nelson; ceph-devel
> > > Subject: RE: Bluestore assert
> > >=20
> > > On Wed, 24 Aug 2016, Somnath Roy wrote:
> > > > Sage,
> > > > I got the db assert log from submit_transaction in the following lo=
cation.
> > > >=20
> > > > https://github.com/somnathr/ceph/commit/b69811eb2b87f25cf017b39c
> > > > 68
> > > > 7d
> > > > 88
> > > > a1b28fcc39
> > > >=20
> > > > This is the log with level 1/20 and with my hook of printing rocksd=
b::writebatch transaction. I have uploaded 3 osd logs and a common pattern =
before crash is the following.
> > > >=20
> > > >    -34> 2016-08-24 02:37:22.074321 7ff151fff700  4 rocksdb:=20
> > > > reusing log 266 from recycle list
> > > >=20
> > > >    -33> 2016-08-24 02:37:22.074332 7ff151fff700 10 bluefs rename db=
.wal/000266.log -> db.wal/000271.log
> > > >    -32> 2016-08-24 02:37:22.074338 7ff151fff700 20 bluefs rename di=
r db.wal (0x7ff18bdfdec0) file 000266.log not found
> > > >    -31> 2016-08-24 02:37:22.074341 7ff151fff700  4 rocksdb: [defaul=
t] New memtable created with log file: #271. Immutable memtables: 0.
> > > >=20
> > > > It is trying to rename the wal file it seems and old file is not fo=
und. You can see the transaction printed in the log along with error code l=
ike this.
> > >=20
> > > How much of the log do you have? Can you post what you have somewhere=
?
> > >=20
> > > Thanks!
> > > sage
> > >=20
> > >=20
> > > >=20
> > > >    -30> 2016-08-24 02:37:22.074486 7ff151fff700 -1 rocksdb:=20
> > > > submit_transaction error: NotFound:  code =3D 1=20
> > > > rocksdb::WriteBatch =3D Put( Prefix =3D M key =3D
> > > > 0x0000000000001483'.0000000087.00000000000000035303')
> > > > Put( Prefix =3D M key =3D 0x0000000000001483'._info') Put( Prefix =
=3D=20
> > > > O key =3D
> > > > '--'0x800000000000000137863de5'.!=3Drbd_data.105b6b8b4567.00000000
> > > > 00
> > > > 89
> > > > ac
> > > > e7!'0xfffffffffffffffeffffffffffffffff)
> > > > Delete( Prefix =3D B key =3D 0x000004e73ae72000) Put( Prefix =3D B =
key=20
> > > > =3D
> > > > 0x000004e73af72000) Merge( Prefix =3D T key =3D 'bluestore_statfs')
> > > >=20
> > > > Hope my decoding of the key is proper, I have reused pretty_binary_=
string() of Bluestore after removing 1st 2 bytes of the key which is prefix=
 and a '0'.
> > > >=20
> > > > Any suggestion on the next step of root causing this db assert if l=
og rename is not enough hint ?
> > > >=20
> > > > BTW, I ran this time with bluefs_compact_log_sync =3D true and with=
out commenting the inode number asserts. I didn't hit those asserts as well=
 as no corruption  so far. Seems like bug of async compaction. Will try to =
reproduce with verbose log that one later.
> > > >=20
> > > > Thanks & Regards
> > > > Somnath
> > > >=20
> > > > -----Original Message-----
> > > > From: Somnath Roy
> > > > Sent: Tuesday, August 23, 2016 7:46 AM
> > > > To: 'Sage Weil'
> > > > Cc: Mark Nelson; ceph-devel
> > > > Subject: RE: Bluestore assert
> > > >=20
> > > > I was running my tests for 2 hours and it happened within that time=
.
> > > > I will try to reproduce with 1/20.
> > > >=20
> > > > Thanks & Regards
> > > > Somnath
> > > >=20
> > > > -----Original Message-----
> > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > Sent: Tuesday, August 23, 2016 6:46 AM
> > > > To: Somnath Roy
> > > > Cc: Mark Nelson; ceph-devel
> > > > Subject: RE: Bluestore assert
> > > >=20
> > > > On Mon, 22 Aug 2016, Somnath Roy wrote:
> > > > > Sage,
> > > > > I think there are some bug introduced recently in the BlueFS=20
> > > > > and I am getting the corruption like this which I was not facing =
earlier.
> > > >=20
> > > > My guess is the async bluefs compaction.  You can set 'bluefs compa=
ct log sync =3D true' to disable it.
> > > >=20
> > > > Any idea how long do you have to run to reproduce?  I'd love to see=
 a bluefs log leading up to it.  If it eats too much disk space, you could =
do debug bluefs =3D 1/20 so that it only dumps recent history on crash.
> > > >=20
> > > > Thanks!
> > > > sage
> > > >=20
> > > > >=20
> > > > >    -5> 2016-08-22 15:55:21.248558 7fb68f7ff700  4 rocksdb: EVENT_=
LOG_v1 {"time_micros": 1471906521248538, "job": 3, "event": "compaction_sta=
rted", "files_L0": [2115, 2102, 2087, 2069, 2046], "files_L1": [], "files_L=
2": [], "files_L3": [], "files_L4": [], "files_L5": [], "files_L6": [1998, =
2007, 2013, 2019, 2026, 2032, 2039, 2043, 2052, 2060], "score": 1.5, "input=
_data_size": 1648188401}
> > > > >     -4> 2016-08-22 15:55:27.209944 7fb6ba94d8c0  0 <cls> cls/hell=
o/cls_hello.cc:305: loading cls_hello
> > > > >     -3> 2016-08-22 15:55:27.213612 7fb6ba94d8c0  0 <cls> cls/ceph=
fs/cls_cephfs.cc:202: loading cephfs_size_scan
> > > > >     -2> 2016-08-22 15:55:27.213627 7fb6ba94d8c0  0 _get_class not=
 permitted to load kvs
> > > > >     -1> 2016-08-22 15:55:27.214620 7fb6ba94d8c0 -1 osd.0 0 failed=
 to load OSD map for epoch 321, got 0 bytes
> > > > >      0> 2016-08-22 15:55:27.216111 7fb6ba94d8c0 -1 osd/OSD.h:=20
> > > > > In function 'OSDMapRef OSDService::get_map(epoch_t)' thread
> > > > > 7fb6ba94d8c0 time 2016-08-22 15:55:27.214638
> > > > > osd/OSD.h: 999: FAILED assert(ret)
> > > > >=20
> > > > >  ceph version 11.0.0-1688-g6f48ee6
> > > > > (6f48ee6bc5c85f44d7ca4c984f9bef1339c2bea4)
> > > > >  1: (ceph::__ceph_assert_fail(char const*, char const*, int,=20
> > > > > char
> > > > > const*)+0x80) [0x5617f2a99e80]
> > > > >  2: (OSDService::get_map(unsigned int)+0x5d) [0x5617f2395fdd]
> > > > >  3: (OSD::init()+0x1f7e) [0x5617f233d3ce]
> > > > >  4: (main()+0x2fe0) [0x5617f229d1f0]
> > > > >  5: (__libc_start_main()+0xf0) [0x7fb6b7196830]
> > > > >  6: (_start()+0x29) [0x5617f22eb909]
> > > > >=20
> > > > > OSDs are not coming up (after a restart) and eventually I had to =
recreate the cluster.
> > > > >=20
> > > > > Thanks & Regards
> > > > > Somnath
> > > > >=20
> > > > > -----Original Message-----
> > > > > From: Somnath Roy
> > > > > Sent: Monday, August 22, 2016 3:01 PM
> > > > > To: 'Sage Weil'
> > > > > Cc: Mark Nelson; ceph-devel
> > > > > Subject: RE: Bluestore assert
> > > > >=20
> > > > > "compaction_style=3DkCompactionStyleUniversal"  in the bluestore_=
rocksdb_options .
> > > > > Here is the option I am using..
> > > > >=20
> > > > >         bluestore_rocksdb_options =3D "max_write_buffer_number=3D=
16,min_write_buffer_number_to_merge=3D2,recycle_log_file_num=3D16,compactio=
n_threads=3D32,flusher_threads=3D8,max_background_compactions=3D32,max_back=
ground_flushes=3D8,max_bytes_for_level_base=3D5368709120,write_buffer_size=
=3D83886080,level0_file_num_compaction_trigger=3D4,level0_slowdown_writes_t=
rigger=3D400,level0_stop_writes_trigger=3D800,stats_dump_period_sec=3D10,co=
mpaction_style=3DkCompactionStyleUniversal"
> > > > >=20
> > > > > Here is another one after 4 hours of 4K RW :-)...Sorry to bombard=
 you with all these , I am adding more log for the next time if I hit it..
> > > > >=20
> > > > >=20
> > > > >      0> 2016-08-22 17:37:24.730817 7f8e7afff700 -1
> > > > > os/bluestore/BlueFS.cc: In function 'int=20
> > > > > BlueFS::_read_random(BlueFS::FileReader*, uint64_t, size_t, char*=
)'
> > > > > thread 7f8e7afff700 time 2016-08-22 17:37:24.722706
> > > > > os/bluestore/BlueFS.cc: 845: FAILED assert(r =3D=3D 0)
> > > > >=20
> > > > >  ceph version 11.0.0-1688-g3fcc89c
> > > > > (3fcc89c7ab4c92e6c4564e29f4e1a663db36acc0)
> > > > >  1: (ceph::__ceph_assert_fail(char const*, char const*, int,=20
> > > > > char
> > > > > const*)+0x80) [0x5581ed453cb0]
> > > > >  2: (BlueFS::_read_random(BlueFS::FileReader*, unsigned long,=20
> > > > > unsigned long, char*)+0x836) [0x5581ed11c1b6]
> > > > >  3: (BlueRocksRandomAccessFile::Read(unsigned long, unsigned=20
> > > > > long, rocksdb::Slice*, char*) const+0x20) [0x5581ed13f840]
> > > > >  4: (rocksdb::RandomAccessFileReader::Read(unsigned long,=20
> > > > > unsigned long, rocksdb::Slice*, char*) const+0x83f)=20
> > > > > [0x5581ed2c6f4f]
> > > > >  5:=20
> > > > > (rocksdb::ReadBlockContents(rocksdb::RandomAccessFileReader*,
> > > > > rocksdb::Footer const&, rocksdb::ReadOptions const&,=20
> > > > > rocksdb::BlockHandle const&, rocksdb::BlockContents*,=20
> > > > > rocksdb::Env*, bool, rocksdb::Slice const&,=20
> > > > > rocksdb::PersistentCacheOptions const&,
> > > > > rocksdb::Logger*)+0x358) [0x5581ed291c18]
> > > > >  6: (()+0x94fd54) [0x5581ed282d54]
> > > > >  7:=20
> > > > > (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb::Block
> > > > > Ba se dT ab le::Rep*, rocksdb::ReadOptions const&,=20
> > > > > rocksdb::Slice const&,
> > > > > rocksdb::BlockIter*)+0x60c) [0x5581ed284b3c]
> > > > >  8: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions=20
> > > > > const&, rocksdb::Slice const&, rocksdb::GetContext*,=20
> > > > > bool)+0x508) [0x5581ed28ba68]
> > > > >  9: (rocksdb::TableCache::Get(rocksdb::ReadOptions const&,=20
> > > > > rocksdb::InternalKeyComparator const&, rocksdb::FileDescriptor=20
> > > > > const&, rocksdb::Slice const&, rocksdb::GetContext*,=20
> > > > > rocksdb::HistogramImpl*, bool, int)+0x158) [0x5581ed252118]
> > > > >  10: (rocksdb::Version::Get(rocksdb::ReadOptions const&,=20
> > > > > rocksdb::LookupKey const&, std::__cxx11::basic_string<char,=20
> > > > > std::char_traits<char>, std::allocator<char> >*,=20
> > > > > rocksdb::Status*, rocksdb::MergeContext*, bool*, bool*,=20
> > > > > unsigned
> > > > > long*)+0x4f8) [0x5581ed25c458]
> > > > >  11: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions const&,=20
> > > > > rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,=20
> > > > > std::__cxx11::basic_string<char, std::char_traits<char>,=20
> > > > > std::allocator<char> >*, bool*)+0x5fa) [0x5581ed1f3f7a]
> > > > >  12: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&,=20
> > > > > rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,=20
> > > > > std::__cxx11::basic_string<char, std::char_traits<char>,=20
> > > > > std::allocator<char> >*)+0x22) [0x5581ed1f4182]
> > > > >  13: (RocksDBStore::get(std::__cxx11::basic_string<char,
> > > > > std::char_traits<char>, std::allocator<char> > const&,=20
> > > > > std::__cxx11::basic_string<char, std::char_traits<char>,=20
> > > > > std::allocator<char> > const&, ceph::buffer::list*)+0x157)=20
> > > > > [0x5581ed1d21d7]
> > > > >  14: (BlueStore::Collection::get_onode(ghobject_t const&,
> > > > > bool)+0x55b) [0x5581ed02802b]
> > > > >  15:=20
> > > > > (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
> > > > > ObjectStore::Transaction*)+0x1e49) [0x5581ed0318a9]
> > > > >  16: (BlueStore::queue_transactions(ObjectStore::Sequencer*,
> > > > > std::vector<ObjectStore::Transaction,
> > > > > std::allocator<ObjectStore::Transaction> >&,=20
> > > > > std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x362)=20
> > > > > [0x5581ed032bc2]
> > > > >  17:=20
> > > > > (ReplicatedPG::queue_transactions(std::vector<ObjectStore::Tra
> > > > > ns ac ti on , std::allocator<ObjectStore::Transaction> >&,
> > > > > std::shared_ptr<OpRequest>)+0x81) [0x5581ecea5e51]
> > > > >  18:=20
> > > > > (ReplicatedBackend::sub_op_modify(std::shared_ptr<OpRequest>)+
> > > > > 0x
> > > > > d3
> > > > > 9)
> > > > > [0x5581ecef89e9]
> > > > >  19:=20
> > > > > (ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>)
> > > > > +0
> > > > > x2
> > > > > fb
> > > > > )
> > > > > [0x5581ecefeb4b]
> > > > >  20: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
> > > > > ThreadPool::TPHandle&)+0xbd) [0x5581ece4c63d]
> > > > >  21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
> > > > > std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x409)=20
> > > > > [0x5581eccdd2e9]
> > > > >  22:=20
> > > > > (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>
> > > > > const&)+0x52) [0x5581eccdd542]
> > > > >  23: (OSD::ShardedOpWQ::_process(unsigned int,
> > > > > ceph::heartbeat_handle_d*)+0x73f) [0x5581eccfd30f]
> > > > >  24: (ShardedThreadPool::shardedthreadpool_worker(unsigned
> > > > > int)+0x89f) [0x5581ed440b2f]
> > > > >  25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10)
> > > > > [0x5581ed4441f0]
> > > > >  26: (Thread::entry_wrapper()+0x75) [0x5581ed4335c5]
> > > > >  27: (()+0x76fa) [0x7f8ed9e4e6fa]
> > > > >  28: (clone()+0x6d) [0x7f8ed7caeb5d]
> > > > >  NOTE: a copy of the executable, or `objdump -rdS <executable>` i=
s needed to interpret this.
> > > > >=20
> > > > >=20
> > > > > Thanks & Regards
> > > > > Somnath
> > > > >=20
> > > > > -----Original Message-----
> > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > Sent: Monday, August 22, 2016 2:57 PM
> > > > > To: Somnath Roy
> > > > > Cc: Mark Nelson; ceph-devel
> > > > > Subject: RE: Bluestore assert
> > > > >=20
> > > > > On Mon, 22 Aug 2016, Somnath Roy wrote:
> > > > > > FYI, I was running rocksdb by enabling universal style=20
> > > > > > compaction during this time.
> > > > >=20
> > > > > How are you selecting universal compaction?
> > > > >=20
> > > > > sage
> > > > > PLEASE NOTE: The information contained in this electronic mail me=
ssage is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you are he=
reby notified that you have received this message in error and that any rev=
iew, dissemination, distribution, or copying of this message is strictly pr=
ohibited. If you have received this communication in error, please notify t=
he sender by telephone or e-mail (as shown above) immediately and destroy a=
ny and all copies of this message in your possession (whether hard copies o=
r electronically stored copies).
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"=20
> > > > > in the body of a message to majordomo@vger.kernel.org More=20
> > > > > majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > >=20
> > > > >=20
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"=20
> > > > in the body of a message to majordomo@vger.kernel.org More=20
> > > > majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > >=20
> > > >=20
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> > > in the body of a message to majordomo@vger.kernel.org More=20
> > > majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >=20
> > >=20
> >=20
> >=20
>=20
>=20
