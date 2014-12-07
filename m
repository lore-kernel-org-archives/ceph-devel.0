From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sun, 07 Dec 2014 12:36:44 -0800
Message-ID: <5484ba5cc110_615211353207264b@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:56667 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbaLGUgo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Dec 2014 15:36:44 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

2 new defect(s) introduced to ceph found with Coverity Scan.
1 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 1257029:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 250 in main()
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 250 in main()
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 250 in main()
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 250 in main()
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 250 in main()

** CID 1257030:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 250 in main()


________________________________________________________________________________________________________
*** CID 1257029:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 250 in main()
244     
245     void usage(const string &name) {
246       cerr << "Usage: " << name << " [times] "
247            << std::endl;
248     }
249     
>>>     CID 1257029:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
250     int main(int argc, char **argv)
251     {
252       vector<const char*> args;
253       argv_to_vec(argc, (const char **)argv, args);
254     
255       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 250 in main()
244     
245     void usage(const string &name) {
246       cerr << "Usage: " << name << " [times] "
247            << std::endl;
248     }
249     
>>>     CID 1257029:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
250     int main(int argc, char **argv)
251     {
252       vector<const char*> args;
253       argv_to_vec(argc, (const char **)argv, args);
254     
255       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 250 in main()
244     
245     void usage(const string &name) {
246       cerr << "Usage: " << name << " [times] "
247            << std::endl;
248     }
249     
>>>     CID 1257029:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
250     int main(int argc, char **argv)
251     {
252       vector<const char*> args;
253       argv_to_vec(argc, (const char **)argv, args);
254     
255       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 250 in main()
244     
245     void usage(const string &name) {
246       cerr << "Usage: " << name << " [times] "
247            << std::endl;
248     }
249     
>>>     CID 1257029:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
250     int main(int argc, char **argv)
251     {
252       vector<const char*> args;
253       argv_to_vec(argc, (const char **)argv, args);
254     
255       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 250 in main()
244     
245     void usage(const string &name) {
246       cerr << "Usage: " << name << " [times] "
247            << std::endl;
248     }
249     
>>>     CID 1257029:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
250     int main(int argc, char **argv)
251     {
252       vector<const char*> args;
253       argv_to_vec(argc, (const char **)argv, args);
254     
255       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);

________________________________________________________________________________________________________
*** CID 1257030:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/objectstore/ObjectStoreTransactionBenchmark.cc: 250 in main()
244     
245     void usage(const string &name) {
246       cerr << "Usage: " << name << " [times] "
247            << std::endl;
248     }
249     
>>>     CID 1257030:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
250     int main(int argc, char **argv)
251     {
252       vector<const char*> args;
253       argv_to_vec(argc, (const char **)argv, args);
254     
255       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

