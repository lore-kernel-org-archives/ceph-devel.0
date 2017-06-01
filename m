From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Wed, 31 May 2017 21:33:00 -0700
Message-ID: <592f98fc54df6_4e8d72f330517b3@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:61105 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750726AbdFAEej (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 00:34:39 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0001p1sjc2.sendgrid.net (SG) with ESMTP id -bCnTshoTJCsXHV_8qX7ow
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 04:33:00.388 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

11 new defect(s) introduced to ceph found with Coverity Scan.
3 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 11 of 11 defect(s)


** CID 1411820:  Integer handling issues  (DIVIDE_BY_ZERO)
/home/brad/working/src/ceph/src/test/test_denc.cc: 618 in Legacy::encode_n(unsigned int, const std::vector<unsigned int, std::allocator<unsigned int>> &)()


________________________________________________________________________________________________________
*** CID 1411820:  Integer handling issues  (DIVIDE_BY_ZERO)
/home/brad/working/src/ceph/src/test/test_denc.cc: 618 in Legacy::encode_n(unsigned int, const std::vector<unsigned int, std::allocator<unsigned int>> &)()
612       bufferlist segmented;
613       auto p = bl.begin();
614     
615       auto sum = std::accumulate(segments.begin(), segments.end(), 0u);
616       for (auto i : segments) {
617         buffer::ptr seg;
>>>     CID 1411820:  Integer handling issues  (DIVIDE_BY_ZERO)
>>>     In expression "bl.length() * i / sum", division by expression "sum" which may be zero has undefined behavior.
618         p.copy_deep(bl.length() * i / sum, seg);
619         segmented.push_back(seg);
620       }
621       p.copy_all(segmented);
622       return segmented;
623     }

** CID 1411821:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI15sstring_wrapperE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1411821:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI15sstring_wrapperE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1411821:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1411822:    (NEGATIVE_RETURNS)
/home/brad/working/src/ceph/src/include/buffer.h: 661 in ceph::buffer::list::list(unsigned int)()
/home/brad/working/src/ceph/src/include/rados/buffer.h: 661 in ceph::buffer::list::list(unsigned int)()


