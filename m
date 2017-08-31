From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 31 Aug 2017 06:39:29 +0000 (UTC)
Message-ID: <59a7af213db1a_8b1449314459d1@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:13237 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750826AbdHaGja (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 31 Aug 2017 02:39:30 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0004p1sjc2.sendgrid.net (SG) with ESMTP id T9uv6LCBQJ-XGYbtwVhA1A
        for <ceph-devel@vger.kernel.org>; Thu, 31 Aug 2017 06:39:29.285 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

5 new defect(s) introduced to ceph found with Coverity Scan.
35 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 5 of 5 defect(s)


** CID 1394731:  Concurrent data access violations  (ATOMICITY)
/home/brad/working/src/ceph/src/common/cohort_lru.h: 153 in cohort::lru::LRU<std::mutex>::evict_block()()


________________________________________________________________________________________________________
*** CID 1394731:  Concurrent data access violations  (ATOMICITY)
/home/brad/working/src/ceph/src/common/cohort_lru.h: 153 in cohort::lru::LRU<std::mutex>::evict_block()()
147     	      lane.lock.lock();
148     	      --(o->lru_refcnt);
149     	      /* assertions that o state has not changed across
150     	       * relock */
151     	      assert(o->lru_refcnt == SENTINEL_REFCNT);
152     	      assert(o->lru_flags & FLAG_INLRU);
>>>     CID 1394731:  Concurrent data access violations  (ATOMICITY)
>>>     Using an unreliable value of "o" inside the second locked section. If the data that "o" depends on was changed by another thread, this use might be incorrect.
153     	      Object::Queue::iterator it =
154     		Object::Queue::s_iterator_to(*o);
155     	      lane.q.erase(it);
156     	      lane.lock.unlock();
157     	      return o;
158     	    } else {

** CID 1405520:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1282 in PGLog::read_log_and_missing<pg_missing_set<(bool)1>>(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, PGLog::IndexedLog &, T1 &, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool *, const DoutPrefixProvider *, std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> *, bool)()


________________________________________________________________________________________________________
*** CID 1405520:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1282 in PGLog::read_log_and_missing<pg_missing_set<(bool)1>>(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, PGLog::IndexedLog &, T1 &, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool *, const DoutPrefixProvider *, std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> *, bool)()
1276     
1277       template <typename missing_type>
1278       static void read_log_and_missing(
1279         ObjectStore *store,
1280         coll_t pg_coll,
1281         coll_t log_coll,
>>>     CID 1405520:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter log_oid of type "ghobject_t" (size 144 bytes) by value.
1282         ghobject_t log_oid,
1283         const pg_info_t &info,
1284         IndexedLog &log,
1285         missing_type &missing,
1286         ostringstream &oss,
1287         bool tolerate_divergent_missing_log,

** CID 1405521:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1261 in PGLog::read_log_and_missing(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool)()


________________________________________________________________________________________________________
*** CID 1405521:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1261 in PGLog::read_log_and_missing(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool)()
1255         );
1256     
1257       void read_log_and_missing(
1258         ObjectStore *store,
1259         coll_t pg_coll,
1260         coll_t log_coll,
>>>     CID 1405521:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter log_oid of type "ghobject_t" (size 144 bytes) by value.
1261         ghobject_t log_oid,
1262         const pg_info_t &info,
1263         ostringstream &oss,
1264         bool tolerate_divergent_missing_log,
1265         bool debug_verify_stored_missing = false
1266         ) {

** CID 1417061:  Compiler dependency  (DELETE_ARRAY)
/home/brad/working/src/ceph/src/client/fuse_ll.cc: 121 in getgroups(fuse_req *, unsigned int **)()


________________________________________________________________________________________________________
*** CID 1417061:  Compiler dependency  (DELETE_ARRAY)
/home/brad/working/src/ceph/src/client/fuse_ll.cc: 121 in getgroups(fuse_req *, unsigned int **)()
115       gid_t *gids = new (std::nothrow) gid_t[c];
116       if (!gids) {
117         return -ENOMEM;
118       }
119       c = fuse_req_getgroups(req, c, gids);
120       if (c < 0) {
>>>     CID 1417061:  Compiler dependency  (DELETE_ARRAY)
>>>     Deleting array variable "gids" with non-array delete in "delete gids".
121         delete gids;
122       } else {
123         *sgids = gids;
124       }
125       return c;
126     #endif

** CID 1417062:  Incorrect expression  (UNINTENDED_INTEGER_DIVISION)
/home/brad/working/src/ceph/src/test/kv_store_bench.cc: 120 in KvStoreBench::setup(int, const char **)()


________________________________________________________________________________________________________
*** CID 1417062:  Incorrect expression  (UNINTENDED_INTEGER_DIVISION)
/home/brad/working/src/ceph/src/test/kv_store_bench.cc: 120 in KvStoreBench::setup(int, const char **)()
114     	val_size = atoi(args[i+1]);
115           } else if (strcmp(args[i], "--cache-size") == 0) {
116     	cache_size = atoi(args[i+1]);
117           } else if (strcmp(args[i], "--cache-refresh") == 0) {
118     	auto temp = atoi(args[i+1]);
119     	assert (temp != 0);
>>>     CID 1417062:  Incorrect expression  (UNINTENDED_INTEGER_DIVISION)
>>>     Dividing integer expressions "100" and "temp", and then converting the integer quotient to type "double". Any remainder, or fractional part of the quotient, is ignored.
120     	cache_refresh = 100 / temp;
121           } else if (strcmp(args[i], "-t") == 0) {
122     	max_ops_in_flight = atoi(args[i+1]);
123           } else if (strcmp(args[i], "--clients") == 0) {
124     	clients = atoi(args[i+1]);
125           } else if (strcmp(args[i], "-d") == 0) {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HWXCLxI9Hvwy6AIjOktPyiqxqjoXsSXJBL-2FkI7Cu1h7bGyGLOcBu7N6ZYB3PwxN6eAKBs4DAhmUu8fgNRnRbfk5U8k8UaJmA-2Bnf0b21mScqTRygT-2FA-2BzJEecy-2BXHx30JB8CpD4GLSlbRZN8BJBB4eLx9nTfKu2b5bz9-2Bw-2BN9f0Cj-2BDeN1XbKFWAMi-2BCGt-2Bh-2Bw-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HWXCLxI9Hvwy6AIjOktPyiqxqjoXsSXJBL-2FkI7Cu1h7b1zC0sVmqB4iH6SBRjovrDYs6-2Bjs7Y5nP56O7JDJoMerfFgTcsL6xITJehu3SWwX0z-2FZo254TcctuhoWqH6jgTGNm5qbtOH8Yhx-2FvrY9v6l31imhS4zel-2FDbnDjQ8c847eWGDeCYAkXQiP6f2xWQbA-3D

