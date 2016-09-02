From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore assert
Date: Fri, 2 Sep 2016 16:11:06 +0000
Message-ID: <BL2PR02MB21153A76E39772A143A638EEF4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB2115443F5ACA3459E2CEBFBAF41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608112226280.17762@piezo.us.to>
 <BL2PR02MB2115BB77EA5BA38BCF48E52DF4110@BL2PR02MB2115.namprd02.prod.outlook.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:28400
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932357AbcIBQLI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Sep 2016 12:11:08 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sage,
Tried to do some analysis on the inode assert, following looks suspicious.

   -10> 2016-08-31 17:55:56.921075 7faf14fff700 10 bluefs _fsync 0x7faf1207=
5140 file(ino 693 size 0x19c2c265 mtime 2016-08-31 17:55:56.919038 bdev 1 e=
xtents [1:0x6e500000+100000,1:0x6e700000+100000,1:0x6ea00000+200000,1:0x6ed=
00000+200000,1:0x6f000000+200000,1:0x6f300000+200000,1:0x6f600000+200000,1:=
0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff00000+100000,1:0x70100000+2000=
00,1:0x70400000+200000,1:0x70700000+200000,1:0x70a00000+100000,1:0x70c00000=
+200000,1:0x70f00000+100000,1:0x71100000+200000,1:0x71400000+200000,1:0x717=
00000+200000,1:0x71a00000+100000,1:0x71c00000+100000,1:0x71e00000+100000,1:=
0x72000000+100000,1:0x72200000+200000,1:0x72500000+200000,1:0x72800000+1000=
00,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72f00000+100000,1:0x73100000=
+200000,1:0x73400000+100000,1:0x73600000+200000,1:0x73900000+200000,1:0x73c=
00000+200000,1:0x73f00000+200000,1:0x74300000+200000,1:0x74600000+200000,1:=
0x74900000+200000,1:0x74c00000+200000,1:0x74f00000+100000,1:0x75100000+1000=
00,1:0x75300000+100000,1:0x75600000+100000,1:0x75800000+100000,1:0x75a00000=
+200000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x76100000+100000,1:0x764=
00000+200000,1:0x76700000+200000,1:0x76a00000+300000,1:0x76e00000+200000,1:=
0x77100000+100000,1:0x77300000+100000,1:0x77500000+100000,1:0x77700000+3000=
00,1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000+100000,1:0x78300000=
+200000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c00000+100000,1:0x78e=
00000+100000,1:0x79000000+100000,1:0x79200000+100000,1:0x79400000+200000,1:=
0x79700000+100000,1:0x79900000+200000,1:0x79c00000+200000,1:0x79f00000+1000=
00,1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000+100000,1:0x7a900000=
+200000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b000000+100000,1:0x7b2=
00000+200000,1:0x7b500000+100000,1:0x7b800000+200000,1:0x7bb00000+100000,1:=
0x7bd00000+200000,1:0x7c000000+100000,1:0x7c200000+200000,1:0x7c500000+1000=
00,1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+100000,1:0x7ce00000=
+100000,1:0x7d000000+100000,1:0x7d200000+100000,1:0x7d400000+100000,1:0x7d6=
00000+100000,1:0x7d800000+10e00000])
    -9> 2016-08-31 17:55:56.921117 7faf14fff700 10 bluefs _flush 0x7faf1207=
5140 no dirty data on file(ino 693 size 0x19c2c265 mtime 2016-08-31 17:55:5=
6.919038 bdev 1 extents [1:0x6e500000+100000,1:0x6e700000+100000,1:0x6ea000=
00+200000,1:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000+200000,1:0x6=
f600000+200000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff00000+100000,=
1:0x70100000+200000,1:0x70400000+200000,1:0x70700000+200000,1:0x70a00000+10=
0000,1:0x70c00000+200000,1:0x70f00000+100000,1:0x71100000+200000,1:0x714000=
00+200000,1:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000+100000,1:0x7=
1e00000+100000,1:0x72000000+100000,1:0x72200000+200000,1:0x72500000+200000,=
1:0x72800000+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72f00000+10=
0000,1:0x73100000+200000,1:0x73400000+100000,1:0x73600000+200000,1:0x739000=
00+200000,1:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000+200000,1:0x7=
4600000+200000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f00000+100000,=
1:0x75100000+100000,1:0x75300000+100000,1:0x75600000+100000,1:0x75800000+10=
0000,1:0x75a00000+200000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x761000=
00+100000,1:0x76400000+200000,1:0x76700000+200000,1:0x76a00000+300000,1:0x7=
6e00000+200000,1:0x77100000+100000,1:0x77300000+100000,1:0x77500000+100000,=
1:0x77700000+300000,1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000+10=
0000,1:0x78300000+200000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c000=
00+100000,1:0x78e00000+100000,1:0x79000000+100000,1:0x79200000+100000,1:0x7=
9400000+200000,1:0x79700000+100000,1:0x79900000+200000,1:0x79c00000+200000,=
1:0x79f00000+100000,1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000+10=
0000,1:0x7a900000+200000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b0000=
00+100000,1:0x7b200000+200000,1:0x7b500000+100000,1:0x7b800000+200000,1:0x7=
bb00000+100000,1:0x7bd00000+200000,1:0x7c000000+100000,1:0x7c200000+200000,=
1:0x7c500000+100000,1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+10=
0000,1:0x7ce00000+100000,1:0x7d000000+100000,1:0x7d200000+100000,1:0x7d4000=
00+100000,1:0x7d600000+100000,1:0x7d800000+10e00000])
    -8> 2016-08-31 17:55:56.921137 7faf14fff700 10 bluefs wait_for_aio 0x7f=
