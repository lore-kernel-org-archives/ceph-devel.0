From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 27 Jan 2017 05:22:53 -0800
Message-ID: <588b49ad335ab_43efc3f3343031c@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:55820 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754865AbdA0NXc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 27 Jan 2017 08:23:32 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0015p1las1.sendgrid.net (SG) with ESMTP id Tmsbw_E3Rr62J9vqiq20UQ
        for <ceph-devel@vger.kernel.org>; Fri, 27 Jan 2017 13:22:53.348 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

24 new defect(s) introduced to ceph found with Coverity Scan.
13 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 24 defect(s)


** CID 1291023:    (TAINTED_SCALAR)
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 1487 in sort_typeBstar()
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 1602 in sort_typeBstar()
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 1603 in sort_typeBstar()


________________________________________________________________________________________________________
*** CID 1291023:    (TAINTED_SCALAR)
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 1487 in sort_typeBstar()
1481     */
1482     
1483       /* Calculate the index of start/end point of each bucket. */
1484       for(c0 = 0, i = 0, j = 0; c0 < ALPHABET_SIZE; ++c0) {
1485         t = i + BUCKET_A(c0);
1486         BUCKET_A(c0) = i + j; /* start point */
>>>     CID 1291023:    (TAINTED_SCALAR)
>>>     Using tainted variable "(c0 << 8) | c0" as an index to pointer "bucket_B".
1487         i = t + BUCKET_B(c0, c0);
1488         for(c1 = c0 + 1; c1 < ALPHABET_SIZE; ++c1) {
1489           j += BUCKET_BSTAR(c0, c1);
1490           BUCKET_BSTAR(c0, c1) = j; /* end point */
1491           i += BUCKET_B(c0, c1);
1492         }
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 1602 in sort_typeBstar()
1596     
1597             /* Move all type B* suffixes to the correct position. */
1598             for(i = t, j = BUCKET_BSTAR(c0, c1);
1599                 j <= k;
1600                 --i, --k) { SA[i] = SA[k]; }
1601           }
>>>     CID 1291023:    (TAINTED_SCALAR)
>>>     Using tainted variable "(c0 << 8) | c0" as an index to pointer "bucket_B".
1602           BUCKET_BSTAR(c0, c0 + 1) = i - BUCKET_B(c0, c0) + 1; /* start point */
1603           BUCKET_B(c0, c0) = i; /* end point */
1604         }
1605       }
1606     
1607       return m;
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 1603 in sort_typeBstar()
1597             /* Move all type B* suffixes to the correct position. */
1598             for(i = t, j = BUCKET_BSTAR(c0, c1);
1599                 j <= k;
1600                 --i, --k) { SA[i] = SA[k]; }
1601           }
1602           BUCKET_BSTAR(c0, c0 + 1) = i - BUCKET_B(c0, c0) + 1; /* start point */
>>>     CID 1291023:    (TAINTED_SCALAR)
>>>     Using tainted variable "(c0 << 8) | c0" as an index to pointer "bucket_B".
1603           BUCKET_B(c0, c0) = i; /* end point */
1604         }
1605       }
1606     
1607       return m;
1608     }

** CID 1291034:    (UNINIT)
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 1229 in tr_introsort()
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 1229 in tr_introsort()
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 1230 in tr_introsort()


________________________________________________________________________________________________________
*** CID 1291034:    (UNINIT)
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 1229 in tr_introsort()
1223               } else {
1224                 STACK_POP5(ISAd, first, last, limit, trlink);
1225               }
1226             }
1227           } else if(limit == -2) {
1228             /* tandem repeat copy */
>>>     CID 1291034:    (UNINIT)
>>>     Using uninitialized value "stack[--ssize].b".
1229             a = stack[--ssize].b, b = stack[ssize].c;
1230             if(stack[ssize].d == 0) {
1231               tr_copy(ISA, SA, first, a, b, last, ISAd - ISA);
1232             } else {
1233               if(0 <= trlink) { stack[trlink].d = -1; }
1234               tr_partialcopy(ISA, SA, first, a, b, last, ISAd - ISA);
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 1229 in tr_introsort()
1223               } else {
1224                 STACK_POP5(ISAd, first, last, limit, trlink);
1225               }
1226             }
1227           } else if(limit == -2) {
1228             /* tandem repeat copy */
>>>     CID 1291034:    (UNINIT)
>>>     Using uninitialized value "stack[ssize].c".
1229             a = stack[--ssize].b, b = stack[ssize].c;
1230             if(stack[ssize].d == 0) {
1231               tr_copy(ISA, SA, first, a, b, last, ISAd - ISA);
1232             } else {
1233               if(0 <= trlink) { stack[trlink].d = -1; }
1234               tr_partialcopy(ISA, SA, first, a, b, last, ISAd - ISA);
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 1230 in tr_introsort()
1224                 STACK_POP5(ISAd, first, last, limit, trlink);
1225               }
1226             }
1227           } else if(limit == -2) {
1228             /* tandem repeat copy */
1229             a = stack[--ssize].b, b = stack[ssize].c;
>>>     CID 1291034:    (UNINIT)
>>>     Using uninitialized value "stack[ssize].d".
1230             if(stack[ssize].d == 0) {
1231               tr_copy(ISA, SA, first, a, b, last, ISAd - ISA);
1232             } else {
1233               if(0 <= trlink) { stack[trlink].d = -1; }
1234               tr_partialcopy(ISA, SA, first, a, b, last, ISAd - ISA);
1235             }

** CID 1291063:  Memory - illegal accesses  (OVERRUN)
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 217 in ss_isqrt()


________________________________________________________________________________________________________
*** CID 1291063:  Memory - illegal accesses  (OVERRUN)
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/divsufsort.c: 217 in ss_isqrt()
211         y = sqq_table[x >> ((e - 6) - (e & 1))] << ((e >> 1) - 7);
212         if(e >= 24) { y = (y + 1 + x / y) >> 1; }
213         y = (y + 1 + x / y) >> 1;
214       } else if(e >= 8) {
215         y = (sqq_table[x >> ((e - 6) - (e & 1))] >> (7 - (e >> 1))) + 1;
216       } else {
>>>     CID 1291063:  Memory - illegal accesses  (OVERRUN)
>>>     Overrunning array "sqq_table" of 256 4-byte elements at element index 1048575 (byte offset 4194300) using index "x" (which evaluates to 1048575).
217         return sqq_table[x] >> 4;
218       }
219     
220       return (x < (y * y)) ? y - 1 : y;
221     }
222     

