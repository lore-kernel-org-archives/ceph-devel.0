From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 09 Dec 2016 03:29:27 -0800
Message-ID: <584a959794961_6b917b531818e0@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:51156 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753453AbcLILdB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Dec 2016 06:33:01 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0003p1sjc2.sendgrid.net (SG) with ESMTP id KOWOI4WpQduVbFMVCZFsng
        for <ceph-devel@vger.kernel.org>; Fri, 09 Dec 2016 11:29:27.687 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

63 new defect(s) introduced to ceph found with Coverity Scan.
56 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 63 defect(s)


** CID 1396921:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 38132 in __pyx_pw_5rados_5Ioctx_93set_omap()


________________________________________________________________________________________________________
*** CID 1396921:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 38132 in __pyx_pw_5rados_5Ioctx_93set_omap()
38126           }
38127           kw_args = PyDict_Size(__pyx_kwds);
38128           switch (pos_args) {
38129             case  0:
38130             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_write_op)) != 0)) kw_args--;
38131             else goto __pyx_L5_argtuple_error;
>>>     CID 1396921:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
38132             case  1:
38133             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_keys)) != 0)) kw_args--;
38134             else {
38135               __Pyx_RaiseArgtupleInvalid("set_omap", 1, 3, 3, 1); __PYX_ERR(0, 3066, __pyx_L3_error)
38136             }
38137             case  2:

** CID 1396922:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 38824 in __pyx_pw_5rados_5Ioctx_97operate_aio_write_op()


________________________________________________________________________________________________________
*** CID 1396922:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 38824 in __pyx_pw_5rados_5Ioctx_97operate_aio_write_op()
38818           }
38819           kw_args = PyDict_Size(__pyx_kwds);
38820           switch (pos_args) {
38821             case  0:
38822             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_write_op)) != 0)) kw_args--;
38823             else goto __pyx_L5_argtuple_error;
>>>     CID 1396922:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
38824             case  1:
38825             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oid)) != 0)) kw_args--;
38826             else {
38827               __Pyx_RaiseArgtupleInvalid("operate_aio_write_op", 0, 2, 6, 1); __PYX_ERR(0, 3126, __pyx_L3_error)
38828             }
38829             case  2:

** CID 1396923:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 41380 in __pyx_pw_5rados_5Ioctx_113lock_exclusive()


________________________________________________________________________________________________________
*** CID 1396923:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 41380 in __pyx_pw_5rados_5Ioctx_113lock_exclusive()
41374             }
41375             case  3:
41376             if (kw_args > 0) {
41377               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_desc);
41378               if (value) { values[3] = value; kw_args--; }
41379             }
>>>     CID 1396923:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
41380             case  4:
41381             if (kw_args > 0) {
41382               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_duration);
41383               if (value) { values[4] = value; kw_args--; }
41384             }
41385             case  5:

** CID 1396924:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 35734 in __pyx_pw_5rados_5Ioctx_67set_xattr()


________________________________________________________________________________________________________
*** CID 1396924:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 35734 in __pyx_pw_5rados_5Ioctx_67set_xattr()
35728             else goto __pyx_L5_argtuple_error;
35729             case  1:
35730             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_xattr_name)) != 0)) kw_args--;
35731             else {
35732               __Pyx_RaiseArgtupleInvalid("set_xattr", 1, 3, 3, 1); __PYX_ERR(0, 2855, __pyx_L3_error)
35733             }
>>>     CID 1396924:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
35734             case  2:
35735             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_xattr_value)) != 0)) kw_args--;
35736             else {
35737               __Pyx_RaiseArgtupleInvalid("set_xattr", 1, 3, 3, 2); __PYX_ERR(0, 2855, __pyx_L3_error)
35738             }
35739           }

** CID 1396925:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 34553 in __pyx_pw_5rados_5Ioctx_59trunc()


________________________________________________________________________________________________________
*** CID 1396925:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 34553 in __pyx_pw_5rados_5Ioctx_59trunc()
34547           }
34548           kw_args = PyDict_Size(__pyx_kwds);
34549           switch (pos_args) {
34550             case  0:
34551             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_key)) != 0)) kw_args--;
34552             else goto __pyx_L5_argtuple_error;
>>>     CID 1396925:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
34553             case  1:
34554             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_size)) != 0)) kw_args--;
34555             else {
34556               __Pyx_RaiseArgtupleInvalid("trunc", 1, 2, 2, 1); __PYX_ERR(0, 2745, __pyx_L3_error)
34557             }
34558           }

