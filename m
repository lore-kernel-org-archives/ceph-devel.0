From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 21 Sep 2017 06:44:38 +0000 (UTC)
Message-ID: <59c35fd644174_6fbe71733478b1@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.hv1nn.shared.sendgrid.net ([167.89.100.17]:59132 "EHLO
        o2.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751806AbdIUGoj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 21 Sep 2017 02:44:39 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0001p1sjc2.sendgrid.net (SG) with ESMTP id heoNpJ9sSXSlOrpfCIgg0w
        for <ceph-devel@vger.kernel.org>; Thu, 21 Sep 2017 06:44:38.326 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

35 new defect(s) introduced to ceph found with Coverity Scan.
40 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 35 defect(s)


** CID 1418233:  Integer handling issues  (NEGATIVE_RETURNS)
/home/brad/working/src/ceph/src/common/lockdep.cc: 299 in lockdep_will_lock(const char *, int, bool)()


________________________________________________________________________________________________________
*** CID 1418233:  Integer handling issues  (NEGATIVE_RETURNS)
/home/brad/working/src/ceph/src/common/lockdep.cc: 299 in lockdep_will_lock(const char *, int, bool)()
293       if (!g_lockdep) {
294         pthread_mutex_unlock(&lockdep_mutex);
295         return id;
296       }
297     
298       if (id < 0)
>>>     CID 1418233:  Integer handling issues  (NEGATIVE_RETURNS)
>>>     Assigning: signed variable "id" = "_lockdep_register".
299         id = _lockdep_register(name);
300     
301       lockdep_dout(20) << "_will_lock " << name << " (" << id << ")" << dendl;
302     
303       // check dependency graph
304       map<int, BackTrace *> &m = held[p];

** CID 1418234:    (LOCK)
/home/brad/working/src/ceph/src/librbd/io/ImageRequestWQ.cc: 584 in librbd::io::ImageRequestWQ<librbd::<unnamed>::MockTestImageCtx>::_void_dequeue()()
/home/brad/working/src/ceph/src/librbd/io/ImageRequestWQ.cc: 601 in librbd::io::ImageRequestWQ<librbd::<unnamed>::MockTestImageCtx>::_void_dequeue()()
/home/brad/working/src/ceph/src/librbd/io/ImageRequestWQ.cc: 597 in librbd::io::ImageRequestWQ<librbd::<unnamed>::MockTestImageCtx>::_void_dequeue()()


________________________________________________________________________________________________________
*** CID 1418234:    (LOCK)
/home/brad/working/src/ceph/src/librbd/io/ImageRequestWQ.cc: 584 in librbd::io::ImageRequestWQ<librbd::<unnamed>::MockTestImageCtx>::_void_dequeue()()
578           lock_required = false;
579         }
580         m_image_ctx.owner_lock.put_read();
581         this->get_pool_lock().Lock();
582     
583         if (lock_required) {
>>>     CID 1418234:    (LOCK)
>>>     Returning without unlocking "this->get_pool_lock()._m".
584           return nullptr;
585         }
586       }
587     
588       if (refresh_required) {
589         ldout(cct, 5) << "image refresh required: delaying IO " << item << dendl;
/home/brad/working/src/ceph/src/librbd/io/ImageRequestWQ.cc: 601 in librbd::io::ImageRequestWQ<librbd::<unnamed>::MockTestImageCtx>::_void_dequeue()()
595         m_image_ctx.state->refresh(new C_RefreshFinish(this, item));
596         this->get_pool_lock().Lock();
597         return nullptr;
598       }
599     
600       item->start_op();
>>>     CID 1418234:    (LOCK)
>>>     Returning without unlocking "this->get_pool_lock()._m".
601       return item;
602     }
603     
604     template <typename I>
605     void ImageRequestWQ<I>::process(ImageRequest<I> *req) {
606       CephContext *cct = m_image_ctx.cct;
/home/brad/working/src/ceph/src/librbd/io/ImageRequestWQ.cc: 597 in librbd::io::ImageRequestWQ<librbd::<unnamed>::MockTestImageCtx>::_void_dequeue()()
591         // stall IO until the refresh completes
592         ++m_io_blockers;
593     
594         this->get_pool_lock().Unlock();
595         m_image_ctx.state->refresh(new C_RefreshFinish(this, item));
596         this->get_pool_lock().Lock();
>>>     CID 1418234:    (LOCK)
>>>     Returning without unlocking "this->get_pool_lock()._m".
597         return nullptr;
598       }
599     
600       item->start_op();
601       return item;
602     }

