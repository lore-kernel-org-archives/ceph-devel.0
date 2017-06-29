From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 29 Jun 2017 04:08:43 +0000 (UTC)
Message-ID: <59547d4b76c5b_374d9713149833@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:26312 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751228AbdF2EIp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Jun 2017 00:08:45 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1las1.sendgrid.net (SG) with ESMTP id _WVzytMNQ623Budq4sKspQ
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jun 2017 04:08:43.697 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

36 new defect(s) introduced to ceph found with Coverity Scan.
32 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 36 defect(s)


** CID 1405850:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/dmclock/src/dmclock_server.h: 326 in crimson::dmclock::PriorityQueueBase<ceph::mClockOpClassQueue::osd_op_type_t, std::pair<spg_t, PGQueueable>, (unsigned int)2>::ClientRec::ClientRec(ceph::mClockOpClassQueue::osd_op_type_t, const crimson::dmclock::ClientInfo &, unsigned long)()
/home/brad/working/src/ceph/src/dmclock/src/dmclock_server.h: 326 in crimson::dmclock::PriorityQueueBase<std::pair<entity_inst_t, ceph::mClockClientQueue::osd_op_type_t>, std::pair<spg_t, PGQueueable>, (unsigned int)2>::ClientRec::ClientRec(std::pair<entity_inst_t, ceph::mClockClientQueue::osd_op_type_t>, const crimson::dmclock::ClientInfo &, unsigned long)()


________________________________________________________________________________________________________
*** CID 1405850:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/dmclock/src/dmclock_server.h: 326 in crimson::dmclock::PriorityQueueBase<ceph::mClockOpClassQueue::osd_op_type_t, std::pair<spg_t, PGQueueable>, (unsigned int)2>::ClientRec::ClientRec(ceph::mClockOpClassQueue::osd_op_type_t, const crimson::dmclock::ClientInfo &, unsigned long)()
320     	  idle(true),
321     	  last_tick(current_tick),
322     	  cur_rho(1),
323     	  cur_delta(1)
324     	{
325     	  // empty
>>>     CID 1405850:    (UNINIT_CTOR)
>>>     Non-static class member "ready_heap_data" is not initialized in this constructor nor in any functions that it calls.
326     	}
327     
328     	inline const RequestTag& get_req_tag() const {
329     	  return prev_tag;
330     	}
331     
/home/brad/working/src/ceph/src/dmclock/src/dmclock_server.h: 326 in crimson::dmclock::PriorityQueueBase<std::pair<entity_inst_t, ceph::mClockClientQueue::osd_op_type_t>, std::pair<spg_t, PGQueueable>, (unsigned int)2>::ClientRec::ClientRec(std::pair<entity_inst_t, ceph::mClockClientQueue::osd_op_type_t>, const crimson::dmclock::ClientInfo &, unsigned long)()
320     	  idle(true),
321     	  last_tick(current_tick),
322     	  cur_rho(1),
323     	  cur_delta(1)
324     	{
325     	  // empty
>>>     CID 1405850:    (UNINIT_CTOR)
>>>     Non-static class member "ready_heap_data" is not initialized in this constructor nor in any functions that it calls.
326     	}
327     
328     	inline const RequestTag& get_req_tag() const {
329     	  return prev_tag;
330     	}
331     

** CID 1413773:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/OpenRequest.cc: 341 in librbd::image::OpenRequest<librbd::ImageCtx>::send_v2_get_create_timestamp()()


________________________________________________________________________________________________________
*** CID 1413773:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/OpenRequest.cc: 341 in librbd::image::OpenRequest<librbd::ImageCtx>::send_v2_get_create_timestamp()()
335       cls_client::get_create_timestamp_start(&op);
336     
337       using klass = OpenRequest<I>;
338       librados::AioCompletion *comp = create_rados_callback<
339         klass, &klass::handle_v2_get_create_timestamp>(this);
340       m_out_bl.clear();
>>>     CID 1413773:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "aio_operate" without checking return value (as is done elsewhere 60 out of 74 times).
341       m_image_ctx->md_ctx.aio_operate(m_image_ctx->header_oid, comp, &op,
342                                       &m_out_bl);
343       comp->release();
344     }
345     
346     template <typename I>

