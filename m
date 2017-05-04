From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Wed, 03 May 2017 19:45:11 -0700
Message-ID: <590a95b7a99bf_428972f330517b8@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:56972 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932456AbdEDCpN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 3 May 2017 22:45:13 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0001p1sjc2.sendgrid.net (SG) with ESMTP id ei7PZWspRHydZfuuuxcfhQ
        for <ceph-devel@vger.kernel.org>; Thu, 04 May 2017 02:45:11.728 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

83 new defect(s) introduced to ceph found with Coverity Scan.
64 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 83 defect(s)


** CID 1161001:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.2.1/functional: 1871 in std::function<void (const int &, std::unique_ptr<Request, std::default_delete<Request>>, crimson::dmclock::PhaseType)>::function()()


________________________________________________________________________________________________________
*** CID 1161001:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.2.1/functional: 1871 in std::function<void (const int &, std::unique_ptr<Request, std::default_delete<Request>>, crimson::dmclock::PhaseType)>::function()()
1865     
1866           /**
1867            *  @brief Default construct creates an empty function call wrapper.
1868            *  @post @c !(bool)*this
1869            */
1870           function() noexcept
>>>     CID 1161001:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "_M_invoker" is not initialized in this constructor nor in any functions that it calls.
1871           : _Function_base() { }
1872     
1873           /**
1874            *  @brief Creates an empty function call wrapper.
1875            *  @post @c !(bool)*this
1876            */

** CID 1222393:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.2.1/functional: 2111 in std::function<void (const unsigned int &, const crimson::qos_simulation::TestRequest &, const unsigned int &, const crimson::dmclock::ReqParams &)>::function(const std::function<void (const unsigned int &, const crimson::qos_simulation::TestRequest &, const unsigned int &, const crimson::dmclock::ReqParams &)>&)()


________________________________________________________________________________________________________
*** CID 1222393:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.2.1/functional: 2111 in std::function<void (const unsigned int &, const crimson::qos_simulation::TestRequest &, const unsigned int &, const crimson::dmclock::ReqParams &)>::function(const std::function<void (const unsigned int &, const crimson::qos_simulation::TestRequest &, const unsigned int &, const crimson::dmclock::ReqParams &)>&)()
2105           if (static_cast<bool>(__x))
2106     	{
2107     	  __x._M_manager(_M_functor, __x._M_functor, __clone_functor);
2108     	  _M_invoker = __x._M_invoker;
2109     	  _M_manager = __x._M_manager;
2110     	}
>>>     CID 1222393:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "_M_invoker" is not initialized in this constructor nor in any functions that it calls.
2111         }
2112     
2113       template<typename _Res, typename... _ArgTypes>
2114         template<typename _Functor, typename, typename>
2115           function<_Res(_ArgTypes...)>::
2116           function(_Functor __f)

** CID 1358695:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.2.1/functional: 2127 in std::function<void (crimson::test_dmc::DmcAccum &, const crimson::dmclock::PhaseType &)>::function<void (*)(crimson::test_dmc::DmcAccum &, const crimson::dmclock::PhaseType &), void, void>(T1)()


________________________________________________________________________________________________________
*** CID 1358695:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.2.1/functional: 2127 in std::function<void (crimson::test_dmc::DmcAccum &, const crimson::dmclock::PhaseType &)>::function<void (*)(crimson::test_dmc::DmcAccum &, const crimson::dmclock::PhaseType &), void, void>(T1)()
2121     	if (_My_handler::_M_not_empty_function(__f))
2122     	  {
2123     	    _My_handler::_M_init_functor(_M_functor, std::move(__f));
2124     	    _M_invoker = &_My_handler::_M_invoke;
2125     	    _M_manager = &_My_handler::_M_manager;
2126     	  }
>>>     CID 1358695:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "_M_invoker" is not initialized in this constructor nor in any functions that it calls.
2127           }
2128     
2129       template<typename _Res, typename... _ArgTypes>
2130         _Res
2131         function<_Res(_ArgTypes...)>::
2132         operator()(_ArgTypes... __args) const