** CID 1418235:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/rocksdb/utilities/transactions/pessimistic_transaction.cc: 522 in rocksdb::PessimisticTransaction::TryLock(rocksdb::ColumnFamilyHandle *, const rocksdb::Slice &, bool, bool, bool)()


________________________________________________________________________________________________________
*** CID 1418235:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/rocksdb/utilities/transactions/pessimistic_transaction.cc: 522 in rocksdb::PessimisticTransaction::TryLock(rocksdb::ColumnFamilyHandle *, const rocksdb::Slice &, bool, bool, bool)()
516     
517           if (!s.ok()) {
518             // Failed to validate key
519             if (!previously_locked) {
520               // Unlock key we just locked
521               if (lock_upgrade) {
>>>     CID 1418235:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach the expression "(s) = (rocksdb::Status(this->txn_db_impl_->TryLock(this, cfh_id, key_str, false)))" inside this statement: "(s) = (rocksdb::Status(this...".
522                 s = txn_db_impl_->TryLock(this, cfh_id, key_str,
523                                           false /* exclusive */);
524                 assert(s.ok());
525               } else {
526                 txn_db_impl_->UnLock(this, cfh_id, key.ToString());
527               }

** CID 1418236:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/utilities/transactions/write_prepared_txn.cc: 30 in rocksdb::WritePreparedTxn::WritePreparedTxn(rocksdb::WritePreparedTxnDB *, const rocksdb::WriteOptions &, const rocksdb::TransactionOptions &)()


________________________________________________________________________________________________________
*** CID 1418236:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/utilities/transactions/write_prepared_txn.cc: 30 in rocksdb::WritePreparedTxn::WritePreparedTxn(rocksdb::WritePreparedTxnDB *, const rocksdb::WriteOptions &, const rocksdb::TransactionOptions &)()
24     WritePreparedTxn::WritePreparedTxn(WritePreparedTxnDB* txn_db,
25                                        const WriteOptions& write_options,
26                                        const TransactionOptions& txn_options)
27         : PessimisticTransaction(txn_db, write_options, txn_options),
28           wpt_db_(txn_db) {
29       PessimisticTransaction::Initialize(txn_options);
>>>     CID 1418236:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "prepare_seq_" is not initialized in this constructor nor in any functions that it calls.
30     }
31     
32     Status WritePreparedTxn::Get(const ReadOptions& read_options,
33                                  ColumnFamilyHandle* column_family,
34                                  const Slice& key, PinnableSlice* pinnable_val) {
35       auto snapshot = GetSnapshot();

** CID 1418237:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rocksdb/db/c.cc: 585 in rocksdb_checkpoint_object_create()


________________________________________________________________________________________________________
*** CID 1418237:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rocksdb/db/c.cc: 585 in rocksdb_checkpoint_object_create()
579     }
580     
581     rocksdb_checkpoint_t* rocksdb_checkpoint_object_create(rocksdb_t* db,
582                                                            char** errptr) {
583       Checkpoint* checkpoint;
584       if (SaveError(errptr, Checkpoint::Create(db->rep, &checkpoint))) {
>>>     CID 1418237:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "checkpoint" going out of scope leaks the storage it points to.
585         return nullptr;
586       }
587       rocksdb_checkpoint_t* result = new rocksdb_checkpoint_t;
588       result->rep = checkpoint;
589       return result;
590     }

** CID 1418238:  Control flow issues  (UNREACHABLE)
/home/brad/working/src/ceph/src/rocksdb/utilities/transactions/write_prepared_txn.cc: 103 in rocksdb::WritePreparedTxn::Rollback()()


________________________________________________________________________________________________________
*** CID 1418238:  Control flow issues  (UNREACHABLE)
/home/brad/working/src/ceph/src/rocksdb/utilities/transactions/write_prepared_txn.cc: 103 in rocksdb::WritePreparedTxn::Rollback()()
97       return s;
98     }
99     
100     Status WritePreparedTxn::Rollback() {
101       // TODO(myabandeh) Implement this
102       throw std::runtime_error("Rollback not Implemented");
>>>     CID 1418238:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "return rocksdb::Status(rock...".
103       return Status::OK();
104     }
105     
106     }  // namespace rocksdb
107     

