From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: Bluestore OSD support in ceph-disk
Date: Mon, 19 Sep 2016 05:24:02 +0000
Message-ID: <D0AE157A-6091-49E1-81F6-F2C515569038@Teradata.com>
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
 <77422969-34AC-4458-8040-4CB5265FECDB@Teradata.com>
 <MWHPR02MB2639FB271F3C2C44547B448AE2F40@MWHPR02MB2639.namprd02.prod.outlook.com>
 <BL2PR02MB211579DFFC8D3FB45EF005D1F4F40@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:38667 "EHLO
        rpc7279.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932557AbcISFYG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 01:24:06 -0400
In-Reply-To: <BL2PR02MB211579DFFC8D3FB45EF005D1F4F40@BL2PR02MB2115.namprd02.prod.outlook.com>
Content-Language: en-US
Content-ID: <C1A618C3443CEA4AB7C759518605D535@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Varada Kari <Varada.Kari@sandisk.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>


> On Sep 18, 2016, at 8:25 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> 
> The crash Nitin is getting is different. I think it could be related to aio limit of the Linux/disk. Check the device nr_requests and queue_depth settings. If it is related to Linux (syslog should be having that if I can recall), increase fs.aio-max-nr.
> There should be an error string printed in the log before assert. Search with " aio submit got" in the ceph-osd.<num>.log.
> 
> Thanks & Regards
> Somnath

Here is further information if it helps in understanding the assert.

host4:/ # cat /proc/sys/fs/aio-max-nr 
65536
host4:/ # cat /sys/block/sdk/device/queue_depth 
256
host4:/ # cat /sys/block/sdk/queue/nr_requests 
128

As seen below, there is an "aio submit got" error just before the assert.
I did not find anything related in dmesg

2016-09-18 13:30:11.011673 7fdf399b8700 20 bluefs _flush_range in 0:0xdd00000+400000 x_off 0x3ec257
2016-09-18 13:30:11.011674 7fdf399b8700 20 bluefs _flush_range using partial tail 0x257
2016-09-18 13:30:11.011676 7fdf399b8700 20 bluefs _flush_range waiting for previous aio to complete
2016-09-18 13:30:11.011711 7fdf399b8700 20 bluefs _flush_range h 0x7fe026503400 pos now 0x3c00000
2016-09-18 13:30:11.011732 7fdf399b8700 10 bluefs _flush 0x7fe026503400 ignoring, length 15358 < min_flush_size 65536
2016-09-18 13:30:11.011932 7fdf399b8700 10 bluefs get_usage bdev 0 free 41943040 (40960 kB) / 268431360 (255 MB), used 84%
2016-09-18 13:30:11.011935 7fdf399b8700 10 bluefs get_usage bdev 1 free 77204553728 (73628 MB) / 79456886784 (75775 MB), used 2%
2016-09-18 13:30:11.011938 7fdf399b8700 10 bluefs get_usage bdev 2 free 160031571968 (149 GB) / 160032612352 (149 GB), used 0%
2016-09-18 13:30:11.011940 7fdf399b8700 10 bluefs _flush 0x7fe026503400 ignoring, length 15381 < min_flush_size 65536
2016-09-18 13:30:11.011941 7fdf399b8700 10 bluefs _flush 0x7fe026503400 ignoring, length 15381 < min_flush_size 65536
2016-09-18 13:30:11.011942 7fdf399b8700 10 bluefs _fsync 0x7fe026503400 file(ino 23 size 0x3d2a7de mtime 2016-09-18 13:28:24.844259 bdev 0 extents [0:0x9500000+100000,0:0x9a00000+1200000,0:0xb000000+1300000,0:0xc700000+1200000,0:0xdd00000+400000,1:0xe100000+200000])
2016-09-18 13:30:11.011946 7fdf399b8700 10 bluefs _flush 0x7fe026503400 0x3c00000~3c15 to file(ino 23 size 0x3d2a7de mtime 2016-09-18 13:28:24.844259 bdev 0 extents [0:0x9500000+100000,0:0x9a00000+1200000,0:0xb000000+1300000,0:0xc700000+1200000,0:0xdd00000+400000,1:0xe100000+200000])
2016-09-18 13:30:11.011949 7fdf399b8700 10 bluefs _flush_range 0x7fe026503400 pos 0x3c00000 0x3c00000~3c15 to file(ino 23 size 0x3d2a7de mtime 2016-09-18 13:28:24.844259 bdev 0 extents [0:0x9500000+100000,0:0x9a00000+1200000,0:0xb000000+1300000,0:0xc700000+1200000,0:0xdd00000+400000,1:0xe100000+200000])
2016-09-18 13:30:11.011953 7fdf399b8700 20 bluefs _flush_range file now file(ino 23 size 0x3d2a7de mtime 2016-09-18 13:28:24.844259 bdev 0 extents [0:0x9500000+100000,0:0x9a00000+1200000,0:0xb000000+1300000,0:0xc700000+1200000,0:0xdd00000+400000,1:0xe100000+200000])
2016-09-18 13:30:11.011956 7fdf399b8700 20 bluefs _flush_range in 1:0xe100000+200000 x_off 0x0
2016-09-18 13:30:11.011958 7fdf399b8700 20 bluefs _flush_range caching tail of 0xc15 and padding block with zeros
2016-09-18 13:30:11.270003 7fdf399b8700 -1 bdev(/var/lib/ceph/osd/ceph-18/block.wal)  aio submit got (9) Bad file descriptor
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

