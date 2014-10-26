From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sun, 26 Oct 2014 06:17:53 -0700
Message-ID: <544cf4816933d_6564b55338883d7@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:57556 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbaJZNRy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Oct 2014 09:17:54 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

77 new defect(s) introduced to ceph found with Coverity Scan.
74 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 77 defect(s)


** CID 717233:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/Capability.h: 253 in Capability::Capability(CInode *, unsigned long, client_t)()

** CID 1201388:  Missing unlock  (LOCK)
/mon/Monitor.cc: 564 in Monitor::preinit()()

** CID 1213581:  Dereference null return value  (NULL_RETURNS)
/osd/OSD.cc: 5523 in OSD::ms_fast_preprocess(Message *)()

** CID 1214678:  Unchecked return value  (CHECKED_RETURN)
/osd/OSD.cc: 326 in OSDService::_maybe_split_pgid(std::tr1::shared_ptr<const OSDMap>, std::tr1::shared_ptr<const OSDMap>, spg_t)()

** CID 1219460:  Unchecked return value  (CHECKED_RETURN)
/tools/cephfs/JournalTool.cc: 104 in JournalTool::main(std::vector<const char *, std::allocator<const char *>> &)()

** CID 1219463:  Unchecked return value  (CHECKED_RETURN)
/client/SyntheticClient.cc: 1142 in SyntheticClient::play_trace(Trace &, std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, bool)()

** CID 1219620:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()

** CID 1219621:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()

** CID 1219622:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()

** CID 1219637:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/filestore/TestFileStore.cc: 67 in main()
/test/filestore/TestFileStore.cc: 67 in main()
/test/filestore/TestFileStore.cc: 67 in main()
/test/filestore/TestFileStore.cc: 67 in main()

** CID 1219650:  Uninitialized scalar field  (UNINIT_CTOR)
/tools/cephfs/Resetter.h: 29 in Resetter::Resetter()()

** CID 1220854:  Invalid iterator comparison  (MISMATCHED_ITERATOR)
/osd/PG.cc: 1000 in PG::calc_ec_acting(std::_Rb_tree_const_iterator<std::pair<const pg_shard_t, pg_info_t>>, unsigned int, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::map<pg_shard_t, pg_info_t, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, pg_info_t>>> &, bool, std::vector<int, std::allocator<int>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, pg_shard_t *, std::basic_ostream<char, std::char_traits<char>>&)()

** CID 1221498:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/test/libradosstriper/striping.cc: 61 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()

** CID 1221499:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/test/libradosstriper/striping.cc: 70 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()

** CID 1221525:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/striping.cc: 227 in StriperTestRT_StripedRoundtrip_Test::TestBody()()

** CID 1221526:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/striping.cc: 39 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 86 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 140 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()

** CID 1221538:  Uninitialized pointer field  (UNINIT_CTOR)
/test/libradosstriper/TestCase.h: 25 in StriperTest::StriperTest()()

** CID 1225099:  Unchecked return value  (CHECKED_RETURN)
/mon/MDSMonitor.cc: 1523 in MDSMonitor::filesystem_command(MMonCommand *, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detai
 l::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_>, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::
 detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_>>>> &, std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>> &, int &)()

** CID 1225100:  Missing unlock  (LOCK)
/mds/MDLog.cc: 562 in MDLog::trim(int)()
/mds/MDLog.cc: 562 in MDLog::trim(int)()

** CID 1225101:  Missing unlock  (LOCK)
/mds/MDLog.cc: 445 in MDLog::shutdown()()


________________________________________________________________________________________________________
*** CID 717233:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/Capability.h: 253 in Capability::Capability(CInode *, unsigned long, client_t)()
247         client_follows(0), client_xattr_version(0),
248         client_inline_version(0),
249         item_session_caps(this), item_snaprealm_caps(this),
250         item_revoking_caps(this), item_client_revoking_caps(this) {
251         g_num_cap++;
252         g_num_capa++;
>>>     CID 717233:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "num_revoke_warnings" is not initialized in this constructor nor in any functions that it calls.
253       }
254       ~Capability() {
255         g_num_cap--;
256         g_num_caps++;
257       }
258     