** CID 1418239:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rocksdb/utilities/write_batch_with_index/write_batch_with_index.cc: 853 in rocksdb::WriteBatchWithIndex::GetFromBatchAndDB(rocksdb::DB *, const rocksdb::ReadOptions &, rocksdb::ColumnFamilyHandle *, const rocksdb::Slice &, rocksdb::PinnableSlice *, rocksdb::ReadCallback *)()


________________________________________________________________________________________________________
*** CID 1418239:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rocksdb/utilities/write_batch_with_index/write_batch_with_index.cc: 853 in rocksdb::WriteBatchWithIndex::GetFromBatchAndDB(rocksdb::DB *, const rocksdb::ReadOptions &, rocksdb::ColumnFamilyHandle *, const rocksdb::Slice &, rocksdb::PinnableSlice *, rocksdb::ReadCallback *)()
847           Logger* logger = immuable_db_options.info_log.get();
848     
849           Slice* merge_data;
850           if (s.ok()) {
851             merge_data = pinnable_val;
852           } else {  // Key not present in db (s.IsNotFound())
>>>     CID 1418239:  Null pointer dereferences  (FORWARD_NULL)
>>>     Assigning: "merge_data" = "NULL".
853             merge_data = nullptr;
854           }
855     
856           if (merge_operator) {
857             s = MergeHelper::TimedFullMerge(
858                 merge_operator, key, merge_data, merge_context.GetOperands(),

** CID 1418240:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 48203 in __pyx_pw_5rados_5Ioctx_127application_metadata_set()


________________________________________________________________________________________________________
*** CID 1418240:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 48203 in __pyx_pw_5rados_5Ioctx_127application_metadata_set()
48197           }
48198           kw_args = PyDict_Size(__pyx_kwds);
48199           switch (pos_args) {
48200             case  0:
48201             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_app_name)) != 0)) kw_args--;
48202             else goto __pyx_L5_argtuple_error;
>>>     CID 1418240:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
48203             case  1:
48204             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_key)) != 0)) kw_args--;
48205             else {
48206               __Pyx_RaiseArgtupleInvalid("application_metadata_set", 1, 3, 3, 1); __PYX_ERR(0, 3643, __pyx_L3_error)
48207             }
48208             case  2:

** CID 1418241:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 47475 in __pyx_pw_5rados_5Ioctx_123application_enable()


________________________________________________________________________________________________________
*** CID 1418241:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 47475 in __pyx_pw_5rados_5Ioctx_123application_enable()
47469           }
47470           kw_args = PyDict_Size(__pyx_kwds);
47471           switch (pos_args) {
47472             case  0:
47473             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_app_name)) != 0)) kw_args--;
47474             else goto __pyx_L5_argtuple_error;
>>>     CID 1418241:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
47475             case  1:
47476             if (kw_args > 0) {
47477               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_force);
47478               if (value) { values[1] = value; kw_args--; }
47479             }
47480           }

** CID 1418242:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/dmclock/src/dmclock_server.h: 326 in crimson::dmclock::PriorityQueueBase<ceph::mClockOpClassQueue::osd_op_type_t, std::pair<spg_t, PGQueueable>, (bool)0, (unsigned int)2>::ClientRec::ClientRec(ceph::mClockOpClassQueue::osd_op_type_t, const crimson::dmclock::ClientInfo &, unsigned long)()
/home/brad/working/src/ceph/src/dmclock/src/dmclock_server.h: 326 in crimson::dmclock::PriorityQueueBase<Client, Request, (bool)0, (unsigned int)2>::ClientRec::ClientRec(Client, const crimson::dmclock::ClientInfo &, unsigned long)()