** CID 1399573:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/managed_lock/AcquireRequest.cc: 62 in librbd::managed_lock::AcquireRequest<librbd::MockImageCtx>::AcquireRequest(librados::IoCtx &, librbd::MockImageWatcher *, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool, bool, unsigned int, Context *)()


________________________________________________________________________________________________________
*** CID 1399573:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/managed_lock/AcquireRequest.cc: 62 in librbd::managed_lock::AcquireRequest<librbd::MockImageCtx>::AcquireRequest(librados::IoCtx &, librbd::MockImageWatcher *, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool, bool, unsigned int, Context *)()
56       : m_ioctx(ioctx), m_watcher(watcher),
57         m_cct(reinterpret_cast<CephContext *>(m_ioctx.cct())),
58         m_work_queue(work_queue), m_oid(oid), m_cookie(cookie),
59         m_exclusive(exclusive),
60         m_blacklist_on_break_lock(blacklist_on_break_lock),
61         m_blacklist_expire_seconds(blacklist_expire_seconds),
>>>     CID 1399573:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::managed_lock::AcquireRequest<librbd::MockImageCtx>" but the destructor and whatever functions it calls do not free it.
62         m_on_finish(new C_AsyncCallback<ContextWQ>(work_queue, on_finish)) {
63     }
64     
65     template <typename I>
66     AcquireRequest<I>::~AcquireRequest() {
67     }

** CID 1399574:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/managed_lock/AcquireRequest.cc: 62 in librbd::managed_lock::AcquireRequest<librbd::ImageCtx>::AcquireRequest(librados::IoCtx &, librbd::Watcher *, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool, bool, unsigned int, Context *)()


________________________________________________________________________________________________________
*** CID 1399574:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/managed_lock/AcquireRequest.cc: 62 in librbd::managed_lock::AcquireRequest<librbd::ImageCtx>::AcquireRequest(librados::IoCtx &, librbd::Watcher *, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool, bool, unsigned int, Context *)()
56       : m_ioctx(ioctx), m_watcher(watcher),
57         m_cct(reinterpret_cast<CephContext *>(m_ioctx.cct())),
58         m_work_queue(work_queue), m_oid(oid), m_cookie(cookie),
59         m_exclusive(exclusive),
60         m_blacklist_on_break_lock(blacklist_on_break_lock),
61         m_blacklist_expire_seconds(blacklist_expire_seconds),
>>>     CID 1399574:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::managed_lock::AcquireRequest<librbd::ImageCtx>" but the destructor and whatever functions it calls do not free it.
62         m_on_finish(new C_AsyncCallback<ContextWQ>(work_queue, on_finish)) {
63     }
64     
65     template <typename I>
66     AcquireRequest<I>::~AcquireRequest() {
67     }