Thanks,
Nitin


> 
> -----Original Message-----
> From: Varada Kari
> Sent: Sunday, September 18, 2016 6:59 PM
> To: Kamble, Nitin A
> Cc: Somnath Roy; Sage Weil; Ceph Development
> Subject: Re: Bluestore OSD support in ceph-disk
> 
> If you are not running with latest master, could you please retry with latest master. https://github.com/ceph/ceph/pull/11095 should solve the problem.
> 
> if you are hitting the problem with the latest master, please post the logs in shared location like google drive or pastebin etc...
> 
> Varada
> 
> On Monday 19 September 2016 05:58 AM, Kamble, Nitin A wrote:
>> I find the ceph-osd processes which are taking 100% cpu are all have common log last line.
>> 
>> 
>> It means the log rotation has triggered, and it takes forever to finish.
>> host5:~ # ls -lh /var/log/ceph/ceph-osd.24*
>> -rw-r----- 1 ceph ceph    0 Sep 18 17:00 /var/log/ceph/ceph-osd.24.log
>> -rw-r----- 1 ceph ceph 1.4G Sep 18 17:00
>> /var/log/ceph/ceph-osd.24.log-20160918
>> 
>> host5:~ # tail /var/log/ceph/ceph-osd.24.log-20160918
>> 2016-09-18 11:36:18.292275 7fab858dc700 10 bluefs get_usage bdev 2
>> free 160031571968 (149 GB) / 160032612352 (149 GB), used 0%
>> 2016-09-18 11:36:18.292279 7fab858dc700 10 bluefs _flush
>> 0x7fac47a5dd00 ignoring, length 3310 < min_flush_size 65536
>> 2016-09-18 11:36:18.292280 7fab858dc700 10 bluefs _flush
>> 0x7fac47a5dd00 ignoring, length 3310 < min_flush_size 65536
>> 2016-09-18 11:36:18.292281 7fab858dc700 10 bluefs _fsync
>> 0x7fac47a5dd00 file(ino 24 size 0x3d7cdc5 mtime 2016-09-18
>> 11:36:04.164949 bdev 0 extents
>> [0:0xe100000+d00000,0:0xf200000+e00000,1:0x10000000+2100000,0:0x100000
>> +200000])
>> 2016-09-18 11:36:18.292286 7fab858dc700 10 bluefs _flush
>> 0x7fac47a5dd00 0x1b10000~cee to file(ino 24 size 0x3d7cdc5 mtime
>> 2016-09-18 11:36:04.164949 bdev 0 extents
>> [0:0xe100000+d00000,0:0xf200000+e00000,1:0x10000000+2100000,0:0x100000
>> +200000])
>> 2016-09-18 11:36:18.292289 7fab858dc700 10 bluefs _flush_range
>> 0x7fac47a5dd00 pos 0x1b10000 0x1b10000~cee to file(ino 24 size
>> 0x3d7cdc5 mtime 2016-09-18 11:36:04.164949 bdev 0 extents
>> [0:0xe100000+d00000,0:0xf200000+e00000,1:0x10000000+2100000,0:0x100000
>> +200000])
>> 2016-09-18 11:36:18.292292 7fab858dc700 20 bluefs _flush_range file
>> now file(ino 24 size 0x3d7cdc5 mtime 2016-09-18 11:36:04.164949 bdev 0
>> extents
>> [0:0xe100000+d00000,0:0xf200000+e00000,1:0x10000000+2100000,0:0x100000
>> +200000])
>> 2016-09-18 11:36:18.292296 7fab858dc700 20 bluefs _flush_range in
>> 1:0x10000000+2100000 x_off 0x10000
>> 2016-09-18 11:36:18.292297 7fab858dc700 20 bluefs _flush_range caching
>> tail of 0xcee and padding block with zeros
>> 2016-09-18 17:00:01.276990 7fab738b8700 -1 received  signal: Hangup
>> from  PID: 89063 task name: killall -q -1 ceph-mon ceph-mds ceph-osd
>> ceph-fuse radosgw  UID: 0
>> 
>> Further one of the osd process has crashed with this in the log:
>> 
>> 2016-09-18 13:30:11.274012 7fdf399b8700 -1
>> /build/nitin/nightly_builds/20160914_125459-master/ceph.git/rpmbuild/B
>> UILD/ceph-v11.0.0-2309.g9096ad3/src/os/bluestore/KernelDevice.cc: In
>> function 'virtual void KernelDevice::aio_submit(IOContext*)' thread
>> 7fdf399b8700 time 2016-09-18 13:30:11.270019
>> /build/nitin/nightly_builds/20160914_125459-master/ceph.git/rpmbuild/B
>> UILD/ceph-v11.0.0-2309.g9096ad3/src/os/bluestore/KernelDevice.cc: 370:
>> FAILED assert(r == 0)
>> 
>> ceph version v11.0.0-2309-g9096ad3
>> (9096ad37f2c0798c26d7784fb4e7a781feb72cb8)
>> 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x8b) [0x7fdf4f73811b]
>> 2: (KernelDevice::aio_submit(IOContext*)+0x76d) [0x7fdf4f597dbd]
>> 3: (BlueFS::_flush_range(BlueFS::FileWriter*, unsigned long, unsigned
>> long)+0xcbd) [0x7fdf4f575b6d]
>> 4: (BlueFS::_flush(BlueFS::FileWriter*, bool)+0xe9) [0x7fdf4f576c79]
>> 5: (BlueFS::_fsync(BlueFS::FileWriter*,
>> std::unique_lock<std::mutex>&)+0x6d) [0x7fdf4f579a6d]
>> 6: (BlueRocksWritableFile::Sync()+0x4e) [0x7fdf4f58f25e]
>> 7: (rocksdb::WritableFileWriter::SyncInternal(bool)+0x139)
>> [0x7fdf4f686699]
>> 8: (rocksdb::WritableFileWriter::Sync(bool)+0x88) [0x7fdf4f687238]
>> 9: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&,
>> rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*,
>> unsigned long, bool)+0x13cf) [0x7fdf4f5dea2f]
>> 10: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&,
>> rocksdb::WriteBatch*)+0x27) [0x7fdf4f5df637]
>> 11:
>> (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB::Tra
>> nsactionImpl>)+0x5b) [0x7fdf4f51814b]
>> 12: (BlueStore::_kv_sync_thread()+0xf5a) [0x7fdf4f4e5ffa]
>> 13: (BlueStore::KVSyncThread::entry()+0xd) [0x7fdf4f4f3a6d]
>> 14: (()+0x80a4) [0x7fdf4b7a50a4]
>> 15: (clone()+0x6d) [0x7fdf4a61e04d]
>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>> 
>> This time I have captured the log with debug bluefs = 20/20
>> 
>> Is there a good place where I can upload the trail of the log for sharing?
>> 
>> Thanks,
>> Nitin
>> 
>> 
>> 
>> 
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

