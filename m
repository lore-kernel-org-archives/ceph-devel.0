From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 16 Nov 2017 11:35:53 +0000 (UTC)
Message-ID: <5a0d781930362_7134ef531c69087@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.hv1nn.shared.sendgrid.net ([167.89.100.17]:55087 "EHLO
        o2.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757796AbdKPLfy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Nov 2017 06:35:54 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0022p1las1.sendgrid.net (SG) with ESMTP id bDIHNK36TlWJLmdL3tldRQ
        for <ceph-devel@vger.kernel.org>; Thu, 16 Nov 2017 11:35:53.418 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

68 new defect(s) introduced to ceph found with Coverity Scan.
17 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 68 defect(s)


** CID 1421246:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 29004 in __pyx_pw_3rbd_5Image_129aio_read()


________________________________________________________________________________________________________
*** CID 1421246:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 29004 in __pyx_pw_3rbd_5Image_129aio_read()
28998           }
28999           kw_args = PyDict_Size(__pyx_kwds);
29000           switch (pos_args) {
29001             case  0:
29002             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
29003             else goto __pyx_L5_argtuple_error;
>>>     CID 1421246:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
29004             case  1:
29005             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
29006             else {
29007               __Pyx_RaiseArgtupleInvalid("aio_read", 0, 3, 4, 1); __PYX_ERR(0, 2538, __pyx_L3_error)
29008             }
29009             case  2:

** CID 1421247:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/ceph_crypto.cc: 148 in main()


________________________________________________________________________________________________________
*** CID 1421247:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/ceph_crypto.cc: 148 in main()
142     #if GTEST_HAS_DEATH_TEST
143     TEST_F(ForkDeathTest, MD5) {
144       ASSERT_EXIT(do_simple_crypto(), ::testing::ExitedWithCode(0), "^$");
145     }
146     #endif //GTEST_HAS_DEATH_TEST
147     
>>>     CID 1421247:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
148     int main(int argc, char **argv) {
149       std::vector<const char*> args(argv, argv + argc);
150       env_to_vec(args);
151       auto cct = global_init(NULL, args,
152                              CEPH_ENTITY_TYPE_CLIENT,
153                              CODE_ENVIRONMENT_UTILITY,

** CID 1421248:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_authtool.cc: 53 in main()


________________________________________________________________________________________________________
*** CID 1421248:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_authtool.cc: 53 in main()
47            << "  --caps CAPSFILE               will set all of capabilities associated with a\n"
48            << "                                given key, for all subsystems"
49            << std::endl;
50       exit(1);
51     }
52     
>>>     CID 1421248:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
53     int main(int argc, const char **argv)
54     {
55       vector<const char*> args;
56       argv_to_vec(argc, argv, args);
57       env_to_vec(args);
58     

** CID 1421249:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/rbd_mirror/random_write.cc: 153 in main()


________________________________________________________________________________________________________
*** CID 1421249:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/rbd_mirror/random_write.cc: 153 in main()
147       }
148       b.wait_for(0);
149     }
150     
151     } // anonymous namespace
152     
>>>     CID 1421249:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
153     int main(int argc, const char **argv)
154     {
155       std::vector<const char*> args;
156       argv_to_vec(argc, argv, args);
157       env_to_vec(args);
158     

** CID 1421250:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_conf.cc: 164 in main()
/home/brad/working/src/ceph/src/tools/ceph_conf.cc: 164 in main()
/home/brad/working/src/ceph/src/tools/ceph_conf.cc: 164 in main()


________________________________________________________________________________________________________
*** CID 1421250:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_conf.cc: 164 in main()
158         cerr << "format '" << format << "' not recognized." << std::endl;
159         usage();
160         return 1;
161       }
162     }
163     
>>>     CID 1421250:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
164     int main(int argc, const char **argv)
165     {
166       vector<const char*> args;
167       deque<std::string> sections;
168       bool resolve_search = false;
169       std::string action;
/home/brad/working/src/ceph/src/tools/ceph_conf.cc: 164 in main()
158         cerr << "format '" << format << "' not recognized." << std::endl;
159         usage();
160         return 1;
161       }
162     }
163     
>>>     CID 1421250:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
164     int main(int argc, const char **argv)
165     {
166       vector<const char*> args;
167       deque<std::string> sections;
168       bool resolve_search = false;
169       std::string action;
/home/brad/working/src/ceph/src/tools/ceph_conf.cc: 164 in main()
158         cerr << "format '" << format << "' not recognized." << std::endl;
159         usage();
160         return 1;
161       }
162     }
163     
>>>     CID 1421250:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
164     int main(int argc, const char **argv)
165     {
166       vector<const char*> args;
167       deque<std::string> sections;
168       bool resolve_search = false;
169       std::string action;

** CID 1421251:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 26567 in __pyx_pw_3rbd_5Image_109lock_shared()


________________________________________________________________________________________________________
*** CID 1421251:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 26567 in __pyx_pw_3rbd_5Image_109lock_shared()
26561           }
26562           kw_args = PyDict_Size(__pyx_kwds);
26563           switch (pos_args) {
26564             case  0:
26565             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cookie)) != 0)) kw_args--;
26566             else goto __pyx_L5_argtuple_error;
>>>     CID 1421251:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
26567             case  1:
26568             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_tag)) != 0)) kw_args--;
26569             else {
26570               __Pyx_RaiseArgtupleInvalid("lock_shared", 1, 2, 2, 1); __PYX_ERR(0, 2370, __pyx_L3_error)
26571             }
26572           }