** CID 1399575:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3402 in TestLibRBD_FlattenNoEmptyObjects_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3411 in TestLibRBD_FlattenNoEmptyObjects_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3413 in TestLibRBD_FlattenNoEmptyObjects_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1399575:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3402 in TestLibRBD_FlattenNoEmptyObjects_Test::TestBody()()
3396     
3397       // write something into parent
3398       char test_data[TEST_IO_SIZE + 1];
3399       char zero_data[TEST_IO_SIZE + 1];
3400       int i;
3401       for (i = 0; i < TEST_IO_SIZE; ++i)
>>>     CID 1399575:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3402         test_data[i] = (char) (rand() % (126 - 33) + 33);
3403       test_data[TEST_IO_SIZE] = '\0';
3404       memset(zero_data, 0, sizeof(zero_data));
3405     
3406       // generate a random map which covers every objects with random
3407       // offset
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3411 in TestLibRBD_FlattenNoEmptyObjects_Test::TestBody()()
3405     
3406       // generate a random map which covers every objects with random
3407       // offset
3408       int count = 0;
3409       map<uint64_t, uint64_t> write_tracker;
3410       while (count < 10) {
>>>     CID 1399575:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3411         uint64_t ono = rand() % object_num;
3412         if (write_tracker.find(ono) == write_tracker.end()) {
3413           uint64_t offset = rand() % (object_size - TEST_IO_SIZE);
3414           write_tracker.insert(pair<uint64_t, uint64_t>(ono, offset));
3415           count++;
3416         }
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3413 in TestLibRBD_FlattenNoEmptyObjects_Test::TestBody()()
3407       // offset
3408       int count = 0;
3409       map<uint64_t, uint64_t> write_tracker;
3410       while (count < 10) {
3411         uint64_t ono = rand() % object_num;
3412         if (write_tracker.find(ono) == write_tracker.end()) {
>>>     CID 1399575:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3413           uint64_t offset = rand() % (object_size - TEST_IO_SIZE);
3414           write_tracker.insert(pair<uint64_t, uint64_t>(ono, offset));
3415           count++;
3416         }
3417       }
3418     

** CID 1399576:    (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/image/RefreshRequest.cc: 34 in librbd::image::RefreshRequest<librbd::<unnamed>::MockRefreshImageCtx>::RefreshRequest(librbd::<unnamed>::MockRefreshImageCtx &, bool, bool, Context *)()
/home/brad/working/src/ceph/src/librbd/image/RefreshRequest.cc: 34 in librbd::image::RefreshRequest<librbd::ImageCtx>::RefreshRequest(librbd::ImageCtx &, bool, bool, Context *)()


________________________________________________________________________________________________________
*** CID 1399576:    (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/image/RefreshRequest.cc: 34 in librbd::image::RefreshRequest<librbd::<unnamed>::MockRefreshImageCtx>::RefreshRequest(librbd::<unnamed>::MockRefreshImageCtx &, bool, bool, Context *)()
28     
29     template <typename I>
30     RefreshRequest<I>::RefreshRequest(I &image_ctx, bool acquiring_lock,
31                                       bool skip_open_parent, Context *on_finish)
32       : m_image_ctx(image_ctx), m_acquiring_lock(acquiring_lock),
33         m_skip_open_parent_image(skip_open_parent),
>>>     CID 1399576:    (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::image::RefreshRequest<librbd::<unnamed>::MockRefreshImageCtx>" but the destructor and whatever functions it calls do not free it.
34         m_on_finish(create_async_context_callback(m_image_ctx, on_finish)),
35         m_error_result(0), m_flush_aio(false), m_exclusive_lock(nullptr),
36         m_object_map(nullptr), m_journal(nullptr), m_refresh_parent(nullptr) {
37     }
38     
39     template <typename I>
/home/brad/working/src/ceph/src/librbd/image/RefreshRequest.cc: 34 in librbd::image::RefreshRequest<librbd::ImageCtx>::RefreshRequest(librbd::ImageCtx &, bool, bool, Context *)()
28     
29     template <typename I>
30     RefreshRequest<I>::RefreshRequest(I &image_ctx, bool acquiring_lock,
31                                       bool skip_open_parent, Context *on_finish)
32       : m_image_ctx(image_ctx), m_acquiring_lock(acquiring_lock),
33         m_skip_open_parent_image(skip_open_parent),
>>>     CID 1399576:    (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::image::RefreshRequest<librbd::ImageCtx>" but the destructor and whatever functions it calls do not free it.
34         m_on_finish(create_async_context_callback(m_image_ctx, on_finish)),
35         m_error_result(0), m_flush_aio(false), m_exclusive_lock(nullptr),
36         m_object_map(nullptr), m_journal(nullptr), m_refresh_parent(nullptr) {
37     }
38     
39     template <typename I>

** CID 1399577:    (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreReleaseRequest.cc: 37 in librbd::exclusive_lock::PreReleaseRequest<librbd::MockImageCtx>::PreReleaseRequest(librbd::MockImageCtx &, bool, Context *)()
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreReleaseRequest.cc: 37 in librbd::exclusive_lock::PreReleaseRequest<librbd::ImageCtx>::PreReleaseRequest(librbd::ImageCtx &, bool, Context *)()


________________________________________________________________________________________________________
*** CID 1399577:    (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreReleaseRequest.cc: 37 in librbd::exclusive_lock::PreReleaseRequest<librbd::MockImageCtx>::PreReleaseRequest(librbd::MockImageCtx &, bool, Context *)()
31     }
32     
33     template <typename I>
34     PreReleaseRequest<I>::PreReleaseRequest(I &image_ctx, bool shutting_down,
35                                             Context *on_finish)
36       : m_image_ctx(image_ctx),
>>>     CID 1399577:    (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::exclusive_lock::PreReleaseRequest<librbd::MockImageCtx>" but the destructor and whatever functions it calls do not free it.
37         m_on_finish(create_async_context_callback(image_ctx, on_finish)),
38         m_shutting_down(shutting_down), m_error_result(0), m_object_map(nullptr),
39         m_journal(nullptr) {
40     }
41     
42     template <typename I>
/home/brad/working/src/ceph/src/librbd/exclusive_lock/PreReleaseRequest.cc: 37 in librbd::exclusive_lock::PreReleaseRequest<librbd::ImageCtx>::PreReleaseRequest(librbd::ImageCtx &, bool, Context *)()
31     }
32     
33     template <typename I>
34     PreReleaseRequest<I>::PreReleaseRequest(I &image_ctx, bool shutting_down,
35                                             Context *on_finish)
36       : m_image_ctx(image_ctx),
>>>     CID 1399577:    (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_on_finish" of "librbd::exclusive_lock::PreReleaseRequest<librbd::ImageCtx>" but the destructor and whatever functions it calls do not free it.
37         m_on_finish(create_async_context_callback(image_ctx, on_finish)),
38         m_shutting_down(shutting_down), m_error_result(0), m_object_map(nullptr),
39         m_journal(nullptr) {
40     }
41     
42     template <typename I>

** CID 1399578:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 529 in AsyncMessenger::_send_message(Message *, const entity_inst_t &)()
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 529 in AsyncMessenger::_send_message(Message *, const entity_inst_t &)()
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 529 in AsyncMessenger::_send_message(Message *, const entity_inst_t &)()
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 529 in AsyncMessenger::_send_message(Message *, const entity_inst_t &)()


________________________________________________________________________________________________________
*** CID 1399578:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 529 in AsyncMessenger::_send_message(Message *, const entity_inst_t &)()
523     
524     int AsyncMessenger::_send_message(Message *m, const entity_inst_t& dest)
525     {
526       FUNCTRACE();
527       if (m && m->get_type() == CEPH_MSG_OSD_OP)
528         OID_EVENT_TRACE(((MOSDOp *)m)->get_oid().name.c_str(), "SEND_MSG_OSD_OP");
>>>     CID 1399578:    (FORWARD_NULL)
>>>     Comparing "m" to null implies that "m" might be null.
529       else if (m && m->get_type() == CEPH_MSG_OSD_OPREPLY)
530         OID_EVENT_TRACE(((MOSDOpReply *)m)->get_oid().name.c_str(), "SEND_MSG_OSD_OP_REPLY");
531     
532       ldout(cct, 1) << __func__ << "--> " << dest.name << " "
533           << dest.addr << " -- " << *m << " -- ?+"
534           << m->get_data().length() << " " << m << dendl;
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 529 in AsyncMessenger::_send_message(Message *, const entity_inst_t &)()
523     
524     int AsyncMessenger::_send_message(Message *m, const entity_inst_t& dest)
525     {
526       FUNCTRACE();
527       if (m && m->get_type() == CEPH_MSG_OSD_OP)
528         OID_EVENT_TRACE(((MOSDOp *)m)->get_oid().name.c_str(), "SEND_MSG_OSD_OP");
>>>     CID 1399578:    (FORWARD_NULL)
>>>     Comparing "m" to null implies that "m" might be null.
529       else if (m && m->get_type() == CEPH_MSG_OSD_OPREPLY)
530         OID_EVENT_TRACE(((MOSDOpReply *)m)->get_oid().name.c_str(), "SEND_MSG_OSD_OP_REPLY");
531     
532       ldout(cct, 1) << __func__ << "--> " << dest.name << " "
533           << dest.addr << " -- " << *m << " -- ?+"
534           << m->get_data().length() << " " << m << dendl;
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 529 in AsyncMessenger::_send_message(Message *, const entity_inst_t &)()
523     
524     int AsyncMessenger::_send_message(Message *m, const entity_inst_t& dest)
525     {
526       FUNCTRACE();
527       if (m && m->get_type() == CEPH_MSG_OSD_OP)
528         OID_EVENT_TRACE(((MOSDOp *)m)->get_oid().name.c_str(), "SEND_MSG_OSD_OP");
>>>     CID 1399578:    (FORWARD_NULL)
>>>     Comparing "m" to null implies that "m" might be null.
529       else if (m && m->get_type() == CEPH_MSG_OSD_OPREPLY)
530         OID_EVENT_TRACE(((MOSDOpReply *)m)->get_oid().name.c_str(), "SEND_MSG_OSD_OP_REPLY");
531     
532       ldout(cct, 1) << __func__ << "--> " << dest.name << " "
533           << dest.addr << " -- " << *m << " -- ?+"
534           << m->get_data().length() << " " << m << dendl;
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 529 in AsyncMessenger::_send_message(Message *, const entity_inst_t &)()
523     
524     int AsyncMessenger::_send_message(Message *m, const entity_inst_t& dest)
525     {
526       FUNCTRACE();
527       if (m && m->get_type() == CEPH_MSG_OSD_OP)
528         OID_EVENT_TRACE(((MOSDOp *)m)->get_oid().name.c_str(), "SEND_MSG_OSD_OP");
>>>     CID 1399578:    (FORWARD_NULL)
>>>     Comparing "m" to null implies that "m" might be null.
529       else if (m && m->get_type() == CEPH_MSG_OSD_OPREPLY)
530         OID_EVENT_TRACE(((MOSDOpReply *)m)->get_oid().name.c_str(), "SEND_MSG_OSD_OP_REPLY");
531     
532       ldout(cct, 1) << __func__ << "--> " << dest.name << " "
533           << dest.addr << " -- " << *m << " -- ?+"
534           << m->get_data().length() << " " << m << dendl;

** CID 1399579:  Program hangs  (LOCK)
/home/brad/working/src/ceph/src/msg/simple/SimpleMessenger.cc: 315 in SimpleMessenger::client_bind(const entity_addr_t &)()


________________________________________________________________________________________________________
*** CID 1399579:  Program hangs  (LOCK)
/home/brad/working/src/ceph/src/msg/simple/SimpleMessenger.cc: 315 in SimpleMessenger::client_bind(const entity_addr_t &)()
309     
310     int SimpleMessenger::client_bind(const entity_addr_t &bind_addr)
311     {
312       lock.Lock();
313       if (did_bind) {
314         assert(my_inst.addr == bind_addr);
>>>     CID 1399579:  Program hangs  (LOCK)
>>>     Returning without unlocking "this->lock._m".
315         return 0;
316       }
317       if (started) {
318         ldout(cct,10) << "rank.bind already started" << dendl;
319         lock.Unlock();
320         return -1;

** CID 1399580:  Program hangs  (LOCK)
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 388 in AsyncMessenger::client_bind(const entity_addr_t &)()


________________________________________________________________________________________________________
*** CID 1399580:  Program hangs  (LOCK)
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 388 in AsyncMessenger::client_bind(const entity_addr_t &)()
382     
383     int AsyncMessenger::client_bind(const entity_addr_t &bind_addr)
384     {
385       lock.Lock();
386       if (did_bind) {
387         assert(my_inst.addr == bind_addr);
>>>     CID 1399580:  Program hangs  (LOCK)
>>>     Returning without unlocking "this->lock._m".
388         return 0;
389       }
390       if (started) {
391         ldout(cct, 10) << __func__ << " already started" << dendl;
392         lock.Unlock();
393         return -1;

** CID 1399581:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/rgw/rgw_file.h: 536 in rgw::RGWFileHandle::set_times(std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>)()


________________________________________________________________________________________________________
*** CID 1399581:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/rgw/rgw_file.h: 536 in rgw::RGWFileHandle::set_times(std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>)()
530           state.size = size;
531         }
532     
533         void set_times(real_time t) {
534           state.ctime = real_clock::to_timespec(t);
535           state.mtime = state.ctime;
>>>     CID 1399581:  Concurrent data access violations  (MISSING_LOCK)
>>>     Accessing "this->state.atime" without holding lock "rgw::RGWFileHandle.mtx". Elsewhere, "_ZN3rgw13RGWFileHandle5StateE.atime" is accessed with "rgw::RGWFileHandle.mtx" held 2 out of 3 times (2 of these accesses strongly imply that it is necessary).
536           state.atime = state.ctime;
537         }
538     
539         void set_ctime(const struct timespec &ts) {
540           state.ctime = ts;
541         }

** CID 1399582:  Integer handling issues  (NO_EFFECT)
/home/brad/working/src/ceph/src/osd/PG.cc: 2536 in PG::_update_calc_stats()()


________________________________________________________________________________________________________
*** CID 1399582:  Integer handling issues  (NO_EFFECT)
/home/brad/working/src/ceph/src/osd/PG.cc: 2536 in PG::_update_calc_stats()()
2530               osd_missing = peer_missing[p].num_missing();
2531               object_copies += peer_info[p].stats.stats.sum.num_objects;
2532             }
2533             missing += osd_missing;
2534             // Count non-missing objects not in up as misplaced
2535             if (!in_up)
>>>     CID 1399582:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "0UL > num_objects - osd_missing".
2536     	  misplaced += MAX(0, num_objects - osd_missing);
2537           } else {
2538             assert(in_up && !in_acting);
2539     
2540             // If this peer has more objects then it should, ignore them
2541             backfilled += MIN(num_objects, peer_info[p].stats.stats.sum.num_objects);

** CID 1399583:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 5041 in TestLibRBD_ExclusiveLock_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1399583:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 5041 in TestLibRBD_ExclusiveLock_Test::TestBody()()
5035       char *lock_owners[1];
5036       size_t max_lock_owners = 0;
5037       ASSERT_EQ(-ERANGE, rbd_lock_get_owners(image1, &lock_mode, lock_owners,
5038                                              &max_lock_owners));
5039       ASSERT_EQ(1U, max_lock_owners);
5040     
>>>     CID 1399583:  Memory - corruptions  (OVERRUN)
>>>     Assigning: "max_lock_owners" = "2UL".
5041       max_lock_owners = 2;
5042       ASSERT_EQ(0, rbd_lock_get_owners(image1, &lock_mode, lock_owners,
5043                                        &max_lock_owners));
5044       ASSERT_EQ(RBD_LOCK_MODE_EXCLUSIVE, lock_mode);
5045       ASSERT_STRNE("", lock_owners[0]);
5046       ASSERT_EQ(1U, max_lock_owners);

** CID 1399584:  Memory - illegal accesses  (OVERRUN)
/home/brad/working/src/ceph/src/zstd/lib/compress/zstd_opt.h: 523 in ZSTD_compressBlock_opt_generic()


________________________________________________________________________________________________________
*** CID 1399584:  Memory - illegal accesses  (OVERRUN)
/home/brad/working/src/ceph/src/zstd/lib/compress/zstd_opt.h: 523 in ZSTD_compressBlock_opt_generic()
517                     opt[cur].rep[0] = ((opt[cur].off==ZSTD_REP_MOVE_OPT) && (mlen != 1)) ? (opt[cur-mlen].rep[0] - 1) : (opt[cur-mlen].rep[opt[cur].off]);
518                }
519     
520                 best_mlen = minMatch;
521                 {   U32 i, last_i = ZSTD_REP_CHECK + (mlen != 1);
522                     for (i=(opt[cur].mlen != 1); i<last_i; i++) {  /* check rep */
>>>     CID 1399584:  Memory - illegal accesses  (OVERRUN)
>>>     Overrunning array "(opt + cur).rep" of 3 4-byte elements at element index 4 (byte offset 16) using index "i" (which evaluates to 4).
523                         const S32 repCur = (i==ZSTD_REP_MOVE_OPT) ? (opt[cur].rep[0] - 1) : opt[cur].rep[i];
524                         if ( (repCur > 0) && (repCur < (S32)(inr-prefixStart))
525                            && (MEM_readMINMATCH(inr, minMatch) == MEM_readMINMATCH(inr - repCur, minMatch))) {
526                            mlen = (U32)ZSTD_count(inr+minMatch, inr+minMatch - repCur, iend) + minMatch;
527     
528                            if (mlen > sufficient_len || cur + mlen >= ZSTD_OPT_NUM) {

** CID 1399585:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3483 in TestLibRBD_FlattenNoEmptyObjects_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1399585:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3483 in TestLibRBD_FlattenNoEmptyObjects_Test::TestBody()()
3477       printf("flattening clone: \"%s\"\n", child_name.c_str());
3478       ASSERT_EQ(0, rbd_flatten(child));
3479     
3480       printf("check whether child image has the same set of objects as parent\n");
3481       rbd_image_info_t c_info;
3482       ASSERT_EQ(0, rbd_stat(child, &c_info, sizeof(c_info)));
>>>     CID 1399585:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "list_ctx" going out of scope leaks the storage it points to.
3483       ASSERT_EQ(0, rados_nobjects_list_open(d_ioctx, &list_ctx));
3484       while (rados_nobjects_list_next(list_ctx, &entry, NULL, NULL) != -ENOENT) {
3485         if (strstr(entry, c_info.block_name_prefix)) {
3486           const char *block_name_suffix = entry + strlen(c_info.block_name_prefix) + 1;
3487           set<string>::iterator it = obj_checker.find(block_name_suffix);
3488           ASSERT_TRUE(it != obj_checker.end());

** CID 1399586:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1827 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1826 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1825 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1823 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1821 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1819 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1818 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1817 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1816 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1815 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1813 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1811 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1810 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1809 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1807 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1805 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1800 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1799 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1798 in LibCephFS_OperationsOnRoot_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1797 in LibCephFS_OperationsOnRoot_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1399586:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1827 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1821       ASSERT_EQ(ceph_mkdir(cmount, "/", 0777), -EEXIST);
1822     
1823       ASSERT_EQ(ceph_mknod(cmount, "/", 0, 0), -EEXIST);
1824     
1825       ASSERT_EQ(ceph_symlink(cmount, "/", "/"), -EEXIST);
1826       ASSERT_EQ(ceph_symlink(cmount, dirname, "/"), -EEXIST);
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1827       ASSERT_EQ(ceph_symlink(cmount, "nonExistingDir", "/"), -EEXIST);
1828     
1829       ceph_shutdown(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1826 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1820     
1821       ASSERT_EQ(ceph_mkdir(cmount, "/", 0777), -EEXIST);
1822     
1823       ASSERT_EQ(ceph_mknod(cmount, "/", 0, 0), -EEXIST);
1824     
1825       ASSERT_EQ(ceph_symlink(cmount, "/", "/"), -EEXIST);
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1826       ASSERT_EQ(ceph_symlink(cmount, dirname, "/"), -EEXIST);
1827       ASSERT_EQ(ceph_symlink(cmount, "nonExistingDir", "/"), -EEXIST);
1828     
1829       ceph_shutdown(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1825 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1819       ASSERT_EQ(ceph_rename(cmount, "/", "nonExistingDir"), -EBUSY);
1820     
1821       ASSERT_EQ(ceph_mkdir(cmount, "/", 0777), -EEXIST);
1822     
1823       ASSERT_EQ(ceph_mknod(cmount, "/", 0, 0), -EEXIST);
1824     
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1825       ASSERT_EQ(ceph_symlink(cmount, "/", "/"), -EEXIST);
1826       ASSERT_EQ(ceph_symlink(cmount, dirname, "/"), -EEXIST);
1827       ASSERT_EQ(ceph_symlink(cmount, "nonExistingDir", "/"), -EEXIST);
1828     
1829       ceph_shutdown(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1823 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1817       ASSERT_EQ(ceph_rename(cmount, "nonExistingDir", "/"), -EBUSY);
1818       ASSERT_EQ(ceph_rename(cmount, "/", dirname), -EBUSY);
1819       ASSERT_EQ(ceph_rename(cmount, "/", "nonExistingDir"), -EBUSY);
1820     
1821       ASSERT_EQ(ceph_mkdir(cmount, "/", 0777), -EEXIST);
1822     
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1823       ASSERT_EQ(ceph_mknod(cmount, "/", 0, 0), -EEXIST);
1824     
1825       ASSERT_EQ(ceph_symlink(cmount, "/", "/"), -EEXIST);
1826       ASSERT_EQ(ceph_symlink(cmount, dirname, "/"), -EEXIST);
1827       ASSERT_EQ(ceph_symlink(cmount, "nonExistingDir", "/"), -EEXIST);
1828     
1829       ceph_shutdown(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1821 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1815       ASSERT_EQ(ceph_rename(cmount, "/", "/"), -EBUSY);
1816       ASSERT_EQ(ceph_rename(cmount, dirname, "/"), -EBUSY);
1817       ASSERT_EQ(ceph_rename(cmount, "nonExistingDir", "/"), -EBUSY);
1818       ASSERT_EQ(ceph_rename(cmount, "/", dirname), -EBUSY);
1819       ASSERT_EQ(ceph_rename(cmount, "/", "nonExistingDir"), -EBUSY);
1820     
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1821       ASSERT_EQ(ceph_mkdir(cmount, "/", 0777), -EEXIST);
1822     
1823       ASSERT_EQ(ceph_mknod(cmount, "/", 0, 0), -EEXIST);
1824     
1825       ASSERT_EQ(ceph_symlink(cmount, "/", "/"), -EEXIST);
1826       ASSERT_EQ(ceph_symlink(cmount, dirname, "/"), -EEXIST);
1827       ASSERT_EQ(ceph_symlink(cmount, "nonExistingDir", "/"), -EEXIST);
1828     
1829       ceph_shutdown(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1819 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1813       ASSERT_EQ(ceph_unlink(cmount, "/"), -EISDIR);
1814     
1815       ASSERT_EQ(ceph_rename(cmount, "/", "/"), -EBUSY);
1816       ASSERT_EQ(ceph_rename(cmount, dirname, "/"), -EBUSY);
1817       ASSERT_EQ(ceph_rename(cmount, "nonExistingDir", "/"), -EBUSY);
1818       ASSERT_EQ(ceph_rename(cmount, "/", dirname), -EBUSY);
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1819       ASSERT_EQ(ceph_rename(cmount, "/", "nonExistingDir"), -EBUSY);
1820     
1821       ASSERT_EQ(ceph_mkdir(cmount, "/", 0777), -EEXIST);
1822     
1823       ASSERT_EQ(ceph_mknod(cmount, "/", 0, 0), -EEXIST);
1824     
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1818 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1812     
1813       ASSERT_EQ(ceph_unlink(cmount, "/"), -EISDIR);
1814     
1815       ASSERT_EQ(ceph_rename(cmount, "/", "/"), -EBUSY);
1816       ASSERT_EQ(ceph_rename(cmount, dirname, "/"), -EBUSY);
1817       ASSERT_EQ(ceph_rename(cmount, "nonExistingDir", "/"), -EBUSY);
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1818       ASSERT_EQ(ceph_rename(cmount, "/", dirname), -EBUSY);
1819       ASSERT_EQ(ceph_rename(cmount, "/", "nonExistingDir"), -EBUSY);
1820     
1821       ASSERT_EQ(ceph_mkdir(cmount, "/", 0777), -EEXIST);
1822     
1823       ASSERT_EQ(ceph_mknod(cmount, "/", 0, 0), -EEXIST);
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1817 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1811       ASSERT_EQ(ceph_link(cmount, "nonExisitingDir", "/"), -ENOENT);
1812     
1813       ASSERT_EQ(ceph_unlink(cmount, "/"), -EISDIR);
1814     
1815       ASSERT_EQ(ceph_rename(cmount, "/", "/"), -EBUSY);
1816       ASSERT_EQ(ceph_rename(cmount, dirname, "/"), -EBUSY);
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1817       ASSERT_EQ(ceph_rename(cmount, "nonExistingDir", "/"), -EBUSY);
1818       ASSERT_EQ(ceph_rename(cmount, "/", dirname), -EBUSY);
1819       ASSERT_EQ(ceph_rename(cmount, "/", "nonExistingDir"), -EBUSY);
1820     
1821       ASSERT_EQ(ceph_mkdir(cmount, "/", 0777), -EEXIST);
1822     
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1816 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1810       ASSERT_EQ(ceph_link(cmount, dirname, "/"), -EEXIST);
1811       ASSERT_EQ(ceph_link(cmount, "nonExisitingDir", "/"), -ENOENT);
1812     
1813       ASSERT_EQ(ceph_unlink(cmount, "/"), -EISDIR);
1814     
1815       ASSERT_EQ(ceph_rename(cmount, "/", "/"), -EBUSY);
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1816       ASSERT_EQ(ceph_rename(cmount, dirname, "/"), -EBUSY);
1817       ASSERT_EQ(ceph_rename(cmount, "nonExistingDir", "/"), -EBUSY);
1818       ASSERT_EQ(ceph_rename(cmount, "/", dirname), -EBUSY);
1819       ASSERT_EQ(ceph_rename(cmount, "/", "nonExistingDir"), -EBUSY);
1820     
1821       ASSERT_EQ(ceph_mkdir(cmount, "/", 0777), -EEXIST);
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1815 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1809       ASSERT_EQ(ceph_link(cmount, "/", "/"), -EEXIST);
1810       ASSERT_EQ(ceph_link(cmount, dirname, "/"), -EEXIST);
1811       ASSERT_EQ(ceph_link(cmount, "nonExisitingDir", "/"), -ENOENT);
1812     
1813       ASSERT_EQ(ceph_unlink(cmount, "/"), -EISDIR);
1814     
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1815       ASSERT_EQ(ceph_rename(cmount, "/", "/"), -EBUSY);
1816       ASSERT_EQ(ceph_rename(cmount, dirname, "/"), -EBUSY);
1817       ASSERT_EQ(ceph_rename(cmount, "nonExistingDir", "/"), -EBUSY);
1818       ASSERT_EQ(ceph_rename(cmount, "/", dirname), -EBUSY);
1819       ASSERT_EQ(ceph_rename(cmount, "/", "nonExistingDir"), -EBUSY);
1820     
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1813 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1807       ASSERT_EQ(ceph_rmdir(cmount, "/"), -EBUSY);
1808     
1809       ASSERT_EQ(ceph_link(cmount, "/", "/"), -EEXIST);
1810       ASSERT_EQ(ceph_link(cmount, dirname, "/"), -EEXIST);
1811       ASSERT_EQ(ceph_link(cmount, "nonExisitingDir", "/"), -ENOENT);
1812     
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1813       ASSERT_EQ(ceph_unlink(cmount, "/"), -EISDIR);
1814     
1815       ASSERT_EQ(ceph_rename(cmount, "/", "/"), -EBUSY);
1816       ASSERT_EQ(ceph_rename(cmount, dirname, "/"), -EBUSY);
1817       ASSERT_EQ(ceph_rename(cmount, "nonExistingDir", "/"), -EBUSY);
1818       ASSERT_EQ(ceph_rename(cmount, "/", dirname), -EBUSY);
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1811 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1805       ASSERT_EQ(ceph_mkdir(cmount, dirname, 0755), 0);
1806     
1807       ASSERT_EQ(ceph_rmdir(cmount, "/"), -EBUSY);
1808     
1809       ASSERT_EQ(ceph_link(cmount, "/", "/"), -EEXIST);
1810       ASSERT_EQ(ceph_link(cmount, dirname, "/"), -EEXIST);
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1811       ASSERT_EQ(ceph_link(cmount, "nonExisitingDir", "/"), -ENOENT);
1812     
1813       ASSERT_EQ(ceph_unlink(cmount, "/"), -EISDIR);
1814     
1815       ASSERT_EQ(ceph_rename(cmount, "/", "/"), -EBUSY);
1816       ASSERT_EQ(ceph_rename(cmount, dirname, "/"), -EBUSY);
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1810 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1804     
1805       ASSERT_EQ(ceph_mkdir(cmount, dirname, 0755), 0);
1806     
1807       ASSERT_EQ(ceph_rmdir(cmount, "/"), -EBUSY);
1808     
1809       ASSERT_EQ(ceph_link(cmount, "/", "/"), -EEXIST);
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1810       ASSERT_EQ(ceph_link(cmount, dirname, "/"), -EEXIST);
1811       ASSERT_EQ(ceph_link(cmount, "nonExisitingDir", "/"), -ENOENT);
1812     
1813       ASSERT_EQ(ceph_unlink(cmount, "/"), -EISDIR);
1814     
1815       ASSERT_EQ(ceph_rename(cmount, "/", "/"), -EBUSY);
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1809 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1803       sprintf(dirname, "/somedir%x", getpid());
1804     
1805       ASSERT_EQ(ceph_mkdir(cmount, dirname, 0755), 0);
1806     
1807       ASSERT_EQ(ceph_rmdir(cmount, "/"), -EBUSY);
1808     
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1809       ASSERT_EQ(ceph_link(cmount, "/", "/"), -EEXIST);
1810       ASSERT_EQ(ceph_link(cmount, dirname, "/"), -EEXIST);
1811       ASSERT_EQ(ceph_link(cmount, "nonExisitingDir", "/"), -ENOENT);
1812     
1813       ASSERT_EQ(ceph_unlink(cmount, "/"), -EISDIR);
1814     
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1807 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1801     
1802       char dirname[32];
1803       sprintf(dirname, "/somedir%x", getpid());
1804     
1805       ASSERT_EQ(ceph_mkdir(cmount, dirname, 0755), 0);
1806     
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1807       ASSERT_EQ(ceph_rmdir(cmount, "/"), -EBUSY);
1808     
1809       ASSERT_EQ(ceph_link(cmount, "/", "/"), -EEXIST);
1810       ASSERT_EQ(ceph_link(cmount, dirname, "/"), -EEXIST);
1811       ASSERT_EQ(ceph_link(cmount, "nonExisitingDir", "/"), -ENOENT);
1812     
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1805 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1799       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
1800       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1801     
1802       char dirname[32];
1803       sprintf(dirname, "/somedir%x", getpid());
1804     
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1805       ASSERT_EQ(ceph_mkdir(cmount, dirname, 0755), 0);
1806     
1807       ASSERT_EQ(ceph_rmdir(cmount, "/"), -EBUSY);
1808     
1809       ASSERT_EQ(ceph_link(cmount, "/", "/"), -EEXIST);
1810       ASSERT_EQ(ceph_link(cmount, dirname, "/"), -EEXIST);
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1800 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1794     TEST(LibCephFS, OperationsOnRoot)
1795     {
1796       struct ceph_mount_info *cmount;
1797       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
1798       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
1799       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1800       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1801     
1802       char dirname[32];
1803       sprintf(dirname, "/somedir%x", getpid());
1804     
1805       ASSERT_EQ(ceph_mkdir(cmount, dirname, 0755), 0);
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1799 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1793     
1794     TEST(LibCephFS, OperationsOnRoot)
1795     {
1796       struct ceph_mount_info *cmount;
1797       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
1798       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1799       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
1800       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1801     
1802       char dirname[32];
1803       sprintf(dirname, "/somedir%x", getpid());
1804     
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1798 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1792     }
1793     
1794     TEST(LibCephFS, OperationsOnRoot)
1795     {
1796       struct ceph_mount_info *cmount;
1797       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1798       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
1799       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
1800       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1801     
1802       char dirname[32];
1803       sprintf(dirname, "/somedir%x", getpid());
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1797 in LibCephFS_OperationsOnRoot_Test::TestBody()()
1791       ceph_shutdown(cmount);
1792     }
1793     
1794     TEST(LibCephFS, OperationsOnRoot)
1795     {
1796       struct ceph_mount_info *cmount;
>>>     CID 1399586:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1797       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
1798       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
1799       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
1800       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1801     
1802       char dirname[32];

** CID 1399587:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/msg/async/net_handler.cc: 178 in ceph::NetHandler::generic_connect(const entity_addr_t &, const entity_addr_t &, bool)()
/home/brad/working/src/ceph/src/msg/async/net_handler.cc: 178 in ceph::NetHandler::generic_connect(const entity_addr_t &, const entity_addr_t &, bool)()


________________________________________________________________________________________________________
*** CID 1399587:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/msg/async/net_handler.cc: 178 in ceph::NetHandler::generic_connect(const entity_addr_t &, const entity_addr_t &, bool)()
172         if (cct->_conf->ms_bind_before_connect && (!addr.is_blank_ip())) {
173           addr.set_port(0);
174           ret = ::bind(s, addr.get_sockaddr(), addr.get_sockaddr_len());
175           if (ret < 0) {
176             ret = -errno;
177             ldout(cct, 2) << __func__ << " client bind error " << ", " << cpp_strerror(ret) << dendl;
>>>     CID 1399587:    (RESOURCE_LEAK)
>>>     Handle variable "s" going out of scope leaks the handle.
178             return ret;
179           }
180         }
181       }
182     
183       ret = ::connect(s, addr.get_sockaddr(), addr.get_sockaddr_len());
/home/brad/working/src/ceph/src/msg/async/net_handler.cc: 178 in ceph::NetHandler::generic_connect(const entity_addr_t &, const entity_addr_t &, bool)()
172         if (cct->_conf->ms_bind_before_connect && (!addr.is_blank_ip())) {
173           addr.set_port(0);
174           ret = ::bind(s, addr.get_sockaddr(), addr.get_sockaddr_len());
175           if (ret < 0) {
176             ret = -errno;
177             ldout(cct, 2) << __func__ << " client bind error " << ", " << cpp_strerror(ret) << dendl;
>>>     CID 1399587:    (RESOURCE_LEAK)
>>>     Handle variable "s" going out of scope leaks the handle.
178             return ret;
179           }
180         }
181       }
182     
183       ret = ::connect(s, addr.get_sockaddr(), addr.get_sockaddr_len());

** CID 1399588:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/zdict.c: 908 in ZDICT_trainFromBuffer_unsafe()


________________________________________________________________________________________________________
*** CID 1399588:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/zdict.c: 908 in ZDICT_trainFromBuffer_unsafe()
902             DISPLAYLEVEL(3, "list %u best segments \n", nb-1);
903             for (u=1; u<nb; u++) {
904                 U32 const pos = dictList[u].pos;
905                 U32 const length = dictList[u].length;
906                 U32 const printedLength = MIN(40, length);
907                 if ((pos > samplesBuffSize) || ((pos + length) > samplesBuffSize))
>>>     CID 1399588:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "dictList" going out of scope leaks the storage it points to.
908                     return ERROR(GENERIC);   /* should never happen */
909                 DISPLAYLEVEL(3, "%3u:%3u bytes at pos %8u, savings %7u bytes |",
910                              u, length, pos, dictList[u].savings);
911                 ZDICT_printHex((const char*)samplesBuffer+pos, printedLength);
912                 DISPLAYLEVEL(3, "| \n");
913         }   }

** CID 1399589:  Insecure data handling  (TAINTED_SCALAR)
/home/brad/working/src/ceph/src/librbd/managed_lock/Utils.cc: 26 in librbd::managed_lock::util::decode_lock_cookie(const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long *)()


________________________________________________________________________________________________________
*** CID 1399589:  Insecure data handling  (TAINTED_SCALAR)
/home/brad/working/src/ceph/src/librbd/managed_lock/Utils.cc: 26 in librbd::managed_lock::util::decode_lock_cookie(const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long *)()
20       return WATCHER_LOCK_TAG;
21     }
22     
23     bool decode_lock_cookie(const std::string &tag, uint64_t *handle) {
24       std::string prefix;
25       std::istringstream ss(tag);
>>>     CID 1399589:  Insecure data handling  (TAINTED_SCALAR)
>>>     Calling function "operator >>" taints argument "prefix".
26       if (!(ss >> prefix >> *handle) || prefix != WATCHER_LOCK_COOKIE_PREFIX) {
27         return false;
28       }
29       return true;
30     }
31     


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8F-2FSrHHeUw77GfuYhRonfTSUes-2BsyNAqZdZ1oRr4a8LOG1uIo5p-2BRfIuyaLcYfJLSymmhxUQRzPrY0KRXLG1StoyD-2FaQLAlf6yMJ5vQ3JKxioFg44aeyf1d-2BlyRDrqHpTPUd-2FTEWlme5vhYmdCVjz1F65XvYKrfS5baCrOiX4fajHr85QkbZLMTloo-2BWHpf2nU-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8F-2FSrHHeUw77GfuYhRonfTSUes-2BsyNAqZdZ1oRr4a8LOE-2FT7TFobtNXgClUIMSV4gHSPiLdtSjqtCKUkKTXFN5gtFEBuydTCHyxLsf-2FcAHKFEH6xecGTCHAo2x-2Bi-2FuPnxuovxBwkhwu66p1h0Ls5bbb9qHnhIhZ7eqc9uURoDPEYEVJZEQMCc4n7m83lSx-2BFew-3D