________________________________________________________________________________________________________
*** CID 1418242:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/dmclock/src/dmclock_server.h: 326 in crimson::dmclock::PriorityQueueBase<ceph::mClockOpClassQueue::osd_op_type_t, std::pair<spg_t, PGQueueable>, (bool)0, (unsigned int)2>::ClientRec::ClientRec(ceph::mClockOpClassQueue::osd_op_type_t, const crimson::dmclock::ClientInfo &, unsigned long)()
320     	  idle(true),
321     	  last_tick(current_tick),
322     	  cur_rho(1),
323     	  cur_delta(1)
324     	{
325     	  // empty
>>>     CID 1418242:    (UNINIT_CTOR)
>>>     Non-static class member "ready_heap_data" is not initialized in this constructor nor in any functions that it calls.
326     	}
327     
328     	inline const RequestTag& get_req_tag() const {
329     	  return prev_tag;
330     	}
331     
/home/brad/working/src/ceph/src/dmclock/src/dmclock_server.h: 326 in crimson::dmclock::PriorityQueueBase<Client, Request, (bool)0, (unsigned int)2>::ClientRec::ClientRec(Client, const crimson::dmclock::ClientInfo &, unsigned long)()
320     	  idle(true),
321     	  last_tick(current_tick),
322     	  cur_rho(1),
323     	  cur_delta(1)
324     	{
325     	  // empty
>>>     CID 1418242:    (UNINIT_CTOR)
>>>     Non-static class member "ready_heap_data" is not initialized in this constructor nor in any functions that it calls.
326     	}
327     
328     	inline const RequestTag& get_req_tag() const {
329     	  return prev_tag;
330     	}
331     

** CID 1418243:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1874 in shutdown_racer_func()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1873 in shutdown_racer_func()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1872 in shutdown_racer_func()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1871 in shutdown_racer_func()()


________________________________________________________________________________________________________
*** CID 1418243:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1874 in shutdown_racer_func()()
1868     {
1869       struct ceph_mount_info *cmount;
1870     
1871       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
1872       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
1873       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
>>>     CID 1418243:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1874       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1875       ceph_shutdown(cmount);
1876     }
1877     
1878     // See tracker #20988
1879     TEST(LibCephFS, ShutdownRace)
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1873 in shutdown_racer_func()()
1867     static void shutdown_racer_func()
1868     {
1869       struct ceph_mount_info *cmount;
1870     
1871       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
1872       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
>>>     CID 1418243:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1873       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
1874       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1875       ceph_shutdown(cmount);
1876     }
1877     
1878     // See tracker #20988
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1872 in shutdown_racer_func()()
1866     
1867     static void shutdown_racer_func()
1868     {
1869       struct ceph_mount_info *cmount;
1870     
1871       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
>>>     CID 1418243:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1872       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
1873       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
1874       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1875       ceph_shutdown(cmount);
1876     }
1877     
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1871 in shutdown_racer_func()()
1865     #define NTHREADS 128
1866     
1867     static void shutdown_racer_func()
1868     {
1869       struct ceph_mount_info *cmount;
1870     
>>>     CID 1418243:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1871       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
1872       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
1873       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
1874       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1875       ceph_shutdown(cmount);
1876     }

** CID 1418244:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/dmclock/src/dmclock_server.h: 326 in crimson::dmclock::PriorityQueueBase<std::pair<unsigned long, ceph::mClockClientQueue::osd_op_type_t>, std::pair<spg_t, PGQueueable>, (bool)0, (unsigned int)2>::ClientRec::ClientRec(std::pair<unsigned long, ceph::mClockClientQueue::osd_op_type_t>, const crimson::dmclock::ClientInfo &, unsigned long)()


________________________________________________________________________________________________________
*** CID 1418244:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/dmclock/src/dmclock_server.h: 326 in crimson::dmclock::PriorityQueueBase<std::pair<unsigned long, ceph::mClockClientQueue::osd_op_type_t>, std::pair<spg_t, PGQueueable>, (bool)0, (unsigned int)2>::ClientRec::ClientRec(std::pair<unsigned long, ceph::mClockClientQueue::osd_op_type_t>, const crimson::dmclock::ClientInfo &, unsigned long)()
320     	  idle(true),
321     	  last_tick(current_tick),
322     	  cur_rho(1),
323     	  cur_delta(1)
324     	{
325     	  // empty
>>>     CID 1418244:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "ready_heap_data" is not initialized in this constructor nor in any functions that it calls.
326     	}
327     
328     	inline const RequestTag& get_req_tag() const {
329     	  return prev_tag;
330     	}
331     

