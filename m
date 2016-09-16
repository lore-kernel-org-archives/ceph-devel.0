From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: Bluestore OSD support in ceph-disk
Date: Fri, 16 Sep 2016 19:00:17 +0000
Message-ID: <E27159E7-FDEB-4075-B1B3-8C788D2CCA8C@Teradata.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:37753 "EHLO
        rpc7279.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964804AbcIPTAZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2016 15:00:25 -0400
In-Reply-To: <BL2PR02MB21150C4B85B1897282432B86F4F30@BL2PR02MB2115.namprd02.prod.outlook.com>
Content-Language: en-US
Content-ID: <B00E6D26E393E64F9990060A79DBC2DE@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>


> On Sep 16, 2016, at 11:43 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> 
> Please send the snippet (very first trace , go up in the log) where it is actually printing the assert.
> BTW, what workload you are running ?
> 
> Thanks & Regards
> Somnath
> 
Here it is.

2016-09-16 08:49:30.605845 7fb5a96ba700 -1 /build/nitin/nightly_builds/20160914_125459-master/ceph.git/rpmbuild/BUILD/ceph-v11.0.0-2309.g9096ad3/src/os/bluestore/BlueFS.cc: In function 'int BlueFS::_allocate(uint8_t, uint64_t, std::vecto
r<bluefs_extent_t>*)' thread 7fb5a96ba700 time 2016-09-16 08:49:30.602139
/build/nitin/nightly_builds/20160914_125459-master/ceph.git/rpmbuild/BUILD/ceph-v11.0.0-2309.g9096ad3/src/os/bluestore/BlueFS.cc: 1686: FAILED assert(0 == "allocate failed... wtf")

 ceph version v11.0.0-2309-g9096ad3 (9096ad37f2c0798c26d7784fb4e7a781feb72cb8)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) [0x7fb5bf43a11b]
 2: (BlueFS::_allocate(unsigned char, unsigned long, std::vector<bluefs_extent_t, std::allocator<bluefs_extent_t> >*)+0x8ad) [0x7fb5bf2735dd]
 3: (BlueFS::_flush_and_sync_log(std::unique_lock<std::mutex>&, unsigned long, unsigned long)+0xb4f) [0x7fb5bf27aa1f]
 4: (BlueFS::_fsync(BlueFS::FileWriter*, std::unique_lock<std::mutex>&)+0x29b) [0x7fb5bf27bc9b]
 5: (BlueRocksWritableFile::Sync()+0x4e) [0x7fb5bf29125e]
 6: (rocksdb::WritableFileWriter::SyncInternal(bool)+0x139) [0x7fb5bf388699]
 7: (rocksdb::WritableFileWriter::Sync(bool)+0x88) [0x7fb5bf389238]
 8: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool)+0x13cf) [0x7fb5bf2e0a2f]
 9: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*)+0x27) [0x7fb5bf2e1637]
 10: (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB::TransactionImpl>)+0x5b) [0x7fb5bf21a14b]
 11: (BlueStore::_kv_sync_thread()+0xf5a) [0x7fb5bf1e7ffa]
 12: (BlueStore::KVSyncThread::entry()+0xd) [0x7fb5bf1f5a6d]
 13: (()+0x80a4) [0x7fb5bb4a70a4]
 14: (clone()+0x6d) [0x7fb5ba32004d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.



Thanks,
Nitin