af12075140
    -7> 2016-08-31 17:55:56.931541 7faf14fff700 10 bluefs wait_for_aio 0x7f=
af12075140 done in 0.010402
    -6> 2016-08-31 17:55:56.931551 7faf14fff700 20 bluefs _fsync file metad=
ata was dirty (31278) on file(ino 693 size 0x19c2c265 mtime 2016-08-31 17:5=
5:56.919038 bdev 1 extents [1:0x6e500000+100000,1:0x6e700000+100000,1:0x6ea=
00000+200000,1:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000+200000,1:=
0x6f600000+200000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff00000+1000=
00,1:0x70100000+200000,1:0x70400000+200000,1:0x70700000+200000,1:0x70a00000=
+100000,1:0x70c00000+200000,1:0x70f00000+100000,1:0x71100000+200000,1:0x714=
00000+200000,1:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000+100000,1:=
0x71e00000+100000,1:0x72000000+100000,1:0x72200000+200000,1:0x72500000+2000=
00,1:0x72800000+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72f00000=
+100000,1:0x73100000+200000,1:0x73400000+100000,1:0x73600000+200000,1:0x739=
00000+200000,1:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000+200000,1:=
0x74600000+200000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f00000+1000=
00,1:0x75100000+100000,1:0x75300000+100000,1:0x75600000+100000,1:0x75800000=
+100000,1:0x75a00000+200000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x761=
00000+100000,1:0x76400000+200000,1:0x76700000+200000,1:0x76a00000+300000,1:=
0x76e00000+200000,1:0x77100000+100000,1:0x77300000+100000,1:0x77500000+1000=
00,1:0x77700000+300000,1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000=
+100000,1:0x78300000+200000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c=
00000+100000,1:0x78e00000+100000,1:0x79000000+100000,1:0x79200000+100000,1:=
0x79400000+200000,1:0x79700000+100000,1:0x79900000+200000,1:0x79c00000+2000=
00,1:0x79f00000+100000,1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000=
+100000,1:0x7a900000+200000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b0=
00000+100000,1:0x7b200000+200000,1:0x7b500000+100000,1:0x7b800000+200000,1:=
0x7bb00000+100000,1:0x7bd00000+200000,1:0x7c000000+100000,1:0x7c200000+2000=
00,1:0x7c500000+100000,1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000=
+100000,1:0x7ce00000+100000,1:0x7d000000+100000,1:0x7d200000+100000,1:0x7d4=
00000+100000,1:0x7d600000+100000,1:0x7d800000+10e00000]), flushing log

The above looks good, it is about to call _flush_and_sync_log() after this.

    -5> 2016-08-31 17:55:56.931588 7faf14fff700 10 bluefs _flush_and_sync_l=
og txn(seq 31278 len 0x50e146 crc 0x58a6b9ab)
    -4> 2016-08-31 17:55:56.933951 7faf14fff700 10 bluefs _pad_bl padding w=
ith 0xe94 zeros
    -3> 2016-08-31 17:55:56.934079 7faf14fff700 20 bluefs flush_bdev
    -2> 2016-08-31 17:55:56.934257 7faf14fff700 10 bluefs _flush 0x7faf2e82=
4140 0xce9000~50f000 to file(ino 1 size 0xce9000 mtime 0.000000 bdev 0 exte=
nts [0:0xba00000+500000,0:0xfd00000+c00000])
    -1> 2016-08-31 17:55:56.934274 7faf14fff700 10 bluefs _flush_range 0x7f=
af2e824140 pos 0xce9000 0xce9000~50f000 to file(ino 1 size 0xce9000 mtime 0=
.000000 bdev 0 extents [0:0xba00000+500000,0:0xfd00000+c00000])
     0> 2016-08-31 17:55:56.939745 7faf14fff700 -1 os/bluestore/BlueFS.cc: =
