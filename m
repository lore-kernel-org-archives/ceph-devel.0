From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 19 Oct 2017 03:54:05 +0000 (UTC)
Message-ID: <59e821dcc29cc_381740932c353a1@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.hv1nn.shared.sendgrid.net ([167.89.100.169]:5417 "EHLO
        o1.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751643AbdJSDyG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 18 Oct 2017 23:54:06 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0007p1sjc2.sendgrid.net (SG) with ESMTP id u7MBeuDTS3Ws3xrLOxsG3Q
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 03:54:04.837 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

13 new defect(s) introduced to ceph found with Coverity Scan.
46 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 13 of 13 defect(s)


** CID 1419851:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/db_iter.cc: 136 in rocksdb::DBIter::DBIter(rocksdb::Env *, const rocksdb::ReadOptions &, const rocksdb::ImmutableCFOptions &, const rocksdb::Comparator *, rocksdb::InternalIterator *, unsigned long, bool, unsigned long, rocksdb::ReadCallback *, bool)()


________________________________________________________________________________________________________
*** CID 1419851:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/db_iter.cc: 136 in rocksdb::DBIter::DBIter(rocksdb::Env *, const rocksdb::ReadOptions &, const rocksdb::ImmutableCFOptions &, const rocksdb::Comparator *, rocksdb::InternalIterator *, unsigned long, bool, unsigned long, rocksdb::ReadCallback *, bool)()
130         if (pin_thru_lifetime_) {
131           pinned_iters_mgr_.StartPinning();
132         }
133         if (iter_) {
134           iter_->SetPinnedItersMgr(&pinned_iters_mgr_);
135         }
>>>     CID 1419851:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "is_blob_" is not initialized in this constructor nor in any functions that it calls.
136       }
137       virtual ~DBIter() {
138         // Release pinned data if any
139         if (pinned_iters_mgr_.PinningEnabled()) {
140           pinned_iters_mgr_.ReleasePinnedData();
141         }

** CID 1419852:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_job.cc: 276 in rocksdb::CompactionJob::CompactionJob(int, rocksdb::Compaction *, const rocksdb::ImmutableDBOptions &, rocksdb::EnvOptions, rocksdb::VersionSet *, const std::atomic<bool> *, rocksdb::LogBuffer *, rocksdb::Directory *, rocksdb::Directory *, rocksdb::Statistics *, rocksdb::InstrumentedMutex *, rocksdb::Status *, std::vector<unsigned long, std::allocator<unsigned long>>, unsigned long, const rocksdb::SnapshotChecker *, std::shared_ptr<rocksdb::Cache>, rocksdb::EventLogger *, bool, bool, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, rocksdb::CompactionJobStats *)()


________________________________________________________________________________________________________
*** CID 1419852:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_job.cc: 276 in rocksdb::CompactionJob::CompactionJob(int, rocksdb::Compaction *, const rocksdb::ImmutableDBOptions &, rocksdb::EnvOptions, rocksdb::VersionSet *, const std::atomic<bool> *, rocksdb::LogBuffer *, rocksdb::Directory *, rocksdb::Directory *, rocksdb::Statistics *, rocksdb::InstrumentedMutex *, rocksdb::Status *, std::vector<unsigned long, std::allocator<unsigned long>>, unsigned long, const rocksdb::SnapshotChecker *, std::shared_ptr<rocksdb::Cache>, rocksdb::EventLogger *, bool, bool, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, rocksdb::CompactionJobStats *)()
270         std::vector<SequenceNumber> existing_snapshots,
271         SequenceNumber earliest_write_conflict_snapshot,
272         const SnapshotChecker* snapshot_checker, std::shared_ptr<Cache> table_cache,
273         EventLogger* event_logger, bool paranoid_file_checks, bool measure_io_stats,
274         const std::string& dbname, CompactionJobStats* compaction_job_stats)
275         : job_id_(job_id),
>>>     CID 1419852:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "compact_" of "rocksdb::CompactionJob" but the destructor and whatever functions it calls do not free it.
276           compact_(new CompactionState(compaction)),
277           compaction_job_stats_(compaction_job_stats),
278           compaction_stats_(1),
279           dbname_(dbname),
280           db_options_(db_options),
281           env_options_(env_options),

