From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sat, 10 Jan 2015 06:36:04 -0800
Message-ID: <54b138d459f9e_3522d2933079664@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:57592 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbbAJOgG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Jan 2015 09:36:06 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

2 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 1260210:  Resource leak  (RESOURCE_LEAK)
/test/msgr/test_msgr.cc: 537 in MessengerTest_ClientStandbyTest_Test::TestBody()()

** CID 1260212:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/msgr/test_msgr.cc: 579 in main()
/test/msgr/test_msgr.cc: 579 in main()
/test/msgr/test_msgr.cc: 579 in main()
/test/msgr/test_msgr.cc: 579 in main()
/test/msgr/test_msgr.cc: 579 in main()
/test/msgr/test_msgr.cc: 579 in main()


________________________________________________________________________________________________________
*** CID 1260210:  Resource leak  (RESOURCE_LEAK)
/test/msgr/test_msgr.cc: 537 in MessengerTest_ClientStandbyTest_Test::TestBody()()
531       usleep(300*1000);
532       // client should be standby, so we use original connection
533       {
534         m = new MPing();
535         conn->send_keepalive();
536         CHECK_AND_WAIT_TRUE(conn->is_connected());
>>>     CID 1260210:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "m" going out of scope leaks the storage it points to.
537         ASSERT_TRUE(conn->is_connected());
538         ASSERT_EQ(conn->send_message(m), 0);
539         Mutex::Locker l(cli_dispatcher.lock);
540         while (!cli_dispatcher.got_new)
541           cli_dispatcher.cond.Wait(cli_dispatcher.lock);
542         cli_dispatcher.got_new = false;

________________________________________________________________________________________________________
*** CID 1260212:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/msgr/test_msgr.cc: 579 in main()
573     // must be defined). This dummy test keeps gtest_main linked in.
574     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
575     
576     #endif
577     
578     
>>>     CID 1260212:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
579     int main(int argc, char **argv) {
580       vector<const char*> args;
581       argv_to_vec(argc, (const char **)argv, args);
582     
583       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
584       g_ceph_context->_conf->set_val("auth_cluster_required", "none");
/test/msgr/test_msgr.cc: 579 in main()
573     // must be defined). This dummy test keeps gtest_main linked in.
574     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
575     
576     #endif
577     
578     
>>>     CID 1260212:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
579     int main(int argc, char **argv) {
580       vector<const char*> args;
581       argv_to_vec(argc, (const char **)argv, args);
582     
583       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
584       g_ceph_context->_conf->set_val("auth_cluster_required", "none");
/test/msgr/test_msgr.cc: 579 in main()
573     // must be defined). This dummy test keeps gtest_main linked in.
574     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
575     
576     #endif
577     
578     
>>>     CID 1260212:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
579     int main(int argc, char **argv) {
580       vector<const char*> args;
581       argv_to_vec(argc, (const char **)argv, args);
582     
583       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
584       g_ceph_context->_conf->set_val("auth_cluster_required", "none");
/test/msgr/test_msgr.cc: 579 in main()
573     // must be defined). This dummy test keeps gtest_main linked in.
574     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
575     
576     #endif
577     
578     
>>>     CID 1260212:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
579     int main(int argc, char **argv) {
580       vector<const char*> args;
581       argv_to_vec(argc, (const char **)argv, args);
582     
583       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
584       g_ceph_context->_conf->set_val("auth_cluster_required", "none");
/test/msgr/test_msgr.cc: 579 in main()
573     // must be defined). This dummy test keeps gtest_main linked in.
574     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
575     
576     #endif
577     
578     
>>>     CID 1260212:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
579     int main(int argc, char **argv) {
580       vector<const char*> args;
581       argv_to_vec(argc, (const char **)argv, args);
582     
583       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
584       g_ceph_context->_conf->set_val("auth_cluster_required", "none");
/test/msgr/test_msgr.cc: 579 in main()
573     // must be defined). This dummy test keeps gtest_main linked in.
574     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
575     
576     #endif
577     
578     
>>>     CID 1260212:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
579     int main(int argc, char **argv) {
580       vector<const char*> args;
581       argv_to_vec(argc, (const char **)argv, args);
582     
583       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
584       g_ceph_context->_conf->set_val("auth_cluster_required", "none");


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

