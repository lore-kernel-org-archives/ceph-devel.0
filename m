From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sun, 11 Jun 2017 16:46:35 -0700
Message-ID: <593dd65bc1cb7_440d72f3305171@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:63030 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751932AbdFKXqi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 11 Jun 2017 19:46:38 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0001p1sjc2.sendgrid.net (SG) with ESMTP id HvQ9RmDJTRGWgvDTKAyaXg
        for <ceph-devel@vger.kernel.org>; Sun, 11 Jun 2017 23:46:35.832 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

49 new defect(s) introduced to ceph found with Coverity Scan.
21 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 49 defect(s)


** CID 717210:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/common/LogEntry.h: 70 in LogEntryKey::LogEntryKey()()


________________________________________________________________________________________________________
*** CID 717210:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/common/LogEntry.h: 70 in LogEntryKey::LogEntryKey()()
64     
65       entity_inst_t who;
66       utime_t stamp;
67       uint64_t seq = 0;
68     
69     public:
>>>     CID 717210:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "_hash" is not initialized in this constructor nor in any functions that it calls.
70       LogEntryKey() {}
71       LogEntryKey(const entity_inst_t& w, utime_t t, uint64_t s)
72         : who(w), stamp(t), seq(s) {
73         _calc_hash();
74       }
75     

** CID 1412572:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/mon/MgrStatMonitor.cc: 82 in MgrStatMonitor::update_from_paxos(bool *)()


________________________________________________________________________________________________________
*** CID 1412572:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/mon/MgrStatMonitor.cc: 82 in MgrStatMonitor::update_from_paxos(bool *)()
76     
77     void MgrStatMonitor::update_from_paxos(bool *need_bootstrap)
78     {
79       version = get_last_committed();
80       dout(10) << " " << version << dendl;
81       bufferlist bl;
>>>     CID 1412572:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "get_version" without checking return value (as is done elsewhere 14 out of 15 times).
82       get_version(version, bl);
83       if (version) {
84         assert(bl.length());
85         auto p = bl.begin();
86         ::decode(digest, p);
87         ::decode(health_summary, p);

** CID 1412573:  Incorrect expression  (COPY_PASTE_ERROR)
/home/brad/working/src/ceph/src/rgw/rgw_rados.cc: 10941 in RGWRados::bucket_index_read_olh_log(const RGWBucketInfo &, RGWObjState &, const rgw_obj &, unsigned long, std::map<unsigned long, std::vector<rgw_bucket_olh_log_entry, std::allocator<rgw_bucket_olh_log_entry>>, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, std::vector<rgw_bucket_olh_log_entry, std::allocator<rgw_bucket_olh_log_entry>>>>> *, bool *)()


________________________________________________________________________________________________________
*** CID 1412573:  Incorrect expression  (COPY_PASTE_ERROR)
/home/brad/working/src/ceph/src/rgw/rgw_rados.cc: 10941 in RGWRados::bucket_index_read_olh_log(const RGWBucketInfo &, RGWObjState &, const rgw_obj &, unsigned long, std::map<unsigned long, std::vector<rgw_bucket_olh_log_entry, std::allocator<rgw_bucket_olh_log_entry>>, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, std::vector<rgw_bucket_olh_log_entry, std::allocator<rgw_bucket_olh_log_entry>>>>> *, bool *)()
10935                           cls_rgw_guard_bucket_resharding(op, -ERR_BUSY_RESHARDING);
10936                           return cls_rgw_get_olh_log(bs->index_ctx, bs->bucket_obj, op,
10937                                                      key, ver_marker, olh_tag, log, is_truncated);
10938                         });
10939       if (ret < 0) {
10940         ldout(cct, 20) << "cls_rgw_get_olh_log() returned r=" << r << dendl;
>>>     CID 1412573:  Incorrect expression  (COPY_PASTE_ERROR)
>>>     "ret" looks like a copy-paste error.
10941         return ret;
10942       }
10943     
10944       return 0;
10945     }
10946     

