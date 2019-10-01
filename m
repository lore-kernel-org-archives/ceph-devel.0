From: Alex Litvak <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: OSD crashed during the fio test
Date: Tue, 1 Oct 2019 01:25:48 -0500
Message-ID: <qmurhc$36ev$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hellow everyone,

Can you shed the line on the cause of the crash?  Could actually client request trigger it?

Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]: 2019-09-30 22:52:58.867 7f093d71e700 -1 bdev(0x55b72c156000 /var/lib/ceph/osd/ceph-17/block) aio_submit retries 16
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]: 2019-09-30 22:52:58.867 7f093d71e700 -1 bdev(0x55b72c156000 /var/lib/ceph/osd/ceph-17/block)  aio submit got (11) Resource temporarily unavailable
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]: 
/home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/14.2.2/rpm/el7/BUILD/ceph-14.2.2/src/os/bluestore/KernelDevice.cc: 
In fun
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]: 
/home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/14.2.2/rpm/el7/BUILD/ceph-14.2.2/src/os/bluestore/KernelDevice.cc: 
757: F
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  ceph version 14.2.2 (4f8fa0a0024755aae7d95567c63f11d6862d55be) nautilus (stable)
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x14a) [0x55b71f668cf4]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  2: (ceph::__ceph_assertf_fail(char const*, char const*, int, char const*, char const*, ...)+0) [0x55b71f668ec2]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  3: (KernelDevice::aio_submit(IOContext*)+0x701) [0x55b71fd61ca1]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  4: (BlueStore::_txc_aio_submit(BlueStore::TransContext*)+0x42) [0x55b71fc29892]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  5: (BlueStore::_txc_state_proc(BlueStore::TransContext*)+0x42b) [0x55b71fc496ab]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  6: (BlueStore::queue_transactions(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, std::vector<ObjectStore::Transaction, 
std::allocator<ObjectStore::Transaction> >&, boost::intrusive_ptr<TrackedOp>, ThreadPool::T
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  7: (non-virtual thunk to PrimaryLogPG::queue_transactions(std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, 
boost::intrusive_ptr<OpRequest>)+0x54) [0x55b71f9b1b84]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  8: (ReplicatedBackend::submit_transaction(hobject_t const&, object_stat_sum_t const&, eversion_t const&, std::unique_ptr<PGTransaction, 
std::default_delete<PGTransaction> >&&, eversion_t const&, eversion_t const&, s
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  9: (PrimaryLogPG::issue_repop(PrimaryLogPG::RepGather*, PrimaryLogPG::OpContext*)+0xf12) [0x55b71f90e322]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  10: (PrimaryLogPG::execute_ctx(PrimaryLogPG::OpContext*)+0xfae) [0x55b71f969b7e]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  11: (PrimaryLogPG::do_op(boost::intrusive_ptr<OpRequest>&)+0x3965) [0x55b71f96de15]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  12: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&, ThreadPool::TPHandle&)+0xbd4) [0x55b71f96f8a4]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  13: (OSD::dequeue_op(boost::intrusive_ptr<PG>, boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x1a9) [0x55b71f7a9ea9]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  14: (PGOpItem::run(OSD*, OSDShard*, boost::intrusive_ptr<PG>&, ThreadPool::TPHandle&)+0x62) [0x55b71fa475d2]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  15: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0x9f4) [0x55b71f7c6ef4]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  16: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x433) [0x55b71fdc5ce3]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  17: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55b71fdc8d80]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  18: (()+0x7dd5) [0x7f0971da9dd5]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  19: (clone()+0x6d) [0x7f0970c7002d]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]: 2019-09-30 22:52:58.879 7f093d71e700 -1 
/home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/14.2.2/rpm/el7/BUILD/ceph-14.2.2/
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]: 
/home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/14.2.2/rpm/el7/BUILD/ceph-14.2.2/src/os/bluestore/KernelDevice.cc: 
757: F
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  ceph version 14.2.2 (4f8fa0a0024755aae7d95567c63f11d6862d55be) nautilus (stable)
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x14a) [0x55b71f668cf4]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  2: (ceph::__ceph_assertf_fail(char const*, char const*, int, char const*, char const*, ...)+0) [0x55b71f668ec2]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  3: (KernelDevice::aio_submit(IOContext*)+0x701) [0x55b71fd61ca1]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  4: (BlueStore::_txc_aio_submit(BlueStore::TransContext*)+0x42) [0x55b71fc29892]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  5: (BlueStore::_txc_state_proc(BlueStore::TransContext*)+0x42b) [0x55b71fc496ab]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  6: (BlueStore::queue_transactions(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, std::vector<ObjectStore::Transaction, 
std::allocator<ObjectStore::Transaction> >&, boost::intrusive_ptr<TrackedOp>, ThreadPool::T
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  7: (non-virtual thunk to PrimaryLogPG::queue_transactions(std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, 
boost::intrusive_ptr<OpRequest>)+0x54) [0x55b71f9b1b84]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  8: (ReplicatedBackend::submit_transaction(hobject_t const&, object_stat_sum_t const&, eversion_t const&, std::unique_ptr<PGTransaction, 
std::default_delete<PGTransaction> >&&, eversion_t const&, eversion_t const&, s
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  9: (PrimaryLogPG::issue_repop(PrimaryLogPG::RepGather*, PrimaryLogPG::OpContext*)+0xf12) [0x55b71f90e322]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  10: (PrimaryLogPG::execute_ctx(PrimaryLogPG::OpContext*)+0xfae) [0x55b71f969b7e]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  11: (PrimaryLogPG::do_op(boost::intrusive_ptr<OpRequest>&)+0x3965) [0x55b71f96de15]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  12: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&, ThreadPool::TPHandle&)+0xbd4) [0x55b71f96f8a4]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  13: (OSD::dequeue_op(boost::intrusive_ptr<PG>, boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x1a9) [0x55b71f7a9ea9]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  14: (PGOpItem::run(OSD*, OSDShard*, boost::intrusive_ptr<PG>&, ThreadPool::TPHandle&)+0x62) [0x55b71fa475d2]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  15: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0x9f4) [0x55b71f7c6ef4]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  16: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x433) [0x55b71fdc5ce3]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  17: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55b71fdc8d80]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  18: (()+0x7dd5) [0x7f0971da9dd5]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  19: (clone()+0x6d) [0x7f0970c7002d]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]: *** Caught signal (Aborted) **
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  in thread 7f093d71e700 thread_name:tp_osd_tp
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  ceph version 14.2.2 (4f8fa0a0024755aae7d95567c63f11d6862d55be) nautilus (stable)
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  1: (()+0xf5d0) [0x7f0971db15d0]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  2: (gsignal()+0x37) [0x7f0970ba82c7]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  3: (abort()+0x148) [0x7f0970ba99b8]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  4: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x199) [0x55b71f668d43]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  5: (ceph::__ceph_assertf_fail(char const*, char const*, int, char const*, char const*, ...)+0) [0x55b71f668ec2]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  6: (KernelDevice::aio_submit(IOContext*)+0x701) [0x55b71fd61ca1]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  7: (BlueStore::_txc_aio_submit(BlueStore::TransContext*)+0x42) [0x55b71fc29892]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  8: (BlueStore::_txc_state_proc(BlueStore::TransContext*)+0x42b) [0x55b71fc496ab]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  9: (BlueStore::queue_transactions(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, std::vector<ObjectStore::Transaction, 
std::allocator<ObjectStore::Transaction> >&, boost::intrusive_ptr<TrackedOp>, ThreadPool::T
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  10: (non-virtual thunk to PrimaryLogPG::queue_transactions(std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, 
boost::intrusive_ptr<OpRequest>)+0x54) [0x55b71f9b1b84]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  11: (ReplicatedBackend::submit_transaction(hobject_t const&, object_stat_sum_t const&, eversion_t const&, std::unique_ptr<PGTransaction, 
std::default_delete<PGTransaction> >&&, eversion_t const&, eversion_t const&,
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  12: (PrimaryLogPG::issue_repop(PrimaryLogPG::RepGather*, PrimaryLogPG::OpContext*)+0xf12) [0x55b71f90e322]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  13: (PrimaryLogPG::execute_ctx(PrimaryLogPG::OpContext*)+0xfae) [0x55b71f969b7e]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  14: (PrimaryLogPG::do_op(boost::intrusive_ptr<OpRequest>&)+0x3965) [0x55b71f96de15]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  15: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&, ThreadPool::TPHandle&)+0xbd4) [0x55b71f96f8a4]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  16: (OSD::dequeue_op(boost::intrusive_ptr<PG>, boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x1a9) [0x55b71f7a9ea9]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  17: (PGOpItem::run(OSD*, OSDShard*, boost::intrusive_ptr<PG>&, ThreadPool::TPHandle&)+0x62) [0x55b71fa475d2]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  18: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0x9f4) [0x55b71f7c6ef4]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  19: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x433) [0x55b71fdc5ce3]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  20: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55b71fdc8d80]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  21: (()+0x7dd5) [0x7f0971da9dd5]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  22: (clone()+0x6d) [0x7f0970c7002d]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]: 2019-09-30 22:52:58.883 7f093d71e700 -1 *** Caught signal (Aborted) **
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  in thread 7f093d71e700 thread_name:tp_osd_tp
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  ceph version 14.2.2 (4f8fa0a0024755aae7d95567c63f11d6862d55be) nautilus (stable)
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  1: (()+0xf5d0) [0x7f0971db15d0]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  2: (gsignal()+0x37) [0x7f0970ba82c7]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  3: (abort()+0x148) [0x7f0970ba99b8]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  4: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x199) [0x55b71f668d43]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  5: (ceph::__ceph_assertf_fail(char const*, char const*, int, char const*, char const*, ...)+0) [0x55b71f668ec2]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  6: (KernelDevice::aio_submit(IOContext*)+0x701) [0x55b71fd61ca1]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  7: (BlueStore::_txc_aio_submit(BlueStore::TransContext*)+0x42) [0x55b71fc29892]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  8: (BlueStore::_txc_state_proc(BlueStore::TransContext*)+0x42b) [0x55b71fc496ab]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  9: (BlueStore::queue_transactions(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, std::vector<ObjectStore::Transaction, 
std::allocator<ObjectStore::Transaction> >&, boost::intrusive_ptr<TrackedOp>, ThreadPool::T
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  10: (non-virtual thunk to PrimaryLogPG::queue_transactions(std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, 
boost::intrusive_ptr<OpRequest>)+0x54) [0x55b71f9b1b84]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  11: (ReplicatedBackend::submit_transaction(hobject_t const&, object_stat_sum_t const&, eversion_t const&, std::unique_ptr<PGTransaction, 
std::default_delete<PGTransaction> >&&, eversion_t const&, eversion_t const&,
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  12: (PrimaryLogPG::issue_repop(PrimaryLogPG::RepGather*, PrimaryLogPG::OpContext*)+0xf12) [0x55b71f90e322]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  13: (PrimaryLogPG::execute_ctx(PrimaryLogPG::OpContext*)+0xfae) [0x55b71f969b7e]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  14: (PrimaryLogPG::do_op(boost::intrusive_ptr<OpRequest>&)+0x3965) [0x55b71f96de15]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  15: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&, ThreadPool::TPHandle&)+0xbd4) [0x55b71f96f8a4]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  16: (OSD::dequeue_op(boost::intrusive_ptr<PG>, boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x1a9) [0x55b71f7a9ea9]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  17: (PGOpItem::run(OSD*, OSDShard*, boost::intrusive_ptr<PG>&, ThreadPool::TPHandle&)+0x62) [0x55b71fa475d2]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  18: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0x9f4) [0x55b71f7c6ef4]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  19: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x433) [0x55b71fdc5ce3]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  20: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55b71fdc8d80]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  21: (()+0x7dd5) [0x7f0971da9dd5]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  22: (clone()+0x6d) [0x7f0970c7002d]
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]: --- begin dump of recent events ---
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9999> 2019-09-30 20:46:02.076 7f0937f13700  5 osd.17 6328 heartbeat osd_stat(store_statfs(0x1a485594000/0x40000000/0x1bf00000000, data 
0x19cfcadc2a/0x1a3aa68000, compress 0x0/0x0/0x0, omap 0xcdefc78, meta 0x3321038
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9998> 2019-09-30 20:46:03.776 7f0937f13700  5 osd.17 6328 heartbeat osd_stat(store_statfs(0x1a485594000/0x40000000/0x1bf00000000, data 
0x19cfcadc2a/0x1a3aa68000, compress 0x0/0x0/0x0, omap 0xcdefc78, meta 0x3321038
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9997> 2019-09-30 20:46:04.277 7f0937f13700  5 osd.17 6328 heartbeat osd_stat(store_statfs(0x1a485594000/0x40000000/0x1bf00000000, data 
0x19cfcadc2a/0x1a3aa68000, compress 0x0/0x0/0x0, omap 0xcdefc78, meta 0x3321038
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9996> 2019-09-30 20:46:04.777 7f0937f13700  5 osd.17 6328 heartbeat osd_stat(store_statfs(0x1a485594000/0x40000000/0x1bf00000000, data 
0x19cfcadc2a/0x1a3aa68000, compress 0x0/0x0/0x0, omap 0xcdefc78, meta 0x3321038
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9995> 2019-09-30 20:46:04.905 7f0950744700  5 bluestore.MempoolThread(0x55b72c210a88) _tune_cache_size target: 8485076992 heap: 398680064 unmapped: 
9035776 mapped: 389644288 old cache_size: 5064831794 new cache siz
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9994> 2019-09-30 20:46:04.905 7f0950744700  5 bluestore.MempoolThread(0x55b72c210a88) _trim_shards cache_size: 5064831794 kv_alloc: 1979711488 
kv_used: 120635251 meta_alloc: 1979711488 meta_used: 117486636 data_all
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9993> 2019-09-30 20:46:05.813 7f094ccd2700 10 monclient: tick
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9992> 2019-09-30 20:46:05.813 7f094ccd2700 10 monclient: _check_auth_rotating have uptodate secrets (they expire after 2019-09-30 20:45:35.819641)
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9991> 2019-09-30 20:46:09.913 7f0950744700  5 bluestore.MempoolThread(0x55b72c210a88) _tune_cache_size target: 8485076992 heap: 398680064 unmapped: 
9035776 mapped: 389644288 old cache_size: 5064831794 new cache siz
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9990> 2019-09-30 20:46:09.913 7f0950744700  5 bluestore.MempoolThread(0x55b72c210a88) _trim_shards cache_size: 5064831794 kv_alloc: 1979711488 
kv_used: 120635251 meta_alloc: 1979711488 meta_used: 117486836 data_all
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9989> 2019-09-30 20:46:10.681 7f0937f13700  5 osd.17 6328 heartbeat osd_stat(store_statfs(0x1a485594000/0x40000000/0x1bf00000000, data 
0x19cfcadc2a/0x1a3aa68000, compress 0x0/0x0/0x0, omap 0xcdefc78, meta 0x3321038
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9988> 2019-09-30 20:46:14.569 7f094dcd4700  2 osd.17 6328 ms_handle_reset con 0x55b72c797000 session 0x55b7401f1800
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9987> 2019-09-30 20:46:14.569 7f096da92700 10 monclient: handle_auth_request added challenge on 0x55b733bf0400
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9986> 2019-09-30 20:46:14.917 7f0950744700  5 bluestore.MempoolThread(0x55b72c210a88) _tune_cache_size target: 8485076992 heap: 398680064 unmapped: 
9035776 mapped: 389644288 old cache_size: 5064831794 new cache siz
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9985> 2019-09-30 20:46:14.917 7f0950744700  5 bluestore.MempoolThread(0x55b72c210a88) _trim_shards cache_size: 5064831794 kv_alloc: 1979711488 
kv_used: 120635251 meta_alloc: 1979711488 meta_used: 117487036 data_all
Sep 30 22:52:58 storage2n2-la ceph-osd-17[10770]:  -9984> 2019-09-30 20:46:15.381 7f0937f13700  5 osd.17 6328 heartbeat osd_stat(store_statfs(0x1a485594000/0x40000000/0x1bf00000000, data 
0x19cfcadc2a/0x1a3aa68000, compress 0x0/0x0/0x0, omap 0xcdefc78, meta 0x3321038
