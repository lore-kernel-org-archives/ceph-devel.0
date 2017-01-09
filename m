From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Mon, 09 Jan 2017 02:05:03 -0800
Message-ID: <5873604f8dcff_6866de3334795cc@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.24nn.shared.sendgrid.net ([167.89.100.237]:53524 "EHLO
        o1.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935056AbdAIKFF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 05:05:05 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0004p1sjc2.sendgrid.net (SG) with ESMTP id ldLZ1My4R1-rYOo-k9kFxQ
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2017 10:05:03.621 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

20 new defect(s) introduced to ceph found with Coverity Scan.
26 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 20 defect(s)


** CID 1398500:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/civetweb/src/civetweb.c: 10820 in refresh_trust()


________________________________________________________________________________________________________
*** CID 1398500:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/civetweb/src/civetweb.c: 10820 in refresh_trust()
10814     	if ((pem = conn->ctx->config[SSL_CERTIFICATE]) == NULL
10815     	    && conn->ctx->callbacks.init_ssl == NULL) {
10816     		return 0;
10817     	}
10818     
10819     	t = data_check;
>>>     CID 1398500:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "pem" to "stat", which dereferences it. [Note: The source code implementation of the function has been overridden by a builtin model.]
10820     	if (stat(pem, &cert_buf) != -1) {
10821     		t = (long int)cert_buf.st_mtime;
10822     	}
10823     
10824     	if (data_check != t) {
10825     		data_check = t;

** CID 1398501:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 21760 in __pyx_pw_3rbd_5Image_97lock_break()


________________________________________________________________________________________________________
*** CID 1398501:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 21760 in __pyx_pw_3rbd_5Image_97lock_break()
21754           }
21755           kw_args = PyDict_Size(__pyx_kwds);
21756           switch (pos_args) {
21757             case  0:
21758             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_lock_mode)) != 0)) kw_args--;
21759             else goto __pyx_L5_argtuple_error;
>>>     CID 1398501:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
21760             case  1:
21761             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_lock_owner)) != 0)) kw_args--;
21762             else {
21763               __Pyx_RaiseArgtupleInvalid("lock_break", 1, 2, 2, 1); __PYX_ERR(0, 2100, __pyx_L3_error)
21764             }
21765           }

** CID 1398502:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 22666 in __pyx_pw_3rbd_5Image_105break_lock()


________________________________________________________________________________________________________
*** CID 1398502:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 22666 in __pyx_pw_3rbd_5Image_105break_lock()
22660           }
22661           kw_args = PyDict_Size(__pyx_kwds);
22662           switch (pos_args) {
22663             case  0:
22664             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_client)) != 0)) kw_args--;
22665             else goto __pyx_L5_argtuple_error;
>>>     CID 1398502:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
22666             case  1:
22667             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cookie)) != 0)) kw_args--;
22668             else {
22669               __Pyx_RaiseArgtupleInvalid("break_lock", 1, 2, 2, 1); __PYX_ERR(0, 2159, __pyx_L3_error)
22670             }
22671           }

** CID 1398503:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24445 in __pyx_pw_3rbd_5Image_121aio_read()


________________________________________________________________________________________________________
*** CID 1398503:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24445 in __pyx_pw_3rbd_5Image_121aio_read()
24439             else goto __pyx_L5_argtuple_error;
24440             case  1:
24441             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
24442             else {
24443               __Pyx_RaiseArgtupleInvalid("aio_read", 0, 3, 4, 1); __PYX_ERR(0, 2298, __pyx_L3_error)
24444             }
>>>     CID 1398503:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
24445             case  2:
24446             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete)) != 0)) kw_args--;
24447             else {
24448               __Pyx_RaiseArgtupleInvalid("aio_read", 0, 3, 4, 2); __PYX_ERR(0, 2298, __pyx_L3_error)
24449             }
24450             case  3:

** CID 1398504:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25561 in __pyx_pw_3rbd_5Image_125aio_discard()


