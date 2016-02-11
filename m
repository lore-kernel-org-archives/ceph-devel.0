From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 11 Feb 2016 09:57:05 -0800
Message-ID: <56bccb71750ff_105ef2d3209258f@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:50381 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbcBKSCk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Feb 2016 13:02:40 -0500
Received: from localhost.localdomain (static-208.69.177.245.nephosdns.com [208.69.177.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtprelay.synopsys.com (Postfix) with ESMTPS id 2C8491E05E9
	for <ceph-devel@vger.kernel.org>; Thu, 11 Feb 2016 18:56:52 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

28 new defect(s) introduced to ceph found with Coverity Scan.
106 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 28 defect(s)


** CID 1352097:  Control flow issues  (UNREACHABLE)
/common/shunique_lock.h: 326 in ceph::shunique_lock<boost::shared_mutex>::release_to_unique()()


________________________________________________________________________________________________________
*** CID 1352097:  Control flow issues  (UNREACHABLE)
/common/shunique_lock.h: 326 in ceph::shunique_lock<boost::shared_mutex>::release_to_unique()()
320           return tu;
321         } else if (m == nullptr) {
322           return unique_lock_type();
323         }
324         throw std::system_error((int)std::errc::operation_not_permitted,
325     			    std::generic_category());
>>>     CID 1352097:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "return ceph::shunique_lock<...".
326         return unique_lock_type();
327       }
328     
329       shared_lock_type release_to_shared() {
330         if (o == ownership::shared) {
331           o = ownership::none;

** CID 1352096:    (UNCAUGHT_EXCEPT)
/test/rbd_mirror/test_main.cc: 14 in main()
/test/rbd_mirror/test_main.cc: 14 in main()


________________________________________________________________________________________________________
*** CID 1352096:    (UNCAUGHT_EXCEPT)
/test/rbd_mirror/test_main.cc: 14 in main()
8     #include <iostream>
9     #include <string>
10     
11     extern void register_test_cluster_watcher();
12     extern void register_test_pool_watcher();
13     
>>>     CID 1352096:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
14     int main(int argc, char **argv)
15     {
16       register_test_cluster_watcher();
17       register_test_pool_watcher();
18     
19       ::testing::InitGoogleTest(&argc, argv);
/test/rbd_mirror/test_main.cc: 14 in main()
8     #include <iostream>
9     #include <string>
10     
11     extern void register_test_cluster_watcher();
12     extern void register_test_pool_watcher();
13     
>>>     CID 1352096:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
14     int main(int argc, char **argv)
15     {
16       register_test_cluster_watcher();
17       register_test_pool_watcher();
18     
19       ::testing::InitGoogleTest(&argc, argv);

** CID 1352095:    (UNCAUGHT_EXCEPT)
/tools/cephfs/cephfs-table-tool.cc: 11 in main()
/tools/cephfs/cephfs-table-tool.cc: 11 in main()


________________________________________________________________________________________________________
*** CID 1352095:    (UNCAUGHT_EXCEPT)
/tools/cephfs/cephfs-table-tool.cc: 11 in main()
5     #include "common/errno.h"
6     #include "global/global_init.h"
7     
8     #include "TableTool.h"
9     
10     
>>>     CID 1352095:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
11     int main(int argc, const char **argv)
12     {
13       vector<const char*> args;
14       argv_to_vec(argc, argv, args);
15       env_to_vec(args);
16     
/tools/cephfs/cephfs-table-tool.cc: 11 in main()
5     #include "common/errno.h"
6     #include "global/global_init.h"
7     
8     #include "TableTool.h"
9     
10     
>>>     CID 1352095:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
11     int main(int argc, const char **argv)
12     {
13       vector<const char*> args;
14       argv_to_vec(argc, argv, args);
15       env_to_vec(args);
16     

** CID 1352094:    (UNCAUGHT_EXCEPT)
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()


________________________________________________________________________________________________________
*** CID 1352094:    (UNCAUGHT_EXCEPT)
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
18     #include "common/errno.h"
19     #include "global/global_init.h"
20     
21     #include "JournalTool.h"
22     
23     
>>>     CID 1352094:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
24     int main(int argc, const char **argv)
25     {
26       vector<const char*> args;
27       argv_to_vec(argc, argv, args);
28       env_to_vec(args);
29     
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
18     #include "common/errno.h"
19     #include "global/global_init.h"
20     
21     #include "JournalTool.h"
22     
23     
>>>     CID 1352094:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
24     int main(int argc, const char **argv)
25     {
26       vector<const char*> args;
27       argv_to_vec(argc, argv, args);
28       env_to_vec(args);
29     

** CID 1352093:    (UNCAUGHT_EXCEPT)
/tools/cephfs/cephfs-data-scan.cc: 11 in main()
/tools/cephfs/cephfs-data-scan.cc: 11 in main()


________________________________________________________________________________________________________
*** CID 1352093:    (UNCAUGHT_EXCEPT)
/tools/cephfs/cephfs-data-scan.cc: 11 in main()
5     #include "common/errno.h"
6     #include "global/global_init.h"
7     
8     #include "DataScan.h"
9     
10     
>>>     CID 1352093:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
11     int main(int argc, const char **argv)
12     {
13       vector<const char*> args;
14       argv_to_vec(argc, argv, args);
15       env_to_vec(args);
16     
/tools/cephfs/cephfs-data-scan.cc: 11 in main()
5     #include "common/errno.h"
6     #include "global/global_init.h"
7     
8     #include "DataScan.h"
9     
10     
>>>     CID 1352093:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
11     int main(int argc, const char **argv)
12     {
13       vector<const char*> args;
14       argv_to_vec(argc, argv, args);
15       env_to_vec(args);
16     

** CID 1352092:  Error handling issues  (UNCAUGHT_EXCEPT)
/tools/rbd_mirror/main.cc: 32 in main()


________________________________________________________________________________________________________
*** CID 1352092:  Error handling issues  (UNCAUGHT_EXCEPT)
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352092:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     

** CID 1352091:    (UNCAUGHT_EXCEPT)
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()
/tools/rbd_mirror/main.cc: 32 in main()


________________________________________________________________________________________________________
*** CID 1352091:    (UNCAUGHT_EXCEPT)
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     
/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1352091:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       argv_to_vec(argc, argv, args);
36       env_to_vec(args);
37     

** CID 1352090:  Error handling issues  (UNCAUGHT_EXCEPT)
/tools/rados/rados.cc: 2969 in main()


________________________________________________________________________________________________________
*** CID 1352090:  Error handling issues  (UNCAUGHT_EXCEPT)
/tools/rados/rados.cc: 2969 in main()
2963     
2964     out:
2965       delete formatter;
2966       return (ret < 0) ? 1 : 0;
2967     }
2968     
>>>     CID 1352090:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
2969     int main(int argc, const char **argv)
2970     {
2971       vector<const char*> args;
2972       argv_to_vec(argc, argv, args);
2973       env_to_vec(args);
2974     

** CID 1352089:  Resource leaks  (RESOURCE_LEAK)
/global/global_init.cc: 249 in global_init(std::vector<const char *, std::allocator<const char *>> *, std::vector<const char *, std::allocator<const char *>> &, unsigned int, code_environment_t, int, const char *)()


________________________________________________________________________________________________________
*** CID 1352089:  Resource leaks  (RESOURCE_LEAK)
/global/global_init.cc: 249 in global_init(std::vector<const char *, std::allocator<const char *>> *, std::vector<const char *, std::allocator<const char *>> &, unsigned int, code_environment_t, int, const char *)()
243       // test leak checking
244       if (g_conf->debug_deliberately_leak_memory) {
245         derr << "deliberately leaking some memory" << dendl;
246         char *s = new char[1234567];
247         (void)s;
248         // cppcheck-suppress memleak
>>>     CID 1352089:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "s" going out of scope leaks the storage it points to.
249       }
250     
251       if (code_env == CODE_ENVIRONMENT_DAEMON && !(flags & CINIT_FLAG_NO_DAEMON_ACTIONS))
252         output_ceph_version();
253     }
254     

** CID 1352088:    (RESOURCE_LEAK)
/test/librados/cmd.cc: 84 in LibRadosCmd_OSDCmd_Test::TestBody()()
/test/librados/cmd.cc: 87 in LibRadosCmd_OSDCmd_Test::TestBody()()
/test/librados/cmd.cc: 90 in LibRadosCmd_OSDCmd_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1352088:    (RESOURCE_LEAK)
/test/librados/cmd.cc: 84 in LibRadosCmd_OSDCmd_Test::TestBody()()
78       char *cmd[2];
79       cmd[1] = NULL;
80     
81       // note: tolerate NXIO here in case the cluster is thrashing out underneath us.
82       cmd[0] = (char *)"asdfasdf";
83       r = rados_osd_command(cluster, 0, (const char **)cmd, 1, "", 0, &buf, &buflen, &st, &stlen);
>>>     CID 1352088:    (RESOURCE_LEAK)
>>>     Variable "st" going out of scope leaks the storage it points to.
84       ASSERT_TRUE(r == -22 || r == -ENXIO);
85       cmd[0] = (char *)"version";
86       r = rados_osd_command(cluster, 0, (const char **)cmd, 1, "", 0, &buf, &buflen, &st, &stlen);
87       ASSERT_TRUE(r == -22 || r == -ENXIO);
88       cmd[0] = (char *)"{\"prefix\":\"version\"}";
89       r = rados_osd_command(cluster, 0, (const char **)cmd, 1, "", 0, &buf, &buflen, &st, &stlen);
/test/librados/cmd.cc: 87 in LibRadosCmd_OSDCmd_Test::TestBody()()
81       // note: tolerate NXIO here in case the cluster is thrashing out underneath us.
82       cmd[0] = (char *)"asdfasdf";
83       r = rados_osd_command(cluster, 0, (const char **)cmd, 1, "", 0, &buf, &buflen, &st, &stlen);
84       ASSERT_TRUE(r == -22 || r == -ENXIO);
85       cmd[0] = (char *)"version";
86       r = rados_osd_command(cluster, 0, (const char **)cmd, 1, "", 0, &buf, &buflen, &st, &stlen);
>>>     CID 1352088:    (RESOURCE_LEAK)
>>>     Variable "st" going out of scope leaks the storage it points to.
87       ASSERT_TRUE(r == -22 || r == -ENXIO);
88       cmd[0] = (char *)"{\"prefix\":\"version\"}";
89       r = rados_osd_command(cluster, 0, (const char **)cmd, 1, "", 0, &buf, &buflen, &st, &stlen);
90       ASSERT_TRUE((r == 0 && buflen > 0) || (r == -ENXIO && buflen == 0));
91       rados_buffer_free(buf);
92       rados_buffer_free(st);
/test/librados/cmd.cc: 90 in LibRadosCmd_OSDCmd_Test::TestBody()()
84       ASSERT_TRUE(r == -22 || r == -ENXIO);
85       cmd[0] = (char *)"version";
86       r = rados_osd_command(cluster, 0, (const char **)cmd, 1, "", 0, &buf, &buflen, &st, &stlen);
87       ASSERT_TRUE(r == -22 || r == -ENXIO);
88       cmd[0] = (char *)"{\"prefix\":\"version\"}";
89       r = rados_osd_command(cluster, 0, (const char **)cmd, 1, "", 0, &buf, &buflen, &st, &stlen);
>>>     CID 1352088:    (RESOURCE_LEAK)
>>>     Variable "st" going out of scope leaks the storage it points to.
90       ASSERT_TRUE((r == 0 && buflen > 0) || (r == -ENXIO && buflen == 0));
91       rados_buffer_free(buf);
92       rados_buffer_free(st);
93       rados_shutdown(cluster);
94     }
95     

** CID 1352087:  Parse warnings  (PARSE_ERROR)
/mds/StrayManager.cc: 1 in ()


________________________________________________________________________________________________________
*** CID 1352087:  Parse warnings  (PARSE_ERROR)
/mds/StrayManager.cc: 1 in ()
>>>     CID 1352087:  Parse warnings  (PARSE_ERROR)
>>>     The Coverity compiler fails to compile this file. Please see the build output log for more information.
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*- 
2     // vim: ts=8 sw=2 smarttab
3     /*
4      * Ceph - scalable distributed file system
5      *
6      * Copyright (C) 2015 Red Hat

** CID 1352086:  Parse warnings  (PARSE_ERROR)
/mds/SnapServer.cc: 1 in ()


________________________________________________________________________________________________________
*** CID 1352086:  Parse warnings  (PARSE_ERROR)
/mds/SnapServer.cc: 1 in ()
>>>     CID 1352086:  Parse warnings  (PARSE_ERROR)
>>>     The Coverity compiler fails to compile this file. Please see the build output log for more information.
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*- 
2     // vim: ts=8 sw=2 smarttab
3     /*
4      * Ceph - scalable distributed file system
5      *
6      * Copyright (C) 2004-2006 Sage Weil <sage@newdream.net>

** CID 1352085:  Parse warnings  (PARSE_ERROR)
/mds/Server.cc: 1 in ()


________________________________________________________________________________________________________
*** CID 1352085:  Parse warnings  (PARSE_ERROR)
/mds/Server.cc: 1 in ()
>>>     CID 1352085:  Parse warnings  (PARSE_ERROR)
>>>     The Coverity compiler fails to compile this file. Please see the build output log for more information.
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
2     // vim: ts=8 sw=2 smarttab
3     /*
4      * Ceph - scalable distributed file system
5      *
6      * Copyright (C) 2004-2006 Sage Weil <sage@newdream.net>

** CID 1352084:  Parse warnings  (PARSE_ERROR)
/mds/MDSRank.cc: 1 in ()


________________________________________________________________________________________________________
*** CID 1352084:  Parse warnings  (PARSE_ERROR)
/mds/MDSRank.cc: 1 in ()
>>>     CID 1352084:  Parse warnings  (PARSE_ERROR)
>>>     The Coverity compiler fails to compile this file. Please see the build output log for more information.
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
2     // vim: ts=8 sw=2 smarttab
3     /*
4      * Ceph - scalable distributed file system
5      *
6      * Copyright (C) 2015 Red Hat

** CID 1352083:  Parse warnings  (PARSE_ERROR)
/mds/MDSDaemon.cc: 1 in ()


________________________________________________________________________________________________________
*** CID 1352083:  Parse warnings  (PARSE_ERROR)
/mds/MDSDaemon.cc: 1 in ()
>>>     CID 1352083:  Parse warnings  (PARSE_ERROR)
>>>     The Coverity compiler fails to compile this file. Please see the build output log for more information.
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
2     // vim: ts=8 sw=2 smarttab
3     /*
4      * Ceph - scalable distributed file system
5      *
6      * Copyright (C) 2004-2006 Sage Weil <sage@newdream.net>

** CID 1352082:  Parse warnings  (PARSE_ERROR)
/librados/RadosClient.cc: 1 in ()


________________________________________________________________________________________________________
*** CID 1352082:  Parse warnings  (PARSE_ERROR)
/librados/RadosClient.cc: 1 in ()
>>>     CID 1352082:  Parse warnings  (PARSE_ERROR)
>>>     The Coverity compiler fails to compile this file. Please see the build output log for more information.
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
2     // vim: ts=8 sw=2 smarttab
3     /*
4      * Ceph - scalable distributed file system
5      *
6      * Copyright (C) 2004-2012 Sage Weil <sage@newdream.net>

** CID 1352081:  Parse warnings  (PARSE_ERROR)
/client/SyntheticClient.cc: 1 in ()


________________________________________________________________________________________________________
*** CID 1352081:  Parse warnings  (PARSE_ERROR)
/client/SyntheticClient.cc: 1 in ()
>>>     CID 1352081:  Parse warnings  (PARSE_ERROR)
>>>     The Coverity compiler fails to compile this file. Please see the build output log for more information.
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*- 
2     // vim: ts=8 sw=2 smarttab
3     /*
4      * Ceph - scalable distributed file system
5      *
6      * Copyright (C) 2004-2006 Sage Weil <sage@newdream.net>

** CID 1352080:  Parse warnings  (PARSE_ERROR)
/client/Client.cc: 1 in ()


________________________________________________________________________________________________________
*** CID 1352080:  Parse warnings  (PARSE_ERROR)
/client/Client.cc: 1 in ()
>>>     CID 1352080:  Parse warnings  (PARSE_ERROR)
>>>     The Coverity compiler fails to compile this file. Please see the build output log for more information.
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
2     // vim: ts=8 sw=2 smarttab
3     /*
4      * Ceph - scalable distributed file system
5      *
6      * Copyright (C) 2004-2006 Sage Weil <sage@newdream.net>

** CID 1352079:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1352079:  Memory - corruptions  (OVERRUN)
/librbd/journal/Types.cc: 378 in librbd::journal::ClientData::encode(ceph::buffer::list &) const()
372     
373     ClientMetaType ClientData::get_client_meta_type() const {
374       return boost::apply_visitor(GetTypeVisitor<ClientMetaType>(), client_meta);
375     }
376     
377     void ClientData::encode(bufferlist& bl) const {
>>>     CID 1352079:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
378       ENCODE_START(1, 1, bl);
379       boost::apply_visitor(EncodeVisitor(bl), client_meta);
380       ENCODE_FINISH(bl);
381     }
382     
383     void ClientData::decode(bufferlist::iterator& it) {

** CID 1352078:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1352078:  Memory - corruptions  (OVERRUN)
/cls/journal/cls_journal_types.cc: 104 in cls::journal::Tag::encode(ceph::buffer::list &) const()
98       o.push_back(new Client());
99       o.push_back(new Client("id", data));
100       o.push_back(new Client("id", data, {1, {{1, 120}, {2, 121}}}));
101     }
102     
103     void Tag::encode(bufferlist& bl) const {
>>>     CID 1352078:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
104       ENCODE_START(1, 1, bl);
105       ::encode(tid, bl);
106       ::encode(tag_class, bl);
107       ::encode(data, bl);
108       ENCODE_FINISH(bl);
109     }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/ceph?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c

