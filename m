From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sat, 05 Mar 2016 09:55:03 -0800
Message-ID: <56db1d779c20a_3499abd33094453@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:50660 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbcCERzF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Mar 2016 12:55:05 -0500
Received: from localhost.localdomain (static-208.69.177.245.nephosdns.com [208.69.177.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtprelay.synopsys.com (Postfix) with ESMTPS id AD08F24E0331
	for <ceph-devel@vger.kernel.org>; Sat,  5 Mar 2016 09:55:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

72 new defect(s) introduced to ceph found with Coverity Scan.
29 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 72 defect(s)


** CID 1355178:    (BAD_SHIFT)
/common/strtol.cc: 173 in strict_si_cast<int>(const char *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*)()
/common/strtol.cc: 173 in strict_si_cast<int>(const char *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*)()
/common/strtol.cc: 173 in strict_si_cast<int>(const char *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*)()


________________________________________________________________________________________________________
*** CID 1355178:    (BAD_SHIFT)
/common/strtol.cc: 173 in strict_si_cast<int>(const char *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*)()
167         return 0;
168       }
169       if (ll < (long long)std::numeric_limits<T>::min() >> m) {
170         *err = "strict_sistrtoll: value seems to be too small";
171         return 0;
172       }
>>>     CID 1355178:    (BAD_SHIFT)
>>>     In expression "0x7fffffff >> m", right shifting by more than 31 bits has undefined behavior.  The shift amount, "m", is 40.
173       if (ll > std::numeric_limits<T>::max() >> m) {
174         *err = "strict_sistrtoll: value seems to be too large";
175         return 0;
176     
177       }
178       return (ll << m);
/common/strtol.cc: 173 in strict_si_cast<int>(const char *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*)()
167         return 0;
168       }
169       if (ll < (long long)std::numeric_limits<T>::min() >> m) {
170         *err = "strict_sistrtoll: value seems to be too small";
171         return 0;
172       }
>>>     CID 1355178:    (BAD_SHIFT)
>>>     In expression "0x7fffffff >> m", right shifting by more than 31 bits has undefined behavior.  The shift amount, "m", is 50.
173       if (ll > std::numeric_limits<T>::max() >> m) {
174         *err = "strict_sistrtoll: value seems to be too large";
175         return 0;
176     
177       }
178       return (ll << m);
/common/strtol.cc: 173 in strict_si_cast<int>(const char *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*)()
167         return 0;
168       }
169       if (ll < (long long)std::numeric_limits<T>::min() >> m) {
170         *err = "strict_sistrtoll: value seems to be too small";
171         return 0;
172       }
>>>     CID 1355178:    (BAD_SHIFT)
>>>     In expression "0x7fffffff >> m", right shifting by more than 31 bits has undefined behavior.  The shift amount, "m", is 60.
173       if (ll > std::numeric_limits<T>::max() >> m) {
174         *err = "strict_sistrtoll: value seems to be too large";
175         return 0;
176     
177       }
178       return (ll << m);

** CID 1355179:  Control flow issues  (DEADCODE)
/common/strtol.cc: 170 in strict_si_cast<unsigned long>(const char *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*)()


