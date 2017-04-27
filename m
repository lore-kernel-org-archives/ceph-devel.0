From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Wed, 26 Apr 2017 19:22:17 -0700
Message-ID: <590155d955646_40d172f330517d1@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:60031 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S938120AbdD0CWS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 26 Apr 2017 22:22:18 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0003p1sjc2.sendgrid.net (SG) with ESMTP id 5D4A6uQdRgyGgIpF9gFTjQ
        for <ceph-devel@vger.kernel.org>; Thu, 27 Apr 2017 02:22:17.387 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

22 new defect(s) introduced to ceph found with Coverity Scan.
8 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 22 defect(s)


** CID 1405516:  Incorrect expression  (COPY_PASTE_ERROR)
/home/brad/working/src/ceph/src/mon/Monitor.cc: 2923 in Monitor::handle_command(boost::intrusive_ptr<MonOpRequest>)()


________________________________________________________________________________________________________
*** CID 1405516:  Incorrect expression  (COPY_PASTE_ERROR)
/home/brad/working/src/ceph/src/mon/Monitor.cc: 2923 in Monitor::handle_command(boost::intrusive_ptr<MonOpRequest>)()
2917       }
2918     
2919       if (module == "mds" || module == "fs") {
2920         mdsmon()->dispatch(op);
2921         return;
2922       }
>>>     CID 1405516:  Incorrect expression  (COPY_PASTE_ERROR)
>>>     "module" looks like a copy-paste error.
2923       if (module == "osd" || prefix == "pg map") {
2924         osdmon()->dispatch(op);
2925         return;
2926       }
2927     
2928       if (module == "pg") {

** CID 1405517:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_sync.cc: 98 in RGWBackoffControlCR::operate()()


________________________________________________________________________________________________________
*** CID 1405517:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_sync.cc: 98 in RGWBackoffControlCR::operate()()
92             cr->get();
93             call(cr);
94           }
95           {
96             Mutex::Locker l(lock);
97             cr->put();
>>>     CID 1405517:  Null pointer dereferences  (FORWARD_NULL)
>>>     Assigning: "this->cr" = "NULL".
98             cr = NULL;
99           }
100           if (retcode >= 0) {
101             break;
102           }
103           if (retcode != -EBUSY && retcode != -EAGAIN) {

** CID 1405518:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 106 in __event_prepare_filter_stack__osd___do_osd_op_pre_extent_cmp()


________________________________________________________________________________________________________
*** CID 1405518:  Integer handling issues  (NO_EFFECT)
/include/tracing/osd.h: 106 in __event_prepare_filter_stack__osd___do_osd_op_pre_extent_cmp()
100             ctf_integer_hex(uint16_t, op, op)
101             ctf_string(opname, opname)
102             ctf_integer_hex(uint32_t, flags, flags)
103         )
104     )
105     
>>>     CID 1405518:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "4294967295U < 0U".
106     TRACEPOINT_EVENT(osd, do_osd_op_pre_extent_cmp,
107         TP_ARGS(
108             const char*, oid,
109             uint64_t, snap,
110             uint64_t, osize,
111             uint32_t, oseq,

** CID 1405519:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1405519:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/tools/rbd_mirror/instance_watcher/Types.cc: 108 in rbd::mirror::instance_watcher::NotifyMessage::encode(ceph::buffer::list &) const()
102     }
103     
104     void UnknownPayload::dump(Formatter *f) const {
105     }
106     
107     void NotifyMessage::encode(bufferlist& bl) const {
>>>     CID 1405519:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
108       ENCODE_START(1, 1, bl);
109       boost::apply_visitor(EncodePayloadVisitor(bl), payload);
110       ENCODE_FINISH(bl);
111     }
112     
113     void NotifyMessage::decode(bufferlist::iterator& iter) {

** CID 1405520:    (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1116 in PGLog::read_log_and_missing<pg_missing_set<(bool)0>>(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, PGLog::IndexedLog &, T1 &, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool *, const DoutPrefixProvider *, std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> *, bool)()
/home/brad/working/src/ceph/src/osd/PGLog.h: 1116 in PGLog::read_log_and_missing<pg_missing_set<(bool)1>>(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, PGLog::IndexedLog &, T1 &, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool *, const DoutPrefixProvider *, std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> *, bool)()


________________________________________________________________________________________________________
*** CID 1405520:    (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1116 in PGLog::read_log_and_missing<pg_missing_set<(bool)0>>(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, PGLog::IndexedLog &, T1 &, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool *, const DoutPrefixProvider *, std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> *, bool)()
1110           (pg_log_debug ? &log_keys_debug : 0),
1111           debug_verify_stored_missing);
1112       }
1113     
1114       template <typename missing_type>
1115       static void read_log_and_missing(ObjectStore *store, coll_t pg_coll,
>>>     CID 1405520:    (PASS_BY_VALUE)
>>>     Passing parameter log_oid of type "ghobject_t" (size 144 bytes) by value.
1116         coll_t log_coll, ghobject_t log_oid,
1117         const pg_info_t &info,
1118         IndexedLog &log,
1119         missing_type &missing, ostringstream &oss,
1120         bool tolerate_divergent_missing_log,
1121         bool *clear_divergent_priors = NULL,
/home/brad/working/src/ceph/src/osd/PGLog.h: 1116 in PGLog::read_log_and_missing<pg_missing_set<(bool)1>>(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, PGLog::IndexedLog &, T1 &, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool *, const DoutPrefixProvider *, std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> *, bool)()
1110           (pg_log_debug ? &log_keys_debug : 0),
1111           debug_verify_stored_missing);
1112       }
1113     
1114       template <typename missing_type>
1115       static void read_log_and_missing(ObjectStore *store, coll_t pg_coll,
>>>     CID 1405520:    (PASS_BY_VALUE)
>>>     Passing parameter log_oid of type "ghobject_t" (size 144 bytes) by value.
1116         coll_t log_coll, ghobject_t log_oid,
1117         const pg_info_t &info,
1118         IndexedLog &log,
1119         missing_type &missing, ostringstream &oss,
1120         bool tolerate_divergent_missing_log,
1121         bool *clear_divergent_priors = NULL,

** CID 1405521:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1098 in PGLog::read_log_and_missing(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool)()


________________________________________________________________________________________________________
*** CID 1405521:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1098 in PGLog::read_log_and_missing(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool)()
1092         bool clear_divergent_priors,
1093         set<string> *log_keys_debug
1094         );
1095     
1096       void read_log_and_missing(
1097         ObjectStore *store, coll_t pg_coll,
>>>     CID 1405521:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter log_oid of type "ghobject_t" (size 144 bytes) by value.
1098         coll_t log_coll, ghobject_t log_oid,
1099         const pg_info_t &info,
1100         ostringstream &oss,
1101         bool tolerate_divergent_missing_log,
1102         bool debug_verify_stored_missing = false
1103         ) {

** CID 1405522:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/c_read_operations.cc: 680 in CReadOpsTest_CmpExt_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/c_read_operations.cc: 696 in CReadOpsTest_CmpExt_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1405522:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/c_read_operations.cc: 680 in CReadOpsTest_CmpExt_Test::TestBody()()
674       int read_val = 0;
675     
676       write_object();
677     
678       // cmpext with match should ensure that the following read is successful
679       rados_read_op_t op = rados_create_read_op();
>>>     CID 1405522:    (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
680       ASSERT_TRUE(op);
681       // @obj, @data and @len correspond to object initialised by write_object()
682       rados_read_op_cmpext(op, data, len, 0, &cmpext_val);
683       rados_read_op_read(op, 0, len, buf, &bytes_read, &read_val);
684       ASSERT_EQ(0, rados_read_op_operate(op, ioctx, obj, 0));
685       ASSERT_EQ(len, bytes_read);
/home/brad/working/src/ceph/src/test/librados/c_read_operations.cc: 696 in CReadOpsTest_CmpExt_Test::TestBody()()
690       // cmpext with mismatch should fail and fill mismatch_buf accordingly
691       memset(buf, 0, sizeof(buf));
692       bytes_read = 0;
693       cmpext_val = 0;
694       read_val = 0;
695       op = rados_create_read_op();
>>>     CID 1405522:    (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
696       ASSERT_TRUE(op);
697       // @obj, @data and @len correspond to object initialised by write_object()
698       rados_read_op_cmpext(op, "mismatch", strlen("mismatch"), 0, &cmpext_val);
699       rados_read_op_read(op, 0, len, buf, &bytes_read, &read_val);
700       ASSERT_EQ(-MAX_ERRNO, rados_read_op_operate(op, ioctx, obj, 0));
701       rados_release_read_op(op);

** CID 1405523:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4101 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4109 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4113 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4115 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4099 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4095 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1405523:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4101 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
4095       ASSERT_EQ(0, test_data.m_ioctx.aio_cmpext("foo", my_completion2, 0, cbl));
4096     
4097       {
4098         TestAlarm alarm;
4099         ASSERT_EQ(0, my_completion2->wait_for_complete());
4100       }
>>>     CID 1405523:    (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
4101       ASSERT_EQ(0, my_completion2->get_return_value());
4102     
4103       /* compare with mismatch */
4104       memset(full, 0xdd, sizeof(full));
4105       cbl.clear();
4106       cbl.append(full, sizeof(full));
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4109 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
4103       /* compare with mismatch */
4104       memset(full, 0xdd, sizeof(full));
4105       cbl.clear();
4106       cbl.append(full, sizeof(full));
4107       AioCompletion *my_completion3 = test_data.m_cluster.aio_create_completion(
4108     	  (void*)&test_data, set_completion_complete, set_completion_safe);
>>>     CID 1405523:    (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
4109       ASSERT_EQ(0, test_data.m_ioctx.aio_cmpext("foo", my_completion3, 0, cbl));
4110     
4111       {
4112         TestAlarm alarm;
4113         ASSERT_EQ(0, my_completion3->wait_for_complete());
4114       }
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4113 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
4107       AioCompletion *my_completion3 = test_data.m_cluster.aio_create_completion(
4108     	  (void*)&test_data, set_completion_complete, set_completion_safe);
4109       ASSERT_EQ(0, test_data.m_ioctx.aio_cmpext("foo", my_completion3, 0, cbl));
4110     
4111       {
4112         TestAlarm alarm;
>>>     CID 1405523:    (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
4113         ASSERT_EQ(0, my_completion3->wait_for_complete());
4114       }
4115       ASSERT_EQ(-MAX_ERRNO, my_completion3->get_return_value());
4116     
4117       delete my_completion;
4118       delete my_completion2;
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4115 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
4109       ASSERT_EQ(0, test_data.m_ioctx.aio_cmpext("foo", my_completion3, 0, cbl));
4110     
4111       {
4112         TestAlarm alarm;
4113         ASSERT_EQ(0, my_completion3->wait_for_complete());
4114       }
>>>     CID 1405523:    (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
4115       ASSERT_EQ(-MAX_ERRNO, my_completion3->get_return_value());
4116     
4117       delete my_completion;
4118       delete my_completion2;
4119       delete my_completion3;
4120     }
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4099 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
4093       AioCompletion *my_completion2 = test_data.m_cluster.aio_create_completion(
4094     	  (void*)&test_data, set_completion_complete, set_completion_safe);
4095       ASSERT_EQ(0, test_data.m_ioctx.aio_cmpext("foo", my_completion2, 0, cbl));
4096     
4097       {
4098         TestAlarm alarm;
>>>     CID 1405523:    (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
4099         ASSERT_EQ(0, my_completion2->wait_for_complete());
4100       }
4101       ASSERT_EQ(0, my_completion2->get_return_value());
4102     
4103       /* compare with mismatch */
4104       memset(full, 0xdd, sizeof(full));
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4095 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
4089     
4090       /* compare with match */
4091       bufferlist cbl;
4092       cbl.append(full, sizeof(full));
4093       AioCompletion *my_completion2 = test_data.m_cluster.aio_create_completion(
4094     	  (void*)&test_data, set_completion_complete, set_completion_safe);
>>>     CID 1405523:    (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
4095       ASSERT_EQ(0, test_data.m_ioctx.aio_cmpext("foo", my_completion2, 0, cbl));
4096     
4097       {
4098         TestAlarm alarm;
4099         ASSERT_EQ(0, my_completion2->wait_for_complete());
4100       }

** CID 1405524:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4115 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4113 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4109 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1405524:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4115 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
4109       ASSERT_EQ(0, test_data.m_ioctx.aio_cmpext("foo", my_completion3, 0, cbl));
4110     
4111       {
4112         TestAlarm alarm;
4113         ASSERT_EQ(0, my_completion3->wait_for_complete());
4114       }
>>>     CID 1405524:    (RESOURCE_LEAK)
>>>     Variable "my_completion3" going out of scope leaks the storage it points to.
4115       ASSERT_EQ(-MAX_ERRNO, my_completion3->get_return_value());
4116     
4117       delete my_completion;
4118       delete my_completion2;
4119       delete my_completion3;
4120     }
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4113 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
4107       AioCompletion *my_completion3 = test_data.m_cluster.aio_create_completion(
4108     	  (void*)&test_data, set_completion_complete, set_completion_safe);
4109       ASSERT_EQ(0, test_data.m_ioctx.aio_cmpext("foo", my_completion3, 0, cbl));
4110     
4111       {
4112         TestAlarm alarm;
>>>     CID 1405524:    (RESOURCE_LEAK)
>>>     Variable "my_completion3" going out of scope leaks the storage it points to.
4113         ASSERT_EQ(0, my_completion3->wait_for_complete());
4114       }
4115       ASSERT_EQ(-MAX_ERRNO, my_completion3->get_return_value());
4116     
4117       delete my_completion;
4118       delete my_completion2;
/home/brad/working/src/ceph/src/test/librados/aio.cc: 4109 in LibRadosAio_RoundTripCmpExtPP_Test::TestBody()()
4103       /* compare with mismatch */
4104       memset(full, 0xdd, sizeof(full));
4105       cbl.clear();
4106       cbl.append(full, sizeof(full));
4107       AioCompletion *my_completion3 = test_data.m_cluster.aio_create_completion(
4108     	  (void*)&test_data, set_completion_complete, set_completion_safe);
>>>     CID 1405524:    (RESOURCE_LEAK)
>>>     Variable "my_completion3" going out of scope leaks the storage it points to.
4109       ASSERT_EQ(0, test_data.m_ioctx.aio_cmpext("foo", my_completion3, 0, cbl));
4110     
4111       {
4112         TestAlarm alarm;
4113         ASSERT_EQ(0, my_completion3->wait_for_complete());
4114       }

** CID 1405525:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/c_write_operations.cc: 240 in LibRadosCWriteOps_CmpExt_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/c_write_operations.cc: 273 in LibRadosCWriteOps_CmpExt_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1405525:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/c_write_operations.cc: 240 in LibRadosCWriteOps_CmpExt_Test::TestBody()()
234       std::string pool_name = get_temp_pool_name();
235       ASSERT_EQ("", create_one_pool(pool_name, &cluster));
236       rados_ioctx_create(cluster, pool_name.c_str(), &ioctx);
237     
238       // create an object, write to it using writesame
239       rados_write_op_t op = rados_create_write_op();
>>>     CID 1405525:    (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
240       ASSERT_TRUE(op);
241       rados_write_op_create(op, LIBRADOS_CREATE_EXCLUSIVE, NULL);
242       rados_write_op_write(op, "four", 4, 0);
243       ASSERT_EQ(0, rados_write_op_operate(op, ioctx, "test", NULL, 0));
244       rados_release_write_op(op);
245       char hi[4];
/home/brad/working/src/ceph/src/test/librados/c_write_operations.cc: 273 in LibRadosCWriteOps_CmpExt_Test::TestBody()()
267       ASSERT_EQ(-MAX_ERRNO - 1, rados_write_op_operate(op, ioctx, "test", NULL, 0));
268     
269       ASSERT_EQ(-MAX_ERRNO - 1, val);
270     
271       // cleanup
272       op = rados_create_write_op();
>>>     CID 1405525:    (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
273       ASSERT_TRUE(op);
274       rados_write_op_remove(op);
275       ASSERT_EQ(0, rados_write_op_operate(op, ioctx, "test", NULL, 0));
276     
277       rados_ioctx_destroy(ioctx);
278       ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));

** CID 1405526:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/c_write_operations.cc: 240 in LibRadosCWriteOps_CmpExt_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1405526:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/c_write_operations.cc: 240 in LibRadosCWriteOps_CmpExt_Test::TestBody()()
234       std::string pool_name = get_temp_pool_name();
235       ASSERT_EQ("", create_one_pool(pool_name, &cluster));
236       rados_ioctx_create(cluster, pool_name.c_str(), &ioctx);
237     
238       // create an object, write to it using writesame
239       rados_write_op_t op = rados_create_write_op();
>>>     CID 1405526:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "ioctx" going out of scope leaks the storage it points to.
240       ASSERT_TRUE(op);
241       rados_write_op_create(op, LIBRADOS_CREATE_EXCLUSIVE, NULL);
242       rados_write_op_write(op, "four", 4, 0);
243       ASSERT_EQ(0, rados_write_op_operate(op, ioctx, "test", NULL, 0));
244       rados_release_write_op(op);
245       char hi[4];

** CID 1405527:  API usage errors  (STREAM_FORMAT_STATE)
/home/brad/working/src/ceph/src/osd/osd_types.cc: 3704 in operator <<(std::basic_ostream<char, std::char_traits<char>>&, const pg_log_entry_t &)()


________________________________________________________________________________________________________
*** CID 1405527:  API usage errors  (STREAM_FORMAT_STATE)
/home/brad/working/src/ceph/src/osd/osd_types.cc: 3704 in operator <<(std::basic_ostream<char, std::char_traits<char>>&, const pg_log_entry_t &)()
3698           ::decode(snaps, p);
3699         } catch (...) {
3700           snaps.clear();
3701         }
3702         out << " snaps " << snaps;
3703       }
>>>     CID 1405527:  API usage errors  (STREAM_FORMAT_STATE)
>>>     Changing format state of stream "out" for category adjustfield without later restoring it.
3704       return out;
3705     }
3706     
3707     
3708     // -- pg_log_t --
3709     

** CID 1405528:  Memory - illegal accesses  (STRING_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_data_sync.cc: 483 in RGWInitDataSyncStatusCoroutine::RGWInitDataSyncStatusCoroutine(RGWDataSyncEnv *, unsigned int, rgw_data_sync_status *)()


________________________________________________________________________________________________________
*** CID 1405528:  Memory - illegal accesses  (STRING_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_data_sync.cc: 483 in RGWInitDataSyncStatusCoroutine::RGWInitDataSyncStatusCoroutine(RGWDataSyncEnv *, unsigned int, rgw_data_sync_status *)()
477         lock_name = "sync_lock";
478     
479     #define COOKIE_LEN 16
480         char buf[COOKIE_LEN + 1];
481     
482         gen_rand_alphanumeric(cct, buf, sizeof(buf) - 1);
>>>     CID 1405528:  Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "buf" to "operator =", which expects a null-terminated string. [Note: The source code implementation of the function has been overridden by a builtin model.]
483         cookie = buf;
484     
485         sync_status_oid = RGWDataSyncStatusManager::sync_status_oid(sync_env->source_zone);
486       }
487     
488       int operate() override {

** CID 1405529:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()


________________________________________________________________________________________________________
*** CID 1405529:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 246 in main()
240         << "  compact\n"
241         << "  compact-prefix <prefix>\n"
242         << "  compact-range <prefix> <start> <end>\n"
243         << std::endl;
244     }
245     
>>>     CID 1405529:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
246     int main(int argc, const char *argv[])
247     {
248       vector<const char*> args;
249       argv_to_vec(argc, argv, args);
250       env_to_vec(args);
251     

** CID 1405530:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/direct_messenger/test_direct_messenger.cc: 424 in main()
/home/brad/working/src/ceph/src/test/direct_messenger/test_direct_messenger.cc: 424 in main()
/home/brad/working/src/ceph/src/test/direct_messenger/test_direct_messenger.cc: 424 in main()


________________________________________________________________________________________________________
*** CID 1405530:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/direct_messenger/test_direct_messenger.cc: 424 in main()
418       ASSERT_EQ(-ENOTCONN, client.send_message(new MPing(), server.get_myinst()));
419     
420       ASSERT_EQ(0, client.shutdown());
421       client.wait();
422     }
423     
>>>     CID 1405530:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
424     int main(int argc, char **argv)
425     {
426       // command-line arguments
427       vector<const char*> args;
428       argv_to_vec(argc, (const char **)argv, args);
429       env_to_vec(args);
/home/brad/working/src/ceph/src/test/direct_messenger/test_direct_messenger.cc: 424 in main()
418       ASSERT_EQ(-ENOTCONN, client.send_message(new MPing(), server.get_myinst()));
419     
420       ASSERT_EQ(0, client.shutdown());
421       client.wait();
422     }
423     
>>>     CID 1405530:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
424     int main(int argc, char **argv)
425     {
426       // command-line arguments
427       vector<const char*> args;
428       argv_to_vec(argc, (const char **)argv, args);
429       env_to_vec(args);
/home/brad/working/src/ceph/src/test/direct_messenger/test_direct_messenger.cc: 424 in main()
418       ASSERT_EQ(-ENOTCONN, client.send_message(new MPing(), server.get_myinst()));
419     
420       ASSERT_EQ(0, client.shutdown());
421       client.wait();
422     }
423     
>>>     CID 1405530:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
424     int main(int argc, char **argv)
425     {
426       // command-line arguments
427       vector<const char*> args;
428       argv_to_vec(argc, (const char **)argv, args);
429       env_to_vec(args);

** CID 1405531:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/ObjectMap/test_keyvaluedb_atomicity.cc: 82 in main()


________________________________________________________________________________________________________
*** CID 1405531:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/ObjectMap/test_keyvaluedb_atomicity.cc: 82 in main()
76         }
77         assert(!db->submit_transaction(t));
78       }
79       return 0;
80     }
81     
>>>     CID 1405531:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main()" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
82     int main() {
83       char *path = getenv("OBJECT_MAP_PATH");
84       boost::scoped_ptr< KeyValueDB > db;
85       if (!path) {
86         std::cerr << "No path found, OBJECT_MAP_PATH undefined" << std::endl;
87         return 0;

** CID 1405532:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/direct_messenger/test_direct_messenger.cc: 424 in main()


________________________________________________________________________________________________________
*** CID 1405532:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/direct_messenger/test_direct_messenger.cc: 424 in main()
418       ASSERT_EQ(-ENOTCONN, client.send_message(new MPing(), server.get_myinst()));
419     
420       ASSERT_EQ(0, client.shutdown());
421       client.wait();
422     }
423     
>>>     CID 1405532:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::GoogleTestFailureException" is thrown and never caught.
424     int main(int argc, char **argv)
425     {
426       // command-line arguments
427       vector<const char*> args;
428       argv_to_vec(argc, (const char **)argv, args);
429       env_to_vec(args);

** CID 1405533:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/direct_messenger/test_direct_messenger.cc: 424 in main()


________________________________________________________________________________________________________
*** CID 1405533:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/direct_messenger/test_direct_messenger.cc: 424 in main()
418       ASSERT_EQ(-ENOTCONN, client.send_message(new MPing(), server.get_myinst()));
419     
420       ASSERT_EQ(0, client.shutdown());
421       client.wait();
422     }
423     
>>>     CID 1405533:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
424     int main(int argc, char **argv)
425     {
426       // command-line arguments
427       vector<const char*> args;
428       argv_to_vec(argc, (const char **)argv, args);
429       env_to_vec(args);

** CID 1405534:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/direct_messenger/test_direct_messenger.cc: 424 in main()


________________________________________________________________________________________________________
*** CID 1405534:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/direct_messenger/test_direct_messenger.cc: 424 in main()
418       ASSERT_EQ(-ENOTCONN, client.send_message(new MPing(), server.get_myinst()));
419     
420       ASSERT_EQ(0, client.shutdown());
421       client.wait();
422     }
423     
>>>     CID 1405534:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::<unnamed>::ClassUniqueToAlwaysTrue" is thrown and never caught.
424     int main(int argc, char **argv)
425     {
426       // command-line arguments
427       vector<const char*> args;
428       argv_to_vec(argc, (const char **)argv, args);
429       env_to_vec(args);

** CID 1405535:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/image/CloneRequest.cc: 55 in librbd::image::CloneRequest<librbd::ImageCtx>::CloneRequest(librbd::ImageCtx *, librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, librbd::ImageOptions, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ContextWQ *, Context *)()


________________________________________________________________________________________________________
*** CID 1405535:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/image/CloneRequest.cc: 55 in librbd::image::CloneRequest<librbd::ImageCtx>::CloneRequest(librbd::ImageCtx *, librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, librbd::ImageOptions, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ContextWQ *, Context *)()
49         m_opts.set(RBD_IMAGE_OPTION_FORMAT, static_cast<uint64_t>(2));
50       }
51     
52       ldout(m_cct, 20) << "clone " << &m_p_imctx->md_ctx << " name " << m_p_imctx->name
53     		 << " snap " << m_p_imctx->snap_name << " to child " << &m_ioctx
54     		 << " name " << m_name << " opts = " << &m_opts << dendl;
>>>     CID 1405535:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_force_non_primary" is not initialized in this constructor nor in any functions that it calls.
55       return;
56     }
57     
58     template <typename I>
59     void CloneRequest<I>::send() {
60       ldout(m_cct, 20) << this << " " << __func__ << dendl;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FWC5Lanp6zKkoteKjArroYRReoPv-2BmrW7vqYxCjQ4mkRmh-2FzUglMW6QVZAp3Ih0RwpGGsAnBGRGpDRdBIb5WBcIM6G-2B1GcGHIg0aFT2TASUVccMXbDD-2FPFt6MvRsdHss0tCxKW1raF8bBpdkMDDaOf-2FGSj60neSozzoto5gOYI1TvJDH85Dvy8m-2BzZgtqKtZQ-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FWC5Lanp6zKkoteKjArroYRReoPv-2BmrW7vqYxCjQ4mkSkH0vVHRb6k0xQGwMJkLxh1Q7glJvc43rNhn8FsQ-2FnIA4ZxdbGL8bZCiMHGg5kDt8iVRHOfbUxdEdtB1QOauXVTDnPmVHS3-2BsVroXgtImy0jRQDfnknsV9P95M60Bhd-2B2Yzq9O9kyAF3S3A-2F6fzaLs-3D

