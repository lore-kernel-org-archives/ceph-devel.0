From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Ceph Luminous - pg is down due to src/osd/SnapMapper.cc: 246: FAILED
 assert(r == -2)
Date: Tue, 16 Jan 2018 02:23:17 +0100
Message-ID: <a02d6d40-e4e7-5f9a-0f9a-b3939f376c70@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:21935 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750918AbeAPBXT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 15 Jan 2018 20:23:19 -0500
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

currently one of my clusters is missing a whole pg due to all 3 osds
being down.

All of them fail with:
    0> 2018-01-16 02:05:33.353293 7f944dbfe700 -1
/build/ceph/src/osd/SnapMapper.cc: In function 'void
SnapMapper::add_oid(const hobject_t&, const std::set<snapid_t>&,
MapCacher::Transaction<std::basic_string<char>, ceph::buffer::list>*)'
thread 7f944dbfe700 time 2018-01-16 02:05:33.349946
/build/ceph/src/osd/SnapMapper.cc: 246: FAILED assert(r == -2)

 ceph version 12.2.2-93-gd6da8d7
(d6da8d77a4b2220e6bdd61e4bdd911a9cd91946c) luminous (stable)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x102) [0x561f9ff0b1e2]
 2: (SnapMapper::add_oid(hobject_t const&, std::set<snapid_t,
std::less<snapid_t>, std::allocator<snapid_t> > const&,
MapCacher::Transaction<std::string, ceph::buffer::list>*)+0x64b)
[0x561f9fb76f3b]
 3: (PG::update_snap_map(std::vector<pg_log_entry_t,
std::allocator<pg_log_entry_t> > const&,
ObjectStore::Transaction&)+0x38f) [0x561f9fa0ae3f]
 4: (PG::append_log(std::vector<pg_log_entry_t,
std::allocator<pg_log_entry_t> > const&, eversion_t, eversion_t,
ObjectStore::Transaction&, bool)+0x538) [0x561f9fa31018]
 5: (PrimaryLogPG::log_operation(std::vector<pg_log_entry_t,
std::allocator<pg_log_entry_t> > const&,
boost::optional<pg_hit_set_history_t> const&, eversion_t const&,
eversion_t const&, bool, ObjectStore::Transaction&)+0x64) [0x561f9fb25d64]
 6: (ReplicatedBackend::do_repop(boost::intrusive_ptr<OpRequest>)+0xa92)
[0x561f9fc314b2]
 7:
(ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2a4)
[0x561f9fc374f4]
 8: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
[0x561f9fb5cf10]
 9: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0x77b) [0x561f9fac91eb]
 10: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f7)
[0x561f9f955bc7]
 11: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
const&)+0x57) [0x561f9fbcd947]
 12: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x108c) [0x561f9f984d1c]
 13: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x88d)
[0x561f9ff10e6d]
 14: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x561f9ff12e30]
 15: (()+0x8064) [0x7f949afcb064]
 16: (clone()+0x6d) [0x7f949a0bf62d]
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
   1/ 1 reserver
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
   1/ 5 bluestore
   1/ 5 bluefs
   1/ 3 bdev
   1/ 5 kstore
   4/ 5 rocksdb
   4/ 5 leveldb
   4/ 5 memdb
   1/ 5 kinetic
   1/ 5 fuse
   1/ 5 mgr
   1/ 5 mgrc
   1/ 5 dpdk
   1/ 5 eventtrace
  -2/-2 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/ceph-osd.47.log
--- end dump of recent events ---
2018-01-16 02:05:33.357616 7f944dbfe700 -1 *** Caught signal (Aborted) **
 in thread 7f944dbfe700 thread_name:tp_osd_tp

 ceph version 12.2.2-93-gd6da8d7
