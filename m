From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sat, 02 May 2015 07:37:00 -0700
Message-ID: <5544e10c7c52d_71dd125b3307783d@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:41840 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934382AbbI1RUZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 13:20:25 -0400
Received: from us02secmta1.synopsys.com (us02secmta1.synopsys.com [10.12.235.96])
	by smtprelay.synopsys.com (Postfix) with ESMTP id EF25A10C0B5E
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Received: from us02secmta1.internal.synopsys.com (us02secmta1.internal.synopsys.com [127.0.0.1])
	by us02secmta1.internal.synopsys.com (Service) with ESMTP id E71544E220
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Received: from mailhost.synopsys.com (unknown [10.13.184.66])
	by us02secmta1.internal.synopsys.com (Service) with ESMTP id A44A04E21E
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
	by mailhost.synopsys.com (Postfix) with ESMTP id 8D800529
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.internal.synopsys.com [10.0.8.65])
	by mailhost.synopsys.com (Postfix) with ESMTP id 7F0CA527
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

14 new defect(s) introduced to ceph found with Coverity Scan.
4 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 14 of 14 defect(s)


** CID 1296388:  Uninitialized members  (UNINIT_CTOR)
/librbd/RebuildObjectMapRequest.cc: 35 in librbd::<unnamed>::C_VerifyObject::C_VerifyObject(librbd::AsyncObjectThrottle &, librbd::ImageCtx *, unsigned long, unsigned long)()