________________________________________________________________________________________________________
*** CID 1398504:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25561 in __pyx_pw_3rbd_5Image_125aio_discard()
25555           }
25556           kw_args = PyDict_Size(__pyx_kwds);
25557           switch (pos_args) {
25558             case  0:
25559             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
25560             else goto __pyx_L5_argtuple_error;
>>>     CID 1398504:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
25561             case  1:
25562             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
25563             else {
25564               __Pyx_RaiseArgtupleInvalid("aio_discard", 1, 3, 3, 1); __PYX_ERR(0, 2399, __pyx_L3_error)
25565             }
25566             case  2:

** CID 1398505:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25132 in __pyx_pw_3rbd_5Image_123aio_write()


________________________________________________________________________________________________________
*** CID 1398505:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25132 in __pyx_pw_3rbd_5Image_123aio_write()
25126             else goto __pyx_L5_argtuple_error;
25127             case  1:
25128             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
25129             else {
25130               __Pyx_RaiseArgtupleInvalid("aio_write", 0, 3, 4, 1); __PYX_ERR(0, 2353, __pyx_L3_error)
25131             }
>>>     CID 1398505:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
25132             case  2:
25133             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete)) != 0)) kw_args--;
25134             else {
25135               __Pyx_RaiseArgtupleInvalid("aio_write", 0, 3, 4, 2); __PYX_ERR(0, 2353, __pyx_L3_error)
25136             }
25137             case  3:

** CID 1398506:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24450 in __pyx_pw_3rbd_5Image_121aio_read()


________________________________________________________________________________________________________
*** CID 1398506:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24450 in __pyx_pw_3rbd_5Image_121aio_read()
24444             }
24445             case  2:
24446             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete)) != 0)) kw_args--;
24447             else {
24448               __Pyx_RaiseArgtupleInvalid("aio_read", 0, 3, 4, 2); __PYX_ERR(0, 2298, __pyx_L3_error)
24449             }
>>>     CID 1398506:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
24450             case  3:
24451             if (kw_args > 0) {
24452               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_fadvise_flags);
24453               if (value) { values[3] = value; kw_args--; }
24454             }
24455           }

** CID 1398507:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25127 in __pyx_pw_3rbd_5Image_123aio_write()


________________________________________________________________________________________________________
*** CID 1398507:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25127 in __pyx_pw_3rbd_5Image_123aio_write()
25121           }
25122           kw_args = PyDict_Size(__pyx_kwds);
25123           switch (pos_args) {
25124             case  0:
25125             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_data)) != 0)) kw_args--;
25126             else goto __pyx_L5_argtuple_error;
>>>     CID 1398507:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
25127             case  1:
25128             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
25129             else {
25130               __Pyx_RaiseArgtupleInvalid("aio_write", 0, 3, 4, 1); __PYX_ERR(0, 2353, __pyx_L3_error)
25131             }
25132             case  2:

** CID 1398508:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 22193 in __pyx_pw_3rbd_5Image_101lock_shared()


________________________________________________________________________________________________________
*** CID 1398508:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 22193 in __pyx_pw_3rbd_5Image_101lock_shared()
22187           }
22188           kw_args = PyDict_Size(__pyx_kwds);
22189           switch (pos_args) {
22190             case  0:
22191             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cookie)) != 0)) kw_args--;
22192             else goto __pyx_L5_argtuple_error;
>>>     CID 1398508:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
22193             case  1:
22194             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_tag)) != 0)) kw_args--;
22195             else {
22196               __Pyx_RaiseArgtupleInvalid("lock_shared", 1, 2, 2, 1); __PYX_ERR(0, 2130, __pyx_L3_error)
22197             }
22198           }

** CID 1398509:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25566 in __pyx_pw_3rbd_5Image_125aio_discard()


________________________________________________________________________________________________________
*** CID 1398509:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25566 in __pyx_pw_3rbd_5Image_125aio_discard()
25560             else goto __pyx_L5_argtuple_error;
25561             case  1:
25562             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
25563             else {
25564               __Pyx_RaiseArgtupleInvalid("aio_discard", 1, 3, 3, 1); __PYX_ERR(0, 2399, __pyx_L3_error)
25565             }
>>>     CID 1398509:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
25566             case  2:
25567             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete)) != 0)) kw_args--;
25568             else {
25569               __Pyx_RaiseArgtupleInvalid("aio_discard", 1, 3, 3, 2); __PYX_ERR(0, 2399, __pyx_L3_error)
25570             }
25571           }

