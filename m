From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 20 Jul 2017 04:08:00 +0000 (UTC)
Message-ID: <59702ca04638c_76553e7330107ba@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:36513 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754039AbdGTEIB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 20 Jul 2017 00:08:01 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0001p1sjc2.sendgrid.net (SG) with ESMTP id ANEpwcVMQMCTedg2LACWpg
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jul 2017 04:08:00.328 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

17 new defect(s) introduced to ceph found with Coverity Scan.
16 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 17 of 17 defect(s)


** CID 1415542:  Control flow issues  (UNREACHABLE)
/src/pybind/rados/rados.c: 49347 in __pyx_pf_5rados_5Ioctx_126application_metadata_list()


________________________________________________________________________________________________________
*** CID 1415542:  Control flow issues  (UNREACHABLE)
/src/pybind/rados/rados.c: 49347 in __pyx_pf_5rados_5Ioctx_126application_metadata_list()
49341      * 
49342      * 
49343      */
49344           free(__pyx_v_c_vals);
49345           goto __pyx_L5;
49346         }
>>>     CID 1415542:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  PyThreadState *__pyx_ts...".
49347         /*exception exit:*/{
49348           __Pyx_PyThreadState_declare
49349           __pyx_L4_error:;
49350           __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0; __pyx_t_18 = 0; __pyx_t_19 = 0; __pyx_t_20 = 0;
49351           __Pyx_PyThreadState_assign
49352           __Pyx_XDECREF(__pyx_t_12); __pyx_t_12 = 0;

** CID 1415543:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/messages/MOSDPGRecoveryDeleteReply.h: 30 in MOSDPGRecoveryDeleteReply::MOSDPGRecoveryDeleteReply()()


________________________________________________________________________________________________________
*** CID 1415543:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/messages/MOSDPGRecoveryDeleteReply.h: 30 in MOSDPGRecoveryDeleteReply::MOSDPGRecoveryDeleteReply()()
24       spg_t get_spg() const override {
25         return pgid;
26       }
27     
28       MOSDPGRecoveryDeleteReply()
29         : MOSDFastDispatchOp(MSG_OSD_PG_RECOVERY_DELETE_REPLY, HEAD_VERSION, COMPAT_VERSION)
>>>     CID 1415543:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "min_epoch" is not initialized in this constructor nor in any functions that it calls.
30         {}
31     
32       void decode_payload() override {
33         bufferlist::iterator p = payload.begin();
34         ::decode(pgid.pgid, p);
35         ::decode(map_epoch, p);

** CID 1415544:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 48431 in __pyx_pw_5rados_5Ioctx_125application_metadata_remove()


________________________________________________________________________________________________________
*** CID 1415544:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 48431 in __pyx_pw_5rados_5Ioctx_125application_metadata_remove()
48425           }
48426           kw_args = PyDict_Size(__pyx_kwds);
48427           switch (pos_args) {
48428             case  0:
48429             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_app_name)) != 0)) kw_args--;
48430             else goto __pyx_L5_argtuple_error;
>>>     CID 1415544:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
48431             case  1:
48432             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_key)) != 0)) kw_args--;
48433             else {
48434               __Pyx_RaiseArgtupleInvalid("application_metadata_remove", 1, 2, 2, 1); __PYX_ERR(0, 3654, __pyx_L3_error)
48435             }
48436           }

