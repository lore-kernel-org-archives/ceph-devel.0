From: sheng qiu <herbert1984106@gmail.com>
Subject: segmentation fault while using fio_ceph_objectstore
Date: Fri, 31 Mar 2017 09:43:23 -0700
Message-ID: <CAB7xdikeEJC9W-e9k-Kaz5=qFK84=vCTDpFoqt=w-tj9otquGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34035 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933217AbdCaQnZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Mar 2017 12:43:25 -0400
Received: by mail-vk0-f52.google.com with SMTP id z204so97687922vkd.1
        for <ceph-devel@vger.kernel.org>; Fri, 31 Mar 2017 09:43:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

i am trying to use fio_ceph_objectstore as an external engine used by
fio to directly generate IO to objectstore backend without running a
ceph cluster. The purpose is to understand the performance of
objectstore backend.

i was able to run kstore relatively stable, however with bluestore, it
frequently crash during the test.
here's the crash log:

*** Caught signal (Segmentation fault) **
 in thread 7f6bc67f4700 thread_name:bstore_kv_sync
 ceph version ccd5a2 (4ccd5a2aafa15ccb6830fa0e339d57be67a50e24)
 1: (()+0x4f309e) [0x7f6bff71509e]
 2: (()+0x11390) [0x7f6bed0a8390]
 3: (malloc_usable_size()+0x28) [0x7f6becb4e4e8]
 4: (rocksdb::Arena::AllocateNewBlock(unsigned long)+0x7c) [0x7f6bff80072c]
 5: (rocksdb::Arena::AllocateFallback(unsigned long, bool)+0x45)
[0x7f6bff8008a5]
 6: (rocksdb::ConcurrentArena::AllocateAligned(unsigned long, unsigned
long, rocksdb::Logger*)+0x16e) [0x7f6bff78a46e]
 7: (()+0x5a3c0b) [0x7f6bff7c5c0b]
 8: (rocksdb::MemTable::Add(unsigned long, rocksdb::ValueType,
rocksdb::Slice const&, rocksdb::Slice const&, bool,
rocksdb::MemTablePostProcessInfo*)+0x8d9) [0x7f6bff7871d9]
 9: (rocksdb::MemTableInserter::PutCF(unsigned int, rocksdb::Slice
const&, rocksdb::Slice const&)+0x30f) [0x7f6bff7c215f]
 10: (rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*)
const+0x53d) [0x7f6bff7bd3cd]
 11: (rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*,
8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*,
rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*,
bool)+0x140) [0x7f6bff7bfd50]
 12: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&,
rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*,
unsigned long, bool)+0x1617) [0x7f6bff73e3c7]
 13: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&,
rocksdb::WriteBatch*)+0x2a) [0x7f6bff73ec5a]
 14: (RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>)+0x249)
[0x7f6bff644469]
 15: (BlueStore::_kv_sync_thread()+0x12a7) [0x7f6bff5e5037]
 16: (BlueStore::KVSyncThread::entry()+0xd) [0x7f6bff6299ed]
 17: (Thread::entry_wrapper()+0x75) [0x7f6bff923335]
 18: (()+0x76ba) [0x7f6bed09e6ba]
 19: (clone()+0x6d) [0x7f6becbd082d]

is there any clue how to fix it? any help would be appreciated.

Thanks,
Sheng