** CID 1413774:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotCreateRequest.cc: 35 in librbd::operation::SnapshotCreateRequest<librbd::MockImageCtx>::SnapshotCreateRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, bool)()
/home/brad/working/src/ceph/src/librbd/operation/SnapshotCreateRequest.cc: 35 in librbd::operation::SnapshotCreateRequest<librbd::ImageCtx>::SnapshotCreateRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, bool)()


________________________________________________________________________________________________________
*** CID 1413774:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotCreateRequest.cc: 35 in librbd::operation::SnapshotCreateRequest<librbd::MockImageCtx>::SnapshotCreateRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, bool)()
29                                                     const std::string &snap_name,
30                                                     uint64_t journal_op_tid,
31                                                     bool skip_object_map)
32       : Request<I>(image_ctx, on_finish, journal_op_tid),
33         m_snap_namespace(snap_namespace), m_snap_name(snap_name),
34         m_skip_object_map(skip_object_map), m_ret_val(0), m_snap_id(CEPH_NOSNAP) {
>>>     CID 1413774:    (UNINIT_CTOR)
>>>     Non-static class member "m_size" is not initialized in this constructor nor in any functions that it calls.
35     }
36     
37     template <typename I>
38     void SnapshotCreateRequest<I>::send_op() {
39       send_suspend_requests();
40     }
/home/brad/working/src/ceph/src/librbd/operation/SnapshotCreateRequest.cc: 35 in librbd::operation::SnapshotCreateRequest<librbd::ImageCtx>::SnapshotCreateRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, bool)()
29                                                     const std::string &snap_name,
30                                                     uint64_t journal_op_tid,
31                                                     bool skip_object_map)
32       : Request<I>(image_ctx, on_finish, journal_op_tid),
33         m_snap_namespace(snap_namespace), m_snap_name(snap_name),
34         m_skip_object_map(skip_object_map), m_ret_val(0), m_snap_id(CEPH_NOSNAP) {
>>>     CID 1413774:    (UNINIT_CTOR)
>>>     Non-static class member "m_size" is not initialized in this constructor nor in any functions that it calls.
35     }
36     
37     template <typename I>
38     void SnapshotCreateRequest<I>::send_op() {
39       send_suspend_requests();
40     }

** CID 1413775:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25903 in __pyx_pw_3rbd_5Image_103lock_break()


________________________________________________________________________________________________________
*** CID 1413775:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25903 in __pyx_pw_3rbd_5Image_103lock_break()
25897           }
25898           kw_args = PyDict_Size(__pyx_kwds);
25899           switch (pos_args) {
25900             case  0:
25901             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_lock_mode)) != 0)) kw_args--;
25902             else goto __pyx_L5_argtuple_error;
>>>     CID 1413775:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
25903             case  1:
25904             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_lock_owner)) != 0)) kw_args--;
25905             else {
25906               __Pyx_RaiseArgtupleInvalid("lock_break", 1, 2, 2, 1); __PYX_ERR(0, 2318, __pyx_L3_error)
25907             }
25908           }

** CID 1413776:  Control flow issues  (UNREACHABLE)
/src/pybind/rbd/rbd.c: 24761 in __pyx_pf_3rbd_5Image_92list_children()