In function 'int BlueFS::_flush_range(BlueFS::FileWriter*, uint64_t, uint64=
_t)' thread 7faf14fff700 time 2016-08-31 17:55:56.934282
os/bluestore/BlueFS.cc: 1390: FAILED assert(h->file->fnode.ino !=3D 1)

 ceph version 11.0.0-1946-g9a5cfe2 (9a5cfe2e8e8c79b976c34e593993d74b58fce88=
5)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0=
x80) [0x56073c27c7d0]
 2: (BlueFS::_flush_range(BlueFS::FileWriter*, unsigned long, unsigned long=
)+0x1d69) [0x56073bf4e109]
 3: (BlueFS::_flush(BlueFS::FileWriter*, bool)+0xa7) [0x56073bf4e2d7]
 4: (BlueFS::_flush_and_sync_log(std::unique_lock<std::mutex>&, unsigned lo=
ng, unsigned long)+0x443) [0x56073bf4fe13]
 5: (BlueFS::_fsync(BlueFS::FileWriter*, std::unique_lock<std::mutex>&)+0x3=
5b) [0x56073bf5140b]
 6: (BlueRocksWritableFile::Sync()+0x62) [0x56073bf68be2]
 7: (rocksdb::WritableFileWriter::SyncInternal(bool)+0x2d1) [0x56073c0f24b1=
]
 8: (rocksdb::WritableFileWriter::Sync(bool)+0xf0) [0x56073c0f3960]
 9: (rocksdb::CompactionJob::FinishCompactionOutputFile(rocksdb::Status con=
st&, rocksdb::CompactionJob::SubcompactionState*)+0x4e6) [0x56073c1354c6]
 10: (rocksdb::CompactionJob::ProcessKeyValueCompaction(rocksdb::Compaction=
Job::SubcompactionState*)+0x14ea) [0x56073c137c8a]
 11: (rocksdb::CompactionJob::Run()+0x479) [0x56073c138c09]
 12: (rocksdb::DBImpl::BackgroundCompaction(bool*, rocksdb::JobContext*, ro=
cksdb::LogBuffer*, void*)+0x9c0) [0x56073c0275d0]
 13: (rocksdb::DBImpl::BackgroundCallCompaction(void*)+0xbf) [0x56073c03443=
f]
 14: (rocksdb::ThreadPool::BGThread(unsigned long)+0x1d9) [0x56073c0eb039]
 15: (()+0x9900d3) [0x56073c0eb0d3]
 16: (()+0x76fa) [0x7faf3d1106fa]
 17: (clone()+0x6d) [0x7faf3af70b5d]


Now, as you can see it is calling _flush() with inode 1 , why ? is this exp=
ected ?

Question :
------------

1. Why we are using the existing log_write to do a runway check ?

https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueFS.cc#L1280

Shouldn't the log_writer needs to be reinitialed with the FileWriter rocksd=
b sent with sync call ?

