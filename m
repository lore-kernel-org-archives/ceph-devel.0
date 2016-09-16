From: Sage Weil <sage@newdream.net>
Subject: Re: Bluestore OSD support in ceph-disk
Date: Fri, 16 Sep 2016 20:54:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609162053270.1040@piezo.us.to>
References: <4459A44C-1336-4EC1-82F0-F491D0C83712@Teradata.com> <BL2PR02MB2115BE07E99958F8FA8E521CF4F10@BL2PR02MB2115.namprd02.prod.outlook.com> <0B017562-31CE-4C51-8ADB-997E5D59C1BF@Teradata.com> <C749C86B-A804-4566-9F63-B7B90E6E0891@Teradata.com>
 <alpine.DEB.2.11.1609151833290.19761@piezo.us.to> <BC30B826-3E63-4002-9436-60222C606E9F@Teradata.com> <alpine.DEB.2.11.1609151850330.19761@piezo.us.to> <E9BC8A1A-CFD4-4D1E-A719-FD3AD217607E@Teradata.com> <EA284BAD-1765-4600-92A9-32FF2BF098E9@Teradata.com>
 <BL2PR02MB21150C4B85B1897282432B86F4F30@BL2PR02MB2115.namprd02.prod.outlook.com> <E27159E7-FDEB-4075-B1B3-8C788D2CCA8C@Teradata.com> <BL2PR02MB21153BD658496CF33BD40CB8F4F30@BL2PR02MB2115.namprd02.prod.outlook.com>
 <3BA97D41-E3A1-404A-9FEE-41245D56D538@Teradata.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48704 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965254AbcIPUye (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2016 16:54:34 -0400
In-Reply-To: <3BA97D41-E3A1-404A-9FEE-41245D56D538@Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 16 Sep 2016, Kamble, Nitin A wrote:
> > On Sep 16, 2016, at 12:23 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > 
> > How you configured bluestore, all default ? i.e all in single partition , no separate partition for db/wal ?
> It is separated partitions for data(SSD), wal(SSD), rocksdb(SSD), & block store (HDD).
> 
> > Wondering if you are out of db space/disk space ?
> I notice a misconfiguration on the cluster now. The wal & db partition use got swapped, so it is getting just 128MB db partition now. Probably this is the cause of the assert.

FWIW bluefs is supposed to fall back on any allocation failure to the next 
larger/slower device (wal -> db -> primary), so having a tiny wal or tiny 
db shouldn't actually matter.  A bluefs log (debug bluefs = 10 or 20) 
leading up to any crash there would be helpful.

Thanks!
sage


> > We had some issues in this front sometimes back which was fixed, may be a new issue (?). Need verbose log for at least bluefs (debug_bluefs = 20/20)
> 
> Let me fix the cluster configuration, to give better space to the DB partition. And if with that this issue comes up then I will try capturing detailed logs.
> 
> > BTW, what is your workload (block size, IO pattern ) ?
> 
> The workload is internal teradata benchmark, which simulates IO pattern of database disk access with various block sizes and IO pattern. 
> 
> Thanks,
> Nitin
> 
> 
> 
> > 
> > -----Original Message-----
> > From: Kamble, Nitin A [mailto:Nitin.Kamble@Teradata.com]
> > Sent: Friday, September 16, 2016 12:00 PM
> > To: Somnath Roy
> > Cc: Sage Weil; Ceph Development
> > Subject: Re: Bluestore OSD support in ceph-disk
> > 
> > 
> >> On Sep 16, 2016, at 11:43 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> >> 
> >> Please send the snippet (very first trace , go up in the log) where it is actually printing the assert.
> >> BTW, what workload you are running ?
> >> 
> >> Thanks & Regards
> >> Somnath
> >> 
> > Here it is.
> > 
> > 2016-09-16 08:49:30.605845 7fb5a96ba700 -1 /build/nitin/nightly_builds/20160914_125459-master/ceph.git/rpmbuild/BUILD/ceph-v11.0.0-2309.g9096ad3/src/os/bluestore/BlueFS.cc: In function 'int BlueFS::_allocate(uint8_t, uint64_t, std::vecto r<bluefs_extent_t>*)' thread 7fb5a96ba700 time 2016-09-16 08:49:30.602139
> > /build/nitin/nightly_builds/20160914_125459-master/ceph.git/rpmbuild/BUILD/ceph-v11.0.0-2309.g9096ad3/src/os/bluestore/BlueFS.cc: 1686: FAILED assert(0 == "allocate failed... wtf")
> > 
> > ceph version v11.0.0-2309-g9096ad3 (9096ad37f2c0798c26d7784fb4e7a781feb72cb8)
> > 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) [0x7fb5bf43a11b]
> > 2: (BlueFS::_allocate(unsigned char, unsigned long, std::vector<bluefs_extent_t, std::allocator<bluefs_extent_t> >*)+0x8ad) [0x7fb5bf2735dd]
> > 3: (BlueFS::_flush_and_sync_log(std::unique_lock<std::mutex>&, unsigned long, unsigned long)+0xb4f) [0x7fb5bf27aa1f]
> > 4: (BlueFS::_fsync(BlueFS::FileWriter*, std::unique_lock<std::mutex>&)+0x29b) [0x7fb5bf27bc9b]
> > 5: (BlueRocksWritableFile::Sync()+0x4e) [0x7fb5bf29125e]
> > 6: (rocksdb::WritableFileWriter::SyncInternal(bool)+0x139) [0x7fb5bf388699]
> > 7: (rocksdb::WritableFileWriter::Sync(bool)+0x88) [0x7fb5bf389238]
> > 8: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool)+0x13cf) [0x7fb5bf2e0a2f]
> > 9: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*)+0x27) [0x7fb5bf2e1637]
> > 10: (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB::TransactionImpl>)+0x5b) [0x7fb5bf21a14b]
> > 11: (BlueStore::_kv_sync_thread()+0xf5a) [0x7fb5bf1e7ffa]
> > 12: (BlueStore::KVSyncThread::entry()+0xd) [0x7fb5bf1f5a6d]
> > 13: (()+0x80a4) [0x7fb5bb4a70a4]
> > 14: (clone()+0x6d) [0x7fb5ba32004d]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> > 
> > 
> > 
> > Thanks,
> > Nitin
> > 
> > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
