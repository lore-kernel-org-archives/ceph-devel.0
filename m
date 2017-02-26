From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Bluestore/Rocksdb panic when compiling with jemalloc
Date: Sun, 26 Feb 2017 19:36:47 +0800
Message-ID: <CAEYCsVLEST0_EYsHtfQgnoLEbUQ0_kNqd74srj+nmk8jp5j3jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f172.google.com ([209.85.213.172]:33115 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752239AbdBZLo4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Feb 2017 06:44:56 -0500
Received: by mail-yb0-f172.google.com with SMTP id d88so13791145ybi.0
        for <ceph-devel@vger.kernel.org>; Sun, 26 Feb 2017 03:44:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

     We got repeatable segmentation fault with jemalloc building of
Kraken 11.2.0, on ubuntu 16.04.

     The log looks like below, wondering if it is a bug, or a known issue ?


Xiaoxi.


2017-02-20 16:29:51.178757 7f362de7aa40  4 rocksdb: Write Ahead Log file in db:

2017-02-20 16:29:51.178758 7f362de7aa40  4 rocksdb:
     Options.error_if_exists: 0
"/var/log/ceph/ceph-osd.0.log" 762535L, 161170224C

                                          1,1           Top
   0/ 0 client
   0/ 0 osd
   0/ 0 optracker
   0/ 0 objclass
   0/ 0 filestore
   0/ 0 journal
   0/ 0 ms
   0/ 0 mon
   0/ 0 monc
   0/ 0 paxos
   0/ 0 tp
   0/ 0 auth
   1/ 5 crypto
   0/ 0 finisher
   0/ 0 heartbeatmap
   0/ 0 perfcounter
   0/ 0 rgw
   1/10 civetweb
   1/ 5 javaclient
   0/ 0 asok
   0/ 0 throttle
   0/ 0 refs
   1/ 5 xio
   1/ 5 compressor
   1/ 5 newstore
   0/ 0 bluestore
   0/ 0 bluefs
   1/ 3 bdev
   1/ 5 kstore
   0/ 0 rocksdb
   4/ 5 leveldb
   4/ 5 memdb
   1/ 5 kinetic
   1/ 5 fuse
   1/ 5 mgr
   1/ 5 mgrc
   1/ 5 dpdk
  -2/-2 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/ceph-osd.0.log
--- end dump of recent events ---


                                          762535,1      Bot
 13: (BlueStore::Collection::get_onode(ghobject_t const&, bool)+0x54e)
[0x55a0f73b62be]
 14: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
ObjectStore::Transaction*)+0x903) [0x55a0f73d4b23]
 15: (BlueStore::queue_transactions(ObjectStore::Sequencer*,
std::vector<ObjectStore::Transaction,
std::allocator<ObjectStore::Transaction> >&,
std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x436)
[0x55a0f73d6e66]
 16: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,
ObjectStore::Transaction&&, Context*, Context*, Context*,
std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x1ab)
[0x55a0f6fe0f1b]
 17: (PrimaryLogPG::queue_transaction(ObjectStore::Transaction&&,
std::shared_ptr<OpRequest>)+0x6a) [0x55a0f716072a]
 18: (ReplicatedBackend::_do_push(std::shared_ptr<OpRequest>)+0x545)
[0x55a0f7241a15]
 19: (ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>)+0x320)
[0x55a0f7250c60]
 20: (PrimaryLogPG::do_request(std::shared_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0xbd) [0x55a0f70f708d]
 21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x418)
[0x55a0f6f91ce8]
 22: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>
const&)+0x52) [0x55a0f6f91f42]
 23: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x776) [0x55a0f6fb76e6]
 24: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x7f9)