________________________________________________________________________________________________________
*** CID 1411822:    (NEGATIVE_RETURNS)
/home/brad/working/src/ceph/src/include/buffer.h: 661 in ceph::buffer::list::list(unsigned int)()
655         int zero_copy_to_fd(int fd) const;
656     
657       public:
658         // cons/des
659         list() : _len(0), _memcopy_count(0), last_p(this) {}
660         // cppcheck-suppress noExplicitConstructor
>>>     CID 1411822:    (NEGATIVE_RETURNS)
>>>     Assigning: "this->_mempool" = a negative value.
661         list(unsigned prealloc) : _len(0), _memcopy_count(0), last_p(this) {
662           reserve(prealloc);
663         }
664     
665         list(const list& other) : _buffers(other._buffers), _len(other._len),
666     			      _memcopy_count(other._memcopy_count), last_p(this) {
/home/brad/working/src/ceph/src/include/rados/buffer.h: 661 in ceph::buffer::list::list(unsigned int)()
655         int zero_copy_to_fd(int fd) const;
656     
657       public:
658         // cons/des
659         list() : _len(0), _memcopy_count(0), last_p(this) {}
660         // cppcheck-suppress noExplicitConstructor
>>>     CID 1411822:    (NEGATIVE_RETURNS)
>>>     Assigning: "this->_mempool" = a negative value.
661         list(unsigned prealloc) : _len(0), _memcopy_count(0), last_p(this) {
662           reserve(prealloc);
663         }
664     
665         list(const list& other) : _buffers(other._buffers), _len(other._len),
666     			      _memcopy_count(other._memcopy_count), last_p(this) {

** CID 1411823:  Null pointer dereferences  (NULL_RETURNS)
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1378 in CrushWrapper::bucket_add_item(crush_bucket *, int, int)()


________________________________________________________________________________________________________
*** CID 1411823:  Null pointer dereferences  (NULL_RETURNS)
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1378 in CrushWrapper::bucket_add_item(crush_bucket *, int, int)()
1372         crush_choose_arg_map arg_map = w.second;
1373         crush_choose_arg *arg = &arg_map.args[-1-bucket->id];
1374         for (__u32 j = 0; j < arg->weight_set_size; j++) {
1375           crush_weight_set *weight_set = &arg->weight_set[j];
1376           weight_set->weights = (__u32*)realloc(weight_set->weights, new_size * sizeof(__u32));
1377           assert(weight_set->size + 1 == new_size);
>>>     CID 1411823:  Null pointer dereferences  (NULL_RETURNS)
>>>     Dereferencing a null pointer "weight_set->weights".
1378           weight_set->weights[weight_set->size] = weight;
1379           weight_set->size = new_size;
1380         }
1381         if (arg->ids_size) {
1382           arg->ids = (int*)realloc(arg->ids, new_size * sizeof(int));
1383           assert(arg->ids_size + 1 == new_size);

** CID 1411824:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1411824:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/osd/osd_types.cc: 4933 in object_manifest_t::encode(ceph::buffer::list &) const()
4927     }
4928     
4929     // -- object_manifest_t --
4930     
4931     void object_manifest_t::encode(bufferlist& bl) const
4932     {
>>>     CID 1411824:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
4933       ENCODE_START(1, 1, bl);
4934       ::encode(type, bl);
4935       switch (type) {
4936         case TYPE_NONE: break;
4937         case TYPE_REDIRECT: 
4938           ::encode(redirect_target, bl);

** CID 1411825:    (OVERRUN)
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1378 in CrushWrapper::bucket_add_item(crush_bucket *, int, int)()
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1378 in CrushWrapper::bucket_add_item(crush_bucket *, int, int)()


________________________________________________________________________________________________________
*** CID 1411825:    (OVERRUN)
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1378 in CrushWrapper::bucket_add_item(crush_bucket *, int, int)()
1372         crush_choose_arg_map arg_map = w.second;
1373         crush_choose_arg *arg = &arg_map.args[-1-bucket->id];
1374         for (__u32 j = 0; j < arg->weight_set_size; j++) {
1375           crush_weight_set *weight_set = &arg->weight_set[j];
1376           weight_set->weights = (__u32*)realloc(weight_set->weights, new_size * sizeof(__u32));
1377           assert(weight_set->size + 1 == new_size);
>>>     CID 1411825:    (OVERRUN)
>>>     Overrunning dynamic array "weight_set->weights" at offset corresponding to index variable "weight_set->size".
1378           weight_set->weights[weight_set->size] = weight;
1379           weight_set->size = new_size;
1380         }
1381         if (arg->ids_size) {
1382           arg->ids = (int*)realloc(arg->ids, new_size * sizeof(int));
1383           assert(arg->ids_size + 1 == new_size);
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1378 in CrushWrapper::bucket_add_item(crush_bucket *, int, int)()
1372         crush_choose_arg_map arg_map = w.second;
1373         crush_choose_arg *arg = &arg_map.args[-1-bucket->id];
1374         for (__u32 j = 0; j < arg->weight_set_size; j++) {
1375           crush_weight_set *weight_set = &arg->weight_set[j];
1376           weight_set->weights = (__u32*)realloc(weight_set->weights, new_size * sizeof(__u32));
1377           assert(weight_set->size + 1 == new_size);
>>>     CID 1411825:    (OVERRUN)
>>>     Overrunning dynamic array "weight_set->weights" at offset corresponding to index variable "weight_set->size".
1378           weight_set->weights[weight_set->size] = weight;
1379           weight_set->size = new_size;
1380         }
1381         if (arg->ids_size) {
1382           arg->ids = (int*)realloc(arg->ids, new_size * sizeof(int));
1383           assert(arg->ids_size + 1 == new_size);

** CID 1411826:    (OVERRUN)
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1384 in CrushWrapper::bucket_add_item(crush_bucket *, int, int)()
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1384 in CrushWrapper::bucket_add_item(crush_bucket *, int, int)()


________________________________________________________________________________________________________
*** CID 1411826:    (OVERRUN)
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1384 in CrushWrapper::bucket_add_item(crush_bucket *, int, int)()
1378           weight_set->weights[weight_set->size] = weight;
1379           weight_set->size = new_size;
1380         }
1381         if (arg->ids_size) {
1382           arg->ids = (int*)realloc(arg->ids, new_size * sizeof(int));
1383           assert(arg->ids_size + 1 == new_size);
>>>     CID 1411826:    (OVERRUN)
>>>     Overrunning dynamic array "arg->ids" at offset corresponding to index variable "arg->ids_size".
1384           arg->ids[arg->ids_size] = item;
1385           arg->ids_size = new_size;
1386         }
1387       }
1388       return crush_bucket_add_item(crush, bucket, item, weight);
1389     }
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1384 in CrushWrapper::bucket_add_item(crush_bucket *, int, int)()
1378           weight_set->weights[weight_set->size] = weight;
1379           weight_set->size = new_size;
1380         }
1381         if (arg->ids_size) {
1382           arg->ids = (int*)realloc(arg->ids, new_size * sizeof(int));
1383           assert(arg->ids_size + 1 == new_size);
>>>     CID 1411826:    (OVERRUN)
>>>     Overrunning dynamic array "arg->ids" at offset corresponding to index variable "arg->ids_size".
1384           arg->ids[arg->ids_size] = item;
1385           arg->ids_size = new_size;
1386         }
1387       }
1388       return crush_bucket_add_item(crush, bucket, item, weight);
1389     }

