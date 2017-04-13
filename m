From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Wed, 12 Apr 2017 23:25:25 -0700
Message-ID: <58ef19d5d461b_21e272f330517e0@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.24nn.shared.sendgrid.net ([167.89.100.237]:11235 "EHLO
        o1.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755882AbdDMGZ1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 13 Apr 2017 02:25:27 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0003p1las1.sendgrid.net (SG) with ESMTP id 42mP6wfVSVeAAmaJM1mqug
        for <ceph-devel@vger.kernel.org>; Thu, 13 Apr 2017 06:25:26.112 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

52 new defect(s) introduced to ceph found with Coverity Scan.
43 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 52 defect(s)


** CID 1313369:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/osd/OSD.cc: 3156 in OSD::clear_temp_objects()()


________________________________________________________________________________________________________
*** CID 1313369:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/osd/OSD.cc: 3156 in OSD::clear_temp_objects()()
3150     }
3151     
3152     void OSD::clear_temp_objects()
3153     {
3154       dout(10) << __func__ << dendl;
3155       vector<coll_t> ls;
>>>     CID 1313369:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "list_collections" without checking return value (as is done elsewhere 9 out of 11 times).
3156       store->list_collections(ls);
3157       for (vector<coll_t>::iterator p = ls.begin(); p != ls.end(); ++p) {
3158         spg_t pgid;
3159         if (!p->is_pg(&pgid))
3160           continue;
3161     

** CID 1405048:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/os/FuseStore.cc: 408 in os_readdir(const char *, void *, int (*)(void *, const char *, const stat *, long), long, fuse_file_info *)()


________________________________________________________________________________________________________
*** CID 1405048:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/os/FuseStore.cc: 408 in os_readdir(const char *, void *, int (*)(void *, const char *, const stat *, long), long, fuse_file_info *)()
402     
403       switch (t) {
404       case FN_ROOT:
405         {
406           filler(buf, "type", NULL, 0);
407           vector<coll_t> cls;
>>>     CID 1405048:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "list_collections" without checking return value (as is done elsewhere 9 out of 11 times).
408           fs->store->list_collections(cls);
409           for (auto c : cls) {
410     	int r = filler(buf, stringify(c).c_str(), NULL, 0);
411     	if (r > 0)
412     	  break;
413           }

** CID 1405049:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/OpenRequest.cc: 215 in librbd::image::OpenRequest<librbd::ImageCtx>::send_v2_get_name_from_trash()()


________________________________________________________________________________________________________
*** CID 1405049:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/OpenRequest.cc: 215 in librbd::image::OpenRequest<librbd::ImageCtx>::send_v2_get_name_from_trash()()
209       cls_client::trash_get_start(&op, m_image_ctx->id);
210     
211       using klass = OpenRequest<I>;
212       librados::AioCompletion *comp = create_rados_callback<
213         klass, &klass::handle_v2_get_name_from_trash>(this);
214       m_out_bl.clear();
>>>     CID 1405049:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "aio_operate" without checking return value (as is done elsewhere 56 out of 69 times).
215       m_image_ctx->md_ctx.aio_operate(RBD_TRASH, comp, &op, &m_out_bl);
216       comp->release();
217     }
218     
219     template <typename I>
220     Context *OpenRequest<I>::handle_v2_get_name_from_trash(int *result) {

** CID 1405050:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/tools/rbd/Utils.cc: 323 in rbd::utils::get_pool_image_id(const boost::program_options::variables_map &, unsigned long *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *)()


________________________________________________________________________________________________________
*** CID 1405050:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/tools/rbd/Utils.cc: 323 in rbd::utils::get_pool_image_id(const boost::program_options::variables_map &, unsigned long *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *)()
317           if (r < 0) {
318             return r;
319           }
320         }
321       }
322     
>>>     CID 1405050:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "pool_name" to "empty", which dereferences it. [Note: The source code implementation of the function has been overridden by a builtin model.]
323       if (pool_name->empty()) {
324         *pool_name = at::DEFAULT_POOL_NAME;
325       }
326     
327       if (image_id != nullptr && image_id->empty()) {
328         std::cerr << "rbd: image id was not specified" << std::endl;

** CID 1405051:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 4244 in memset_rand(char *, unsigned long)()


________________________________________________________________________________________________________
*** CID 1405051:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 4244 in memset_rand(char *, unsigned long)()
4238       ASSERT_EQ(0, image1.snap_set(NULL));
4239       ASSERT_PASSED(validate_object_map, image1);
4240     }
4241     
4242     void memset_rand(char *buf, size_t len) {
4243       for (size_t i = 0; i < len; ++i) {
>>>     CID 1405051:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
4244         buf[i] = (char) (rand() % (126 - 33) + 33);
4245       }
4246     }
4247     
4248     TEST_F(TestLibRBD, Metadata)
4249     {

** CID 1405052:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 28021 in __pyx_pw_3rbd_5Image_133metadata_set()


________________________________________________________________________________________________________
*** CID 1405052:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 28021 in __pyx_pw_3rbd_5Image_133metadata_set()
28015           }
28016           kw_args = PyDict_Size(__pyx_kwds);
28017           switch (pos_args) {
28018             case  0:
28019             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_key)) != 0)) kw_args--;
28020             else goto __pyx_L5_argtuple_error;
>>>     CID 1405052:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
28021             case  1:
28022             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_value)) != 0)) kw_args--;
28023             else {
28024               __Pyx_RaiseArgtupleInvalid("metadata_set", 1, 2, 2, 1); __PYX_ERR(0, 2591, __pyx_L3_error)
28025             }
28026           }

