From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 09 Nov 2017 11:36:17 +0000 (UTC)
Message-ID: <5a043db180ffd_728bef531c69015@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.hv1nn.shared.sendgrid.net ([167.89.100.169]:25244 "EHLO
        o1.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753972AbdKILgT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Nov 2017 06:36:19 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0018p1las1.sendgrid.net (SG) with ESMTP id iS1RwBaoSHC5ABHMj5xX1Q
        for <ceph-devel@vger.kernel.org>; Thu, 09 Nov 2017 11:36:17.755 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

27 new defect(s) introduced to ceph found with Coverity Scan.
21 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 27 defect(s)


** CID 1420670:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 56 in librbd::deep_copy::<unnamed>::scribble(librbd::ImageCtx *, int, unsigned long, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()


________________________________________________________________________________________________________
*** CID 1420670:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 56 in librbd::deep_copy::<unnamed>::scribble(librbd::ImageCtx *, int, unsigned long, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
50     
51     namespace {
52     
53     void scribble(librbd::ImageCtx *image_ctx, int num_ops, size_t max_size,
54                   interval_set<uint64_t> *what)
55     {
>>>     CID 1420670:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "1 << image_ctx->order" with type "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "uint64_t" (64 bits, unsigned).
56       uint64_t object_size = 1 << image_ctx->order;
57       for (int i = 0; i < num_ops; i++) {
58         uint64_t off = rand() % (object_size - max_size + 1);
59         uint64_t len = 1 + rand() % max_size;
60         std::cout << __func__ << ": off=" << off << ", len=" << len << std::endl;
61     

** CID 1420671:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 771 in librbd::deep_copy::TestMockDeepCopyObjectCopyRequest_Remove_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1420671:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 771 in librbd::deep_copy::TestMockDeepCopyObjectCopyRequest_Remove_Test::TestBody()()
765       interval_set<uint64_t> one;
766       scribble(m_src_image_ctx, 10, 102400, &one);
767       ASSERT_EQ(0, create_snap("one"));
768       ASSERT_EQ(0, create_snap("two"));
769     
770       // remove the object
>>>     CID 1420671:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "1 << this->m_src_image_ctx->order" with type "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "uint64_t" (64 bits, unsigned).
771       uint64_t object_size = 1 << m_src_image_ctx->order;
772       ASSERT_LE(0, m_src_image_ctx->io_work_queue->discard(0, object_size, m_src_image_ctx->skip_partial_discard));
773       ASSERT_EQ(0, create_snap("copy"));
774       librbd::MockTestImageCtx mock_src_image_ctx(*m_src_image_ctx);
775       librbd::MockTestImageCtx mock_dst_image_ctx(*m_dst_image_ctx);
776     

** CID 1420672:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 58 in librbd::deep_copy::<unnamed>::scribble(librbd::ImageCtx *, int, unsigned long, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 59 in librbd::deep_copy::<unnamed>::scribble(librbd::ImageCtx *, int, unsigned long, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()


________________________________________________________________________________________________________
*** CID 1420672:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 58 in librbd::deep_copy::<unnamed>::scribble(librbd::ImageCtx *, int, unsigned long, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
52     
53     void scribble(librbd::ImageCtx *image_ctx, int num_ops, size_t max_size,
54                   interval_set<uint64_t> *what)
55     {
56       uint64_t object_size = 1 << image_ctx->order;
57       for (int i = 0; i < num_ops; i++) {
>>>     CID 1420672:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
58         uint64_t off = rand() % (object_size - max_size + 1);
59         uint64_t len = 1 + rand() % max_size;
60         std::cout << __func__ << ": off=" << off << ", len=" << len << std::endl;
61     
62         bufferlist bl;
63         bl.append(std::string(len, '1'));
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 59 in librbd::deep_copy::<unnamed>::scribble(librbd::ImageCtx *, int, unsigned long, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
53     void scribble(librbd::ImageCtx *image_ctx, int num_ops, size_t max_size,
54                   interval_set<uint64_t> *what)
55     {
56       uint64_t object_size = 1 << image_ctx->order;
57       for (int i = 0; i < num_ops; i++) {
58         uint64_t off = rand() % (object_size - max_size + 1);
>>>     CID 1420672:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
59         uint64_t len = 1 + rand() % max_size;
60         std::cout << __func__ << ": off=" << off << ", len=" << len << std::endl;
61     
62         bufferlist bl;
63         bl.append(std::string(len, '1'));
64     

** CID 1420673:  Integer handling issues  (NO_EFFECT)
/include/tracing/librbd.h: 1036 in __event_prepare_filter_stack__librbd___deep_copy_enter()


________________________________________________________________________________________________________
*** CID 1420673:  Integer handling issues  (NO_EFFECT)
/include/tracing/librbd.h: 1036 in __event_prepare_filter_stack__librbd___deep_copy_enter()
1030             int, retval),
1031         TP_FIELDS(
1032             ctf_integer(int, retval, retval)
1033         )
1034     )
1035     
>>>     CID 1420673:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "18446744073709551615UL < 0UL".
1036     TRACEPOINT_EVENT(librbd, deep_copy_enter,
1037         TP_ARGS(
1038             void*, src_imagectx,
1039             const char*, src_name,
1040             const char*, src_snap_name,
1041             char, src_read_only,

** CID 1420674:  Memory - corruptions  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 306 in librbd::deep_copy::TestMockDeepCopyObjectCopyRequest::create_snap(const char *)()


________________________________________________________________________________________________________
*** CID 1420674:  Memory - corruptions  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 306 in librbd::deep_copy::TestMockDeepCopyObjectCopyRequest::create_snap(const char *)()
300           return r;
301         }
302     
303         // collection of all existing snaps in dst image
304         SnapIds dst_snap_ids({dst_snap_id});
305         if (!m_snap_map.empty()) {
>>>     CID 1420674:  Memory - corruptions  (MISMATCHED_ITERATOR)
>>>     Using iterator "std::map<unsigned long, std::vector<unsigned long, std::allocator<unsigned long> >, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, std::vector<unsigned long, std::allocator<unsigned long> > > > >::reverse_iterator(this->m_snap_map.rbegin())->second.end()" from "std::map<unsigned long, std::vector<unsigned long, std::allocator<unsigned long> >, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, std::vector<unsigned long, std::allocator<unsigned long> > > > >::reverse_iterator(this->m_snap_map.rbegin())->second" with "dst_snap_ids".
306           dst_snap_ids.insert(dst_snap_ids.end(),
307                                 m_snap_map.rbegin()->second.begin(),
308                                 m_snap_map.rbegin()->second.end());
309         }
310         m_snap_map[src_snap_id] = dst_snap_ids;
311         m_src_snap_ids.push_back(src_snap_id);

** CID 1420675:  Memory - corruptions  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ImageCopyRequest.cc: 188 in librbd::deep_copy::TestMockDeepCopyImageCopyRequest::create_snap(const char *, unsigned long *)()


________________________________________________________________________________________________________
*** CID 1420675:  Memory - corruptions  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ImageCopyRequest.cc: 188 in librbd::deep_copy::TestMockDeepCopyImageCopyRequest::create_snap(const char *, unsigned long *)()
182           return r;
183         }
184     
185         // collection of all existing snaps in dst image
186         SnapIds dst_snap_ids({dst_snap_id});
187         if (!m_snap_map.empty()) {
>>>     CID 1420675:  Memory - corruptions  (MISMATCHED_ITERATOR)
>>>     Using iterator "std::map<unsigned long, std::vector<unsigned long, std::allocator<unsigned long> >, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, std::vector<unsigned long, std::allocator<unsigned long> > > > >::reverse_iterator(this->m_snap_map.rbegin())->second.begin()" from "std::map<unsigned long, std::vector<unsigned long, std::allocator<unsigned long> >, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, std::vector<unsigned long, std::allocator<unsigned long> > > > >::reverse_iterator(this->m_snap_map.rbegin())->second" with "dst_snap_ids".
188           dst_snap_ids.insert(dst_snap_ids.end(),
189                               m_snap_map.rbegin()->second.begin(),
190                               m_snap_map.rbegin()->second.end());
191         }
192         m_snap_map[src_snap_id] = dst_snap_ids;
193         m_snap_seqs[src_snap_id] = dst_snap_id;

** CID 1420676:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librbd/test_mock_DeepCopyRequest.cc: 82 in librbd::deep_copy::MetadataCopyRequest<librbd::<unnamed>::MockTestImageCtx>::MetadataCopyRequest()()


________________________________________________________________________________________________________
*** CID 1420676:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librbd/test_mock_DeepCopyRequest.cc: 82 in librbd::deep_copy::MetadataCopyRequest<librbd::<unnamed>::MockTestImageCtx>::MetadataCopyRequest()()
76         s_instance->on_finish = on_finish;
77         return s_instance;
78       }
79     
80       MetadataCopyRequest() {
81         s_instance = this;
>>>     CID 1420676:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "on_finish" is not initialized in this constructor nor in any functions that it calls.
82       }
83     
84       MOCK_METHOD0(send, void());
85     };
86     
87     template <>

** CID 1420677:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 397 in TestDeepCopy_Stress_StrippingSmallerDstObjSize_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 398 in TestDeepCopy_Stress_StrippingSmallerDstObjSize_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 399 in TestDeepCopy_Stress_StrippingSmallerDstObjSize_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1420677:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 397 in TestDeepCopy_Stress_StrippingSmallerDstObjSize_Test::TestBody()()
391     }
392     
393     TEST_F(TestDeepCopy, Stress_StrippingSmallerDstObjSize)
394     {
395       REQUIRE_FEATURE(RBD_FEATURE_STRIPINGV2);
396     
>>>     CID 1420677:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
397       uint64_t order = m_src_ictx->order - 1 - rand() % 2;
398       uint64_t stripe_unit = 1 << (order - rand() % 4);
399       uint64_t stripe_count = 2 + rand() % 14;
400       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_ORDER, order));
401       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit));
402       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count));
403     
404       test_stress();
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 398 in TestDeepCopy_Stress_StrippingSmallerDstObjSize_Test::TestBody()()
392     
393     TEST_F(TestDeepCopy, Stress_StrippingSmallerDstObjSize)
394     {
395       REQUIRE_FEATURE(RBD_FEATURE_STRIPINGV2);
396     
397       uint64_t order = m_src_ictx->order - 1 - rand() % 2;
>>>     CID 1420677:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
398       uint64_t stripe_unit = 1 << (order - rand() % 4);
399       uint64_t stripe_count = 2 + rand() % 14;
400       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_ORDER, order));
401       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit));
402       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count));
403     
404       test_stress();
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 399 in TestDeepCopy_Stress_StrippingSmallerDstObjSize_Test::TestBody()()
393     TEST_F(TestDeepCopy, Stress_StrippingSmallerDstObjSize)
394     {
395       REQUIRE_FEATURE(RBD_FEATURE_STRIPINGV2);
396     
397       uint64_t order = m_src_ictx->order - 1 - rand() % 2;
398       uint64_t stripe_unit = 1 << (order - rand() % 4);
>>>     CID 1420677:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
399       uint64_t stripe_count = 2 + rand() % 14;
400       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_ORDER, order));
401       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit));
402       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count));
403     
404       test_stress();