2. The runway check is not considering the request length , so, why it is n=
ot expecting to allocate here (https://github.com/ceph/ceph/blob/master/src=
/os/bluestore/BlueFS.cc#L1388)

If the snippet is not sufficient, let me know if you want me to upload the =
level 10 log or need 20/20 log to proceed further.

Thanks & Regards
Somnath


-----Original Message-----
From: Somnath Roy=20
Sent: Thursday, September 01, 2016 3:59 PM
To: 'Sage Weil'
Cc: Mark Nelson; ceph-devel
Subject: RE: Bluestore assert

Sage,
Created the following pull request on rocksdb repo, please take a look.

https://github.com/facebook/rocksdb/pull/1313

The fix is working fine for me.

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Wednesday, August 31, 2016 6:20 AM
To: Somnath Roy
Cc: Mark Nelson; ceph-devel
Subject: RE: Bluestore assert

On Tue, 30 Aug 2016, Somnath Roy wrote:
> Sage,
> I did some debugging on the rocksdb bug., here is my findings.
>=20
> 1. The log file number is added to log_recycle_files and *not* in log_del=
ete_files from the following if loop, which is expected.
>=20
> https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698f46060
> 9bf7cea4b63/db/db_impl.cc#L854
>=20
> 2. But, it is there in the candidate list in the following loop.
>=20
> https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698f46060
> 9bf7cea4b63/db/db_impl.cc#L1000
>=20
>=20
> 3. This means it is added in full_scan_candidate_files from the=20
> following  from a full scan (?)
>=20
> https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698f46060
> 9bf7cea4b63/db/db_impl.cc#L834
>=20
> Added some log entries to verify , need to wait 6 hours :-(
>=20
> 4. Probably, #3 is not unusual , but the check in the following seems not=
 sufficient to keep the file.
>=20
> https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698f46060
> 9bf7cea4b63/db/db_impl.cc#L1013
>=20
> Again, added some log to see the state.log_number during that time. BTW, =
I have seen the following check probably noop as state.prev_log_number is a=
lways coming 0.
>=20
> (number =3D=3D state.prev_log_number)
>=20
> 5. So, the quick solution I am thinking is to put a check to see if the l=
og is in recycle list and avoid deleting from the above part (?).

That seems reasonable.  I suggest coding this up and submitting a PR to git=
hub.com/facebook/rocksdb, and ask in the comment if there is a better solut=
ion.

Probably the recycle list should be turned into a set so that the check is =
O(log n)...

Thanks!
sage


>=20
> Let me know what you think.
>=20
> Thanks & Regards
> Somnath
> -----Original Message-----
> From: Somnath Roy
> Sent: Sunday, August 28, 2016 7:37 AM
> To: 'Sage Weil'
> Cc: 'Mark Nelson'; 'ceph-devel'
> Subject: RE: Bluestore assert
>=20
> Sage,
> Some updates on this.
>=20
> 1. The issue is reproduced with the latest rocksdb master as well.
>=20
> 2. The issue is *not happening* if I run disabling rocksdb log recycling.=
 This proves our root cause is right.
>=20
> 3. Running some more performance tests by disabling log recycling , but, =
initial impression is, it is introducing spikes and output is not as stable=
 as enabling log recycling.
>=20
> 4. Created a rocksdb issue for this
> (https://github.com/facebook/rocksdb/issues/1303)
>=20
> Thanks & Regards
> Somnath
>=20
>=20
> -----Original Message-----
> From: Somnath Roy
> Sent: Thursday, August 25, 2016 2:35 PM
> To: 'Sage Weil'
> Cc: 'Mark Nelson'; 'ceph-devel'
> Subject: RE: Bluestore assert
>=20
> Sage,
> Hope you are able to download the log I shared via google doc.
> It seems the bug is around this portion.
>=20
> 2016-08-25 00:44:03.348710 7f7c117ff700  4 rocksdb: adding log 254 to=20
> recycle list
>=20
> 2016-08-25 00:44:03.348722 7f7c117ff700  4 rocksdb: adding log 256 to=20
> recycle list
>=20
> 2016-08-25 00:44:03.348725 7f7c117ff700  4 rocksdb: (Original Log Time
> 2016/08/25-00:44:03.347467) [default] Level-0 commit table #258=20
> started
> 2016-08-25 00:44:03.348727 7f7c117ff700  4 rocksdb: (Original Log Time
> 2016/08/25-00:44:03.348225) [default] Level-0 commit table #258:=20
> memtable #1 done
> 2016-08-25 00:44:03.348729 7f7c117ff700  4 rocksdb: (Original Log Time
> 2016/08/25-00:44:03.348227) [default] Level-0 commit table #258:=20
> memtable #2 done
> 2016-08-25 00:44:03.348730 7f7c117ff700  4 rocksdb: (Original Log Time
> 2016/08/25-00:44:03.348239) EVENT_LOG_v1 {"time_micros":=20
> 1472111043348233, "job": 88, "event": "flush_finished", "lsm_state":=20
> [3, 4, 0, 0, 0, 0, 0], "immutable_memtables": 0}
> 2016-08-25 00:44:03.348735 7f7c117ff700  4 rocksdb: (Original Log Time
> 2016/08/25-00:44:03.348297) [default] Level summary: base level 1 max=20
> bytes base 5368709120 files[3 4 0 0 0 0 0] max score 0.75
>=20
> 2016-08-25 00:44:03.348751 7f7c117ff700  4 rocksdb: [JOB 88] Try to delet=
e WAL files size 131512372, prev total WAL file size 131834601, number of l=
ive WAL files 3.
>=20
> 2016-08-25 00:44:03.348761 7f7c117ff700 10 bluefs unlink=20
> db.wal/000256.log
> 2016-08-25 00:44:03.348766 7f7c117ff700 20 bluefs _drop_link had refs
> 1 on file(ino 19 size 0x3f3ddd9 mtime 2016-08-25 00:41:26.298423 bdev
> 0 extents
> [0:0xc500000+200000,0:0xcb00000+800000,0:0xd700000+700000,0:0xe200000+
> 800000,0:0xee00000+800000,0:0xfa00000+800000,0:0x10600000+700000,0:0x1
> 1100000+700000,0:0x11c00000+800000,0:0x12800000+100000])
> 2016-08-25 00:44:03.348775 7f7c117ff700 20 bluefs _drop_link=20
> destroying file(ino 19 size 0x3f3ddd9 mtime 2016-08-25 00:41:26.298423=20
> bdev 0 extents=20
> [0:0xc500000+200000,0:0xcb00000+800000,0:0xd700000+700000,0:0xe200000+
> 800000,0:0xee00000+800000,0:0xfa00000+800000,0:0x10600000+700000,0:0x1
> 1100000+700000,0:0x11c00000+800000,0:0x12800000+100000])
> 2016-08-25 00:44:03.348794 7f7c117ff700 10 bluefs unlink=20
> db.wal/000254.log
> 2016-08-25 00:44:03.348796 7f7c117ff700 20 bluefs _drop_link had refs
> 1 on file(ino 18 size 0x3f3d402 mtime 2016-08-25 00:41:26.299110 bdev
> 0 extents
> [0:0x6500000+400000,0:0x6d00000+700000,0:0x7800000+800000,0:0x8400000+
> 800000,0:0x9000000+800000,0:0x9c00000+700000,0:0xa700000+900000,0:0xb4
> 00000+800000,0:0xc000000+500000])
> 2016-08-25 00:44:03.348803 7f7c117ff700 20 bluefs _drop_link=20
> destroying file(ino 18 size 0x3f3d402 mtime 2016-08-25 00:41:26.299110=20
> bdev 0 extents=20
> [0:0x6500000+400000,0:0x6d00000+700000,0:0x7800000+800000,0:0x8400000+
> 800000,0:0x9000000+800000,0:0x9c00000+700000,0:0xa700000+900000,0:0xb4
> 00000+800000,0:0xc000000+500000])
>=20
> So, log 254 is added to the recycle list and at the same time it is added=
 for deletion. It seems there is a race condition in this portion (?).
>=20
> I was going through the rocksdb code and I found the following.
>=20
> 1. DBImpl::FindObsoleteFiles is the one that is responsible for populatin=
g log_recycle_files and log_delete_files. It is also deleting entries from =
alive_log_files_. But, this is always under mutex_ lock.
>=20
> 2. Log is deleted from DBImpl::DeleteObsoleteFileImpl which is *not* unde=
r lock , but iterating over log_delete_files. This is fishy but it shouldn'=
t be the reason for same log number end up in two list.
>=20
> 3. I saw all the places but the following  place alive_log_files_ (within=
 DBImpl::WriteImpl)  is accessed without lock.
>=20
> 4625       alive_log_files_.back().AddSize(log_entry.size());  =20
>=20
> Can it be reintroducing the same log number (254) , I am not sure.
>=20
> Summary, it seems a rocksb bug and making recycle_log_file_num =3D 0 shou=
ld *bypass* that. I need to check the performance impact for this though.
>=20
> Should I post this to rocksdb community or any other place from where I c=
an get response from rocksdb folks ?
>=20
> Thanks & Regards
> Somnath
>=20
>=20
> -----Original Message-----
> From: Somnath Roy
> Sent: Wednesday, August 24, 2016 2:52 PM
> To: 'Sage Weil'
> Cc: Mark Nelson; ceph-devel
> Subject: RE: Bluestore assert
>=20
> Sage,
> Thanks for looking , glad that we figured out something :-)..
> So, you want me to reproduce this with only debug_bluefs =3D 20/20 ? Don'=
t need bluestore log ?
> Hope my root partition doesn't get full , this crash happened after 6=20
> hours :-) ,
>=20
> Thanks & Regards
> Somnath
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Wednesday, August 24, 2016 2:34 PM
> To: Somnath Roy
> Cc: Mark Nelson; ceph-devel
> Subject: RE: Bluestore assert
>=20
> On Wed, 24 Aug 2016, Somnath Roy wrote:
> > Sage, It is there in the following github link I posted earlier..You=20
> > can see 3 logs there..
> >=20
> > https://github.com/somnathr/ceph/commit/b69811eb2b87f25cf017b39c687d
> > 88
> > a1b28fcc39
>=20
> Ah sorry, got it.
>=20
> And looking at the crash and code the weird error you're getting makes pe=
rfect sense: it's coming from the ReuseWritableFile() function (which gets =
and error on rename and returns that).  It shouldn't ever fail, so there is=
 either a bug in the bluefs code or the rocksdb recycling code.