________________________________________________________________________________________________________
*** CID 1355179:  Control flow issues  (DEADCODE)
/common/strtol.cc: 170 in strict_si_cast<unsigned long>(const char *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*)()
164       long long ll = strict_strtoll(s.c_str(), 10, err);
165       if (ll < 0 && !std::numeric_limits<T>::is_signed) {
166         *err = "strict_sistrtoll: value should not be negative";
167         return 0;
168       }
169       if (ll < (long long)std::numeric_limits<T>::min() >> m) {
>>>     CID 1355179:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "(*err) = ("strict_sistrtoll...".
170         *err = "strict_sistrtoll: value seems to be too small";
171         return 0;
172       }
173       if (ll > std::numeric_limits<T>::max() >> m) {
174         *err = "strict_sistrtoll: value seems to be too large";
175         return 0;

** CID 1355180:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 1833 in __pyx_pw_6cephfs_1cstr()


________________________________________________________________________________________________________
*** CID 1355180:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 1833 in __pyx_pw_6cephfs_1cstr()
1827           }
1828           kw_args = PyDict_Size(__pyx_kwds);
1829           switch (pos_args) {
1830             case  0:
1831             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_val)) != 0)) kw_args--;
1832             else goto __pyx_L5_argtuple_error;
>>>     CID 1355180:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
1833             case  1:
1834             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_name)) != 0)) kw_args--;
1835             else {
1836               __Pyx_RaiseArgtupleInvalid("cstr", 0, 2, 4, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 238; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
1837             }
1838             case  2:

** CID 1355181:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 1838 in __pyx_pw_6cephfs_1cstr()


________________________________________________________________________________________________________
*** CID 1355181:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 1838 in __pyx_pw_6cephfs_1cstr()
1832             else goto __pyx_L5_argtuple_error;
1833             case  1:
1834             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_name)) != 0)) kw_args--;
1835             else {
1836               __Pyx_RaiseArgtupleInvalid("cstr", 0, 2, 4, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 238; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
1837             }
>>>     CID 1355181:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
1838             case  2:
1839             if (kw_args > 0) {
1840               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_encoding);
1841               if (value) { values[2] = value; kw_args--; }
1842             }
1843             case  3:

** CID 1355182:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 1843 in __pyx_pw_6cephfs_1cstr()


________________________________________________________________________________________________________
*** CID 1355182:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 1843 in __pyx_pw_6cephfs_1cstr()
1837             }
1838             case  2:
1839             if (kw_args > 0) {
1840               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_encoding);
1841               if (value) { values[2] = value; kw_args--; }
1842             }
>>>     CID 1355182:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
1843             case  3:
1844             if (kw_args > 0) {
1845               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_opt);
1846               if (value) { values[3] = value; kw_args--; }
1847             }
1848           }

** CID 1355183:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 2089 in __pyx_pw_6cephfs_3cstr_list()


________________________________________________________________________________________________________
*** CID 1355183:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 2089 in __pyx_pw_6cephfs_3cstr_list()
2083           }
2084           kw_args = PyDict_Size(__pyx_kwds);
2085           switch (pos_args) {
2086             case  0:
2087             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_list_str)) != 0)) kw_args--;
2088             else goto __pyx_L5_argtuple_error;
>>>     CID 1355183:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
2089             case  1:
2090             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_name)) != 0)) kw_args--;
2091             else {
2092               __Pyx_RaiseArgtupleInvalid("cstr_list", 0, 2, 3, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 259; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
2093             }
2094             case  2:

** CID 1355184:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 2094 in __pyx_pw_6cephfs_3cstr_list()


________________________________________________________________________________________________________
*** CID 1355184:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 2094 in __pyx_pw_6cephfs_3cstr_list()
2088             else goto __pyx_L5_argtuple_error;
2089             case  1:
2090             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_name)) != 0)) kw_args--;
2091             else {
2092               __Pyx_RaiseArgtupleInvalid("cstr_list", 0, 2, 3, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 259; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
2093             }
>>>     CID 1355184:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
2094             case  2:
2095             if (kw_args > 0) {
2096               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_encoding);
2097               if (value) { values[2] = value; kw_args--; }
2098             }
2099           }

** CID 1355185:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 2299 in __pyx_pw_6cephfs_5decode_cstr()


________________________________________________________________________________________________________
*** CID 1355185:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 2299 in __pyx_pw_6cephfs_5decode_cstr()
2293           }
2294           kw_args = PyDict_Size(__pyx_kwds);
2295           switch (pos_args) {
2296             case  0:
2297             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_val)) != 0)) kw_args--;
2298             else goto __pyx_L5_argtuple_error;
>>>     CID 1355185:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
2299             case  1:
2300             if (kw_args > 0) {
2301               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_encoding);
2302               if (value) { values[1] = value; kw_args--; }
2303             }
2304           }

** CID 1355186:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 4558 in __pyx_pw_6cephfs_9LibCephFS_17__exit__()