** CID 1419853:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/flush_job.cc: 93 in rocksdb::FlushJob::FlushJob(const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, rocksdb::ColumnFamilyData *, const rocksdb::ImmutableDBOptions &, const rocksdb::MutableCFOptions &, rocksdb::EnvOptions, rocksdb::VersionSet *, rocksdb::InstrumentedMutex *, std::atomic<bool> *, std::vector<unsigned long, std::allocator<unsigned long>>, unsigned long, rocksdb::SnapshotChecker *, rocksdb::JobContext *, rocksdb::LogBuffer *, rocksdb::Directory *, rocksdb::Directory *, rocksdb::CompressionType, rocksdb::Statistics *, rocksdb::EventLogger *, bool)()


________________________________________________________________________________________________________
*** CID 1419853:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/flush_job.cc: 93 in rocksdb::FlushJob::FlushJob(const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, rocksdb::ColumnFamilyData *, const rocksdb::ImmutableDBOptions &, const rocksdb::MutableCFOptions &, rocksdb::EnvOptions, rocksdb::VersionSet *, rocksdb::InstrumentedMutex *, std::atomic<bool> *, std::vector<unsigned long, std::allocator<unsigned long>>, unsigned long, rocksdb::SnapshotChecker *, rocksdb::JobContext *, rocksdb::LogBuffer *, rocksdb::Directory *, rocksdb::Directory *, rocksdb::CompressionType, rocksdb::Statistics *, rocksdb::EventLogger *, bool)()
87           event_logger_(event_logger),
88           measure_io_stats_(measure_io_stats),
89           pick_memtable_called(false) {
90       // Update the thread status to indicate flush.
91       ReportStartedFlush();
92       TEST_SYNC_POINT("FlushJob::FlushJob()");
>>>     CID 1419853:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "base_" is not initialized in this constructor nor in any functions that it calls.
93     }
94     
95     FlushJob::~FlushJob() {
96       ThreadStatusUtil::ResetThreadStatus();
97     }
98     

** CID 1419854:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/bufferlist.cc: 399 in TestRawPipe_buffer_list_write_fd_zero_copy_Test::TestBody()()
/home/brad/working/src/ceph/src/test/bufferlist.cc: 403 in TestRawPipe_buffer_list_write_fd_zero_copy_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1419854:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/bufferlist.cc: 399 in TestRawPipe_buffer_list_write_fd_zero_copy_Test::TestBody()()
393     TEST_F(TestRawPipe, buffer_list_write_fd_zero_copy) {
394       ::unlink(FILENAME);
395       bufferlist bl;
396       EXPECT_EQ(0, bl.read_fd_zero_copy(fd, len));
397       EXPECT_TRUE(bl.can_zero_copy());
398       int out_fd = ::open(FILENAME, O_RDWR|O_CREAT|O_TRUNC, 0600);
>>>     CID 1419854:    (RESOURCE_LEAK)
>>>     Handle variable "out_fd" going out of scope leaks the handle.
399       ASSERT_NE(-1, out_fd);
400       EXPECT_EQ(0, bl.write_fd_zero_copy(out_fd));
401       struct stat st;
402       memset(&st, 0, sizeof(st));
403       ASSERT_EQ(0, ::stat(FILENAME, &st));
404       EXPECT_EQ(len, st.st_size);
/home/brad/working/src/ceph/src/test/bufferlist.cc: 403 in TestRawPipe_buffer_list_write_fd_zero_copy_Test::TestBody()()
397       EXPECT_TRUE(bl.can_zero_copy());
398       int out_fd = ::open(FILENAME, O_RDWR|O_CREAT|O_TRUNC, 0600);
399       ASSERT_NE(-1, out_fd);
400       EXPECT_EQ(0, bl.write_fd_zero_copy(out_fd));
401       struct stat st;
402       memset(&st, 0, sizeof(st));
>>>     CID 1419854:    (RESOURCE_LEAK)
>>>     Handle variable "out_fd" going out of scope leaks the handle.
403       ASSERT_EQ(0, ::stat(FILENAME, &st));
404       EXPECT_EQ(len, st.st_size);
405       char buf[len + 1];
406       EXPECT_EQ((int)len, safe_read(out_fd, buf, len + 1));
407       EXPECT_EQ(0, memcmp(buf, "ABC\n", len));
408       ::close(out_fd);

** CID 1419855:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_iterator.cc: 109 in rocksdb::CompactionIterator::CompactionIterator(rocksdb::InternalIterator *, const rocksdb::Comparator *, rocksdb::MergeHelper *, unsigned long, std::vector<unsigned long, std::allocator<unsigned long>> *, unsigned long, const rocksdb::SnapshotChecker *, rocksdb::Env *, bool, rocksdb::RangeDelAggregator *, std::unique_ptr<rocksdb::CompactionIterator::CompactionProxy, std::default_delete<rocksdb::CompactionIterator::CompactionProxy>>, const rocksdb::CompactionFilter *, rocksdb::CompactionEventListener *, const std::atomic<bool> *)()


________________________________________________________________________________________________________
*** CID 1419855:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_iterator.cc: 109 in rocksdb::CompactionIterator::CompactionIterator(rocksdb::InternalIterator *, const rocksdb::Comparator *, rocksdb::MergeHelper *, unsigned long, std::vector<unsigned long, std::allocator<unsigned long>> *, unsigned long, const rocksdb::SnapshotChecker *, rocksdb::Env *, bool, rocksdb::RangeDelAggregator *, std::unique_ptr<rocksdb::CompactionIterator::CompactionProxy, std::default_delete<rocksdb::CompactionIterator::CompactionProxy>>, const rocksdb::CompactionFilter *, rocksdb::CompactionEventListener *, const std::atomic<bool> *)()
103           ignore_snapshots_ = true;
104         }
105       } else {
106         ignore_snapshots_ = false;
107       }
108       input_->SetPinnedItersMgr(&pinned_iters_mgr_);
>>>     CID 1419855:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "current_key_committed_" is not initialized in this constructor nor in any functions that it calls.
109     }
110     
111     CompactionIterator::~CompactionIterator() {
112       // input_ Iteartor lifetime is longer than pinned_iters_mgr_ lifetime
113       input_->SetPinnedItersMgr(nullptr);
114     }