** CID 1398510:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25137 in __pyx_pw_3rbd_5Image_123aio_write()


________________________________________________________________________________________________________
*** CID 1398510:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25137 in __pyx_pw_3rbd_5Image_123aio_write()
25131             }
25132             case  2:
25133             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete)) != 0)) kw_args--;
25134             else {
25135               __Pyx_RaiseArgtupleInvalid("aio_write", 0, 3, 4, 2); __PYX_ERR(0, 2353, __pyx_L3_error)
25136             }
>>>     CID 1398510:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
25137             case  3:
25138             if (kw_args > 0) {
25139               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_fadvise_flags);
25140               if (value) { values[3] = value; kw_args--; }
25141             }
25142           }

** CID 1398511:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24440 in __pyx_pw_3rbd_5Image_121aio_read()


________________________________________________________________________________________________________
*** CID 1398511:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24440 in __pyx_pw_3rbd_5Image_121aio_read()
24434           }
24435           kw_args = PyDict_Size(__pyx_kwds);
24436           switch (pos_args) {
24437             case  0:
24438             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
24439             else goto __pyx_L5_argtuple_error;
>>>     CID 1398511:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
24440             case  1:
24441             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
24442             else {
24443               __Pyx_RaiseArgtupleInvalid("aio_read", 0, 3, 4, 1); __PYX_ERR(0, 2298, __pyx_L3_error)
24444             }
24445             case  2:

** CID 1398512:  Performance inefficiencies  (PASS_BY_VALUE)
/usr/include/c++/6.2.1/bits/list.tcc: 484 in std::__cxx11::list<obj_watch_t, std::allocator<obj_watch_t>>::remove_if<librbd::<unnamed>::filter_out_mirror_watchers(librbd::ImageCtx *, std::__cxx11::list<obj_watch_t, std::allocator<obj_watch_t>>*)::[lambda(obj_watch_t &) (instance 1)]>(T1)()


________________________________________________________________________________________________________
*** CID 1398512:  Performance inefficiencies  (PASS_BY_VALUE)
/usr/include/c++/6.2.1/bits/list.tcc: 484 in std::__cxx11::list<obj_watch_t, std::allocator<obj_watch_t>>::remove_if<librbd::<unnamed>::filter_out_mirror_watchers(librbd::ImageCtx *, std::__cxx11::list<obj_watch_t, std::allocator<obj_watch_t>>*)::[lambda(obj_watch_t &) (instance 1)]>(T1)()
478         }
479     
480       template<typename _Tp, typename _Alloc>
481         template <typename _Predicate>
482           void
483           list<_Tp, _Alloc>::
>>>     CID 1398512:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter __pred of type "librbd::<unnamed>::filter_out_mirror_watchers(librbd::ImageCtx *, std::__cxx11::list<obj_watch_t, std::allocator<obj_watch_t> > *)::[lambda(obj_watch_t &) (instance 1)]" (size 280 bytes) by value.
484           remove_if(_Predicate __pred)
485           {
486             iterator __first = begin();
487             iterator __last = end();
488             while (__first != __last)
489     	  {

** CID 1398513:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 771 in LibRadosSnapshotsSelfManagedECPP_SnapPP_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 790 in LibRadosSnapshotsSelfManagedECPP_SnapPP_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1398513:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 771 in LibRadosSnapshotsSelfManagedECPP_SnapPP_Test::TestBody()()
765       bl1.append(buf, bsize);
766       ASSERT_EQ(0, ioctx.write("foo", bl1, bsize, 0));
767     
768       my_snaps.push_back(-2);
769       librados::AioCompletion *completion = cluster.aio_create_completion();
770       ioctx.aio_selfmanaged_snap_create(&my_snaps.back(), completion);
>>>     CID 1398513:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
771       ASSERT_EQ(0, completion->wait_for_complete());
772       completion->release();
773       ::std::reverse(my_snaps.begin(), my_snaps.end());
774       ASSERT_EQ(0, ioctx.selfmanaged_snap_set_write_ctx(my_snaps[0], my_snaps));
775       ::std::reverse(my_snaps.begin(), my_snaps.end());
776       char *buf2 = (char *)new char[bsize];
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 790 in LibRadosSnapshotsSelfManagedECPP_SnapPP_Test::TestBody()()
784       bufferlist bl3;
785       ASSERT_EQ(bsize, ioctx.read("foo", bl3, bsize*3, 0));
786       ASSERT_EQ(0, memcmp(bl3.c_str(), buf, bsize));
787     
788       completion = cluster.aio_create_completion();
789       ioctx.aio_selfmanaged_snap_remove(my_snaps.back(), completion);
>>>     CID 1398513:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
790       ASSERT_EQ(0, completion->wait_for_complete());
791       completion->release();
792       my_snaps.pop_back();
793       ASSERT_EQ(0, ioctx.selfmanaged_snap_remove(my_snaps.back()));
794       my_snaps.pop_back();
795       ioctx.snap_set_read(LIBRADOS_SNAP_HEAD);

** CID 1398514:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 183 in LibRadosSnapshotsSelfManaged_Snap_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 203 in LibRadosSnapshotsSelfManaged_Snap_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1398514:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 183 in LibRadosSnapshotsSelfManaged_Snap_Test::TestBody()()
177       char buf[bufsize];
178       memset(buf, 0xcc, sizeof(buf));
179       ASSERT_EQ(0, rados_write(ioctx, "foo", buf, sizeof(buf), 0));
180     
181       my_snaps.push_back(-2);
182       rados_completion_t completion;
>>>     CID 1398514:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
183       ASSERT_EQ(0, rados_aio_create_completion(nullptr, nullptr, nullptr,
184                                                &completion));
185       rados_aio_ioctx_selfmanaged_snap_create(ioctx, &my_snaps.back(), completion);
186       ASSERT_EQ(0, rados_aio_wait_for_complete(completion));
187       rados_aio_release(completion);
188       ::std::reverse(my_snaps.begin(), my_snaps.end());
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 203 in LibRadosSnapshotsSelfManaged_Snap_Test::TestBody()()
197       ASSERT_EQ(-ENOENT, rados_read(ioctx, "foo", buf3, sizeof(buf3), 0));
198     
199       rados_ioctx_snap_set_read(ioctx, my_snaps[1]);
200       ASSERT_EQ((int)sizeof(buf3), rados_read(ioctx, "foo", buf3, sizeof(buf3), 0));
201       ASSERT_EQ(0, memcmp(buf3, buf, sizeof(buf)));
202     
>>>     CID 1398514:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
203       ASSERT_EQ(0, rados_aio_create_completion(nullptr, nullptr, nullptr,
204                                                &completion));
205       rados_aio_ioctx_selfmanaged_snap_remove(ioctx, my_snaps.back(), completion);
206       ASSERT_EQ(0, rados_aio_wait_for_complete(completion));
207       rados_aio_release(completion);
208       my_snaps.pop_back();

** CID 1398515:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 681 in LibRadosSnapshotsSelfManagedEC_Snap_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 701 in LibRadosSnapshotsSelfManagedEC_Snap_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1398515:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 681 in LibRadosSnapshotsSelfManagedEC_Snap_Test::TestBody()()
675       char *buf = (char *)new char[bsize];
676       memset(buf, 0xcc, bsize);
677       ASSERT_EQ(0, rados_write(ioctx, "foo", buf, bsize, 0));
678     
679       my_snaps.push_back(-2);
680       rados_completion_t completion;
>>>     CID 1398515:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
681       ASSERT_EQ(0, rados_aio_create_completion(nullptr, nullptr, nullptr,
682                                                &completion));
683       rados_aio_ioctx_selfmanaged_snap_create(ioctx, &my_snaps.back(), completion);
684       ASSERT_EQ(0, rados_aio_wait_for_complete(completion));
685       rados_aio_release(completion);
686       ::std::reverse(my_snaps.begin(), my_snaps.end());
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 701 in LibRadosSnapshotsSelfManagedEC_Snap_Test::TestBody()()
695       ASSERT_EQ(-ENOENT, rados_read(ioctx, "foo", buf3, bsize*2, 0));
696     
697       rados_ioctx_snap_set_read(ioctx, my_snaps[1]);
698       ASSERT_EQ(bsize, rados_read(ioctx, "foo", buf3, bsize*2, 0));
699       ASSERT_EQ(0, memcmp(buf3, buf, bsize));
700     
>>>     CID 1398515:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
701       ASSERT_EQ(0, rados_aio_create_completion(nullptr, nullptr, nullptr,
702                                                &completion));
703       rados_aio_ioctx_selfmanaged_snap_remove(ioctx, my_snaps.back(), completion);
704       ASSERT_EQ(0, rados_aio_wait_for_complete(completion));
705       rados_aio_release(completion);
706       my_snaps.pop_back();

** CID 1398516:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 266 in LibRadosSnapshotsSelfManagedPP_SnapPP_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 284 in LibRadosSnapshotsSelfManagedPP_SnapPP_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1398516:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 266 in LibRadosSnapshotsSelfManagedPP_SnapPP_Test::TestBody()()
260       bl1.append(buf, sizeof(buf));
261       ASSERT_EQ(0, ioctx.write("foo", bl1, sizeof(buf), 0));
262     
263       my_snaps.push_back(-2);
264       librados::AioCompletion *completion = cluster.aio_create_completion();
265       ioctx.aio_selfmanaged_snap_create(&my_snaps.back(), completion);
>>>     CID 1398516:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
266       ASSERT_EQ(0, completion->wait_for_complete());
267       completion->release();
268       ::std::reverse(my_snaps.begin(), my_snaps.end());
269       ASSERT_EQ(0, ioctx.selfmanaged_snap_set_write_ctx(my_snaps[0], my_snaps));
270       ::std::reverse(my_snaps.begin(), my_snaps.end());
271       char buf2[sizeof(buf)];
/home/brad/working/src/ceph/src/test/librados/snapshots.cc: 284 in LibRadosSnapshotsSelfManagedPP_SnapPP_Test::TestBody()()
278       bufferlist bl3;
279       ASSERT_EQ((int)sizeof(buf), ioctx.read("foo", bl3, sizeof(buf), 0));
280       ASSERT_EQ(0, memcmp(bl3.c_str(), buf, sizeof(buf)));
281     
282       completion = cluster.aio_create_completion();
283       ioctx.aio_selfmanaged_snap_remove(my_snaps.back(), completion);
>>>     CID 1398516:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
284       ASSERT_EQ(0, completion->wait_for_complete());
285       completion->release();
286       my_snaps.pop_back();
287       ASSERT_EQ(0, ioctx.selfmanaged_snap_remove(my_snaps.back()));
288       my_snaps.pop_back();
289       ioctx.snap_set_read(LIBRADOS_SNAP_HEAD);

** CID 1398517:  Security best practices violations  (STRING_OVERFLOW)
/home/brad/working/src/ceph/src/test/librbd/exclusive_lock/test_mock_BreakRequest.cc: 55 in librbd::exclusive_lock::TestMockExclusiveLockBreakRequest::expect_list_watchers(librbd::<unnamed>::MockTestImageCtx &, int, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long)()


________________________________________________________________________________________________________
*** CID 1398517:  Security best practices violations  (STRING_OVERFLOW)
/home/brad/working/src/ceph/src/test/librbd/exclusive_lock/test_mock_BreakRequest.cc: 55 in librbd::exclusive_lock::TestMockExclusiveLockBreakRequest::expect_list_watchers(librbd::<unnamed>::MockTestImageCtx &, int, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long)()
49         auto &expect = EXPECT_CALL(get_mock_io_ctx(mock_image_ctx.md_ctx),
50                                    list_watchers(mock_image_ctx.header_oid, _));
51         if (r < 0) {
52           expect.WillOnce(Return(r));
53         } else {
54           obj_watch_t watcher;
>>>     CID 1398517:  Security best practices violations  (STRING_OVERFLOW)
>>>     You might overrun the 256-character fixed-size string "watcher.addr" by copying the return value of "c_str" without checking the length.
55           strcpy(watcher.addr, (address + ":0/0").c_str());
56           watcher.cookie = watch_handle;
57     
58           std::list<obj_watch_t> watchers;
59           watchers.push_back(watcher);
60     

** CID 1398518:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/exclusive_lock/BreakRequest.h: 75 in librbd::exclusive_lock::BreakRequest<librbd::<unnamed>::MockTestImageCtx>::BreakRequest(librbd::<unnamed>::MockTestImageCtx &, const librbd::exclusive_lock::Locker &, bool, bool, Context *)()
/home/brad/working/src/ceph/src/librbd/exclusive_lock/BreakRequest.h: 75 in librbd::exclusive_lock::BreakRequest<librbd::ImageCtx>::BreakRequest(librbd::ImageCtx &, const librbd::exclusive_lock::Locker &, bool, bool, Context *)()


________________________________________________________________________________________________________
*** CID 1398518:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/exclusive_lock/BreakRequest.h: 75 in librbd::exclusive_lock::BreakRequest<librbd::<unnamed>::MockTestImageCtx>::BreakRequest(librbd::<unnamed>::MockTestImageCtx &, const librbd::exclusive_lock::Locker &, bool, bool, Context *)()
69       BreakRequest(ImageCtxT &image_ctx, const Locker &locker,
70                    bool blacklist_locker, bool force_break_lock,
71                    Context *on_finish)
72         : m_image_ctx(image_ctx), m_locker(locker),
73           m_blacklist_locker(blacklist_locker),
74           m_force_break_lock(force_break_lock), m_on_finish(on_finish) {
>>>     CID 1398518:    (UNINIT_CTOR)
>>>     Non-static class member "m_watchers_ret_val" is not initialized in this constructor nor in any functions that it calls.
75       }
76     
77       void send_get_watchers();
78       void handle_get_watchers(int r);
79     
80       void send_blacklist();
/home/brad/working/src/ceph/src/librbd/exclusive_lock/BreakRequest.h: 75 in librbd::exclusive_lock::BreakRequest<librbd::ImageCtx>::BreakRequest(librbd::ImageCtx &, const librbd::exclusive_lock::Locker &, bool, bool, Context *)()
69       BreakRequest(ImageCtxT &image_ctx, const Locker &locker,
70                    bool blacklist_locker, bool force_break_lock,
71                    Context *on_finish)
72         : m_image_ctx(image_ctx), m_locker(locker),
73           m_blacklist_locker(blacklist_locker),
74           m_force_break_lock(force_break_lock), m_on_finish(on_finish) {
>>>     CID 1398518:    (UNINIT_CTOR)
>>>     Non-static class member "m_watchers_ret_val" is not initialized in this constructor nor in any functions that it calls.
75       }
76     
77       void send_get_watchers();
78       void handle_get_watchers(int r);
79     
80       void send_blacklist();

** CID 1398519:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librbd/exclusive_lock/test_mock_AcquireRequest.cc: 73 in librbd::exclusive_lock::GetLockerRequest<librbd::<unnamed>::MockTestImageCtx>::GetLockerRequest()()


________________________________________________________________________________________________________
*** CID 1398519:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librbd/exclusive_lock/test_mock_AcquireRequest.cc: 73 in librbd::exclusive_lock::GetLockerRequest<librbd::<unnamed>::MockTestImageCtx>::GetLockerRequest()()
67         s_instance->on_finish = on_finish;
68         return s_instance;
69       }
70     
71       GetLockerRequest() {
72         s_instance = this;
>>>     CID 1398519:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "on_finish" is not initialized in this constructor nor in any functions that it calls.
73       }
74     
75       MOCK_METHOD0(send, void());
76     };
77     
78     BreakRequest<librbd::MockTestImageCtx> *BreakRequest<librbd::MockTestImageCtx>::s_instance = nullptr;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GZX1JbV4p59iDYT3T-2FG3xR0QhHOyubCeQVFcE1DBLfv53DXk4NoNohCrs9QYfXU0zWv2XF-2FKoqp295uxOLTRCpKxpMW2tZXF3uCbwLxYtAUyAtjH6hrxN5XPuBdTxFr5owNjaS6EgpFqPII5BbJqTe4UjBAhJ54sYFHprvGWdNtDaumHWcZewzfofaWkSj-2Brk-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GZX1JbV4p59iDYT3T-2FG3xR0QhHOyubCeQVFcE1DBLfv5tpq4sKgD1ElADcbgVSD1YAAUuXE5iMZMIKUFKREcNcJhnW6rCU9bXwjQHObs33FNIpJStXJjP9YTOEzHAvyuimmhmteEzbQymTObDpWOjUeFB9W-2BSk60VpHG7zRgWVuheJi2P8mZZsnq-2BXnfUfRFo-3D