>=20
> I think we need a full bluefs log leading up to the crash so we can find =
out what happened to the file that is missing...
>=20
> sage
>=20
>=20
>=20
>  >
> > Thanks & Regards
> > Somnath
> >=20
> >=20
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Wednesday, August 24, 2016 1:43 PM
> > To: Somnath Roy
> > Cc: Mark Nelson; ceph-devel
> > Subject: RE: Bluestore assert
> >=20
> > On Wed, 24 Aug 2016, Somnath Roy wrote:
> > > Sage,
> > > I got the db assert log from submit_transaction in the following loca=
tion.
> > >=20
> > > https://github.com/somnathr/ceph/commit/b69811eb2b87f25cf017b39c68
> > > 7d
> > > 88
> > > a1b28fcc39
> > >=20
> > > This is the log with level 1/20 and with my hook of printing rocksdb:=
:writebatch transaction. I have uploaded 3 osd logs and a common pattern be=
fore crash is the following.
> > >=20
> > >    -34> 2016-08-24 02:37:22.074321 7ff151fff700  4 rocksdb:=20
> > > reusing log 266 from recycle list
> > >=20
> > >    -33> 2016-08-24 02:37:22.074332 7ff151fff700 10 bluefs rename db.w=
al/000266.log -> db.wal/000271.log
> > >    -32> 2016-08-24 02:37:22.074338 7ff151fff700 20 bluefs rename dir =
db.wal (0x7ff18bdfdec0) file 000266.log not found
> > >    -31> 2016-08-24 02:37:22.074341 7ff151fff700  4 rocksdb: [default]=
 New memtable created with log file: #271. Immutable memtables: 0.