** CID 1419856:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/bufferlist.cc: 2601 in BufferList_write_fd_offset_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1419856:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/bufferlist.cc: 2601 in BufferList_write_fd_offset_Test::TestBody()()
2595       ::unlink(FILENAME);
2596     }
2597     
2598     TEST(BufferList, write_fd_offset) {
2599       ::unlink(FILENAME);
2600       int fd = ::open(FILENAME, O_WRONLY|O_CREAT|O_TRUNC, 0600);
>>>     CID 1419856:  Resource leaks  (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
2601       ASSERT_NE(-1, fd);
2602       bufferlist bl;
2603       for (unsigned i = 0; i < IOV_MAX * 2; i++) {
2604         bufferptr ptr("A", 1);
2605         bl.push_back(ptr);
2606       }

** CID 1419857:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/options/db_options.cc: 237 in rocksdb::MutableDBOptions::MutableDBOptions()()


________________________________________________________________________________________________________
*** CID 1419857:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/options/db_options.cc: 237 in rocksdb::MutableDBOptions::MutableDBOptions()()
231           max_background_compactions(-1),
232           avoid_flush_during_shutdown(false),
233           delayed_write_rate(2 * 1024U * 1024U),
234           max_total_wal_size(0),
235           delete_obsolete_files_period_micros(6ULL * 60 * 60 * 1000000),
236           stats_dump_period_sec(600),
>>>     CID 1419857:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "wal_bytes_per_sync" is not initialized in this constructor nor in any functions that it calls.
237           max_open_files(-1) {}
238     
239     MutableDBOptions::MutableDBOptions(const DBOptions& options)
240         : max_background_jobs(options.max_background_jobs),
241           base_background_compactions(options.base_background_compactions),
242           max_background_compactions(options.max_background_compactions),

** CID 1419858:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/bufferlist.cc: 2583 in BufferList_write_fd_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1419858:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/bufferlist.cc: 2583 in BufferList_write_fd_Test::TestBody()()
2577       ::unlink(FILENAME);
2578     }
2579     
2580     TEST(BufferList, write_fd) {
2581       ::unlink(FILENAME);
2582       int fd = ::open(FILENAME, O_WRONLY|O_CREAT|O_TRUNC, 0600);
>>>     CID 1419858:  Resource leaks  (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
2583       ASSERT_NE(-1, fd);
2584       bufferlist bl;
2585       for (unsigned i = 0; i < IOV_MAX * 2; i++) {
2586         bufferptr ptr("A", 1);
2587         bl.push_back(ptr);
2588       }

** CID 1419859:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_iterator.cc: 55 in rocksdb::CompactionIterator::CompactionIterator(rocksdb::InternalIterator *, const rocksdb::Comparator *, rocksdb::MergeHelper *, unsigned long, std::vector<unsigned long, std::allocator<unsigned long>> *, unsigned long, const rocksdb::SnapshotChecker *, rocksdb::Env *, bool, rocksdb::RangeDelAggregator *, const rocksdb::Compaction *, const rocksdb::CompactionFilter *, rocksdb::CompactionEventListener *, const std::atomic<bool> *)()


________________________________________________________________________________________________________
*** CID 1419859:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_iterator.cc: 55 in rocksdb::CompactionIterator::CompactionIterator(rocksdb::InternalIterator *, const rocksdb::Comparator *, rocksdb::MergeHelper *, unsigned long, std::vector<unsigned long, std::allocator<unsigned long>> *, unsigned long, const rocksdb::SnapshotChecker *, rocksdb::Env *, bool, rocksdb::RangeDelAggregator *, const rocksdb::Compaction *, const rocksdb::CompactionFilter *, rocksdb::CompactionEventListener *, const std::atomic<bool> *)()
49         : CompactionIterator(
50               input, cmp, merge_helper, last_sequence, snapshots,
51               earliest_write_conflict_snapshot, snapshot_checker, env,
52               expect_valid_internal_key, range_del_agg,
53               std::unique_ptr<CompactionProxy>(
54                   compaction ? new CompactionProxy(compaction) : nullptr),
>>>     CID 1419859:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "current_key_committed_" is not initialized in this constructor nor in any functions that it calls.
55               compaction_filter, compaction_listener, shutting_down) {}
56     
57     CompactionIterator::CompactionIterator(
58         InternalIterator* input, const Comparator* cmp, MergeHelper* merge_helper,
59         SequenceNumber last_sequence, std::vector<SequenceNumber>* snapshots,
60         SequenceNumber earliest_write_conflict_snapshot,

** CID 1419860:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/bufferlist.cc: 2558 in BufferList_read_fd_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1419860:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/bufferlist.cc: 2558 in BufferList_read_fd_Test::TestBody()()
2552       snprintf(cmd, sizeof(cmd), "echo ABC > %s", FILENAME);
2553       EXPECT_EQ(0, ::system(cmd));
2554       int fd = -1;
2555       bufferlist bl;
2556       EXPECT_EQ(-EBADF, bl.read_fd(fd, len));
2557       fd = ::open(FILENAME, O_RDONLY);
>>>     CID 1419860:  Resource leaks  (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
2558       ASSERT_NE(-1, fd);
2559       EXPECT_EQ(len, (unsigned)bl.read_fd(fd, len));
2560       //EXPECT_EQ(CEPH_BUFFER_APPEND_SIZE - len, bl.front().unused_tail_length());
2561       EXPECT_EQ(len, bl.length());
2562       ::close(fd);
2563       ::unlink(FILENAME);

** CID 1419861:  Program hangs  (SLEEP)


________________________________________________________________________________________________________
*** CID 1419861:  Program hangs  (SLEEP)
/home/brad/working/src/ceph/src/msg/async/AsyncConnection.cc: 2365 in AsyncConnection::DelayedDelivery::do_request(unsigned long)()
2359         m = delay_queue.front().second;
2360         string delay_msg_type = msgr->cct->_conf->ms_inject_delay_msg_type;
2361         utime_t now = ceph_clock_now();
2362         if ((release > now &&
2363             (delay_msg_type.empty() || m->get_type_name() == delay_msg_type))) {
2364           utime_t t = release - now;
>>>     CID 1419861:  Program hangs  (SLEEP)
>>>     Call to "sleep" might sleep while holding lock "this->delay_lock".
2365           t.sleep();
2366         }
2367         delay_queue.pop_front();
2368       }
2369       if (msgr->ms_can_fast_dispatch(m)) {
2370         dispatch_queue->fast_dispatch(m);

** CID 1419862:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/write_batch.cc: 940 in rocksdb::MemTableInserter::MemTableInserter(unsigned long, rocksdb::ColumnFamilyMemTables *, rocksdb::FlushScheduler *, bool, unsigned long, rocksdb::DB *, bool, bool *, bool)()


________________________________________________________________________________________________________
*** CID 1419862:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/write_batch.cc: 940 in rocksdb::MemTableInserter::MemTableInserter(unsigned long, rocksdb::ColumnFamilyMemTables *, rocksdb::FlushScheduler *, bool, unsigned long, rocksdb::DB *, bool, bool *, bool)()
934             seq_per_batch_(seq_per_batch),
935             // Write after commit currently uses one seq per key (instead of per
936             // batch). So seq_per_batch being false indicates write_after_commit
937             // approach.
938             write_after_commit_(!seq_per_batch) {
939         assert(cf_mems_);
>>>     CID 1419862:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "rebuilding_trx_seq_" is not initialized in this constructor nor in any functions that it calls.
940       }
941     
942       ~MemTableInserter() {
943         if (post_info_created_) {
944           reinterpret_cast<MemPostInfoMap*>
945             (&mem_post_info_map_)->~MemPostInfoMap();

** CID 1419863:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_job.cc: 304 in rocksdb::CompactionJob::CompactionJob(int, rocksdb::Compaction *, const rocksdb::ImmutableDBOptions &, rocksdb::EnvOptions, rocksdb::VersionSet *, const std::atomic<bool> *, rocksdb::LogBuffer *, rocksdb::Directory *, rocksdb::Directory *, rocksdb::Statistics *, rocksdb::InstrumentedMutex *, rocksdb::Status *, std::vector<unsigned long, std::allocator<unsigned long>>, unsigned long, const rocksdb::SnapshotChecker *, std::shared_ptr<rocksdb::Cache>, rocksdb::EventLogger *, bool, bool, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, rocksdb::CompactionJobStats *)()


________________________________________________________________________________________________________
*** CID 1419863:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_job.cc: 304 in rocksdb::CompactionJob::CompactionJob(int, rocksdb::Compaction *, const rocksdb::ImmutableDBOptions &, rocksdb::EnvOptions, rocksdb::VersionSet *, const std::atomic<bool> *, rocksdb::LogBuffer *, rocksdb::Directory *, rocksdb::Directory *, rocksdb::Statistics *, rocksdb::InstrumentedMutex *, rocksdb::Status *, std::vector<unsigned long, std::allocator<unsigned long>>, unsigned long, const rocksdb::SnapshotChecker *, std::shared_ptr<rocksdb::Cache>, rocksdb::EventLogger *, bool, bool, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, rocksdb::CompactionJobStats *)()
298       assert(log_buffer_ != nullptr);
299       const auto* cfd = compact_->compaction->column_family_data();
300       ThreadStatusUtil::SetColumnFamily(cfd, cfd->ioptions()->env,
301                                         db_options_.enable_thread_tracking);
302       ThreadStatusUtil::SetThreadOperation(ThreadStatus::OP_COMPACTION);
303       ReportStartedCompaction(compaction);
>>>     CID 1419863:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "bottommost_level_" is not initialized in this constructor nor in any functions that it calls.
304     }
305     
306     CompactionJob::~CompactionJob() {
307       assert(compact_ == nullptr);
308       ThreadStatusUtil::ResetThreadStatus();
309     }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FFh10-2Fdq40-2FWwGIRvgJ7TlLS-2BzCkoP-2B9IdIBkJe92VJ1veYttNj8klI71oFxLvavCx0uov3kXkhI1AyrSWdLJv9k5AAtKbKM-2BiRB1ieGKg7btdOyyq-2FOgJNZM67lM-2BzWwOhQBD2HkpBVstDN3IrZqE1qI6M2IbxnDxFA5C8ZZbvz7GMHeDMp-2F3uF9gyfIIeww-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FFh10-2Fdq40-2FWwGIRvgJ7TlLS-2BzCkoP-2B9IdIBkJe92VJ8prbWzhKpt7jaAFGauPdv5fKXbonHjHe4du8Xynypzbsx-2F2NPNh2Bj0M7bDtrpnv-2FqneozwfUwlmeSB0Tv-2BojqrkO1d6yHof2L-2BeKTyM7HLC-2BvQvW73n1eKcp0YrqMGoFamb8P4xSc3O-2Bt60coZcBY-3D

