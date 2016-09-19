From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: Bluestore OSD support in ceph-disk
Date: Mon, 19 Sep 2016 00:28:25 +0000
Message-ID: <77422969-34AC-4458-8040-4CB5265FECDB@Teradata.com>
References: <4459A44C-1336-4EC1-82F0-F491D0C83712@Teradata.com>
 <BL2PR02MB2115BE07E99958F8FA8E521CF4F10@BL2PR02MB2115.namprd02.prod.outlook.com>
 <0B017562-31CE-4C51-8ADB-997E5D59C1BF@Teradata.com>
 <C749C86B-A804-4566-9F63-B7B90E6E0891@Teradata.com>
 <alpine.DEB.2.11.1609151833290.19761@piezo.us.to>
 <BC30B826-3E63-4002-9436-60222C606E9F@Teradata.com>
 <alpine.DEB.2.11.1609151850330.19761@piezo.us.to>
 <E9BC8A1A-CFD4-4D1E-A719-FD3AD217607E@Teradata.com>
 <EA284BAD-1765-4600-92A9-32FF2BF098E9@Teradata.com>
 <BL2PR02MB21150C4B85B1897282432B86F4F30@BL2PR02MB2115.namprd02.prod.outlook.com>
 <E27159E7-FDEB-4075-B1B3-8C788D2CCA8C@Teradata.com>
 <BL2PR02MB21153BD658496CF33BD40CB8F4F30@BL2PR02MB2115.namprd02.prod.outlook.com>
 <3BA97D41-E3A1-404A-9FEE-41245D56D538@Teradata.com>
 <alpine.DEB.2.11.1609162053270.1040@piezo.us.to>
 <B3E46566-5536-4414-8A51-7223ABDA463E@Teradata.com>
 <BL2PR02MB2115227088E471EBE1188D4AF4F30@BL2PR02MB2115.namprd02.prod.outlook.com>
 <518C930B-0854-4C8E-8E8E-740D54C0613B@Teradata.com>
 <BN6PR02MB2628206336115829C46466BCE2F50@BN6PR02MB2628.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:38543 "EHLO
        rpc7279.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932541AbcISA22 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Sep 2016 20:28:28 -0400
In-Reply-To: <BN6PR02MB2628206336115829C46466BCE2F50@BN6PR02MB2628.namprd02.prod.outlook.com>
Content-Language: en-US
Content-ID: <A83514AFD40C934C98A4D3E1DB192448@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

I find the ceph-osd processes which are taking 100% cpu are all have common log last line.


It means the log rotation has triggered, and it takes forever to finish.
host5:~ # ls -lh /var/log/ceph/ceph-osd.24*
-rw-r----- 1 ceph ceph    0 Sep 18 17:00 /var/log/ceph/ceph-osd.24.log
-rw-r----- 1 ceph ceph 1.4G Sep 18 17:00 /var/log/ceph/ceph-osd.24.log-20160918