________________________________________________________________________________________________________
*** CID 1201388:  Missing unlock  (LOCK)
/mon/Monitor.cc: 564 in Monitor::preinit()()
558     
559       dout(1) << "preinit fsid " << monmap->fsid << dendl;
560     
561       int r = sanitize_options();
562       if (r < 0) {
563         derr << "option sanitization failed!" << dendl;
>>>     CID 1201388:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->lock._m".
564         return r;
565       }
566     
567       assert(!logger);
568       {
569         PerfCountersBuilder pcb(g_ceph_context, "mon", l_mon_first, l_mon_last);

________________________________________________________________________________________________________
*** CID 1213581:  Dereference null return value  (NULL_RETURNS)
/osd/OSD.cc: 5523 in OSD::ms_fast_preprocess(Message *)()
5517     
5518     void OSD::ms_fast_preprocess(Message *m)
5519     {
5520       if (m->get_connection()->get_peer_type() == CEPH_ENTITY_TYPE_OSD) {
5521         if (m->get_type() == CEPH_MSG_OSD_MAP) {
5522           MOSDMap *mm = static_cast<MOSDMap*>(m);
>>>     CID 1213581:  Dereference null return value  (NULL_RETURNS)
>>>     Assigning: "s" = null return value from "get_priv".
5523           Session *s = static_cast<Session*>(m->get_connection()->get_priv());
5524           s->received_map_lock.Lock();
5525           s->received_map_epoch = mm->get_last();
5526           s->received_map_lock.Unlock();
5527           s->put();
5528         }

________________________________________________________________________________________________________
*** CID 1214678:  Unchecked return value  (CHECKED_RETURN)
/osd/OSD.cc: 326 in OSDService::_maybe_split_pgid(std::tr1::shared_ptr<const OSDMap>, std::tr1::shared_ptr<const OSDMap>, spg_t)()
320     				  OSDMapRef new_map,
321     				  spg_t pgid)
322     {
323       assert(old_map->have_pg_pool(pgid.pool()));
324       if (pgid.ps() < static_cast<unsigned>(old_map->get_pg_num(pgid.pool()))) {
325         set<spg_t> children;
>>>     CID 1214678:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "is_split" without checking return value (as is done elsewhere 6 out of 7 times).
326         pgid.is_split(old_map->get_pg_num(pgid.pool()),
327     		  new_map->get_pg_num(pgid.pool()), &children);
328         _start_split(pgid, children);
329       } else {
330         assert(pgid.ps() < static_cast<unsigned>(new_map->get_pg_num(pgid.pool())));
331       }

________________________________________________________________________________________________________
*** CID 1219460:  Unchecked return value  (CHECKED_RETURN)
/tools/cephfs/JournalTool.cc: 104 in JournalTool::main(std::vector<const char *, std::allocator<const char *>> &)()
98       if (r < 0) {
99         derr << "RADOS unavailable, cannot scan filesystem journal" << dendl;
100         return r;
101       }
102     
103       dout(4) << "JournalTool: connecting to RADOS..." << dendl;
>>>     CID 1219460:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "connect" without checking return value (as is done elsewhere 14 out of 17 times).
104       rados.connect();
105      
106       int const pool_id = mdsmap->get_metadata_pool();
107       dout(4) << "JournalTool: resolving pool " << pool_id << dendl;
108       std::string pool_name;
109       r = rados.pool_reverse_lookup(pool_id, &pool_name);

________________________________________________________________________________________________________
*** CID 1219463:  Unchecked return value  (CHECKED_RETURN)
/client/SyntheticClient.cc: 1142 in SyntheticClient::play_trace(Trace &, std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, bool)()
1136           const char *a = t.get_string(buf, p);
1137           int64_t b = t.get_int();
1138           client->mknod(a, b, 0);
1139         } else if (strcmp(op, "getdir") == 0) {
1140           const char *a = t.get_string(buf, p);
1141           list<string> contents;
>>>     CID 1219463:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "getdir" without checking return value (as is done elsewhere 4 out of 5 times).
1142           client->getdir(a, contents);
1143         } else if (strcmp(op, "opendir") == 0) {
1144           const char *a = t.get_string(buf, p);
1145           int64_t b = t.get_int();
1146           dir_result_t *dirp;
1147           client->opendir(a, &dirp);

________________________________________________________________________________________________________
*** CID 1219620:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
18     #include "common/errno.h"
19     #include "global/global_init.h"
20     
21     #include "JournalTool.h"
22     
23     
>>>     CID 1219620:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
24     int main(int argc, const char **argv)
25     {
26       vector<const char*> args;
27       argv_to_vec(argc, argv, args);
28       env_to_vec(args);
29     
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
18     #include "common/errno.h"
19     #include "global/global_init.h"
20     
21     #include "JournalTool.h"
22     
23     
>>>     CID 1219620:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
24     int main(int argc, const char **argv)
25     {
26       vector<const char*> args;
27       argv_to_vec(argc, argv, args);
28       env_to_vec(args);
29     
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
18     #include "common/errno.h"
19     #include "global/global_init.h"
20     
21     #include "JournalTool.h"
22     
23     
>>>     CID 1219620:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
24     int main(int argc, const char **argv)
25     {
26       vector<const char*> args;
27       argv_to_vec(argc, argv, args);
28       env_to_vec(args);
29     
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
18     #include "common/errno.h"
19     #include "global/global_init.h"
20     
21     #include "JournalTool.h"
22     
23     
>>>     CID 1219620:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
24     int main(int argc, const char **argv)
25     {
26       vector<const char*> args;
27       argv_to_vec(argc, argv, args);
28       env_to_vec(args);
29     
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
18     #include "common/errno.h"
19     #include "global/global_init.h"
20     
21     #include "JournalTool.h"
22     
23     
>>>     CID 1219620:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
24     int main(int argc, const char **argv)
25     {
26       vector<const char*> args;
27       argv_to_vec(argc, argv, args);
28       env_to_vec(args);
29     

________________________________________________________________________________________________________
*** CID 1219621:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
18     #include "common/errno.h"
19     #include "global/global_init.h"
20     
21     #include "JournalTool.h"
22     
23     
>>>     CID 1219621:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
24     int main(int argc, const char **argv)
25     {
26       vector<const char*> args;
27       argv_to_vec(argc, argv, args);
28       env_to_vec(args);
29     

________________________________________________________________________________________________________
*** CID 1219622:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/cephfs/cephfs-journal-tool.cc: 24 in main()
18     #include "common/errno.h"
19     #include "global/global_init.h"
20     
21     #include "JournalTool.h"
22     
23     
>>>     CID 1219622:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::malformed_input" is thrown and never caught.
24     int main(int argc, const char **argv)
25     {
26       vector<const char*> args;
27       argv_to_vec(argc, argv, args);
28       env_to_vec(args);
29     

________________________________________________________________________________________________________
*** CID 1219637:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/filestore/TestFileStore.cc: 67 in main()
61         fs.collect_metadata(&pm);
62         ASSERT_EQ(pm["filestore_backend"], "zfs");
63       }
64     #endif
65     }
66     
>>>     CID 1219637:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
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
>>>     CID 1219637:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
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
>>>     CID 1219637:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
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
>>>     CID 1219637:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
67     int main(int argc, char **argv) {
68       vector<const char*> args;
69       argv_to_vec(argc, (const char **)argv, args);
70     
71       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
72       common_init_finish(g_ceph_context);

________________________________________________________________________________________________________
*** CID 1219650:  Uninitialized scalar field  (UNINIT_CTOR)
/tools/cephfs/Resetter.h: 29 in Resetter::Resetter()()
23      * To use, create a Resetter, call init(), and then call reset() with the name
24      * of the file to dump to.
25      */
26     class Resetter : public MDSUtility {
27       int rank; 
28     public:
>>>     CID 1219650:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "rank" is not initialized in this constructor nor in any functions that it calls.
29       Resetter() {}
30     
31       void reset(int rank);
32     };
33     

________________________________________________________________________________________________________
*** CID 1220854:  Invalid iterator comparison  (MISMATCHED_ITERATOR)
/osd/PG.cc: 1000 in PG::calc_ec_acting(std::_Rb_tree_const_iterator<std::pair<const pg_shard_t, pg_info_t>>, unsigned int, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::map<pg_shard_t, pg_info_t, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, pg_info_t>>> &, bool, std::vector<int, std::allocator<int>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, pg_shard_t *, std::basic_ostream<char, std::char_traits<char>>&)()
994     	all_info.find(pg_shard_t(acting[i], shard_id_t(i)))->second.last_update >=
995     	auth_log_shard->second.log_tail) {
996           ss << " selecting acting[i]: " << pg_shard_t(acting[i], shard_id_t(i)) << std::endl;
997           want[i] = acting[i];
998           ++usable;
999         } else {
>>>     CID 1220854:  Invalid iterator comparison  (MISMATCHED_ITERATOR)
>>>     Comparing "j" from "all_info_by_shard[shard_id_t(i)]" to "all_info_by_shard[shard_id_t(i)]->end()" from "all_info_by_shard[shard_id_t(i)]".
1000           for (set<pg_shard_t>::iterator j = all_info_by_shard[shard_id_t(i)].begin();
1001     	   j != all_info_by_shard[shard_id_t(i)].end();
1002     	   ++j) {
1003     	assert(j->shard == i);
1004     	if (!all_info.find(*j)->second.is_incomplete() &&
1005     	    all_info.find(*j)->second.last_update >=

________________________________________________________________________________________________________
*** CID 1221498:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/test/libradosstriper/striping.cc: 61 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
55         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
56         uint64_t xa_size = strtoll(s_xattr.c_str(), NULL, 10);
57         ASSERT_EQ(xa_size, size);
58         // checking object content from rados point of view
59         // we will go stripe by stripe, read the content of each of them and
60         // check with expectations
>>>     CID 1221498:  Division or modulo by zero  (DIVIDE_BY_ZERO)
>>>     In expression "object_size / stripe_unit", division by expression "stripe_unit" which may be zero has undefined behavior.
61         uint64_t stripe_per_object = object_size / stripe_unit;
62         uint64_t stripe_per_objectset = stripe_per_object * stripe_count;
63         uint64_t nb_stripes_in_object = (size+stripe_unit-1)/stripe_unit;
64         for (uint64_t stripe_nb = 0;
65              stripe_nb < nb_stripes_in_object;
66              stripe_nb++) {

________________________________________________________________________________________________________
*** CID 1221499:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/test/libradosstriper/striping.cc: 70 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
64         for (uint64_t stripe_nb = 0;
65              stripe_nb < nb_stripes_in_object;
66              stripe_nb++) {
67           // find out where this stripe is stored
68           uint64_t objectset = stripe_nb / stripe_per_objectset;
69           uint64_t stripe_in_object_set = stripe_nb % stripe_per_objectset;
>>>     CID 1221499:  Division or modulo by zero  (DIVIDE_BY_ZERO)
>>>     In expression "stripe_in_object_set % stripe_count", modulo by expression "stripe_count" which may be zero has undefined behavior.
70           uint64_t object_in_set = stripe_in_object_set % stripe_count;
71           uint64_t stripe_in_object = stripe_in_object_set / stripe_count;
72           uint64_t object_nb = objectset * stripe_count + object_in_set;
73           uint64_t start = stripe_in_object * stripe_unit;
74           uint64_t len = stripe_unit;
75           if (stripe_nb == nb_stripes_in_object-1 and size % stripe_unit != 0) {

________________________________________________________________________________________________________
*** CID 1221525:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/striping.cc: 227 in StriperTestRT_StripedRoundtrip_Test::TestBody()()
221       }
222       {
223         SCOPED_TRACE("Testing remove when no object size");
224         // recreate object
225         ASSERT_EQ(0, striper.write(soid, bl1, testData.size*2, 0));
226         // remove the object size attribute from the striped object
>>>     CID 1221525:  Resource leak  (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "this->getObjName(soid, 0UL)" leaks it.
227         std::string firstOid = getObjName(soid, 0);
228         ASSERT_EQ(0, ioctx.rmxattr(firstOid, "striper.size"));
229         // check that stat fails
230         uint64_t size;
231         time_t mtime;   
232         ASSERT_EQ(-ENODATA, striper.stat(soid, &size, &mtime));

________________________________________________________________________________________________________
*** CID 1221526:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/striping.cc: 39 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
33                                 uint64_t exp_stripe_unit, uint64_t exp_stripe_count,
34                                 uint64_t exp_object_size, size_t size,
35                                 size_t actual_size_if_sparse)
36       {
37         // checking first object's rados xattrs
38         bufferlist xattrbl;
>>>     CID 1221526:  Resource leak  (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "this->getObjName(soid, 0UL)" leaks it.
39         std::string firstOid = getObjName(soid, 0);
40         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.stripe_unit", xattrbl));
41         std::string s_xattr(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
42         uint64_t stripe_unit = strtoll(s_xattr.c_str(), NULL, 10);
43         ASSERT_LT((unsigned)0, stripe_unit);
44         ASSERT_EQ(stripe_unit, exp_stripe_unit);
/test/libradosstriper/striping.cc: 86 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
80               ((actual_size_if_sparse+stripe_unit-1)/stripe_unit)-1 == stripe_nb) {
81             len = actual_size_if_sparse % stripe_unit;
82             if (0 == len) len = stripe_unit;
83           }
84           bufferlist stripe_data;
85           // check object content
>>>     CID 1221526:  Resource leak  (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "this->getObjName(soid, object_nb)" leaks it.
86           std::string oid = getObjName(soid, object_nb);
87           int rc = ioctx.read(oid, stripe_data, len, start);
88           if (actual_size_if_sparse < size and
89               (actual_size_if_sparse+stripe_unit-1)/stripe_unit <= stripe_nb) {
90             // sparse object case : the stripe does not exist, but the rados object may
91             uint64_t object_start = (object_in_set + objectset*stripe_per_objectset) * stripe_unit;
/test/libradosstriper/striping.cc: 140 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
134              ASSERT_EQ(len, rados_size);
135            }
136         }
137         // check we do not have an extra object behind
138         uint64_t rados_size;
139         time_t mtime;
>>>     CID 1221526:  Resource leak  (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "this->getObjName(soid, nb_objects)" leaks it.
140         std::string oid = getObjName(soid, nb_objects);
141         ASSERT_EQ(-ENOENT, ioctx.stat(oid, &rados_size, &mtime));
142       }
143     };
144       
145     TEST_P(StriperTestRT, StripedRoundtrip) {

________________________________________________________________________________________________________
*** CID 1221538:  Uninitialized pointer field  (UNINIT_CTOR)
/test/libradosstriper/TestCase.h: 25 in StriperTest::StriperTest()()
19      *
20      * Since pool creation and deletion is slow, this allows many tests to
21      * run faster.
22      */
23     class StriperTest : public ::testing::Test {
24     public:
>>>     CID 1221538:  Uninitialized pointer field  (UNINIT_CTOR)
>>>     Non-static class member "striper" is not initialized in this constructor nor in any functions that it calls.
25       StriperTest() {}
26       virtual ~StriperTest() {}
27     protected:
28       static void SetUpTestCase();
29       static void TearDownTestCase();
30       static rados_t s_cluster;

________________________________________________________________________________________________________
*** CID 1225099:  Unchecked return value  (CHECKED_RETURN)
/mon/MDSMonitor.cc: 1523 in MDSMonitor::filesystem_command(MMonCommand *, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detai
 l::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_>, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::
 detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_>>>> &, std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>> &, int &)()
1517           r = -EINVAL;
1518           poolid = -1;
1519           ss << "cannot remove default data pool";
1520         }
1521     
1522         if (poolid >= 0) {
>>>     CID 1225099:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "cmd_getval" without checking return value (as is done elsewhere 19 out of 22 times).
1523           cmd_getval(g_ceph_context, cmdmap, "poolid", poolid);
1524           r = pending_mdsmap.remove_data_pool(poolid);
1525           if (r == -ENOENT)
1526     	r = 0;
1527           if (r == 0)
1528     	ss << "removed data pool " << poolid << " from mdsmap";

________________________________________________________________________________________________________
*** CID 1225100:  Missing unlock  (LOCK)
/mds/MDLog.cc: 562 in MDLog::trim(int)()
556           p = segments.lower_bound(last_seq + 1);
557         }
558       }
559     
560       // discard expired segments and unlock submit_mutex
561       _trim_expired_segments();
>>>     CID 1225100:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->submit_mutex._m".
562     }
563     
564     
565     void MDLog::try_expire(LogSegment *ls, int op_prio)
566     {
567       MDSGatherBuilder gather_bld(g_ceph_context);
/mds/MDLog.cc: 562 in MDLog::trim(int)()
556           p = segments.lower_bound(last_seq + 1);
557         }
558       }
559     
560       // discard expired segments and unlock submit_mutex
561       _trim_expired_segments();
>>>     CID 1225100:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->submit_mutex._m".
562     }
563     
564     
565     void MDLog::try_expire(LogSegment *ls, int op_prio)
566     {
567       MDSGatherBuilder gather_bld(g_ceph_context);

________________________________________________________________________________________________________
*** CID 1225101:  Missing unlock  (LOCK)
/mds/MDLog.cc: 445 in MDLog::shutdown()()
439       submit_mutex.Lock();
440       stopping = true;
441       submit_cond.Signal();
442       submit_mutex.Unlock();
443     
444       mds->mds_lock.Lock();
>>>     CID 1225101:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->mds->mds_lock._m".
445     }
446     
447     
448     // -----------------------------
449     // segments
450     


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