________________________________________________________________________________________________________
*** CID 1413776:  Control flow issues  (UNREACHABLE)
/src/pybind/rbd/rbd.c: 24761 in __pyx_pf_3rbd_5Image_92list_children()
24755      *             return list(zip(pools, images))
24756      *         finally:
24757      *             free(c_pools)             # <<<<<<<<<<<<<<
24758      *             free(c_images)
24759      * 
24760      */
>>>     CID 1413776:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    PyThreadState *__...".
24761       /*finally:*/ {
24762         /*exception exit:*/{
24763           __Pyx_PyThreadState_declare
24764           __pyx_L4_error:;
24765           __pyx_t_9 = 0; __pyx_t_10 = 0; __pyx_t_11 = 0; __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0;
24766           __Pyx_PyThreadState_assign

** CID 1413777:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotProtectRequest.cc: 37 in librbd::operation::SnapshotProtectRequest<librbd::MockImageCtx>::SnapshotProtectRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
/home/brad/working/src/ceph/src/librbd/operation/SnapshotProtectRequest.cc: 37 in librbd::operation::SnapshotProtectRequest<librbd::ImageCtx>::SnapshotProtectRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()


________________________________________________________________________________________________________
*** CID 1413777:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotProtectRequest.cc: 37 in librbd::operation::SnapshotProtectRequest<librbd::MockImageCtx>::SnapshotProtectRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
31     template <typename I>
32     SnapshotProtectRequest<I>::SnapshotProtectRequest(I &image_ctx,
33                                                       Context *on_finish,
34     						  const cls::rbd::SnapshotNamespace &snap_namespace,
35     						  const std::string &snap_name)
36       : Request<I>(image_ctx, on_finish), m_snap_namespace(snap_namespace), m_snap_name(snap_name) {
>>>     CID 1413777:    (UNINIT_CTOR)
>>>     Non-static class member "m_state" is not initialized in this constructor nor in any functions that it calls.
37     }
38     
39     template <typename I>
40     void SnapshotProtectRequest<I>::send_op() {
41       send_protect_snap();
42     }
/home/brad/working/src/ceph/src/librbd/operation/SnapshotProtectRequest.cc: 37 in librbd::operation::SnapshotProtectRequest<librbd::ImageCtx>::SnapshotProtectRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
31     template <typename I>
32     SnapshotProtectRequest<I>::SnapshotProtectRequest(I &image_ctx,
33                                                       Context *on_finish,
34     						  const cls::rbd::SnapshotNamespace &snap_namespace,
35     						  const std::string &snap_name)
36       : Request<I>(image_ctx, on_finish), m_snap_namespace(snap_namespace), m_snap_name(snap_name) {
>>>     CID 1413777:    (UNINIT_CTOR)
>>>     Non-static class member "m_state" is not initialized in this constructor nor in any functions that it calls.
37     }
38     
39     template <typename I>
40     void SnapshotProtectRequest<I>::send_op() {
41       send_protect_snap();
42     }

** CID 1413778:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 26372 in __pyx_pw_3rbd_5Image_107lock_shared()


________________________________________________________________________________________________________
*** CID 1413778:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 26372 in __pyx_pw_3rbd_5Image_107lock_shared()
26366           }
26367           kw_args = PyDict_Size(__pyx_kwds);
26368           switch (pos_args) {
26369             case  0:
26370             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cookie)) != 0)) kw_args--;
26371             else goto __pyx_L5_argtuple_error;
>>>     CID 1413778:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
26372             case  1:
26373             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_tag)) != 0)) kw_args--;
26374             else {
26375               __Pyx_RaiseArgtupleInvalid("lock_shared", 1, 2, 2, 1); __PYX_ERR(0, 2348, __pyx_L3_error)
26376             }
26377           }

** CID 1413779:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 29536 in __pyx_pw_3rbd_5Image_129aio_write()


________________________________________________________________________________________________________
*** CID 1413779:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 29536 in __pyx_pw_3rbd_5Image_129aio_write()
29530           }
29531           kw_args = PyDict_Size(__pyx_kwds);
29532           switch (pos_args) {
29533             case  0:
29534             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_data)) != 0)) kw_args--;
29535             else goto __pyx_L5_argtuple_error;
>>>     CID 1413779:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
29536             case  1:
29537             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
29538             else {
29539               __Pyx_RaiseArgtupleInvalid("aio_write", 0, 3, 4, 1); __PYX_ERR(0, 2571, __pyx_L3_error)
29540             }
29541             case  2:

** CID 1413780:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/osd/TestMClockClientQueue.cc: 12 in main()


