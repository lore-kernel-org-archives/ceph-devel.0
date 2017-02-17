From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 16 Feb 2017 18:29:41 -0800
Message-ID: <58a660157ad1a_4e8c3f334303af@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.24nn.shared.sendgrid.net ([167.89.100.237]:28805 "EHLO
        o1.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754742AbdBQC3s (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Feb 2017 21:29:48 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id n3BxuwchRL61Q0gz8NHXKA
        for <ceph-devel@vger.kernel.org>; Fri, 17 Feb 2017 02:29:41.542 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

18 new defect(s) introduced to ceph found with Coverity Scan.
32 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 18 of 18 defect(s)


** CID 1400653:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/home/brad/working/src/ceph/src/tools/rbd_nbd/rbd-nbd.cc: 632 in do_map()()


________________________________________________________________________________________________________
*** CID 1400653:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/home/brad/working/src/ceph/src/tools/rbd_nbd/rbd-nbd.cc: 632 in do_map()()
626       r = ioctl(nbd, NBD_SET_BLKSIZE, RBD_NBD_BLKSIZE);
627       if (r < 0) {
628         r = -errno;
629         goto close_nbd;
630       }
631     
>>>     CID 1400653:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
>>>     "info.size > 18446744073709551615UL /* 9223372036854775807L * 2UL + 1UL */" is always false regardless of the values of its operands. This occurs as the logical operand of "if".
632       if (info.size > ULONG_MAX) {
633         r = -EFBIG;
634         cerr << "rbd-nbd: image is too large (" << prettybyte_t(info.size)
635              << ", max is " << prettybyte_t(ULONG_MAX) << ")" << std::endl;
636         goto close_nbd;
637       }

** CID 1400654:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_job.cc: 276 in rocksdb::CompactionJob::CompactionJob(int, rocksdb::Compaction *, const rocksdb::ImmutableDBOptions &, const rocksdb::EnvOptions &, rocksdb::VersionSet *, const std::atomic<bool> *, rocksdb::LogBuffer *, rocksdb::Directory *, rocksdb::Directory *, rocksdb::Statistics *, rocksdb::InstrumentedMutex *, rocksdb::Status *, std::vector<unsigned long, std::allocator<unsigned long>>, unsigned long, std::shared_ptr<rocksdb::Cache>, rocksdb::EventLogger *, bool, bool, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, rocksdb::CompactionJobStats *)()


________________________________________________________________________________________________________
*** CID 1400654:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_job.cc: 276 in rocksdb::CompactionJob::CompactionJob(int, rocksdb::Compaction *, const rocksdb::ImmutableDBOptions &, const rocksdb::EnvOptions &, rocksdb::VersionSet *, const std::atomic<bool> *, rocksdb::LogBuffer *, rocksdb::Directory *, rocksdb::Directory *, rocksdb::Statistics *, rocksdb::InstrumentedMutex *, rocksdb::Status *, std::vector<unsigned long, std::allocator<unsigned long>>, unsigned long, std::shared_ptr<rocksdb::Cache>, rocksdb::EventLogger *, bool, bool, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, rocksdb::CompactionJobStats *)()
270         std::vector<SequenceNumber> existing_snapshots,
271         SequenceNumber earliest_write_conflict_snapshot,
272         std::shared_ptr<Cache> table_cache, EventLogger* event_logger,
273         bool paranoid_file_checks, bool measure_io_stats, const std::string& dbname,
274         CompactionJobStats* compaction_job_stats)
275         : job_id_(job_id),
>>>     CID 1400654:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "compact_" of "rocksdb::CompactionJob" but the destructor and whatever functions it calls do not free it.
276           compact_(new CompactionState(compaction)),
277           compaction_job_stats_(compaction_job_stats),
278           compaction_stats_(1),
279           dbname_(dbname),
280           db_options_(db_options),
281           env_options_(env_options),

** CID 1400655:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osdc/Objecter.cc: 2792 in Objecter::_calc_target(Objecter::op_target_t *, Connection *, bool)()


________________________________________________________________________________________________________
*** CID 1400655:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osdc/Objecter.cc: 2792 in Objecter::_calc_target(Objecter::op_target_t *, Connection *, bool)()
2786         if (acting_primary == -1) {
2787           t->osd = -1;
2788         } else {
2789           int osd;
2790           bool read = is_read && !is_write;
2791           if (read && (t->flags & CEPH_OSD_FLAG_BALANCE_READS)) {
>>>     CID 1400655:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2792     	int p = rand() % acting.size();
2793     	if (p)
2794     	  t->used_replica = true;
2795     	osd = acting[p];
2796     	ldout(cct, 10) << " chose random osd." << osd << " of " << acting
2797     		       << dendl;

** CID 1400656:  Incorrect expression  (NO_EFFECT)
/home/brad/working/src/ceph/src/msg/async/AsyncConnection.cc: 1077 in AsyncConnection::_process_connection()()


________________________________________________________________________________________________________
*** CID 1400656:  Incorrect expression  (NO_EFFECT)
/home/brad/working/src/ceph/src/msg/async/AsyncConnection.cc: 1077 in AsyncConnection::_process_connection()()
1071               goto fail;
1072             } else if (r > 0) {
1073               break;
1074             }
1075     
1076             connect_reply = *((ceph_msg_connect_reply*)state_buffer);
>>>     CID 1400656:  Incorrect expression  (NO_EFFECT)
>>>     Assigning "this->connect_reply.features" to itself has no effect.
1077             connect_reply.features = connect_reply.features;
1078     
1079             ldout(async_msgr->cct, 20) << __func__ << " connect got reply tag " << (int)connect_reply.tag
1080                                  << " connect_seq " << connect_reply.connect_seq << " global_seq "
1081                                  << connect_reply.global_seq << " proto " << connect_reply.protocol_version
1082                                  << " flags " << (int)connect_reply.flags << " features "

** CID 1400657:  Incorrect expression  (NO_EFFECT)
/home/brad/working/src/ceph/src/msg/simple/Pipe.cc: 1152 in Pipe::connect()()


________________________________________________________________________________________________________
*** CID 1400657:  Incorrect expression  (NO_EFFECT)
/home/brad/working/src/ceph/src/msg/simple/Pipe.cc: 1152 in Pipe::connect()()
1146         if (rc < 0) {
1147           ldout(msgr->cct,2) << "connect read reply " << cpp_strerror(rc) << dendl;
1148           goto fail;
1149         }
1150     
1151         // sanitize features
>>>     CID 1400657:  Incorrect expression  (NO_EFFECT)
>>>     Assigning "reply.features" to itself has no effect.
1152         reply.features = reply.features;
1153     
1154         ldout(msgr->cct,20) << "connect got reply tag " << (int)reply.tag
1155     			<< " connect_seq " << reply.connect_seq
1156     			<< " global_seq " << reply.global_seq
1157     			<< " proto " << reply.protocol_version

** CID 1400658:  Incorrect expression  (NO_EFFECT)
/home/brad/working/src/ceph/src/msg/simple/Pipe.cc: 431 in Pipe::accept()()


________________________________________________________________________________________________________
*** CID 1400658:  Incorrect expression  (NO_EFFECT)
/home/brad/working/src/ceph/src/msg/simple/Pipe.cc: 431 in Pipe::accept()()
425         if (tcp_read((char*)&connect, sizeof(connect)) < 0) {
426           ldout(msgr->cct,10) << "accept couldn't read connect" << dendl;
427           goto fail_unlocked;
428         }
429     
430         // sanitize features
>>>     CID 1400658:  Incorrect expression  (NO_EFFECT)
>>>     Assigning "connect.features" to itself has no effect.
431         connect.features = connect.features;
432     
433         authorizer.clear();
434         if (connect.authorizer_len) {
435           bp = buffer::create(connect.authorizer_len);
436           if (tcp_read(bp.c_str(), connect.authorizer_len) < 0) {

** CID 1400659:    (RETURN_LOCAL)
/home/brad/working/src/ceph/src/rocksdb/db/forward_iterator.cc: 567 in rocksdb::ForwardIterator::RebuildIterators(bool)()
/home/brad/working/src/ceph/src/rocksdb/db/forward_iterator.cc: 567 in rocksdb::ForwardIterator::RebuildIterators(bool)()


________________________________________________________________________________________________________
*** CID 1400659:    (RETURN_LOCAL)
/home/brad/working/src/ceph/src/rocksdb/db/forward_iterator.cc: 567 in rocksdb::ForwardIterator::RebuildIterators(bool)()
561       // Clean up
562       Cleanup(refresh_sv);
563       if (refresh_sv) {
564         // New
565         sv_ = cfd_->GetReferencedSuperVersion(&(db_->mutex_));
566       }
>>>     CID 1400659:    (RETURN_LOCAL)
>>>     Temporary variable of type "rocksdb::InternalKeyComparator" goes out of scope.
567       RangeDelAggregator range_del_agg(
568           InternalKeyComparator(cfd_->internal_comparator()), {} /* snapshots */);
569       mutable_iter_ = sv_->mem->NewIterator(read_options_, &arena_);
570       sv_->imm->AddIterators(read_options_, &imm_iters_, &arena_);
571       if (!read_options_.ignore_range_deletions) {
572         std::unique_ptr<InternalIterator> range_del_iter(
/home/brad/working/src/ceph/src/rocksdb/db/forward_iterator.cc: 567 in rocksdb::ForwardIterator::RebuildIterators(bool)()
561       // Clean up
562       Cleanup(refresh_sv);
563       if (refresh_sv) {
564         // New
565         sv_ = cfd_->GetReferencedSuperVersion(&(db_->mutex_));
566       }
>>>     CID 1400659:    (RETURN_LOCAL)
>>>     Temporary variable of type "rocksdb::InternalKeyComparator" goes out of scope.
567       RangeDelAggregator range_del_agg(
568           InternalKeyComparator(cfd_->internal_comparator()), {} /* snapshots */);
569       mutable_iter_ = sv_->mem->NewIterator(read_options_, &arena_);
570       sv_->imm->AddIterators(read_options_, &imm_iters_, &arena_);
571       if (!read_options_.ignore_range_deletions) {
572         std::unique_ptr<InternalIterator> range_del_iter(

** CID 1400660:    (RETURN_LOCAL)
/home/brad/working/src/ceph/src/rocksdb/db/forward_iterator.cc: 622 in rocksdb::ForwardIterator::RenewIterators()()
/home/brad/working/src/ceph/src/rocksdb/db/forward_iterator.cc: 622 in rocksdb::ForwardIterator::RenewIterators()()


________________________________________________________________________________________________________
*** CID 1400660:    (RETURN_LOCAL)
/home/brad/working/src/ceph/src/rocksdb/db/forward_iterator.cc: 622 in rocksdb::ForwardIterator::RenewIterators()()
616         DeleteIterator(m, true /* is_arena */);
617       }
618       imm_iters_.clear();
619     
620       mutable_iter_ = svnew->mem->NewIterator(read_options_, &arena_);
621       svnew->imm->AddIterators(read_options_, &imm_iters_, &arena_);
>>>     CID 1400660:    (RETURN_LOCAL)
>>>     Temporary variable of type "rocksdb::InternalKeyComparator" goes out of scope.
622       RangeDelAggregator range_del_agg(
623           InternalKeyComparator(cfd_->internal_comparator()), {} /* snapshots */);
624       if (!read_options_.ignore_range_deletions) {
625         std::unique_ptr<InternalIterator> range_del_iter(
626             svnew->mem->NewRangeTombstoneIterator(read_options_));
627         range_del_agg.AddTombstones(std::move(range_del_iter));
/home/brad/working/src/ceph/src/rocksdb/db/forward_iterator.cc: 622 in rocksdb::ForwardIterator::RenewIterators()()
616         DeleteIterator(m, true /* is_arena */);
617       }
618       imm_iters_.clear();
619     
620       mutable_iter_ = svnew->mem->NewIterator(read_options_, &arena_);
621       svnew->imm->AddIterators(read_options_, &imm_iters_, &arena_);
>>>     CID 1400660:    (RETURN_LOCAL)
>>>     Temporary variable of type "rocksdb::InternalKeyComparator" goes out of scope.
622       RangeDelAggregator range_del_agg(
623           InternalKeyComparator(cfd_->internal_comparator()), {} /* snapshots */);
624       if (!read_options_.ignore_range_deletions) {
625         std::unique_ptr<InternalIterator> range_del_iter(
626             svnew->mem->NewRangeTombstoneIterator(read_options_));
627         range_del_agg.AddTombstones(std::move(range_del_iter));

** CID 1400661:  Uninitialized variables  (UNINIT)


________________________________________________________________________________________________________
*** CID 1400661:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/messages/MOSDBackoff.h: 41 in MOSDBackoff::MOSDBackoff()()
35       }
36       epoch_t get_map_epoch() const override {
37         return map_epoch;
38       }
39     
40       MOSDBackoff()
>>>     CID 1400661:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "this->COMPAT_VERSION" when calling "MOSDFastDispatchOp".
41         : MOSDFastDispatchOp(CEPH_MSG_OSD_BACKOFF, HEAD_VERSION, COMPAT_VERSION) {}
42       MOSDBackoff(spg_t pgid_, epoch_t ep, uint8_t op_, uint64_t id_,
43     	      hobject_t begin_, hobject_t end_)
44         : MOSDFastDispatchOp(CEPH_MSG_OSD_BACKOFF, HEAD_VERSION, COMPAT_VERSION),
45           pgid(pgid_),
46           map_epoch(ep),

** CID 1400662:  Uninitialized variables  (UNINIT)


________________________________________________________________________________________________________
*** CID 1400662:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/messages/MOSDBackoff.h: 44 in MOSDBackoff::MOSDBackoff(spg_t, unsigned int, unsigned char, unsigned long, hobject_t, hobject_t)()
38       }
39     
40       MOSDBackoff()
41         : MOSDFastDispatchOp(CEPH_MSG_OSD_BACKOFF, HEAD_VERSION, COMPAT_VERSION) {}
42       MOSDBackoff(spg_t pgid_, epoch_t ep, uint8_t op_, uint64_t id_,
43     	      hobject_t begin_, hobject_t end_)
>>>     CID 1400662:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "this->COMPAT_VERSION" when calling "MOSDFastDispatchOp".
44         : MOSDFastDispatchOp(CEPH_MSG_OSD_BACKOFF, HEAD_VERSION, COMPAT_VERSION),
45           pgid(pgid_),
46           map_epoch(ep),
47           op(op_),
48           id(id_),
49           begin(begin_),

** CID 1400663:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_iterator.cc: 71 in rocksdb::CompactionIterator::CompactionIterator(rocksdb::InternalIterator *, const rocksdb::Comparator *, rocksdb::MergeHelper *, unsigned long, std::vector<unsigned long, std::allocator<unsigned long>> *, unsigned long, rocksdb::Env *, bool, rocksdb::RangeDelAggregator *, std::unique_ptr<rocksdb::CompactionIterator::CompactionProxy, std::default_delete<rocksdb::CompactionIterator::CompactionProxy>>, const rocksdb::CompactionFilter *, const std::atomic<bool> *)()


________________________________________________________________________________________________________
*** CID 1400663:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_iterator.cc: 71 in rocksdb::CompactionIterator::CompactionIterator(rocksdb::InternalIterator *, const rocksdb::Comparator *, rocksdb::MergeHelper *, unsigned long, std::vector<unsigned long, std::allocator<unsigned long>> *, unsigned long, rocksdb::Env *, bool, rocksdb::RangeDelAggregator *, std::unique_ptr<rocksdb::CompactionIterator::CompactionProxy, std::default_delete<rocksdb::CompactionIterator::CompactionProxy>>, const rocksdb::CompactionFilter *, const std::atomic<bool> *)()
65       if (compaction_filter_ != nullptr && compaction_filter_->IgnoreSnapshots()) {
66         ignore_snapshots_ = true;
67       } else {
68         ignore_snapshots_ = false;
69       }
70       input_->SetPinnedItersMgr(&pinned_iters_mgr_);
>>>     CID 1400663:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "current_user_key_snapshot_" is not initialized in this constructor nor in any functions that it calls.
71     }
72     
73     CompactionIterator::~CompactionIterator() {
74       // input_ Iteartor lifetime is longer than pinned_iters_mgr_ lifetime
75       input_->SetPinnedItersMgr(nullptr);
76     }

** CID 1400664:  Control flow issues  (UNREACHABLE)
/home/brad/working/src/ceph/src/rocksdb/util/env_posix.cc: 386 in rocksdb::<unnamed>::PosixEnv::ReuseWritableFile(const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, std::unique_ptr<rocksdb::WritableFile, std::default_delete<rocksdb::WritableFile>> *, const rocksdb::EnvOptions &)()


________________________________________________________________________________________________________
*** CID 1400664:  Control flow issues  (UNREACHABLE)
/home/brad/working/src/ceph/src/rocksdb/util/env_posix.cc: 386 in rocksdb::<unnamed>::PosixEnv::ReuseWritableFile(const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, std::unique_ptr<rocksdb::WritableFile, std::default_delete<rocksdb::WritableFile>> *, const rocksdb::EnvOptions &)()
380           EnvOptions no_mmap_writes_options = options;
381           no_mmap_writes_options.use_mmap_writes = false;
382           result->reset(new PosixWritableFile(fname, fd, no_mmap_writes_options));
383         }
384         return s;
385     
>>>     CID 1400664:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "return rocksdb::Status(s);".
386         return s;
387       }
388     
389       virtual Status NewRandomRWFile(const std::string& fname,
390                                      unique_ptr<RandomRWFile>* result,
391                                      const EnvOptions& options) override {

** CID 1400665:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_iterator.cc: 26 in rocksdb::CompactionIterator::CompactionIterator(rocksdb::InternalIterator *, const rocksdb::Comparator *, rocksdb::MergeHelper *, unsigned long, std::vector<unsigned long, std::allocator<unsigned long>> *, unsigned long, rocksdb::Env *, bool, rocksdb::RangeDelAggregator *, const rocksdb::Compaction *, const rocksdb::CompactionFilter *, const std::atomic<bool> *)()


________________________________________________________________________________________________________
*** CID 1400665:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_iterator.cc: 26 in rocksdb::CompactionIterator::CompactionIterator(rocksdb::InternalIterator *, const rocksdb::Comparator *, rocksdb::MergeHelper *, unsigned long, std::vector<unsigned long, std::allocator<unsigned long>> *, unsigned long, rocksdb::Env *, bool, rocksdb::RangeDelAggregator *, const rocksdb::Compaction *, const rocksdb::CompactionFilter *, const std::atomic<bool> *)()
20         : CompactionIterator(
21               input, cmp, merge_helper, last_sequence, snapshots,
22               earliest_write_conflict_snapshot, env, expect_valid_internal_key,
23               range_del_agg,
24               std::unique_ptr<CompactionProxy>(
25                   compaction ? new CompactionProxy(compaction) : nullptr),
>>>     CID 1400665:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "current_user_key_snapshot_" is not initialized in this constructor nor in any functions that it calls.
26               compaction_filter, shutting_down) {}
27     
28     CompactionIterator::CompactionIterator(
29         InternalIterator* input, const Comparator* cmp, MergeHelper* merge_helper,
30         SequenceNumber last_sequence, std::vector<SequenceNumber>* snapshots,
31         SequenceNumber earliest_write_conflict_snapshot, Env* env,

** CID 1400666:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/dbformat.h: 531 in rocksdb::RangeTombstone::RangeTombstone()()


________________________________________________________________________________________________________
*** CID 1400666:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/dbformat.h: 531 in rocksdb::RangeTombstone::RangeTombstone()()
525     // the struct here is a easy-understood form
526     // start/end_key_ is the start/end user key of the range to be deleted
527     struct RangeTombstone {
528       Slice start_key_;
529       Slice end_key_;
530       SequenceNumber seq_;
>>>     CID 1400666:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "seq_" is not initialized in this constructor nor in any functions that it calls.
531       RangeTombstone() = default;
532       RangeTombstone(Slice sk, Slice ek, SequenceNumber sn)
533           : start_key_(sk), end_key_(ek), seq_(sn) {}
534     
535       RangeTombstone(ParsedInternalKey parsed_key, Slice value) {
536         start_key_ = parsed_key.user_key;

** CID 1400667:    (UNINIT_CTOR)
/usr/include/c++/6.2.1/bits/regex_executor.h: 86 in std::__detail::_Executor<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::sub_match<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>>, std::__cxx11::regex_traits<char>, (bool)0>::_Executor(__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, __gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::vector<std::__cxx11::sub_match<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<cha
 r>, std::allocator<char>>>>, std::allocator<std::__cxx11::sub_match<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>
 >>> &, const std::__cxx11::basic_regex<char, std::__cxx11::regex_traits<char>> &, std::regex_constants::match_flag_type)()
/usr/include/c++/6.2.1/bits/regex_executor.h: 86 in std::__detail::_Executor<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::sub_match<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>>, std::__cxx11::regex_traits<char>, (bool)1>::_Executor(__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, __gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::vector<std::__cxx11::sub_match<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<cha
 r>, std::allocator<char>>>>, std::allocator<std::__cxx11::sub_match<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>
 >>> &, const std::__cxx11::basic_regex<char, std::__cxx11::regex_traits<char>> &, std::regex_constants::match_flag_type)()


________________________________________________________________________________________________________
*** CID 1400667:    (UNINIT_CTOR)
/usr/include/c++/6.2.1/bits/regex_executor.h: 86 in std::__detail::_Executor<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::sub_match<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>>, std::__cxx11::regex_traits<char>, (bool)0>::_Executor(__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, __gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::vector<std::__cxx11::sub_match<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<cha
 r>, std::allocator<char>>>>, std::allocator<std::__cxx11::sub_match<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>
 >>> &, const std::__cxx11::basic_regex<char, std::__cxx11::regex_traits<char>> &, std::regex_constants::match_flag_type)()
80           _M_states(_M_nfa._M_start(), _M_nfa.size()),
81           _M_flags((__flags & regex_constants::match_prev_avail)
82     	       ? (__flags
83     		  & ~regex_constants::match_not_bol
84     		  & ~regex_constants::match_not_bow)
85     	       : __flags)
>>>     CID 1400667:    (UNINIT_CTOR)
>>>     Non-static class member "_M_has_sol" is not initialized in this constructor nor in any functions that it calls.
86           { }
87     
88           // Set matched when string exactly matches the pattern.
89           bool
90           _M_match()
91           {
/usr/include/c++/6.2.1/bits/regex_executor.h: 86 in std::__detail::_Executor<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::sub_match<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>>, std::__cxx11::regex_traits<char>, (bool)1>::_Executor(__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, __gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::vector<std::__cxx11::sub_match<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<cha
 r>, std::allocator<char>>>>, std::allocator<std::__cxx11::sub_match<__gnu_cxx::__normal_iterator<const char *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>
 >>> &, const std::__cxx11::basic_regex<char, std::__cxx11::regex_traits<char>> &, std::regex_constants::match_flag_type)()
80           _M_states(_M_nfa._M_start(), _M_nfa.size()),
81           _M_flags((__flags & regex_constants::match_prev_avail)
82     	       ? (__flags
83     		  & ~regex_constants::match_not_bol
84     		  & ~regex_constants::match_not_bow)
85     	       : __flags)
>>>     CID 1400667:    (UNINIT_CTOR)
>>>     Non-static class member "_M_has_sol" is not initialized in this constructor nor in any functions that it calls.
86           { }
87     
88           // Set matched when string exactly matches the pattern.
89           bool
90           _M_match()
91           {

** CID 1400668:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/util/thread_local.cc: 41 in rocksdb::ThreadData::ThreadData(rocksdb::ThreadLocalPtr::StaticMeta *)()


________________________________________________________________________________________________________
*** CID 1400668:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/util/thread_local.cc: 41 in rocksdb::ThreadData::ThreadData(rocksdb::ThreadLocalPtr::StaticMeta *)()
35     //     ---------------------------------------------------
36     //     | thread 2 |    void*   |    void*   |    void*   | <- ThreadData
37     //     ---------------------------------------------------
38     //     | thread 3 |    void*   |    void*   |    void*   | <- ThreadData
39     //     ---------------------------------------------------
40     struct ThreadData {
>>>     CID 1400668:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "prev" is not initialized in this constructor nor in any functions that it calls.
41       explicit ThreadData(ThreadLocalPtr::StaticMeta* _inst) : entries(), inst(_inst) {}
42       std::vector<Entry> entries;
43       ThreadData* next;
44       ThreadData* prev;
45       ThreadLocalPtr::StaticMeta* inst;
46     };

** CID 1400669:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_job.cc: 303 in rocksdb::CompactionJob::CompactionJob(int, rocksdb::Compaction *, const rocksdb::ImmutableDBOptions &, const rocksdb::EnvOptions &, rocksdb::VersionSet *, const std::atomic<bool> *, rocksdb::LogBuffer *, rocksdb::Directory *, rocksdb::Directory *, rocksdb::Statistics *, rocksdb::InstrumentedMutex *, rocksdb::Status *, std::vector<unsigned long, std::allocator<unsigned long>>, unsigned long, std::shared_ptr<rocksdb::Cache>, rocksdb::EventLogger *, bool, bool, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, rocksdb::CompactionJobStats *)()


________________________________________________________________________________________________________
*** CID 1400669:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rocksdb/db/compaction_job.cc: 303 in rocksdb::CompactionJob::CompactionJob(int, rocksdb::Compaction *, const rocksdb::ImmutableDBOptions &, const rocksdb::EnvOptions &, rocksdb::VersionSet *, const std::atomic<bool> *, rocksdb::LogBuffer *, rocksdb::Directory *, rocksdb::Directory *, rocksdb::Statistics *, rocksdb::InstrumentedMutex *, rocksdb::Status *, std::vector<unsigned long, std::allocator<unsigned long>>, unsigned long, std::shared_ptr<rocksdb::Cache>, rocksdb::EventLogger *, bool, bool, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, rocksdb::CompactionJobStats *)()
297       assert(log_buffer_ != nullptr);
298       const auto* cfd = compact_->compaction->column_family_data();
299       ThreadStatusUtil::SetColumnFamily(cfd, cfd->ioptions()->env,
300                                         db_options_.enable_thread_tracking);
301       ThreadStatusUtil::SetThreadOperation(ThreadStatus::OP_COMPACTION);
302       ReportStartedCompaction(compaction);
>>>     CID 1400669:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "bottommost_level_" is not initialized in this constructor nor in any functions that it calls.
303     }
304     
305     CompactionJob::~CompactionJob() {
306       assert(compact_ == nullptr);
307       ThreadStatusUtil::ResetThreadStatus();
308     }

** CID 1400670:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/common/perf_histogram.h: 76 in PerfHistogram<(int)3>::PerfHistogram(std::initializer_list<PerfHistogramCommon::axis_config_d>)()
/home/brad/working/src/ceph/src/common/perf_histogram.h: 76 in PerfHistogram<(int)2>::PerfHistogram(std::initializer_list<PerfHistogramCommon::axis_config_d>)()


________________________________________________________________________________________________________
*** CID 1400670:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/common/perf_histogram.h: 76 in PerfHistogram<(int)3>::PerfHistogram(std::initializer_list<PerfHistogramCommon::axis_config_d>)()
70                  "Quantization unit must be non-zero positive integer value");
71     
72           m_axes_config[i++] = ac;
73         }
74     
75         m_rawData.reset(new atomic64_t[get_raw_size()]);
>>>     CID 1400670:    (UNINIT_CTOR)
>>>     Non-static class member field "m_axes_config.m_buckets" is not initialized in this constructor nor in any functions that it calls.
76       }
77     
78       /// Copy from other histogram object
79       PerfHistogram(const PerfHistogram &other)
80           : m_axes_config(other.m_axes_config) {
81         int64_t size = get_raw_size();
/home/brad/working/src/ceph/src/common/perf_histogram.h: 76 in PerfHistogram<(int)2>::PerfHistogram(std::initializer_list<PerfHistogramCommon::axis_config_d>)()
70                  "Quantization unit must be non-zero positive integer value");
71     
72           m_axes_config[i++] = ac;
73         }
74     
75         m_rawData.reset(new atomic64_t[get_raw_size()]);
>>>     CID 1400670:    (UNINIT_CTOR)
>>>     Non-static class member field "m_axes_config.m_buckets" is not initialized in this constructor nor in any functions that it calls.
76       }
77     
78       /// Copy from other histogram object
79       PerfHistogram(const PerfHistogram &other)
80           : m_axes_config(other.m_axes_config) {
81         int64_t size = get_raw_size();


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8H4KF1IlXLD-2BqrKefpd88Z5Qn-2BCdL-2Fafidv7i7JbWnbYk2XkuOyRjm7mXKjIHSkA92ObTvjIEq-2B5i2MmktPXrNNvXGakHrXTM3wVp3hqJlVTnu2NfhoRcCwEL0hTK4iUF8mfcRFEYXJ8-2BPbpX9ipo3XzvQgcITqg6E1Pr7dF9-2B7jr50RALwBCrj2W3qAey0ubs-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8H4KF1IlXLD-2BqrKefpd88Z5Qn-2BCdL-2Fafidv7i7JbWnbYj3UFll0kLEXj1l8hL4GuqmBx-2FvovAjGpFTlH-2FaIcjDnBBxKBJTwcEG4iy7vZfeeugTV1lawq4rA-2BeUmFeCA-2FFXIX2wyMhco9kl6-2BRDnMz1sgDM7n0Ea67Ff92t-2B9rYiCTqGkRx16OZcOHkIZM-2B-2FPaw-3D