________________________________________________________________________________________________________
*** CID 1355186:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 4558 in __pyx_pw_6cephfs_9LibCephFS_17__exit__()
4552           }
4553           kw_args = PyDict_Size(__pyx_kwds);
4554           switch (pos_args) {
4555             case  0:
4556             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_type)) != 0)) kw_args--;
4557             else goto __pyx_L5_argtuple_error;
>>>     CID 1355186:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
4558             case  1:
4559             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_value)) != 0)) kw_args--;
4560             else {
4561               __Pyx_RaiseArgtupleInvalid("__exit__", 1, 3, 3, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 392; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
4562             }
4563             case  2:

** CID 1355187:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 4563 in __pyx_pw_6cephfs_9LibCephFS_17__exit__()


________________________________________________________________________________________________________
*** CID 1355187:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 4563 in __pyx_pw_6cephfs_9LibCephFS_17__exit__()
4557             else goto __pyx_L5_argtuple_error;
4558             case  1:
4559             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_value)) != 0)) kw_args--;
4560             else {
4561               __Pyx_RaiseArgtupleInvalid("__exit__", 1, 3, 3, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 392; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
4562             }
>>>     CID 1355187:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
4563             case  2:
4564             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_traceback)) != 0)) kw_args--;
4565             else {
4566               __Pyx_RaiseArgtupleInvalid("__exit__", 1, 3, 3, 2); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 392; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
4567             }
4568           }

** CID 1355188:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 5345 in __pyx_pw_6cephfs_9LibCephFS_25conf_set()


________________________________________________________________________________________________________
*** CID 1355188:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 5345 in __pyx_pw_6cephfs_9LibCephFS_25conf_set()
5339           }
5340           kw_args = PyDict_Size(__pyx_kwds);
5341           switch (pos_args) {
5342             case  0:
5343             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_option)) != 0)) kw_args--;
5344             else goto __pyx_L5_argtuple_error;
>>>     CID 1355188:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
5345             case  1:
5346             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_val)) != 0)) kw_args--;
5347             else {
5348               __Pyx_RaiseArgtupleInvalid("conf_set", 1, 2, 2, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 439; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
5349             }
5350           }

** CID 1355189:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 2874 in __pyx_pw_6cephfs_9LibCephFS_3__cinit__()


________________________________________________________________________________________________________
*** CID 1355189:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 2874 in __pyx_pw_6cephfs_9LibCephFS_3__cinit__()
2868           switch (pos_args) {
2869             case  0:
2870             if (kw_args > 0) {
2871               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_conf);
2872               if (value) { values[0] = value; kw_args--; }
2873             }
>>>     CID 1355189:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
2874             case  1:
2875             if (kw_args > 0) {
2876               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_conffile);
2877               if (value) { values[1] = value; kw_args--; }
2878             }
2879             case  2:

** CID 1355190:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 2879 in __pyx_pw_6cephfs_9LibCephFS_3__cinit__()


________________________________________________________________________________________________________
*** CID 1355190:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 2879 in __pyx_pw_6cephfs_9LibCephFS_3__cinit__()
2873             }
2874             case  1:
2875             if (kw_args > 0) {
2876               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_conffile);
2877               if (value) { values[1] = value; kw_args--; }
2878             }
>>>     CID 1355190:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
2879             case  2:
2880             if (kw_args > 0) {
2881               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_auth_id);
2882               if (value) { values[2] = value; kw_args--; }
2883             }
2884             case  3:

** CID 1355191:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 2884 in __pyx_pw_6cephfs_9LibCephFS_3__cinit__()


________________________________________________________________________________________________________
*** CID 1355191:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 2884 in __pyx_pw_6cephfs_9LibCephFS_3__cinit__()
2878             }
2879             case  2:
2880             if (kw_args > 0) {
2881               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_auth_id);
2882               if (value) { values[2] = value; kw_args--; }
2883             }
>>>     CID 1355191:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
2884             case  3:
2885             if (kw_args > 0) {
2886               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_rados_inst);
2887               if (value) { values[3] = value; kw_args--; }
2888             }
2889           }

** CID 1355192:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 7401 in __pyx_pw_6cephfs_9LibCephFS_45mkdir()


