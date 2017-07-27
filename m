From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 27 Jul 2017 03:50:24 +0000 (UTC)
Message-ID: <597962ffac427_273d7af32858674@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:22316 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751471AbdG0DuZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 26 Jul 2017 23:50:25 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0030p1mdw1.sendgrid.net (SG) with ESMTP id uD1EH_AmTdqwJjmsS-RtjA
        for <ceph-devel@vger.kernel.org>; Thu, 27 Jul 2017 03:50:24.327 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

119 new defect(s) introduced to ceph found with Coverity Scan.
10 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 119 defect(s)


** CID 742343:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.3.1/functional: 1862 in std::function<int (std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *)>::function()()


________________________________________________________________________________________________________
*** CID 742343:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.3.1/functional: 1862 in std::function<int (std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *)>::function()()
1856     
1857           /**
1858            *  @brief Default construct creates an empty function call wrapper.
1859            *  @post @c !(bool)*this
1860            */
1861           function() noexcept
>>>     CID 742343:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "_M_invoker" is not initialized in this constructor nor in any functions that it calls.
1862           : _Function_base() { }
1863     
1864           /**
1865            *  @brief Creates an empty function call wrapper.
1866            *  @post @c !(bool)*this
1867            */

** CID 1415737:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/rgw/test_http_manager.cc: 46 in main()
/home/brad/working/src/ceph/src/test/rgw/test_http_manager.cc: 46 in main()