________________________________________________________________________________________________________
*** CID 1413780:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/osd/TestMClockClientQueue.cc: 12 in main()
6     #include "global/global_init.h"
7     #include "common/common_init.h"
8     
9     #include "osd/mClockClientQueue.h"
10     
11     
>>>     CID 1413780:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::<unnamed>::ClassUniqueToAlwaysTrue" is thrown and never caught.
12     int main(int argc, char **argv) {
13       std::vector<const char*> args(argv, argv+argc);
14       auto cct = global_init(nullptr, args, CEPH_ENTITY_TYPE_OSD,
15     			 CODE_ENVIRONMENT_UTILITY,
16     			 CINIT_FLAG_NO_DEFAULT_CONFIG_FILE);
17       common_init_finish(g_ceph_context);

** CID 1413781:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/osd/TestMClockOpClassQueue.cc: 14 in main()


________________________________________________________________________________________________________
*** CID 1413781:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/osd/TestMClockOpClassQueue.cc: 14 in main()
8     #include "global/global_init.h"
9     #include "common/common_init.h"
10     
11     #include "osd/mClockOpClassQueue.h"
12     
13     
>>>     CID 1413781:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
14     int main(int argc, char **argv) {
15       std::vector<const char*> args(argv, argv+argc);
16       auto cct = global_init(nullptr, args, CEPH_ENTITY_TYPE_OSD,
17     			 CODE_ENVIRONMENT_UTILITY,
18     			 CINIT_FLAG_NO_DEFAULT_CONFIG_FILE);
19       common_init_finish(g_ceph_context);

** CID 1413782:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/osd/TestMClockClientQueue.cc: 12 in main()


________________________________________________________________________________________________________
*** CID 1413782:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/osd/TestMClockClientQueue.cc: 12 in main()
6     #include "global/global_init.h"
7     #include "common/common_init.h"
8     
9     #include "osd/mClockClientQueue.h"
10     
11     
>>>     CID 1413782:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::GoogleTestFailureException" is thrown and never caught.
12     int main(int argc, char **argv) {
13       std::vector<const char*> args(argv, argv+argc);
14       auto cct = global_init(nullptr, args, CEPH_ENTITY_TYPE_OSD,
15     			 CODE_ENVIRONMENT_UTILITY,
16     			 CINIT_FLAG_NO_DEFAULT_CONFIG_FILE);
17       common_init_finish(g_ceph_context);

** CID 1413783:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/rgw/rgw_rest.cc: 1919 in RGWHandler_REST::read_permissions(RGWOp *)()


________________________________________________________________________________________________________
*** CID 1413783:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/rgw/rgw_rest.cc: 1919 in RGWHandler_REST::read_permissions(RGWOp *)()
1913     
1914       return do_init_permissions();
1915     }
1916     
1917     int RGWHandler_REST::read_permissions(RGWOp* op_obj)
1918     {
>>>     CID 1413783:  Uninitialized variables  (UNINIT)
>>>     Declaring variable "only_bucket" without initializer.
1919       bool only_bucket;
1920     
1921       switch (s->op) {
1922       case OP_HEAD:
1923       case OP_GET:
1924         only_bucket = false;

** CID 1413784:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/osd/TestMClockOpClassQueue.cc: 14 in main()


________________________________________________________________________________________________________
*** CID 1413784:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/osd/TestMClockOpClassQueue.cc: 14 in main()
8     #include "global/global_init.h"
9     #include "common/common_init.h"
10     
11     #include "osd/mClockOpClassQueue.h"
12     
13     
>>>     CID 1413784:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::<unnamed>::ClassUniqueToAlwaysTrue" is thrown and never caught.
14     int main(int argc, char **argv) {
15       std::vector<const char*> args(argv, argv+argc);
16       auto cct = global_init(nullptr, args, CEPH_ENTITY_TYPE_OSD,
17     			 CODE_ENVIRONMENT_UTILITY,
18     			 CINIT_FLAG_NO_DEFAULT_CONFIG_FILE);
19       common_init_finish(g_ceph_context);

** CID 1413785:  Control flow issues  (UNREACHABLE)
/src/pybind/rbd/rbd.c: 25390 in __pyx_pf_3rbd_5Image_94list_lockers()


________________________________________________________________________________________________________
*** CID 1413785:  Control flow issues  (UNREACHABLE)
/src/pybind/rbd/rbd.c: 25390 in __pyx_pf_3rbd_5Image_94list_lockers()
25384      *                 }
25385      *         finally:
25386      *             free(c_clients)             # <<<<<<<<<<<<<<
25387      *             free(c_cookies)
25388      *             free(c_addrs)
25389      */
>>>     CID 1413785:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    PyThreadState *__...".
25390       /*finally:*/ {
25391         /*exception exit:*/{
25392           __Pyx_PyThreadState_declare
25393           __pyx_L4_error:;
25394           __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0;
25395           __Pyx_PyThreadState_assign

** CID 1413786:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 28809 in __pyx_pw_3rbd_5Image_127aio_read()


________________________________________________________________________________________________________
*** CID 1413786:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 28809 in __pyx_pw_3rbd_5Image_127aio_read()
28803           }
28804           kw_args = PyDict_Size(__pyx_kwds);
28805           switch (pos_args) {
28806             case  0:
28807             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
28808             else goto __pyx_L5_argtuple_error;
>>>     CID 1413786:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
28809             case  1:
28810             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
28811             else {
28812               __Pyx_RaiseArgtupleInvalid("aio_read", 0, 3, 4, 1); __PYX_ERR(0, 2516, __pyx_L3_error)
28813             }
28814             case  2:

** CID 1413787:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1413787:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/rgw/rgw_tag.h: 20 in RGWObjTags::encode(ceph::buffer::list &) const()
14       tag_map_t tag_map;
15      public:
16       RGWObjTags() {}
17       ~RGWObjTags() {}
18     
19       void encode(bufferlist& bl) const {
>>>     CID 1413787:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
20         ENCODE_START(1,1,bl);
21         ::encode(tag_map, bl);
22         ENCODE_FINISH(bl);
23       }
24     
25       void decode(bufferlist::iterator &bl) {

** CID 1413788:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 26899 in __pyx_pw_3rbd_5Image_111break_lock()


________________________________________________________________________________________________________
*** CID 1413788:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 26899 in __pyx_pw_3rbd_5Image_111break_lock()
26893           }
26894           kw_args = PyDict_Size(__pyx_kwds);
26895           switch (pos_args) {
26896             case  0:
26897             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_client)) != 0)) kw_args--;
26898             else goto __pyx_L5_argtuple_error;
>>>     CID 1413788:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
26899             case  1:
26900             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cookie)) != 0)) kw_args--;
26901             else {
26902               __Pyx_RaiseArgtupleInvalid("break_lock", 1, 2, 2, 1); __PYX_ERR(0, 2377, __pyx_L3_error)
26903             }
26904           }