** CID 1405781:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/dmclock/support/test/test_indirect_intrusive_heap.cc: 390 in IndIntruHeap_multi_K_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1405781:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/dmclock/support/test/test_indirect_intrusive_heap.cc: 390 in IndIntruHeap_multi_K_Test::TestBody()()
384       constexpr size_t count = 250;
385     
386       std::srand(std::time(0)); // use current time as seed for random generator
387     
388       // insert same set of random values into the four heaps
389       for (size_t i = 0; i < count; ++i) {
>>>     CID 1405781:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
390         int value = std::rand() % 201 - 100; // -100...+100
391         auto data = std::make_shared<Elem>(value);
392         heap2.push(data);
393         heap3.push(data);
394         heap4.push(data);
395         heap10.push(data);

** CID 1405782:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_rest_swift.cc: 770 in RGWPutObj_ObjStore_SWIFT::get_params()()


________________________________________________________________________________________________________
*** CID 1405782:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_rest_swift.cc: 770 in RGWPutObj_ObjStore_SWIFT::get_params()()
764         return r;
765       }
766     
767       if (!s->cct->_conf->rgw_swift_custom_header.empty()) {
768         string custom_header = s->cct->_conf->rgw_swift_custom_header;
769         if (s->info.env->exists(custom_header.c_str())) {
>>>     CID 1405782:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "this->s->info.env->get(custom_header.c_str(), NULL)" to "operator =", which dereferences it. [Note: The source code implementation of the function has been overridden by a builtin model.]
770           user_data = s->info.env->get(custom_header.c_str());
771         }
772       }
773     
774       dlo_manifest = s->info.env->get("HTTP_X_OBJECT_MANIFEST");
775       bool exists;

** CID 1405783:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rocksdb/db/convenience.cc: 19 in rocksdb::CancelAllBackgroundWork(rocksdb::DB *, bool)()


________________________________________________________________________________________________________
*** CID 1405783:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rocksdb/db/convenience.cc: 19 in rocksdb::CancelAllBackgroundWork(rocksdb::DB *, bool)()
13     
14     #include "db/db_impl.h"
15     
16     namespace rocksdb {
17     
18     void CancelAllBackgroundWork(DB* db, bool wait) {
>>>     CID 1405783:  Null pointer dereferences  (FORWARD_NULL)
>>>     Dynamic cast to pointer "dynamic_cast <rocksdb::DBImpl *>(db->GetRootDB())" can return "NULL".
19       (dynamic_cast<DBImpl*>(db->GetRootDB()))->CancelAllBackgroundWork(wait);
20     }
21     
22     Status DeleteFilesInRange(DB* db, ColumnFamilyHandle* column_family,
23                               const Slice* begin, const Slice* end) {
24       return (dynamic_cast<DBImpl*>(db))

** CID 1405784:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 8134 in BlueStore::_kv_sync_thread()()


________________________________________________________________________________________________________
*** CID 1405784:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 8134 in BlueStore::_kv_sync_thread()()
8128     	kv_committing.pop_front();
8129           }
8130           for (auto b : deferred_stable) {
8131     	auto p = b->txcs.begin();
8132     	while (p != b->txcs.end()) {
8133     	  TransContext *txc = &*p;
>>>     CID 1405784:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Using invalid iterator "boost::intrusive::list_impl<boost::intrusive::mhtraits<BlueStore::TransContext, boost::intrusive::list_member_hook<void, void, void>, &BlueStore::TransContext::deferred_queue_item>, unsigned long, true, void>::const_iterator(p)".
8134     	  p = b->txcs.erase(p); // unlink here because
8135     	  _txc_state_proc(txc); // this may destroy txc
8136     	}
8137     	delete b;
8138           }
8139     

** CID 1405785:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 2995 in __pyx_pw_5rados_7OSError_1__init__()


________________________________________________________________________________________________________
*** CID 1405785:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 2995 in __pyx_pw_5rados_7OSError_1__init__()
2989           }
2990           kw_args = PyDict_Size(__pyx_kwds);
2991           switch (pos_args) {
2992             case  0:
2993             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_self)) != 0)) kw_args--;
2994             else goto __pyx_L5_argtuple_error;
>>>     CID 1405785:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
2995             case  1:
2996             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_errno)) != 0)) kw_args--;
2997             else {
2998               __Pyx_RaiseArgtupleInvalid("__init__", 1, 3, 3, 1); __PYX_ERR(0, 310, __pyx_L3_error)
2999             }
3000             case  2:

** CID 1405786:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 3000 in __pyx_pw_5rados_7OSError_1__init__()


________________________________________________________________________________________________________
*** CID 1405786:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 3000 in __pyx_pw_5rados_7OSError_1__init__()
2994             else goto __pyx_L5_argtuple_error;
2995             case  1:
2996             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_errno)) != 0)) kw_args--;
2997             else {
2998               __Pyx_RaiseArgtupleInvalid("__init__", 1, 3, 3, 1); __PYX_ERR(0, 310, __pyx_L3_error)
2999             }
>>>     CID 1405786:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
3000             case  2:
3001             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_strerror)) != 0)) kw_args--;
3002             else {
3003               __Pyx_RaiseArgtupleInvalid("__init__", 1, 3, 3, 2); __PYX_ERR(0, 310, __pyx_L3_error)
3004             }
3005           }

** CID 1405787:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 21003 in __pyx_pw_3rbd_5Image_73diff_iterate()