** CID 1396926:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 33426 in __pyx_pw_5rados_5Ioctx_53execute()


________________________________________________________________________________________________________
*** CID 1396926:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 33426 in __pyx_pw_5rados_5Ioctx_53execute()
33420             }
33421             case  3:
33422             if (likely((values[3] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_data)) != 0)) kw_args--;
33423             else {
33424               __Pyx_RaiseArgtupleInvalid("execute", 0, 4, 5, 3); __PYX_ERR(0, 2614, __pyx_L3_error)
33425             }
>>>     CID 1396926:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
33426             case  4:
33427             if (kw_args > 0) {
33428               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length);
33429               if (value) { values[4] = value; kw_args--; }
33430             }
33431           }

** CID 1396927:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 39254 in __pyx_pw_5rados_5Ioctx_99operate_read_op()


________________________________________________________________________________________________________
*** CID 1396927:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 39254 in __pyx_pw_5rados_5Ioctx_99operate_read_op()
39248             else goto __pyx_L5_argtuple_error;
39249             case  1:
39250             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oid)) != 0)) kw_args--;
39251             else {
39252               __Pyx_RaiseArgtupleInvalid("operate_read_op", 0, 2, 3, 1); __PYX_ERR(0, 3168, __pyx_L3_error)
39253             }
>>>     CID 1396927:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
39254             case  2:
39255             if (kw_args > 0) {
39256               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_flag);
39257               if (value) { values[2] = value; kw_args--; }
39258             }
39259           }

** CID 1396928:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 38137 in __pyx_pw_5rados_5Ioctx_93set_omap()


________________________________________________________________________________________________________
*** CID 1396928:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 38137 in __pyx_pw_5rados_5Ioctx_93set_omap()
38131             else goto __pyx_L5_argtuple_error;
38132             case  1:
38133             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_keys)) != 0)) kw_args--;
38134             else {
38135               __Pyx_RaiseArgtupleInvalid("set_omap", 1, 3, 3, 1); __PYX_ERR(0, 3066, __pyx_L3_error)
38136             }
>>>     CID 1396928:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
38137             case  2:
38138             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_values)) != 0)) kw_args--;
38139             else {
38140               __Pyx_RaiseArgtupleInvalid("set_omap", 1, 3, 3, 2); __PYX_ERR(0, 3066, __pyx_L3_error)
38141             }
38142           }

** CID 1396929:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 41375 in __pyx_pw_5rados_5Ioctx_113lock_exclusive()


________________________________________________________________________________________________________
*** CID 1396929:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 41375 in __pyx_pw_5rados_5Ioctx_113lock_exclusive()
41369             }
41370             case  2:
41371             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cookie)) != 0)) kw_args--;
41372             else {
41373               __Pyx_RaiseArgtupleInvalid("lock_exclusive", 0, 3, 6, 2); __PYX_ERR(0, 3349, __pyx_L3_error)
41374             }
>>>     CID 1396929:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
41375             case  3:
41376             if (kw_args > 0) {
41377               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_desc);
41378               if (value) { values[3] = value; kw_args--; }
41379             }
41380             case  4:

** CID 1396930:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 39535 in __pyx_pw_5rados_5Ioctx_101operate_aio_read_op()


________________________________________________________________________________________________________
*** CID 1396930:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 39535 in __pyx_pw_5rados_5Ioctx_101operate_aio_read_op()
39529             else goto __pyx_L5_argtuple_error;
39530             case  1:
39531             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oid)) != 0)) kw_args--;
39532             else {
39533               __Pyx_RaiseArgtupleInvalid("operate_aio_read_op", 0, 2, 5, 1); __PYX_ERR(0, 3190, __pyx_L3_error)
39534             }
>>>     CID 1396930:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
39535             case  2:
39536             if (kw_args > 0) {
39537               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete);
39538               if (value) { values[2] = value; kw_args--; }
39539             }
39540             case  3:

** CID 1396931:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 39540 in __pyx_pw_5rados_5Ioctx_101operate_aio_read_op()


________________________________________________________________________________________________________
*** CID 1396931:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 39540 in __pyx_pw_5rados_5Ioctx_101operate_aio_read_op()
39534             }
39535             case  2:
39536             if (kw_args > 0) {
39537               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete);
39538               if (value) { values[2] = value; kw_args--; }
39539             }
>>>     CID 1396931:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
39540             case  3:
39541             if (kw_args > 0) {
39542               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_onsafe);
39543               if (value) { values[3] = value; kw_args--; }
39544             }
39545             case  4:

** CID 1396932:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 41385 in __pyx_pw_5rados_5Ioctx_113lock_exclusive()


________________________________________________________________________________________________________
*** CID 1396932:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 41385 in __pyx_pw_5rados_5Ioctx_113lock_exclusive()
41379             }
41380             case  4:
41381             if (kw_args > 0) {
41382               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_duration);
41383               if (value) { values[4] = value; kw_args--; }
41384             }
>>>     CID 1396932:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
41385             case  5:
41386             if (kw_args > 0) {
41387               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_flags);
41388               if (value) { values[5] = value; kw_args--; }
41389             }
41390           }

** CID 1396933:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 31693 in __pyx_pw_5rados_5Ioctx_45write()


________________________________________________________________________________________________________
*** CID 1396933:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 31693 in __pyx_pw_5rados_5Ioctx_45write()
31687             else goto __pyx_L5_argtuple_error;
31688             case  1:
31689             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_data)) != 0)) kw_args--;
31690             else {
31691               __Pyx_RaiseArgtupleInvalid("write", 0, 2, 3, 1); __PYX_ERR(0, 2467, __pyx_L3_error)
31692             }
>>>     CID 1396933:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
31693             case  2:
31694             if (kw_args > 0) {
31695               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset);
31696               if (value) { values[2] = value; kw_args--; }
31697             }
31698           }

** CID 1396934:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 38829 in __pyx_pw_5rados_5Ioctx_97operate_aio_write_op()


________________________________________________________________________________________________________
*** CID 1396934:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 38829 in __pyx_pw_5rados_5Ioctx_97operate_aio_write_op()
38823             else goto __pyx_L5_argtuple_error;
38824             case  1:
38825             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oid)) != 0)) kw_args--;
38826             else {
38827               __Pyx_RaiseArgtupleInvalid("operate_aio_write_op", 0, 2, 6, 1); __PYX_ERR(0, 3126, __pyx_L3_error)
38828             }
>>>     CID 1396934:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
38829             case  2:
38830             if (kw_args > 0) {
38831               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete);
38832               if (value) { values[2] = value; kw_args--; }
38833             }
38834             case  3:

** CID 1396935:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 32951 in __pyx_pw_5rados_5Ioctx_51read()


________________________________________________________________________________________________________
*** CID 1396935:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 32951 in __pyx_pw_5rados_5Ioctx_51read()
32945             else goto __pyx_L5_argtuple_error;
32946             case  1:
32947             if (kw_args > 0) {
32948               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length);
32949               if (value) { values[1] = value; kw_args--; }
32950             }
>>>     CID 1396935:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
32951             case  2:
32952             if (kw_args > 0) {
32953               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset);
32954               if (value) { values[2] = value; kw_args--; }
32955             }
32956           }

** CID 1396936:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 41365 in __pyx_pw_5rados_5Ioctx_113lock_exclusive()


________________________________________________________________________________________________________
*** CID 1396936:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 41365 in __pyx_pw_5rados_5Ioctx_113lock_exclusive()
41359           }
41360           kw_args = PyDict_Size(__pyx_kwds);
41361           switch (pos_args) {
41362             case  0:
41363             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_key)) != 0)) kw_args--;
41364             else goto __pyx_L5_argtuple_error;
>>>     CID 1396936:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
41365             case  1:
41366             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_name_2)) != 0)) kw_args--;
41367             else {
41368               __Pyx_RaiseArgtupleInvalid("lock_exclusive", 0, 3, 6, 1); __PYX_ERR(0, 3349, __pyx_L3_error)
41369             }
41370             case  2:

** CID 1396937:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 32531 in __pyx_pw_5rados_5Ioctx_49append()


________________________________________________________________________________________________________
*** CID 1396937:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 32531 in __pyx_pw_5rados_5Ioctx_49append()
32525           }
32526           kw_args = PyDict_Size(__pyx_kwds);
32527           switch (pos_args) {
32528             case  0:
32529             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_key)) != 0)) kw_args--;
32530             else goto __pyx_L5_argtuple_error;
>>>     CID 1396937:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
32531             case  1:
32532             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_data)) != 0)) kw_args--;
32533             else {
32534               __Pyx_RaiseArgtupleInvalid("append", 1, 2, 2, 1); __PYX_ERR(0, 2538, __pyx_L3_error)
32535             }
32536           }

** CID 1396938:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 39545 in __pyx_pw_5rados_5Ioctx_101operate_aio_read_op()


________________________________________________________________________________________________________
*** CID 1396938:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 39545 in __pyx_pw_5rados_5Ioctx_101operate_aio_read_op()
39539             }
39540             case  3:
39541             if (kw_args > 0) {
39542               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_onsafe);
39543               if (value) { values[3] = value; kw_args--; }
39544             }
>>>     CID 1396938:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
39545             case  4:
39546             if (kw_args > 0) {
39547               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_flag);
39548               if (value) { values[4] = value; kw_args--; }
39549             }
39550           }

** CID 1396939:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 40329 in __pyx_pw_5rados_5Ioctx_105get_omap_keys()


________________________________________________________________________________________________________
*** CID 1396939:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 40329 in __pyx_pw_5rados_5Ioctx_105get_omap_keys()
40323             else goto __pyx_L5_argtuple_error;
40324             case  1:
40325             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_start_after)) != 0)) kw_args--;
40326             else {
40327               __Pyx_RaiseArgtupleInvalid("get_omap_keys", 1, 3, 3, 1); __PYX_ERR(0, 3256, __pyx_L3_error)
40328             }
>>>     CID 1396939:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
40329             case  2:
40330             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_max_return)) != 0)) kw_args--;
40331             else {
40332               __Pyx_RaiseArgtupleInvalid("get_omap_keys", 1, 3, 3, 2); __PYX_ERR(0, 3256, __pyx_L3_error)
40333             }
40334           }

** CID 1396940:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 42551 in __pyx_pw_5rados_5Ioctx_117unlock()


________________________________________________________________________________________________________
*** CID 1396940:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 42551 in __pyx_pw_5rados_5Ioctx_117unlock()
42545           }
42546           kw_args = PyDict_Size(__pyx_kwds);
42547           switch (pos_args) {
42548             case  0:
42549             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_key)) != 0)) kw_args--;
42550             else goto __pyx_L5_argtuple_error;
>>>     CID 1396940:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
42551             case  1:
42552             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_name_2)) != 0)) kw_args--;
42553             else {
42554               __Pyx_RaiseArgtupleInvalid("unlock", 1, 3, 3, 1); __PYX_ERR(0, 3453, __pyx_L3_error)
42555             }
42556             case  2:


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Hd0C1yAhYLb22f6o9wAmve2fEeIz02AMBDg8oR8mkf9-2BXdU60d8KwPO65vKVmektJzP3sgthKROqNEXl2RGAbBrB6UaKDxoUJw-2FQdFXWETnD0U2HE1GpRMtPkOzCq-2Bs8RMFPosIT1iJs9CtlEWQu4uI0yALovJ0KAb4-2FBYGB57jWFhQYEYy4IO-2B9oLeDtrHc0-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Hd0C1yAhYLb22f6o9wAmve2fEeIz02AMBDg8oR8mkf980R3Y-2FbAmkHRZ4mu60R4ob1iksRD6ANkt-2B-2F-2FaG14P4ztBpmJcCCl-2BmetB4lEHjsa-2Ff3JXgCq1k3ZmXt1v68R4jF5JsomMlTt9Wm4LRSLrFGrwz9tf8m3KIm-2BnQp4DnuKdQOSW1BJQo1vs5S-2BlBC5EM-3D