________________________________________________________________________________________________________
*** CID 1296388:  Uninitialized members  (UNINIT_CTOR)
/librbd/RebuildObjectMapRequest.cc: 35 in librbd::<unnamed>::C_VerifyObject::C_VerifyObject(librbd::AsyncObjectThrottle &, librbd::ImageCtx *, unsigned long, unsigned long)()
29         : C_AsyncObjectThrottle(throttle), m_image_ctx(*image_ctx),
30           m_snap_id(snap_id), m_object_no(object_no),
31           m_oid(m_image_ctx.get_object_name(m_object_no))
32       {
33         m_io_ctx.dup(m_image_ctx.md_ctx);
34         m_io_ctx.snap_set_read(CEPH_SNAPDIR);
>>>     CID 1296388:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_snap_list_ret" is not initialized in this constructor nor in any functions that it calls.
35       }
36     
37       virtual void complete(int r) {
38         if (should_complete(r)) {
39           ldout(m_image_ctx.cct, 20) << m_oid << " C_VerifyObject completed "
40                                      << dendl;

** CID 1296387:    (UNCAUGHT_EXCEPT)
/test/system/rados_watch_notify.cc: 59 in main()
/test/system/rados_watch_notify.cc: 59 in main()
/test/system/rados_watch_notify.cc: 59 in main()
/test/system/rados_watch_notify.cc: 59 in main()


________________________________________________________________________________________________________
*** CID 1296387:    (UNCAUGHT_EXCEPT)
/test/system/rados_watch_notify.cc: 59 in main()
53     
54     const char *get_id_str()
55     {
56       return "main";
57     }
58     
>>>     CID 1296387:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
59     int main(int argc, const char **argv)
60     {
61       std::string pool = "foo." + stringify(getpid());
62       CrossProcessSem *setup_sem = NULL;
63       RETURN1_IF_NONZERO(CrossProcessSem::create(0, &setup_sem));
64       CrossProcessSem *watch_sem = NULL;
/test/system/rados_watch_notify.cc: 59 in main()
53     
54     const char *get_id_str()
55     {
56       return "main";
57     }
58     
>>>     CID 1296387:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
59     int main(int argc, const char **argv)
60     {
61       std::string pool = "foo." + stringify(getpid());
62       CrossProcessSem *setup_sem = NULL;
63       RETURN1_IF_NONZERO(CrossProcessSem::create(0, &setup_sem));
64       CrossProcessSem *watch_sem = NULL;
/test/system/rados_watch_notify.cc: 59 in main()
53     
54     const char *get_id_str()
55     {
56       return "main";
57     }
58     
>>>     CID 1296387:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
59     int main(int argc, const char **argv)
60     {
61       std::string pool = "foo." + stringify(getpid());
62       CrossProcessSem *setup_sem = NULL;
63       RETURN1_IF_NONZERO(CrossProcessSem::create(0, &setup_sem));
64       CrossProcessSem *watch_sem = NULL;
/test/system/rados_watch_notify.cc: 59 in main()
53     
54     const char *get_id_str()
55     {
56       return "main";
57     }
58     
>>>     CID 1296387:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
59     int main(int argc, const char **argv)
60     {
61       std::string pool = "foo." + stringify(getpid());
62       CrossProcessSem *setup_sem = NULL;
63       RETURN1_IF_NONZERO(CrossProcessSem::create(0, &setup_sem));
64       CrossProcessSem *watch_sem = NULL;

** CID 1296386:    (UNCAUGHT_EXCEPT)
/test/system/rados_open_pools_parallel.cc: 98 in main()
/test/system/rados_open_pools_parallel.cc: 98 in main()


________________________________________________________________________________________________________
*** CID 1296386:    (UNCAUGHT_EXCEPT)
/test/system/rados_open_pools_parallel.cc: 98 in main()
92     
93     const char *get_id_str()
94     {
95       return "main";
96     }
97     
>>>     CID 1296386:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
98     int main(int argc, const char **argv)
99     {
100       // first test: create a pool, shut down the client, access that 
101       // pool in a different process.
102       CrossProcessSem *pool_setup_sem = NULL;
103       RETURN1_IF_NONZERO(CrossProcessSem::create(0, &pool_setup_sem));
/test/system/rados_open_pools_parallel.cc: 98 in main()
92     
93     const char *get_id_str()
94     {
95       return "main";
96     }
97     
>>>     CID 1296386:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
98     int main(int argc, const char **argv)
99     {
100       // first test: create a pool, shut down the client, access that 
101       // pool in a different process.
102       CrossProcessSem *pool_setup_sem = NULL;
103       RETURN1_IF_NONZERO(CrossProcessSem::create(0, &pool_setup_sem));

** CID 1296385:    (UNCAUGHT_EXCEPT)
/test/system/rados_delete_pools_parallel.cc: 57 in main()
/test/system/rados_delete_pools_parallel.cc: 57 in main()


________________________________________________________________________________________________________
*** CID 1296385:    (UNCAUGHT_EXCEPT)
/test/system/rados_delete_pools_parallel.cc: 57 in main()
51     
52     const char *get_id_str()
53     {
54       return "main";
55     }
56     
>>>     CID 1296385:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
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
>>>     CID 1296385:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
57     int main(int argc, const char **argv)
58     {
59       const char *num_objects = getenv("NUM_OBJECTS");
60       std::string pool = "foo";
61       if (num_objects) {
62         g_num_objects = atoi(num_objects); 

** CID 1296384:    (UNCAUGHT_EXCEPT)
/test/librbd/fsx.cc: 1981 in main()
/test/librbd/fsx.cc: 1981 in main()
/test/librbd/fsx.cc: 1981 in main()
/test/librbd/fsx.cc: 1981 in main()
/test/librbd/fsx.cc: 1981 in main()
/test/librbd/fsx.cc: 1981 in main()
/test/librbd/fsx.cc: 1981 in main()
/test/librbd/fsx.cc: 1981 in main()
/test/librbd/fsx.cc: 1981 in main()


________________________________________________________________________________________________________
*** CID 1296384:    (UNCAUGHT_EXCEPT)
/test/librbd/fsx.cc: 1981 in main()
1975     	fallocate_calls = 0;
1976     #endif
1977     
1978     }
1979     
1980     int
>>>     CID 1296384:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
1981     main(int argc, char **argv)
1982     {
1983     	int	i, style, ch, ret;
1984     	char	*endp;
1985     	char goodfile[1024];
1986     	char logfile[1024];
/test/librbd/fsx.cc: 1981 in main()
1975     	fallocate_calls = 0;
1976     #endif
1977     
1978     }
1979     
1980     int
>>>     CID 1296384:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
1981     main(int argc, char **argv)
1982     {
1983     	int	i, style, ch, ret;
1984     	char	*endp;
1985     	char goodfile[1024];
1986     	char logfile[1024];
/test/librbd/fsx.cc: 1981 in main()
1975     	fallocate_calls = 0;
1976     #endif
1977     
1978     }
1979     
1980     int
>>>     CID 1296384:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
1981     main(int argc, char **argv)
1982     {
1983     	int	i, style, ch, ret;
1984     	char	*endp;
1985     	char goodfile[1024];
1986     	char logfile[1024];
/test/librbd/fsx.cc: 1981 in main()
1975     	fallocate_calls = 0;
1976     #endif
1977     
1978     }
1979     
1980     int
>>>     CID 1296384:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
1981     main(int argc, char **argv)
1982     {
1983     	int	i, style, ch, ret;
1984     	char	*endp;
1985     	char goodfile[1024];
1986     	char logfile[1024];
/test/librbd/fsx.cc: 1981 in main()
1975     	fallocate_calls = 0;
1976     #endif
1977     
1978     }
1979     
1980     int
>>>     CID 1296384:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
1981     main(int argc, char **argv)
1982     {
1983     	int	i, style, ch, ret;
1984     	char	*endp;
1985     	char goodfile[1024];
1986     	char logfile[1024];
/test/librbd/fsx.cc: 1981 in main()
1975     	fallocate_calls = 0;
1976     #endif
1977     
1978     }
1979     
1980     int
>>>     CID 1296384:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
1981     main(int argc, char **argv)
1982     {
1983     	int	i, style, ch, ret;
1984     	char	*endp;
1985     	char goodfile[1024];
1986     	char logfile[1024];
/test/librbd/fsx.cc: 1981 in main()
1975     	fallocate_calls = 0;
1976     #endif
1977     
1978     }
1979     
1980     int
>>>     CID 1296384:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
1981     main(int argc, char **argv)
1982     {
1983     	int	i, style, ch, ret;
1984     	char	*endp;
1985     	char goodfile[1024];
1986     	char logfile[1024];
/test/librbd/fsx.cc: 1981 in main()
1975     	fallocate_calls = 0;
1976     #endif
1977     
1978     }
1979     
1980     int
>>>     CID 1296384:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
1981     main(int argc, char **argv)
1982     {
1983     	int	i, style, ch, ret;
1984     	char	*endp;
1985     	char goodfile[1024];
1986     	char logfile[1024];
/test/librbd/fsx.cc: 1981 in main()
1975     	fallocate_calls = 0;
1976     #endif
1977     
1978     }
1979     
1980     int
>>>     CID 1296384:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
1981     main(int argc, char **argv)
1982     {
1983     	int	i, style, ch, ret;
1984     	char	*endp;
1985     	char goodfile[1024];
1986     	char logfile[1024];

** CID 1296383:    (RESOURCE_LEAK)
/test/libcephfs/test.cc: 902 in LibCephFS_BadArgument_Test::TestBody()()
/test/libcephfs/test.cc: 900 in LibCephFS_BadArgument_Test::TestBody()()
/test/libcephfs/test.cc: 899 in LibCephFS_BadArgument_Test::TestBody()()
/test/libcephfs/test.cc: 897 in LibCephFS_BadArgument_Test::TestBody()()
/test/libcephfs/test.cc: 894 in LibCephFS_BadArgument_Test::TestBody()()
/test/libcephfs/test.cc: 893 in LibCephFS_BadArgument_Test::TestBody()()
/test/libcephfs/test.cc: 892 in LibCephFS_BadArgument_Test::TestBody()()
/test/libcephfs/test.cc: 891 in LibCephFS_BadArgument_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1296383:    (RESOURCE_LEAK)
/test/libcephfs/test.cc: 902 in LibCephFS_BadArgument_Test::TestBody()()
896       int fd = ceph_open(cmount, "test_file", O_CREAT|O_RDWR, 0666);
897       ASSERT_GT(fd, 0);
898       char buf[100];
899       ASSERT_EQ(ceph_write(cmount, fd, buf, sizeof(buf), 0), (int)sizeof(buf));
900       ASSERT_EQ(ceph_read(cmount, fd, buf, 5, 0), 0);
901       ceph_close(cmount, fd);
>>>     CID 1296383:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
902       ASSERT_EQ(ceph_unlink(cmount, "test_file"), 0);
903     
904       ceph_shutdown(cmount);
905     }
906     
907     TEST(LibCephFS, BadFileDesc) {
/test/libcephfs/test.cc: 900 in LibCephFS_BadArgument_Test::TestBody()()
894       ASSERT_EQ(ceph_mount(cmount, NULL), 0);
895     
896       int fd = ceph_open(cmount, "test_file", O_CREAT|O_RDWR, 0666);
897       ASSERT_GT(fd, 0);
898       char buf[100];
899       ASSERT_EQ(ceph_write(cmount, fd, buf, sizeof(buf), 0), (int)sizeof(buf));
>>>     CID 1296383:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
900       ASSERT_EQ(ceph_read(cmount, fd, buf, 5, 0), 0);
901       ceph_close(cmount, fd);
902       ASSERT_EQ(ceph_unlink(cmount, "test_file"), 0);
903     
904       ceph_shutdown(cmount);
905     }
/test/libcephfs/test.cc: 899 in LibCephFS_BadArgument_Test::TestBody()()
893       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
894       ASSERT_EQ(ceph_mount(cmount, NULL), 0);
895     
896       int fd = ceph_open(cmount, "test_file", O_CREAT|O_RDWR, 0666);
897       ASSERT_GT(fd, 0);
898       char buf[100];
>>>     CID 1296383:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
899       ASSERT_EQ(ceph_write(cmount, fd, buf, sizeof(buf), 0), (int)sizeof(buf));
900       ASSERT_EQ(ceph_read(cmount, fd, buf, 5, 0), 0);
901       ceph_close(cmount, fd);
902       ASSERT_EQ(ceph_unlink(cmount, "test_file"), 0);
903     
904       ceph_shutdown(cmount);
/test/libcephfs/test.cc: 897 in LibCephFS_BadArgument_Test::TestBody()()
891       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
892       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
893       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
894       ASSERT_EQ(ceph_mount(cmount, NULL), 0);
895     
896       int fd = ceph_open(cmount, "test_file", O_CREAT|O_RDWR, 0666);
>>>     CID 1296383:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
897       ASSERT_GT(fd, 0);
898       char buf[100];
899       ASSERT_EQ(ceph_write(cmount, fd, buf, sizeof(buf), 0), (int)sizeof(buf));
900       ASSERT_EQ(ceph_read(cmount, fd, buf, 5, 0), 0);
901       ceph_close(cmount, fd);
902       ASSERT_EQ(ceph_unlink(cmount, "test_file"), 0);
/test/libcephfs/test.cc: 894 in LibCephFS_BadArgument_Test::TestBody()()
888     
889     TEST(LibCephFS, BadArgument) {
890       struct ceph_mount_info *cmount;
891       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
892       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
893       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
>>>     CID 1296383:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
894       ASSERT_EQ(ceph_mount(cmount, NULL), 0);
895     
896       int fd = ceph_open(cmount, "test_file", O_CREAT|O_RDWR, 0666);
897       ASSERT_GT(fd, 0);
898       char buf[100];
899       ASSERT_EQ(ceph_write(cmount, fd, buf, sizeof(buf), 0), (int)sizeof(buf));
/test/libcephfs/test.cc: 893 in LibCephFS_BadArgument_Test::TestBody()()
887     }
888     
889     TEST(LibCephFS, BadArgument) {
890       struct ceph_mount_info *cmount;
891       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
892       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
>>>     CID 1296383:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
893       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
894       ASSERT_EQ(ceph_mount(cmount, NULL), 0);
895     
896       int fd = ceph_open(cmount, "test_file", O_CREAT|O_RDWR, 0666);
897       ASSERT_GT(fd, 0);
898       char buf[100];
/test/libcephfs/test.cc: 892 in LibCephFS_BadArgument_Test::TestBody()()
886       ceph_shutdown(cmount);
887     }
888     
889     TEST(LibCephFS, BadArgument) {
890       struct ceph_mount_info *cmount;
891       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
>>>     CID 1296383:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
892       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
893       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
894       ASSERT_EQ(ceph_mount(cmount, NULL), 0);
895     
896       int fd = ceph_open(cmount, "test_file", O_CREAT|O_RDWR, 0666);
897       ASSERT_GT(fd, 0);
/test/libcephfs/test.cc: 891 in LibCephFS_BadArgument_Test::TestBody()()
885     
886       ceph_shutdown(cmount);
887     }
888     
889     TEST(LibCephFS, BadArgument) {
890       struct ceph_mount_info *cmount;
>>>     CID 1296383:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
891       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
892       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
893       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
894       ASSERT_EQ(ceph_mount(cmount, NULL), 0);
895     
896       int fd = ceph_open(cmount, "test_file", O_CREAT|O_RDWR, 0666);

** CID 1296382:  Resource leaks  (RESOURCE_LEAK)
/auth/Crypto.cc: 358 in CryptoAES::get_key_handler(const ceph::buffer::ptr &, std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()


________________________________________________________________________________________________________
*** CID 1296382:  Resource leaks  (RESOURCE_LEAK)
/auth/Crypto.cc: 358 in CryptoAES::get_key_handler(const ceph::buffer::ptr &, std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()
352     					     string& error)
353     {
354       CryptoAESKeyHandler *ckh = new CryptoAESKeyHandler;
355       ostringstream oss;
356       if (ckh->init(secret, oss) < 0) {
357         error = oss.str();
>>>     CID 1296382:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "ckh" going out of scope leaks the storage it points to.
358         return NULL;
359       }
360       return ckh;
361     }
362     
363     

** CID 1296381:    (CONSTANT_EXPRESSION_RESULT)
/test/librbd/test_librbd.cc: 2181 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2189 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2198 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2204 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2214 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2225 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2175 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()


________________________________________________________________________________________________________
*** CID 1296381:    (CONSTANT_EXPRESSION_RESULT)
/test/librbd/test_librbd.cc: 2181 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
2175       if (this->whole_object) {
2176         object_size = 1 << order;
2177       }
2178       vector<diff_extent> extents;
2179       ceph::bufferlist bl;
2180     
>>>     CID 1296381:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2181       ASSERT_EQ(0, image.diff_iterate2(NULL, 0, size, true, this->whole_object,
2182           			           vector_iterate_cb, (void *) &extents));
2183       ASSERT_EQ(0u, extents.size());
2184     
2185       char data[256];
2186       memset(data, 1, sizeof(data));
/test/librbd/test_librbd.cc: 2189 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
2183       ASSERT_EQ(0u, extents.size());
2184     
2185       char data[256];
2186       memset(data, 1, sizeof(data));
2187       bl.append(data, 256);
2188       ASSERT_EQ(256, image.write(0, 256, bl));
>>>     CID 1296381:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2189       ASSERT_EQ(0, image.diff_iterate2(NULL, 0, size, true, this->whole_object,
2190           			           vector_iterate_cb, (void *) &extents));
2191       ASSERT_EQ(1u, extents.size());
2192       ASSERT_EQ(diff_extent(0, 256, true, object_size), extents[0]);
2193     
2194       int obj_ofs = 256;
/test/librbd/test_librbd.cc: 2198 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
2192       ASSERT_EQ(diff_extent(0, 256, true, object_size), extents[0]);
2193     
2194       int obj_ofs = 256;
2195       ASSERT_EQ(1 << order, image.discard(0, 1 << order));
2196     
2197       extents.clear();
>>>     CID 1296381:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2198       ASSERT_EQ(0, image.diff_iterate2(NULL, 0, size, true, this->whole_object,
2199           			           vector_iterate_cb, (void *) &extents));
2200       ASSERT_EQ(0u, extents.size());
2201     
2202       ASSERT_EQ(0, image.snap_create("snap1"));
2203       ASSERT_EQ(256, image.write(0, 256, bl));
/test/librbd/test_librbd.cc: 2204 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
2198       ASSERT_EQ(0, image.diff_iterate2(NULL, 0, size, true, this->whole_object,
2199           			           vector_iterate_cb, (void *) &extents));
2200       ASSERT_EQ(0u, extents.size());
2201     
2202       ASSERT_EQ(0, image.snap_create("snap1"));
2203       ASSERT_EQ(256, image.write(0, 256, bl));
>>>     CID 1296381:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2204       ASSERT_EQ(0, image.diff_iterate2(NULL, 0, size, true, this->whole_object,
2205           			           vector_iterate_cb, (void *) &extents));
2206       ASSERT_EQ(1u, extents.size());
2207       ASSERT_EQ(diff_extent(0, 256, true, object_size), extents[0]);
2208       ASSERT_EQ(0, image.snap_create("snap2"));
2209     
/test/librbd/test_librbd.cc: 2214 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
2208       ASSERT_EQ(0, image.snap_create("snap2"));
2209     
2210       ASSERT_EQ(obj_ofs, image.discard(0, obj_ofs));
2211     
2212       extents.clear();
2213       ASSERT_EQ(0, image.snap_set("snap2"));
>>>     CID 1296381:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2214       ASSERT_EQ(0, image.diff_iterate2("snap1", 0, size, true, this->whole_object,
2215           			           vector_iterate_cb, (void *) &extents));
2216       ASSERT_EQ(1u, extents.size());
2217       ASSERT_EQ(diff_extent(0, 256, true, object_size), extents[0]);
2218     
2219       ASSERT_EQ(0, image.snap_set(NULL));
/test/librbd/test_librbd.cc: 2225 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
2219       ASSERT_EQ(0, image.snap_set(NULL));
2220       ASSERT_EQ(1 << order, image.discard(0, 1 << order));
2221       ASSERT_EQ(0, image.snap_create("snap3"));
2222       ASSERT_EQ(0, image.snap_set("snap3"));
2223     
2224       extents.clear();
>>>     CID 1296381:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2225       ASSERT_EQ(0, image.diff_iterate2("snap1", 0, size, true, this->whole_object,
2226           			           vector_iterate_cb, (void *) &extents));
2227       ASSERT_EQ(1u, extents.size());
2228       ASSERT_EQ(diff_extent(0, 256, false, object_size), extents[0]);
2229       ASSERT_PASSED(this->validate_object_map, image);
2230     }
/test/librbd/test_librbd.cc: 2175 in DiffIterateTest_DiffIterateDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
2169       uint64_t size = 20 << 20;
2170     
2171       ASSERT_EQ(0, create_image_pp(rbd, ioctx, name.c_str(), size, &order));
2172       ASSERT_EQ(0, rbd.open(ioctx, image, name.c_str(), NULL));
2173     
2174       uint64_t object_size = 0;
>>>     CID 1296381:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as the logical operand of if.
2175       if (this->whole_object) {
2176         object_size = 1 << order;
2177       }
2178       vector<diff_extent> extents;
2179       ceph::bufferlist bl;
2180     

** CID 1296380:    (CONSTANT_EXPRESSION_RESULT)
/test/librbd/test_librbd.cc: 2115 in DiffIterateTest_DiffIterate_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2100 in DiffIterateTest_DiffIterate_Test<DiffIterateParams<(bool)0>>::TestBody()()


________________________________________________________________________________________________________
*** CID 1296380:    (CONSTANT_EXPRESSION_RESULT)
/test/librbd/test_librbd.cc: 2115 in DiffIterateTest_DiffIterate_Test<DiffIterateParams<(bool)0>>::TestBody()()
2109         scribble(image, 10, 102400, &exists, &two);
2110     
2111         two = round_diff_interval(two, object_size);
2112         cout << " wrote " << two << std::endl;
2113     
2114         interval_set<uint64_t> diff;
>>>     CID 1296380:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2115         ASSERT_EQ(0, image.diff_iterate2("one", 0, size, true, this->whole_object,
2116                                          iterate_cb, (void *)&diff));
2117         cout << " diff was " << diff << std::endl;
2118         if (!two.subset_of(diff)) {
2119           interval_set<uint64_t> i;
2120           i.intersection_of(two, diff);
/test/librbd/test_librbd.cc: 2100 in DiffIterateTest_DiffIterate_Test<DiffIterateParams<(bool)0>>::TestBody()()
2094         uint64_t size = 20 << 20;
2095     
2096         ASSERT_EQ(0, create_image_pp(rbd, ioctx, name.c_str(), size, &order));
2097         ASSERT_EQ(0, rbd.open(ioctx, image, name.c_str(), NULL));
2098     
2099         uint64_t object_size = 0;
>>>     CID 1296380:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as the logical operand of if.
2100         if (this->whole_object) {
2101           object_size = 1 << order;
2102         }
2103     
2104         interval_set<uint64_t> exists;
2105         interval_set<uint64_t> one, two;

** CID 1296379:    (CONSTANT_EXPRESSION_RESULT)
/test/librbd/test_librbd.cc: 2284 in DiffIterateTest_DiffIterateStress_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2247 in DiffIterateTest_DiffIterateStress_Test<DiffIterateParams<(bool)0>>::TestBody()()


________________________________________________________________________________________________________
*** CID 1296379:    (CONSTANT_EXPRESSION_RESULT)
/test/librbd/test_librbd.cc: 2284 in DiffIterateTest_DiffIterateStress_Test<DiffIterateParams<(bool)0>>::TestBody()()
2278             uex.union_of(exists[i], exists[j]);
2279             diff.intersection_of(uex);
2280             diff = round_diff_interval(diff, object_size);
2281             cout << " limited diff " << diff << std::endl;
2282     
2283             ASSERT_EQ(0, image.snap_set(h==0 ? snap[j].c_str() : NULL));
>>>     CID 1296379:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2284             ASSERT_EQ(0, image.diff_iterate2(snap[i].c_str(), 0, size, true,
2285                                              this->whole_object, iterate_cb,
2286                                              (void *)&actual));
2287             cout << " actual was " << actual << std::endl;
2288             if (!diff.subset_of(actual)) {
2289               interval_set<uint64_t> i;
/test/librbd/test_librbd.cc: 2247 in DiffIterateTest_DiffIterateStress_Test<DiffIterateParams<(bool)0>>::TestBody()()
2241       uint64_t size = 400 << 20;
2242     
2243       ASSERT_EQ(0, create_image_pp(rbd, ioctx, name.c_str(), size, &order));
2244       ASSERT_EQ(0, rbd.open(ioctx, image, name.c_str(), NULL));
2245     
2246       uint64_t object_size = 0;
>>>     CID 1296379:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as the logical operand of if.
2247       if (this->whole_object) {
2248         object_size = 1 << order;
2249       }
2250     
2251       interval_set<uint64_t> curexists;
2252       vector<interval_set<uint64_t> > wrote;

** CID 1296378:    (CONSTANT_EXPRESSION_RESULT)
/test/librbd/test_librbd.cc: 2394 in DiffIterateTest_DiffIterateIgnoreParent_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2391 in DiffIterateTest_DiffIterateIgnoreParent_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2366 in DiffIterateTest_DiffIterateIgnoreParent_Test<DiffIterateParams<(bool)0>>::TestBody()()


________________________________________________________________________________________________________
*** CID 1296378:    (CONSTANT_EXPRESSION_RESULT)
/test/librbd/test_librbd.cc: 2394 in DiffIterateTest_DiffIterateIgnoreParent_Test<DiffIterateParams<(bool)0>>::TestBody()()
2388       cout << " wrote " << two << " to clone" << std::endl;
2389     
2390       interval_set<uint64_t> diff;
2391       ASSERT_EQ(0, image.diff_iterate2(NULL, 0, size, false, this->whole_object,
2392                                        iterate_cb, (void *)&diff));
2393       cout << " diff was " << diff << std::endl;
>>>     CID 1296378:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always 0/false regardless of the value of its operand. This occurs as the logical operand of '!'.
2394       if (!this->whole_object) {
2395         ASSERT_FALSE(one.subset_of(diff));
2396       }
2397       ASSERT_TRUE(two.subset_of(diff));
2398     }
2399     
/test/librbd/test_librbd.cc: 2391 in DiffIterateTest_DiffIterateIgnoreParent_Test<DiffIterateParams<(bool)0>>::TestBody()()
2385       interval_set<uint64_t> two;
2386       scribble(image, 10, 102400, &exists, &two);
2387       two = round_diff_interval(two, object_size);
2388       cout << " wrote " << two << " to clone" << std::endl;
2389     
2390       interval_set<uint64_t> diff;
>>>     CID 1296378:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2391       ASSERT_EQ(0, image.diff_iterate2(NULL, 0, size, false, this->whole_object,
2392                                        iterate_cb, (void *)&diff));
2393       cout << " diff was " << diff << std::endl;
2394       if (!this->whole_object) {
2395         ASSERT_FALSE(one.subset_of(diff));
2396       }
/test/librbd/test_librbd.cc: 2366 in DiffIterateTest_DiffIterateIgnoreParent_Test<DiffIterateParams<(bool)0>>::TestBody()()
2360       int order = 0;
2361     
2362       ASSERT_EQ(0, create_image_pp(rbd, ioctx, name.c_str(), size, &order));
2363       ASSERT_EQ(0, rbd.open(ioctx, image, name.c_str(), NULL));
2364     
2365       uint64_t object_size = 0;
>>>     CID 1296378:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as the logical operand of if.
2366       if (this->whole_object) {
2367         object_size = 1 << order;
2368       }
2369     
2370       bufferlist bl;
2371       bl.append(buffer::create(size));

** CID 1296377:    (CONSTANT_EXPRESSION_RESULT)
/test/librbd/test_librbd.cc: 2326 in DiffIterateTest_DiffIterateRegression6926_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2337 in DiffIterateTest_DiffIterateRegression6926_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2344 in DiffIterateTest_DiffIterateRegression6926_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2320 in DiffIterateTest_DiffIterateRegression6926_Test<DiffIterateParams<(bool)0>>::TestBody()()


________________________________________________________________________________________________________
*** CID 1296377:    (CONSTANT_EXPRESSION_RESULT)
/test/librbd/test_librbd.cc: 2326 in DiffIterateTest_DiffIterateRegression6926_Test<DiffIterateParams<(bool)0>>::TestBody()()
2320       if (this->whole_object) {
2321         object_size = 1 << order;
2322       }
2323       vector<diff_extent> extents;
2324       ceph::bufferlist bl;
2325     
>>>     CID 1296377:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2326       ASSERT_EQ(0, image.diff_iterate2(NULL, 0, size, true, this->whole_object,
2327           			           vector_iterate_cb, (void *) &extents));
2328       ASSERT_EQ(0u, extents.size());
2329     
2330       ASSERT_EQ(0, image.snap_create("snap1"));
2331       char data[256];
/test/librbd/test_librbd.cc: 2337 in DiffIterateTest_DiffIterateRegression6926_Test<DiffIterateParams<(bool)0>>::TestBody()()
2331       char data[256];
2332       memset(data, 1, sizeof(data));
2333       bl.append(data, 256);
2334       ASSERT_EQ(256, image.write(0, 256, bl));
2335     
2336       extents.clear();
>>>     CID 1296377:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2337       ASSERT_EQ(0, image.diff_iterate2(NULL, 0, size, true, this->whole_object,
2338           			           vector_iterate_cb, (void *) &extents));
2339       ASSERT_EQ(1u, extents.size());
2340       ASSERT_EQ(diff_extent(0, 256, true, object_size), extents[0]);
2341     
2342       ASSERT_EQ(0, image.snap_set("snap1"));
/test/librbd/test_librbd.cc: 2344 in DiffIterateTest_DiffIterateRegression6926_Test<DiffIterateParams<(bool)0>>::TestBody()()
2338           			           vector_iterate_cb, (void *) &extents));
2339       ASSERT_EQ(1u, extents.size());
2340       ASSERT_EQ(diff_extent(0, 256, true, object_size), extents[0]);
2341     
2342       ASSERT_EQ(0, image.snap_set("snap1"));
2343       extents.clear();
>>>     CID 1296377:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2344       ASSERT_EQ(0, image.diff_iterate2(NULL, 0, size, true, this->whole_object,
2345           			           vector_iterate_cb, (void *) &extents));
2346       ASSERT_EQ(static_cast<size_t>(0), extents.size());
2347     }
2348     
2349     TYPED_TEST(DiffIterateTest, DiffIterateIgnoreParent)
/test/librbd/test_librbd.cc: 2320 in DiffIterateTest_DiffIterateRegression6926_Test<DiffIterateParams<(bool)0>>::TestBody()()
2314       uint64_t size = 20 << 20;
2315     
2316       ASSERT_EQ(0, create_image_pp(rbd, ioctx, name.c_str(), size, &order));
2317       ASSERT_EQ(0, rbd.open(ioctx, image, name.c_str(), NULL));
2318     
2319       uint64_t object_size = 0;
>>>     CID 1296377:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as the logical operand of if.
2320       if (this->whole_object) {
2321         object_size = 1 << order;
2322       }
2323       vector<diff_extent> extents;
2324       ceph::bufferlist bl;
2325     

** CID 1296376:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/test/librbd/fsx.cc: 930 in save_buffer(char *, long, int)()


________________________________________________________________________________________________________
*** CID 1296376:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/test/librbd/fsx.cc: 930 in save_buffer(char *, long, int)()
924     	off_t ret;
925     	ssize_t byteswritten;
926     
927     	if (fd <= 0 || bufferlength == 0)
928     		return;
929     
>>>     CID 1296376:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
>>>     "bufferlength > 9223372036854775807L" is always false regardless of the values of its operands. This occurs as the logical operand of if.
930     	if (bufferlength > SSIZE_MAX) {
931     		prt("fsx flaw: overflow in save_buffer\n");
932     		exit(67);
933     	}
934     
935     	ret = lseek(fd, (off_t)0, SEEK_SET);

** CID 1296375:  Memory - illegal accesses  (BUFFER_SIZE_WARNING)
/test/librbd/fsx.cc: 2133 in main()


________________________________________________________________________________________________________
*** CID 1296375:  Memory - illegal accesses  (BUFFER_SIZE_WARNING)
/test/librbd/fsx.cc: 2133 in main()
2127     			if (strlen(goodfile) < sizeof(goodfile)-2) {
2128     				strcat(goodfile, "/");
2129     			} else {
2130     				prt("file name to long\n");
2131     				exit(1);
2132     			}
>>>     CID 1296375:  Memory - illegal accesses  (BUFFER_SIZE_WARNING)
>>>     Calling strncpy with a maximum size argument of 1024 bytes on destination array "logfile" of size 1024 bytes might leave the destination string unterminated.
2133     			strncpy(logfile, dirpath, sizeof(logfile));
2134     			if (strlen(logfile) < sizeof(logfile)-2) {
2135     				strcat(logfile, "/");
2136     			} else {
2137     				prt("file path to long\n");
2138     				exit(1);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