________________________________________________________________________________________________________
*** CID 1405787:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 21003 in __pyx_pw_3rbd_5Image_73diff_iterate()
20997             }
20998             case  2:
20999             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_from_snapshot)) != 0)) kw_args--;
21000             else {
21001               __Pyx_RaiseArgtupleInvalid("diff_iterate", 0, 4, 6, 2); __PYX_ERR(0, 2022, __pyx_L3_error)
21002             }
>>>     CID 1405787:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
21003             case  3:
21004             if (likely((values[3] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_iterate_cb)) != 0)) kw_args--;
21005             else {
21006               __Pyx_RaiseArgtupleInvalid("diff_iterate", 0, 4, 6, 3); __PYX_ERR(0, 2022, __pyx_L3_error)
21007             }
21008             case  4:

** CID 1405788:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 28052 in __pyx_pw_3rbd_5Image_129aio_discard()


________________________________________________________________________________________________________
*** CID 1405788:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 28052 in __pyx_pw_3rbd_5Image_129aio_discard()
28046             else goto __pyx_L5_argtuple_error;
28047             case  1:
28048             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
28049             else {
28050               __Pyx_RaiseArgtupleInvalid("aio_discard", 1, 3, 3, 1); __PYX_ERR(0, 2601, __pyx_L3_error)
28051             }
>>>     CID 1405788:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
28052             case  2:
28053             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete)) != 0)) kw_args--;
28054             else {
28055               __Pyx_RaiseArgtupleInvalid("aio_discard", 1, 3, 3, 2); __PYX_ERR(0, 2601, __pyx_L3_error)
28056             }
28057           }

** CID 1405789:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8010 in __pyx_pw_3rbd_3RBD_17trash_get()


________________________________________________________________________________________________________
*** CID 1405789:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8010 in __pyx_pw_3rbd_3RBD_17trash_get()
8004             else goto __pyx_L5_argtuple_error;
8005             case  1:
8006             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
8007             else {
8008               __Pyx_RaiseArgtupleInvalid("trash_get", 1, 3, 3, 1); __PYX_ERR(0, 936, __pyx_L3_error)
8009             }
>>>     CID 1405789:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8010             case  2:
8011             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_image_id)) != 0)) kw_args--;
8012             else {
8013               __Pyx_RaiseArgtupleInvalid("trash_get", 1, 3, 3, 2); __PYX_ERR(0, 936, __pyx_L3_error)
8014             }
8015           }

** CID 1405790:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8490 in __pyx_pw_3rbd_3RBD_19trash_list()


________________________________________________________________________________________________________
*** CID 1405790:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8490 in __pyx_pw_3rbd_3RBD_19trash_list()
8484           }
8485           kw_args = PyDict_Size(__pyx_kwds);
8486           switch (pos_args) {
8487             case  0:
8488             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_self)) != 0)) kw_args--;
8489             else goto __pyx_L5_argtuple_error;
>>>     CID 1405790:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8490             case  1:
8491             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
8492             else {
8493               __Pyx_RaiseArgtupleInvalid("trash_list", 1, 2, 2, 1); __PYX_ERR(0, 979, __pyx_L3_error)
8494             }
8495           }

** CID 1405791:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24679 in __pyx_pw_3rbd_5Image_105lock_shared()


________________________________________________________________________________________________________
*** CID 1405791:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24679 in __pyx_pw_3rbd_5Image_105lock_shared()
24673           }
24674           kw_args = PyDict_Size(__pyx_kwds);
24675           switch (pos_args) {
24676             case  0:
24677             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cookie)) != 0)) kw_args--;
24678             else goto __pyx_L5_argtuple_error;
>>>     CID 1405791:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
24679             case  1:
24680             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_tag)) != 0)) kw_args--;
24681             else {
24682               __Pyx_RaiseArgtupleInvalid("lock_shared", 1, 2, 2, 1); __PYX_ERR(0, 2333, __pyx_L3_error)
24683             }
24684           }

** CID 1405792:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9338 in __pyx_pw_3rbd_3RBD_27mirror_peer_add()


________________________________________________________________________________________________________
*** CID 1405792:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9338 in __pyx_pw_3rbd_3RBD_27mirror_peer_add()
9332           }
9333           kw_args = PyDict_Size(__pyx_kwds);
9334           switch (pos_args) {
9335             case  0:
9336             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_self)) != 0)) kw_args--;
9337             else goto __pyx_L5_argtuple_error;
>>>     CID 1405792:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
9338             case  1:
9339             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
9340             else {
9341               __Pyx_RaiseArgtupleInvalid("mirror_peer_add", 1, 4, 4, 1); __PYX_ERR(0, 1044, __pyx_L3_error)
9342             }
9343             case  2:

** CID 1405793:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 18160 in __pyx_pw_3rbd_5Image_47rename_snap()