** CID 1413789:  Null pointer dereferences  (NULL_RETURNS)
/home/brad/working/src/ceph/src/rgw/rgw_rest_s3.cc: 412 in RGWPutObjTags_ObjStore_S3::get_params()()


________________________________________________________________________________________________________
*** CID 1413789:  Null pointer dereferences  (NULL_RETURNS)
/home/brad/working/src/ceph/src/rgw/rgw_rest_s3.cc: 412 in RGWPutObjTags_ObjStore_S3::get_params()()
406         return -ERR_MALFORMED_XML;
407       }
408     
409       RGWObjTagSet_S3 *obj_tags_s3;
410       RGWObjTagging_S3 *tagging;
411     
>>>     CID 1413789:  Null pointer dereferences  (NULL_RETURNS)
>>>     Assigning: "tagging" = null return value from "find_first".
412       tagging = static_cast<RGWObjTagging_S3 *>(parser.find_first("Tagging"));
413       obj_tags_s3 = static_cast<RGWObjTagSet_S3 *>(tagging->find_first("TagSet"));
414       if(!obj_tags_s3){
415         return -ERR_MALFORMED_XML;
416       }
417     

** CID 1413790:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotRemoveRequest.cc: 56 in librbd::operation::SnapshotRemoveRequest<librbd::MockImageCtx>::SnapshotRemoveRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long)()
/home/brad/working/src/ceph/src/librbd/operation/SnapshotRemoveRequest.cc: 56 in librbd::operation::SnapshotRemoveRequest<librbd::ImageCtx>::SnapshotRemoveRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long)()