> > >=20
> > > It is trying to rename the wal file it seems and old file is not foun=
d. You can see the transaction printed in the log along with error code lik=
e this.
> >=20
> > How much of the log do you have? Can you post what you have somewhere?
> >=20
> > Thanks!
> > sage
> >=20
> >=20
> > >=20
> > >    -30> 2016-08-24 02:37:22.074486 7ff151fff700 -1 rocksdb:=20
> > > submit_transaction error: NotFound:  code =3D 1 rocksdb::WriteBatch=20
> > > =3D Put( Prefix =3D M key =3D
> > > 0x0000000000001483'.0000000087.00000000000000035303')
> > > Put( Prefix =3D M key =3D 0x0000000000001483'._info') Put( Prefix =3D=
 O=20
> > > key =3D
> > > '--'0x800000000000000137863de5'.!=3Drbd_data.105b6b8b4567.0000000000
> > > 89
> > > ac
> > > e7!'0xfffffffffffffffeffffffffffffffff)
> > > Delete( Prefix =3D B key =3D 0x000004e73ae72000) Put( Prefix =3D B ke=
y =3D
> > > 0x000004e73af72000) Merge( Prefix =3D T key =3D 'bluestore_statfs')
> > >=20
> > > Hope my decoding of the key is proper, I have reused pretty_binary_st=
ring() of Bluestore after removing 1st 2 bytes of the key which is prefix a=
nd a '0'.
> > >=20
> > > Any suggestion on the next step of root causing this db assert if log=
 rename is not enough hint ?
> > >=20
> > > BTW, I ran this time with bluefs_compact_log_sync =3D true and withou=
t commenting the inode number asserts. I didn't hit those asserts as well a=
s no corruption  so far. Seems like bug of async compaction. Will try to re=
produce with verbose log that one later.
> > >=20
> > > Thanks & Regards
> > > Somnath
> > >=20
> > > -----Original Message-----
> > > From: Somnath Roy
> > > Sent: Tuesday, August 23, 2016 7:46 AM
> > > To: 'Sage Weil'
> > > Cc: Mark Nelson; ceph-devel
> > > Subject: RE: Bluestore assert
> > >=20
> > > I was running my tests for 2 hours and it happened within that time.
> > > I will try to reproduce with 1/20.
> > >=20
> > > Thanks & Regards
> > > Somnath
> > >=20
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sweil@redhat.com]
> > > Sent: Tuesday, August 23, 2016 6:46 AM
> > > To: Somnath Roy
> > > Cc: Mark Nelson; ceph-devel
> > > Subject: RE: Bluestore assert
> > >=20
> > > On Mon, 22 Aug 2016, Somnath Roy wrote:
> > > > Sage,
> > > > I think there are some bug introduced recently in the BlueFS and=20
> > > > I am getting the corruption like this which I was not facing earlie=
r.
> > >=20
> > > My guess is the async bluefs compaction.  You can set 'bluefs compact=
 log sync =3D true' to disable it.
> > >=20
> > > Any idea how long do you have to run to reproduce?  I'd love to see a=
 bluefs log leading up to it.  If it eats too much disk space, you could do=
 debug bluefs =3D 1/20 so that it only dumps recent history on crash.