** CID 1420678:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 398 in TestDeepCopy_Stress_StrippingSmallerDstObjSize_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1420678:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 398 in TestDeepCopy_Stress_StrippingSmallerDstObjSize_Test::TestBody()()
392     
393     TEST_F(TestDeepCopy, Stress_StrippingSmallerDstObjSize)
394     {
395       REQUIRE_FEATURE(RBD_FEATURE_STRIPINGV2);
396     
397       uint64_t order = m_src_ictx->order - 1 - rand() % 2;
>>>     CID 1420678:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "1 << order - rand() % 4" with type "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "uint64_t" (64 bits, unsigned).
398       uint64_t stripe_unit = 1 << (order - rand() % 4);
399       uint64_t stripe_count = 2 + rand() % 14;
400       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_ORDER, order));
401       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit));
402       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count));
403     
404       test_stress();

** CID 1420679:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 384 in TestDeepCopy_Snaps_StrippingSmallerDstObjSize_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1420679:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 384 in TestDeepCopy_Snaps_StrippingSmallerDstObjSize_Test::TestBody()()
378     
379     TEST_F(TestDeepCopy, Snaps_StrippingSmallerDstObjSize)
380     {
381       REQUIRE_FEATURE(RBD_FEATURE_STRIPINGV2);
382     
383       uint64_t order = m_src_ictx->order - 1;
>>>     CID 1420679:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "1 << order - 2UL" with type "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "uint64_t" (64 bits, unsigned).
384       uint64_t stripe_unit = 1 << (order - 2);
385       uint64_t stripe_count = 4;
386       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_ORDER, order));
387       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit));
388       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count));
389     

