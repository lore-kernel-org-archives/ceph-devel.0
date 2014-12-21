From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sun, 21 Dec 2014 06:13:09 -0800
Message-ID: <5496d57569eb7_8a63833302881b@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:54773 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbaLUONL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Dec 2014 09:13:11 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

4 new defect(s) introduced to ceph found with Coverity Scan.
1 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 1260211:  Resource leak  (RESOURCE_LEAK)
/test/msgr/test_msgr.cc: 414 in MessengerTest_StatefulTest_Test::TestBody()()

** CID 1260210:  Resource leak  (RESOURCE_LEAK)
/test/msgr/test_msgr.cc: 537 in MessengerTest_ClientStandbyTest_Test::TestBody()()

** CID 1260212:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/msgr/test_msgr.cc: 579 in main()
/test/msgr/test_msgr.cc: 579 in main()
/test/msgr/test_msgr.cc: 579 in main()
/test/msgr/test_msgr.cc: 579 in main()
/test/msgr/test_msgr.cc: 579 in main()

** CID 1260213:  Uninitialized scalar field  (UNINIT_CTOR)
/osd/ReplicatedPG.cc: 1242 in ReplicatedPG::ReplicatedPG(OSDService *, std::tr1::shared_ptr<const OSDMap>, const PGPool &, spg_t)()


________________________________________________________________________________________________________
*** CID 1260211:  Resource leak  (RESOURCE_LEAK)
/test/msgr/test_msgr.cc: 414 in MessengerTest_StatefulTest_Test::TestBody()()
408       }
409       CHECK_AND_WAIT_TRUE(conn->is_connected());
410       ASSERT_TRUE(conn->is_connected());
411       {
412         m = new MPing();
413         Mutex::Locker l(cli_dispatcher.lock);
>>>     CID 1260211:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "m" going out of scope leaks the storage it points to.
414         ASSERT_TRUE(conn->is_connected());
415         ASSERT_EQ(conn->send_message(m), 0);
416         while (!cli_dispatcher.got_new)
417           cli_dispatcher.cond.Wait(cli_dispatcher.lock);
418         cli_dispatcher.got_new = false;
419       }

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
538         Mutex::Locker l(cli_dispatcher.lock);
539         ASSERT_EQ(conn->send_message(m), 0);
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
584       common_init_finish(g_ceph_context);
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
584       common_init_finish(g_ceph_context);
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
584       common_init_finish(g_ceph_context);
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
584       common_init_finish(g_ceph_context);
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
584       common_init_finish(g_ceph_context);

________________________________________________________________________________________________________
*** CID 1260213:  Uninitialized scalar field  (UNINIT_CTOR)
/osd/ReplicatedPG.cc: 1242 in ReplicatedPG::ReplicatedPG(OSDService *, std::tr1::shared_ptr<const OSDMap>, const PGPool &, spg_t)()
1236       snap_trimmer_machine(this)
1237     { 
1238       missing_loc.set_backend_predicates(
1239         pgbackend->get_is_readable_predicate(),
1240         pgbackend->get_is_recoverable_predicate());
1241       snap_trimmer_machine.initiate();
>>>     CID 1260213:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "new_backfill" is not initialized in this constructor nor in any functions that it calls.
1242     }
1243     
1244     void ReplicatedPG::get_src_oloc(const object_t& oid, const object_locator_t& oloc, object_locator_t& src_oloc)
1245     {
1246       src_oloc = oloc;
1247       if (oloc.key.empty())


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