> > >=20
> > > Thanks!
> > > sage
> > >=20
> > > >=20
> > > >    -5> 2016-08-22 15:55:21.248558 7fb68f7ff700  4 rocksdb: EVENT_LO=
G_v1 {"time_micros": 1471906521248538, "job": 3, "event": "compaction_start=
ed", "files_L0": [2115, 2102, 2087, 2069, 2046], "files_L1": [], "files_L2"=
: [], "files_L3": [], "files_L4": [], "files_L5": [], "files_L6": [1998, 20=
07, 2013, 2019, 2026, 2032, 2039, 2043, 2052, 2060], "score": 1.5, "input_d=
ata_size": 1648188401}
> > > >     -4> 2016-08-22 15:55:27.209944 7fb6ba94d8c0  0 <cls> cls/hello/=
cls_hello.cc:305: loading cls_hello
> > > >     -3> 2016-08-22 15:55:27.213612 7fb6ba94d8c0  0 <cls> cls/cephfs=
/cls_cephfs.cc:202: loading cephfs_size_scan
> > > >     -2> 2016-08-22 15:55:27.213627 7fb6ba94d8c0  0 _get_class not p=
ermitted to load kvs
> > > >     -1> 2016-08-22 15:55:27.214620 7fb6ba94d8c0 -1 osd.0 0 failed t=
o load OSD map for epoch 321, got 0 bytes
> > > >      0> 2016-08-22 15:55:27.216111 7fb6ba94d8c0 -1 osd/OSD.h: In=20
> > > > function 'OSDMapRef OSDService::get_map(epoch_t)' thread
> > > > 7fb6ba94d8c0 time 2016-08-22 15:55:27.214638
> > > > osd/OSD.h: 999: FAILED assert(ret)
> > > >=20
> > > >  ceph version 11.0.0-1688-g6f48ee6
> > > > (6f48ee6bc5c85f44d7ca4c984f9bef1339c2bea4)
> > > >  1: (ceph::__ceph_assert_fail(char const*, char const*, int,=20
> > > > char
> > > > const*)+0x80) [0x5617f2a99e80]
> > > >  2: (OSDService::get_map(unsigned int)+0x5d) [0x5617f2395fdd]
> > > >  3: (OSD::init()+0x1f7e) [0x5617f233d3ce]
> > > >  4: (main()+0x2fe0) [0x5617f229d1f0]
> > > >  5: (__libc_start_main()+0xf0) [0x7fb6b7196830]
> > > >  6: (_start()+0x29) [0x5617f22eb909]
> > > >=20
> > > > OSDs are not coming up (after a restart) and eventually I had to re=
create the cluster.
> > > >=20
> > > > Thanks & Regards
> > > > Somnath
> > > >=20
> > > > -----Original Message-----
> > > > From: Somnath Roy
> > > > Sent: Monday, August 22, 2016 3:01 PM
> > > > To: 'Sage Weil'
> > > > Cc: Mark Nelson; ceph-devel
> > > > Subject: RE: Bluestore assert
> > > >=20
> > > > "compaction_style=3DkCompactionStyleUniversal"  in the bluestore_ro=
cksdb_options .
> > > > Here is the option I am using..
> > > >=20
> > > >         bluestore_rocksdb_options =3D "max_write_buffer_number=3D16=
,min_write_buffer_number_to_merge=3D2,recycle_log_file_num=3D16,compaction_=
threads=3D32,flusher_threads=3D8,max_background_compactions=3D32,max_backgr=
ound_flushes=3D8,max_bytes_for_level_base=3D5368709120,write_buffer_size=3D=
83886080,level0_file_num_compaction_trigger=3D4,level0_slowdown_writes_trig=
ger=3D400,level0_stop_writes_trigger=3D800,stats_dump_period_sec=3D10,compa=
ction_style=3DkCompactionStyleUniversal"
> > > >=20
> > > > Here is another one after 4 hours of 4K RW :-)...Sorry to bombard y=
ou with all these , I am adding more log for the next time if I hit it..
> > > >=20
> > > >=20
> > > >      0> 2016-08-22 17:37:24.730817 7f8e7afff700 -1
> > > > os/bluestore/BlueFS.cc: In function 'int=20
> > > > BlueFS::_read_random(BlueFS::FileReader*, uint64_t, size_t, char*)'
> > > > thread 7f8e7afff700 time 2016-08-22 17:37:24.722706
> > > > os/bluestore/BlueFS.cc: 845: FAILED assert(r =3D=3D 0)
> > > >=20
> > > >  ceph version 11.0.0-1688-g3fcc89c
> > > > (3fcc89c7ab4c92e6c4564e29f4e1a663db36acc0)
> > > >  1: (ceph::__ceph_assert_fail(char const*, char const*, int,=20
> > > > char
> > > > const*)+0x80) [0x5581ed453cb0]
> > > >  2: (BlueFS::_read_random(BlueFS::FileReader*, unsigned long,=20
> > > > unsigned long, char*)+0x836) [0x5581ed11c1b6]
> > > >  3: (BlueRocksRandomAccessFile::Read(unsigned long, unsigned=20
> > > > long, rocksdb::Slice*, char*) const+0x20) [0x5581ed13f840]
> > > >  4: (rocksdb::RandomAccessFileReader::Read(unsigned long,=20
> > > > unsigned long, rocksdb::Slice*, char*) const+0x83f)=20
> > > > [0x5581ed2c6f4f]
> > > >  5:=20
> > > > (rocksdb::ReadBlockContents(rocksdb::RandomAccessFileReader*,
> > > > rocksdb::Footer const&, rocksdb::ReadOptions const&,=20
> > > > rocksdb::BlockHandle const&, rocksdb::BlockContents*,=20
> > > > rocksdb::Env*, bool, rocksdb::Slice const&,=20
> > > > rocksdb::PersistentCacheOptions const&,
> > > > rocksdb::Logger*)+0x358) [0x5581ed291c18]
> > > >  6: (()+0x94fd54) [0x5581ed282d54]
> > > >  7:=20
> > > > (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb::BlockBa
> > > > se dT ab le::Rep*, rocksdb::ReadOptions const&, rocksdb::Slice=20
> > > > const&,
> > > > rocksdb::BlockIter*)+0x60c) [0x5581ed284b3c]
> > > >  8: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions const&,=20
> > > > rocksdb::Slice const&, rocksdb::GetContext*, bool)+0x508)=20
> > > > [0x5581ed28ba68]
> > > >  9: (rocksdb::TableCache::Get(rocksdb::ReadOptions const&,=20
> > > > rocksdb::InternalKeyComparator const&, rocksdb::FileDescriptor=20
> > > > const&, rocksdb::Slice const&, rocksdb::GetContext*,=20
> > > > rocksdb::HistogramImpl*, bool, int)+0x158) [0x5581ed252118]
> > > >  10: (rocksdb::Version::Get(rocksdb::ReadOptions const&,=20
> > > > rocksdb::LookupKey const&, std::__cxx11::basic_string<char,=20
> > > > std::char_traits<char>, std::allocator<char> >*,=20
> > > > rocksdb::Status*, rocksdb::MergeContext*, bool*, bool*, unsigned
> > > > long*)+0x4f8) [0x5581ed25c458]
> > > >  11: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions const&,=20
> > > > rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,=20
> > > > std::__cxx11::basic_string<char, std::char_traits<char>,=20
> > > > std::allocator<char> >*, bool*)+0x5fa) [0x5581ed1f3f7a]
> > > >  12: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&,=20
> > > > rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,=20
> > > > std::__cxx11::basic_string<char, std::char_traits<char>,=20
> > > > std::allocator<char> >*)+0x22) [0x5581ed1f4182]
> > > >  13: (RocksDBStore::get(std::__cxx11::basic_string<char,
> > > > std::char_traits<char>, std::allocator<char> > const&,=20
> > > > std::__cxx11::basic_string<char, std::char_traits<char>,=20
> > > > std::allocator<char> > const&, ceph::buffer::list*)+0x157)=20
> > > > [0x5581ed1d21d7]
> > > >  14: (BlueStore::Collection::get_onode(ghobject_t const&,
> > > > bool)+0x55b) [0x5581ed02802b]
> > > >  15: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
> > > > ObjectStore::Transaction*)+0x1e49) [0x5581ed0318a9]
> > > >  16: (BlueStore::queue_transactions(ObjectStore::Sequencer*,
> > > > std::vector<ObjectStore::Transaction,
> > > > std::allocator<ObjectStore::Transaction> >&,=20
> > > > std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x362)=20
> > > > [0x5581ed032bc2]
> > > >  17:=20
> > > > (ReplicatedPG::queue_transactions(std::vector<ObjectStore::Trans
> > > > ac ti on , std::allocator<ObjectStore::Transaction> >&,
> > > > std::shared_ptr<OpRequest>)+0x81) [0x5581ecea5e51]
> > > >  18:=20
> > > > (ReplicatedBackend::sub_op_modify(std::shared_ptr<OpRequest>)+0x
> > > > d3
> > > > 9)
> > > > [0x5581ecef89e9]
> > > >  19:=20
> > > > (ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>)+0
> > > > x2
> > > > fb
> > > > )
> > > > [0x5581ecefeb4b]
> > > >  20: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
> > > > ThreadPool::TPHandle&)+0xbd) [0x5581ece4c63d]
> > > >  21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
> > > > std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x409)=20
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
> > > >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.
> > > >=20
> > > >=20
> > > > Thanks & Regards
> > > > Somnath
> > > >=20
> > > > -----Original Message-----
> > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > Sent: Monday, August 22, 2016 2:57 PM
> > > > To: Somnath Roy
> > > > Cc: Mark Nelson; ceph-devel
> > > > Subject: RE: Bluestore assert
> > > >=20
> > > > On Mon, 22 Aug 2016, Somnath Roy wrote:
> > > > > FYI, I was running rocksdb by enabling universal style=20
> > > > > compaction during this time.
> > > >=20
> > > > How are you selecting universal compaction?
> > > >=20
> > > > sage
> > > > PLEASE NOTE: The information contained in this electronic mail mess=
age is intended only for the use of the designated recipient(s) named above=
. If the reader of this message is not the intended recipient, you are here=
by notified that you have received this message in error and that any revie=
w, dissemination, distribution, or copying of this message is strictly proh=
ibited. If you have received this communication in error, please notify the=
 sender by telephone or e-mail (as shown above) immediately and destroy any=
 and all copies of this message in your possession (whether hard copies or =
electronically stored copies).
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
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> > in the body of a message to majordomo@vger.kernel.org More majordomo=20
> > info at  http://vger.kernel.org/majordomo-info.html
> >=20
> >=20
>=20
>=20