** CID 1418245:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/utilities/blob_db/blob_db_impl.cc: 266 in rocksdb::blob_db::BlobDBImpl::BlobDBImpl(rocksdb::DB *, const rocksdb::blob_db::BlobDBOptions &)()


________________________________________________________________________________________________________
*** CID 1418245:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/utilities/blob_db/blob_db_impl.cc: 266 in rocksdb::blob_db::BlobDBImpl::BlobDBImpl(rocksdb::DB *, const rocksdb::blob_db::BlobDBOptions &)()
260           total_periods_ampl_(0),
261           total_blob_space_(0) {
262       if (!bdb_options_.blob_dir.empty())
263         blob_dir_ = (bdb_options_.path_relative)
264                         ? db_->GetName() + "/" + bdb_options_.blob_dir
265                         : bdb_options_.blob_dir;
>>>     CID 1418245:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "debug_level_" is not initialized in this constructor nor in any functions that it calls.
266     }
267     
268     BlobDBImpl::~BlobDBImpl() {
269       // CancelAllBackgroundWork(db_, true);
270     
271       Shutdown();

** CID 1418246:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/util/file_reader_writer.h: 207 in rocksdb::FilePrefetchBuffer::FilePrefetchBuffer()()


________________________________________________________________________________________________________
*** CID 1418246:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/util/file_reader_writer.h: 207 in rocksdb::FilePrefetchBuffer::FilePrefetchBuffer()()
201       Status Prefetch(RandomAccessFileReader* reader, uint64_t offset, size_t n);
202       bool TryReadFromCache(uint64_t offset, size_t n, Slice* result) const;
203     
204      private:
205       AlignedBuffer buffer_;
206       uint64_t buffer_offset_;
>>>     CID 1418246:  Uninitialized members  (UNINIT_CTOR)
>>>     The compiler-generated constructor for this class does not initialize "buffer_len_".
207       size_t buffer_len_;
208     };
209     
210     extern Status NewWritableFile(Env* env, const std::string& fname,
211                                   unique_ptr<WritableFile>* result,
212                                   const EnvOptions& options);

** CID 1418247:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/memtable/hash_linklist_rep.cc: 86 in rocksdb::<unnamed>::Node::Node()()


________________________________________________________________________________________________________
*** CID 1418247:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/memtable/hash_linklist_rep.cc: 86 in rocksdb::<unnamed>::Node::Node()()
80         return next_.load(std::memory_order_relaxed);
81       }
82     
83       void NoBarrier_SetNext(Node* x) { next_.store(x, std::memory_order_relaxed); }
84     
85       // Needed for placement new below which is fine
>>>     CID 1418247:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member field "next_._M_b" is not initialized in this constructor nor in any functions that it calls.
86       Node() {}
87     
88      private:
89       std::atomic<Node*> next_;
90     
91       // Prohibit copying due to the below

** CID 1418248:  Control flow issues  (UNREACHABLE)
/src/pybind/rados/rados.c: 49517 in __pyx_pf_5rados_5Ioctx_130application_metadata_list()


