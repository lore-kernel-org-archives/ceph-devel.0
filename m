From: Sage Weil <sweil@redhat.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Sat, 23 Aug 2014 09:04:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408230904250.966@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-399057855-1408809869=:966"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58993 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbaHWQE3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Aug 2014 12:04:29 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 45F9380453
	for <ceph-devel@vger.kernel.org>; Sat, 23 Aug 2014 09:04:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1E87A80453
	for <ceph-devel@vger.kernel.org>; Sat, 23 Aug 2014 09:04:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-399057855-1408809869=:966
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-399057855-1408809869=:966
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1408230904260.966@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 9FA4D80069
	for <sage@cobra.newdream.net>; Sat, 23 Aug 2014 06:43:45 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id 9BCFA120AF3; Sat, 23 Aug 2014 06:43:45 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from alc-junkmail-backend3.dreamhost.com (caiajhbdcbae.dreamhost.com
	[208.97.132.104])
	by destro.newdream.net (Postfix) with ESMTP id 95412120A42
	for <sage@newdream.net>; Sat, 23 Aug 2014 06:43:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by alc-junkmail-backend3.dreamhost.com (Postfix) with ESMTP id
	90BCA161606E
	for <sage@newdream.net>; Sat, 23 Aug 2014 06:43:45 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at alc-junkmail-backend3.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
Received: from terminator.dreamhost.com ([208.97.132.17])
	by localhost (alc-junkmail-backend3.dreamhost.com [208.97.132.104])
	(amavisd-new, port 10024)
	with ESMTP id wrUtf19zqhJD for <sage@newdream.net>;
	Sat, 23 Aug 2014 06:43:45 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by terminator.dreamhost.com (Postfix) with ESMTP id 6C8AC2884077
	for <sage@newdream.net>; Sat, 23 Aug 2014 06:43:45 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Sat, 23 Aug 2014 06:43:26 -0700
Date: Sat, 23 Aug 2014 06:43:44 -0700
From: scan-admin@coverity.com
Message-ID: <53f89a90d6618_578610ab31494984@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2014 13:43:26.0687 (UTC)
	FILETIME=[374A66F0:01CFBED8]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 9 of 9 defect(s)


** CID 1232599:  Bad bit shift operation  (BAD_SHIFT)
/os/HashIndex.cc: 433 in HashIndex::pre_split_folder(unsigned int, unsigned long)()

** CID 1232600:  Bad bit shift operation  (BAD_SHIFT)
/os/HashIndex.cc: 421 in HashIndex::pre_split_folder(unsigned int, unsigned long)()

** CID 1232601:  Unchecked return value  (CHECKED_RETURN)
/rbd_replay/Replayer.cc: 154 in rbd_replay::Replayer::run(std::basic_string<char, std::char_traits<char>, std::allocator<char>>)()

** CID 1232602:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/mon/OSDMonitor.cc: 490 in OSDMonitor::reweight_by_utilization(int, std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, bool, const std::set<long, std::less<long>, std::allocator<long>> *)()

** CID 1232603:  Unintentional integer overflow  (OVERFLOW_BEFORE_WIDEN)
/test/objectstore/store_test.cc: 138 in StoreTest_SimpleColPreHashTest_Test::TestBody()()

** CID 1232604:  Unintentional integer overflow  (OVERFLOW_BEFORE_WIDEN)
/os/HashIndex.cc: 378 in HashIndex::pre_split_folder(unsigned int, unsigned long)()

** CID 1232605:  Uncaught exception  (UNCAUGHT_EXCEPT)
/rbd_replay/rbd-replay.cc: 51 in main()

** CID 1232606:  Uncaught exception  (UNCAUGHT_EXCEPT)
/rbd_replay/rbd-replay.cc: 51 in main()
/rbd_replay/rbd-replay.cc: 51 in main()
/rbd_replay/rbd-replay.cc: 51 in main()
/rbd_replay/rbd-replay.cc: 51 in main()
/rbd_replay/rbd-replay.cc: 51 in main()
/rbd_replay/rbd-replay.cc: 51 in main()

** CID 1232607:  Uninitialized pointer field  (UNINIT_CTOR)
/rbd_replay/Replayer.cc: 141 in rbd_replay::Replayer::Replayer(int)()


