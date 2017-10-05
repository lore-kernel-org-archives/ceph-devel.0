From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 05 Oct 2017 05:08:25 +0000 (UTC)
Message-ID: <59d5be492d554_3a5b40932c35368@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.hv1nn.shared.sendgrid.net ([167.89.100.169]:49877 "EHLO
        o1.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751297AbdJEFI7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Oct 2017 01:08:59 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0018p1las1.sendgrid.net (SG) with ESMTP id Bs-4qf0LRxG2LpZv89YxgQ
        for <ceph-devel@vger.kernel.org>; Thu, 05 Oct 2017 05:08:25.414 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

22 new defect(s) introduced to ceph found with Coverity Scan.
36 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 22 defect(s)


** CID 1297802:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/osdc/Objecter.cc: 1905 in Objecter::wait_for_osd_map()()


________________________________________________________________________________________________________
*** CID 1297802:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/osdc/Objecter.cc: 1905 in Objecter::wait_for_osd_map()()
1899       Cond cond;
1900       bool done;
1901       lock.Lock();
1902       C_SafeCond *context = new C_SafeCond(&lock, &cond, &done, NULL);
1903       waiting_for_map[0].push_back(pair<Context*, int>(context, 0));
1904       l.unlock();
>>>     CID 1297802:  Program hangs  (INFINITE_LOOP)
>>>     If "done" is initially false then it will remain false.
1905       while (!done)
1906         cond.Wait(lock);
1907       lock.Unlock();
1908     }
1909     
1910     struct C_Objecter_GetVersion : public Context {

** CID 1351616:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/common/ceph_timer.h: 230 in ceph::timer_detail::timer<ceph::time_detail::mono_clock>::add_event<Objecter::submit_command(Objecter::CommandOp *, unsigned long *)::[lambda() (instance 1)]>(std::chrono::time_point<ceph::time_detail::mono_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>, T1 &&, T2 &&...)()


________________________________________________________________________________________________________
*** CID 1351616:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/common/ceph_timer.h: 230 in ceph::timer_detail::timer<ceph::time_detail::mono_clock>::add_event<Objecter::submit_command(Objecter::CommandOp *, unsigned long *)::[lambda() (instance 1)]>(std::chrono::time_point<ceph::time_detail::mono_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>, T1 &&, T2 &&...)()
224     	// Previously each event was a context, identified by a
225     	// pointer, and each context to be called only once. Since you
226     	// can queue the same function pointer, member function,
227     	// lambda, or functor up multiple times, identifying things by
228     	// function for the purposes of cancellation is no longer
229     	// suitable. Thus:
>>>     CID 1351616:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "e" going out of scope leaks the storage it points to.
230     	return e.id;
231           }
232     
233           // Adjust the timeout of a currently-scheduled event (relative)
234           bool adjust_event(uint64_t id, typename TC::duration duration) {
235     	return adjust_event(id, TC::now() + duration);

** CID 1351659:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/multi_stress_watch.cc: 118 in main()
/home/brad/working/src/ceph/src/test/multi_stress_watch.cc: 118 in main()


________________________________________________________________________________________________________
*** CID 1351659:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/multi_stress_watch.cc: 118 in main()
112     
113       cluster.wait_for_latest_osdmap();
114       test_loop(cluster, pool_name, obj_name);
115       return;
116     }
117     
>>>     CID 1351659:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
118     int main(int args, char **argv)
119     {
120       if (args != 3 && args != 4) {
121         std::cerr << "Error: " << argv[0] << " [ec|rep] pool_name obj_name" << std::endl;
122         return 1;
123       }
/home/brad/working/src/ceph/src/test/multi_stress_watch.cc: 118 in main()
112     
113       cluster.wait_for_latest_osdmap();
114       test_loop(cluster, pool_name, obj_name);
115       return;
116     }
117     
>>>     CID 1351659:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
118     int main(int args, char **argv)
119     {
120       if (args != 3 && args != 4) {
121         std::cerr << "Error: " << argv[0] << " [ec|rep] pool_name obj_name" << std::endl;
122         return 1;
123       }

** CID 1351672:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/kv_store_bench.cc: 553 in main()
/home/brad/working/src/ceph/src/test/kv_store_bench.cc: 553 in main()
/home/brad/working/src/ceph/src/test/kv_store_bench.cc: 553 in main()


________________________________________________________________________________________________________
*** CID 1351672:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/kv_store_bench.cc: 553 in main()
547       } else {
548         err = test_teuthology_sync(&KvStoreBench::rand_distr, probs);
549       }
550       return err;
551     }
552     
>>>     CID 1351672:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
553     int main(int argc, const char** argv) {
554       KvStoreBench kvsb;
555       int err = kvsb.setup(argc, argv);
556       if (err == 0) cout << "setup successful" << std::endl;
557       else{
558         cout << "error " << err << std::endl;
/home/brad/working/src/ceph/src/test/kv_store_bench.cc: 553 in main()
547       } else {
548         err = test_teuthology_sync(&KvStoreBench::rand_distr, probs);
549       }
550       return err;
551     }
552     
>>>     CID 1351672:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
553     int main(int argc, const char** argv) {
554       KvStoreBench kvsb;
555       int err = kvsb.setup(argc, argv);
556       if (err == 0) cout << "setup successful" << std::endl;
557       else{
558         cout << "error " << err << std::endl;
/home/brad/working/src/ceph/src/test/kv_store_bench.cc: 553 in main()
547       } else {
548         err = test_teuthology_sync(&KvStoreBench::rand_distr, probs);
549       }
550       return err;
551     }
552     
>>>     CID 1351672:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
553     int main(int argc, const char** argv) {
554       KvStoreBench kvsb;
555       int err = kvsb.setup(argc, argv);
556       if (err == 0) cout << "setup successful" << std::endl;
557       else{
558         cout << "error " << err << std::endl;

** CID 1355572:    (INFINITE_LOOP)
/home/brad/working/src/ceph/src/tools/cephfs/Resetter.cc: 58 in Resetter::reset(mds_role_t)()
/home/brad/working/src/ceph/src/tools/cephfs/Resetter.cc: 96 in Resetter::reset(mds_role_t)()


________________________________________________________________________________________________________
*** CID 1355572:    (INFINITE_LOOP)
/home/brad/working/src/ceph/src/tools/cephfs/Resetter.cc: 58 in Resetter::reset(mds_role_t)()
52     
53       lock.Lock();
54       journaler.recover(new C_SafeCond(&mylock, &cond, &done, &r));
55       lock.Unlock();
56     
57       mylock.Lock();
>>>     CID 1355572:    (INFINITE_LOOP)
>>>     If "done" is initially false then it will remain false.
58       while (!done)
59         cond.Wait(mylock);
60       mylock.Unlock();
61     
62       if (r != 0) {
63         if (r == -ENOENT) {
/home/brad/working/src/ceph/src/tools/cephfs/Resetter.cc: 96 in Resetter::reset(mds_role_t)()
90     
91       cout << "writing journal head" << std::endl;
92       journaler.write_head(new C_SafeCond(&mylock, &cond, &done, &r));
93       lock.Unlock();
94     
95       mylock.Lock();
>>>     CID 1355572:    (INFINITE_LOOP)
>>>     If "done" is initially false then it will remain false.
96       while (!done)
97         cond.Wait(mylock);
98       mylock.Unlock();
99     
100       Mutex::Locker l(lock);
101       if (r != 0) {

** CID 1395778:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/common/ceph_timer.h: 230 in ceph::timer_detail::timer<ceph::time_detail::mono_clock>::add_event<Objecter::get_pool_stats(std::__cxx11::list<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &, std::map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, pool_stat_t, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, pool_stat_t>>> *, Context *)::[lambda() (instance 1)]>(std::chrono::time_point<ceph::time_detail::mono_clock, std::chrono::duration<unsigned long
 , std::ratio<(long)1, (long)1000000000>>>, T1 &&, T2 &&...)()
/home/brad/working/src/ceph/src/common/ceph_timer.h: 230 in ceph::timer_detail::timer<ceph::time_detail::mono_clock>::add_event<Objecter::get_fs_stats(ceph_statfs &, boost::optional<long>, Context *)::[lambda() (instance 1)]>(std::chrono::time_point<ceph::time_detail::mono_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>, T1 &&, T2 &&...)()


________________________________________________________________________________________________________
*** CID 1395778:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/common/ceph_timer.h: 230 in ceph::timer_detail::timer<ceph::time_detail::mono_clock>::add_event<Objecter::get_pool_stats(std::__cxx11::list<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &, std::map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, pool_stat_t, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, pool_stat_t>>> *, Context *)::[lambda() (instance 1)]>(std::chrono::time_point<ceph::time_detail::mono_clock, std::chrono::duration<unsigned long
 , std::ratio<(long)1, (long)1000000000>>>, T1 &&, T2 &&...)()
224     	// Previously each event was a context, identified by a
225     	// pointer, and each context to be called only once. Since you
226     	// can queue the same function pointer, member function,
227     	// lambda, or functor up multiple times, identifying things by
228     	// function for the purposes of cancellation is no longer
229     	// suitable. Thus:
>>>     CID 1395778:    (RESOURCE_LEAK)
>>>     Variable "e" going out of scope leaks the storage it points to.
230     	return e.id;
231           }
232     
233           // Adjust the timeout of a currently-scheduled event (relative)
234           bool adjust_event(uint64_t id, typename TC::duration duration) {
235     	return adjust_event(id, TC::now() + duration);
/home/brad/working/src/ceph/src/common/ceph_timer.h: 230 in ceph::timer_detail::timer<ceph::time_detail::mono_clock>::add_event<Objecter::get_fs_stats(ceph_statfs &, boost::optional<long>, Context *)::[lambda() (instance 1)]>(std::chrono::time_point<ceph::time_detail::mono_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>, T1 &&, T2 &&...)()
224     	// Previously each event was a context, identified by a
225     	// pointer, and each context to be called only once. Since you
226     	// can queue the same function pointer, member function,
227     	// lambda, or functor up multiple times, identifying things by
228     	// function for the purposes of cancellation is no longer
229     	// suitable. Thus:
>>>     CID 1395778:    (RESOURCE_LEAK)
>>>     Variable "e" going out of scope leaks the storage it points to.
230     	return e.id;
231           }
232     
233           // Adjust the timeout of a currently-scheduled event (relative)
234           bool adjust_event(uint64_t id, typename TC::duration duration) {
235     	return adjust_event(id, TC::now() + duration);

** CID 1396149:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/include/rados/rados_types.hpp: 186 in librados::inconsistent_obj_t::inconsistent_obj_t()()


________________________________________________________________________________________________________
*** CID 1396149:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/include/rados/rados_types.hpp: 186 in librados::inconsistent_obj_t::inconsistent_obj_t()()
180       bool has_deep_errors() const {
181         return errors & DEEP_ERRORS;
182       }
183     };
184     
185     struct inconsistent_obj_t : obj_err_t {
>>>     CID 1396149:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "version" is not initialized in this constructor nor in any functions that it calls.
186       inconsistent_obj_t() = default;
187       inconsistent_obj_t(const object_id_t& object)
188         : object{object}, version(0)
189       {}
190       object_id_t object;
191       uint64_t version;  // XXX: Redundant with object info attr

** CID 1400655:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osdc/Objecter.cc: 2892 in Objecter::_calc_target(Objecter::op_target_t *, Connection *, bool)()


________________________________________________________________________________________________________
*** CID 1400655:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osdc/Objecter.cc: 2892 in Objecter::_calc_target(Objecter::op_target_t *, Connection *, bool)()
2886         if (acting_primary == -1) {
2887           t->osd = -1;
2888         } else {
2889           int osd;
2890           bool read = is_read && !is_write;
2891           if (read && (t->flags & CEPH_OSD_FLAG_BALANCE_READS)) {
>>>     CID 1400655:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2892     	int p = rand() % acting.size();
2893     	if (p)
2894     	  t->used_replica = true;
2895     	osd = acting[p];
2896     	ldout(cct, 10) << " chose random osd." << osd << " of " << acting
2897     		       << dendl;

** CID 1402139:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/list.cc: 563 in LibRadosList_ListObjectsCursor_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/list.cc: 561 in LibRadosList_ListObjectsCursor_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/list.cc: 552 in LibRadosList_ListObjectsCursor_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/list.cc: 603 in LibRadosList_ListObjectsCursor_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/list.cc: 600 in LibRadosList_ListObjectsCursor_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/list.cc: 597 in LibRadosList_ListObjectsCursor_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1402139:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/list.cc: 563 in LibRadosList_ListObjectsCursor_Test::TestBody()()
557           ASSERT_EQ(rados_nobjects_list_get_cursor(ctx, &cursor), 0);
558           cout << "> oid=" << oid << " cursor=" << ObjectCursor(cursor) << std::endl;
559         }
560         rados_nobjects_list_seek_cursor(ctx, first_cursor);
561         ASSERT_EQ(rados_nobjects_list_next(ctx, &entry, NULL, NULL), 0);
562         cout << "FIRST> seek to " << ObjectCursor(first_cursor) << " oid=" << string(entry) << std::endl;
>>>     CID 1402139:    (RESOURCE_LEAK)
>>>     Variable "cursor" going out of scope leaks the storage it points to.
563       }
564       rados_list_ctx_t ctx;
565       ASSERT_EQ(0, rados_nobjects_list_open(ioctx, &ctx));
566     
567       std::map<rados_object_list_cursor, string> cursor_to_obj;
568       int count = 0;
/home/brad/working/src/ceph/src/test/librados/list.cc: 561 in LibRadosList_ListObjectsCursor_Test::TestBody()()
555         while (rados_nobjects_list_next(ctx, &entry, NULL, NULL) == 0) {
556           string oid = entry;
557           ASSERT_EQ(rados_nobjects_list_get_cursor(ctx, &cursor), 0);
558           cout << "> oid=" << oid << " cursor=" << ObjectCursor(cursor) << std::endl;
559         }
560         rados_nobjects_list_seek_cursor(ctx, first_cursor);
>>>     CID 1402139:    (RESOURCE_LEAK)
>>>     Variable "cursor" going out of scope leaks the storage it points to.
561         ASSERT_EQ(rados_nobjects_list_next(ctx, &entry, NULL, NULL), 0);
562         cout << "FIRST> seek to " << ObjectCursor(first_cursor) << " oid=" << string(entry) << std::endl;
563       }
564       rados_list_ctx_t ctx;
565       ASSERT_EQ(0, rados_nobjects_list_open(ioctx, &ctx));
566     
/home/brad/working/src/ceph/src/test/librados/list.cc: 552 in LibRadosList_ListObjectsCursor_Test::TestBody()()
546     
547       {
548         rados_list_ctx_t ctx;
549         const char *entry;
550         rados_object_list_cursor cursor;
551         ASSERT_EQ(0, rados_nobjects_list_open(ioctx, &ctx));
>>>     CID 1402139:    (RESOURCE_LEAK)
>>>     Variable "cursor" going out of scope leaks the storage it points to.
552         ASSERT_EQ(rados_nobjects_list_get_cursor(ctx, &cursor), 0);
553         rados_object_list_cursor first_cursor = cursor;
554         cout << "x cursor=" << ObjectCursor(cursor) << std::endl;
555         while (rados_nobjects_list_next(ctx, &entry, NULL, NULL) == 0) {
556           string oid = entry;
557           ASSERT_EQ(rados_nobjects_list_get_cursor(ctx, &cursor), 0);
/home/brad/working/src/ceph/src/test/librados/list.cc: 603 in LibRadosList_ListObjectsCursor_Test::TestBody()()
597         ASSERT_EQ(rados_nobjects_list_get_cursor(ctx, &cursor), 0);
598         cout << ": cursor()=" << ObjectCursor(cursor) << " expected=" << oid << std::endl;
599         // ASSERT_EQ(ObjectCursor(oid), ObjectCursor(cursor));
600         ASSERT_EQ(rados_nobjects_list_next(ctx, &entry, NULL, NULL), 0);
601         cout << "> " << ObjectCursor(cursor) << " -> " << entry << std::endl;
602         cout << ": entry=" << entry << " expected=" << p->second << std::endl;
>>>     CID 1402139:    (RESOURCE_LEAK)
>>>     Variable "cursor" going out of scope leaks the storage it points to.
603         ASSERT_EQ(p->second, string(entry));
604     
605         ++p;
606     
607         rados_object_list_cursor_free(ctx, cursor);
608       }
/home/brad/working/src/ceph/src/test/librados/list.cc: 600 in LibRadosList_ListObjectsCursor_Test::TestBody()()
594         rados_object_list_cursor cursor;
595         rados_object_list_cursor oid(p->first);
596         rados_nobjects_list_seek_cursor(ctx, oid);
597         ASSERT_EQ(rados_nobjects_list_get_cursor(ctx, &cursor), 0);
598         cout << ": cursor()=" << ObjectCursor(cursor) << " expected=" << oid << std::endl;
599         // ASSERT_EQ(ObjectCursor(oid), ObjectCursor(cursor));
>>>     CID 1402139:    (RESOURCE_LEAK)
>>>     Variable "cursor" going out of scope leaks the storage it points to.
600         ASSERT_EQ(rados_nobjects_list_next(ctx, &entry, NULL, NULL), 0);
601         cout << "> " << ObjectCursor(cursor) << " -> " << entry << std::endl;
602         cout << ": entry=" << entry << " expected=" << p->second << std::endl;
603         ASSERT_EQ(p->second, string(entry));
604     
605         ++p;
/home/brad/working/src/ceph/src/test/librados/list.cc: 597 in LibRadosList_ListObjectsCursor_Test::TestBody()()
591       ASSERT_EQ(0, rados_nobjects_list_open(ioctx, &ctx));
592       while (p != cursor_to_obj.rend()) {
593         cout << ": seek to " << ObjectCursor(p->first) << std::endl;
594         rados_object_list_cursor cursor;
595         rados_object_list_cursor oid(p->first);
596         rados_nobjects_list_seek_cursor(ctx, oid);
>>>     CID 1402139:    (RESOURCE_LEAK)
>>>     Variable "cursor" going out of scope leaks the storage it points to.
597         ASSERT_EQ(rados_nobjects_list_get_cursor(ctx, &cursor), 0);
598         cout << ": cursor()=" << ObjectCursor(cursor) << " expected=" << oid << std::endl;
599         // ASSERT_EQ(ObjectCursor(oid), ObjectCursor(cursor));
600         ASSERT_EQ(rados_nobjects_list_next(ctx, &entry, NULL, NULL), 0);
601         cout << "> " << ObjectCursor(cursor) << " -> " << entry << std::endl;
602         cout << ": entry=" << entry << " expected=" << p->second << std::endl;

** CID 1405343:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/rbd_mirror/test_main.cc: 20 in main()


________________________________________________________________________________________________________
*** CID 1405343:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/rbd_mirror/test_main.cc: 20 in main()
14     extern void register_test_instances();
15     extern void register_test_leader_watcher();
16     extern void register_test_pool_watcher();
17     extern void register_test_rbd_mirror();
18     extern void register_test_rbd_mirror_image_deleter();
19     
>>>     CID 1405343:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
20     int main(int argc, char **argv)
21     {
22       register_test_cluster_watcher();
23       register_test_image_sync();
24       register_test_instance_watcher();
25       register_test_instances();

** CID 1405347:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librbd/test_main.cc: 24 in main()


________________________________________________________________________________________________________
*** CID 1405347:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librbd/test_main.cc: 24 in main()
18     extern void register_test_object_map();
19     extern void register_test_operations();
20     extern void register_test_mirroring();
21     extern void register_test_mirroring_watcher();
22     #endif // TEST_LIBRBD_INTERNALS
23     
>>>     CID 1405347:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
24     int main(int argc, char **argv)
25     {
26       register_test_librbd();
27     #ifdef TEST_LIBRBD_INTERNALS
28       register_test_groups();
29       register_test_image_watcher();

** CID 1405350:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/libcephfs/access.cc: 362 in main()


________________________________________________________________________________________________________
*** CID 1405350:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/libcephfs/access.cc: 362 in main()
356     out:
357       ceph_shutdown(admin);
358       return r;
359     }
360     
361     
>>>     CID 1405350:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
362     int main(int argc, char **argv)
363     {
364       int r = update_root_mode();
365       if (r < 0)
366         exit(1);
367     

** CID 1413801:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/common/ceph_timer.h: 230 in ceph::timer_detail::timer<ceph::time_detail::mono_clock>::add_event<Objecter::_op_submit_with_budget(Objecter::Op *, ceph::shunique_lock<boost::shared_mutex> &, unsigned long *, int *)::[lambda() (instance 1)]>(std::chrono::time_point<ceph::time_detail::mono_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>, T1 &&, T2 &&...)()


________________________________________________________________________________________________________
*** CID 1413801:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/common/ceph_timer.h: 230 in ceph::timer_detail::timer<ceph::time_detail::mono_clock>::add_event<Objecter::_op_submit_with_budget(Objecter::Op *, ceph::shunique_lock<boost::shared_mutex> &, unsigned long *, int *)::[lambda() (instance 1)]>(std::chrono::time_point<ceph::time_detail::mono_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>, T1 &&, T2 &&...)()
224     	// Previously each event was a context, identified by a
225     	// pointer, and each context to be called only once. Since you
226     	// can queue the same function pointer, member function,
227     	// lambda, or functor up multiple times, identifying things by
228     	// function for the purposes of cancellation is no longer
229     	// suitable. Thus:
>>>     CID 1413801:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "e" going out of scope leaks the storage it points to.
230     	return e.id;
231           }
232     
233           // Adjust the timeout of a currently-scheduled event (relative)
234           bool adjust_event(uint64_t id, typename TC::duration duration) {
235     	return adjust_event(id, TC::now() + duration);

** CID 1418951:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/tools/rbd/action/Bench.cc: 134 in rbd::action::bench::rbd_bencher::start_io(int, unsigned long, unsigned long, int, bool)()


________________________________________________________________________________________________________
*** CID 1418951:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/tools/rbd/action/Bench.cc: 134 in rbd::action::bench::rbd_bencher::start_io(int, unsigned long, unsigned long, int, bool)()
128       }
129         
130       void start_io(int max, uint64_t off, uint64_t len, int op_flags, bool read_flag)
131       {
132         {
133           Mutex::Locker l(lock);
>>>     CID 1418951:  Concurrent data access violations  (MISSING_LOCK)
>>>     Accessing "this->in_flight" without holding lock "Mutex._m". Elsewhere, "_ZN3rbd6action5bench11rbd_bencherE.in_flight" is accessed with "Mutex._m" held 1 out of 2 times (1 of these accesses strongly imply that it is necessary).
134           in_flight++;
135         }
136     
137         librbd::RBD::AioCompletion *c;
138         if (read_flag) {
139           bufferlist *read_bl = new bufferlist();

** CID 1418952:  Control flow issues  (MISSING_BREAK)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 6882 in PrimaryLogPG::_rollback_to(PrimaryLogPG::OpContext *, ceph_osd_op &)()


________________________________________________________________________________________________________
*** CID 1418952:  Control flow issues  (MISSING_BREAK)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 6882 in PrimaryLogPG::_rollback_to(PrimaryLogPG::OpContext *, ceph_osd_op &)()
6876           return -EAGAIN;
6877         case cache_result_t::BLOCKED_FULL:
6878           block_write_on_full_cache(soid, ctx->op);
6879           return -EAGAIN;
6880         case cache_result_t::REPLIED_WITH_EAGAIN:
6881           assert(0 == "this can't happen, no rollback on replica");
>>>     CID 1418952:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
6882         default:
6883           assert(0 == "must promote was set, other values are not valid");
6884           return -EAGAIN;
6885         }
6886       }
6887     

** CID 1418953:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/tools/rbd/action/Bench.cc: 125 in rbd::action::bench::rbd_bencher::rbd_bencher(librbd::Image *, rbd::action::bench::<unnamed>::io_type_t, unsigned long)()


________________________________________________________________________________________________________
*** CID 1418953:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/tools/rbd/action/Bench.cc: 125 in rbd::action::bench::rbd_bencher::rbd_bencher(librbd::Image *, rbd::action::bench::<unnamed>::io_type_t, unsigned long)()
119           in_flight(0),
120           io_type(io_type),
121           io_size(io_size)
122       {
123         if (io_type == IO_TYPE_WRITE || io_type == IO_TYPE_RW) {
124           bufferptr bp(io_size);
>>>     CID 1418953:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
125           memset(bp.c_str(), rand() & 0xff, io_size);
126           write_bl.push_back(bp);
127         }
128       }
129         
130       void start_io(int max, uint64_t off, uint64_t len, int op_flags, bool read_flag)

** CID 1418954:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/tools/rbd/action/Bench.cc: 235 in rbd::action::bench::do_bench(librbd::Image &, rbd::action::bench::<unnamed>::io_type_t, unsigned long, unsigned long, unsigned long, bool, unsigned long)()
/home/brad/working/src/ceph/src/tools/rbd/action/Bench.cc: 277 in rbd::action::bench::do_bench(librbd::Image &, rbd::action::bench::<unnamed>::io_type_t, unsigned long, unsigned long, unsigned long, bool, unsigned long)()


________________________________________________________________________________________________________
*** CID 1418954:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/tools/rbd/action/Bench.cc: 235 in rbd::action::bench::do_bench(librbd::Image &, rbd::action::bench::<unnamed>::io_type_t, unsigned long, unsigned long, unsigned long, bool, unsigned long)()
229       uint64_t start_pos;
230     
231       uint64_t unit_len = size/io_size/io_threads;
232       // disturb all thread's offset
233       for (i = 0; i < io_threads; i++) {
234         if (random) {
>>>     CID 1418954:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
235           start_pos = (rand() % (size / io_size)) * io_size;
236         } else {
237           start_pos = unit_len * i * io_size;
238         }
239         thread_offset.push_back(start_pos);
240       }
/home/brad/working/src/ceph/src/tools/rbd/action/Bench.cc: 277 in rbd::action::bench::do_bench(librbd::Image &, rbd::action::bench::<unnamed>::io_type_t, unsigned long, unsigned long, unsigned long, bool, unsigned long)()
271           bool read_flag = should_read(read_proportion);
272     
273           b.wait_for(io_threads - 1);
274           b.start_io(io_threads, thread_offset[i], io_size, op_flags, read_flag);
275     
276           if (random) {
>>>     CID 1418954:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
277             thread_offset[i] = (rand() % (size / io_size)) * io_size;
278           } else {
279             thread_offset[i] += io_size;
280             if (thread_offset[i] + io_size > size)
281               thread_offset[i] = 0;
282           }

** CID 1418955:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/osdc/Journaler.cc: 562 in Journaler::append_entry(ceph::buffer::list &)()


________________________________________________________________________________________________________
*** CID 1418955:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/osdc/Journaler.cc: 562 in Journaler::append_entry(ceph::buffer::list &)()
556         l.lock();
557       }
558       ldout(cct, 20) << "write_buf_throttle get, delta " << delta << dendl;
559       size_t wrote = journal_stream.write(bl, &write_buf, write_pos);
560       ldout(cct, 10) << "append_entry len " << s << " to " << write_pos << "~"
561     		 << wrote << dendl;
>>>     CID 1418955:  Concurrent data access violations  (MISSING_LOCK)
>>>     Accessing "this->write_pos" without holding lock "Journaler.lock". Elsewhere, "Journaler.write_pos" is accessed with "Journaler.lock" held 6 out of 8 times (1 of these accesses strongly imply that it is necessary).
562       write_pos += wrote;
563     
564       // flush previous object?
565       uint64_t su = get_layout_period();
566       assert(su > 0);
567       uint64_t write_off = write_pos % su;

** CID 1418956:    (DIVIDE_BY_ZERO)
/home/brad/working/src/ceph/src/tools/rbd/action/Bench.cc: 231 in rbd::action::bench::do_bench(librbd::Image &, rbd::action::bench::<unnamed>::io_type_t, unsigned long, unsigned long, unsigned long, bool, unsigned long)()
/home/brad/working/src/ceph/src/tools/rbd/action/Bench.cc: 235 in rbd::action::bench::do_bench(librbd::Image &, rbd::action::bench::<unnamed>::io_type_t, unsigned long, unsigned long, unsigned long, bool, unsigned long)()


________________________________________________________________________________________________________
*** CID 1418956:    (DIVIDE_BY_ZERO)
/home/brad/working/src/ceph/src/tools/rbd/action/Bench.cc: 231 in rbd::action::bench::do_bench(librbd::Image &, rbd::action::bench::<unnamed>::io_type_t, unsigned long, unsigned long, unsigned long, bool, unsigned long)()
225       unsigned ios = 0;
226     
227       vector<uint64_t> thread_offset;
228       uint64_t i;
229       uint64_t start_pos;
230     
>>>     CID 1418956:    (DIVIDE_BY_ZERO)
>>>     In expression "size / io_size", division by expression "io_size" which may be zero has undefined behavior.
231       uint64_t unit_len = size/io_size/io_threads;
232       // disturb all thread's offset
233       for (i = 0; i < io_threads; i++) {
234         if (random) {
235           start_pos = (rand() % (size / io_size)) * io_size;
236         } else {
/home/brad/working/src/ceph/src/tools/rbd/action/Bench.cc: 235 in rbd::action::bench::do_bench(librbd::Image &, rbd::action::bench::<unnamed>::io_type_t, unsigned long, unsigned long, unsigned long, bool, unsigned long)()
229       uint64_t start_pos;
230     
231       uint64_t unit_len = size/io_size/io_threads;
232       // disturb all thread's offset
233       for (i = 0; i < io_threads; i++) {
234         if (random) {
>>>     CID 1418956:    (DIVIDE_BY_ZERO)
>>>     In expression "size / io_size", division by expression "io_size" which may be zero has undefined behavior.
235           start_pos = (rand() % (size / io_size)) * io_size;
236         } else {
237           start_pos = unit_len * i * io_size;
238         }
239         thread_offset.push_back(start_pos);
240       }

** CID 1418957:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/rbd_mirror/test_mock_ImageSync.cc: 107 in rbd::mirror::image_sync::MetadataCopyRequest<librbd::<unnamed>::MockTestImageCtx>::MetadataCopyRequest()()


________________________________________________________________________________________________________
*** CID 1418957:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/rbd_mirror/test_mock_ImageSync.cc: 107 in rbd::mirror::image_sync::MetadataCopyRequest<librbd::<unnamed>::MockTestImageCtx>::MetadataCopyRequest()()
101         s_instance->on_finish = on_finish;
102         return s_instance;
103       }
104     
105       MetadataCopyRequest() {
106         s_instance = this;
>>>     CID 1418957:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "on_finish" is not initialized in this constructor nor in any functions that it calls.
107       }
108     
109       MOCK_METHOD0(send, void());
110     };
111     
112     template <>


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FCBsNVyGXtBtUu5bDT7ItSJQjbRl2Ee4PG8K-2FycjN-2FryFBgcAdPnrk7XQ2BwD363FcC64gju3cTdVPd5CXN3UpGQ9pNaBVxW5DlJWx6FvI-2Fusuy8N7nHTMXyHFzu6ZE7DP2NfsqwknjJ-2BabyRng3m2F09WHzdfoBrvXBxXmzusZ2PNPiX8No6jOuoui1mYK-2Bg-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FCBsNVyGXtBtUu5bDT7ItSJQjbRl2Ee4PG8K-2FycjN-2Fr5NZ21oVA-2BuXJqzPU5-2FfcCwOcWCXSWNYGUmQzReV9wL9TmFx6aqZq59o87d2HGDOlnMeK5G0ScClfZtw3Frkfm01q34FqqL5GVMfthacoCk8Lmpr6XOPbICMdf5U9STR5M78EIdk8fWkfoPI7h5-2BEa4-3D