[0x55a0f769d129]
 25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55a0f76a04e0]
 26: (()+0x76ba) [0x7f8e1c0c66ba]
 27: (clone()+0x6d) [0x7f8e1a79582d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 0 lockdep
   0/ 0 context
   0/ 0 crush
   0/ 0 mds
   0/ 0 mds_balancer
   0/ 0 mds_locker
   0/ 0 mds_log
   0/ 0 mds_log_expire
   0/ 0 mds_migrator
   0/ 0 buffer
   0/ 0 timer
   0/ 0 filer
   0/ 1 striper
   0/ 0 objecter
   0/ 0 rados
   0/ 0 rbd
   0/ 5 rbd_mirror
   0/ 5 rbd_replay
   0/ 0 journaler
   0/ 0 objectcacher
   0/ 0 client
   0/ 0 osd
   0/ 0 optracker


                                          762494,4      99%
   -18> 2017-02-25 19:32:12.622925 7f8de53b8700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
   -17> 2017-02-25 19:32:12.623455 7f8de53b8700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 2
   -16> 2017-02-25 19:32:12.623645 7f8de53b8700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
   -15> 2017-02-25 19:32:12.664082 7f8de13b0700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
   -14> 2017-02-25 19:32:12.664274 7f8de13b0700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
   -13> 2017-02-25 19:32:12.664461 7f8de13b0700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
   -12> 2017-02-25 19:32:12.664645 7f8de13b0700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
   -11> 2017-02-25 19:32:12.664829 7f8de13b0700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
   -10> 2017-02-25 19:32:12.740853 7f8de03ae700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
    -9> 2017-02-25 19:32:12.741046 7f8de03ae700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
    -8> 2017-02-25 19:32:12.741238 7f8de03ae700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
    -7> 2017-02-25 19:32:12.779708 7f8de6bbb700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
    -6> 2017-02-25 19:32:12.779910 7f8de6bbb700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
    -5> 2017-02-25 19:32:12.815901 7f8de03ae700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
    -4> 2017-02-25 19:32:12.816090 7f8de03ae700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
    -3> 2017-02-25 19:32:12.859204 7f8de43b6700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
    -2> 2017-02-25 19:32:12.859401 7f8de43b6700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
    -1> 2017-02-25 19:32:12.859588 7f8de43b6700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
     0> 2017-02-25 19:32:12.898476 7f8de43b6700 -1 *** Caught signal
(Segmentation fault) **
 in thread 7f8de43b6700 thread_name:tp_osd_tp

 ceph version 11.2.0-41-g6c6b185 (6c6b185bab1e0b7d7446b97d5d314b4dd60360ff)
 1: (()+0x946e4e) [0x55a0f74c6e4e]
 2: (()+0x11390) [0x7f8e1c0d0390]
 3: (()+0x1f8af) [0x7f8e1ce458af]
 4: (rocksdb::BlockBasedTable::PutDataBlockToCache(rocksdb::Slice
const&, rocksdb::Slice const&, rocksdb::Cache*, rocksdb::Cache*,
rocksdb::ReadOptions const&, rocksdb::ImmutableCFOptions const&,
rocksdb::BlockBasedTable::CachableEntry<rocksdb::Block>*,
rocksdb::Block*, unsigned int, rocksdb::Slice const&, unsigned
long)+0x1ce) [0x55a0f758380e]
 5: (rocksdb::BlockBasedTable::MaybeLoadDataBlockToCache(rocksdb::BlockBasedTable::Rep*,
rocksdb::ReadOptions const&, rocksdb::BlockHandle const&,
rocksdb::Slice,
rocksdb::BlockBasedTable::CachableEntry<rocksdb::Block>*)+0x3ab)
[0x55a0f7584feb]
 6: (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb::BlockBasedTable::Rep*,
rocksdb::ReadOptions const&, rocksdb::Slice const&,
rocksdb::BlockIter*)+0x301) [0x55a0f75853b1]
 7: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions const&,
rocksdb::Slice const&, rocksdb::GetContext*, bool)+0x5cb)
[0x55a0f758b17b]
 8: (rocksdb::TableCache::Get(rocksdb::ReadOptions const&,
rocksdb::InternalKeyComparator const&, rocksdb::FileDescriptor const&,
rocksdb::Slice const&, rocksdb::GetContext*, rocksdb::HistogramImpl*,
bool, int)+0x2ee) [0x55a0f754817e]
 9: (rocksdb::Version::Get(rocksdb::ReadOptions const&,
rocksdb::LookupKey const&, std::__cxx11::basic_string<char,
std::char_traits<char>, std::allocator<char> >*, rocksdb::Status*,
rocksdb::MergeContext*, rocksdb::RangeDelAggregator*, bool*, bool*,
unsigned long*)+0x417) [0x55a0f755ed77]
 10: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions const&,
rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,
std::__cxx11::basic_string<char, std::char_traits<char>,
std::allocator<char> >*, bool*)+0x324) [0x55a0f74e68b4]
 11: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&,
rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,
std::__cxx11::basic_string<char, std::char_traits<char>,
std::allocator<char> >*)+0x22) [0x55a0f74e7002]
 12: (RocksDBStore::get(std::__cxx11::basic_string<char,
std::char_traits<char>, std::allocator<char> > const&,
std::__cxx11::basic_string<char, std::char_traits<char>,
std::allocator<char> > const&, ceph::buffer::list*)+0x15d)
[0x55a0f740c20d]
 13: (BlueStore::Collection::get_onode(ghobject_t const&, bool)+0x54e)
[0x55a0f73b62be]
 14: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
ObjectStore::Transaction*)+0x903) [0x55a0f73d4b23]


                                          762455,2      99%
 13: (BlueStore::Collection::get_onode(ghobject_t const&, bool)+0x54e)
[0x55a0f73b62be]
 14: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
ObjectStore::Transaction*)+0x903) [0x55a0f73d4b23]
 15: (BlueStore::queue_transactions(ObjectStore::Sequencer*,
std::vector<ObjectStore::Transaction,
std::allocator<ObjectStore::Transaction> >&,
std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x436)
[0x55a0f73d6e66]
 16: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,
ObjectStore::Transaction&&, Context*, Context*, Context*,
std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x1ab)
[0x55a0f6fe0f1b]
 17: (PrimaryLogPG::queue_transaction(ObjectStore::Transaction&&,
std::shared_ptr<OpRequest>)+0x6a) [0x55a0f716072a]
 18: (ReplicatedBackend::_do_push(std::shared_ptr<OpRequest>)+0x545)
[0x55a0f7241a15]
 19: (ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>)+0x320)
[0x55a0f7250c60]
 20: (PrimaryLogPG::do_request(std::shared_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0xbd) [0x55a0f70f708d]
 21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x418)
[0x55a0f6f91ce8]
 22: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>
const&)+0x52) [0x55a0f6f91f42]
 23: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x776) [0x55a0f6fb76e6]
 24: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x7f9)
[0x55a0f769d129]
 25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55a0f76a04e0]
 26: (()+0x76ba) [0x7f8e1c0c66ba]
 27: (clone()+0x6d) [0x7f8e1a79582d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 0 lockdep
   0/ 0 context
   0/ 0 crush
   0/ 0 mds
   0/ 0 mds_balancer
   0/ 0 mds_locker
   0/ 0 mds_log
   0/ 0 mds_log_expire
   0/ 0 mds_migrator
   0/ 0 buffer
   0/ 0 timer
   0/ 0 filer
   0/ 1 striper
   0/ 0 objecter
   0/ 0 rados
   0/ 0 rbd
   0/ 5 rbd_mirror
   0/ 5 rbd_replay
   0/ 0 journaler
   0/ 0 objectcacher
   0/ 0 client
   0/ 0 osd
   0/ 0 optracker


                                          762454,2      99%
    -1> 2017-02-25 19:32:12.859588 7f8de43b6700 -1
bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
     0> 2017-02-25 19:32:12.898476 7f8de43b6700 -1 *** Caught signal
(Segmentation fault) **
 in thread 7f8de43b6700 thread_name:tp_osd_tp

 ceph version 11.2.0-41-g6c6b185 (6c6b185bab1e0b7d7446b97d5d314b4dd60360ff)
 1: (()+0x946e4e) [0x55a0f74c6e4e]
 2: (()+0x11390) [0x7f8e1c0d0390]
 3: (()+0x1f8af) [0x7f8e1ce458af]
 4: (rocksdb::BlockBasedTable::PutDataBlockToCache(rocksdb::Slice
const&, rocksdb::Slice const&, rocksdb::Cache*, rocksdb::Cache*,
rocksdb::ReadOptions const&, rocksdb::ImmutableCFOptions const&,
rocksdb::BlockBasedTable::CachableEntry<rocksdb::Block>*,
rocksdb::Block*, unsigned int, rocksdb::Slice const&, unsigned
long)+0x1ce) [0x55a0f758380e]
 5: (rocksdb::BlockBasedTable::MaybeLoadDataBlockToCache(rocksdb::BlockBasedTable::Rep*,
rocksdb::ReadOptions const&, rocksdb::BlockHandle const&,
rocksdb::Slice,
rocksdb::BlockBasedTable::CachableEntry<rocksdb::Block>*)+0x3ab)
[0x55a0f7584feb]
 6: (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb::BlockBasedTable::Rep*,
rocksdb::ReadOptions const&, rocksdb::Slice const&,
rocksdb::BlockIter*)+0x301) [0x55a0f75853b1]
 7: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions const&,
