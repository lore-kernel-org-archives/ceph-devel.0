From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: Bluestore/Rocksdb panic when compiling with jemalloc
Date: Mon, 27 Feb 2017 04:56:56 +0000
Message-ID: <A2F6736D5AC58C448B8B7D859805FD150FEA0E@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <CAEYCsVLEST0_EYsHtfQgnoLEbUQ0_kNqd74srj+nmk8jp5j3jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35016 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdB0FL4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2017 00:11:56 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>, Sage Weil <sage@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

If this problem is consistent, could you please collect the core? That=0A=
might give some more clues and in a periodic way you can dump the=0A=
rocksdb stats(rocksdb_collect_extended_stats and=0A=
rocksdb_collect_memory_stats) from admin socket. They might give some=0A=
more info about the block table cache from rocksdb.=0A=
=0A=
Varada=0A=
=0A=
On Sunday 26 February 2017 05:15 PM, Xiaoxi Chen wrote:=0A=
> Hi Sage,=0A=
>=0A=
>      We got repeatable segmentation fault with jemalloc building of=0A=
> Kraken 11.2.0, on ubuntu 16.04.=0A=
>=0A=
>      The log looks like below, wondering if it is a bug, or a known issue=
 ?=0A=
>=0A=
>=0A=
> Xiaoxi.=0A=
>=0A=
>=0A=
> 2017-02-20 16:29:51.178757 7f362de7aa40  4 rocksdb: Write Ahead Log file =
in db:=0A=
>=0A=
> 2017-02-20 16:29:51.178758 7f362de7aa40  4 rocksdb:=0A=
>      Options.error_if_exists: 0=0A=
> "/var/log/ceph/ceph-osd.0.log" 762535L, 161170224C=0A=
>=0A=
>                                           1,1           Top=0A=
>    0/ 0 client=0A=
>    0/ 0 osd=0A=
>    0/ 0 optracker=0A=
>    0/ 0 objclass=0A=
>    0/ 0 filestore=0A=
>    0/ 0 journal=0A=
>    0/ 0 ms=0A=
>    0/ 0 mon=0A=
>    0/ 0 monc=0A=
>    0/ 0 paxos=0A=
>    0/ 0 tp=0A=
>    0/ 0 auth=0A=
>    1/ 5 crypto=0A=
>    0/ 0 finisher=0A=
>    0/ 0 heartbeatmap=0A=
>    0/ 0 perfcounter=0A=
>    0/ 0 rgw=0A=
>    1/10 civetweb=0A=
>    1/ 5 javaclient=0A=
>    0/ 0 asok=0A=
>    0/ 0 throttle=0A=
>    0/ 0 refs=0A=
>    1/ 5 xio=0A=
>    1/ 5 compressor=0A=
>    1/ 5 newstore=0A=
>    0/ 0 bluestore=0A=
>    0/ 0 bluefs=0A=
>    1/ 3 bdev=0A=
>    1/ 5 kstore=0A=
>    0/ 0 rocksdb=0A=
>    4/ 5 leveldb=0A=
>    4/ 5 memdb=0A=
>    1/ 5 kinetic=0A=
>    1/ 5 fuse=0A=
>    1/ 5 mgr=0A=
>    1/ 5 mgrc=0A=
>    1/ 5 dpdk=0A=
>   -2/-2 (syslog threshold)=0A=
>   -1/-1 (stderr threshold)=0A=
>   max_recent     10000=0A=
>   max_new         1000=0A=
>   log_file /var/log/ceph/ceph-osd.0.log=0A=
> --- end dump of recent events ---=0A=
>=0A=
>=0A=
>                                           762535,1      Bot=0A=
>  13: (BlueStore::Collection::get_onode(ghobject_t const&, bool)+0x54e)=0A=
> [0x55a0f73b62be]=0A=
>  14: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,=0A=
> ObjectStore::Transaction*)+0x903) [0x55a0f73d4b23]=0A=
>  15: (BlueStore::queue_transactions(ObjectStore::Sequencer*,=0A=
> std::vector<ObjectStore::Transaction,=0A=
> std::allocator<ObjectStore::Transaction> >&,=0A=
> std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x436)=0A=
> [0x55a0f73d6e66]=0A=
>  16: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,=0A=
> ObjectStore::Transaction&&, Context*, Context*, Context*,=0A=
> std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x1ab)=0A=
> [0x55a0f6fe0f1b]=0A=
>  17: (PrimaryLogPG::queue_transaction(ObjectStore::Transaction&&,=0A=
> std::shared_ptr<OpRequest>)+0x6a) [0x55a0f716072a]=0A=
>  18: (ReplicatedBackend::_do_push(std::shared_ptr<OpRequest>)+0x545)=0A=
> [0x55a0f7241a15]=0A=
>  19: (ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>)+0x320=
)=0A=
> [0x55a0f7250c60]=0A=
>  20: (PrimaryLogPG::do_request(std::shared_ptr<OpRequest>&,=0A=
> ThreadPool::TPHandle&)+0xbd) [0x55a0f70f708d]=0A=
>  21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,=0A=
> std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x418)=0A=
> [0x55a0f6f91ce8]=0A=
>  22: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>=0A=
> const&)+0x52) [0x55a0f6f91f42]=0A=
>  23: (OSD::ShardedOpWQ::_process(unsigned int,=0A=
> ceph::heartbeat_handle_d*)+0x776) [0x55a0f6fb76e6]=0A=
>  24: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x7f9)=0A=
> [0x55a0f769d129]=0A=
>  25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55a0f76a04e0=
]=0A=
>  26: (()+0x76ba) [0x7f8e1c0c66ba]=0A=
>  27: (clone()+0x6d) [0x7f8e1a79582d]=0A=
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is=0A=
> needed to interpret this.=0A=
>=0A=
> --- logging levels ---=0A=
>    0/ 5 none=0A=
>    0/ 0 lockdep=0A=
>    0/ 0 context=0A=
>    0/ 0 crush=0A=
>    0/ 0 mds=0A=
>    0/ 0 mds_balancer=0A=
>    0/ 0 mds_locker=0A=
>    0/ 0 mds_log=0A=
>    0/ 0 mds_log_expire=0A=
>    0/ 0 mds_migrator=0A=
>    0/ 0 buffer=0A=
>    0/ 0 timer=0A=
>    0/ 0 filer=0A=
>    0/ 1 striper=0A=
>    0/ 0 objecter=0A=
>    0/ 0 rados=0A=
>    0/ 0 rbd=0A=
>    0/ 5 rbd_mirror=0A=
>    0/ 5 rbd_replay=0A=
>    0/ 0 journaler=0A=
>    0/ 0 objectcacher=0A=
>    0/ 0 client=0A=
>    0/ 0 osd=0A=
>    0/ 0 optracker=0A=
>=0A=
>=0A=
>                                           762494,4      99%=0A=
>    -18> 2017-02-25 19:32:12.622925 7f8de53b8700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>    -17> 2017-02-25 19:32:12.623455 7f8de53b8700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 2=0A=
>    -16> 2017-02-25 19:32:12.623645 7f8de53b8700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>    -15> 2017-02-25 19:32:12.664082 7f8de13b0700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>    -14> 2017-02-25 19:32:12.664274 7f8de13b0700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>    -13> 2017-02-25 19:32:12.664461 7f8de13b0700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>    -12> 2017-02-25 19:32:12.664645 7f8de13b0700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>    -11> 2017-02-25 19:32:12.664829 7f8de13b0700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>    -10> 2017-02-25 19:32:12.740853 7f8de03ae700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>     -9> 2017-02-25 19:32:12.741046 7f8de03ae700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>     -8> 2017-02-25 19:32:12.741238 7f8de03ae700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>     -7> 2017-02-25 19:32:12.779708 7f8de6bbb700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>     -6> 2017-02-25 19:32:12.779910 7f8de6bbb700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>     -5> 2017-02-25 19:32:12.815901 7f8de03ae700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>     -4> 2017-02-25 19:32:12.816090 7f8de03ae700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>     -3> 2017-02-25 19:32:12.859204 7f8de43b6700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>     -2> 2017-02-25 19:32:12.859401 7f8de43b6700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>     -1> 2017-02-25 19:32:12.859588 7f8de43b6700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>      0> 2017-02-25 19:32:12.898476 7f8de43b6700 -1 *** Caught signal=0A=
> (Segmentation fault) **=0A=
>  in thread 7f8de43b6700 thread_name:tp_osd_tp=0A=
>=0A=
>  ceph version 11.2.0-41-g6c6b185 (6c6b185bab1e0b7d7446b97d5d314b4dd60360f=
f)=0A=
>  1: (()+0x946e4e) [0x55a0f74c6e4e]=0A=
>  2: (()+0x11390) [0x7f8e1c0d0390]=0A=
>  3: (()+0x1f8af) [0x7f8e1ce458af]=0A=
>  4: (rocksdb::BlockBasedTable::PutDataBlockToCache(rocksdb::Slice=0A=
> const&, rocksdb::Slice const&, rocksdb::Cache*, rocksdb::Cache*,=0A=
> rocksdb::ReadOptions const&, rocksdb::ImmutableCFOptions const&,=0A=
> rocksdb::BlockBasedTable::CachableEntry<rocksdb::Block>*,=0A=
> rocksdb::Block*, unsigned int, rocksdb::Slice const&, unsigned=0A=
> long)+0x1ce) [0x55a0f758380e]=0A=
>  5: (rocksdb::BlockBasedTable::MaybeLoadDataBlockToCache(rocksdb::BlockBa=
sedTable::Rep*,=0A=
> rocksdb::ReadOptions const&, rocksdb::BlockHandle const&,=0A=
> rocksdb::Slice,=0A=
> rocksdb::BlockBasedTable::CachableEntry<rocksdb::Block>*)+0x3ab)=0A=
> [0x55a0f7584feb]=0A=
>  6: (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb::BlockBasedTa=
ble::Rep*,=0A=
> rocksdb::ReadOptions const&, rocksdb::Slice const&,=0A=
> rocksdb::BlockIter*)+0x301) [0x55a0f75853b1]=0A=
>  7: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions const&,=0A=
> rocksdb::Slice const&, rocksdb::GetContext*, bool)+0x5cb)=0A=
> [0x55a0f758b17b]=0A=
>  8: (rocksdb::TableCache::Get(rocksdb::ReadOptions const&,=0A=
> rocksdb::InternalKeyComparator const&, rocksdb::FileDescriptor const&,=0A=
> rocksdb::Slice const&, rocksdb::GetContext*, rocksdb::HistogramImpl*,=0A=
> bool, int)+0x2ee) [0x55a0f754817e]=0A=
>  9: (rocksdb::Version::Get(rocksdb::ReadOptions const&,=0A=
> rocksdb::LookupKey const&, std::__cxx11::basic_string<char,=0A=
> std::char_traits<char>, std::allocator<char> >*, rocksdb::Status*,=0A=
> rocksdb::MergeContext*, rocksdb::RangeDelAggregator*, bool*, bool*,=0A=
> unsigned long*)+0x417) [0x55a0f755ed77]=0A=
>  10: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions const&,=0A=
> rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,=0A=
> std::__cxx11::basic_string<char, std::char_traits<char>,=0A=
> std::allocator<char> >*, bool*)+0x324) [0x55a0f74e68b4]=0A=
>  11: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&,=0A=
> rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,=0A=
> std::__cxx11::basic_string<char, std::char_traits<char>,=0A=
> std::allocator<char> >*)+0x22) [0x55a0f74e7002]=0A=
>  12: (RocksDBStore::get(std::__cxx11::basic_string<char,=0A=
> std::char_traits<char>, std::allocator<char> > const&,=0A=
> std::__cxx11::basic_string<char, std::char_traits<char>,=0A=
> std::allocator<char> > const&, ceph::buffer::list*)+0x15d)=0A=
> [0x55a0f740c20d]=0A=
>  13: (BlueStore::Collection::get_onode(ghobject_t const&, bool)+0x54e)=0A=
> [0x55a0f73b62be]=0A=
>  14: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,=0A=
> ObjectStore::Transaction*)+0x903) [0x55a0f73d4b23]=0A=
>=0A=
>=0A=
>                                           762455,2      99%=0A=
>  13: (BlueStore::Collection::get_onode(ghobject_t const&, bool)+0x54e)=0A=
> [0x55a0f73b62be]=0A=
>  14: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,=0A=
> ObjectStore::Transaction*)+0x903) [0x55a0f73d4b23]=0A=
>  15: (BlueStore::queue_transactions(ObjectStore::Sequencer*,=0A=
> std::vector<ObjectStore::Transaction,=0A=
> std::allocator<ObjectStore::Transaction> >&,=0A=
> std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x436)=0A=
> [0x55a0f73d6e66]=0A=
>  16: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,=0A=
> ObjectStore::Transaction&&, Context*, Context*, Context*,=0A=
> std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x1ab)=0A=
> [0x55a0f6fe0f1b]=0A=
>  17: (PrimaryLogPG::queue_transaction(ObjectStore::Transaction&&,=0A=
> std::shared_ptr<OpRequest>)+0x6a) [0x55a0f716072a]=0A=
>  18: (ReplicatedBackend::_do_push(std::shared_ptr<OpRequest>)+0x545)=0A=
> [0x55a0f7241a15]=0A=
>  19: (ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>)+0x320=
)=0A=
> [0x55a0f7250c60]=0A=
>  20: (PrimaryLogPG::do_request(std::shared_ptr<OpRequest>&,=0A=
> ThreadPool::TPHandle&)+0xbd) [0x55a0f70f708d]=0A=
>  21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,=0A=
> std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x418)=0A=
> [0x55a0f6f91ce8]=0A=
>  22: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>=0A=
> const&)+0x52) [0x55a0f6f91f42]=0A=
>  23: (OSD::ShardedOpWQ::_process(unsigned int,=0A=
> ceph::heartbeat_handle_d*)+0x776) [0x55a0f6fb76e6]=0A=
>  24: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x7f9)=0A=
> [0x55a0f769d129]=0A=
>  25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55a0f76a04e0=
]=0A=
>  26: (()+0x76ba) [0x7f8e1c0c66ba]=0A=
>  27: (clone()+0x6d) [0x7f8e1a79582d]=0A=
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is=0A=
> needed to interpret this.=0A=
>=0A=
> --- logging levels ---=0A=
>    0/ 5 none=0A=
>    0/ 0 lockdep=0A=
>    0/ 0 context=0A=
>    0/ 0 crush=0A=
>    0/ 0 mds=0A=
>    0/ 0 mds_balancer=0A=
>    0/ 0 mds_locker=0A=
>    0/ 0 mds_log=0A=
>    0/ 0 mds_log_expire=0A=
>    0/ 0 mds_migrator=0A=
>    0/ 0 buffer=0A=
>    0/ 0 timer=0A=
>    0/ 0 filer=0A=
>    0/ 1 striper=0A=
>    0/ 0 objecter=0A=
>    0/ 0 rados=0A=
>    0/ 0 rbd=0A=
>    0/ 5 rbd_mirror=0A=
>    0/ 5 rbd_replay=0A=
>    0/ 0 journaler=0A=
>    0/ 0 objectcacher=0A=
>    0/ 0 client=0A=
>    0/ 0 osd=0A=
>    0/ 0 optracker=0A=
>=0A=
>=0A=
>                                           762454,2      99%=0A=
>     -1> 2017-02-25 19:32:12.859588 7f8de43b6700 -1=0A=
> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1=0A=
>      0> 2017-02-25 19:32:12.898476 7f8de43b6700 -1 *** Caught signal=0A=
> (Segmentation fault) **=0A=
>  in thread 7f8de43b6700 thread_name:tp_osd_tp=0A=
>=0A=
>  ceph version 11.2.0-41-g6c6b185 (6c6b185bab1e0b7d7446b97d5d314b4dd60360f=
f)=0A=
>  1: (()+0x946e4e) [0x55a0f74c6e4e]=0A=
>  2: (()+0x11390) [0x7f8e1c0d0390]=0A=
>  3: (()+0x1f8af) [0x7f8e1ce458af]=0A=
>  4: (rocksdb::BlockBasedTable::PutDataBlockToCache(rocksdb::Slice=0A=
> const&, rocksdb::Slice const&, rocksdb::Cache*, rocksdb::Cache*,=0A=
> rocksdb::ReadOptions const&, rocksdb::ImmutableCFOptions const&,=0A=
> rocksdb::BlockBasedTable::CachableEntry<rocksdb::Block>*,=0A=
> rocksdb::Block*, unsigned int, rocksdb::Slice const&, unsigned=0A=
> long)+0x1ce) [0x55a0f758380e]=0A=
>  5: (rocksdb::BlockBasedTable::MaybeLoadDataBlockToCache(rocksdb::BlockBa=
sedTable::Rep*,=0A=
> rocksdb::ReadOptions const&, rocksdb::BlockHandle const&,=0A=
> rocksdb::Slice,=0A=
> rocksdb::BlockBasedTable::CachableEntry<rocksdb::Block>*)+0x3ab)=0A=
> [0x55a0f7584feb]=0A=
>  6: (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb::BlockBasedTa=
ble::Rep*,=0A=
> rocksdb::ReadOptions const&, rocksdb::Slice const&,=0A=
> rocksdb::BlockIter*)+0x301) [0x55a0f75853b1]=0A=
>  7: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions const&,=0A=
> rocksdb::Slice const&, rocksdb::GetContext*, bool)+0x5cb)=0A=
> [0x55a0f758b17b]=0A=
>  8: (rocksdb::TableCache::Get(rocksdb::ReadOptions const&,=0A=
> rocksdb::InternalKeyComparator const&, rocksdb::FileDescriptor const&,=0A=
> rocksdb::Slice const&, rocksdb::GetContext*, rocksdb::HistogramImpl*,=0A=
> bool, int)+0x2ee) [0x55a0f754817e]=0A=
>  9: (rocksdb::Version::Get(rocksdb::ReadOptions const&,=0A=
> rocksdb::LookupKey const&, std::__cxx11::basic_string<char,=0A=
> std::char_traits<char>, std::allocator<char> >*, rocksdb::Status*,=0A=
> rocksdb::MergeContext*, rocksdb::RangeDelAggregator*, bool*, bool*,=0A=
> unsigned long*)+0x417) [0x55a0f755ed77]=0A=
>  10: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions const&,=0A=
> rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,=0A=
> std::__cxx11::basic_string<char, std::char_traits<char>,=0A=
> std::allocator<char> >*, bool*)+0x324) [0x55a0f74e68b4]=0A=
>  11: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&,=0A=
> rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,=0A=
> std::__cxx11::basic_string<char, std::char_traits<char>,=0A=
> std::allocator<char> >*)+0x22) [0x55a0f74e7002]=0A=
>  12: (RocksDBStore::get(std::__cxx11::basic_string<char,=0A=
> std::char_traits<char>, std::allocator<char> > const&,=0A=
> std::__cxx11::basic_string<char, std::char_traits<char>,=0A=
> std::allocator<char> > const&, ceph::buffer::list*)+0x15d)=0A=
> [0x55a0f740c20d]=0A=
>  13: (BlueStore::Collection::get_onode(ghobject_t const&, bool)+0x54e)=0A=
> [0x55a0f73b62be]=0A=
>  14: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,=0A=
> ObjectStore::Transaction*)+0x903) [0x55a0f73d4b23]=0A=
>  15: (BlueStore::queue_transactions(ObjectStore::Sequencer*,=0A=
> std::vector<ObjectStore::Transaction,=0A=
> std::allocator<ObjectStore::Transaction> >&,=0A=
> std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x436)=0A=
> [0x55a0f73d6e66]=0A=
>  16: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,=0A=
> ObjectStore::Transaction&&, Context*, Context*, Context*,=0A=
> std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x1ab)=0A=
> [0x55a0f6fe0f1b]=0A=
>  17: (PrimaryLogPG::queue_transaction(ObjectStore::Transaction&&,=0A=
> std::shared_ptr<OpRequest>)+0x6a) [0x55a0f716072a]=0A=
>  18: (ReplicatedBackend::_do_push(std::shared_ptr<OpRequest>)+0x545)=0A=
> [0x55a0f7241a15]=0A=
>  19: (ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>)+0x320=
)=0A=
> [0x55a0f7250c60]=0A=
>  20: (PrimaryLogPG::do_request(std::shared_ptr<OpRequest>&,=0A=
> ThreadPool::TPHandle&)+0xbd) [0x55a0f70f708d]=0A=
>  21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,=0A=
> std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x418)=0A=
> [0x55a0f6f91ce8]=0A=
>  22: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>=0A=
> const&)+0x52) [0x55a0f6f91f42]=0A=
>  23: (OSD::ShardedOpWQ::_process(unsigned int,=0A=
> ceph::heartbeat_handle_d*)+0x776) [0x55a0f6fb76e6]=0A=
>  24: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x7f9)=0A=
> [0x55a0f769d129]=0A=
>  25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55a0f76a04e0=
]=0A=
>  26: (()+0x76ba) [0x7f8e1c0c66ba]=0A=
>  27: (clone()+0x6d) [0x7f8e1a79582d]=0A=
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is=0A=
> needed to interpret this.=0A=
>=0A=
> --- logging levels ---=0A=
> --=0A=
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in=
=0A=
> the body of a message to majordomo@vger.kernel.org=0A=
> More majordomo info at  http://vger.kernel.org/majordomo-info.html=0A=
>=0A=
=0A=
