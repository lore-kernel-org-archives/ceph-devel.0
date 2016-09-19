From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: Bluestore OSD support in ceph-disk
Date: Mon, 19 Sep 2016 01:58:42 +0000
Message-ID: <MWHPR02MB2639FB271F3C2C44547B448AE2F40@MWHPR02MB2639.namprd02.prod.outlook.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0051.outbound.protection.outlook.com ([104.47.42.51]:63049
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936003AbcISB6p (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 18 Sep 2016 21:58:45 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

If you are not running with latest master, could you please retry with
latest master. https://github.com/ceph/ceph/pull/11095 should solve the
problem.

if you are hitting the problem with the latest master, please post the
logs in shared location like google drive or pastebin etc...

Varada

On Monday 19 September 2016 05:58 AM, Kamble, Nitin A wrote:
> I find the ceph-osd processes which are taking 100% cpu are all have comm=
on log last line.
>
>
> It means the log rotation has triggered, and it takes forever to finish.
> host5:~ # ls -lh /var/log/ceph/ceph-osd.24*
> -rw-r----- 1 ceph ceph    0 Sep 18 17:00 /var/log/ceph/ceph-osd.24.log
> -rw-r----- 1 ceph ceph 1.4G Sep 18 17:00 /var/log/ceph/ceph-osd.24.log-20=
160918
>
> host5:~ # tail /var/log/ceph/ceph-osd.24.log-20160918
> 2016-09-18 11:36:18.292275 7fab858dc700 10 bluefs get_usage bdev 2 free 1=
60031571968 (149 GB) / 160032612352 (149 GB), used 0%
> 2016-09-18 11:36:18.292279 7fab858dc700 10 bluefs _flush 0x7fac47a5dd00 i=
gnoring, length 3310 < min_flush_size 65536
> 2016-09-18 11:36:18.292280 7fab858dc700 10 bluefs _flush 0x7fac47a5dd00 i=
gnoring, length 3310 < min_flush_size 65536
> 2016-09-18 11:36:18.292281 7fab858dc700 10 bluefs _fsync 0x7fac47a5dd00 f=
ile(ino 24 size 0x3d7cdc5 mtime 2016-09-18 11:36:04.164949 bdev 0 extents [=
0:0xe100000+d00000,0:0xf200000+e00000,1:0x10000000+2100000,0:0x100000+20000=
0])
> 2016-09-18 11:36:18.292286 7fab858dc700 10 bluefs _flush 0x7fac47a5dd00 0=
x1b10000~cee to file(ino 24 size 0x3d7cdc5 mtime 2016-09-18 11:36:04.164949=
 bdev 0 extents [0:0xe100000+d00000,0:0xf200000+e00000,1:0x10000000+2100000=
,0:0x100000+200000])
> 2016-09-18 11:36:18.292289 7fab858dc700 10 bluefs _flush_range 0x7fac47a5=
dd00 pos 0x1b10000 0x1b10000~cee to file(ino 24 size 0x3d7cdc5 mtime 2016-0=
9-18 11:36:04.164949 bdev 0 extents [0:0xe100000+d00000,0:0xf200000+e00000,=
1:0x10000000+2100000,0:0x100000+200000])
> 2016-09-18 11:36:18.292292 7fab858dc700 20 bluefs _flush_range file now f=
ile(ino 24 size 0x3d7cdc5 mtime 2016-09-18 11:36:04.164949 bdev 0 extents [=
0:0xe100000+d00000,0:0xf200000+e00000,1:0x10000000+2100000,0:0x100000+20000=
0])
> 2016-09-18 11:36:18.292296 7fab858dc700 20 bluefs _flush_range in 1:0x100=
00000+2100000 x_off 0x10000
> 2016-09-18 11:36:18.292297 7fab858dc700 20 bluefs _flush_range caching ta=
il of 0xcee and padding block with zeros
> 2016-09-18 17:00:01.276990 7fab738b8700 -1 received  signal: Hangup from =
 PID: 89063 task name: killall -q -1 ceph-mon ceph-mds ceph-osd ceph-fuse r=
adosgw  UID: 0
>
> Further one of the osd process has crashed with this in the log:
>
> 2016-09-18 13:30:11.274012 7fdf399b8700 -1 /build/nitin/nightly_builds/20=
160914_125459-master/ceph.git/rpmbuild/BUILD/ceph-v11.0.0-2309.g9096ad3/src=
/os/bluestore/KernelDevice.cc: In function 'virtual void KernelDevice::aio_=
submit(IOContext*)' thread 7fdf399b8700 time 2016-09-18 13:30:11.270019
> /build/nitin/nightly_builds/20160914_125459-master/ceph.git/rpmbuild/BUIL=
D/ceph-v11.0.0-2309.g9096ad3/src/os/bluestore/KernelDevice.cc: 370: FAILED =
assert(r =3D=3D 0)
>
>  ceph version v11.0.0-2309-g9096ad3 (9096ad37f2c0798c26d7784fb4e7a781feb7=
2cb8)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)=
+0x8b) [0x7fdf4f73811b]
>  2: (KernelDevice::aio_submit(IOContext*)+0x76d) [0x7fdf4f597dbd]
>  3: (BlueFS::_flush_range(BlueFS::FileWriter*, unsigned long, unsigned lo=
ng)+0xcbd) [0x7fdf4f575b6d]
>  4: (BlueFS::_flush(BlueFS::FileWriter*, bool)+0xe9) [0x7fdf4f576c79]
>  5: (BlueFS::_fsync(BlueFS::FileWriter*, std::unique_lock<std::mutex>&)+0=
x6d) [0x7fdf4f579a6d]
>  6: (BlueRocksWritableFile::Sync()+0x4e) [0x7fdf4f58f25e]
>  7: (rocksdb::WritableFileWriter::SyncInternal(bool)+0x139) [0x7fdf4f6866=
99]
>  8: (rocksdb::WritableFileWriter::Sync(bool)+0x88) [0x7fdf4f687238]
>  9: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::Wr=
iteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool)+0x=
13cf) [0x7fdf4f5dea2f]
>  10: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::Write=
Batch*)+0x27) [0x7fdf4f5df637]
>  11: (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB::T=
ransactionImpl>)+0x5b) [0x7fdf4f51814b]
>  12: (BlueStore::_kv_sync_thread()+0xf5a) [0x7fdf4f4e5ffa]
>  13: (BlueStore::KVSyncThread::entry()+0xd) [0x7fdf4f4f3a6d]
>  14: (()+0x80a4) [0x7fdf4b7a50a4]
>  15: (clone()+0x6d) [0x7fdf4a61e04d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed=
 to interpret this.
>
> This time I have captured the log with debug bluefs =3D 20/20
>
> Is there a good place where I can upload the trail of the log for sharing=
?
>
> Thanks,
> Nitin
>
>
>
>

PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