rocksdb::Slice const&, rocksdb::GetContext*, bool)+0x5cb)
[0x55a0f758b17b]
 8: (rocksdb::TableCache::Get(rocksdb::ReadOptions const&,
rocksdb::InternalKeyComparator const&, rocksdb::FileDescriptor const&,
rocksdb::Slice const&, rocksdb::GetContext*, rocksdb::HistogramImpl*,
bool, int)+0x2ee) [0x55a0f754817e]
 9: (rocksdb::Version::Get(rocksdb::ReadOptions const&,
rocksdb::LookupKey const&, std::__cxx11::basic_string<char,
std::char_traits<char>, std::allocator<char> >*, rocksdb::Status*,
rocksdb::MergeContext*, rocksdb::RangeDelAggregator*, bool*, bool*,
unsigned long*)+0x417) [0x55a0f755ed77]
 10: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions const&,
rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,
std::__cxx11::basic_string<char, std::char_traits<char>,
std::allocator<char> >*, bool*)+0x324) [0x55a0f74e68b4]
 11: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&,
rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,
std::__cxx11::basic_string<char, std::char_traits<char>,
std::allocator<char> >*)+0x22) [0x55a0f74e7002]
 12: (RocksDBStore::get(std::__cxx11::basic_string<char,
std::char_traits<char>, std::allocator<char> > const&,
std::__cxx11::basic_string<char, std::char_traits<char>,
std::allocator<char> > const&, ceph::buffer::list*)+0x15d)
[0x55a0f740c20d]
 13: (BlueStore::Collection::get_onode(ghobject_t const&, bool)+0x54e)
[0x55a0f73b62be]
 14: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
ObjectStore::Transaction*)+0x903) [0x55a0f73d4b23]
 15: (BlueStore::queue_transactions(ObjectStore::Sequencer*,
std::vector<ObjectStore::Transaction,
std::allocator<ObjectStore::Transaction> >&,
std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x436)
[0x55a0f73d6e66]
 16: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,
ObjectStore::Transaction&&, Context*, Context*, Context*,
std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x1ab)
[0x55a0f6fe0f1b]
 17: (PrimaryLogPG::queue_transaction(ObjectStore::Transaction&&,
std::shared_ptr<OpRequest>)+0x6a) [0x55a0f716072a]
 18: (ReplicatedBackend::_do_push(std::shared_ptr<OpRequest>)+0x545)
[0x55a0f7241a15]
 19: (ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>)+0x320)
[0x55a0f7250c60]
 20: (PrimaryLogPG::do_request(std::shared_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0xbd) [0x55a0f70f708d]
 21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x418)
[0x55a0f6f91ce8]
 22: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>
const&)+0x52) [0x55a0f6f91f42]
 23: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x776) [0x55a0f6fb76e6]
 24: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x7f9)
[0x55a0f769d129]
 25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55a0f76a04e0]
 26: (()+0x76ba) [0x7f8e1c0c66ba]
 27: (clone()+0x6d) [0x7f8e1a79582d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- logging levels ---