** CID 1405053:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9001 in __pyx_pw_3rbd_3RBD_27mirror_peer_remove()


________________________________________________________________________________________________________
*** CID 1405053:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9001 in __pyx_pw_3rbd_3RBD_27mirror_peer_remove()
8995             else goto __pyx_L5_argtuple_error;
8996             case  1:
8997             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
8998             else {
8999               __Pyx_RaiseArgtupleInvalid("mirror_peer_remove", 1, 3, 3, 1); __PYX_ERR(0, 1017, __pyx_L3_error)
9000             }
>>>     CID 1405053:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
9001             case  2:
9002             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_uuid)) != 0)) kw_args--;
9003             else {
9004               __Pyx_RaiseArgtupleInvalid("mirror_peer_remove", 1, 3, 3, 2); __PYX_ERR(0, 1017, __pyx_L3_error)
9005             }
9006           }

** CID 1405054:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8360 in __pyx_pw_3rbd_3RBD_23mirror_mode_set()


________________________________________________________________________________________________________
*** CID 1405054:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8360 in __pyx_pw_3rbd_3RBD_23mirror_mode_set()
8354             else goto __pyx_L5_argtuple_error;
8355             case  1:
8356             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
8357             else {
8358               __Pyx_RaiseArgtupleInvalid("mirror_mode_set", 1, 3, 3, 1); __PYX_ERR(0, 970, __pyx_L3_error)
8359             }
>>>     CID 1405054:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8360             case  2:
8361             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_mirror_mode)) != 0)) kw_args--;
8362             else {
8363               __Pyx_RaiseArgtupleInvalid("mirror_mode_set", 1, 3, 3, 2); __PYX_ERR(0, 970, __pyx_L3_error)
8364             }
8365           }

** CID 1405055:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9999 in __pyx_pw_3rbd_3RBD_35mirror_image_status_list()


________________________________________________________________________________________________________
*** CID 1405055:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9999 in __pyx_pw_3rbd_3RBD_35mirror_image_status_list()
9993           }
9994           kw_args = PyDict_Size(__pyx_kwds);
9995           switch (pos_args) {
9996             case  0:
9997             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_self)) != 0)) kw_args--;
9998             else goto __pyx_L5_argtuple_error;
>>>     CID 1405055:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
9999             case  1:
10000             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
10001             else {
10002               __Pyx_RaiseArgtupleInvalid("mirror_image_status_list", 1, 2, 2, 1); __PYX_ERR(0, 1089, __pyx_L3_error)
10003             }
10004           }

** CID 1405056:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8577 in __pyx_pw_3rbd_3RBD_25mirror_peer_add()


________________________________________________________________________________________________________
*** CID 1405056:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8577 in __pyx_pw_3rbd_3RBD_25mirror_peer_add()
8571             }
8572             case  2:
8573             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cluster_name)) != 0)) kw_args--;
8574             else {
8575               __Pyx_RaiseArgtupleInvalid("mirror_peer_add", 1, 4, 4, 2); __PYX_ERR(0, 987, __pyx_L3_error)
8576             }
>>>     CID 1405056:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8577             case  3:
8578             if (likely((values[3] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_client_name)) != 0)) kw_args--;
8579             else {
8580               __Pyx_RaiseArgtupleInvalid("mirror_peer_add", 1, 4, 4, 3); __PYX_ERR(0, 987, __pyx_L3_error)
8581             }
8582           }

** CID 1405057:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9250 in __pyx_pw_3rbd_3RBD_29mirror_peer_list()