** CID 1420680:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librbd/test_mock_DeepCopyRequest.cc: 54 in librbd::deep_copy::ImageCopyRequest<librbd::<unnamed>::MockTestImageCtx>::ImageCopyRequest()()


________________________________________________________________________________________________________
*** CID 1420680:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librbd/test_mock_DeepCopyRequest.cc: 54 in librbd::deep_copy::ImageCopyRequest<librbd::<unnamed>::MockTestImageCtx>::ImageCopyRequest()()
48         s_instance->on_finish = on_finish;
49         return s_instance;
50       }
51     
52       ImageCopyRequest() {
53         s_instance = this;
>>>     CID 1420680:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "on_finish" is not initialized in this constructor nor in any functions that it calls.
54       }
55     
56       void put() {
57       }
58     
59       void get() {

** CID 1420681:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 342 in TestDeepCopy_Snaps_StrippingLargerDstObjSize_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1420681:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 342 in TestDeepCopy_Snaps_StrippingLargerDstObjSize_Test::TestBody()()
336     
337     TEST_F(TestDeepCopy, Snaps_StrippingLargerDstObjSize)
338     {
339       REQUIRE_FEATURE(RBD_FEATURE_STRIPINGV2);
340     
341       uint64_t order = m_src_ictx->order + 1;
>>>     CID 1420681:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "1 << order - 2UL" with type "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "uint64_t" (64 bits, unsigned).
342       uint64_t stripe_unit = 1 << (order - 2);
343       uint64_t stripe_count = 4;
344       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_ORDER, order));
345       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit));
346       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count));
347     

