From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Wed, 24 May 2017 23:22:37 -0700
Message-ID: <5926782d9b5ab_19272f330517c6@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:38154 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1165149AbdEYGWj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 25 May 2017 02:22:39 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0003p1sjc2.sendgrid.net (SG) with ESMTP id 02IVuRzOSWK7QKO7Z1wcqA
        for <ceph-devel@vger.kernel.org>; Thu, 25 May 2017 06:22:37.785 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

400 new defect(s) introduced to ceph found with Coverity Scan.
7 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 400 defect(s)


** CID 717165:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3519 in main()
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3519 in main()


________________________________________________________________________________________________________
*** CID 717165:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3519 in main()
3513     
3514     out:
3515       delete formatter;
3516       return (ret < 0) ? 1 : 0;
3517     }
3518     
>>>     CID 717165:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
3519     int main(int argc, const char **argv)
3520     {
3521       vector<const char*> args;
3522       argv_to_vec(argc, argv, args);
3523       env_to_vec(args);
3524     
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3519 in main()
3513     
3514     out:
3515       delete formatter;
3516       return (ret < 0) ? 1 : 0;
3517     }
3518     
>>>     CID 717165:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
3519     int main(int argc, const char **argv)
3520     {
3521       vector<const char*> args;
3522       argv_to_vec(argc, argv, args);
3523       env_to_vec(args);
3524     

** CID 717379:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rgw/rgw_op.h: 244 in RGWGetObj::RGWGetObj()()


________________________________________________________________________________________________________
*** CID 717379:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rgw/rgw_op.h: 244 in RGWGetObj::RGWGetObj()()
238         first_block = 0;
239         last_block = 0;
240         q_ofs = 0;
241         q_len = 0;
242         first_data = true;
243         cur_ofs = 0;
>>>     CID 717379:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "rgwx_stat" is not initialized in this constructor nor in any functions that it calls.
244      }
245     
246       bool prefetch_data() override;
247     
248       void set_get_data(bool get_data) {
249         this->get_data = get_data;

** CID 745929:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/rgw/rgw_jsonparser.cc: 60 in main()


________________________________________________________________________________________________________
*** CID 745929:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/rgw/rgw_jsonparser.cc: 60 in main()
54         JSONDecoder::decode_json("max_buckets", max_buckets, obj);
55         JSONDecoder::decode_json("keys", keys, obj);
56       }
57     };
58     
59     
>>>     CID 745929:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
60     int main(int argc, char **argv) {
61       JSONParser parser;
62     
63       char buf[1024];
64       bufferlist bl;
65     

** CID 1019602:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()


________________________________________________________________________________________________________
*** CID 1019602:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
19     #include "detailed_stat_collector.h"
20     #include "distribution.h"
21     
22     namespace po = boost::program_options;
23     using namespace std;
24     
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
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
>>>     CID 1019602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_any_cast> >" is thrown and never caught.
25     int main(int argc, char **argv)
26     {
27       po::options_description desc("Allowed options");
28       desc.add_options()
29         ("help", "produce help message")
30         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),

** CID 1019603:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()


________________________________________________________________________________________________________
*** CID 1019603:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
19     #include "detailed_stat_collector.h"
20     #include "distribution.h"
21     
22     namespace po = boost::program_options;
23     using namespace std;
24     
>>>     CID 1019603:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_lexical_cast> >" is thrown and never caught.
25     int main(int argc, char **argv)
26     {
27       po::options_description desc("Allowed options");
28       desc.add_options()
29         ("help", "produce help message")
30         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),

** CID 1054823:    (ATOMICITY)
/home/brad/working/src/ceph/src/rgw/rgw_rest_client.cc: 542 in RGWRESTStreamWriteRequest::send_data(void *, unsigned long)()
/home/brad/working/src/ceph/src/rgw/rgw_rest_client.cc: 542 in RGWRESTStreamWriteRequest::send_data(void *, unsigned long)()


________________________________________________________________________________________________________
*** CID 1054823:    (ATOMICITY)
/home/brad/working/src/ceph/src/rgw/rgw_rest_client.cc: 542 in RGWRESTStreamWriteRequest::send_data(void *, unsigned long)()
536         len -= send_len;
537         sent += send_len;
538     
539         lock.Lock();
540     
541         bufferlist new_bl;
>>>     CID 1054823:    (ATOMICITY)
>>>     Using an unreliable value of "bl" inside the second locked section. If the data that "bl" depends on was changed by another thread, this use might be incorrect.
542         if (bl.length() > send_len) {
543           bufferptr bp(bl.c_str() + send_len, bl.length() - send_len);
544           new_bl.append(bp);
545         }
546         pending_send.pop_front(); /* need to do this after we copy data from bl */
547         if (new_bl.length()) {
/home/brad/working/src/ceph/src/rgw/rgw_rest_client.cc: 542 in RGWRESTStreamWriteRequest::send_data(void *, unsigned long)()
536         len -= send_len;
537         sent += send_len;
538     
539         lock.Lock();
540     
541         bufferlist new_bl;
>>>     CID 1054823:    (ATOMICITY)
>>>     Using an unreliable value of "bl" inside the second locked section. If the data that "bl" depends on was changed by another thread, this use might be incorrect.
542         if (bl.length() > send_len) {
543           bufferptr bp(bl.c_str() + send_len, bl.length() - send_len);
544           new_bl.append(bp);
545         }
546         pending_send.pop_front(); /* need to do this after we copy data from bl */
547         if (new_bl.length()) {

** CID 1219619:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3519 in main()


________________________________________________________________________________________________________
*** CID 1219619:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3519 in main()
3513     
3514     out:
3515       delete formatter;
3516       return (ret < 0) ? 1 : 0;
3517     }
3518     
>>>     CID 1219619:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
3519     int main(int argc, const char **argv)
3520     {
3521       vector<const char*> args;
3522       argv_to_vec(argc, argv, args);
3523       env_to_vec(args);
3524     

** CID 1219625:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/rgw/rgw_jsonparser.cc: 60 in main()


________________________________________________________________________________________________________
*** CID 1219625:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/rgw/rgw_jsonparser.cc: 60 in main()
54         JSONDecoder::decode_json("max_buckets", max_buckets, obj);
55         JSONDecoder::decode_json("keys", keys, obj);
56       }
57     };
58     
59     
>>>     CID 1219625:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
60     int main(int argc, char **argv) {
61       JSONParser parser;
62     
63       char buf[1024];
64       bufferlist bl;
65     

** CID 1219631:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()


________________________________________________________________________________________________________
*** CID 1219631:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/bench/small_io_bench_rbd.cc: 25 in main()
19     #include "detailed_stat_collector.h"
20     #include "distribution.h"
21     
22     namespace po = boost::program_options;
23     using namespace std;
24     
>>>     CID 1219631:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
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
>>>     CID 1219631:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
25     int main(int argc, char **argv)
26     {
27       po::options_description desc("Allowed options");
28       desc.add_options()
29         ("help", "produce help message")
30         ("num-concurrent-ops", po::value<unsigned>()->default_value(10),

** CID 1232605:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/rbd_replay/rbd-replay.cc: 58 in main()


________________________________________________________________________________________________________
*** CID 1232605:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/rbd_replay/rbd-replay.cc: 58 in main()
52       cout << std::endl;
53       cout << "Image mapping rules:" << std::endl;
54       cout << "A rule of image1@snap1=image2@snap2 would map snap1 of image1 to snap2 of" << std::endl;
55       cout << "image2." << std::endl;
56     }
57     
>>>     CID 1232605:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
58     int main(int argc, const char **argv) {
59       vector<const char*> args;
60     
61       argv_to_vec(argc, argv, args);
62       env_to_vec(args);
63       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,

** CID 1247721:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rbd/rbd.cc: 10 in main()


________________________________________________________________________________________________________
*** CID 1247721:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rbd/rbd.cc: 10 in main()
4     #include "tools/rbd/Shell.h"
5     #include "include/int_types.h"
6     #include "common/ceph_argparse.h"
7     #include "global/global_init.h"
8     #include <vector>
9     
>>>     CID 1247721:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
10     int main(int argc, const char **argv)
11     {
12       std::vector<const char*> args;
13       argv_to_vec(argc, argv, args);
14       env_to_vec(args);
15     

** CID 1255934:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.3.1/functional: 1869 in std::function<void (ceph::Formatter &, const md_config_t &, RGWRados &)>::function(std::nullptr_t)()


________________________________________________________________________________________________________
*** CID 1255934:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.3.1/functional: 1869 in std::function<void (ceph::Formatter &, const md_config_t &, RGWRados &)>::function(std::nullptr_t)()
1863     
1864           /**
1865            *  @brief Creates an empty function call wrapper.
1866            *  @post @c !(bool)*this
1867            */
1868           function(nullptr_t) noexcept
>>>     CID 1255934:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "_M_invoker" is not initialized in this constructor nor in any functions that it calls.
1869           : _Function_base() { }
1870     
1871           /**
1872            *  @brief %Function copy constructor.
1873            *  @param __x A %function object with identical call signature.
1874            *  @post @c bool(*this) == bool(__x)

** CID 1296302:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.3.1/bits/regex_scanner.h: 110 in std::__detail::_ScannerBase::_ScannerBase(std::regex_constants::syntax_option_type)()


________________________________________________________________________________________________________
*** CID 1296302:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.3.1/bits/regex_scanner.h: 110 in std::__detail::_ScannerBase::_ScannerBase(std::regex_constants::syntax_option_type)()
104     		 : _M_flags & regex_constants::egrep
105     		 ? ".[\\()*+?{|^$\n"
106     		 : _M_flags & regex_constants::awk
107     		 ? _M_extended_spec_char
108     		 : nullptr),
109         _M_at_bracket_start(false)
>>>     CID 1296302:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "_M_token" is not initialized in this constructor nor in any functions that it calls.
110         { __glibcxx_assert(_M_spec_char); }
111     
112       protected:
113         const char*
114         _M_find_escape(char __c)
115         {

** CID 1296376:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/home/brad/working/src/ceph/src/test/librbd/fsx.cc: 1340 in save_buffer(char *, long, int)()


________________________________________________________________________________________________________
*** CID 1296376:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/home/brad/working/src/ceph/src/test/librbd/fsx.cc: 1340 in save_buffer(char *, long, int)()
1334     	off_t ret;
1335     	ssize_t byteswritten;
1336     
1337     	if (fd <= 0 || bufferlength == 0)
1338     		return;
1339     
>>>     CID 1296376:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
>>>     "bufferlength > 9223372036854775807L" is always false regardless of the values of its operands. This occurs as the logical operand of "if".
1340     	if (bufferlength > SSIZE_MAX) {
1341     		prt("fsx flaw: overflow in save_buffer\n");
1342     		exit(67);
1343     	}
1344     
1345     	ret = lseek(fd, (off_t)0, SEEK_SET);

** CID 1297756:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/cls_rbd/test_cls_rbd.cc: 62 in random_buf(unsigned long)()


________________________________________________________________________________________________________
*** CID 1297756:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/cls_rbd/test_cls_rbd.cc: 62 in random_buf(unsigned long)()
56     }
57     
58     static char *random_buf(size_t len)
59     {
60       char *b = new char[len];
61       for (size_t i = 0; i < len; i++)
>>>     CID 1297756:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
62         b[i] = (rand() % (128 - 32)) + 32;
63       return b;
64     }
65     
66     class TestClsRbd : public ::testing::Test {
67     public:

** CID 1297879:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/rbd_replay/rbd-replay.cc: 58 in main()


________________________________________________________________________________________________________
*** CID 1297879:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/rbd_replay/rbd-replay.cc: 58 in main()
52       cout << std::endl;
53       cout << "Image mapping rules:" << std::endl;
54       cout << "A rule of image1@snap1=image2@snap2 would map snap1 of image1 to snap2 of" << std::endl;
55       cout << "image2." << std::endl;
56     }
57     
>>>     CID 1297879:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::thread_resource_error> >" is thrown and never caught.
58     int main(int argc, const char **argv) {
59       vector<const char*> args;
60     
61       argv_to_vec(argc, argv, args);
62       env_to_vec(args);
63       auto cct = global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT,

** CID 1313366:    (ATOMICITY)
/home/brad/working/src/ceph/src/common/obj_bencher.cc: 719 in ObjBencher::seq_read_bench(int, int, int, int, bool)()
/home/brad/working/src/ceph/src/common/obj_bencher.cc: 788 in ObjBencher::seq_read_bench(int, int, int, int, bool)()


________________________________________________________________________________________________________
*** CID 1313366:    (ATOMICITY)
/home/brad/working/src/ceph/src/common/obj_bencher.cc: 719 in ObjBencher::seq_read_bench(int, int, int, int, bool)()
713         }
714     
715         // calculate latency here, so memcmp doesn't inflate it
716         data.cur_latency = ceph_clock_now() - start_times[slot];
717     
718         cur_contents = contents[slot];
>>>     CID 1313366:    (ATOMICITY)
>>>     Using an unreliable value of "index[slot]" inside the second locked section. If the data that "index[slot]" depends on was changed by another thread, this use might be incorrect.
719         int current_index = index[slot];
720         
721         // invalidate internal crc cache
722         cur_contents->invalidate_crc();
723       
724         if (!no_verify) {
/home/brad/working/src/ceph/src/common/obj_bencher.cc: 788 in ObjBencher::seq_read_bench(int, int, int, int, bool)()
782         if (data.cur_latency < data.min_latency) data.min_latency = data.cur_latency;
783         ++data.finished;
784         data.avg_latency = total_latency / data.finished;
785         --data.in_flight;
786         release_completion(slot);
787         if (!no_verify) {
>>>     CID 1313366:    (ATOMICITY)
>>>     Using an unreliable value of "index[slot]" inside the second locked section. If the data that "index[slot]" depends on was changed by another thread, this use might be incorrect.
788           snprintf(data.object_contents, data.op_size, "I'm the %16dth op!", index[slot]);
789           lock.Unlock();
790           if ((contents[slot]->length() != data.op_size) || 
791              (memcmp(data.object_contents, contents[slot]->c_str(), data.op_size) != 0)) {
792             cerr << name[slot] << " is not correct!" << std::endl;
793             ++errors;

** CID 1313371:    (CHECKED_RETURN)
/home/brad/working/src/ceph/src/tools/rados/RadosImport.cc: 120 in RadosImport::import(librados::IoCtx &, bool)()
/home/brad/working/src/ceph/src/tools/rados/RadosImport.cc: 164 in RadosImport::import(librados::IoCtx &, bool)()


________________________________________________________________________________________________________
*** CID 1313371:    (CHECKED_RETURN)
/home/brad/working/src/ceph/src/tools/rados/RadosImport.cc: 120 in RadosImport::import(librados::IoCtx &, bool)()
114         return -EINVAL;
115       }
116     #endif
117     
118     #if defined(__linux__)
119       if (file_fd != STDIN_FILENO)
>>>     CID 1313371:    (CHECKED_RETURN)
>>>     Calling "posix_fadvise(this->file_fd, 0L, 0L, 2)" without checking return value. This library function may fail and return an error code.
120         posix_fadvise(file_fd, 0, 0, POSIX_FADV_SEQUENTIAL);
121     #endif
122     
123       bool done = false;
124       bool found_metadata = false;
125       while(!done) {
/home/brad/working/src/ceph/src/tools/rados/RadosImport.cc: 164 in RadosImport::import(librados::IoCtx &, bool)()
158       if (!(pool_mode || found_metadata)) {
159         cerr << "Missing metadata section!" << std::endl;
160       }
161     
162     #if defined(__linux__)
163       if (file_fd != STDIN_FILENO)
>>>     CID 1313371:    (CHECKED_RETURN)
>>>     Calling "posix_fadvise(this->file_fd, 0L, 0L, 4)" without checking return value. This library function may fail and return an error code.
164         posix_fadvise(file_fd, 0, 0, POSIX_FADV_DONTNEED);
165     #endif
166       return 0;
167     }
168     
169     int RadosImport::get_object_rados(librados::IoCtx &ioctx, bufferlist &bl, bool no_overwrite)

** CID 1313372:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/tools/rados/PoolDump.cc: 167 in PoolDump::dump(librados::IoCtx *)()


________________________________________________________________________________________________________
*** CID 1313372:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/tools/rados/PoolDump.cc: 167 in PoolDump::dump(librados::IoCtx *)()
161         }
162       }
163     
164       r = write_simple(TYPE_POOL_END, file_fd);
165     #if defined(__linux__)
166       if (file_fd != STDOUT_FILENO)
>>>     CID 1313372:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "posix_fadvise(this->file_fd, 0L, 0L, 4)" without checking return value. This library function may fail and return an error code.
167         posix_fadvise(file_fd, 0, 0, POSIX_FADV_DONTNEED);
168     #endif
169       return r;

** CID 1313380:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/common/obj_bencher.cc: 977 in ObjBencher::rand_read_bench(int, int, int, int, bool)()


________________________________________________________________________________________________________
*** CID 1313380:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/common/obj_bencher.cc: 977 in ObjBencher::rand_read_bench(int, int, int, int, bool)()
971               (memcmp(data.object_contents, cur_contents->c_str(), data.op_size) != 0)) {
972             cerr << name[slot] << " is not correct!" << std::endl;
973             ++errors;
974           }
975         } 
976     
>>>     CID 1313380:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
977         rand_id = rand() % num_objects;
978         newName = generate_object_name(rand_id / writes_per_object, pid);
979         index[slot] = rand_id;
980         release_completion(slot);
981     
982         // invalidate internal crc cache


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HbBSYlGRvC6yb6IGf3IrEcYVJqy9-2FImfMxv9uburkNvarkyqWwX5Mqfu1HqNERerkSBlR1irNG2DpcaId5JlbsZpQs26lS4yycxgraa1mvrR7aSRTFPsSGKdgWoLAVo-2Frer-2FgL1qdiMaEHDi926oC8TDKjYc6u-2FkgsCns9GNvyZCnDQmB-2F3VZmts8D-2F4mxFKc-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HbBSYlGRvC6yb6IGf3IrEcYVJqy9-2FImfMxv9uburkNvWGv8Z7p1J5GSXDQNgfSCKDvcXRmzIF5P9TwhoIZ-2F-2FM6-2FmWzXqXif3RlYGW6QeWOjcarMjFVTscNUNbzSaxsAsqDUL7G1JdcbAvWsyF65rFgQ2-2FtBGe0pEE4IAAkDKDhaV5C3064UhFoc-2FjLoVy2SQk-3D