________________________________________________________________________________________________________
*** CID 1418248:  Control flow issues  (UNREACHABLE)
/src/pybind/rados/rados.c: 49517 in __pyx_pf_5rados_5Ioctx_130application_metadata_list()
49511      * 
49512      * 
49513      */
49514           free(__pyx_v_c_vals);
49515           goto __pyx_L5;
49516         }
>>>     CID 1418248:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  PyThreadState *__pyx_ts...".
49517         /*exception exit:*/{
49518           __Pyx_PyThreadState_declare
49519           __pyx_L4_error:;
49520           __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0; __pyx_t_18 = 0; __pyx_t_19 = 0; __pyx_t_20 = 0;
49521           __Pyx_PyThreadState_assign
49522           __Pyx_XDECREF(__pyx_t_12); __pyx_t_12 = 0;

** CID 1418249:  Memory - illegal accesses  (WRAPPER_ESCAPE)
/home/brad/working/src/ceph/src/rocksdb/table/format.cc: 450 in rocksdb::ReadBlockContents(rocksdb::RandomAccessFileReader *, rocksdb::FilePrefetchBuffer *, const rocksdb::Footer &, const rocksdb::ReadOptions &, const rocksdb::BlockHandle &, rocksdb::BlockContents *, const rocksdb::ImmutableCFOptions &, bool, const rocksdb::Slice &, const rocksdb::PersistentCacheOptions &)()


________________________________________________________________________________________________________
*** CID 1418249:  Memory - illegal accesses  (WRAPPER_ESCAPE)
/home/brad/working/src/ceph/src/rocksdb/table/format.cc: 450 in rocksdb::ReadBlockContents(rocksdb::RandomAccessFileReader *, rocksdb::FilePrefetchBuffer *, const rocksdb::Footer &, const rocksdb::ReadOptions &, const rocksdb::BlockHandle &, rocksdb::BlockContents *, const rocksdb::ImmutableCFOptions &, bool, const rocksdb::Slice &, const rocksdb::PersistentCacheOptions &)()
444         // the slice content is not the buffer provided
445         *contents = BlockContents(Slice(slice.data(), n), false, compression_type);
446       } else {
447         // page is uncompressed, the buffer either stack or heap provided
448         if (got_from_prefetch_buffer || used_buf == &stack_buf[0]) {
449           heap_buf = std::unique_ptr<char[]>(new char[n]);
>>>     CID 1418249:  Memory - illegal accesses  (WRAPPER_ESCAPE)
>>>     Using invalidated internal representation of local "used_buf".
450           memcpy(heap_buf.get(), used_buf, n);
451         }
452         *contents = BlockContents(std::move(heap_buf), n, true, compression_type);
453       }
454     
455       if (status.ok() && !got_from_prefetch_buffer && read_options.fill_cache &&

** CID 1418250:    (BAD_SHIFT)
/home/brad/working/src/ceph/src/common/lockdep.cc: 321 in lockdep_will_lock(const char *, int, bool)()
/home/brad/working/src/ceph/src/common/lockdep.cc: 356 in lockdep_will_lock(const char *, int, bool)()


________________________________________________________________________________________________________
*** CID 1418250:    (BAD_SHIFT)
/home/brad/working/src/ceph/src/common/lockdep.cc: 321 in lockdep_will_lock(const char *, int, bool)()
315     	p->second->print(*_dout);
316           }
317           delete bt;
318           *_dout << dendl;
319           ceph_abort();
320         }
>>>     CID 1418250:    (BAD_SHIFT)
>>>     In expression "1 << id % 8", shifting by a negative amount has undefined behavior.  The shift amount, "id % 8", is -1.
321         else if (!(follows[p->first][id/8] & (1 << (id % 8)))) {
322           // new dependency
323     
324           // did we just create a cycle?
325           if (does_follow(id, p->first)) {
326             BackTrace *bt = new BackTrace(BACKTRACE_SKIP);
/home/brad/working/src/ceph/src/common/lockdep.cc: 356 in lockdep_will_lock(const char *, int, bool)()
350     	ceph_abort();  // actually, we should just die here.
351           } else {
352             BackTrace *bt = NULL;
353             if (force_backtrace || lockdep_force_backtrace()) {
354               bt = new BackTrace(BACKTRACE_SKIP);
355             }
>>>     CID 1418250:    (BAD_SHIFT)
>>>     In expression "1 << id % 8", shifting by a negative amount has undefined behavior.  The shift amount, "id % 8", is -1.
356             follows[p->first][id/8] |= 1 << (id % 8);
357             follows_bt[p->first][id] = bt;
358     	lockdep_dout(10) << lock_names[p->first] << " -> " << name << " at" << dendl;
359     	//bt->print(*_dout);
360           }
361         }

** CID 1418251:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 48208 in __pyx_pw_5rados_5Ioctx_127application_metadata_set()