________________________________________________________________________________________________________
*** CID 1232599:  Bad bit shift operation  (BAD_SHIFT)
/os/HashIndex.cc: 433 in HashIndex::pre_split_folder(unsigned int, unsigned long)()
427       leavies /= subs;
428       while (leavies > 1) {
429         ++level;
430         leavies = leavies >> 4;
431       }
432       for (uint32_t i = 0; i < subs; ++i) {
>>>     CID 1232599:  Bad bit shift operation  (BAD_SHIFT)
>>>     In expression "i << (4 - split_bits) % 4", shifting by a negative amount has undefined behavior.  The shift amount, "(4 - split_bits) % 4", is -1.
433         int v = tmp_id | (i << ((4 - split_bits) % 4));
434         paths.push_back(to_hex(v));
435         ret = create_path(paths);
436         if (ret < 0 && ret != -EEXIST)
437           return ret;
438         ret = recursive_create_path(paths, level);

________________________________________________________________________________________________________
*** CID 1232600:  Bad bit shift operation  (BAD_SHIFT)
/os/HashIndex.cc: 421 in HashIndex::pre_split_folder(unsigned int, unsigned long)()
415       // this variable denotes how many bits (for this level) that can be
416       // used for sub folder splitting
417       int split_bits = 4 - left_bits;
418       // the below logic is inspired by rados.h#ceph_stable_mod,
419       // it basically determines how many sub-folders should we
420       // create for splitting
>>>     CID 1232600:  Bad bit shift operation  (BAD_SHIFT)
>>>     In expression "1 << pg_num_bits - 1", shifting by a negative amount has undefined behavior.  The shift amount, "pg_num_bits - 1", is -1.
421       if (((1 << (pg_num_bits - 1)) | ps) >= pg_num) {
422         ++split_bits;
423       }
424       const uint32_t subs = (1 << split_bits);
425       // Calculate how many levels we create starting from here
426       int level  = 0;

________________________________________________________________________________________________________
*** CID 1232601:  Unchecked return value  (CHECKED_RETURN)
/rbd_replay/Replayer.cc: 154 in rbd_replay::Replayer::run(std::basic_string<char, std::char_traits<char>, std::allocator<char>>)()
148       return m_action_trackers[id % m_num_action_trackers];
149     }
150     
151     void Replayer::run(const std::string replay_file) {
152       {
153         librados::Rados rados;
>>>     CID 1232601:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "init" without checking return value (as is done elsewhere 10 out of 11 times).
154         rados.init(NULL);
155         int r = rados.init_with_context(g_ceph_context);
156         if (r) {
157           cerr << "Unable to read conf file: " << r << std::endl;
158           goto out;
159         }

________________________________________________________________________________________________________
*** CID 1232602:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/mon/OSDMonitor.cc: 490 in OSDMonitor::reweight_by_utilization(int, std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, bool, const std::set<long, std::less<long>, std::allocator<long>> *)()
484     	}
485     	++pgs_by_osd[*q];
486     	++num_pg_copies;
487           }
488         }
489     
>>>     CID 1232602:  Division or modulo by zero  (DIVIDE_BY_ZERO)
>>>     In expression "num_pg_copies / num_osds", division by expression "num_osds" which may be zero has undefined behavior.
490         if (num_pg_copies / num_osds < g_conf->mon_reweight_min_pgs_per_osd) {
491           ostringstream oss;
492           oss << "Refusing to reweight: we only have " << num_pg_copies
493     	  << " PGs across " << num_osds << " osds!\n";
494           out_str = oss.str();
495           return -EDOM;

________________________________________________________________________________________________________
*** CID 1232603:  Unintentional integer overflow  (OVERFLOW_BEFORE_WIDEN)
/test/objectstore/store_test.cc: 138 in StoreTest_SimpleColPreHashTest_Test::TestBody()()
132       boost::uniform_int<> pg_id_range(0, pg_num);
133       gen_type rng(time(NULL));
134       int pg_id = pg_id_range(rng);
135     
136       int objs_per_folder = abs(merge_threshold) * 16 * g_ceph_context->_conf->filestore_split_multiple;
137       boost::uniform_int<> folders_range(5, 256);
>>>     CID 1232603:  Unintentional integer overflow  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "objs_per_folder * folders_range(rng)" with type "int" (32 bits, signed) is evaluated using 32-bit arithmetic before being used in a context which expects an expression of type "uint64_t" (64 bits, unsigned). To avoid overflow, cast either operand to "uint64_t" before performing the multiplication.
138       uint64_t expected_num_objs = (uint64_t)(objs_per_folder * folders_range(rng));
139     
140       char buf[100];
141       snprintf(buf, 100, "1.%x_head", pg_id);
142     
143       coll_t cid(buf);

________________________________________________________________________________________________________
*** CID 1232604:  Unintentional integer overflow  (OVERFLOW_BEFORE_WIDEN)
/os/HashIndex.cc: 378 in HashIndex::pre_split_folder(unsigned int, unsigned long)()
372       // Do not split if the expected number of objects in this collection is zero (by default)
373       if (expected_num_objs == 0)
374         return 0;
375     
376       // Calculate the number of leaf folders (which actually store files)
377       // need to be created
>>>     CID 1232604:  Unintentional integer overflow  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "(unsigned int)abs(this->merge_threshold) * 16U * this->split_multiplier" with type "unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithmetic before being used in a context which expects an expression of type "uint64_t const" (64 bits, unsigned). To avoid overflow, cast either operand to "uint64_t const" before performing the multiplication.
378       const uint64_t objs_per_folder = (unsigned)(abs(merge_threshold)) * 16 * split_multiplier;
379       uint64_t leavies = expected_num_objs / objs_per_folder ;
380       // No need to split
381       if (leavies == 0 || expected_num_objs == objs_per_folder)
382         return 0;
383     

________________________________________________________________________________________________________
*** CID 1232605:  Uncaught exception  (UNCAUGHT_EXCEPT)
/rbd_replay/rbd-replay.cc: 51 in main()
45       cout << std::endl;
46       cout << "Image mapping rules:" << std::endl;
47       cout << "A rule of image1@snap1=image2@snap2 would map snap1 of image1 to snap2 of" << std::endl;
48       cout << "image2." << std::endl;
49     }
50     
>>>     CID 1232605:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
51     int main(int argc, const char **argv) {
52       vector<const char*> args;
53     
54       argv_to_vec(argc, argv, args);
55       env_to_vec(args);
56       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);

