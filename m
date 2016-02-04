From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 04 Feb 2016 12:39:27 -0800
Message-ID: <56b3b6ff81823_2c2bb5b314362f9@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:47097 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbcBDUjO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Feb 2016 15:39:14 -0500
Received: from localhost.localdomain (static-208.69.177.245.nephosdns.com [208.69.177.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtprelay.synopsys.com (Postfix) with ESMTPS id 3AEF024E0D55
	for <ceph-devel@vger.kernel.org>; Thu,  4 Feb 2016 12:39:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

103 new defect(s) introduced to ceph found with Coverity Scan.
1 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 103 defect(s)


** CID 1351813:    (UNCAUGHT_EXCEPT)
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()
/test/bench/small_io_bench_fs.cc: 44 in main()


________________________________________________________________________________________________________
*** CID 1351813:    (UNCAUGHT_EXCEPT)
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench_fs.cc: 44 in main()
38         delete f;
39         bl.append('\0');
40         *out << bl.c_str() << std::endl;
41       }
42     };
43     
>>>     CID 1351813:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
44     int main(int argc, char **argv)
45     {
46       po::options_description desc("Allowed options");
47       desc.add_options()
48         ("help", "produce help message")
49         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),

** CID 1351812:    (UNCAUGHT_EXCEPT)
/test/msgr/test_async_driver.cc: 352 in main()
/test/msgr/test_async_driver.cc: 352 in main()


