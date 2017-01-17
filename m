From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Mon, 16 Jan 2017 19:01:57 -0800
Message-ID: <587d8925b6290_6856de333479568@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.24nn.shared.sendgrid.net ([167.89.100.237]:36258 "EHLO
        o1.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751050AbdAQDFH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 16 Jan 2017 22:05:07 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0004p1sjc2.sendgrid.net (SG) with ESMTP id nwWe0LDjS5iF0CXQ_gB1ZQ
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2017 03:01:57.783 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

88 new defect(s) introduced to ceph found with Coverity Scan.
35 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 88 defect(s)


** CID 1019567:  Program hangs  (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1019567:  Program hangs  (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/osd/OSD.cc: 4106 in OSD::handle_osd_ping(MOSDPing *)()
4100     		  << ", " << heartbeat_drop->second
4101     		  << " remaining to drop" << dendl;
4102     	  break;
4103     	}
4104           }
4105     
>>>     CID 1019567:  Program hangs  (ORDER_REVERSAL)
>>>     Calling "is_healthy" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 5 / 10).
4106           if (!cct->get_heartbeat_map()->is_healthy()) {
4107     	dout(10) << "internal heartbeat not healthy, dropping ping request" << dendl;
4108     	break;
4109           }
4110     
4111           Message *r = new MOSDPing(monc->get_fsid(),

** CID 1231682:    (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1231682:    (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/osd/OSD.cc: 2703 in OSD::shutdown()()
2697       service.start_shutdown();
2698     
2699       clear_waiting_sessions();
2700     
2701       // Shutdown PGs
2702       {
>>>     CID 1231682:    (ORDER_REVERSAL)
>>>     Calling "RLocker" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 5 / 10).
2703         RWLock::RLocker l(pg_map_lock);
2704         for (ceph::unordered_map<spg_t, PG*>::iterator p = pg_map.begin();
2705             p != pg_map.end();
2706             ++p) {
2707           dout(20) << " kicking pg " << p->first << dendl;
2708           p->second->lock();
/home/brad/working/src/ceph/src/osd/OSD.cc: 2813 in OSD::shutdown()()
2807     
2808       // Remove PGs
2809     #ifdef PG_DEBUG_REFS
2810       service.dump_live_pgids();
2811     #endif
2812       {
>>>     CID 1231682:    (ORDER_REVERSAL)
>>>     Calling "RLocker" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 5 / 10).
2813         RWLock::RLocker l(pg_map_lock);
2814         for (ceph::unordered_map<spg_t, PG*>::iterator p = pg_map.begin();
2815             p != pg_map.end();
2816             ++p) {
2817           dout(20) << " kicking pg " << p->first << dendl;
2818           p->second->lock();

** CID 1395483:  Program hangs  (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1395483:  Program hangs  (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/mds/MDSDaemon.cc: 415 in MDSDaemon::handle_conf_change(const md_config_t *, const std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &)()
409           mds_rank->op_tracker.set_history_size_and_duration(conf->mds_op_history_size,
410                                                    conf->mds_op_history_duration);
411         }
412       }
413       if (changed.count("mds_enable_op_tracker")) {
414         if (mds_rank) {
>>>     CID 1395483:  Program hangs  (ORDER_REVERSAL)
>>>     Calling "set_tracking" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 5 / 10).
415           mds_rank->op_tracker.set_tracking(conf->mds_enable_op_tracker);
416         }
417       }
418       if (changed.count("clog_to_monitors") ||
419           changed.count("clog_to_syslog") ||
420           changed.count("clog_to_syslog_level") ||

** CID 1398823:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/managed_lock/ReleaseRequest.cc: 41 in librbd::managed_lock::ReleaseRequest<librbd::MockImageCtx>::ReleaseRequest(librados::IoCtx &, librbd::MockImageWatcher *, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, Context *)()


________________________________________________________________________________________________________
*** CID 1398823:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/managed_lock/ReleaseRequest.cc: 41 in librbd::managed_lock::ReleaseRequest<librbd::MockImageCtx>::ReleaseRequest(librados::IoCtx &, librbd::MockImageWatcher *, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, Context *)()
35     
36     template <typename I>
37     ReleaseRequest<I>::ReleaseRequest(librados::IoCtx& ioctx, Watcher *watcher,
38                                       ContextWQ *work_queue, const string& oid,
39                                       const string& cookie, Context *on_finish)
40       : m_ioctx(ioctx), m_watcher(watcher), m_oid(oid), m_cookie(cookie),
>>>     CID 1398823:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::managed_lock::ReleaseRequest<librbd::MockImageCtx>" but the destructor and whatever functions it calls do not free it.
41         m_on_finish(new C_AsyncCallback<ContextWQ>(work_queue, on_finish)) {
42     }
43     
44     template <typename I>
45     ReleaseRequest<I>::~ReleaseRequest() {
46     }

** CID 1398824:    (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreAcquireRequest.cc: 34 in librbd::exclusive_lock::PreAcquireRequest<librbd::<unnamed>::MockTestImageCtx>::PreAcquireRequest(librbd::<unnamed>::MockTestImageCtx &, Context *)()
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreAcquireRequest.cc: 34 in librbd::exclusive_lock::PreAcquireRequest<librbd::ImageCtx>::PreAcquireRequest(librbd::ImageCtx &, Context *)()


________________________________________________________________________________________________________
*** CID 1398824:    (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreAcquireRequest.cc: 34 in librbd::exclusive_lock::PreAcquireRequest<librbd::<unnamed>::MockTestImageCtx>::PreAcquireRequest(librbd::<unnamed>::MockTestImageCtx &, Context *)()
28       return new PreAcquireRequest(image_ctx, on_finish);
29     }
30     
31     template <typename I>
32     PreAcquireRequest<I>::PreAcquireRequest(I &image_ctx, Context *on_finish)
33       : m_image_ctx(image_ctx),
>>>     CID 1398824:    (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::exclusive_lock::PreAcquireRequest<librbd::<unnamed>::MockTestImageCtx>" but the destructor and whatever functions it calls do not free it.
34         m_on_finish(create_async_context_callback(image_ctx, on_finish)),
35         m_error_result(0) {
36     }
37     
38     template <typename I>
39     PreAcquireRequest<I>::~PreAcquireRequest() {
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreAcquireRequest.cc: 34 in librbd::exclusive_lock::PreAcquireRequest<librbd::ImageCtx>::PreAcquireRequest(librbd::ImageCtx &, Context *)()
28       return new PreAcquireRequest(image_ctx, on_finish);
29     }
30     
31     template <typename I>
32     PreAcquireRequest<I>::PreAcquireRequest(I &image_ctx, Context *on_finish)
33       : m_image_ctx(image_ctx),
>>>     CID 1398824:    (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::exclusive_lock::PreAcquireRequest<librbd::ImageCtx>" but the destructor and whatever functions it calls do not free it.
34         m_on_finish(create_async_context_callback(image_ctx, on_finish)),
35         m_error_result(0) {
36     }
37     
38     template <typename I>
39     PreAcquireRequest<I>::~PreAcquireRequest() {

** CID 1398825:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/managed_lock/AcquireRequest.cc: 74 in librbd::managed_lock::AcquireRequest<librbd::ImageCtx>::AcquireRequest(librados::IoCtx &, librbd::Watcher *, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, Context *)()


________________________________________________________________________________________________________
*** CID 1398825:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/managed_lock/AcquireRequest.cc: 74 in librbd::managed_lock::AcquireRequest<librbd::ImageCtx>::AcquireRequest(librados::IoCtx &, librbd::Watcher *, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, Context *)()
68     AcquireRequest<I>::AcquireRequest(librados::IoCtx& ioctx, Watcher *watcher,
69                                       ContextWQ *work_queue, const string& oid,
70                                       const string& cookie, Context *on_finish)
71       : m_ioctx(ioctx), m_watcher(watcher),
72         m_cct(reinterpret_cast<CephContext *>(m_ioctx.cct())),
73         m_work_queue(work_queue), m_oid(oid), m_cookie(cookie),
>>>     CID 1398825:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::managed_lock::AcquireRequest<librbd::ImageCtx>" but the destructor and whatever functions it calls do not free it.
74         m_on_finish(new C_AsyncCallback<ContextWQ>(work_queue, on_finish)),
75         m_error_result(0) {
76     }
77     
78     template <typename I>
79     AcquireRequest<I>::~AcquireRequest() {

** CID 1398826:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osdc/Objecter.cc: 2775 in Objecter::_calc_target(Objecter::op_target_t *, bool)()


________________________________________________________________________________________________________
*** CID 1398826:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osdc/Objecter.cc: 2775 in Objecter::_calc_target(Objecter::op_target_t *, bool)()
2769         if (acting_primary == -1) {
2770           t->osd = -1;
2771         } else {
2772           int osd;
2773           bool read = is_read && !is_write;
2774           if (read && (t->flags & CEPH_OSD_FLAG_BALANCE_READS)) {
>>>     CID 1398826:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2775     	int p = rand() % acting.size();
2776     	if (p)
2777     	  t->used_replica = true;
2778     	osd = acting[p];
2779     	ldout(cct, 10) << " chose random osd." << osd << " of " << acting
2780     		       << dendl;

** CID 1398827:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/managed_lock/AcquireRequest.cc: 74 in librbd::managed_lock::AcquireRequest<librbd::MockImageCtx>::AcquireRequest(librados::IoCtx &, librbd::MockImageWatcher *, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, Context *)()


________________________________________________________________________________________________________
*** CID 1398827:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/managed_lock/AcquireRequest.cc: 74 in librbd::managed_lock::AcquireRequest<librbd::MockImageCtx>::AcquireRequest(librados::IoCtx &, librbd::MockImageWatcher *, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, Context *)()
68     AcquireRequest<I>::AcquireRequest(librados::IoCtx& ioctx, Watcher *watcher,
69                                       ContextWQ *work_queue, const string& oid,
70                                       const string& cookie, Context *on_finish)
71       : m_ioctx(ioctx), m_watcher(watcher),
72         m_cct(reinterpret_cast<CephContext *>(m_ioctx.cct())),
73         m_work_queue(work_queue), m_oid(oid), m_cookie(cookie),
>>>     CID 1398827:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::managed_lock::AcquireRequest<librbd::MockImageCtx>" but the destructor and whatever functions it calls do not free it.
74         m_on_finish(new C_AsyncCallback<ContextWQ>(work_queue, on_finish)),
75         m_error_result(0) {
76     }
77     
78     template <typename I>
79     AcquireRequest<I>::~AcquireRequest() {

** CID 1398828:    (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreReleaseRequest.cc: 39 in librbd::exclusive_lock::PreReleaseRequest<librbd::MockImageCtx>::PreReleaseRequest(librbd::MockImageCtx &, Context *, Context *, bool)()
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreReleaseRequest.cc: 39 in librbd::exclusive_lock::PreReleaseRequest<librbd::ImageCtx>::PreReleaseRequest(librbd::ImageCtx &, Context *, Context *, bool)()


________________________________________________________________________________________________________
*** CID 1398828:    (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreReleaseRequest.cc: 39 in librbd::exclusive_lock::PreReleaseRequest<librbd::MockImageCtx>::PreReleaseRequest(librbd::MockImageCtx &, Context *, Context *, bool)()
33     }
34     
35     template <typename I>
36     PreReleaseRequest<I>::PreReleaseRequest(I &image_ctx, Context *on_releasing,
37                                             Context *on_finish, bool shutting_down)
38       : m_image_ctx(image_ctx), m_on_releasing(on_releasing),
>>>     CID 1398828:    (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::exclusive_lock::PreReleaseRequest<librbd::MockImageCtx>" but the destructor and whatever functions it calls do not free it.
39         m_on_finish(create_async_context_callback(image_ctx, on_finish)),
40         m_shutting_down(shutting_down), m_error_result(0), m_object_map(nullptr),
41         m_journal(nullptr) {
42     }
43     
44     template <typename I>
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreReleaseRequest.cc: 39 in librbd::exclusive_lock::PreReleaseRequest<librbd::ImageCtx>::PreReleaseRequest(librbd::ImageCtx &, Context *, Context *, bool)()
33     }
34     
35     template <typename I>
36     PreReleaseRequest<I>::PreReleaseRequest(I &image_ctx, Context *on_releasing,
37                                             Context *on_finish, bool shutting_down)
38       : m_image_ctx(image_ctx), m_on_releasing(on_releasing),
>>>     CID 1398828:    (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::exclusive_lock::PreReleaseRequest<librbd::ImageCtx>" but the destructor and whatever functions it calls do not free it.
39         m_on_finish(create_async_context_callback(image_ctx, on_finish)),
40         m_shutting_down(shutting_down), m_error_result(0), m_object_map(nullptr),
41         m_journal(nullptr) {
42     }
43     
44     template <typename I>

** CID 1398829:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/Journal.cc: 74 in librbd::<unnamed>::C_IsTagOwner<librbd::ImageCtx>::C_IsTagOwner(librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool *, ContextWQ *, Context *)()


________________________________________________________________________________________________________
*** CID 1398829:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/Journal.cc: 74 in librbd::<unnamed>::C_IsTagOwner<librbd::ImageCtx>::C_IsTagOwner(librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool *, ContextWQ *, Context *)()
68     
69       C_IsTagOwner(librados::IoCtx &io_ctx, const std::string &image_id,
70                    bool *is_tag_owner, ContextWQ *op_work_queue, Context *on_finish)
71         : io_ctx(io_ctx), image_id(image_id), is_tag_owner(is_tag_owner),
72           op_work_queue(op_work_queue), on_finish(on_finish),
73           cct(reinterpret_cast<CephContext*>(io_ctx.cct())),
>>>     CID 1398829:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "journaler" of "librbd::<unnamed>::C_IsTagOwner<librbd::ImageCtx>" but there is no destructor.
74           journaler(new Journaler(io_ctx, image_id, Journal<>::IMAGE_CLIENT_ID,
75                                   {})) {
76       }
77     
78       virtual void finish(int r) {
79         ldout(cct, 20) << this << " C_IsTagOwner::" << __func__ << ": r=" << r

** CID 1398830:    (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PostAcquireRequest.cc: 47 in librbd::exclusive_lock::PostAcquireRequest<librbd::<unnamed>::MockTestImageCtx>::PostAcquireRequest(librbd::<unnamed>::MockTestImageCtx &, Context *, Context *)()
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PostAcquireRequest.cc: 47 in librbd::exclusive_lock::PostAcquireRequest<librbd::ImageCtx>::PostAcquireRequest(librbd::ImageCtx &, Context *, Context *)()


________________________________________________________________________________________________________
*** CID 1398830:    (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PostAcquireRequest.cc: 47 in librbd::exclusive_lock::PostAcquireRequest<librbd::<unnamed>::MockTestImageCtx>::PostAcquireRequest(librbd::<unnamed>::MockTestImageCtx &, Context *, Context *)()
41     
42     template <typename I>
43     PostAcquireRequest<I>::PostAcquireRequest(I &image_ctx, Context *on_acquire,
44                                               Context *on_finish)
45       : m_image_ctx(image_ctx),
46         m_on_acquire(on_acquire),
>>>     CID 1398830:    (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::exclusive_lock::PostAcquireRequest<librbd::<unnamed>::MockTestImageCtx>" but the destructor and whatever functions it calls do not free it.
47         m_on_finish(create_async_context_callback(image_ctx, on_finish)),
48         m_object_map(nullptr), m_journal(nullptr), m_error_result(0) {
49     }
50     
51     template <typename I>
52     PostAcquireRequest<I>::~PostAcquireRequest() {
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PostAcquireRequest.cc: 47 in librbd::exclusive_lock::PostAcquireRequest<librbd::ImageCtx>::PostAcquireRequest(librbd::ImageCtx &, Context *, Context *)()
41     
42     template <typename I>
43     PostAcquireRequest<I>::PostAcquireRequest(I &image_ctx, Context *on_acquire,
44                                               Context *on_finish)
45       : m_image_ctx(image_ctx),
46         m_on_acquire(on_acquire),
>>>     CID 1398830:    (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::exclusive_lock::PostAcquireRequest<librbd::ImageCtx>" but the destructor and whatever functions it calls do not free it.
47         m_on_finish(create_async_context_callback(image_ctx, on_finish)),
48         m_object_map(nullptr), m_journal(nullptr), m_error_result(0) {
49     }
50     
51     template <typename I>
52     PostAcquireRequest<I>::~PostAcquireRequest() {

** CID 1398831:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/managed_lock/ReleaseRequest.cc: 41 in librbd::managed_lock::ReleaseRequest<librbd::ImageCtx>::ReleaseRequest(librados::IoCtx &, librbd::Watcher *, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, Context *)()


________________________________________________________________________________________________________
*** CID 1398831:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/managed_lock/ReleaseRequest.cc: 41 in librbd::managed_lock::ReleaseRequest<librbd::ImageCtx>::ReleaseRequest(librados::IoCtx &, librbd::Watcher *, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, Context *)()
35     
36     template <typename I>
37     ReleaseRequest<I>::ReleaseRequest(librados::IoCtx& ioctx, Watcher *watcher,
38                                       ContextWQ *work_queue, const string& oid,
39                                       const string& cookie, Context *on_finish)
40       : m_ioctx(ioctx), m_watcher(watcher), m_oid(oid), m_cookie(cookie),
>>>     CID 1398831:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::managed_lock::ReleaseRequest<librbd::ImageCtx>" but the destructor and whatever functions it calls do not free it.
41         m_on_finish(new C_AsyncCallback<ContextWQ>(work_queue, on_finish)) {
42     }
43     
44     template <typename I>
45     ReleaseRequest<I>::~ReleaseRequest() {
46     }

** CID 1398832:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 788 in __event_prepare_filter_stack__osd___do_osd_op_post()


________________________________________________________________________________________________________
*** CID 1398832:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 788 in __event_prepare_filter_stack__osd___do_osd_op_post()
782             ctf_integer(uint64_t, snap, snap)
783             ctf_integer_hex(uint16_t, op, op)
784             ctf_string(opname, opname)
785         )
786     )
787     
>>>     CID 1398832:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "4294967295U < 0U".
788     TRACEPOINT_EVENT(osd, do_osd_op_post,
789         TP_ARGS(
790             const char*, oid,
791             uint64_t, snap,
792             uint16_t, op,
793             const char*, opname,

** CID 1398833:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 678 in __event_prepare_filter_stack__osd___do_osd_op_pre_omap_cmp()


________________________________________________________________________________________________________
*** CID 1398833:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 678 in __event_prepare_filter_stack__osd___do_osd_op_pre_omap_cmp()
672             ctf_string(oid, oid)
673             ctf_integer(uint64_t, snap, snap)
674             ctf_string(keys, keys)
675         )
676     )
677     
>>>     CID 1398833:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "18446744073709551615UL < 0UL".
678     TRACEPOINT_EVENT(osd, do_osd_op_pre_omap_cmp,
679         TP_ARGS(
680             const char*, oid,
681             uint64_t, snap,
682             const char*, keys),
683         TP_FIELDS(

** CID 1398834:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 626 in __event_prepare_filter_stack__osd___do_osd_op_pre_omapgetkeys()


________________________________________________________________________________________________________
*** CID 1398834:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 626 in __event_prepare_filter_stack__osd___do_osd_op_pre_omapgetkeys()
620         TP_FIELDS(
621             ctf_string(oid, oid)
622             ctf_integer(uint64_t, snap, snap)
623         )
624     )
625     
>>>     CID 1398834:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "18446744073709551615UL < 0UL".
626     TRACEPOINT_EVENT(osd, do_osd_op_pre_omapgetkeys,
627         TP_ARGS(
628             const char*, oid,
629             uint64_t, snap,
630             const char*, start_after,
631             uint64_t, max_return),

** CID 1398835:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 250 in __event_prepare_filter_stack__osd___do_osd_op_pre_getxattrs()


________________________________________________________________________________________________________
*** CID 1398835:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 250 in __event_prepare_filter_stack__osd___do_osd_op_pre_getxattrs()
244             ctf_string(oid, oid)
245             ctf_integer(uint64_t, snap, snap)
246             ctf_string(aname, aname)
247         )
248     )
249     
>>>     CID 1398835:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "18446744073709551615UL < 0UL".
250     TRACEPOINT_EVENT(osd, do_osd_op_pre_getxattrs,
251         TP_ARGS(
252             const char*, oid,
253             uint64_t, snap),
254         TP_FIELDS(
255             ctf_string(oid, oid)

** CID 1398836:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 396 in __event_prepare_filter_stack__osd___do_osd_op_pre_writesame()


________________________________________________________________________________________________________
*** CID 1398836:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 396 in __event_prepare_filter_stack__osd___do_osd_op_pre_writesame()
390             ctf_integer(uint64_t, osize, osize)
391             ctf_integer(uint64_t, offset, offset)
392             ctf_integer(uint64_t, length, length)
393         )
394     )
395     
>>>     CID 1398836:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "18446744073709551615UL < 0UL".
396     TRACEPOINT_EVENT(osd, do_osd_op_pre_writesame,
397         TP_ARGS(
398             const char*, oid,
399             uint64_t, snap,
400             uint64_t, osize,
401             uint64_t, offset,

** CID 1398837:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 496 in __event_prepare_filter_stack__osd___do_osd_op_pre_watch()


________________________________________________________________________________________________________
*** CID 1398837:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 496 in __event_prepare_filter_stack__osd___do_osd_op_pre_watch()
490             ctf_integer(uint64_t, offset, offset)
491             ctf_integer(uint64_t, length, length)
492             ctf_integer(uint64_t, src_offset, src_offset)
493         )
494     )
495     
>>>     CID 1398837:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "18446744073709551615UL < 0UL".
496     TRACEPOINT_EVENT(osd, do_osd_op_pre_watch,
497         TP_ARGS(
498             const char*, oid,
499             uint64_t, snap,
500             uint64_t, cookie,
501             uint8_t, op),

** CID 1398838:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 740 in __event_prepare_filter_stack__osd___do_osd_op_pre_copy_get()


________________________________________________________________________________________________________
*** CID 1398838:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 740 in __event_prepare_filter_stack__osd___do_osd_op_pre_copy_get()
734         TP_FIELDS(
735             ctf_string(oid, oid)
736             ctf_integer(uint64_t, snap, snap)
737         )
738     )
739     
>>>     CID 1398838:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "18446744073709551615UL < 0UL".
740     TRACEPOINT_EVENT(osd, do_osd_op_pre_copy_get,
741         TP_ARGS(
742             const char*, oid,
743             uint64_t, snap),
744         TP_FIELDS(
745             ctf_string(oid, oid)

** CID 1398839:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 30 in __event_prepare_filter_stack__osd___prepare_tx_exit()


________________________________________________________________________________________________________
*** CID 1398839:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 30 in __event_prepare_filter_stack__osd___prepare_tx_exit()
24             ctf_integer(int64_t, num, num)
25             ctf_integer(uint64_t, tid, tid)
26             ctf_integer(int32_t, inc, inc)
27         )
28     )
29     
>>>     CID 1398839:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "18446744073709551615UL < 0UL".
30     TRACEPOINT_EVENT(osd, prepare_tx_exit,
31         TP_ARGS(
32             // osd_reqid_t
33             uint8_t,  type,
34             int64_t,  num,
35             uint64_t, tid,


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E7Ilp3hIRx8pD79hCpT6dWOj5uDWQoRRvMwB-2Fk12Re3A-2FlJor-2FNUK0cQgaXnnFNvyRkBlZ-2F01qGbIFxZiBrt-2BDUaUzogA-2Bg6fLDDn32ARgZAe6SxD5DO-2FkUDXDyWiWhwdel-2B6apKTMYOcHWDftfTt8nPDzjI1CaKa-2Fa1fFMNsXRE5wnWRWTwvZwVT-2BO5GVq-2F8-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E7Ilp3hIRx8pD79hCpT6dWOj5uDWQoRRvMwB-2Fk12Re3KPAf7RrdehYo8AnLOFuXsNG8dqxANOgPzSFAP-2Br7fhNYcMy92fiRTtAy1okD-2FmPPWhgT2C9dfXHFIe5SXc2nAglDpn1Qnh7Ep5n5FiyOWN-2FiqKClFNWD-2FigyXMImEq53Pkm6CoknrE0fPs179Y1sUM-3D