** CID 1415545:    (OVERRUN)
/home/brad/working/src/ceph/src/test/librados/misc.cc: 1272 in LibRadosMisc_Applications_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/misc.cc: 1262 in LibRadosMisc_Applications_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/misc.cc: 1301 in LibRadosMisc_Applications_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/misc.cc: 1309 in LibRadosMisc_Applications_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/misc.cc: 1302 in LibRadosMisc_Applications_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/misc.cc: 1310 in LibRadosMisc_Applications_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1415545:    (OVERRUN)
/home/brad/working/src/ceph/src/test/librados/misc.cc: 1272 in LibRadosMisc_Applications_Test::TestBody()()
1266       ASSERT_EQ(0, rados_application_enable(ioctx, "app2", 1));
1267     
1268       ASSERT_EQ(-ERANGE, rados_application_list(ioctx, apps, &app_len));
1269       ASSERT_EQ(16U, app_len);
1270       ASSERT_EQ(0, rados_application_list(ioctx, apps, &app_len));
1271       ASSERT_EQ(16U, app_len);
>>>     CID 1415545:    (OVERRUN)
>>>     Overrunning array ""app1\0app2\0rados"" of 17 bytes by passing it to a function which accesses it at byte offset 127 using argument "app_len" (which evaluates to 128).
1272       ASSERT_EQ(0, memcmp("app1\0app2\0rados\0", apps, app_len));
1273     
1274       char keys[128];
1275       char vals[128];
1276       size_t key_len;
1277       size_t val_len;
/home/brad/working/src/ceph/src/test/librados/misc.cc: 1262 in LibRadosMisc_Applications_Test::TestBody()()
1256       char apps[128];
1257       size_t app_len;
1258     
1259       app_len = sizeof(apps);
1260       ASSERT_EQ(0, rados_application_list(ioctx, apps, &app_len));
1261       ASSERT_EQ(6U, app_len);
>>>     CID 1415545:    (OVERRUN)
>>>     Overrunning array ""rados"" of 7 bytes by passing it to a function which accesses it at byte offset 127 using argument "app_len" (which evaluates to 128).
1262       ASSERT_EQ(0, memcmp("rados\0", apps, app_len));
1263     
1264       ASSERT_EQ(0, rados_application_enable(ioctx, "app1", 1));
1265       ASSERT_EQ(-EPERM, rados_application_enable(ioctx, "app2", 0));
1266       ASSERT_EQ(0, rados_application_enable(ioctx, "app2", 1));
1267     
/home/brad/working/src/ceph/src/test/librados/misc.cc: 1301 in LibRadosMisc_Applications_Test::TestBody()()
1295       ASSERT_EQ(10U, key_len);
1296       ASSERT_EQ(14U, val_len);
1297       ASSERT_EQ(0, rados_application_metadata_list(ioctx, "app1", keys, &key_len,
1298                                                    vals, &val_len));
1299       ASSERT_EQ(10U, key_len);
1300       ASSERT_EQ(14U, val_len);
>>>     CID 1415545:    (OVERRUN)
>>>     Overrunning array ""key1\0key2"" of 11 bytes by passing it to a function which accesses it at byte offset 127 using argument "key_len" (which evaluates to 128).
1301       ASSERT_EQ(0, memcmp("key1\0key2\0", keys, key_len));
1302       ASSERT_EQ(0, memcmp("value1\0value2\0", vals, val_len));
1303     
1304       ASSERT_EQ(0, rados_application_metadata_remove(ioctx, "app1", "key1"));
1305       ASSERT_EQ(0, rados_application_metadata_list(ioctx, "app1", keys, &key_len,
1306                                                    vals, &val_len));
/home/brad/working/src/ceph/src/test/librados/misc.cc: 1309 in LibRadosMisc_Applications_Test::TestBody()()
1303     
1304       ASSERT_EQ(0, rados_application_metadata_remove(ioctx, "app1", "key1"));
1305       ASSERT_EQ(0, rados_application_metadata_list(ioctx, "app1", keys, &key_len,
1306                                                    vals, &val_len));
1307       ASSERT_EQ(5U, key_len);
1308       ASSERT_EQ(7U, val_len);
>>>     CID 1415545:    (OVERRUN)
>>>     Overrunning array ""key2"" of 6 bytes by passing it to a function which accesses it at byte offset 127 using argument "key_len" (which evaluates to 128).
1309       ASSERT_EQ(0, memcmp("key2\0", keys, key_len));
1310       ASSERT_EQ(0, memcmp("value2\0", vals, val_len));
1311     }
1312     
1313     TEST_F(LibRadosMiscPP, Applications) {
1314       bufferlist inbl, outbl;
/home/brad/working/src/ceph/src/test/librados/misc.cc: 1302 in LibRadosMisc_Applications_Test::TestBody()()
1296       ASSERT_EQ(14U, val_len);
1297       ASSERT_EQ(0, rados_application_metadata_list(ioctx, "app1", keys, &key_len,
1298                                                    vals, &val_len));
1299       ASSERT_EQ(10U, key_len);
1300       ASSERT_EQ(14U, val_len);
1301       ASSERT_EQ(0, memcmp("key1\0key2\0", keys, key_len));
>>>     CID 1415545:    (OVERRUN)
>>>     Overrunning array ""value1\0value2"" of 15 bytes by passing it to a function which accesses it at byte offset 127 using argument "val_len" (which evaluates to 128).
1302       ASSERT_EQ(0, memcmp("value1\0value2\0", vals, val_len));
1303     
1304       ASSERT_EQ(0, rados_application_metadata_remove(ioctx, "app1", "key1"));
1305       ASSERT_EQ(0, rados_application_metadata_list(ioctx, "app1", keys, &key_len,
1306                                                    vals, &val_len));
1307       ASSERT_EQ(5U, key_len);
/home/brad/working/src/ceph/src/test/librados/misc.cc: 1310 in LibRadosMisc_Applications_Test::TestBody()()
1304       ASSERT_EQ(0, rados_application_metadata_remove(ioctx, "app1", "key1"));
1305       ASSERT_EQ(0, rados_application_metadata_list(ioctx, "app1", keys, &key_len,
1306                                                    vals, &val_len));
1307       ASSERT_EQ(5U, key_len);
1308       ASSERT_EQ(7U, val_len);
1309       ASSERT_EQ(0, memcmp("key2\0", keys, key_len));
>>>     CID 1415545:    (OVERRUN)
>>>     Overrunning array ""value2"" of 8 bytes by passing it to a function which accesses it at byte offset 127 using argument "val_len" (which evaluates to 128).
1310       ASSERT_EQ(0, memcmp("value2\0", vals, val_len));
1311     }
1312     
1313     TEST_F(LibRadosMiscPP, Applications) {
1314       bufferlist inbl, outbl;
1315       string outs;

** CID 1415546:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 917 in boost::function1<void, int>::assign_to<PrimaryLogPG::remove_missing_object(const hobject_t &, eversion_t, Context *)::[lambda(int) (instance 1)]>(T1)()


________________________________________________________________________________________________________
*** CID 1415546:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 917 in boost::function1<void, int>::assign_to<PrimaryLogPG::remove_missing_object(const hobject_t &, eversion_t, Context *)::[lambda(int) (instance 1)]>(T1)()
911               get_vtable()->base.manager(f.functor, this->functor,
912                                          boost::detail::function::clone_functor_tag);
913           }
914         }
915     
916         template<typename Functor>
>>>     CID 1415546:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "PrimaryLogPG::remove_missing_object(hobject_t const &, eversion_t, Context *)::[lambda(int) (instance 1)]" (size 1104 bytes) by value.
917         void assign_to(Functor f)
918         {
919           using boost::detail::function::vtable_base;
920     
921           typedef typename boost::detail::function::get_function_tag<Functor>::type tag;
922           typedef boost::detail::function::BOOST_FUNCTION_GET_INVOKER<tag> get_invoker;

** CID 1415547:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/messages/MOSDPGRecoveryDelete.h: 47 in MOSDPGRecoveryDelete::MOSDPGRecoveryDelete()()


________________________________________________________________________________________________________
*** CID 1415547:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/messages/MOSDPGRecoveryDelete.h: 47 in MOSDPGRecoveryDelete::MOSDPGRecoveryDelete()()
41       void set_cost(uint64_t c) {
42         cost = c;
43       }
44     
45       MOSDPGRecoveryDelete()
46         : MOSDFastDispatchOp(MSG_OSD_PG_RECOVERY_DELETE, HEAD_VERSION,
>>>     CID 1415547:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "cost" is not initialized in this constructor nor in any functions that it calls.
47     			COMPAT_VERSION) {}
48     
49       MOSDPGRecoveryDelete(pg_shard_t from, spg_t pgid, epoch_t map_epoch,
50     		       epoch_t min_epoch)
51         : MOSDFastDispatchOp(MSG_OSD_PG_RECOVERY_DELETE, HEAD_VERSION,
52     			 COMPAT_VERSION),

** CID 1415548:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 1065 in boost::function<void (int)>::function<PrimaryLogPG::remove_missing_object(const hobject_t &, eversion_t, Context *)::[lambda(int) (instance 1)]>(T1, boost::enable_if_c<(!(boost::is_integral<T1>::value)), int>::type)()


________________________________________________________________________________________________________
*** CID 1415548:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 1065 in boost::function<void (int)>::function<PrimaryLogPG::remove_missing_object(const hobject_t &, eversion_t, Context *)::[lambda(int) (instance 1)]>(T1, boost::enable_if_c<(!(boost::is_integral<T1>::value)), int>::type)()
1059     
1060     public:
1061     
1062       function() : base_type() {}
1063     
1064       template<typename Functor>
>>>     CID 1415548:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "PrimaryLogPG::remove_missing_object(hobject_t const &, eversion_t, Context *)::[lambda(int) (instance 1)]" (size 1104 bytes) by value.
1065       function(Functor f
1066     #ifndef BOOST_NO_SFINAE
1067                ,typename boost::enable_if_c<
1068                               !(is_integral<Functor>::value),
1069                            int>::type = 0
1070     #endif

** CID 1415549:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 48033 in __pyx_pw_5rados_5Ioctx_123application_metadata_set()


________________________________________________________________________________________________________
*** CID 1415549:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 48033 in __pyx_pw_5rados_5Ioctx_123application_metadata_set()
48027           }
48028           kw_args = PyDict_Size(__pyx_kwds);
48029           switch (pos_args) {
48030             case  0:
48031             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_app_name)) != 0)) kw_args--;
48032             else goto __pyx_L5_argtuple_error;
>>>     CID 1415549:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
48033             case  1:
48034             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_key)) != 0)) kw_args--;
48035             else {
48036               __Pyx_RaiseArgtupleInvalid("application_metadata_set", 1, 3, 3, 1); __PYX_ERR(0, 3627, __pyx_L3_error)
48037             }
48038             case  2:

** CID 1415550:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 605 in boost::detail::function::basic_vtable1<void, int>::assign_to<PrimaryLogPG::remove_missing_object(const hobject_t &, eversion_t, Context *)::[lambda(int) (instance 1)]>(T1, boost::detail::function::function_buffer &, boost::detail::function::function_obj_tag) const()


________________________________________________________________________________________________________
*** CID 1415550:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 605 in boost::detail::function::basic_vtable1<void, int>::assign_to<PrimaryLogPG::remove_missing_object(const hobject_t &, eversion_t, Context *)::[lambda(int) (instance 1)]>(T1, boost::detail::function::function_buffer &, boost::detail::function::function_obj_tag) const()
599               functor_wrapper_type* new_f = static_cast<functor_wrapper_type*>(copy);
600               functor.members.obj_ptr = new_f;
601             }
602     
603             template<typename FunctionObj>
604             bool
>>>     CID 1415550:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "PrimaryLogPG::remove_missing_object(hobject_t const &, eversion_t, Context *)::[lambda(int) (instance 1)]" (size 1104 bytes) by value.
605             assign_to(FunctionObj f, function_buffer& functor, function_obj_tag) const
606             {
607               if (!boost::detail::function::has_empty_target(boost::addressof(f))) {
608                 assign_functor(f, functor,
609                                mpl::bool_<(function_allows_small_object_optimization<FunctionObj>::value)>());
610                 return true;

** CID 1415551:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 48038 in __pyx_pw_5rados_5Ioctx_123application_metadata_set()


________________________________________________________________________________________________________
*** CID 1415551:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 48038 in __pyx_pw_5rados_5Ioctx_123application_metadata_set()
48032             else goto __pyx_L5_argtuple_error;
48033             case  1:
48034             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_key)) != 0)) kw_args--;
48035             else {
48036               __Pyx_RaiseArgtupleInvalid("application_metadata_set", 1, 3, 3, 1); __PYX_ERR(0, 3627, __pyx_L3_error)
48037             }
>>>     CID 1415551:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
48038             case  2:
48039             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_value)) != 0)) kw_args--;
48040             else {
48041               __Pyx_RaiseArgtupleInvalid("application_metadata_set", 1, 3, 3, 2); __PYX_ERR(0, 3627, __pyx_L3_error)
48042             }
48043           }