________________________________________________________________________________________________________
*** CID 1232606:  Uncaught exception  (UNCAUGHT_EXCEPT)
/rbd_replay/rbd-replay.cc: 51 in main()
45       cout << std::endl;
46       cout << "Image mapping rules:" << std::endl;
47       cout << "A rule of image1@snap1=image2@snap2 would map snap1 of image1 to snap2 of" << std::endl;
48       cout << "image2." << std::endl;
49     }
50     
>>>     CID 1232606:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
51     int main(int argc, const char **argv) {
52       vector<const char*> args;
53     
54       argv_to_vec(argc, argv, args);
55       env_to_vec(args);
56       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/rbd_replay/rbd-replay.cc: 51 in main()
45       cout << std::endl;
46       cout << "Image mapping rules:" << std::endl;
47       cout << "A rule of image1@snap1=image2@snap2 would map snap1 of image1 to snap2 of" << std::endl;
48       cout << "image2." << std::endl;
49     }
50     
>>>     CID 1232606:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
51     int main(int argc, const char **argv) {
52       vector<const char*> args;
53     
54       argv_to_vec(argc, argv, args);
55       env_to_vec(args);
56       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/rbd_replay/rbd-replay.cc: 51 in main()
45       cout << std::endl;
46       cout << "Image mapping rules:" << std::endl;
47       cout << "A rule of image1@snap1=image2@snap2 would map snap1 of image1 to snap2 of" << std::endl;
48       cout << "image2." << std::endl;
49     }
50     
>>>     CID 1232606:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
51     int main(int argc, const char **argv) {
52       vector<const char*> args;
53     
54       argv_to_vec(argc, argv, args);
55       env_to_vec(args);
56       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/rbd_replay/rbd-replay.cc: 51 in main()
45       cout << std::endl;
46       cout << "Image mapping rules:" << std::endl;
47       cout << "A rule of image1@snap1=image2@snap2 would map snap1 of image1 to snap2 of" << std::endl;
48       cout << "image2." << std::endl;
49     }
50     
>>>     CID 1232606:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
51     int main(int argc, const char **argv) {
52       vector<const char*> args;
53     
54       argv_to_vec(argc, argv, args);
55       env_to_vec(args);
56       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/rbd_replay/rbd-replay.cc: 51 in main()
45       cout << std::endl;
46       cout << "Image mapping rules:" << std::endl;
47       cout << "A rule of image1@snap1=image2@snap2 would map snap1 of image1 to snap2 of" << std::endl;
48       cout << "image2." << std::endl;
49     }
50     
>>>     CID 1232606:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
51     int main(int argc, const char **argv) {
52       vector<const char*> args;
53     
54       argv_to_vec(argc, argv, args);
55       env_to_vec(args);
56       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
/rbd_replay/rbd-replay.cc: 51 in main()
45       cout << std::endl;
46       cout << "Image mapping rules:" << std::endl;
47       cout << "A rule of image1@snap1=image2@snap2 would map snap1 of image1 to snap2 of" << std::endl;
48       cout << "image2." << std::endl;
49     }
50     
>>>     CID 1232606:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
51     int main(int argc, const char **argv) {
52       vector<const char*> args;
53     
54       argv_to_vec(argc, argv, args);
55       env_to_vec(args);
56       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);

________________________________________________________________________________________________________
*** CID 1232607:  Uninitialized pointer field  (UNINIT_CTOR)
/rbd_replay/Replayer.cc: 141 in rbd_replay::Replayer::Replayer(int)()
135     
136     Replayer::Replayer(int num_action_trackers)
137       : m_pool_name("rbd"),
138         m_num_action_trackers(num_action_trackers),
139         m_action_trackers(new action_tracker_d[m_num_action_trackers]) {
140       assertf(num_action_trackers > 0, "num_action_trackers = %d", num_action_trackers);
>>>     CID 1232607:  Uninitialized pointer field  (UNINIT_CTOR)
>>>     Non-static class member "m_readonly" is not initialized in this constructor nor in any functions that it calls.
141     }
142     
143     Replayer::~Replayer() {
144       delete[] m_action_trackers;
145     }
146     


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-399057855-1408809869=:966--