________________________________________________________________________________________________________
*** CID 1405793:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 18160 in __pyx_pw_3rbd_5Image_47rename_snap()
18154           }
18155           kw_args = PyDict_Size(__pyx_kwds);
18156           switch (pos_args) {
18157             case  0:
18158             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_srcname)) != 0)) kw_args--;
18159             else goto __pyx_L5_argtuple_error;
>>>     CID 1405793:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
18160             case  1:
18161             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_dstname)) != 0)) kw_args--;
18162             else {
18163               __Pyx_RaiseArgtupleInvalid("rename_snap", 1, 2, 2, 1); __PYX_ERR(0, 1786, __pyx_L3_error)
18164             }
18165           }

** CID 1405794:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8609 in __pyx_pw_3rbd_3RBD_21trash_restore()


________________________________________________________________________________________________________
*** CID 1405794:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8609 in __pyx_pw_3rbd_3RBD_21trash_restore()
8603           }
8604           kw_args = PyDict_Size(__pyx_kwds);
8605           switch (pos_args) {
8606             case  0:
8607             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_self)) != 0)) kw_args--;
8608             else goto __pyx_L5_argtuple_error;
>>>     CID 1405794:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8609             case  1:
8610             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
8611             else {
8612               __Pyx_RaiseArgtupleInvalid("trash_restore", 1, 4, 4, 1); __PYX_ERR(0, 988, __pyx_L3_error)
8613             }
8614             case  2:

** CID 1405795:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 27618 in __pyx_pw_3rbd_5Image_127aio_write()


________________________________________________________________________________________________________
*** CID 1405795:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 27618 in __pyx_pw_3rbd_5Image_127aio_write()
27612             else goto __pyx_L5_argtuple_error;
27613             case  1:
27614             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
27615             else {
27616               __Pyx_RaiseArgtupleInvalid("aio_write", 0, 3, 4, 1); __PYX_ERR(0, 2556, __pyx_L3_error)
27617             }
>>>     CID 1405795:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
27618             case  2:
27619             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete)) != 0)) kw_args--;
27620             else {
27621               __Pyx_RaiseArgtupleInvalid("aio_write", 0, 3, 4, 2); __PYX_ERR(0, 2556, __pyx_L3_error)
27622             }
27623             case  3:

** CID 1405796:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24246 in __pyx_pw_3rbd_5Image_101lock_break()


________________________________________________________________________________________________________
*** CID 1405796:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24246 in __pyx_pw_3rbd_5Image_101lock_break()
24240           }
24241           kw_args = PyDict_Size(__pyx_kwds);
24242           switch (pos_args) {
24243             case  0:
24244             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_lock_mode)) != 0)) kw_args--;
24245             else goto __pyx_L5_argtuple_error;
>>>     CID 1405796:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
24246             case  1:
24247             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_lock_owner)) != 0)) kw_args--;
24248             else {
24249               __Pyx_RaiseArgtupleInvalid("lock_break", 1, 2, 2, 1); __PYX_ERR(0, 2303, __pyx_L3_error)
24250             }
24251           }

** CID 1405797:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 27613 in __pyx_pw_3rbd_5Image_127aio_write()


________________________________________________________________________________________________________
*** CID 1405797:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 27613 in __pyx_pw_3rbd_5Image_127aio_write()
27607           }
27608           kw_args = PyDict_Size(__pyx_kwds);
27609           switch (pos_args) {
27610             case  0:
27611             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_data)) != 0)) kw_args--;
27612             else goto __pyx_L5_argtuple_error;
>>>     CID 1405797:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
27613             case  1:
27614             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
27615             else {
27616               __Pyx_RaiseArgtupleInvalid("aio_write", 0, 3, 4, 1); __PYX_ERR(0, 2556, __pyx_L3_error)
27617             }
27618             case  2:


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GkzVqSy5um0G-2F060TlF5Yc14Eu4rR4NWgcuqu6-2BlwkuG-2BuyzfDsEURiBOsX-2FGvN5jmsKmeIE97INOgDRil5CF-2FdBU-2BNz-2FDLUPPF8idy4XySa5AlDew0cBaAbN1mS7NqLG-2FQkC8G3YrFDqV96XFaQeL8-2Beu6nYHiz6GrGvXe-2FFjCoatpFX82VCedd-2Bf-2FudXKLk-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GkzVqSy5um0G-2F060TlF5Yc14Eu4rR4NWgcuqu6-2BlwkuBR8pCwrYuhbR-2B5Tx3ftvQQOyYTup1g5qYrQ-2FseYF8sDv-2Bmv10yMfinqIhsYVcPRemPxf-2BD0msxaB-2FL97kr9eBVzA4OnTAo-2FWRMxjH1-2F0-2BdJabe7SBC-2F2zUuAN-2B3cQPxHjiRZo2wELAIhtra-2BhhoAFA-3D