________________________________________________________________________________________________________
*** CID 1418251:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 48208 in __pyx_pw_5rados_5Ioctx_127application_metadata_set()
48202             else goto __pyx_L5_argtuple_error;
48203             case  1:
48204             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_key)) != 0)) kw_args--;
48205             else {
48206               __Pyx_RaiseArgtupleInvalid("application_metadata_set", 1, 3, 3, 1); __PYX_ERR(0, 3643, __pyx_L3_error)
48207             }
>>>     CID 1418251:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
48208             case  2:
48209             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_value)) != 0)) kw_args--;
48210             else {
48211               __Pyx_RaiseArgtupleInvalid("application_metadata_set", 1, 3, 3, 2); __PYX_ERR(0, 3643, __pyx_L3_error)
48212             }
48213           }

** CID 1418252:    (CHECKED_RETURN)
/home/brad/working/src/ceph/src/rocksdb/db/merge_helper.cc: 135 in rocksdb::MergeHelper::MergeUntil(rocksdb::InternalIterator *, rocksdb::RangeDelAggregator *, unsigned long, bool)()
/home/brad/working/src/ceph/src/rocksdb/db/merge_helper.cc: 249 in rocksdb::MergeHelper::MergeUntil(rocksdb::InternalIterator *, rocksdb::RangeDelAggregator *, unsigned long, bool)()


________________________________________________________________________________________________________
*** CID 1418252:    (CHECKED_RETURN)
/home/brad/working/src/ceph/src/rocksdb/db/merge_helper.cc: 135 in rocksdb::MergeHelper::MergeUntil(rocksdb::InternalIterator *, rocksdb::RangeDelAggregator *, unsigned long, bool)()
129       bool original_key_is_iter = true;
130       std::string original_key = iter->key().ToString();
131       // Important:
132       // orig_ikey is backed by original_key if keys_.empty()
133       // orig_ikey is backed by keys_.back() if !keys_.empty()
134       ParsedInternalKey orig_ikey;
>>>     CID 1418252:    (CHECKED_RETURN)
>>>     Calling "ParseInternalKey" without checking return value (as is done elsewhere 25 out of 31 times).
135       ParseInternalKey(original_key, &orig_ikey);
136     
137       Status s;
138       bool hit_the_next_user_key = false;
139       for (; iter->Valid(); iter->Next(), original_key_is_iter = false) {
140         if (IsShuttingDown()) {
/home/brad/working/src/ceph/src/rocksdb/db/merge_helper.cc: 249 in rocksdb::MergeHelper::MergeUntil(rocksdb::InternalIterator *, rocksdb::RangeDelAggregator *, unsigned long, bool)()
243             } else {
244               keys_.push_front(iter->key().ToString());
245             }
246             if (keys_.size() == 1) {
247               // we need to re-anchor the orig_ikey because it was anchored by
248               // original_key before
>>>     CID 1418252:    (CHECKED_RETURN)
>>>     Calling "ParseInternalKey" without checking return value (as is done elsewhere 25 out of 31 times).
249               ParseInternalKey(keys_.back(), &orig_ikey);
250             }
251             if (filter == CompactionFilter::Decision::kKeep) {
252               merge_context_.PushOperand(
253                   value_slice, iter->IsValuePinned() /* operand_pinned */);
254             } else {  // kChangeValue


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GyefNjJaJ-2FyXE15QWVNQOElzV2UBinM3P2nLLf04jfU1oBjekCw8oYd4zmBPBCTzY-2F-2FkwvumZVupyWeL9E99hsAt-2Ftidj6wLA7aFaXkK8wqyJeEzmRnXq0DtpmzXYyi3oV95fyG3Q8N7MwpvrXxzsXcrKpRlzfC8pQi-2FWm5cA9s6qVNM8QYNd4rDmu5WdM3u8-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GyefNjJaJ-2FyXE15QWVNQOElzV2UBinM3P2nLLf04jfUxc-2BTywOZXv-2BOP9KcKMMV7sBynXweiR9ujbM8S2HQTEjH38TAOunogxX7Za-2BN55nSx32vcXpC3XfyUWFMEQY7g6gAgj4zWfeLcfgGJQAAeOxb59t6uV9pTN4egQy58gcm-2F4lClzSBZgGrGavRf7nUv0-3D