________________________________________________________________________________________________________
*** CID 1413790:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotRemoveRequest.cc: 56 in librbd::operation::SnapshotRemoveRequest<librbd::MockImageCtx>::SnapshotRemoveRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long)()
50     						Context *on_finish,
51     						const cls::rbd::SnapshotNamespace &snap_namespace,
52     						const std::string &snap_name,
53     						uint64_t snap_id)
54       : Request<I>(image_ctx, on_finish), m_snap_namespace(snap_namespace),
55         m_snap_name(snap_name), m_snap_id(snap_id) {
>>>     CID 1413790:    (UNINIT_CTOR)
>>>     Non-static class member "m_state" is not initialized in this constructor nor in any functions that it calls.
56     }
57     
58     template <typename I>
59     void SnapshotRemoveRequest<I>::send_op() {
60       send_remove_object_map();
61     }
/home/brad/working/src/ceph/src/librbd/operation/SnapshotRemoveRequest.cc: 56 in librbd::operation::SnapshotRemoveRequest<librbd::ImageCtx>::SnapshotRemoveRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long)()
50     						Context *on_finish,
51     						const cls::rbd::SnapshotNamespace &snap_namespace,
52     						const std::string &snap_name,
53     						uint64_t snap_id)
54       : Request<I>(image_ctx, on_finish), m_snap_namespace(snap_namespace),
55         m_snap_name(snap_name), m_snap_id(snap_id) {
>>>     CID 1413790:    (UNINIT_CTOR)
>>>     Non-static class member "m_state" is not initialized in this constructor nor in any functions that it calls.
56     }
57     
58     template <typename I>
59     void SnapshotRemoveRequest<I>::send_op() {
60       send_remove_object_map();
61     }

** CID 1413791:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/osd/TestMClockOpClassQueue.cc: 14 in main()


________________________________________________________________________________________________________
*** CID 1413791:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/osd/TestMClockOpClassQueue.cc: 14 in main()
8     #include "global/global_init.h"
9     #include "common/common_init.h"
10     
11     #include "osd/mClockOpClassQueue.h"
12     
13     
>>>     CID 1413791:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::GoogleTestFailureException" is thrown and never caught.
14     int main(int argc, char **argv) {
15       std::vector<const char*> args(argv, argv+argc);
16       auto cct = global_init(nullptr, args, CEPH_ENTITY_TYPE_OSD,
17     			 CODE_ENVIRONMENT_UTILITY,
18     			 CINIT_FLAG_NO_DEFAULT_CONFIG_FILE);
19       common_init_finish(g_ceph_context);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Gdqru02AOJ8xFvhzofrXAMglLToQRHpHQEwgExCFzb-2B1ClWkE-2Bn4aJWgCBAl9eoeUftZbl8RCB2v1Vbmv-2B6i3AD2dWFDhxV7AtWubB4M4GLIGr-2Frg1ZzN96h8xcGayZStALek50fv3LirI6c518Frh3C0VQtXwk-2BBTwlsnslzwMRUFIBiOqozMAuwMx7cuku8-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Gdqru02AOJ8xFvhzofrXAMglLToQRHpHQEwgExCFzb-2B-2FMVWtXCLEedYlBcxvZTdI2rGJjc8W2865NXIGmpml4C61KOLjLmpqsoWcZ5JepreLO-2BsYPiQZILRabMc219jD1dvfOu7ykn53DUxFjcXmLGb-2BTlOFNGJRKYWDhPwB7dSy4Pa3J-2BY9l6AWmpVep1OIc-3D