** CID 1412574:    (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreReleaseRequest.cc: 41 in librbd::exclusive_lock::PreReleaseRequest<librbd::MockImageCtx>::PreReleaseRequest(librbd::MockImageCtx &, bool, AsyncOpTracker &, Context *)()
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreReleaseRequest.cc: 41 in librbd::exclusive_lock::PreReleaseRequest<librbd::ImageCtx>::PreReleaseRequest(librbd::ImageCtx &, bool, AsyncOpTracker &, Context *)()


________________________________________________________________________________________________________
*** CID 1412574:    (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreReleaseRequest.cc: 41 in librbd::exclusive_lock::PreReleaseRequest<librbd::MockImageCtx>::PreReleaseRequest(librbd::MockImageCtx &, bool, AsyncOpTracker &, Context *)()
35     template <typename I>
36     PreReleaseRequest<I>::PreReleaseRequest(I &image_ctx, bool shutting_down,
37                                             AsyncOpTracker &async_op_tracker,
38                                             Context *on_finish)
39       : m_image_ctx(image_ctx), m_shutting_down(shutting_down),
40         m_async_op_tracker(async_op_tracker),
>>>     CID 1412574:    (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::exclusive_lock::PreReleaseRequest<librbd::MockImageCtx>" but the destructor and whatever functions it calls do not free it.
41         m_on_finish(create_async_context_callback(image_ctx, on_finish)) {
42     }
43     
44     template <typename I>
45     PreReleaseRequest<I>::~PreReleaseRequest() {
46       if (!m_shutting_down) {
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreReleaseRequest.cc: 41 in librbd::exclusive_lock::PreReleaseRequest<librbd::ImageCtx>::PreReleaseRequest(librbd::ImageCtx &, bool, AsyncOpTracker &, Context *)()
35     template <typename I>
36     PreReleaseRequest<I>::PreReleaseRequest(I &image_ctx, bool shutting_down,
37                                             AsyncOpTracker &async_op_tracker,
38                                             Context *on_finish)
39       : m_image_ctx(image_ctx), m_shutting_down(shutting_down),
40         m_async_op_tracker(async_op_tracker),
>>>     CID 1412574:    (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::exclusive_lock::PreReleaseRequest<librbd::ImageCtx>" but the destructor and whatever functions it calls do not free it.
41         m_on_finish(create_async_context_callback(image_ctx, on_finish)) {
42     }
43     
44     template <typename I>
45     PreReleaseRequest<I>::~PreReleaseRequest() {
46       if (!m_shutting_down) {

** CID 1412575:  Incorrect expression  (COPY_PASTE_ERROR)
/home/brad/working/src/ceph/src/mon/PGMap.cc: 2764 in PGMap::get_health(CephContext *, const OSDMap &, std::__cxx11::list<std::pair<health_status_t, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<health_status_t, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>> &, std::__cxx11::list<std::pair<health_status_t, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<health_status_t, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>> *) const()


________________________________________________________________________________________________________
*** CID 1412575:  Incorrect expression  (COPY_PASTE_ERROR)
/home/brad/working/src/ceph/src/mon/PGMap.cc: 2764 in PGMap::get_health(CephContext *, const OSDMap &, std::__cxx11::list<std::pair<health_status_t, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<health_status_t, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>> &, std::__cxx11::list<std::pair<health_status_t, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<health_status_t, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>> *) const()
2758     	  ss2 << num_err << " osds have very slow requests";
2759     	  summary.push_back(make_pair(HEALTH_ERR, ss2.str()));
2760     	  detail->push_back(make_pair(HEALTH_ERR, ss2.str()));
2761     	}
2762     	if (num_warn) {
2763     	  ostringstream ss2;
>>>     CID 1412575:  Incorrect expression  (COPY_PASTE_ERROR)
>>>     "num_err" in "ss2 << num_err" looks like a copy-paste error.
2764     	  ss2 << num_err << " osds have slow requests";
2765     	  summary.push_back(make_pair(HEALTH_WARN, ss2.str()));
2766     	  detail->push_back(make_pair(HEALTH_WARN, ss2.str()));
2767     	}
2768           }
2769         }

** CID 1412576:  Integer handling issues  (DIVIDE_BY_ZERO)
/home/brad/working/src/ceph/src/mon/PGMap.cc: 683 in PGMapDigest::dump_pool_stats_full(const OSDMap &, std::__cxx11::basic_stringstream<char, std::char_traits<char>, std::allocator<char>> *, ceph::Formatter *, bool) const()


________________________________________________________________________________________________________
*** CID 1412576:  Integer handling issues  (DIVIDE_BY_ZERO)
/home/brad/working/src/ceph/src/mon/PGMap.cc: 683 in PGMapDigest::dump_pool_stats_full(const OSDMap &, std::__cxx11::basic_stringstream<char, std::char_traits<char>, std::allocator<char>> *, ceph::Formatter *, bool) const()
677             osd_map.get_erasure_code_profile(pool->erasure_code_profile);
678           auto pm = ecp.find("m");
679           auto pk = ecp.find("k");
680           if (pm != ecp.end() && pk != ecp.end()) {
681     	int k = atoi(pk->second.c_str());
682     	int m = atoi(pm->second.c_str());
>>>     CID 1412576:  Integer handling issues  (DIVIDE_BY_ZERO)
>>>     In expression "avail * k / (m + k)", division by expression "m + k" which may be zero has undefined behavior.
683     	avail = avail * k / (m + k);
684     	raw_used_rate = (float)(m + k) / k;
685           } else {
686     	raw_used_rate = 0.0;
687           }
688         }

** CID 1412577:  Incorrect expression  (DIVIDE_BY_ZERO)
/home/brad/working/src/ceph/src/mon/PGMap.cc: 684 in PGMapDigest::dump_pool_stats_full(const OSDMap &, std::__cxx11::basic_stringstream<char, std::char_traits<char>, std::allocator<char>> *, ceph::Formatter *, bool) const()


________________________________________________________________________________________________________
*** CID 1412577:  Incorrect expression  (DIVIDE_BY_ZERO)
/home/brad/working/src/ceph/src/mon/PGMap.cc: 684 in PGMapDigest::dump_pool_stats_full(const OSDMap &, std::__cxx11::basic_stringstream<char, std::char_traits<char>, std::allocator<char>> *, ceph::Formatter *, bool) const()
678           auto pm = ecp.find("m");
679           auto pk = ecp.find("k");
680           if (pm != ecp.end() && pk != ecp.end()) {
681     	int k = atoi(pk->second.c_str());
682     	int m = atoi(pm->second.c_str());
683     	avail = avail * k / (m + k);
>>>     CID 1412577:  Incorrect expression  (DIVIDE_BY_ZERO)
>>>     In expression "(float)(m + k) / k", division by expression "k" which may be zero has undefined behavior.
684     	raw_used_rate = (float)(m + k) / k;
685           } else {
686     	raw_used_rate = 0.0;
687           }
688         }
689         break;

** CID 1412578:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/mds/Server.cc: 7032 in Server::_rename_prepare(boost::intrusive_ptr<MDRequestImpl> &, EMetaBlob *, ceph::buffer::list *, CDentry *, CDentry *, CDentry *)()


________________________________________________________________________________________________________
*** CID 1412578:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/mds/Server.cc: 7032 in Server::_rename_prepare(boost::intrusive_ptr<MDRequestImpl> &, EMetaBlob *, ceph::buffer::list *, CDentry *, CDentry *, CDentry *)()
7026           force_journal_dest = true;
7027         } else
7028           force_journal_dest = _need_force_journal(srci, false);
7029       }
7030     
7031       bool force_journal_stray = false;
>>>     CID 1412578:  Null pointer dereferences  (FORWARD_NULL)
>>>     Comparing "straydn" to null implies that "straydn" might be null.
7032       if (oldin && oldin->is_dir() && straydn && !straydn->is_auth())
7033         force_journal_stray = _need_force_journal(oldin, true);
7034     
7035       if (linkmerge)
7036         dout(10) << " merging remote and primary links to the same inode" << dendl;
7037       if (silent)

** CID 1412579:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI34cls_rgw_clear_bucket_resharding_opE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1412579:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI34cls_rgw_clear_bucket_resharding_opE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1412579:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1412580:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI25cls_rgw_reshard_remove_opE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1412580:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI25cls_rgw_reshard_remove_opE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1412580:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1412581:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI24cls_rgw_reshard_list_retE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1412581:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI24cls_rgw_reshard_list_retE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1412581:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1412582:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI23cls_rgw_reshard_get_retE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1412582:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI23cls_rgw_reshard_get_retE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1412582:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1412583:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI29cls_rgw_bucket_instance_entryE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1412583:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI29cls_rgw_bucket_instance_entryE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1412583:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1412584:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI22cls_rgw_reshard_get_opE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1412584:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI22cls_rgw_reshard_get_opE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1412584:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1412585:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI32cls_rgw_set_bucket_resharding_opE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1412585:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI32cls_rgw_set_bucket_resharding_opE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1412585:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1412586:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI23cls_rgw_reshard_list_opE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1412586:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI23cls_rgw_reshard_list_opE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1412586:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1412587:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI22cls_rgw_reshard_add_opE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1412587:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI22cls_rgw_reshard_add_opE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1412587:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1412588:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI21cls_rgw_reshard_entryE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1412588:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI21cls_rgw_reshard_entryE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1412588:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1412589:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI11PGMapDigestE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1412589:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI11PGMapDigestE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1412589:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1412590:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 18590 in __pyx_pw_5rados_5Rados_65monitor_log2()


________________________________________________________________________________________________________
*** CID 1412590:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 18590 in __pyx_pw_5rados_5Rados_65monitor_log2()
18584           }
18585           kw_args = PyDict_Size(__pyx_kwds);
18586           switch (pos_args) {
18587             case  0:
18588             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_level)) != 0)) kw_args--;
18589             else goto __pyx_L5_argtuple_error;
>>>     CID 1412590:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
18590             case  1:
18591             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_callback)) != 0)) kw_args--;
18592             else {
18593               __Pyx_RaiseArgtupleInvalid("monitor_log2", 1, 3, 3, 1); __PYX_ERR(0, 1419, __pyx_L3_error)
18594             }
18595             case  2:


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8EnwDfL5KmGX4YdCmc-2FpKJF4vR59fQpqSroqM2G9hQwWc-2F47LynvUqg6VdQlp-2BWWUGMuPvvtFIa8UtxGOqgrOKp8YN-2FcIfOQp8BBQD-2FES0-2B7MDQVohLRs579NPLiYQ-2BYf8fS1pCg8vZSky3Xxjkw-2F0QZ97ixCpdPv-2BgCsJCrm57cXgtkl7RiCxG2gS5aYLj2kc-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8EnwDfL5KmGX4YdCmc-2FpKJF4vR59fQpqSroqM2G9hQwWYHoYpGzLSlbNeOLCZzz9R25jlGcLqgN2DWfe-2FXaNZ76yRdlpf6ByXbIBFQu0iVaZZk8MLDbvt2Zbf76GjQOtyvsPZqvqjDWtc880RtWono-2BGKHzWDLygRJOrbty44QnHdG90VIIyfV5WfliF9obpgg-3D