** CID 1421252:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 29741 in __pyx_pw_3rbd_5Image_131aio_write()


________________________________________________________________________________________________________
*** CID 1421252:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 29741 in __pyx_pw_3rbd_5Image_131aio_write()
29735             }
29736             case  2:
29737             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete)) != 0)) kw_args--;
29738             else {
29739               __Pyx_RaiseArgtupleInvalid("aio_write", 0, 3, 4, 2); __PYX_ERR(0, 2593, __pyx_L3_error)
29740             }
>>>     CID 1421252:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
29741             case  3:
29742             if (kw_args > 0) {
29743               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_fadvise_flags);
29744               if (value) { values[3] = value; kw_args--; }
29745             }
29746           }

** CID 1421253:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/test_mutate.cc: 41 in main()


________________________________________________________________________________________________________
*** CID 1421253:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/test_mutate.cc: 41 in main()
35     static void usage(void)
36     {
37       cerr << "--oid           set object id to 'operate' on" << std::endl;
38       cerr << "--pool          set pool to 'operate' on" << std::endl;
39     }
40     
>>>     CID 1421253:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
41     int main(int argc, const char **argv)
42     {
43       int ret = 0;
44       vector<const char*> args;
45       argv_to_vec(argc, argv, args);
46       env_to_vec(args);

** CID 1421254:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/ceph_syn.cc: 39 in main()


________________________________________________________________________________________________________
*** CID 1421254:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/ceph_syn.cc: 39 in main()
33     
34     #include <sys/types.h>
35     #include <fcntl.h>
36     
37     extern int syn_filer_flags;
38     
>>>     CID 1421254:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
39     int main(int argc, const char **argv, char *envp[]) 
40     {
41       //cerr << "ceph-syn starting" << std::endl;
42       vector<const char*> args;
43       argv_to_vec(argc, argv, args);
44     

** CID 1421255:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librgw_file_nfsns.cc: 1110 in main()


________________________________________________________________________________________________________
*** CID 1421255:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librgw_file_nfsns.cc: 1110 in main()
1104     }
1105     
1106     TEST(LibRGW, SHUTDOWN) {
1107       librgw_shutdown(rgw_h);
1108     }
1109     
>>>     CID 1421255:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
1110     int main(int argc, char *argv[])
1111     {
1112       char *v{nullptr};
1113       string val;
1114       vector<const char*> args;
1115     

** CID 1421256:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librgw_file_aw.cc: 359 in main()


________________________________________________________________________________________________________
*** CID 1421256:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librgw_file_aw.cc: 359 in main()
353     }
354     
355     TEST(LibRGW, SHUTDOWN) {
356       librgw_shutdown(rgw);
357     }
358     
>>>     CID 1421256:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
359     int main(int argc, char *argv[])
360     {
361       char *v{nullptr};
362       string val;
363       vector<const char*> args;
364     

** CID 1421257:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/rgw/rgw_token.cc: 60 in main()


________________________________________________________________________________________________________
*** CID 1421257:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/rgw/rgw_token.cc: 60 in main()
54            << std::endl;
55       cout << "\t <token type> := ad | ldap" << std::endl;
56       cout << "\n";
57       generic_client_usage();
58     }
59     
>>>     CID 1421257:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
60     int main(int argc, char **argv)
61     {
62       std::string val;
63       vector<const char*> args;
64       argv_to_vec(argc, (const char **)argv, args);
65       env_to_vec(args);

** CID 1421258:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/osdmaptool.cc: 88 in main()


________________________________________________________________________________________________________
*** CID 1421258:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/osdmaptool.cc: 88 in main()
82       if (r < 0) {
83         cerr << "error writing output: " << cpp_strerror(r) << std::endl;
84         exit(1);
85       }
86     }
87     
>>>     CID 1421258:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
88     int main(int argc, const char **argv)
89     {
90       vector<const char*> args;
91       argv_to_vec(argc, argv, args);
92       env_to_vec(args);
93     

** CID 1421259:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()


________________________________________________________________________________________________________
*** CID 1421259:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
30     
31     /*
32      * You only need to include this file if you are testing Ceph internal code. If
33      * you are testing library code, the library init() interfaces will handle
34      * initialization for you.
35      */
>>>     CID 1421259:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
36     int main(int argc, char **argv) {
37       std::vector<const char*> args(argv, argv + argc);
38       env_to_vec(args);
39       auto cct = global_init(NULL, args,
40     			 CEPH_ENTITY_TYPE_CLIENT,
41     			 CODE_ENVIRONMENT_UTILITY, 0);

** CID 1421260:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 29731 in __pyx_pw_3rbd_5Image_131aio_write()


________________________________________________________________________________________________________
*** CID 1421260:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 29731 in __pyx_pw_3rbd_5Image_131aio_write()
29725           }
29726           kw_args = PyDict_Size(__pyx_kwds);
29727           switch (pos_args) {
29728             case  0:
29729             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_data)) != 0)) kw_args--;
29730             else goto __pyx_L5_argtuple_error;
>>>     CID 1421260:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
29731             case  1:
29732             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
29733             else {
29734               __Pyx_RaiseArgtupleInvalid("aio_write", 0, 3, 4, 1); __PYX_ERR(0, 2593, __pyx_L3_error)
29735             }
29736             case  2:

** CID 1421261:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/messenger/simple_server.cc: 35 in main()


________________________________________________________________________________________________________
*** CID 1421261:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/messenger/simple_server.cc: 35 in main()
29     #include "common/address_helper.h"
30     #include "simple_dispatcher.h"
31     
32     #define dout_subsys ceph_subsys_simple_server
33     
34     
>>>     CID 1421261:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
35     int main(int argc, const char **argv)
36     {
37     	vector<const char*> args;
38     	Messenger *messenger;
39     	Dispatcher *dispatcher;
40     	std::vector<const char*>::iterator arg_iter;

** CID 1421262:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/messenger/simple_client.cc: 48 in main()


________________________________________________________________________________________________________
*** CID 1421262:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/messenger/simple_client.cc: 48 in main()
42     "  --msgs X\n"
43     "  --dsize X\n"
44         ;
45     }
46     
47     
>>>     CID 1421262:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
48     int main(int argc, const char **argv)
49     {
50     	vector<const char*> args;
51     	Messenger* messenger;
52     	SimpleDispatcher *dispatcher;
53     	std::vector<const char*>::iterator arg_iter;

** CID 1421263:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rbd_mirror/main.cc: 32 in main()


________________________________________________________________________________________________________
*** CID 1421263:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1421263:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       env_to_vec(args);
36       argv_to_vec(argc, argv, args);
37     

** CID 1421264:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librgw_file.cc: 241 in main()


________________________________________________________________________________________________________
*** CID 1421264:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librgw_file.cc: 241 in main()
235     }
236     
237     TEST(LibRGW, SHUTDOWN) {
238       librgw_shutdown(rgw);
239     }
240     
>>>     CID 1421264:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
241     int main(int argc, char *argv[])
242     {
243       char *v{nullptr};
244       string val;
245       vector<const char*> args;
246     

** CID 1421265:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/cephfs/cephfs-data-scan.cc: 11 in main()


________________________________________________________________________________________________________
*** CID 1421265:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/cephfs/cephfs-data-scan.cc: 11 in main()
5     #include "common/errno.h"
6     #include "global/global_init.h"
7     
8     #include "DataScan.h"
9     
10     
>>>     CID 1421265:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::out_of_range> >" is thrown and never caught.
11     int main(int argc, const char **argv)
12     {
13       vector<const char*> args;
14       argv_to_vec(argc, argv, args);
15       env_to_vec(args);
16     


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E0j-2FN8CctULgZy2RrAHjEqZmSoWrOeixNfRuq8H7eDNDULdzrTmjr2ShEAP-2F1kxV1qUeN12jlMD2Bo-2Bgls51n8gDcFArajccoJV52TbNC7TEDfQpDivNYJJIPQq7RBmiFwEfLInRswHm6kCExdXPd5IX2SLR-2Bzozs34Aa0SF-2Fj2MALav-2FClrlmXK7k15-2BV52E-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E0j-2FN8CctULgZy2RrAHjEqZmSoWrOeixNfRuq8H7eDNItC9jVBzs6SgHsgvIYltywTX6rGxNjRgxVa3vG3GC3T6o65wwVuJxRMKH2WxVTR6treM1JrVxZPRHTgS6ycTIxFugxNigpSLhH7s-2F6CqUx49L15Lf83nIBG4QoV81gp-2FQQlOhnPednO9tdU7hQb9XE-3D

