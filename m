From: Kevan Rehm <krehm@cray.com>
Subject: bluestore asserts if I/O size > 4MB when using SSDs
Date: Tue, 12 Jul 2016 17:56:11 +0000
Message-ID: <D3AA996A.B5682%krehm@cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from esa2.cray.iphmx.com ([68.232.143.164]:64513 "EHLO
	esa2.cray.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbcGLR4Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2016 13:56:16 -0400
Content-Language: en-US
Content-ID: <18B1416BA31F9444891E4A6A2F39D884@namprd11.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

Greetings,

I have opened issue #16662 for a bluestore assert that happens when using
SSDs with I/O sizes larger than 4 MB.  Below is the traceback.  Inquiring
minds can look at the issue for an analysis of what is happening.   If you
set 'bluestore_max_alloc_size' to 4194304 in ceph.conf, then you can avoid
this problem.

Cheers, Kevan

     0> 2016-07-12 15:37:03.377685 7f47731a7700 -1
os/bluestore/BlueStore.cc: In function 'int
BlueStore::_do_alloc_write(BlueStore::TransContext*,
BlueStore::WriteContext*)' thread 7f47731a7700 time 2016-07-12
15:37:03.368821
os/bluestore/BlueStore.cc: 5988: FAILED assert(r == 0)

 ceph version 11.0.0-196-g85bb43e
(85bb43e111692989d2296a389ce45377d2297d6f)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x85) [0x7f479212de35]
 2: (BlueStore::_do_alloc_write(BlueStore::TransContext*,
BlueStore::WriteContext*)+0x10af) [0x7f4791d48c4f]
 3: (BlueStore::_do_write(BlueStore::TransContext*,
boost::intrusive_ptr<BlueStore::Collection>&,
boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long,
ceph::buffer::list&, unsigned int)+0x3e9) [0x7f4791d69479]
 4: (BlueStore::_write(BlueStore::TransContext*,
boost::intrusive_ptr<BlueStore::Collection>&,
boost::intrusive_ptr<BlueStore::Onode>&, unsigned long, unsigned long,
ceph::buffer::list&, unsigned int)+0x10f) [0x7f4791d6a0bf]
 5: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
ObjectStore::Transaction*)+0x1127) [0x7f4791d6e297]
 6: (BlueStore::queue_transactions(ObjectStore::Sequencer*,
std::vector<ObjectStore::Transaction,
std::allocator<ObjectStore::Transaction> >&, std::shared_ptr<TrackedOp>,
ThreadPool::TPHandle*)+0x41a) [0x7f4791d7017a]
 7: 
(ReplicatedPG::queue_transactions(std::vector<ObjectStore::Transaction,
std::allocator<ObjectStore::Transaction> >&,
std::shared_ptr<OpRequest>)+0x8c) [0x7f4791bffc4c]
 8: (ReplicatedBackend::submit_transaction(hobject_t const&, eversion_t
const&, std::unique_ptr<PGBackend::PGTransaction,
std::default_delete<PGBackend::PGTransaction> >&&, eversion_t const&,
eversion_t const&, std::vector<pg_log_entry_t,
std::allocator<pg_log_entry_t> > const&,
boost::optional<pg_hit_set_history_t>&, Context*, Context*, Context*,
unsigned long, osd_reqid_t, std::shared_ptr<OpRequest>)+0x94d)
[0x7f4791c3b67d]
 9: (ReplicatedPG::issue_repop(ReplicatedPG::RepGather*,
ReplicatedPG::OpContext*)+0x6af) [0x7f4791b8ba5f]
 10: (ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*)+0xeea)
[0x7f4791bdfeda]
 11: (ReplicatedPG::do_op(std::shared_ptr<OpRequest>&)+0x2843)
[0x7f4791be3853]
 12: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
ThreadPool::TPHandle&)+0x777) [0x7f4791b9e957]
 13: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x41d) [0x7f4791a4d0ad]
 14: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>
const&)+0x6d) [0x7f4791a4d2fd]
 15: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x864) [0x7f4791a6e884]
 16: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x947)
[0x7f4792112147]
 17: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f47921142a0]
 18: (()+0x7dc5) [0x7f478ffd7dc5]
 19: (clone()+0x6d) [0x7f478e1efced]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
to interpret this.



