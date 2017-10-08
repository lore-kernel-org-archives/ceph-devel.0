From: Ugis <ugis22@gmail.com>
Subject: bug in luminous bluestore?
Date: Sun, 8 Oct 2017 20:21:46 +0300
Message-ID: <CAE63xUNB8ZZhyiPDSJqd=kxfaEMLAdTR3bHH8Y6_=pGw=fiQtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:53844 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdJHRVs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Oct 2017 13:21:48 -0400
Received: by mail-it0-f45.google.com with SMTP id n195so10451343itg.2
        for <ceph-devel@vger.kernel.org>; Sun, 08 Oct 2017 10:21:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

ceph version 12.2.1 (3e7492b9ada8bdc9a5cd0feafd42fbca27f9c38e) luminous (stable)
I'm in process of migrating OSDs to bluestore. Several migrations
successful but last one failed. OSD has gone down after some time
backfilling, found some errors in log, tried to start it again, but
same errors appeared and OSD went down. After completing this
bugreport I started OSD again out of curiosity and now it works ok.
During this time I have started another bluestore OSD for backfilling.
Nevertheless errors logged below.

This seems rather like a bug in OSD not HDD problem. I do not see
SMART problems or any issues related to HDD in dmesg for this OSD.

The log:
    -3> 2017-10-08 16:56:31.861941 7f7481b4f700 -1
bluestore(/var/lib/ceph/osd/ceph-3) _txc_add_transaction error (7)
Argument list too long not handled on operation 12 (op 2, counting
from 0)
    -2> 2017-10-08 16:56:31.861960 7f7481b4f700 -1
bluestore(/var/lib/ceph/osd/ceph-3) unexpected error code
    -1> 2017-10-08 16:56:31.861962 7f7481b4f700  0
bluestore(/var/lib/ceph/osd/ceph-3)  transaction dump:
{
    "ops": [
        {
            "op_num": 0,
            "op_name": "remove",
            "collection": "53.67_head",
            "oid":
"#-55:e6289795:::temp_recovering_53.67_273646'437437_280059_head:head#"
        },
        {
            "op_num": 1,
            "op_name": "touch",
            "collection": "53.67_head",
            "oid":
"#-55:e6289795:::temp_recovering_53.67_273646'437437_280059_head:head#"
        },
        {
            "op_num": 2,
            "op_name": "truncate",
            "collection": "53.67_head",
            "oid":
"#-55:e6289795:::temp_recovering_53.67_273646'437437_280059_head:head#",
            "offset": 15560314374
        },
        {
            "op_num": 3,
            "op_name": "op_setallochint",
            "collection": "53.67_head",
            "oid":
"#-55:e6289795:::temp_recovering_53.67_273646'437437_280059_head:head#",
            "expected_object_size": "0",
            "expected_write_size": "0"
        },
        {
            "op_num": 4,
            "op_name": "write",
            "collection": "53.67_head",
            "oid":
"#-55:e6289795:::temp_recovering_53.67_273646'437437_280059_head:head#",
            "length": 8388608,
            "offset": 0,
            "bufferlist length": 8388608
        },
        {
            "op_num": 5,
            "op_name": "setattrs",
            "collection": "53.67_head",
            "oid":
"#-55:e6289795:::temp_recovering_53.67_273646'437437_280059_head:head#",
            "attr_lens": {
                "_": 286,
                "snapset": 31
            }
        }
    ]
}

     0> 2017-10-08 16:56:31.871938 7f7481b4f700 -1
/build/ceph-12.2.1/src/os/bluestore/BlueStore.cc: In function 'void
BlueStore::_txc_add_transaction(BlueStore::TransContext*,
ObjectStore::Transaction*)' thread 7f7481b4f700 time 2017-10-08
16:56:31.862077
/build/ceph-12.2.1/src/os/bluestore/BlueStore.cc: 9299: FAILED
assert(0 == "unexpected error")

 ceph version 12.2.1 (3e7492b9ada8bdc9a5cd0feafd42fbca27f9c38e)
luminous (stable)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x102) [0x55fc757a53f2]
 2: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
ObjectStore::Transaction*)+0x1644) [0x55fc7565f404]
 3: (BlueStore::queue_transactions(ObjectStore::Sequencer*,
std::vector<ObjectStore::Transaction,
std::allocator<ObjectStore::Transaction> >&,
boost::intrusive_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x52e)
[0x55fc75660a7e]
 4: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,
ObjectStore::Transaction&&, Context*, Context*, Context*,
boost::intrusive_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x17c)
[0x55fc7520dd8c]
 5: (PrimaryLogPG::queue_transaction(ObjectStore::Transaction&&,
boost::intrusive_ptr<OpRequest>)+0x58) [0x55fc75399598]
 6: (ReplicatedBackend::_do_push(boost::intrusive_ptr<OpRequest>)+0x391)
[0x55fc754a8a41]
 7: (ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2c1)