host5:~ # tail /var/log/ceph/ceph-osd.24.log-20160918
2016-09-18 11:36:18.292275 7fab858dc700 10 bluefs get_usage bdev 2 free 160031571968 (149 GB) / 160032612352 (149 GB), used 0%
2016-09-18 11:36:18.292279 7fab858dc700 10 bluefs _flush 0x7fac47a5dd00 ignoring, length 3310 < min_flush_size 65536
2016-09-18 11:36:18.292280 7fab858dc700 10 bluefs _flush 0x7fac47a5dd00 ignoring, length 3310 < min_flush_size 65536
2016-09-18 11:36:18.292281 7fab858dc700 10 bluefs _fsync 0x7fac47a5dd00 file(ino 24 size 0x3d7cdc5 mtime 2016-09-18 11:36:04.164949 bdev 0 extents [0:0xe100000+d00000,0:0xf200000+e00000,1:0x10000000+2100000,0:0x100000+200000])
2016-09-18 11:36:18.292286 7fab858dc700 10 bluefs _flush 0x7fac47a5dd00 0x1b10000~cee to file(ino 24 size 0x3d7cdc5 mtime 2016-09-18 11:36:04.164949 bdev 0 extents [0:0xe100000+d00000,0:0xf200000+e00000,1:0x10000000+2100000,0:0x100000+200000])
2016-09-18 11:36:18.292289 7fab858dc700 10 bluefs _flush_range 0x7fac47a5dd00 pos 0x1b10000 0x1b10000~cee to file(ino 24 size 0x3d7cdc5 mtime 2016-09-18 11:36:04.164949 bdev 0 extents [0:0xe100000+d00000,0:0xf200000+e00000,1:0x10000000+2100000,0:0x100000+200000])
2016-09-18 11:36:18.292292 7fab858dc700 20 bluefs _flush_range file now file(ino 24 size 0x3d7cdc5 mtime 2016-09-18 11:36:04.164949 bdev 0 extents [0:0xe100000+d00000,0:0xf200000+e00000,1:0x10000000+2100000,0:0x100000+200000])
2016-09-18 11:36:18.292296 7fab858dc700 20 bluefs _flush_range in 1:0x10000000+2100000 x_off 0x10000
2016-09-18 11:36:18.292297 7fab858dc700 20 bluefs _flush_range caching tail of 0xcee and padding block with zeros
2016-09-18 17:00:01.276990 7fab738b8700 -1 received  signal: Hangup from  PID: 89063 task name: killall -q -1 ceph-mon ceph-mds ceph-osd ceph-fuse radosgw  UID: 0

Further one of the osd process has crashed with this in the log:

2016-09-18 13:30:11.274012 7fdf399b8700 -1 /build/nitin/nightly_builds/20160914_125459-master/ceph.git/rpmbuild/BUILD/ceph-v11.0.0-2309.g9096ad3/src/os/bluestore/KernelDevice.cc: In function 'virtual void KernelDevice::aio_submit(IOContext*)' thread 7fdf399b8700 time 2016-09-18 13:30:11.270019
/build/nitin/nightly_builds/20160914_125459-master/ceph.git/rpmbuild/BUILD/ceph-v11.0.0-2309.g9096ad3/src/os/bluestore/KernelDevice.cc: 370: FAILED assert(r == 0)

 ceph version v11.0.0-2309-g9096ad3 (9096ad37f2c0798c26d7784fb4e7a781feb72cb8)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) [0x7fdf4f73811b]
 2: (KernelDevice::aio_submit(IOContext*)+0x76d) [0x7fdf4f597dbd]
 3: (BlueFS::_flush_range(BlueFS::FileWriter*, unsigned long, unsigned long)+0xcbd) [0x7fdf4f575b6d]
 4: (BlueFS::_flush(BlueFS::FileWriter*, bool)+0xe9) [0x7fdf4f576c79]
 5: (BlueFS::_fsync(BlueFS::FileWriter*, std::unique_lock<std::mutex>&)+0x6d) [0x7fdf4f579a6d]
 6: (BlueRocksWritableFile::Sync()+0x4e) [0x7fdf4f58f25e]
 7: (rocksdb::WritableFileWriter::SyncInternal(bool)+0x139) [0x7fdf4f686699]
 8: (rocksdb::WritableFileWriter::Sync(bool)+0x88) [0x7fdf4f687238]
 9: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool)+0x13cf) [0x7fdf4f5dea2f]
 10: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*)+0x27) [0x7fdf4f5df637]
 11: (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB::TransactionImpl>)+0x5b) [0x7fdf4f51814b]
 12: (BlueStore::_kv_sync_thread()+0xf5a) [0x7fdf4f4e5ffa]
 13: (BlueStore::KVSyncThread::entry()+0xd) [0x7fdf4f4f3a6d]
 14: (()+0x80a4) [0x7fdf4b7a50a4]
 15: (clone()+0x6d) [0x7fdf4a61e04d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

This time I have captured the log with debug bluefs = 20/20

Is there a good place where I can upload the trail of the log for sharing?

Thanks,
Nitin