** CID 1411827:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/tier.cc: 5494 in LibRadosTwoPoolsECPP_SetRedirectRead_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/tier.cc: 5492 in LibRadosTwoPoolsECPP_SetRedirectRead_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1411827:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/tier.cc: 5494 in LibRadosTwoPoolsECPP_SetRedirectRead_Test::TestBody()()
5488       {
5489         ObjectWriteOperation op;
5490         op.set_redirect("bar", cache_ioctx, 0);
5491         librados::AioCompletion *completion = cluster.aio_create_completion();
5492         ASSERT_EQ(0, ioctx.aio_operate("foo", completion, &op));
5493         completion->wait_for_safe();
>>>     CID 1411827:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
5494         ASSERT_EQ(0, completion->get_return_value());
5495         completion->release();
5496       }
5497       // read and verify the object
5498       {
5499         bufferlist bl;
/home/brad/working/src/ceph/src/test/librados/tier.cc: 5492 in LibRadosTwoPoolsECPP_SetRedirectRead_Test::TestBody()()
5486       cluster.wait_for_latest_osdmap();
5487     
5488       {
5489         ObjectWriteOperation op;
5490         op.set_redirect("bar", cache_ioctx, 0);
5491         librados::AioCompletion *completion = cluster.aio_create_completion();
>>>     CID 1411827:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
5492         ASSERT_EQ(0, ioctx.aio_operate("foo", completion, &op));
5493         completion->wait_for_safe();
5494         ASSERT_EQ(0, completion->get_return_value());
5495         completion->release();
5496       }
5497       // read and verify the object

** CID 1411828:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/tier.cc: 2795 in LibRadosTwoPoolsPP_SetRedirectRead_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/tier.cc: 2793 in LibRadosTwoPoolsPP_SetRedirectRead_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1411828:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/tier.cc: 2795 in LibRadosTwoPoolsPP_SetRedirectRead_Test::TestBody()()
2789       {
2790         ObjectWriteOperation op;
2791         op.set_redirect("bar", cache_ioctx, 0);
2792         librados::AioCompletion *completion = cluster.aio_create_completion();
2793         ASSERT_EQ(0, ioctx.aio_operate("foo", completion, &op));
2794         completion->wait_for_safe();
>>>     CID 1411828:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
2795         ASSERT_EQ(0, completion->get_return_value());
2796         completion->release();
2797       }
2798       // read and verify the object
2799       {
2800         bufferlist bl;
/home/brad/working/src/ceph/src/test/librados/tier.cc: 2793 in LibRadosTwoPoolsPP_SetRedirectRead_Test::TestBody()()
2787       cluster.wait_for_latest_osdmap();
2788     
2789       {
2790         ObjectWriteOperation op;
2791         op.set_redirect("bar", cache_ioctx, 0);
2792         librados::AioCompletion *completion = cluster.aio_create_completion();
>>>     CID 1411828:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
2793         ASSERT_EQ(0, ioctx.aio_operate("foo", completion, &op));
2794         completion->wait_for_safe();
2795         ASSERT_EQ(0, completion->get_return_value());
2796         completion->release();
2797       }
2798       // read and verify the object

** CID 1411829:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/osd/TestRados.cc: 55 in WeightedTestGenerator::WeightedTestGenerator(int, int, std::map<TestOpType, unsigned int, std::less<TestOpType>, std::allocator<std::pair<const TestOpType, unsigned int>>>, TestOpStat *, int, bool, bool, bool)()


________________________________________________________________________________________________________
*** CID 1411829:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/osd/TestRados.cc: 55 in WeightedTestGenerator::WeightedTestGenerator(int, int, std::map<TestOpType, unsigned int, std::less<TestOpType>, std::allocator<std::pair<const TestOpType, unsigned int>>>, TestOpStat *, int, bool, bool, bool)()
49         if (m_set_redirect) {
50           /* create redirect objects + set-redirect*/
51           m_redirect_objects = objects*2; // for copy_from + set-redirect test
52           m_initial_redirected_objects = objects;
53           m_ops = ops+m_redirect_objects+m_initial_redirected_objects;
54         }
>>>     CID 1411829:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_initial_redirected_objects" is not initialized in this constructor nor in any functions that it calls.
55       }
56     
57       TestOp *next(RadosTestContext &context) override
58       {
59         TestOp *retval = NULL;
60     

** CID 1411830:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/osd/RadosModel.h: 2126 in UnsetRedirectOp::UnsetRedirectOp(int, RadosTestContext *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, TestOpStat *)()


________________________________________________________________________________________________________
*** CID 1411830:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/osd/RadosModel.h: 2126 in UnsetRedirectOp::UnsetRedirectOp(int, RadosTestContext *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, TestOpStat *)()
2120     
2121       UnsetRedirectOp(int n,
2122     	   RadosTestContext *context,
2123     	   const string &oid,
2124     	   TestOpStat *stat = 0)
2125         : TestOp(n, context, stat), oid(oid)
>>>     CID 1411830:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "comp" is not initialized in this constructor nor in any functions that it calls.
2126       {}
2127     
2128       void _begin() override
2129       {
2130         context->state_lock.Lock();
2131         if (context->get_watch_context(oid)) {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8G5OiOArS4mvucljpKkZw44xl0QoIr8EpGQt1P0w1oaffl7nxw8VV-2FfL-2BSHVBEVO6LCmn0hI3U0Gj4IBjBpEHsBqkyG32oG7OM07i90czclrUn8ZHIPd7o0COMiw9vRPoQvv9Qjc4bhBMPPuVAfW-2Fp-2Fl68O2kkGS5yLflkFKEpdvr57J6B1ycB-2BZ93t-2Fb-2BrHkw-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8G5OiOArS4mvucljpKkZw44xl0QoIr8EpGQt1P0w1oafXCIZ8tHMljtYMd-2Fvesxn1V8hxDdwW85wJWMZSoNgAEHWwSeYpAfDcwI4c-2FwCOmfWTElzRdAYV-2FwKXoRzvooUS1exKyuJU-2FEzJqVabH9jj4h26-2BepOn998l-2FejVNhKELgNj8j2nQHqQTsEd6D0fWZnc-3D