[0x55fc754b7a21]
 8: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
[0x55fc753c7aa0]
 9: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0x55d) [0x55fc7532c62d]
 10: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3a9)
[0x55fc751af1a9]
 11: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
const&)+0x57) [0x55fc75448ae7]
 12: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x130e) [0x55fc751d67de]
 13: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x884)
[0x55fc757aa1e4]
 14: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55fc757ad220]
 15: (()+0x76ba) [0x7f749b6d36ba]
 16: (clone()+0x6d) [0x7f749a74a82d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 rbd_mirror
   0/ 5 rbd_replay
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   1/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   1/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/10 civetweb
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
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
  log_file /var/log/ceph/ceph-osd.3.log
--- end dump of recent events ---
2017-10-08 16:56:31.909899 7f7481b4f700 -1 *** Caught signal (Aborted) **
 in thread 7f7481b4f700 thread_name:tp_osd_tp

 ceph version 12.2.1 (3e7492b9ada8bdc9a5cd0feafd42fbca27f9c38e)
luminous (stable)
 1: (()+0xa5a634) [0x55fc75762634]
 2: (()+0x11390) [0x7f749b6dd390]
 3: (gsignal()+0x38) [0x7f749a679428]
 4: (abort()+0x16a) [0x7f749a67b02a]
 5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x28e) [0x55fc757a557e]
 6: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
ObjectStore::Transaction*)+0x1644) [0x55fc7565f404]
 7: (BlueStore::queue_transactions(ObjectStore::Sequencer*,
std::vector<ObjectStore::Transaction,
std::allocator<ObjectStore::Transaction> >&,
boost::intrusive_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x52e)
[0x55fc75660a7e]
 8: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,
ObjectStore::Transaction&&, Context*, Context*, Context*,
boost::intrusive_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x17c)
[0x55fc7520dd8c]
 9: (PrimaryLogPG::queue_transaction(ObjectStore::Transaction&&,
boost::intrusive_ptr<OpRequest>)+0x58) [0x55fc75399598]
 10: (ReplicatedBackend::_do_push(boost::intrusive_ptr<OpRequest>)+0x391)
[0x55fc754a8a41]
 11: (ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2c1)
[0x55fc754b7a21]
 12: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
[0x55fc753c7aa0]
 13: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0x55d) [0x55fc7532c62d]
 14: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3a9)
[0x55fc751af1a9]
 15: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
const&)+0x57) [0x55fc75448ae7]
 16: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x130e) [0x55fc751d67de]
 17: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x884)
[0x55fc757aa1e4]
 18: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55fc757ad220]
 19: (()+0x76ba) [0x7f749b6d36ba]
 20: (clone()+0x6d) [0x7f749a74a82d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- begin dump of recent events ---
     0> 2017-10-08 16:56:31.909899 7f7481b4f700 -1 *** Caught signal
(Aborted) **
 in thread 7f7481b4f700 thread_name:tp_osd_tp

 ceph version 12.2.1 (3e7492b9ada8bdc9a5cd0feafd42fbca27f9c38e)
luminous (stable)
 1: (()+0xa5a634) [0x55fc75762634]
 2: (()+0x11390) [0x7f749b6dd390]
 3: (gsignal()+0x38) [0x7f749a679428]
 4: (abort()+0x16a) [0x7f749a67b02a]
 5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x28e) [0x55fc757a557e]
 6: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
ObjectStore::Transaction*)+0x1644) [0x55fc7565f404]
 7: (BlueStore::queue_transactions(ObjectStore::Sequencer*,
std::vector<ObjectStore::Transaction,
std::allocator<ObjectStore::Transaction> >&,
boost::intrusive_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x52e)
[0x55fc75660a7e]
 8: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,
ObjectStore::Transaction&&, Context*, Context*, Context*,
boost::intrusive_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x17c)
[0x55fc7520dd8c]
 9: (PrimaryLogPG::queue_transaction(ObjectStore::Transaction&&,
boost::intrusive_ptr<OpRequest>)+0x58) [0x55fc75399598]
 10: (ReplicatedBackend::_do_push(boost::intrusive_ptr<OpRequest>)+0x391)
[0x55fc754a8a41]
 11: (ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2c1)
[0x55fc754b7a21]
 12: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
[0x55fc753c7aa0]
 13: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0x55d) [0x55fc7532c62d]
 14: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3a9)
[0x55fc751af1a9]
 15: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
const&)+0x57) [0x55fc75448ae7]
 16: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x130e) [0x55fc751d67de]
 17: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x884)
[0x55fc757aa1e4]
 18: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55fc757ad220]
 19: (()+0x76ba) [0x7f749b6d36ba]
 20: (clone()+0x6d) [0x7f749a74a82d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 rbd_mirror
   0/ 5 rbd_replay
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   1/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   1/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/10 civetweb
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
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
  log_file /var/log/ceph/ceph-osd.3.log
--- end dump of recent events ---

Best regards
Ugis