________________________________________________________________________________________________________
*** CID 1351812:    (UNCAUGHT_EXCEPT)
/test/msgr/test_async_driver.cc: 352 in main()
346     // must be defined). This dummy test keeps gtest_main linked in.
347     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
348     
349     #endif
350     
351     
>>>     CID 1351812:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
352     int main(int argc, char **argv) {
353       vector<const char*> args;
354       argv_to_vec(argc, (const char **)argv, args);
355     
356       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
357       common_init_finish(g_ceph_context);
/test/msgr/test_async_driver.cc: 352 in main()
346     // must be defined). This dummy test keeps gtest_main linked in.
347     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
348     
349     #endif
350     
351     
>>>     CID 1351812:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
352     int main(int argc, char **argv) {
353       vector<const char*> args;
354       argv_to_vec(argc, (const char **)argv, args);
355     
356       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
357       common_init_finish(g_ceph_context);

** CID 1351811:    (UNCAUGHT_EXCEPT)
/test/filestore/TestFileStore.cc: 67 in main()
/test/filestore/TestFileStore.cc: 67 in main()
/test/filestore/TestFileStore.cc: 67 in main()
/test/filestore/TestFileStore.cc: 67 in main()


________________________________________________________________________________________________________
*** CID 1351811:    (UNCAUGHT_EXCEPT)
/test/filestore/TestFileStore.cc: 67 in main()
61         fs.collect_metadata(&pm);
62         ASSERT_EQ(pm["filestore_backend"], "zfs");
63       }
64     #endif
65     }
66     
>>>     CID 1351811:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
67     int main(int argc, char **argv) {
68       vector<const char*> args;
69       argv_to_vec(argc, (const char **)argv, args);
70     
71       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
72       common_init_finish(g_ceph_context);
/test/filestore/TestFileStore.cc: 67 in main()
61         fs.collect_metadata(&pm);
62         ASSERT_EQ(pm["filestore_backend"], "zfs");
63       }
64     #endif
65     }
66     
>>>     CID 1351811:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
67     int main(int argc, char **argv) {
68       vector<const char*> args;
69       argv_to_vec(argc, (const char **)argv, args);
70     
71       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
72       common_init_finish(g_ceph_context);
/test/filestore/TestFileStore.cc: 67 in main()
61         fs.collect_metadata(&pm);
62         ASSERT_EQ(pm["filestore_backend"], "zfs");
63       }
64     #endif
65     }
66     
>>>     CID 1351811:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
67     int main(int argc, char **argv) {
68       vector<const char*> args;
69       argv_to_vec(argc, (const char **)argv, args);
70     
71       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
72       common_init_finish(g_ceph_context);
/test/filestore/TestFileStore.cc: 67 in main()
61         fs.collect_metadata(&pm);
62         ASSERT_EQ(pm["filestore_backend"], "zfs");
63       }
64     #endif
65     }
66     
>>>     CID 1351811:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
67     int main(int argc, char **argv) {
68       vector<const char*> args;
69       argv_to_vec(argc, (const char **)argv, args);
70     
71       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
72       common_init_finish(g_ceph_context);

** CID 1351810:    (UNCAUGHT_EXCEPT)
/test/system/rados_delete_pools_parallel.cc: 57 in main()
/test/system/rados_delete_pools_parallel.cc: 57 in main()


________________________________________________________________________________________________________
*** CID 1351810:    (UNCAUGHT_EXCEPT)
/test/system/rados_delete_pools_parallel.cc: 57 in main()
51     
52     const char *get_id_str()
53     {
54       return "main";
55     }
56     
>>>     CID 1351810:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
57     int main(int argc, const char **argv)
58     {
59       const char *num_objects = getenv("NUM_OBJECTS");
60       std::string pool = "foo";
61       if (num_objects) {
62         g_num_objects = atoi(num_objects); 
/test/system/rados_delete_pools_parallel.cc: 57 in main()
51     
52     const char *get_id_str()
53     {
54       return "main";
55     }
56     
>>>     CID 1351810:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
57     int main(int argc, const char **argv)
58     {
59       const char *num_objects = getenv("NUM_OBJECTS");
60       std::string pool = "foo";
61       if (num_objects) {
62         g_num_objects = atoi(num_objects); 

** CID 1351809:    (UNCAUGHT_EXCEPT)
/test/test_rgw_admin_opstate.cc: 804 in main()
/test/test_rgw_admin_opstate.cc: 804 in main()
/test/test_rgw_admin_opstate.cc: 804 in main()
/test/test_rgw_admin_opstate.cc: 804 in main()


________________________________________________________________________________________________________
*** CID 1351809:    (UNCAUGHT_EXCEPT)
/test/test_rgw_admin_opstate.cc: 804 in main()
798       EXPECT_EQ(200U, g_test->get_resp_code());
799     
800       ASSERT_EQ(caps_rm(cname, perm), 0);
801       ASSERT_EQ(user_rm(uid, display_name), 0);
802     }
803     
>>>     CID 1351809:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
804     int main(int argc, char *argv[]){
805       vector<const char*> args;
806       argv_to_vec(argc, (const char **)argv, args);
807     
808       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
809       common_init_finish(g_ceph_context);
/test/test_rgw_admin_opstate.cc: 804 in main()
798       EXPECT_EQ(200U, g_test->get_resp_code());
799     
800       ASSERT_EQ(caps_rm(cname, perm), 0);
801       ASSERT_EQ(user_rm(uid, display_name), 0);
802     }
803     
>>>     CID 1351809:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
804     int main(int argc, char *argv[]){
805       vector<const char*> args;
806       argv_to_vec(argc, (const char **)argv, args);
807     
808       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
809       common_init_finish(g_ceph_context);
/test/test_rgw_admin_opstate.cc: 804 in main()
798       EXPECT_EQ(200U, g_test->get_resp_code());
799     
800       ASSERT_EQ(caps_rm(cname, perm), 0);
801       ASSERT_EQ(user_rm(uid, display_name), 0);
802     }
803     
>>>     CID 1351809:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
804     int main(int argc, char *argv[]){
805       vector<const char*> args;
806       argv_to_vec(argc, (const char **)argv, args);
807     
808       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
809       common_init_finish(g_ceph_context);
/test/test_rgw_admin_opstate.cc: 804 in main()
798       EXPECT_EQ(200U, g_test->get_resp_code());
799     
800       ASSERT_EQ(caps_rm(cname, perm), 0);
801       ASSERT_EQ(user_rm(uid, display_name), 0);
802     }
803     
>>>     CID 1351809:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
804     int main(int argc, char *argv[]){
805       vector<const char*> args;
806       argv_to_vec(argc, (const char **)argv, args);
807     
808       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
809       common_init_finish(g_ceph_context);

** CID 1351808:  Error handling issues  (UNCAUGHT_EXCEPT)
/test/test_rewrite_latency.cc: 12 in main()


________________________________________________________________________________________________________
*** CID 1351808:  Error handling issues  (UNCAUGHT_EXCEPT)
/test/test_rewrite_latency.cc: 12 in main()
6     #include "include/utime.h"
7     #include "common/Clock.h"
8     #include "common/errno.h"
9     
10     using namespace std;
11     
>>>     CID 1351808:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
12     int main(int argc, const char **argv)
13     {
14       const char *fn = argv[1];
15       multimap<utime_t, utime_t> latency;
16       unsigned max = 10;
17     

** CID 1351807:    (UNCAUGHT_EXCEPT)
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()


________________________________________________________________________________________________________
*** CID 1351807:    (UNCAUGHT_EXCEPT)
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
238     
239     void usage(const string &name) {
240       cerr << "Usage: " << name << " [times] "
241            << std::endl;
242     }
243     
>>>     CID 1351807:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
244     int main(int argc, char **argv)
245     {
246       vector<const char*> args;
247       argv_to_vec(argc, (const char **)argv, args);
248     
249       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
238     
239     void usage(const string &name) {
240       cerr << "Usage: " << name << " [times] "
241            << std::endl;
242     }
243     
>>>     CID 1351807:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
244     int main(int argc, char **argv)
245     {
246       vector<const char*> args;
247       argv_to_vec(argc, (const char **)argv, args);
248     
249       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
238     
239     void usage(const string &name) {
240       cerr << "Usage: " << name << " [times] "
241            << std::endl;
242     }
243     
>>>     CID 1351807:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
244     int main(int argc, char **argv)
245     {
246       vector<const char*> args;
247       argv_to_vec(argc, (const char **)argv, args);
248     
249       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
238     
239     void usage(const string &name) {
240       cerr << "Usage: " << name << " [times] "
241            << std::endl;
242     }
243     
>>>     CID 1351807:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
244     int main(int argc, char **argv)
245     {
246       vector<const char*> args;
247       argv_to_vec(argc, (const char **)argv, args);
248     
249       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
238     
239     void usage(const string &name) {
240       cerr << "Usage: " << name << " [times] "
241            << std::endl;
242     }
243     
>>>     CID 1351807:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
244     int main(int argc, char **argv)
245     {
246       vector<const char*> args;
247       argv_to_vec(argc, (const char **)argv, args);
248     
249       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);

** CID 1351806:    (UNCAUGHT_EXCEPT)
/test/bench_log.cc: 31 in main()
/test/bench_log.cc: 31 in main()
/test/bench_log.cc: 31 in main()
/test/bench_log.cc: 31 in main()


________________________________________________________________________________________________________
*** CID 1351806:    (UNCAUGHT_EXCEPT)
/test/bench_log.cc: 31 in main()
25           generic_dout(0) << "this is a typical log line.  set "
26     		      << myset << " and map " << mymap << dendl;
27         return 0;
28       }
29     };
30     
>>>     CID 1351806:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
31     int main(int argc, const char **argv)
32     {
33       int threads = atoi(argv[1]);
34       int num = atoi(argv[2]);
35     
36       cout << threads << " threads, " << num << " lines per thread" << std::endl;
/test/bench_log.cc: 31 in main()
25           generic_dout(0) << "this is a typical log line.  set "
26     		      << myset << " and map " << mymap << dendl;
27         return 0;
28       }
29     };
30     
>>>     CID 1351806:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
31     int main(int argc, const char **argv)
32     {
33       int threads = atoi(argv[1]);
34       int num = atoi(argv[2]);
35     
36       cout << threads << " threads, " << num << " lines per thread" << std::endl;
/test/bench_log.cc: 31 in main()
25           generic_dout(0) << "this is a typical log line.  set "
26     		      << myset << " and map " << mymap << dendl;
27         return 0;
28       }
29     };
30     
>>>     CID 1351806:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
31     int main(int argc, const char **argv)
32     {
33       int threads = atoi(argv[1]);
34       int num = atoi(argv[2]);
35     
36       cout << threads << " threads, " << num << " lines per thread" << std::endl;
/test/bench_log.cc: 31 in main()
25           generic_dout(0) << "this is a typical log line.  set "
26     		      << myset << " and map " << mymap << dendl;
27         return 0;
28       }
29     };
30     
>>>     CID 1351806:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
31     int main(int argc, const char **argv)
32     {
33       int threads = atoi(argv[1]);
34       int num = atoi(argv[2]);
35     
36       cout << threads << " threads, " << num << " lines per thread" << std::endl;

** CID 1351805:  Error handling issues  (UNCAUGHT_EXCEPT)
/tools/rbd_nbd/rbd-nbd.cc: 853 in main()


________________________________________________________________________________________________________
*** CID 1351805:  Error handling issues  (UNCAUGHT_EXCEPT)
/tools/rbd_nbd/rbd-nbd.cc: 853 in main()
847           return EXIT_FAILURE;
848       }
849     
850       return 0;
851     }
852     
>>>     CID 1351805:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
853     int main(int argc, const char *argv[])
854     {
855       return rbd_nbd(argc, argv);

** CID 1351804:    (UNCAUGHT_EXCEPT)
/tools/rados/rados.cc: 2969 in main()
/tools/rados/rados.cc: 2969 in main()
/tools/rados/rados.cc: 2969 in main()


________________________________________________________________________________________________________
*** CID 1351804:    (UNCAUGHT_EXCEPT)
/tools/rados/rados.cc: 2969 in main()
2963     
2964     out:
2965       delete formatter;
2966       return (ret < 0) ? 1 : 0;
2967     }
2968     
>>>     CID 1351804:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
2969     int main(int argc, const char **argv)
2970     {
2971       vector<const char*> args;
2972       argv_to_vec(argc, argv, args);
2973       env_to_vec(args);
2974     
/tools/rados/rados.cc: 2969 in main()
2963     
2964     out:
2965       delete formatter;
2966       return (ret < 0) ? 1 : 0;
2967     }
2968     
>>>     CID 1351804:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
2969     int main(int argc, const char **argv)
2970     {
2971       vector<const char*> args;
2972       argv_to_vec(argc, argv, args);
2973       env_to_vec(args);
2974     
/tools/rados/rados.cc: 2969 in main()
2963     
2964     out:
2965       delete formatter;
2966       return (ret < 0) ? 1 : 0;
2967     }
2968     
>>>     CID 1351804:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
2969     int main(int argc, const char **argv)
2970     {
2971       vector<const char*> args;
2972       argv_to_vec(argc, argv, args);
2973       env_to_vec(args);
2974     

** CID 1351803:  Error handling issues  (UNCAUGHT_EXCEPT)
/test/erasure-code/ceph_erasure_code_benchmark.cc: 329 in main()


________________________________________________________________________________________________________
*** CID 1351803:  Error handling issues  (UNCAUGHT_EXCEPT)
/test/erasure-code/ceph_erasure_code_benchmark.cc: 329 in main()
323       }
324       utime_t end_time = ceph_clock_now(g_ceph_context);
325       cout << (end_time - begin_time) << "\t" << (max_iterations * (in_size / 1024)) << endl;
326       return 0;
327     }
328     
>>>     CID 1351803:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
329     int main(int argc, char** argv) {
330       ErasureCodeBench ecbench;
331       try {
332         int err = ecbench.setup(argc, argv);
333         if (err)
334           return err;

** CID 1351802:    (UNCAUGHT_EXCEPT)
/test/bench/small_io_bench.cc: 26 in main()
/test/bench/small_io_bench.cc: 26 in main()
/test/bench/small_io_bench.cc: 26 in main()
/test/bench/small_io_bench.cc: 26 in main()
/test/bench/small_io_bench.cc: 26 in main()
/test/bench/small_io_bench.cc: 26 in main()
/test/bench/small_io_bench.cc: 26 in main()
/test/bench/small_io_bench.cc: 26 in main()


________________________________________________________________________________________________________
*** CID 1351802:    (UNCAUGHT_EXCEPT)
/test/bench/small_io_bench.cc: 26 in main()
20     #include "detailed_stat_collector.h"
21     #include "distribution.h"
22     
23     namespace po = boost::program_options;
24     using namespace std;
25     
>>>     CID 1351802:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
26     int main(int argc, char **argv)
27     {
28       po::options_description desc("Allowed options");
29       desc.add_options()
30         ("help", "produce help message")
31         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench.cc: 26 in main()
20     #include "detailed_stat_collector.h"
21     #include "distribution.h"
22     
23     namespace po = boost::program_options;
24     using namespace std;
25     
>>>     CID 1351802:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
26     int main(int argc, char **argv)
27     {
28       po::options_description desc("Allowed options");
29       desc.add_options()
30         ("help", "produce help message")
31         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench.cc: 26 in main()
20     #include "detailed_stat_collector.h"
21     #include "distribution.h"
22     
23     namespace po = boost::program_options;
24     using namespace std;
25     
>>>     CID 1351802:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
26     int main(int argc, char **argv)
27     {
28       po::options_description desc("Allowed options");
29       desc.add_options()
30         ("help", "produce help message")
31         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench.cc: 26 in main()
20     #include "detailed_stat_collector.h"
21     #include "distribution.h"
22     
23     namespace po = boost::program_options;
24     using namespace std;
25     
>>>     CID 1351802:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
26     int main(int argc, char **argv)
27     {
28       po::options_description desc("Allowed options");
29       desc.add_options()
30         ("help", "produce help message")
31         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench.cc: 26 in main()
20     #include "detailed_stat_collector.h"
21     #include "distribution.h"
22     
23     namespace po = boost::program_options;
24     using namespace std;
25     
>>>     CID 1351802:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
26     int main(int argc, char **argv)
27     {
28       po::options_description desc("Allowed options");
29       desc.add_options()
30         ("help", "produce help message")
31         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench.cc: 26 in main()
20     #include "detailed_stat_collector.h"
21     #include "distribution.h"
22     
23     namespace po = boost::program_options;
24     using namespace std;
25     
>>>     CID 1351802:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
26     int main(int argc, char **argv)
27     {
28       po::options_description desc("Allowed options");
29       desc.add_options()
30         ("help", "produce help message")
31         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench.cc: 26 in main()
20     #include "detailed_stat_collector.h"
21     #include "distribution.h"
22     
23     namespace po = boost::program_options;
24     using namespace std;
25     
>>>     CID 1351802:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
26     int main(int argc, char **argv)
27     {
28       po::options_description desc("Allowed options");
29       desc.add_options()
30         ("help", "produce help message")
31         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/test/bench/small_io_bench.cc: 26 in main()
20     #include "detailed_stat_collector.h"
21     #include "distribution.h"
22     
23     namespace po = boost::program_options;
24     using namespace std;
25     
>>>     CID 1351802:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
26     int main(int argc, char **argv)
27     {
28       po::options_description desc("Allowed options");
29       desc.add_options()
30         ("help", "produce help message")
31         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),

** CID 1351801:    (UNCAUGHT_EXCEPT)
/test/osd/TestRados.cc: 245 in main()
/test/osd/TestRados.cc: 245 in main()
/test/osd/TestRados.cc: 245 in main()
/test/osd/TestRados.cc: 245 in main()


________________________________________________________________________________________________________
*** CID 1351801:    (UNCAUGHT_EXCEPT)
/test/osd/TestRados.cc: 245 in main()
239       map<TestOpType, unsigned int> m_weight_sums;
240       unsigned int m_total_weight;
241       bool m_ec_pool;
242       bool m_balance_reads;
243     };
244     
>>>     CID 1351801:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
245     int main(int argc, char **argv)
246     {
247       int ops = 1000;
248       int objects = 50;
249       int max_in_flight = 16;
250       int64_t size = 4000000; // 4 MB
/test/osd/TestRados.cc: 245 in main()
239       map<TestOpType, unsigned int> m_weight_sums;
240       unsigned int m_total_weight;
241       bool m_ec_pool;
242       bool m_balance_reads;
243     };
244     
>>>     CID 1351801:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
245     int main(int argc, char **argv)
246     {
247       int ops = 1000;
248       int objects = 50;
249       int max_in_flight = 16;
250       int64_t size = 4000000; // 4 MB
/test/osd/TestRados.cc: 245 in main()
239       map<TestOpType, unsigned int> m_weight_sums;
240       unsigned int m_total_weight;
241       bool m_ec_pool;
242       bool m_balance_reads;
243     };
244     
>>>     CID 1351801:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
245     int main(int argc, char **argv)
246     {
247       int ops = 1000;
248       int objects = 50;
249       int max_in_flight = 16;
250       int64_t size = 4000000; // 4 MB
/test/osd/TestRados.cc: 245 in main()
239       map<TestOpType, unsigned int> m_weight_sums;
240       unsigned int m_total_weight;
241       bool m_ec_pool;
242       bool m_balance_reads;
243     };
244     
>>>     CID 1351801:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
245     int main(int argc, char **argv)
246     {
247       int ops = 1000;
248       int objects = 50;
249       int max_in_flight = 16;
250       int64_t size = 4000000; // 4 MB

** CID 1351800:    (UNCAUGHT_EXCEPT)
/test/objectstore/workload_generator.cc: 556 in main()
/test/objectstore/workload_generator.cc: 556 in main()
/test/objectstore/workload_generator.cc: 556 in main()
/test/objectstore/workload_generator.cc: 556 in main()
/test/objectstore/workload_generator.cc: 556 in main()


________________________________________________________________________________________________________
*** CID 1351800:    (UNCAUGHT_EXCEPT)
/test/objectstore/workload_generator.cc: 556 in main()
550           l    writes on pglog\n\
551           d    data writes on objects\n\
552     \n\
553     " << std::endl;
554     }
555     
>>>     CID 1351800:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
556     int main(int argc, const char *argv[])
557     {
558       vector<const char*> def_args;
559       vector<const char*> args;
560     
561       our_name = argv[0];
/test/objectstore/workload_generator.cc: 556 in main()
550           l    writes on pglog\n\
551           d    data writes on objects\n\
552     \n\
553     " << std::endl;
554     }
555     
>>>     CID 1351800:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
556     int main(int argc, const char *argv[])
557     {
558       vector<const char*> def_args;
559       vector<const char*> args;
560     
561       our_name = argv[0];
/test/objectstore/workload_generator.cc: 556 in main()
550           l    writes on pglog\n\
551           d    data writes on objects\n\
552     \n\
553     " << std::endl;
554     }
555     
>>>     CID 1351800:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
556     int main(int argc, const char *argv[])
557     {
558       vector<const char*> def_args;
559       vector<const char*> args;
560     
561       our_name = argv[0];
/test/objectstore/workload_generator.cc: 556 in main()
550           l    writes on pglog\n\
551           d    data writes on objects\n\
552     \n\
553     " << std::endl;
554     }
555     
>>>     CID 1351800:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
556     int main(int argc, const char *argv[])
557     {
558       vector<const char*> def_args;
559       vector<const char*> args;
560     
561       our_name = argv[0];
/test/objectstore/workload_generator.cc: 556 in main()
550           l    writes on pglog\n\
551           d    data writes on objects\n\
552     \n\
553     " << std::endl;
554     }
555     
>>>     CID 1351800:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
556     int main(int argc, const char *argv[])
557     {
558       vector<const char*> def_args;
559       vector<const char*> args;
560     
561       our_name = argv[0];

** CID 1351799:    (UNCAUGHT_EXCEPT)
/test/test_filejournal.cc: 69 in main()
/test/test_filejournal.cc: 69 in main()
/test/test_filejournal.cc: 69 in main()
/test/test_filejournal.cc: 69 in main()
/test/test_filejournal.cc: 69 in main()
/test/test_filejournal.cc: 69 in main()


________________________________________________________________________________________________________
*** CID 1351799:    (UNCAUGHT_EXCEPT)
/test/test_filejournal.cc: 69 in main()
63     };
64     
65     unsigned size_mb = 200;
66     //Gtest argument prefix
67     const char GTEST_PRFIX[] = "--gtest_";
68     
>>>     CID 1351799:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
69     int main(int argc, char **argv) {
70       vector<const char*> args;
71       argv_to_vec(argc, (const char **)argv, args);
72     
73       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
74       common_init_finish(g_ceph_context);
/test/test_filejournal.cc: 69 in main()
63     };
64     
65     unsigned size_mb = 200;
66     //Gtest argument prefix
67     const char GTEST_PRFIX[] = "--gtest_";
68     
>>>     CID 1351799:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
69     int main(int argc, char **argv) {
70       vector<const char*> args;
71       argv_to_vec(argc, (const char **)argv, args);
72     
73       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
74       common_init_finish(g_ceph_context);
/test/test_filejournal.cc: 69 in main()
63     };
64     
65     unsigned size_mb = 200;
66     //Gtest argument prefix
67     const char GTEST_PRFIX[] = "--gtest_";
68     
>>>     CID 1351799:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
69     int main(int argc, char **argv) {
70       vector<const char*> args;
71       argv_to_vec(argc, (const char **)argv, args);
72     
73       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
74       common_init_finish(g_ceph_context);
/test/test_filejournal.cc: 69 in main()
63     };
64     
65     unsigned size_mb = 200;
66     //Gtest argument prefix
67     const char GTEST_PRFIX[] = "--gtest_";
68     
>>>     CID 1351799:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
69     int main(int argc, char **argv) {
70       vector<const char*> args;
71       argv_to_vec(argc, (const char **)argv, args);
72     
73       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
74       common_init_finish(g_ceph_context);
/test/test_filejournal.cc: 69 in main()
63     };
64     
65     unsigned size_mb = 200;
66     //Gtest argument prefix
67     const char GTEST_PRFIX[] = "--gtest_";
68     
>>>     CID 1351799:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
69     int main(int argc, char **argv) {
70       vector<const char*> args;
71       argv_to_vec(argc, (const char **)argv, args);
72     
73       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
74       common_init_finish(g_ceph_context);
/test/test_filejournal.cc: 69 in main()
63     };
64     
65     unsigned size_mb = 200;
66     //Gtest argument prefix
67     const char GTEST_PRFIX[] = "--gtest_";
68     
>>>     CID 1351799:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
69     int main(int argc, char **argv) {
70       vector<const char*> args;
71       argv_to_vec(argc, (const char **)argv, args);
72     
73       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
74       common_init_finish(g_ceph_context);

** CID 1351798:    (UNCAUGHT_EXCEPT)
/test/test_rgw_admin_log.cc: 1577 in main()
/test/test_rgw_admin_log.cc: 1577 in main()
/test/test_rgw_admin_log.cc: 1577 in main()
/test/test_rgw_admin_log.cc: 1577 in main()


________________________________________________________________________________________________________
*** CID 1351798:    (UNCAUGHT_EXCEPT)
/test/test_rgw_admin_log.cc: 1577 in main()
1571       
1572       ASSERT_EQ(0, delete_obj(TEST_BUCKET_OBJECT));
1573       ASSERT_EQ(0, delete_bucket());
1574       ASSERT_EQ(0, user_rm(uid, display_name));
1575     }
1576     
>>>     CID 1351798:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
1577     int main(int argc, char *argv[]){
1578       vector<const char*> args;
1579       argv_to_vec(argc, (const char **)argv, args);
1580     
1581       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
1582       common_init_finish(g_ceph_context);
/test/test_rgw_admin_log.cc: 1577 in main()
1571       
1572       ASSERT_EQ(0, delete_obj(TEST_BUCKET_OBJECT));
1573       ASSERT_EQ(0, delete_bucket());
1574       ASSERT_EQ(0, user_rm(uid, display_name));
1575     }
1576     
>>>     CID 1351798:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
1577     int main(int argc, char *argv[]){
1578       vector<const char*> args;
1579       argv_to_vec(argc, (const char **)argv, args);
1580     
1581       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
1582       common_init_finish(g_ceph_context);
/test/test_rgw_admin_log.cc: 1577 in main()
1571       
1572       ASSERT_EQ(0, delete_obj(TEST_BUCKET_OBJECT));
1573       ASSERT_EQ(0, delete_bucket());
1574       ASSERT_EQ(0, user_rm(uid, display_name));
1575     }
1576     
>>>     CID 1351798:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
1577     int main(int argc, char *argv[]){
1578       vector<const char*> args;
1579       argv_to_vec(argc, (const char **)argv, args);
1580     
1581       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
1582       common_init_finish(g_ceph_context);
/test/test_rgw_admin_log.cc: 1577 in main()
1571       
1572       ASSERT_EQ(0, delete_obj(TEST_BUCKET_OBJECT));
1573       ASSERT_EQ(0, delete_bucket());
1574       ASSERT_EQ(0, user_rm(uid, display_name));
1575     }
1576     
>>>     CID 1351798:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
1577     int main(int argc, char *argv[]){
1578       vector<const char*> args;
1579       argv_to_vec(argc, (const char **)argv, args);
1580     
1581       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
1582       common_init_finish(g_ceph_context);

** CID 1351797:    (UNCAUGHT_EXCEPT)
/test/msgr/perf_msgr_client.cc: 170 in main()
/test/msgr/perf_msgr_client.cc: 170 in main()
/test/msgr/perf_msgr_client.cc: 170 in main()
/test/msgr/perf_msgr_client.cc: 170 in main()
/test/msgr/perf_msgr_client.cc: 170 in main()


________________________________________________________________________________________________________
*** CID 1351797:    (UNCAUGHT_EXCEPT)
/test/msgr/perf_msgr_client.cc: 170 in main()
164       cerr << "       [concurrency]: the max inflight messages(like iodepth in fio)" << std::endl;
165       cerr << "       [ios]: how much messages sent for each client" << std::endl;
166       cerr << "       [thinktime]: sleep time when do fast dispatching(match client logic)" << std::endl;
167       cerr << "       [msg length]: message data bytes" << std::endl;
168     }
169     
>>>     CID 1351797:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
170     int main(int argc, char **argv)
171     {
172       vector<const char*> args;
173       argv_to_vec(argc, (const char **)argv, args);
174     
175       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/msgr/perf_msgr_client.cc: 170 in main()
164       cerr << "       [concurrency]: the max inflight messages(like iodepth in fio)" << std::endl;
165       cerr << "       [ios]: how much messages sent for each client" << std::endl;
166       cerr << "       [thinktime]: sleep time when do fast dispatching(match client logic)" << std::endl;
167       cerr << "       [msg length]: message data bytes" << std::endl;
168     }
169     
>>>     CID 1351797:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
170     int main(int argc, char **argv)
171     {
172       vector<const char*> args;
173       argv_to_vec(argc, (const char **)argv, args);
174     
175       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/msgr/perf_msgr_client.cc: 170 in main()
164       cerr << "       [concurrency]: the max inflight messages(like iodepth in fio)" << std::endl;
165       cerr << "       [ios]: how much messages sent for each client" << std::endl;
166       cerr << "       [thinktime]: sleep time when do fast dispatching(match client logic)" << std::endl;
167       cerr << "       [msg length]: message data bytes" << std::endl;
168     }
169     
>>>     CID 1351797:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
170     int main(int argc, char **argv)
171     {
172       vector<const char*> args;
173       argv_to_vec(argc, (const char **)argv, args);
174     
175       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/msgr/perf_msgr_client.cc: 170 in main()
164       cerr << "       [concurrency]: the max inflight messages(like iodepth in fio)" << std::endl;
165       cerr << "       [ios]: how much messages sent for each client" << std::endl;
166       cerr << "       [thinktime]: sleep time when do fast dispatching(match client logic)" << std::endl;
167       cerr << "       [msg length]: message data bytes" << std::endl;
168     }
169     
>>>     CID 1351797:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
170     int main(int argc, char **argv)
171     {
172       vector<const char*> args;
173       argv_to_vec(argc, (const char **)argv, args);
174     
175       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/msgr/perf_msgr_client.cc: 170 in main()
164       cerr << "       [concurrency]: the max inflight messages(like iodepth in fio)" << std::endl;
165       cerr << "       [ios]: how much messages sent for each client" << std::endl;
166       cerr << "       [thinktime]: sleep time when do fast dispatching(match client logic)" << std::endl;
167       cerr << "       [msg length]: message data bytes" << std::endl;
168     }
169     
>>>     CID 1351797:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
170     int main(int argc, char **argv)
171     {
172       vector<const char*> args;
173       argv_to_vec(argc, (const char **)argv, args);
174     
175       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);

** CID 1351796:    (UNCAUGHT_EXCEPT)
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()


________________________________________________________________________________________________________
*** CID 1351796:    (UNCAUGHT_EXCEPT)
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1351796:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     

** CID 1351795:    (UNCAUGHT_EXCEPT)
/test/ObjectMap/test_keyvaluedb_iterators.cc: 1784 in main()
/test/ObjectMap/test_keyvaluedb_iterators.cc: 1784 in main()


________________________________________________________________________________________________________
*** CID 1351795:    (UNCAUGHT_EXCEPT)
/test/ObjectMap/test_keyvaluedb_iterators.cc: 1784 in main()
1778       SCOPED_TRACE("MockDB: Empty Store, Upper Bound");
1779       UpperBound(mock->get_iterator());
1780       ASSERT_FALSE(HasFatalFailure());
1781     }
1782     
1783     
>>>     CID 1351795:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
1784     int main(int argc, char *argv[])
1785     {
1786       vector<const char*> args;
1787       argv_to_vec(argc, (const char **) argv, args);
1788     
1789       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/ObjectMap/test_keyvaluedb_iterators.cc: 1784 in main()
1778       SCOPED_TRACE("MockDB: Empty Store, Upper Bound");
1779       UpperBound(mock->get_iterator());
1780       ASSERT_FALSE(HasFatalFailure());
1781     }
1782     
1783     
>>>     CID 1351795:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
1784     int main(int argc, char *argv[])
1785     {
1786       vector<const char*> args;
1787       argv_to_vec(argc, (const char **) argv, args);
1788     
1789       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);

** CID 1351794:    (UNCAUGHT_EXCEPT)
/tools/psim.cc: 7 in main()
/tools/psim.cc: 7 in main()
/tools/psim.cc: 7 in main()
/tools/psim.cc: 7 in main()


________________________________________________________________________________________________________
*** CID 1351794:    (UNCAUGHT_EXCEPT)
/tools/psim.cc: 7 in main()
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
2     // vim: ts=8 sw=2 smarttab
3     
4     #include "osd/OSDMap.h"
5     #include "include/buffer.h"
6     
>>>     CID 1351794:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
7     int main(int argc, char **argv)
8     {
9       /*
10        * you need to create a suitable osdmap first.  e.g., for 40 osds, 
11        * $ ./osdmaptool --createsimple 40 --clobber .ceph_osdmap
12        */
/tools/psim.cc: 7 in main()
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
2     // vim: ts=8 sw=2 smarttab
3     
4     #include "osd/OSDMap.h"
5     #include "include/buffer.h"
6     
>>>     CID 1351794:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
7     int main(int argc, char **argv)
8     {
9       /*
10        * you need to create a suitable osdmap first.  e.g., for 40 osds, 
11        * $ ./osdmaptool --createsimple 40 --clobber .ceph_osdmap
12        */
/tools/psim.cc: 7 in main()
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
2     // vim: ts=8 sw=2 smarttab
3     
4     #include "osd/OSDMap.h"
5     #include "include/buffer.h"
6     
>>>     CID 1351794:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
7     int main(int argc, char **argv)
8     {
9       /*
10        * you need to create a suitable osdmap first.  e.g., for 40 osds, 
11        * $ ./osdmaptool --createsimple 40 --clobber .ceph_osdmap
12        */
/tools/psim.cc: 7 in main()
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
2     // vim: ts=8 sw=2 smarttab
3     
4     #include "osd/OSDMap.h"
5     #include "include/buffer.h"
6     
>>>     CID 1351794:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
7     int main(int argc, char **argv)
8     {
9       /*
10        * you need to create a suitable osdmap first.  e.g., for 40 osds, 
11        * $ ./osdmaptool --createsimple 40 --clobber .ceph_osdmap
12        */


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/ceph?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c