________________________________________________________________________________________________________
*** CID 1405057:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9250 in __pyx_pw_3rbd_3RBD_29mirror_peer_list()
9244           }
9245           kw_args = PyDict_Size(__pyx_kwds);
9246           switch (pos_args) {
9247             case  0:
9248             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_self)) != 0)) kw_args--;
9249             else goto __pyx_L5_argtuple_error;
>>>     CID 1405057:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
9250             case  1:
9251             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
9252             else {
9253               __Pyx_RaiseArgtupleInvalid("mirror_peer_list", 1, 2, 2, 1); __PYX_ERR(0, 1035, __pyx_L3_error)
9254             }
9255           }

** CID 1405058:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8355 in __pyx_pw_3rbd_3RBD_23mirror_mode_set()


________________________________________________________________________________________________________
*** CID 1405058:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8355 in __pyx_pw_3rbd_3RBD_23mirror_mode_set()
8349           }
8350           kw_args = PyDict_Size(__pyx_kwds);
8351           switch (pos_args) {
8352             case  0:
8353             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_self)) != 0)) kw_args--;
8354             else goto __pyx_L5_argtuple_error;
>>>     CID 1405058:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8355             case  1:
8356             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
8357             else {
8358               __Pyx_RaiseArgtupleInvalid("mirror_mode_set", 1, 3, 3, 1); __PYX_ERR(0, 970, __pyx_L3_error)
8359             }
8360             case  2:

** CID 1405059:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9696 in __pyx_pw_3rbd_3RBD_33mirror_peer_set_cluster()


________________________________________________________________________________________________________
*** CID 1405059:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9696 in __pyx_pw_3rbd_3RBD_33mirror_peer_set_cluster()
9690             }
9691             case  2:
9692             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_uuid)) != 0)) kw_args--;
9693             else {
9694               __Pyx_RaiseArgtupleInvalid("mirror_peer_set_cluster", 1, 4, 4, 2); __PYX_ERR(0, 1067, __pyx_L3_error)
9695             }
>>>     CID 1405059:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
9696             case  3:
9697             if (likely((values[3] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cluster_name)) != 0)) kw_args--;
9698             else {
9699               __Pyx_RaiseArgtupleInvalid("mirror_peer_set_cluster", 1, 4, 4, 3); __PYX_ERR(0, 1067, __pyx_L3_error)
9700             }
9701           }

** CID 1405060:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9686 in __pyx_pw_3rbd_3RBD_33mirror_peer_set_cluster()


________________________________________________________________________________________________________
*** CID 1405060:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9686 in __pyx_pw_3rbd_3RBD_33mirror_peer_set_cluster()
9680           }
9681           kw_args = PyDict_Size(__pyx_kwds);
9682           switch (pos_args) {
9683             case  0:
9684             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_self)) != 0)) kw_args--;
9685             else goto __pyx_L5_argtuple_error;
>>>     CID 1405060:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
9686             case  1:
9687             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
9688             else {
9689               __Pyx_RaiseArgtupleInvalid("mirror_peer_set_cluster", 1, 4, 4, 1); __PYX_ERR(0, 1067, __pyx_L3_error)
9690             }
9691             case  2:

** CID 1405061:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9369 in __pyx_pw_3rbd_3RBD_31mirror_peer_set_client()


________________________________________________________________________________________________________
*** CID 1405061:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9369 in __pyx_pw_3rbd_3RBD_31mirror_peer_set_client()
9363           }
9364           kw_args = PyDict_Size(__pyx_kwds);
9365           switch (pos_args) {
9366             case  0:
9367             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_self)) != 0)) kw_args--;
9368             else goto __pyx_L5_argtuple_error;
>>>     CID 1405061:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
9369             case  1:
9370             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
9371             else {
9372               __Pyx_RaiseArgtupleInvalid("mirror_peer_set_client", 1, 4, 4, 1); __PYX_ERR(0, 1045, __pyx_L3_error)
9373             }
9374             case  2:

** CID 1405062:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9374 in __pyx_pw_3rbd_3RBD_31mirror_peer_set_client()


________________________________________________________________________________________________________
*** CID 1405062:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 9374 in __pyx_pw_3rbd_3RBD_31mirror_peer_set_client()
9368             else goto __pyx_L5_argtuple_error;
9369             case  1:
9370             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
9371             else {
9372               __Pyx_RaiseArgtupleInvalid("mirror_peer_set_client", 1, 4, 4, 1); __PYX_ERR(0, 1045, __pyx_L3_error)
9373             }
>>>     CID 1405062:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
9374             case  2:
9375             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_uuid)) != 0)) kw_args--;
9376             else {
9377               __Pyx_RaiseArgtupleInvalid("mirror_peer_set_client", 1, 4, 4, 2); __PYX_ERR(0, 1045, __pyx_L3_error)
9378             }
9379             case  3:

** CID 1405063:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8572 in __pyx_pw_3rbd_3RBD_25mirror_peer_add()


________________________________________________________________________________________________________
*** CID 1405063:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8572 in __pyx_pw_3rbd_3RBD_25mirror_peer_add()
8566             else goto __pyx_L5_argtuple_error;
8567             case  1:
8568             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
8569             else {
8570               __Pyx_RaiseArgtupleInvalid("mirror_peer_add", 1, 4, 4, 1); __PYX_ERR(0, 987, __pyx_L3_error)
8571             }
>>>     CID 1405063:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8572             case  2:
8573             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cluster_name)) != 0)) kw_args--;
8574             else {
8575               __Pyx_RaiseArgtupleInvalid("mirror_peer_add", 1, 4, 4, 2); __PYX_ERR(0, 987, __pyx_L3_error)
8576             }
8577             case  3:

** CID 1405064:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8151 in __pyx_pw_3rbd_3RBD_21mirror_mode_get()


________________________________________________________________________________________________________
*** CID 1405064:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8151 in __pyx_pw_3rbd_3RBD_21mirror_mode_get()
8145           }
8146           kw_args = PyDict_Size(__pyx_kwds);
8147           switch (pos_args) {
8148             case  0:
8149             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_self)) != 0)) kw_args--;
8150             else goto __pyx_L5_argtuple_error;
>>>     CID 1405064:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8151             case  1:
8152             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
8153             else {
8154               __Pyx_RaiseArgtupleInvalid("mirror_mode_get", 1, 2, 2, 1); __PYX_ERR(0, 953, __pyx_L3_error)
8155             }
8156           }

** CID 1405065:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 10114 in __pyx_pw_3rbd_3RBD_37mirror_image_status_summary()


________________________________________________________________________________________________________
*** CID 1405065:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 10114 in __pyx_pw_3rbd_3RBD_37mirror_image_status_summary()
10108           }
10109           kw_args = PyDict_Size(__pyx_kwds);
10110           switch (pos_args) {
10111             case  0:
10112             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_self)) != 0)) kw_args--;
10113             else goto __pyx_L5_argtuple_error;
>>>     CID 1405065:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
10114             case  1:
10115             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
10116             else {
10117               __Pyx_RaiseArgtupleInvalid("mirror_image_status_summary", 1, 2, 2, 1); __PYX_ERR(0, 1099, __pyx_L3_error)
10118             }
10119           }

** CID 1405066:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8996 in __pyx_pw_3rbd_3RBD_27mirror_peer_remove()


________________________________________________________________________________________________________
*** CID 1405066:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 8996 in __pyx_pw_3rbd_3RBD_27mirror_peer_remove()
8990           }
8991           kw_args = PyDict_Size(__pyx_kwds);
8992           switch (pos_args) {
8993             case  0:
8994             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_self)) != 0)) kw_args--;
8995             else goto __pyx_L5_argtuple_error;
>>>     CID 1405066:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8996             case  1:
8997             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_ioctx)) != 0)) kw_args--;
8998             else {
8999               __Pyx_RaiseArgtupleInvalid("mirror_peer_remove", 1, 3, 3, 1); __PYX_ERR(0, 1017, __pyx_L3_error)
9000             }
9001             case  2:


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HEU8MtG2JUIESx2-2Bsif-2BPmVM1Ko-2BS4lJ-2FgAMtxb6GDj-2BabyFOjyyZAni0rQQF1KNqyoWyqb5UsWbi4pt9SZHE4hXQQ1n1BOAYgZYMMzeY0cTVRVnUdPEB-2Br8eBD2BeCKOIHPju-2BMXcBkIPkIEKsNz5FSaxGzqrvxp0u-2BCHsoNEonJiUJMNSHOx2pAo9QYp0xU-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HEU8MtG2JUIESx2-2Bsif-2BPmVM1Ko-2BS4lJ-2FgAMtxb6GDjyTt0kOBmUqWGnfpKZfvAQ0x1eruOypRYt-2FhKS9hLIRIvo-2BxOcfkZRusdQizKiUIMtjuvbAHFpziV1ND8KDvwtKpluulBuzYxZhzMsGNonKRKNYOxl4ah2uVFEAgGiTUOA7abEwSuhbQV3wdxryh2Ik-3D

