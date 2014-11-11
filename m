From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Tue, 11 Nov 2014 12:40:33 -0800
Message-ID: <546274419c35a_3916a97338434b1@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:55124 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbaKKUke (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Nov 2014 15:40:34 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

19 new defect(s) introduced to ceph found with Coverity Scan.
5 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 19 of 19 defect(s)


** CID 1251445:  Unchecked return value  (CHECKED_RETURN)
/mon/MDSMonitor.cc: 1511 in MDSMonitor::filesystem_command(MMonCommand *, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detai
 l::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_>, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::
 detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_>>>> &, std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>> &)()

** CID 1251446:  Unchecked return value  (CHECKED_RETURN)
/osd/PGBackend.cc: 292 in PGBackend::build_pg_backend(const pg_pool_t &, std::tr1::shared_ptr<const OSDMap>, PGBackend::Listener *, coll_t, coll_t, ObjectStore *, CephContext *)()

** CID 1251447:  Data race condition  (MISSING_LOCK)
/os/FileJournal.cc: 614 in FileJournal::start_writer()()

** CID 1251448:  Resource leak  (RESOURCE_LEAK)
/test/librados/TestCase.cc: 282 in RadosTest::cleanup_namespace(void *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>)()
/test/librados/TestCase.cc: 275 in RadosTest::cleanup_namespace(void *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>)()

** CID 1251449:  Resource leak  (RESOURCE_LEAK)
/test/librados/TestCase.cc: 52 in RadosTestNS::cleanup_all_objects(void *)()
/test/librados/TestCase.cc: 43 in RadosTestNS::cleanup_all_objects(void *)()

** CID 1251450:  Resource leak  (RESOURCE_LEAK)
/test/librbd/test_librbd.cc: 177 in TestLibRBD_CreateAndStat_Test::TestBody()()

** CID 1251451:  Resource leak  (RESOURCE_LEAK)
/test/librbd/test_librbd.cc: 1288 in TestLibRBD_ListChildren_Test::TestBody()()

** CID 1251452:  Resource leak  (RESOURCE_LEAK)
/test/librbd/test_librbd.cc: 1388 in TestLibRBD_ListChildrenTiered_Test::TestBody()()

** CID 1251453:  Resource leak  (RESOURCE_LEAK)
/test/system/st_rados_list_objects.cc: 72 in StRadosListObjects::run()()
/test/system/st_rados_list_objects.cc: 82 in StRadosListObjects::run()()

** CID 1251454:  Resource leak  (RESOURCE_LEAK)
/test/system/st_rados_list_objects.cc: 82 in StRadosListObjects::run()()

** CID 1251455:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/erasure-code/ceph_erasure_code_non_regression.cc: 300 in main()
/test/erasure-code/ceph_erasure_code_non_regression.cc: 300 in main()

** CID 1251456:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/erasure-code/ceph_erasure_code_non_regression.cc: 300 in main()

** CID 1251457:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/erasure-code/ceph_erasure_code_non_regression.cc: 300 in main()

** CID 1251458:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/erasure-code/ceph_erasure_code_non_regression.cc: 300 in main()

** CID 1251459:  Uninitialized pointer field  (UNINIT_CTOR)
/test/librados/TestCase.h: 24 in RadosTestNS::RadosTestNS()()

** CID 1251460:  Uninitialized pointer field  (UNINIT_CTOR)
/test/librados/TestCase.h: 76 in RadosTestECNS::RadosTestECNS()()

** CID 1251461:  Uninitialized scalar field  (UNINIT_CTOR)
/test/librados/TestCase.h: 93 in RadosTestECPPNS::RadosTestECPPNS()()

** CID 1251462:  Use after free  (USE_AFTER_FREE)
/test/librbd/test_librbd.cc: 299 in test_ls(void *, unsigned long, ...)()

** CID 1251463:  Missing varargs init or cleanup  (VARARGS)
/test/librbd/test_librbd.cc: 303 in test_ls(void *, unsigned long, ...)()


________________________________________________________________________________________________________
*** CID 1251445:  Unchecked return value  (CHECKED_RETURN)
/mon/MDSMonitor.cc: 1511 in MDSMonitor::filesystem_command(MMonCommand *, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detai
 l::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_>, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::
 detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_>>>> &, std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>> &)()
1505           r = -EINVAL;
1506           poolid = -1;
1507           ss << "cannot remove default data pool";
1508         }
1509     
1510         if (poolid >= 0) {
>>>     CID 1251445:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "cmd_getval" without checking return value (as is done elsewhere 19 out of 22 times).
1511           cmd_getval(g_ceph_context, cmdmap, "poolid", poolid);
1512           r = pending_mdsmap.remove_data_pool(poolid);
1513           if (r == -ENOENT)
1514     	r = 0;
1515           if (r == 0)
1516     	ss << "removed data pool " << poolid << " from mdsmap";

________________________________________________________________________________________________________
*** CID 1251446:  Unchecked return value  (CHECKED_RETURN)
/osd/PGBackend.cc: 292 in PGBackend::build_pg_backend(const pg_pool_t &, std::tr1::shared_ptr<const OSDMap>, PGBackend::Listener *, coll_t, coll_t, ObjectStore *, CephContext *)()
286       }
287       case pg_pool_t::TYPE_ERASURE: {
288         ErasureCodeInterfaceRef ec_impl;
289         const map<string,string> &profile = curmap->get_erasure_code_profile(pool.erasure_code_profile);
290         assert(profile.count("plugin"));
291         stringstream ss;
>>>     CID 1251446:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "factory" without checking return value (as is done elsewhere 8 out of 10 times).
292         ceph::ErasureCodePluginRegistry::instance().factory(
293           profile.find("plugin")->second,
294           profile,
295           &ec_impl,
296           ss);
297         assert(ec_impl);

________________________________________________________________________________________________________
*** CID 1251447:  Data race condition  (MISSING_LOCK)
/os/FileJournal.cc: 614 in FileJournal::start_writer()()
608     }
609     
610     
611     void FileJournal::start_writer()
612     {
613       write_stop = false;
>>>     CID 1251447:  Data race condition  (MISSING_LOCK)
>>>     Accessing "this->aio_stop" without holding lock "Mutex._m". Elsewhere, "FileJournal.aio_stop" is accessed with "Mutex._m" held 1 out of 2 times (1 of these accesses strongly imply that it is necessary).
614       aio_stop = false;
615       write_thread.create();
616     #ifdef HAVE_LIBAIO
617       if (aio)
618         write_finish_thread.create();
619     #endif

________________________________________________________________________________________________________
*** CID 1251448:  Resource leak  (RESOURCE_LEAK)
/test/librados/TestCase.cc: 282 in RadosTest::cleanup_namespace(void *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>)()
276       int r;
277       const char *entry = NULL;
278       const char *key = NULL;
279       while ((r = rados_nobjects_list_next(list_ctx, &entry, &key, NULL)) != -ENOENT) {
280         ASSERT_EQ(0, r);
281         rados_ioctx_locator_set_key(ioctx, key);
>>>     CID 1251448:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "list_ctx" going out of scope leaks the storage it points to.
282         ASSERT_EQ(0, rados_remove(ioctx, entry));
283       }
284       rados_nobjects_list_close(list_ctx);
285     }
286     
287     std::string RadosTestPP::pool_name;
/test/librados/TestCase.cc: 275 in RadosTest::cleanup_namespace(void *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>)()
269     
270     void RadosTest::cleanup_namespace(rados_ioctx_t ioctx, std::string ns)
271     {
272       rados_ioctx_snap_set_read(ioctx, LIBRADOS_SNAP_HEAD);
273       rados_ioctx_set_namespace(ioctx, ns.c_str());
274       rados_list_ctx_t list_ctx;
>>>     CID 1251448:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "list_ctx" going out of scope leaks the storage it points to.
275       ASSERT_EQ(0, rados_nobjects_list_open(ioctx, &list_ctx));
276       int r;
277       const char *entry = NULL;
278       const char *key = NULL;
279       while ((r = rados_nobjects_list_next(list_ctx, &entry, &key, NULL)) != -ENOENT) {
280         ASSERT_EQ(0, r);

________________________________________________________________________________________________________
*** CID 1251449:  Resource leak  (RESOURCE_LEAK)
/test/librados/TestCase.cc: 52 in RadosTestNS::cleanup_all_objects(void *)()
46       const char *key = NULL;
47       const char *nspace = NULL;
48       while ((r = rados_nobjects_list_next(list_ctx, &entry, &key, &nspace)) != -ENOENT) {
49         ASSERT_EQ(0, r);
50         rados_ioctx_locator_set_key(ioctx, key);
51         rados_ioctx_set_namespace(ioctx, nspace);
>>>     CID 1251449:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "list_ctx" going out of scope leaks the storage it points to.
52         ASSERT_EQ(0, rados_remove(ioctx, entry));
53       }
54       rados_nobjects_list_close(list_ctx);
55     }
56     
57     std::string RadosTestPPNS::pool_name;
/test/librados/TestCase.cc: 43 in RadosTestNS::cleanup_all_objects(void *)()
37     void RadosTestNS::cleanup_all_objects(rados_ioctx_t ioctx)
38     {
39       // remove all objects to avoid polluting other tests
40       rados_ioctx_snap_set_read(ioctx, LIBRADOS_SNAP_HEAD);
41       rados_ioctx_set_namespace(ioctx, LIBRADOS_ALL_NSPACES);
42       rados_list_ctx_t list_ctx;
>>>     CID 1251449:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "list_ctx" going out of scope leaks the storage it points to.
43       ASSERT_EQ(0, rados_nobjects_list_open(ioctx, &list_ctx));
44       int r;
45       const char *entry = NULL;
46       const char *key = NULL;
47       const char *nspace = NULL;
48       while ((r = rados_nobjects_list_next(list_ctx, &entry, &key, &nspace)) != -ENOENT) {

________________________________________________________________________________________________________
*** CID 1251450:  Resource leak  (RESOURCE_LEAK)
/test/librbd/test_librbd.cc: 177 in TestLibRBD_CreateAndStat_Test::TestBody()()
171     librados::Rados TestLibRBD::_rados;
172     uint64_t TestLibRBD::_image_number = 0;
173     
174     TEST_F(TestLibRBD, CreateAndStat)
175     {
176       rados_ioctx_t ioctx;
>>>     CID 1251450:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "ioctx" going out of scope leaks the storage it points to.
177       ASSERT_EQ(0, rados_ioctx_create(_cluster, m_pool_name.c_str(), &ioctx));
178     
179       rbd_image_info_t info;
180       rbd_image_t image;
181       int order = 0;
182       std::string name = get_temp_image_name();

________________________________________________________________________________________________________
*** CID 1251451:  Resource leak  (RESOURCE_LEAK)
/test/librbd/test_librbd.cc: 1288 in TestLibRBD_ListChildren_Test::TestBody()()
1282       std::string child_name1 = get_temp_image_name();
1283       std::string child_name2 = get_temp_image_name();
1284       std::string child_name3 = get_temp_image_name();
1285       std::string child_name4 = get_temp_image_name();
1286     
1287       // make a parent to clone from
>>>     CID 1251451:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "ioctx2" going out of scope leaks the storage it points to.
1288       ASSERT_EQ(0, create_image_full(ioctx1, parent_name.c_str(), 4<<20, &order,
1289     				 false, features));
1290       ASSERT_EQ(0, rbd_open(ioctx1, parent_name.c_str(), &parent, NULL));
1291       // create a snapshot, reopen as the parent we're interested in
1292       ASSERT_EQ(0, rbd_snap_create(parent, "parent_snap"));
1293       ASSERT_EQ(0, rbd_snap_set(parent, "parent_snap"));

________________________________________________________________________________________________________
*** CID 1251452:  Resource leak  (RESOURCE_LEAK)
/test/librbd/test_librbd.cc: 1388 in TestLibRBD_ListChildrenTiered_Test::TestBody()()
1382     
1383       int features = RBD_FEATURE_LAYERING;
1384       rbd_image_t parent;
1385       int order = 0;
1386     
1387       // make a parent to clone from
>>>     CID 1251452:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "ioctx2" going out of scope leaks the storage it points to.
1388       ASSERT_EQ(0, create_image_full(ioctx1, parent_name.c_str(), 4<<20, &order,
1389     				 false, features));
1390       ASSERT_EQ(0, rbd_open(ioctx1, parent_name.c_str(), &parent, NULL));
1391       // create a snapshot, reopen as the parent we're interested in
1392       ASSERT_EQ(0, rbd_snap_create(parent, "parent_snap"));
1393       ASSERT_EQ(0, rbd_snap_set(parent, "parent_snap"));

________________________________________________________________________________________________________
*** CID 1251453:  Resource leak  (RESOURCE_LEAK)
/test/system/st_rados_list_objects.cc: 72 in StRadosListObjects::run()()
66       RETURN1_IF_NONZERO(rados_ioctx_create(cl, "foo", &io_ctx));
67     
68       int saw = 0;
69       const char *obj_name;
70       rados_list_ctx_t h;
71       printf("%s: listing objects.\n", get_id_str());
>>>     CID 1251453:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "io_ctx" going out of scope leaks the storage it points to.
72       RETURN1_IF_NONZERO(rados_nobjects_list_open(io_ctx, &h));
73       while (true) {
74         int ret = rados_nobjects_list_next(h, &obj_name, NULL, NULL);
75         if (ret == -ENOENT) {
76           break;
77         }
/test/system/st_rados_list_objects.cc: 82 in StRadosListObjects::run()()
76           break;
77         }
78         else if (ret != 0) {
79           if (m_accept_list_errors && (!m_midway_sem_post || saw > m_midway_cnt))
80     	break;
81           printf("%s: rados_objects_list_next error: %d\n", get_id_str(), ret);
>>>     CID 1251453:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "io_ctx" going out of scope leaks the storage it points to.
82           return ret;
83         }
84         if ((saw % 25) == 0) {
85           printf("%s: listed object %d...\n", get_id_str(), saw);
86         }
87         ++saw;

________________________________________________________________________________________________________
*** CID 1251454:  Resource leak  (RESOURCE_LEAK)
/test/system/st_rados_list_objects.cc: 82 in StRadosListObjects::run()()
76           break;
77         }
78         else if (ret != 0) {
79           if (m_accept_list_errors && (!m_midway_sem_post || saw > m_midway_cnt))
80     	break;
81           printf("%s: rados_objects_list_next error: %d\n", get_id_str(), ret);
>>>     CID 1251454:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "h" going out of scope leaks the storage it points to.
82           return ret;
83         }
84         if ((saw % 25) == 0) {
85           printf("%s: listed object %d...\n", get_id_str(), saw);
86         }
87         ++saw;

________________________________________________________________________________________________________
*** CID 1251455:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/erasure-code/ceph_erasure_code_non_regression.cc: 300 in main()
294     {
295       stringstream path;
296       path << directory << "/" << chunk;
297       return path.str();
298     }
299     
>>>     CID 1251455:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
300     int main(int argc, char** argv) {
301       ErasureCodeNonRegression non_regression;
302       int err = non_regression.setup(argc, argv);
303       if (err)
304         return err;
305       return non_regression.run();
/test/erasure-code/ceph_erasure_code_non_regression.cc: 300 in main()
294     {
295       stringstream path;
296       path << directory << "/" << chunk;
297       return path.str();
298     }
299     
>>>     CID 1251455:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
300     int main(int argc, char** argv) {
301       ErasureCodeNonRegression non_regression;
302       int err = non_regression.setup(argc, argv);
303       if (err)
304         return err;
305       return non_regression.run();

________________________________________________________________________________________________________
*** CID 1251456:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/erasure-code/ceph_erasure_code_non_regression.cc: 300 in main()
294     {
295       stringstream path;
296       path << directory << "/" << chunk;
297       return path.str();
298     }
299     
>>>     CID 1251456:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_lexical_cast> >" is thrown and never caught.
300     int main(int argc, char** argv) {
301       ErasureCodeNonRegression non_regression;
302       int err = non_regression.setup(argc, argv);
303       if (err)
304         return err;
305       return non_regression.run();

________________________________________________________________________________________________________
*** CID 1251457:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/erasure-code/ceph_erasure_code_non_regression.cc: 300 in main()
294     {
295       stringstream path;
296       path << directory << "/" << chunk;
297       return path.str();
298     }
299     
>>>     CID 1251457:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
300     int main(int argc, char** argv) {
301       ErasureCodeNonRegression non_regression;
302       int err = non_regression.setup(argc, argv);
303       if (err)
304         return err;
305       return non_regression.run();

________________________________________________________________________________________________________
*** CID 1251458:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/erasure-code/ceph_erasure_code_non_regression.cc: 300 in main()
294     {
295       stringstream path;
296       path << directory << "/" << chunk;
297       return path.str();
298     }
299     
>>>     CID 1251458:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_function_call> >" is thrown and never caught.
300     int main(int argc, char** argv) {
301       ErasureCodeNonRegression non_regression;
302       int err = non_regression.setup(argc, argv);
303       if (err)
304         return err;
305       return non_regression.run();

________________________________________________________________________________________________________
*** CID 1251459:  Uninitialized pointer field  (UNINIT_CTOR)
/test/librados/TestCase.h: 24 in RadosTestNS::RadosTestNS()()
18      *
19      * Since pool creation and deletion is slow, this allows many tests to
20      * run faster.
21      */
22     class RadosTestNS : public ::testing::Test {
23     public:
>>>     CID 1251459:  Uninitialized pointer field  (UNINIT_CTOR)
>>>     Non-static class member "ioctx" is not initialized in this constructor nor in any functions that it calls.
24       RadosTestNS() {}
25       virtual ~RadosTestNS() {}
26     protected:
27       static void SetUpTestCase();
28       static void TearDownTestCase();
29       static void cleanup_all_objects(rados_ioctx_t ioctx);

________________________________________________________________________________________________________
*** CID 1251460:  Uninitialized pointer field  (UNINIT_CTOR)
/test/librados/TestCase.h: 76 in RadosTestECNS::RadosTestECNS()()
70       librados::Rados &cluster;
71       librados::IoCtx ioctx;
72     };
73     
74     class RadosTestECNS : public RadosTestNS {
75     public:
>>>     CID 1251460:  Uninitialized pointer field  (UNINIT_CTOR)
>>>     Non-static class member "alignment" is not initialized in this constructor nor in any functions that it calls.
76       RadosTestECNS() {}
77       virtual ~RadosTestECNS() {}
78     protected:
79       static void SetUpTestCase();
80       static void TearDownTestCase();
81       static rados_t s_cluster;

________________________________________________________________________________________________________
*** CID 1251461:  Uninitialized scalar field  (UNINIT_CTOR)
/test/librados/TestCase.h: 93 in RadosTestECPPNS::RadosTestECPPNS()()
87       rados_ioctx_t ioctx;
88       uint64_t alignment;
89     };
90     
91     class RadosTestECPPNS : public RadosTestPPNS {
92     public:
>>>     CID 1251461:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "alignment" is not initialized in this constructor nor in any functions that it calls.
93       RadosTestECPPNS() : cluster(s_cluster) {}
94       virtual ~RadosTestECPPNS() {}
95     protected:
96       static void SetUpTestCase();
97       static void TearDownTestCase();
98       static librados::Rados s_cluster;

________________________________________________________________________________________________________
*** CID 1251462:  Use after free  (USE_AFTER_FREE)
/test/librbd/test_librbd.cc: 299 in test_ls(void *, unsigned long, ...)()
293       va_start(ap, num_expected);
294       for (i = num_expected; i > 0; i--) {
295         char *expected = va_arg(ap, char *);
296         printf("expected = %s\n", expected);
297         std::set<std::string>::iterator it = image_names.find(expected);
298         if (it != image_names.end()) {
>>>     CID 1251462:  Use after free  (USE_AFTER_FREE)
>>>     Passing freed pointer "cur_name" as an argument to "printf".
299           printf("found %s\n", cur_name);
300           image_names.erase(it);
301         } else {
302           ADD_FAILURE() << "Unable to find image " << expected;
303           return -ENOENT;
304         }

________________________________________________________________________________________________________
*** CID 1251463:  Missing varargs init or cleanup  (VARARGS)
/test/librbd/test_librbd.cc: 303 in test_ls(void *, unsigned long, ...)()
297         std::set<std::string>::iterator it = image_names.find(expected);
298         if (it != image_names.end()) {
299           printf("found %s\n", cur_name);
300           image_names.erase(it);
301         } else {
302           ADD_FAILURE() << "Unable to find image " << expected;
>>>     CID 1251463:  Missing varargs init or cleanup  (VARARGS)
>>>     va_end was not called for "ap".
303           return -ENOENT;
304         }
305       }
306       va_end(ap);
307     
308       if (!image_names.empty()) {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