** CID 1420682:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 355 in TestDeepCopy_Stress_StrippingLargerDstObjSize_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 356 in TestDeepCopy_Stress_StrippingLargerDstObjSize_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 357 in TestDeepCopy_Stress_StrippingLargerDstObjSize_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1420682:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 355 in TestDeepCopy_Stress_StrippingLargerDstObjSize_Test::TestBody()()
349     }
350     
351     TEST_F(TestDeepCopy, Stress_StrippingLargerDstObjSize)
352     {
353       REQUIRE_FEATURE(RBD_FEATURE_STRIPINGV2);
354     
>>>     CID 1420682:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
355       uint64_t order = m_src_ictx->order + 1 + rand() % 2;
356       uint64_t stripe_unit = 1 << (order - rand() % 4);
357       uint64_t stripe_count = 2 + rand() % 14;
358       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_ORDER, order));
359       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit));
360       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count));
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 356 in TestDeepCopy_Stress_StrippingLargerDstObjSize_Test::TestBody()()
350     
351     TEST_F(TestDeepCopy, Stress_StrippingLargerDstObjSize)
352     {
353       REQUIRE_FEATURE(RBD_FEATURE_STRIPINGV2);
354     
355       uint64_t order = m_src_ictx->order + 1 + rand() % 2;
>>>     CID 1420682:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
356       uint64_t stripe_unit = 1 << (order - rand() % 4);
357       uint64_t stripe_count = 2 + rand() % 14;
358       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_ORDER, order));
359       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit));
360       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count));
361     
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 357 in TestDeepCopy_Stress_StrippingLargerDstObjSize_Test::TestBody()()
351     TEST_F(TestDeepCopy, Stress_StrippingLargerDstObjSize)
352     {
353       REQUIRE_FEATURE(RBD_FEATURE_STRIPINGV2);
354     
355       uint64_t order = m_src_ictx->order + 1 + rand() % 2;
356       uint64_t stripe_unit = 1 << (order - rand() % 4);
>>>     CID 1420682:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
357       uint64_t stripe_count = 2 + rand() % 14;
358       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_ORDER, order));
359       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit));
360       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count));
361     
362       test_stress();