(d6da8d77a4b2220e6bdd61e4bdd911a9cd91946c) luminous (stable)
 1: (()+0xa43dec) [0x561f9fec7dec]
 2: (()+0xf890) [0x7f949afd2890]
 3: (gsignal()+0x37) [0x7f949a00c067]
 4: (abort()+0x148) [0x7f949a00d448]
 5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x27f) [0x561f9ff0b35f]
 6: (SnapMapper::add_oid(hobject_t const&, std::set<snapid_t,
std::less<snapid_t>, std::allocator<snapid_t> > const&,
MapCacher::Transaction<std::string, ceph::buffer::list>*)+0x64b)
[0x561f9fb76f3b]
 7: (PG::update_snap_map(std::vector<pg_log_entry_t,
std::allocator<pg_log_entry_t> > const&,
ObjectStore::Transaction&)+0x38f) [0x561f9fa0ae3f]
 8: (PG::append_log(std::vector<pg_log_entry_t,
std::allocator<pg_log_entry_t> > const&, eversion_t, eversion_t,
ObjectStore::Transaction&, bool)+0x538) [0x561f9fa31018]
 9: (PrimaryLogPG::log_operation(std::vector<pg_log_entry_t,
std::allocator<pg_log_entry_t> > const&,
boost::optional<pg_hit_set_history_t> const&, eversion_t const&,
eversion_t const&, bool, ObjectStore::Transaction&)+0x64) [0x561f9fb25d64]
 10:
(ReplicatedBackend::do_repop(boost::intrusive_ptr<OpRequest>)+0xa92)
[0x561f9fc314b2]
 11:
(ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2a4)
[0x561f9fc374f4]
 12: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
[0x561f9fb5cf10]
 13: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0x77b) [0x561f9fac91eb]
 14: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f7)
[0x561f9f955bc7]
 15: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
const&)+0x57) [0x561f9fbcd947]
 16: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x108c) [0x561f9f984d1c]
 17: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x88d)
[0x561f9ff10e6d]
 18: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x561f9ff12e30]
 19: (()+0x8064) [0x7f949afcb064]
 20: (clone()+0x6d) [0x7f949a0bf62d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- begin dump of recent events ---
     0> 2018-01-16 02:05:33.357616 7f944dbfe700 -1 *** Caught signal
(Aborted) **
 in thread 7f944dbfe700 thread_name:tp_osd_tp

 ceph version 12.2.2-93-gd6da8d7
(d6da8d77a4b2220e6bdd61e4bdd911a9cd91946c) luminous (stable)
 1: (()+0xa43dec) [0x561f9fec7dec]
 2: (()+0xf890) [0x7f949afd2890]
 3: (gsignal()+0x37) [0x7f949a00c067]
 4: (abort()+0x148) [0x7f949a00d448]
 5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x27f) [0x561f9ff0b35f]
 6: (SnapMapper::add_oid(hobject_t const&, std::set<snapid_t,
std::less<snapid_t>, std::allocator<snapid_t> > const&,
MapCacher::Transaction<std::string, ceph::buffer::list>*)+0x64b)
[0x561f9fb76f3b]
 7: (PG::update_snap_map(std::vector<pg_log_entry_t,
std::allocator<pg_log_entry_t> > const&,
ObjectStore::Transaction&)+0x38f) [0x561f9fa0ae3f]
 8: (PG::append_log(std::vector<pg_log_entry_t,
std::allocator<pg_log_entry_t> > const&, eversion_t, eversion_t,
ObjectStore::Transaction&, bool)+0x538) [0x561f9fa31018]
 9: (PrimaryLogPG::log_operation(std::vector<pg_log_entry_t,
std::allocator<pg_log_entry_t> > const&,
boost::optional<pg_hit_set_history_t> const&, eversion_t const&,
eversion_t const&, bool, ObjectStore::Transaction&)+0x64) [0x561f9fb25d64]
 10:
(ReplicatedBackend::do_repop(boost::intrusive_ptr<OpRequest>)+0xa92)
[0x561f9fc314b2]
 11:
(ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2a4)
[0x561f9fc374f4]
 12: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
[0x561f9fb5cf10]
 13: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0x77b) [0x561f9fac91eb]
 14: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f7)
[0x561f9f955bc7]
 15: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
const&)+0x57) [0x561f9fbcd947]
 16: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x108c) [0x561f9f984d1c]
 17: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x88d)
[0x561f9ff10e6d]
 18: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x561f9ff12e30]
 19: (()+0x8064) [0x7f949afcb064]
 20: (clone()+0x6d) [0x7f949a0bf62d]
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
   1/ 1 reserver
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
   1/ 5 bluestore
   1/ 5 bluefs
   1/ 3 bdev
   1/ 5 kstore
   4/ 5 rocksdb
   4/ 5 leveldb
   4/ 5 memdb
   1/ 5 kinetic
   1/ 5 fuse
   1/ 5 mgr
   1/ 5 mgrc
   1/ 5 dpdk
   1/ 5 eventtrace
  -2/-2 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/ceph-osd.47.log
--- end dump of recent events ---

Any chance to fix this?

Greets,
Stefan