** CID 1415552:  Control flow issues  (UNREACHABLE)
/src/pybind/rados/rados.c: 47921 in __pyx_pf_5rados_5Ioctx_120application_list()


________________________________________________________________________________________________________
*** CID 1415552:  Control flow issues  (UNREACHABLE)
/src/pybind/rados/rados.c: 47921 in __pyx_pf_5rados_5Ioctx_120application_list()
47915      */
47916       /*finally:*/ {
47917         /*normal exit:*/{
47918           free(__pyx_v_apps);
47919           goto __pyx_L5;
47920         }
>>>     CID 1415552:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  PyThreadState *__pyx_ts...".
47921         /*exception exit:*/{
47922           __Pyx_PyThreadState_declare
47923           __pyx_L4_error:;
47924           __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0; __pyx_t_18 = 0; __pyx_t_19 = 0;
47925           __Pyx_PyThreadState_assign
47926           __Pyx_XDECREF(__pyx_t_9); __pyx_t_9 = 0;

** CID 1415553:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/messages/MOSDPGRecoveryDelete.h: 56 in MOSDPGRecoveryDelete::MOSDPGRecoveryDelete(pg_shard_t, spg_t, unsigned int, unsigned int)()


________________________________________________________________________________________________________
*** CID 1415553:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/messages/MOSDPGRecoveryDelete.h: 56 in MOSDPGRecoveryDelete::MOSDPGRecoveryDelete(pg_shard_t, spg_t, unsigned int, unsigned int)()
50     		       epoch_t min_epoch)
51         : MOSDFastDispatchOp(MSG_OSD_PG_RECOVERY_DELETE, HEAD_VERSION,
52     			 COMPAT_VERSION),
53           from(from),
54           pgid(pgid),
55           map_epoch(map_epoch),
>>>     CID 1415553:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "cost" is not initialized in this constructor nor in any functions that it calls.
56           min_epoch(min_epoch) {}
57     
58     private:
59       ~MOSDPGRecoveryDelete() {}
60     
61     public:

** CID 1415554:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1330 in CrushWrapper::_alloc_class_id() const()


________________________________________________________________________________________________________
*** CID 1415554:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1330 in CrushWrapper::_alloc_class_id() const()
1324       if (class_id >= 0) {
1325         return class_id;
1326       }
1327       // wrapped, pick a random start and do exhaustive search
1328       uint32_t upperlimit = numeric_limits<int32_t>::max();
1329       upperlimit++;
>>>     CID 1415554:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
1330       class_id = rand() % upperlimit;
1331       const auto start = class_id;
1332       do {
1333         if (!class_name.count(class_id)) {
1334           return class_id;
1335         } else {

** CID 1415555:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 495 in boost::detail::function::basic_vtable1<void, int>::assign_to<PrimaryLogPG::remove_missing_object(const hobject_t &, eversion_t, Context *)::[lambda(int) (instance 1)]>(T1, boost::detail::function::function_buffer &) const()


________________________________________________________________________________________________________
*** CID 1415555:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 495 in boost::detail::function::basic_vtable1<void, int>::assign_to<PrimaryLogPG::remove_missing_object(const hobject_t &, eversion_t, Context *)::[lambda(int) (instance 1)]>(T1, boost::detail::function::function_buffer &) const()
489     
490             typedef result_type (*invoker_type)(function_buffer&
491                                                 BOOST_FUNCTION_COMMA
492                                                 BOOST_FUNCTION_TEMPLATE_ARGS);
493     
494             template<typename F>
>>>     CID 1415555:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "PrimaryLogPG::remove_missing_object(hobject_t const &, eversion_t, Context *)::[lambda(int) (instance 1)]" (size 1104 bytes) by value.
495             bool assign_to(F f, function_buffer& functor) const
496             {
497               typedef typename get_function_tag<F>::type tag;
498               return assign_to(f, functor, tag());
499             }
500             template<typename F,typename Allocator>

** CID 1415556:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 718 in boost::function1<void, int>::function1<PrimaryLogPG::remove_missing_object(const hobject_t &, eversion_t, Context *)::[lambda(int) (instance 1)]>(T1, boost::enable_if_c<(!(boost::is_integral<T1>::value)), int>::type)()


________________________________________________________________________________________________________
*** CID 1415556:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 718 in boost::function1<void, int>::function1<PrimaryLogPG::remove_missing_object(const hobject_t &, eversion_t, Context *)::[lambda(int) (instance 1)]>(T1, boost::enable_if_c<(!(boost::is_integral<T1>::value)), int>::type)()
712     
713         BOOST_FUNCTION_FUNCTION() : function_base() { }
714     
715         // MSVC chokes if the following two constructors are collapsed into
716         // one with a default parameter.
717         template<typename Functor>
>>>     CID 1415556:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "PrimaryLogPG::remove_missing_object(hobject_t const &, eversion_t, Context *)::[lambda(int) (instance 1)]" (size 1104 bytes) by value.
718         BOOST_FUNCTION_FUNCTION(Functor BOOST_FUNCTION_TARGET_FIX(const &) f
719     #ifndef BOOST_NO_SFINAE
720                                 ,typename boost::enable_if_c<
721                                  !(is_integral<Functor>::value),
722                                             int>::type = 0
723     #endif // BOOST_NO_SFINAE

** CID 1415557:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 584 in boost::detail::function::basic_vtable1<void, int>::assign_functor<PrimaryLogPG::remove_missing_object(const hobject_t &, eversion_t, Context *)::[lambda(int) (instance 1)]>(T1, boost::detail::function::function_buffer &, mpl_::bool_<(bool)0>) const()


________________________________________________________________________________________________________
*** CID 1415557:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 584 in boost::detail::function::basic_vtable1<void, int>::assign_functor<PrimaryLogPG::remove_missing_object(const hobject_t &, eversion_t, Context *)::[lambda(int) (instance 1)]>(T1, boost::detail::function::function_buffer &, mpl_::bool_<(bool)0>) const()
578               assign_functor(f,functor,mpl::true_());
579             }
580     
581             // Assign to a function object allocated on the heap.
582             template<typename FunctionObj>
583             void
>>>     CID 1415557:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "PrimaryLogPG::remove_missing_object(hobject_t const &, eversion_t, Context *)::[lambda(int) (instance 1)]" (size 1104 bytes) by value.
584             assign_functor(FunctionObj f, function_buffer& functor, mpl::false_) const
585             {
586               functor.members.obj_ptr = new FunctionObj(f);
587             }
588             template<typename FunctionObj,typename Allocator>
589             void

** CID 1415558:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 47305 in __pyx_pw_5rados_5Ioctx_119application_enable()


________________________________________________________________________________________________________
*** CID 1415558:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 47305 in __pyx_pw_5rados_5Ioctx_119application_enable()
47299           }
47300           kw_args = PyDict_Size(__pyx_kwds);
47301           switch (pos_args) {
47302             case  0:
47303             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_app_name)) != 0)) kw_args--;
47304             else goto __pyx_L5_argtuple_error;
>>>     CID 1415558:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
47305             case  1:
47306             if (kw_args > 0) {
47307               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_force);
47308               if (value) { values[1] = value; kw_args--; }
47309             }
47310           }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HqmEi2R22YHXkWCosYE9EXLpHsybSNI-2FOQhMZUz6G9OuU0N8q7Uz1CboFB8Edir6bGZC9vy-2BYZokvyRdjMgQZRUzf5LuMKEmAHOvhzBXZT3hQ0Qkusfl5l740nl6QqMToukNsD0seRLn7bN0NpSoQVYDxrWQdCda9lwgN2koQZI-2Bb3G0MbC7owCOWkweFSyEw-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HqmEi2R22YHXkWCosYE9EXLpHsybSNI-2FOQhMZUz6G9Ot5JNAil7JiPkDb5bK2douJenOLgPXJVJauLjwemkUnFFF9SYD0i8nlcoPxVWQFhRjHOeyUgVKstO4SHSS95h9l7BjWFjchtDFu8VnzqqoUv4YBT-2FdfZ5q4UsY26nNO3C5-2BzsKI9rh45IsCP29lN-2BI0-3D