** CID 1420683:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 315 in TestDeepCopy_Stress_SmallerDstObjSize_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1420683:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 315 in TestDeepCopy_Stress_SmallerDstObjSize_Test::TestBody()()
309     
310       test_snaps();
311     }
312     
313     TEST_F(TestDeepCopy, Stress_SmallerDstObjSize)
314     {
>>>     CID 1420683:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
315       uint64_t order = m_src_ictx->order - 1 - rand() % 2;
316       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_ORDER, order));
317       uint64_t stripe_unit = m_src_ictx->stripe_unit >> 2;
318       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit));
319     
320       test_stress();

** CID 1420684:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librbd/test_mock_DeepCopyRequest.cc: 126 in librbd::deep_copy::SnapshotCopyRequest<librbd::<unnamed>::MockTestImageCtx>::SnapshotCopyRequest()()


________________________________________________________________________________________________________
*** CID 1420684:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librbd/test_mock_DeepCopyRequest.cc: 126 in librbd::deep_copy::SnapshotCopyRequest<librbd::<unnamed>::MockTestImageCtx>::SnapshotCopyRequest()()
120         s_instance->on_finish = on_finish;
121         return s_instance;
122       }
123     
124       SnapshotCopyRequest() {
125         s_instance = this;
>>>     CID 1420684:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "on_finish" is not initialized in this constructor nor in any functions that it calls.
126       }
127     
128       void put() {
129       }
130     
131       void get() {

** CID 1420685:  Memory - corruptions  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ImageCopyRequest.cc: 188 in librbd::deep_copy::TestMockDeepCopyImageCopyRequest::create_snap(const char *, unsigned long *)()


________________________________________________________________________________________________________
*** CID 1420685:  Memory - corruptions  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ImageCopyRequest.cc: 188 in librbd::deep_copy::TestMockDeepCopyImageCopyRequest::create_snap(const char *, unsigned long *)()
182           return r;
183         }
184     
185         // collection of all existing snaps in dst image
186         SnapIds dst_snap_ids({dst_snap_id});
187         if (!m_snap_map.empty()) {
>>>     CID 1420685:  Memory - corruptions  (MISMATCHED_ITERATOR)
>>>     Using iterator "std::map<unsigned long, std::vector<unsigned long, std::allocator<unsigned long> >, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, std::vector<unsigned long, std::allocator<unsigned long> > > > >::reverse_iterator(this->m_snap_map.rbegin())->second.end()" from "std::map<unsigned long, std::vector<unsigned long, std::allocator<unsigned long> >, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, std::vector<unsigned long, std::allocator<unsigned long> > > > >::reverse_iterator(this->m_snap_map.rbegin())->second" with "dst_snap_ids".
188           dst_snap_ids.insert(dst_snap_ids.end(),
189                               m_snap_map.rbegin()->second.begin(),
190                               m_snap_map.rbegin()->second.end());
191         }
192         m_snap_map[src_snap_id] = dst_snap_ids;
193         m_snap_seqs[src_snap_id] = dst_snap_id;