________________________________________________________________________________________________________
*** CID 1355192:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 7401 in __pyx_pw_6cephfs_9LibCephFS_45mkdir()
7395           }
7396           kw_args = PyDict_Size(__pyx_kwds);
7397           switch (pos_args) {
7398             case  0:
7399             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_path)) != 0)) kw_args--;
7400             else goto __pyx_L5_argtuple_error;
>>>     CID 1355192:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
7401             case  1:
7402             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_mode)) != 0)) kw_args--;
7403             else {
7404               __Pyx_RaiseArgtupleInvalid("mkdir", 1, 2, 2, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 557; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
7405             }
7406           }

** CID 1355193:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 7686 in __pyx_pw_6cephfs_9LibCephFS_47mkdirs()


________________________________________________________________________________________________________
*** CID 1355193:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 7686 in __pyx_pw_6cephfs_9LibCephFS_47mkdirs()
7680           }
7681           kw_args = PyDict_Size(__pyx_kwds);
7682           switch (pos_args) {
7683             case  0:
7684             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_path)) != 0)) kw_args--;
7685             else goto __pyx_L5_argtuple_error;
>>>     CID 1355193:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
7686             case  1:
7687             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_mode)) != 0)) kw_args--;
7688             else {
7689               __Pyx_RaiseArgtupleInvalid("mkdirs", 1, 2, 2, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 570; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
7690             }
7691           }

** CID 1355194:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 8140 in __pyx_pw_6cephfs_9LibCephFS_51open()


________________________________________________________________________________________________________
*** CID 1355194:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 8140 in __pyx_pw_6cephfs_9LibCephFS_51open()
8134           }
8135           kw_args = PyDict_Size(__pyx_kwds);
8136           switch (pos_args) {
8137             case  0:
8138             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_path)) != 0)) kw_args--;
8139             else goto __pyx_L5_argtuple_error;
>>>     CID 1355194:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8140             case  1:
8141             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_flags)) != 0)) kw_args--;
8142             else {
8143               __Pyx_RaiseArgtupleInvalid("open", 0, 2, 3, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 592; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
8144             }
8145             case  2:

** CID 1355195:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 8145 in __pyx_pw_6cephfs_9LibCephFS_51open()


________________________________________________________________________________________________________
*** CID 1355195:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 8145 in __pyx_pw_6cephfs_9LibCephFS_51open()
8139             else goto __pyx_L5_argtuple_error;
8140             case  1:
8141             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_flags)) != 0)) kw_args--;
8142             else {
8143               __Pyx_RaiseArgtupleInvalid("open", 0, 2, 3, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 592; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
8144             }
>>>     CID 1355195:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8145             case  2:
8146             if (kw_args > 0) {
8147               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_mode);
8148               if (value) { values[2] = value; kw_args--; }
8149             }
8150           }

** CID 1355196:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 8942 in __pyx_pw_6cephfs_9LibCephFS_55read()


________________________________________________________________________________________________________
*** CID 1355196:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 8942 in __pyx_pw_6cephfs_9LibCephFS_55read()
8936           }
8937           kw_args = PyDict_Size(__pyx_kwds);
8938           switch (pos_args) {
8939             case  0:
8940             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_fd)) != 0)) kw_args--;
8941             else goto __pyx_L5_argtuple_error;
>>>     CID 1355196:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8942             case  1:
8943             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
8944             else {
8945               __Pyx_RaiseArgtupleInvalid("read", 1, 3, 3, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 635; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
8946             }
8947             case  2:

** CID 1355197:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 8947 in __pyx_pw_6cephfs_9LibCephFS_55read()


________________________________________________________________________________________________________
*** CID 1355197:  Control flow issues  (MISSING_BREAK)
/build/cephfs.c: 8947 in __pyx_pw_6cephfs_9LibCephFS_55read()
8941             else goto __pyx_L5_argtuple_error;
8942             case  1:
8943             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
8944             else {
8945               __Pyx_RaiseArgtupleInvalid("read", 1, 3, 3, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 635; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
8946             }
>>>     CID 1355197:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
8947             case  2:
8948             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_l)) != 0)) kw_args--;
8949             else {
8950               __Pyx_RaiseArgtupleInvalid("read", 1, 3, 3, 2); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 635; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
8951             }
8952           }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/ceph?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c