________________________________________________________________________________________________________
*** CID 1415737:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/rgw/test_http_manager.cc: 46 in main()
40       for (size_t i = 0; i < num_requests; i++) {
41         RGWHTTPClient client{cct};
42         http.add_request(&client, "PUT", "https://u2389337.ct.sendgrid.net/wf/click?upn=fD34396FQoQ91T9x-2BhmXx3zqBikxIjbLh07rMjDngok-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8F5lXRZqPomtFYhumhQS7Ys56UCLMyraoRU8cAgH5Gb9p-2FOEaXwDBubR7a6vGsxgMl66a2ESHQ-2BDPgGAanQFq9zMj-2BvVvPhZ0KNXhClovkOFoICV8ApnfOJg22A8DyebqOnvcVPoFlLPJ7NKm-2FAP6YCEZCHZIDB4-2Fw8o1j0vzgp57YlHqZFQYywQinyxnevN-2Fg-3D");
43       }
44     }
45     
>>>     CID 1415737:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
46     int main(int argc, char** argv)
47     {
48       vector<const char*> args;
49       argv_to_vec(argc, (const char **)argv, args);
50     
51       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
/home/brad/working/src/ceph/src/test/rgw/test_http_manager.cc: 46 in main()
40       for (size_t i = 0; i < num_requests; i++) {
41         RGWHTTPClient client{cct};
42         http.add_request(&client, "PUT", "https://u2389337.ct.sendgrid.net/wf/click?upn=fD34396FQoQ91T9x-2BhmXx3zqBikxIjbLh07rMjDngok-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8F5lXRZqPomtFYhumhQS7Ys56UCLMyraoRU8cAgH5Gb9nO0iFRmZD9uPWZHcvbCWZ62mEVFjMkDtjtMAALfiMgyOgNHh3OXa0oRFVBiJXDXsNxmMeMbRDVrip9IFae-2B5nLiIMKNjJ6avJaRPApEflKbgvOiIhtgOIYYi6zG36Q7rqnZp786jKHmyzxQQLX-2B3-2FM-3D");
43       }
44     }
45     
>>>     CID 1415737:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
46     int main(int argc, char** argv)
47     {
48       vector<const char*> args;
49       argv_to_vec(argc, (const char **)argv, args);
50     
51       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,

** CID 1415738:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/journal/test_main.cc: 12 in main()
/home/brad/working/src/ceph/src/test/journal/test_main.cc: 12 in main()
/home/brad/working/src/ceph/src/test/journal/test_main.cc: 12 in main()


________________________________________________________________________________________________________
*** CID 1415738:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/journal/test_main.cc: 12 in main()
6     #include "common/ceph_crypto.h"
7     #include "common/config.h"
8     #include "global/global_context.h"
9     #include "global/global_init.h"
10     #include <vector>
11     
>>>     CID 1415738:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
12     int main(int argc, char **argv)
13     {
14       ::testing::InitGoogleTest(&argc, argv);
15     
16       std::vector<const char*> args;
17       argv_to_vec(argc, (const char **)argv, args);
/home/brad/working/src/ceph/src/test/journal/test_main.cc: 12 in main()
6     #include "common/ceph_crypto.h"
7     #include "common/config.h"
8     #include "global/global_context.h"
9     #include "global/global_init.h"
10     #include <vector>
11     
>>>     CID 1415738:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
12     int main(int argc, char **argv)
13     {
14       ::testing::InitGoogleTest(&argc, argv);
15     
16       std::vector<const char*> args;
17       argv_to_vec(argc, (const char **)argv, args);
/home/brad/working/src/ceph/src/test/journal/test_main.cc: 12 in main()
6     #include "common/ceph_crypto.h"
7     #include "common/config.h"
8     #include "global/global_context.h"
9     #include "global/global_init.h"
10     #include <vector>
11     
>>>     CID 1415738:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
12     int main(int argc, char **argv)
13     {
14       ::testing::InitGoogleTest(&argc, argv);
15     
16       std::vector<const char*> args;
17       argv_to_vec(argc, (const char **)argv, args);

** CID 1415739:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/omap_bench.cc: 414 in main()


________________________________________________________________________________________________________
*** CID 1415739:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/omap_bench.cc: 414 in main()
408     }
409     
410     /**
411      * runs the specified test with the specified parameters and generates
412      * a histogram of latencies
413      */
>>>     CID 1415739:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
414     int main(int argc, const char** argv) {
415       OmapBench ob;
416       int err = ob.setup(argc, argv);
417       if (err<0) {
418         cout << "error during setup: "<<err;
419         cout << std::endl;

** CID 1415740:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 4697 in C_ExtentCmpRead::C_ExtentCmpRead(PrimaryLogPG *, OSDOp &, boost::optional<unsigned int>, unsigned long, OSDService *, hobject_t, unsigned int)()


________________________________________________________________________________________________________
*** CID 1415740:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 4697 in C_ExtentCmpRead::C_ExtentCmpRead(PrimaryLogPG *, OSDOp &, boost::optional<unsigned int>, unsigned long, OSDService *, hobject_t, unsigned int)()
4691       Context *fill_extent_ctx;
4692     
4693       C_ExtentCmpRead(PrimaryLogPG *primary_log_pg, OSDOp &osd_op,
4694     		  boost::optional<uint32_t> maybe_crc, uint64_t size,
4695     		  OSDService *osd, hobject_t soid, __le32 flags)
4696         : primary_log_pg(primary_log_pg), osd_op(osd_op),
>>>     CID 1415740:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "fill_extent_ctx" of "C_ExtentCmpRead" but there is no destructor.
4697           fill_extent_ctx(new FillInVerifyExtent(&read_length, &osd_op.rval,
4698     					     &read_bl, maybe_crc, size,
4699     					     osd, soid, flags)) {
4700       }
4701     
4702       void finish(int r) override {

** CID 1415741:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/test_cors.cc: 882 in main()
/home/brad/working/src/ceph/src/test/test_cors.cc: 882 in main()


________________________________________________________________________________________________________
*** CID 1415741:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/test_cors.cc: 882 in main()
876       EXPECT_EQ(204U, g_test->get_resp_code());
877       g_test->send_request("GET", "/" S3_BUCKET_NAME "?cors");
878       EXPECT_EQ(404U, g_test->get_resp_code());
879       ASSERT_EQ(0, delete_bucket());
880     }
881     
>>>     CID 1415741:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
882     int main(int argc, char *argv[]){
883       vector<const char*> args;
884       argv_to_vec(argc, (const char **)argv, args);
885     
886       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
887                              CODE_ENVIRONMENT_UTILITY, 0);
/home/brad/working/src/ceph/src/test/test_cors.cc: 882 in main()
876       EXPECT_EQ(204U, g_test->get_resp_code());
877       g_test->send_request("GET", "/" S3_BUCKET_NAME "?cors");
878       EXPECT_EQ(404U, g_test->get_resp_code());
879       ASSERT_EQ(0, delete_bucket());
880     }
881     
>>>     CID 1415741:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
882     int main(int argc, char *argv[]){
883       vector<const char*> args;
884       argv_to_vec(argc, (const char **)argv, args);
885     
886       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
887                              CODE_ENVIRONMENT_UTILITY, 0);

** CID 1415742:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()


________________________________________________________________________________________________________
*** CID 1415742:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
19     #include "detailed_stat_collector.h"
20     #include "distribution.h"
21     
22     namespace po = boost::program_options;
23     using namespace std;
24     
>>>     CID 1415742:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
25     int main(int argc, char **argv)
26     {
27       po::options_description desc("Allowed options");
28       desc.add_options()
29         ("help", "produce help message")
30         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
19     #include "detailed_stat_collector.h"
20     #include "distribution.h"
21     
22     namespace po = boost::program_options;
23     using namespace std;
24     
>>>     CID 1415742:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
25     int main(int argc, char **argv)
26     {
27       po::options_description desc("Allowed options");
28       desc.add_options()
29         ("help", "produce help message")
30         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
19     #include "detailed_stat_collector.h"
20     #include "distribution.h"
21     
22     namespace po = boost::program_options;
23     using namespace std;
24     
>>>     CID 1415742:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
25     int main(int argc, char **argv)
26     {
27       po::options_description desc("Allowed options");
28       desc.add_options()
29         ("help", "produce help message")
30         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),

** CID 1415743:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/test_rgw_admin_opstate.cc: 804 in main()
/home/brad/working/src/ceph/src/test/test_rgw_admin_opstate.cc: 804 in main()


________________________________________________________________________________________________________
*** CID 1415743:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/test_rgw_admin_opstate.cc: 804 in main()
798       EXPECT_EQ(200U, g_test->get_resp_code());
799     
800       ASSERT_EQ(caps_rm(cname, perm), 0);
801       ASSERT_EQ(user_rm(uid, display_name), 0);
802     }
803     
>>>     CID 1415743:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
804     int main(int argc, char *argv[]){
805       vector<const char*> args;
806       argv_to_vec(argc, (const char **)argv, args);
807     
808       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
809     			 CODE_ENVIRONMENT_UTILITY, 0);
/home/brad/working/src/ceph/src/test/test_rgw_admin_opstate.cc: 804 in main()
798       EXPECT_EQ(200U, g_test->get_resp_code());
799     
800       ASSERT_EQ(caps_rm(cname, perm), 0);
801       ASSERT_EQ(user_rm(uid, display_name), 0);
802     }
803     
>>>     CID 1415743:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
804     int main(int argc, char *argv[]){
805       vector<const char*> args;
806       argv_to_vec(argc, (const char **)argv, args);
807     
808       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
809     			 CODE_ENVIRONMENT_UTILITY, 0);

** CID 1415744:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/messenger/simple_server.cc: 35 in main()
/home/brad/working/src/ceph/src/test/messenger/simple_server.cc: 35 in main()


________________________________________________________________________________________________________
*** CID 1415744:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/messenger/simple_server.cc: 35 in main()
29     #include "common/address_helper.h"
30     #include "simple_dispatcher.h"
31     
32     #define dout_subsys ceph_subsys_simple_server
33     
34     
>>>     CID 1415744:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
35     int main(int argc, const char **argv)
36     {
37     	vector<const char*> args;
38     	Messenger *messenger;
39     	Dispatcher *dispatcher;
40     	std::vector<const char*>::iterator arg_iter;
/home/brad/working/src/ceph/src/test/messenger/simple_server.cc: 35 in main()
29     #include "common/address_helper.h"
30     #include "simple_dispatcher.h"
31     
32     #define dout_subsys ceph_subsys_simple_server
33     
34     
>>>     CID 1415744:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
35     int main(int argc, const char **argv)
36     {
37     	vector<const char*> args;
38     	Messenger *messenger;
39     	Dispatcher *dispatcher;
40     	std::vector<const char*>::iterator arg_iter;

** CID 1415745:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3555 in main()
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3555 in main()


________________________________________________________________________________________________________
*** CID 1415745:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3555 in main()
3549     
3550     out:
3551       delete formatter;
3552       return (ret < 0) ? 1 : 0;
3553     }
3554     
>>>     CID 1415745:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
3555     int main(int argc, const char **argv)
3556     {
3557       vector<const char*> args;
3558       argv_to_vec(argc, argv, args);
3559       env_to_vec(args);
3560     
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3555 in main()
3549     
3550     out:
3551       delete formatter;
3552       return (ret < 0) ? 1 : 0;
3553     }
3554     
>>>     CID 1415745:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
3555     int main(int argc, const char **argv)
3556     {
3557       vector<const char*> args;
3558       argv_to_vec(argc, argv, args);
3559       env_to_vec(args);
3560     

** CID 1415746:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/objectstore/test_kv.cc: 329 in main()
/home/brad/working/src/ceph/src/test/objectstore/test_kv.cc: 329 in main()
/home/brad/working/src/ceph/src/test/objectstore/test_kv.cc: 329 in main()
/home/brad/working/src/ceph/src/test/objectstore/test_kv.cc: 329 in main()


________________________________________________________________________________________________________
*** CID 1415746:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/objectstore/test_kv.cc: 329 in main()
323     // point defined in that library (fatal error LNK1561: entry point
324     // must be defined). This dummy test keeps gtest_main linked in.
325     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
326     
327     #endif
328     
>>>     CID 1415746:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
329     int main(int argc, char **argv) {
330       vector<const char*> args;
331       argv_to_vec(argc, (const char **)argv, args);
332       env_to_vec(args);
333     
334       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
/home/brad/working/src/ceph/src/test/objectstore/test_kv.cc: 329 in main()
323     // point defined in that library (fatal error LNK1561: entry point
324     // must be defined). This dummy test keeps gtest_main linked in.
325     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
326     
327     #endif
328     
>>>     CID 1415746:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
329     int main(int argc, char **argv) {
330       vector<const char*> args;
331       argv_to_vec(argc, (const char **)argv, args);
332       env_to_vec(args);
333     
334       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
/home/brad/working/src/ceph/src/test/objectstore/test_kv.cc: 329 in main()
323     // point defined in that library (fatal error LNK1561: entry point
324     // must be defined). This dummy test keeps gtest_main linked in.
325     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
326     
327     #endif
328     
>>>     CID 1415746:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
329     int main(int argc, char **argv) {
330       vector<const char*> args;
331       argv_to_vec(argc, (const char **)argv, args);
332       env_to_vec(args);
333     
334       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
/home/brad/working/src/ceph/src/test/objectstore/test_kv.cc: 329 in main()
323     // point defined in that library (fatal error LNK1561: entry point
324     // must be defined). This dummy test keeps gtest_main linked in.
325     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
326     
327     #endif
328     
>>>     CID 1415746:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
329     int main(int argc, char **argv) {
330       vector<const char*> args;
331       argv_to_vec(argc, (const char **)argv, args);
332       env_to_vec(args);
333     
334       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,

** CID 1415747:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/test_filejournal.cc: 69 in main()
/home/brad/working/src/ceph/src/test/test_filejournal.cc: 69 in main()
/home/brad/working/src/ceph/src/test/test_filejournal.cc: 69 in main()
/home/brad/working/src/ceph/src/test/test_filejournal.cc: 69 in main()


________________________________________________________________________________________________________
*** CID 1415747:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/test_filejournal.cc: 69 in main()
63     };
64     
65     unsigned size_mb = 200;
66     //Gtest argument prefix
67     const char GTEST_PRFIX[] = "--gtest_";
68     
>>>     CID 1415747:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
69     int main(int argc, char **argv) {
70       vector<const char*> args;
71       argv_to_vec(argc, (const char **)argv, args);
72     
73       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
74     			 CODE_ENVIRONMENT_UTILITY, 0);
/home/brad/working/src/ceph/src/test/test_filejournal.cc: 69 in main()
63     };
64     
65     unsigned size_mb = 200;
66     //Gtest argument prefix
67     const char GTEST_PRFIX[] = "--gtest_";
68     
>>>     CID 1415747:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
69     int main(int argc, char **argv) {
70       vector<const char*> args;
71       argv_to_vec(argc, (const char **)argv, args);
72     
73       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
74     			 CODE_ENVIRONMENT_UTILITY, 0);
/home/brad/working/src/ceph/src/test/test_filejournal.cc: 69 in main()
63     };
64     
65     unsigned size_mb = 200;
66     //Gtest argument prefix
67     const char GTEST_PRFIX[] = "--gtest_";
68     
>>>     CID 1415747:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
69     int main(int argc, char **argv) {
70       vector<const char*> args;
71       argv_to_vec(argc, (const char **)argv, args);
72     
73       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
74     			 CODE_ENVIRONMENT_UTILITY, 0);
/home/brad/working/src/ceph/src/test/test_filejournal.cc: 69 in main()
63     };
64     
65     unsigned size_mb = 200;
66     //Gtest argument prefix
67     const char GTEST_PRFIX[] = "--gtest_";
68     
>>>     CID 1415747:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
69     int main(int argc, char **argv) {
70       vector<const char*> args;
71       argv_to_vec(argc, (const char **)argv, args);
72     
73       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
74     			 CODE_ENVIRONMENT_UTILITY, 0);

** CID 1415748:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/ObjectMap/test_keyvaluedb_iterators.cc: 1741 in main()
/home/brad/working/src/ceph/src/test/ObjectMap/test_keyvaluedb_iterators.cc: 1741 in main()


________________________________________________________________________________________________________
*** CID 1415748:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/ObjectMap/test_keyvaluedb_iterators.cc: 1741 in main()
/home/brad/working/src/ceph/src/test/ObjectMap/test_keyvaluedb_iterators.cc: 1741 in main()
1735       SCOPED_TRACE("MockDB: Empty Store, Upper Bound");
1736       UpperBound(mock->get_iterator());
1737       ASSERT_FALSE(HasFatalFailure());
1738     }
1739     
1740     
>>>     CID 1415748:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
1741     int main(int argc, char *argv[])
1742     {
1743       vector<const char*> args;
1744       argv_to_vec(argc, (const char **) argv, args);
1745     
1746       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);

** CID 1415749:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rbd_mirror/main.cc: 32 in main()
/home/brad/working/src/ceph/src/tools/rbd_mirror/main.cc: 32 in main()
/home/brad/working/src/ceph/src/tools/rbd_mirror/main.cc: 32 in main()


________________________________________________________________________________________________________
*** CID 1415749:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1415749:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       env_to_vec(args);
36       argv_to_vec(argc, argv, args);
37     
/home/brad/working/src/ceph/src/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1415749:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       env_to_vec(args);
36       argv_to_vec(argc, argv, args);
37     
/home/brad/working/src/ceph/src/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1415749:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       env_to_vec(args);
36       argv_to_vec(argc, argv, args);
37     

** CID 1415750:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/objectstore/test_idempotent_sequence.cc: 202 in main()
/home/brad/working/src/ceph/src/test/objectstore/test_idempotent_sequence.cc: 202 in main()
/home/brad/working/src/ceph/src/test/objectstore/test_idempotent_sequence.cc: 202 in main()


________________________________________________________________________________________________________
*** CID 1415750:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/objectstore/test_idempotent_sequence.cc: 202 in main()
196       }
197     
198       usage(our_name, command);
199       exit(1);
200     }
201     
>>>     CID 1415750:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
202     int main(int argc, const char *argv[])
203     {
204       vector<const char*> def_args;
205       vector<const char*> args;
206       our_name = argv[0];
207       argv_to_vec(argc, argv, args);
/home/brad/working/src/ceph/src/test/objectstore/test_idempotent_sequence.cc: 202 in main()
196       }
197     
198       usage(our_name, command);
199       exit(1);
200     }
201     
>>>     CID 1415750:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
202     int main(int argc, const char *argv[])
203     {
204       vector<const char*> def_args;
205       vector<const char*> args;
206       our_name = argv[0];
207       argv_to_vec(argc, argv, args);
/home/brad/working/src/ceph/src/test/objectstore/test_idempotent_sequence.cc: 202 in main()
196       }
197     
198       usage(our_name, command);
199       exit(1);
200     }
201     
>>>     CID 1415750:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
202     int main(int argc, const char *argv[])
203     {
204       vector<const char*> def_args;
205       vector<const char*> args;
206       our_name = argv[0];
207       argv_to_vec(argc, argv, args);

** CID 1415751:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/libcephfs/access.cc: 362 in main()
/home/brad/working/src/ceph/src/test/libcephfs/access.cc: 362 in main()
/home/brad/working/src/ceph/src/test/libcephfs/access.cc: 362 in main()
/home/brad/working/src/ceph/src/test/libcephfs/access.cc: 362 in main()


________________________________________________________________________________________________________
*** CID 1415751:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/libcephfs/access.cc: 362 in main()
356     out:
357       ceph_shutdown(admin);
358       return r;
359     }
360     
361     
>>>     CID 1415751:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
362     int main(int argc, char **argv)
363     {
364       int r = update_root_mode();
365       if (r < 0)
366         exit(1);
367     
/home/brad/working/src/ceph/src/test/libcephfs/access.cc: 362 in main()
356     out:
357       ceph_shutdown(admin);
358       return r;
359     }
360     
361     
>>>     CID 1415751:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
362     int main(int argc, char **argv)
363     {
364       int r = update_root_mode();
365       if (r < 0)
366         exit(1);
367     
/home/brad/working/src/ceph/src/test/libcephfs/access.cc: 362 in main()
356     out:
357       ceph_shutdown(admin);
358       return r;
359     }
360     
361     
>>>     CID 1415751:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
362     int main(int argc, char **argv)
363     {
364       int r = update_root_mode();
365       if (r < 0)
366         exit(1);
367     
/home/brad/working/src/ceph/src/test/libcephfs/access.cc: 362 in main()
356     out:
357       ceph_shutdown(admin);
358       return r;
359     }
360     
361     
>>>     CID 1415751:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
362     int main(int argc, char **argv)
363     {
364       int r = update_root_mode();
365       if (r < 0)
366         exit(1);
367     

** CID 1415752:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/crushtool.cc: 242 in main()
/home/brad/working/src/ceph/src/tools/crushtool.cc: 242 in main()


________________________________________________________________________________________________________
*** CID 1415752:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/crushtool.cc: 242 in main()
236     struct layer_t {
237       const char *name;
238       const char *buckettype;
239       int size;
240     };
241     
>>>     CID 1415752:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
242     int main(int argc, const char **argv)
243     {
244       vector<const char*> args;
245       argv_to_vec(argc, argv, args);
246     
247       const char *me = argv[0];
/home/brad/working/src/ceph/src/tools/crushtool.cc: 242 in main()
236     struct layer_t {
237       const char *name;
238       const char *buckettype;
239       int size;
240     };
241     
>>>     CID 1415752:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
242     int main(int argc, const char **argv)
243     {
244       vector<const char*> args;
245       argv_to_vec(argc, argv, args);
246     
247       const char *me = argv[0];

** CID 1415753:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
/home/brad/working/src/ceph/src/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
/home/brad/working/src/ceph/src/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()


________________________________________________________________________________________________________
*** CID 1415753:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
238     
239     void usage(const string &name) {
240       cerr << "Usage: " << name << " [times] "
241            << std::endl;
242     }
243     
>>>     CID 1415753:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
244     int main(int argc, char **argv)
245     {
246       vector<const char*> args;
247       argv_to_vec(argc, (const char **)argv, args);
248     
249       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
/home/brad/working/src/ceph/src/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
238     
239     void usage(const string &name) {
240       cerr << "Usage: " << name << " [times] "
241            << std::endl;
242     }
243     
>>>     CID 1415753:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
244     int main(int argc, char **argv)
245     {
246       vector<const char*> args;
247       argv_to_vec(argc, (const char **)argv, args);
248     
249       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,
/home/brad/working/src/ceph/src/test/objectstore/ObjectStoreTransactionBenchmark.cc: 244 in main()
238     
239     void usage(const string &name) {
240       cerr << "Usage: " << name << " [times] "
241            << std::endl;
242     }
243     
>>>     CID 1415753:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
244     int main(int argc, char **argv)
245     {
246       vector<const char*> args;
247       argv_to_vec(argc, (const char **)argv, args);
248     
249       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,

** CID 1415754:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/objectstore/test_memstore_clone.cc: 178 in main()
/home/brad/working/src/ceph/src/test/objectstore/test_memstore_clone.cc: 178 in main()


________________________________________________________________________________________________________
*** CID 1415754:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/objectstore/test_memstore_clone.cc: 178 in main()
172       t.clone_range(cid, src, dst, 2, 8, 2);
173       ASSERT_EQ(0u, store->apply_transaction(nullptr, std::move(t)));
174       ASSERT_EQ(12, store->read(cid, dst, 0, 12, result));
175       ASSERT_EQ(expected, result);
176     }
177     
>>>     CID 1415754:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
178     int main(int argc, char** argv)
179     {
180       // default to memstore
181       vector<const char*> defaults{
182         "--osd_objectstore", "memstore",
183         "--osd_data", "msc.test_temp_dir",
/home/brad/working/src/ceph/src/test/objectstore/test_memstore_clone.cc: 178 in main()
172       t.clone_range(cid, src, dst, 2, 8, 2);
173       ASSERT_EQ(0u, store->apply_transaction(nullptr, std::move(t)));
174       ASSERT_EQ(12, store->read(cid, dst, 0, 12, result));
175       ASSERT_EQ(expected, result);
176     }
177     
>>>     CID 1415754:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
178     int main(int argc, char** argv)
179     {
180       // default to memstore
181       vector<const char*> defaults{
182         "--osd_objectstore", "memstore",
183         "--osd_data", "msc.test_temp_dir",

** CID 1415755:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1415755:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/mon/MonCommand.h: 39 in MonCommand::encode(ceph::buffer::list &) const()
33     
34       bool has_flag(uint64_t flag) const { return (flags & flag) != 0; }
35       void set_flag(uint64_t flag) { flags |= flag; }
36       void unset_flag(uint64_t flag) { flags &= ~flag; }
37     
38       void encode(bufferlist &bl) const {
>>>     CID 1415755:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
39         ENCODE_START(1, 1, bl);
40         encode_bare(bl);
41         ::encode(flags, bl);
42         ENCODE_FINISH(bl);
43       }
44     


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8F5lXRZqPomtFYhumhQS7Ys56UCLMyraoRU8cAgH5Gb9r7Tl14jaYgei9cmXUNtbkKA9CKloT1XjbviuMsCqkdz1egGjn1xXAwJTyshEhHNeYGifRuQQEpdBBZHTWtIurE2UL1R9kFjuncnHFGhWm-2FVRCsu5aVc-2B1KJM2BNeVvtTrdR1ozfp02EGO22F4feolk-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8F5lXRZqPomtFYhumhQS7Ys56UCLMyraoRU8cAgH5Gb9j-2Bpg6pHeTbKjI8DZWvhcJ0ZQPkkgqILLEefrJ3oXrTmCx5mhrh4-2BH5NegCIozE0Zs-2FkYK238q0u-2FoKoWnynQmdqdfGpx2b4vg90WpcOaaYTpFNyKK6W7Wl0SbftvvVpG8XqwTL3XY3hI9hT1r14OCg-3D