** CID 1420686:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 718 in librbd::deep_copy::TestMockDeepCopyObjectCopyRequest_Trim_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1420686:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 718 in librbd::deep_copy::TestMockDeepCopyObjectCopyRequest_Trim_Test::TestBody()()
712       // scribble some data
713       interval_set<uint64_t> one;
714       scribble(m_src_image_ctx, 10, 102400, &one);
715       ASSERT_EQ(0, create_snap("one"));
716     
717       // trim the object
>>>     CID 1420686:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
718       uint64_t trim_offset = rand() % one.range_end();
719       ASSERT_LE(0, m_src_image_ctx->io_work_queue->discard(
720         trim_offset, one.range_end() - trim_offset, m_src_image_ctx->skip_partial_discard));
721       ASSERT_EQ(0, create_snap("copy"));
722     
723       librbd::MockTestImageCtx mock_src_image_ctx(*m_src_image_ctx);

** CID 1420687:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 356 in TestDeepCopy_Stress_StrippingLargerDstObjSize_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1420687:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 356 in TestDeepCopy_Stress_StrippingLargerDstObjSize_Test::TestBody()()
350     
351     TEST_F(TestDeepCopy, Stress_StrippingLargerDstObjSize)
352     {
353       REQUIRE_FEATURE(RBD_FEATURE_STRIPINGV2);
354     
355       uint64_t order = m_src_ictx->order + 1 + rand() % 2;
>>>     CID 1420687:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "1 << order - rand() % 4" with type "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "uint64_t" (64 bits, unsigned).
356       uint64_t stripe_unit = 1 << (order - rand() % 4);
357       uint64_t stripe_count = 2 + rand() % 14;
358       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_ORDER, order));
359       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit));
360       ASSERT_EQ(0, m_opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count));
361     

** CID 1420688:  Memory - corruptions  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 306 in librbd::deep_copy::TestMockDeepCopyObjectCopyRequest::create_snap(const char *)()


________________________________________________________________________________________________________
*** CID 1420688:  Memory - corruptions  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/test/librbd/deep_copy/test_mock_ObjectCopyRequest.cc: 306 in librbd::deep_copy::TestMockDeepCopyObjectCopyRequest::create_snap(const char *)()
300           return r;
301         }
302     
303         // collection of all existing snaps in dst image
304         SnapIds dst_snap_ids({dst_snap_id});
305         if (!m_snap_map.empty()) {
>>>     CID 1420688:  Memory - corruptions  (MISMATCHED_ITERATOR)
>>>     Using iterator "std::map<unsigned long, std::vector<unsigned long, std::allocator<unsigned long> >, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, std::vector<unsigned long, std::allocator<unsigned long> > > > >::reverse_iterator(this->m_snap_map.rbegin())->second.begin()" from "std::map<unsigned long, std::vector<unsigned long, std::allocator<unsigned long> >, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, std::vector<unsigned long, std::allocator<unsigned long> > > > >::reverse_iterator(this->m_snap_map.rbegin())->second" with "dst_snap_ids".
306           dst_snap_ids.insert(dst_snap_ids.end(),
307                                 m_snap_map.rbegin()->second.begin(),
308                                 m_snap_map.rbegin()->second.end());
309         }
310         m_snap_map[src_snap_id] = dst_snap_ids;
311         m_src_snap_ids.push_back(src_snap_id);

** CID 1420689:    (TAINTED_SCALAR)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 198 in TestDeepCopy::test_stress()()
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 199 in TestDeepCopy::test_stress()()
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 187 in TestDeepCopy::test_stress()()
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 194 in TestDeepCopy::test_stress()()


