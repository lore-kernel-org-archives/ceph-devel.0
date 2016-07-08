From: Igor Fedotov <ifedotov@mirantis.com>
Subject: yet another assertion in bluestore during random write
Date: Fri, 8 Jul 2016 13:39:18 +0300
Message-ID: <c8078e34-836e-6383-7540-d5fea731efb2@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36587 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbcGHKjW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jul 2016 06:39:22 -0400
Received: by mail-lf0-f47.google.com with SMTP id q132so26877798lfe.3
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2016 03:39:21 -0700 (PDT)
Received: from [172.18.12.66] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id h191sm8085926lfh.0.2016.07.08.03.39.19
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jul 2016 03:39:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi All,


as I mentioned during yesterday's bluestore syncup I observed another 
issue with bluestore during random write.

Here is the backtrace:

      0> 2016-07-07 17:05:10.520543 7ff393dbf700 -1 
os/bluestore/BlueFS.cc: In function 'int BlueFS::_allocate(unsigned int, 
uint64_t, std::vector<bluefs_extent_t>*)' thread 7ff393dbf700 time 
2016-07-07 17:05:10.507412
os/bluestore/BlueFS.cc: 1398: FAILED assert(0 == "allocate failed... wtf")

  ceph version 11.0.0-289-g173e5a6 
(173e5a6d85f624a714c0029db6f828cb1968cf3d)
  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x82) [0x7ff3a9833452]
  2: (BlueFS::_allocate(unsigned int, unsigned long, 
std::vector<bluefs_extent_t, std::allocator<bluefs_extent_t> >*)+0x760) 
[0x7ff3a95186e0]
  3: (BlueFS::_compact_log()+0xd9b) [0x7ff3a951ba8b]
  4: (BlueFS::_maybe_compact_log()+0x2a0) [0x7ff3a951c510]
  5: (BlueFS::sync_metadata()+0x20f) [0x7ff3a951d77f]
  6: (BlueRocksDirectory::Fsync()+0xd) [0x7ff3a95300dd]
  7: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, 
rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned 
long, bool)+0x14e1) [0x7ff3a95ea281]
  8: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, 
rocksdb::WriteBatch*)+0x1b) [0x7ff3a95eae1b]
  9: 
(RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB::TransactionImpl>)+0x6b) 
[0x7ff3a95b7d7b]
  10: (BlueStore::_kv_sync_thread()+0x167b) [0x7ff3a942aefb]
  11: (BlueStore::KVSyncThread::entry()+0xd) [0x7ff3a944af5d]
  12: (()+0x80a5) [0x7ff3a7a170a5]
  13: (clone()+0x6d) [0x7ff3a58f9cfd]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

Looks like bitmap allocator returns a failure at some moment.

My environment:

* Ceph cluster run via vstart.sh.

*rbd image created via:

./rbd create --size 1024 -c ceph.conf --image-feature layering fio_test
./rbd map -c ceph.conf fio_test

* fio script is as follows:

[global]

[rbd_iodepth32]
ioengine=libaio
iodepth=32
filename=/dev/rbd12
size=1m
io_size=8192m
bs=128k
rw=randwrite
numjobs=3


Bug is easily reproducible with the script when bluestore allocator is 
set to bitmap (by default). I was unable to reproduce the issue with 
stupid allocator hence I suppose it's rather bitmap allocator internal 
issue. Maybe some leaks as it occurs rather by the end of the FIO script?

  One should apply bluestore patch I posted yesterday prior to reproduce 
this issue as one can hit another bug otherwise.


Thanks,

Igor