________________________________________________________________________________________________________
*** CID 1420689:    (TAINTED_SCALAR)
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 198 in TestDeepCopy::test_stress()()
192         c = getenv("TEST_RBD_DEEPCOPY_STRESS_NWRITES");
193         if (c != NULL) {
194           std::stringstream ss(c);
195           ASSERT_TRUE(ss >> nwrites);
196         }
197     
>>>     CID 1420689:    (TAINTED_SCALAR)
>>>     Using tainted variable "nsnaps" as a loop boundary.
198         for (int i = 0; i < nsnaps; i++) {
199           for (int j = 0; j < nwrites; j++) {
200             size_t len = rand() % ((1 << m_src_ictx->order) * 2);
201             ASSERT_GT(size, len);
202             bufferlist bl;
203             bl.append(std::string(len, static_cast<char>('A' + i)));
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 199 in TestDeepCopy::test_stress()()
193         if (c != NULL) {
194           std::stringstream ss(c);
195           ASSERT_TRUE(ss >> nwrites);
196         }
197     
198         for (int i = 0; i < nsnaps; i++) {
>>>     CID 1420689:    (TAINTED_SCALAR)
>>>     Using tainted variable "nwrites" as a loop boundary.
199           for (int j = 0; j < nwrites; j++) {
200             size_t len = rand() % ((1 << m_src_ictx->order) * 2);
201             ASSERT_GT(size, len);
202             bufferlist bl;
203             bl.append(std::string(len, static_cast<char>('A' + i)));
204             uint64_t off = std::min(static_cast<uint64_t>(rand() % size),
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 187 in TestDeepCopy::test_stress()()
181           size = initial_size = m_src_ictx->get_image_size(CEPH_NOSNAP);
182         }
183     
184         int nsnaps = 4;
185         const char *c = getenv("TEST_RBD_DEEPCOPY_STRESS_NSNAPS");
186         if (c != NULL) {
>>>     CID 1420689:    (TAINTED_SCALAR)
>>>     Call to function "basic_string" with tainted argument "c" transitively taints "<temporary>". [Note: The source code implementation of the function has been overridden by a builtin model.]
187           std::stringstream ss(c);
188           ASSERT_TRUE(ss >> nsnaps);
189         }
190     
191         int nwrites = 4;
192         c = getenv("TEST_RBD_DEEPCOPY_STRESS_NWRITES");
/home/brad/working/src/ceph/src/test/librbd/test_DeepCopy.cc: 194 in TestDeepCopy::test_stress()()
188           ASSERT_TRUE(ss >> nsnaps);
189         }
190     
191         int nwrites = 4;
192         c = getenv("TEST_RBD_DEEPCOPY_STRESS_NWRITES");
193         if (c != NULL) {
>>>     CID 1420689:    (TAINTED_SCALAR)
>>>     Call to function "basic_string" with tainted argument "c" transitively taints "<temporary>". [Note: The source code implementation of the function has been overridden by a builtin model.]
194           std::stringstream ss(c);
195           ASSERT_TRUE(ss >> nwrites);
196         }
197     
198         for (int i = 0; i < nsnaps; i++) {
199           for (int j = 0; j < nwrites; j++) {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E-2BDmhxL2X5vfGFRmxrHDORz2WmRgVkXxt4TRjbyA-2BA9vC1CZ5ojylUUXxogO-2BPzmlO8mwlFH5sc4E-2B3Dm39KoaDsfBj6kW2zdX3pJRKrML7KPiqWtvGEdOJcenAmrAnLO3f0DUy8gXwixB9L3ti6laEe7nqQlcGtH1JQWx-2FEXWWg9-2FYy0l30FQ2frmEhKoGkA-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E-2BDmhxL2X5vfGFRmxrHDORz2WmRgVkXxt4TRjbyA-2BA9s0FKCpP1blYdyDIACPvyCExDCDuyeNJo8LWkbm9KxpFNjWr5ssLdWGkTnsc1F5SpnT8Msqne0rAPmAjP7BSthIyUdbmFhZ24xo6Ya2RKZ9crgwyLFDqygpDntEZ7s-2Fqlwocroku0npHkAPT83kIU4o-3D

