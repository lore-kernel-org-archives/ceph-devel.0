From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 30 Mar 2017 18:25:36 -0700
Message-ID: <58ddb01010333_726e12f7320702d9@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:57118 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934695AbdCaBZi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Mar 2017 21:25:38 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id VSYpE6KORSeERITBUpw7YQ
        for <ceph-devel@vger.kernel.org>; Fri, 31 Mar 2017 01:25:36.095 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

21 new defect(s) introduced to ceph found with Coverity Scan.
2 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 21 defect(s)


** CID 1160831:  Program hangs  (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1160831:  Program hangs  (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/common/ceph_context.cc: 709 in CephContext::reopen_logs()()
703     }
704     
705     void CephContext::reopen_logs()
706     {
707       ceph_spin_lock(&_service_thread_lock);
708       if (_service_thread)
>>>     CID 1160831:  Program hangs  (ORDER_REVERSAL)
>>>     Calling "reopen_logs" acquires lock "Mutex._m" while holding lock "ceph_spinlock_t.lock" (count: 3 / 23).
709         _service_thread->reopen_logs();
710       ceph_spin_unlock(&_service_thread_lock);
711     }
712     
713     void CephContext::join_service_thread()
714     {

** CID 1403541:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/ObjectMap/test_object_map.cc: 1030 in ObjectMapTest_RandomTestNoDeletesXattrs_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1403541:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/ObjectMap/test_object_map.cc: 1030 in ObjectMapTest_RandomTestNoDeletesXattrs_Test::TestBody()()
1024       }
1025     }
1026     
1027     TEST_F(ObjectMapTest, RandomTestNoDeletesXattrs) {
1028       tester.def_init();
1029       for (unsigned i = 0; i < 5000; ++i) {
>>>     CID 1403541:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
1030         unsigned val = rand();
1031         val <<= 8;
1032         val %= 100;
1033         if (!(i%100))
1034           std::cout << "on op " << i
1035     		<< " val is " << val << std::endl;

** CID 1403542:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/os/ObjectStore.cc: 82 in ObjectStore::create(CephContext *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned int)()


________________________________________________________________________________________________________
*** CID 1403542:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/os/ObjectStore.cc: 82 in ObjectStore::create(CephContext *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned int)()
76       if (type == "bluestore" &&
77           cct->check_experimental_feature_enabled("bluestore")) {
78         return new BlueStore(cct, data);
79       }
80       if (type == "random" &&
81           cct->check_experimental_feature_enabled("bluestore")) {
>>>     CID 1403542:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
82         if (rand() % 2) {
83           return new FileStore(cct, data, journal, flags);
84         } else {
85           return new BlueStore(cct, data);
86         }
87       }

** CID 1403543:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/ObjectMap/test_object_map.cc: 297 in ObjectMapTester::auto_set_keys(std::basic_ostream<char, std::char_traits<char>>&)()


________________________________________________________________________________________________________
*** CID 1403543:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/ObjectMap/test_object_map.cc: 297 in ObjectMapTester::auto_set_keys(std::basic_ostream<char, std::char_traits<char>>&)()
291       }
292     
293       void auto_set_keys(ostream &out) {
294         set<string>::iterator object = rand_choose(object_name_space);
295     
296         map<string, string> to_set;
>>>     CID 1403543:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
297         unsigned amount = (rand() % 10) + 1;
298         for (unsigned i = 0; i < amount; ++i) {
299           set<string>::iterator key = rand_choose(key_space);
300           string value = val_from_key(*object, *key);
301           out << "auto_set_key " << *object << ": " << *key << " -> "
302     	  << value << std::endl;

** CID 1403544:    (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 2040 in CrushWrapper::_choose_type_stack(CephContext *, const std::vector<std::pair<int, int>, std::allocator<std::pair<int, int>>> &, const std::set<int, std::less<int>, std::allocator<int>> &, std::vector<int, std::allocator<int>>&, std::vector<int, std::allocator<int>>&, __gnu_cxx::__normal_iterator<const int *, std::vector<int, std::allocator<int>>> &, std::set<int, std::less<int>, std::allocator<int>> &, std::vector<int, std::allocator<int>>*) const()
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 2040 in CrushWrapper::_choose_type_stack(CephContext *, const std::vector<std::pair<int, int>, std::allocator<std::pair<int, int>>> &, const std::set<int, std::less<int>, std::allocator<int>> &, std::vector<int, std::allocator<int>>&, std::vector<int, std::allocator<int>>&, __gnu_cxx::__normal_iterator<const int *, std::vector<int, std::allocator<int>>> &, std::set<int, std::less<int>, std::allocator<int>> &, std::vector<int, std::allocator<int>>*) const()


________________________________________________________________________________________________________
*** CID 1403544:    (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 2040 in CrushWrapper::_choose_type_stack(CephContext *, const std::vector<std::pair<int, int>, std::allocator<std::pair<int, int>>> &, const std::set<int, std::less<int>, std::allocator<int>> &, std::vector<int, std::allocator<int>>&, std::vector<int, std::allocator<int>>&, __gnu_cxx::__normal_iterator<const int *, std::vector<int, std::allocator<int>>> &, std::set<int, std::less<int>, std::allocator<int>> &, std::vector<int, std::allocator<int>>*) const()
2034         for (auto from : w) {
2035           ldout(cct, 10) << " from " << from << dendl;
2036     
2037           for (int pos = 0; pos < fanout; ++pos) {
2038     	if (type > 0) {
2039     	  // non-leaf
>>>     CID 1403544:    (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "tmpi" though it is already past the end of its container.
2040     	  int item = *tmpi;
2041     	  do {
2042     	    int r = get_immediate_parent_id(item, &item);
2043     	    if (r < 0) {
2044     	      ldout(cct, 10) << __func__ << " parent of " << item << " got "
2045     			     << cpp_strerror(r) << dendl;
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 2040 in CrushWrapper::_choose_type_stack(CephContext *, const std::vector<std::pair<int, int>, std::allocator<std::pair<int, int>>> &, const std::set<int, std::less<int>, std::allocator<int>> &, std::vector<int, std::allocator<int>>&, std::vector<int, std::allocator<int>>&, __gnu_cxx::__normal_iterator<const int *, std::vector<int, std::allocator<int>>> &, std::set<int, std::less<int>, std::allocator<int>> &, std::vector<int, std::allocator<int>>*) const()
2034         for (auto from : w) {
2035           ldout(cct, 10) << " from " << from << dendl;
2036     
2037           for (int pos = 0; pos < fanout; ++pos) {
2038     	if (type > 0) {
2039     	  // non-leaf
>>>     CID 1403544:    (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "tmpi" though it is already past the end of its container.
2040     	  int item = *tmpi;
2041     	  do {
2042     	    int r = get_immediate_parent_id(item, &item);
2043     	    if (r < 0) {
2044     	      ldout(cct, 10) << __func__ << " parent of " << item << " got "
2045     			     << cpp_strerror(r) << dendl;

** CID 1403545:  Program hangs  (LOCK)
/home/brad/working/src/ceph/src/librados/AioCompletionImpl.h: 220 in librados::C_AioCompleteAndSafe::finish(int)()


________________________________________________________________________________________________________
*** CID 1403545:  Program hangs  (LOCK)
/home/brad/working/src/ceph/src/librados/AioCompletionImpl.h: 220 in librados::C_AioCompleteAndSafe::finish(int)()
214     
215         c->lock.Lock();
216         c->callback_complete = NULL;
217         c->callback_safe = NULL;
218         c->cond.Signal();
219         c->put_unlock();
>>>     CID 1403545:  Program hangs  (LOCK)
>>>     Returning without unlocking "this->c->lock._m".
220       }
221     };
222     
223     }
224     

** CID 1403546:  Program hangs  (LOCK)
/home/brad/working/src/ceph/src/test/librados_test_stub/TestRadosClient.cc: 54 in librados::finish_aio_completion(librados::AioCompletionImpl *, int)()


________________________________________________________________________________________________________
*** CID 1403546:  Program hangs  (LOCK)
/home/brad/working/src/ceph/src/test/librados_test_stub/TestRadosClient.cc: 54 in librados::finish_aio_completion(librados::AioCompletionImpl *, int)()
48     
49       c->lock.Lock();
50       c->callback_complete = NULL;
51       c->callback_safe = NULL;
52       c->cond.Signal();
53       c->put_unlock();
>>>     CID 1403546:  Program hangs  (LOCK)
>>>     Returning without unlocking "c->lock._m".
54     }
55     
56     class AioFunctionContext : public Context {
57     public:
58       AioFunctionContext(const TestRadosClient::AioFunction &callback,
59                          Finisher *finisher, AioCompletionImpl *c)

** CID 1403547:  Program hangs  (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1403547:  Program hangs  (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 653 in AsyncMessenger::mark_down(const entity_addr_t &)()
647     void AsyncMessenger::mark_down(const entity_addr_t& addr)
648     {
649       lock.Lock();
650       AsyncConnectionRef p = _lookup_conn(addr);
651       if (p) {
652         ldout(cct, 1) << __func__ << " " << addr << " -- " << p << dendl;
>>>     CID 1403547:  Program hangs  (ORDER_REVERSAL)
>>>     Calling "stop" acquires lock "AsyncConnection.lock" while holding lock "Mutex._m" (count: 2 / 5).
653         p->stop(true);
654       } else {
655         ldout(cct, 1) << __func__ << " " << addr << " -- connection dne" << dendl;
656       }
657       lock.Unlock();
658     }

** CID 1403548:  Program hangs  (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1403548:  Program hangs  (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/common/ceph_context.cc: 769 in CephContext::disable_perf_counter()()
763     
764     void CephContext::disable_perf_counter()
765     {
766       _perf_counters_collection->remove(_cct_perf);
767     
768       ceph_spin_lock(&_cct_perf_lock);
>>>     CID 1403548:  Program hangs  (ORDER_REVERSAL)
>>>     Calling "~PerfCounters" acquires lock "Mutex._m" while holding lock "ceph_spinlock_t.lock" (count: 3 / 23).
769       delete _cct_perf;
770       _cct_perf = NULL;
771       ceph_spin_unlock(&_cct_perf_lock);
772     }
773     
774     void CephContext::refresh_perf_values()

** CID 1403549:    (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1403549:    (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 622 in AsyncMessenger::shutdown_connections(bool)()
616       ldout(cct,1) << __func__ << " " << dendl;
617       lock.Lock();
618       for (set<AsyncConnectionRef>::iterator q = accepting_conns.begin();
619            q != accepting_conns.end(); ++q) {
620         AsyncConnectionRef p = *q;
621         ldout(cct, 5) << __func__ << " accepting_conn " << p.get() << dendl;
>>>     CID 1403549:    (ORDER_REVERSAL)
>>>     Calling "stop" acquires lock "AsyncConnection.lock" while holding lock "Mutex._m" (count: 2 / 5).
622         p->stop(queue_reset);
623       }
624       accepting_conns.clear();
625     
626       while (!conns.empty()) {
627         ceph::unordered_map<entity_addr_t, AsyncConnectionRef>::iterator it = conns.begin();
/home/brad/working/src/ceph/src/msg/async/AsyncMessenger.cc: 632 in AsyncMessenger::shutdown_connections(bool)()
626       while (!conns.empty()) {
627         ceph::unordered_map<entity_addr_t, AsyncConnectionRef>::iterator it = conns.begin();
628         AsyncConnectionRef p = it->second;
629         ldout(cct, 5) << __func__ << " mark down " << it->first << " " << p << dendl;
630         conns.erase(it);
631         p->get_perf_counter()->dec(l_msgr_active_connections);
>>>     CID 1403549:    (ORDER_REVERSAL)
>>>     Calling "stop" acquires lock "AsyncConnection.lock" while holding lock "Mutex._m" (count: 2 / 5).
632         p->stop(queue_reset);
633       }
634     
635       {
636         Mutex::Locker l(deleted_lock);
637         while (!deleted_conns.empty()) {

** CID 1403550:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/test/ObjectMap/test_object_map.cc: 218 in ObjectMapTester::rename(ghobject_t, ghobject_t)()


________________________________________________________________________________________________________
*** CID 1403550:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/test/ObjectMap/test_object_map.cc: 218 in ObjectMapTester::rename(ghobject_t, ghobject_t)()
212     
213       void rename(const string &objname, const string &target) {
214         rename(ghobject_t(hobject_t(sobject_t(objname, CEPH_NOSNAP))),
215     	  ghobject_t(hobject_t(sobject_t(target, CEPH_NOSNAP))));
216       }
217     
>>>     CID 1403550:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter hoid of type "ghobject_t" (size 144 bytes) by value.
218       void rename(ghobject_t hoid,
219     	     ghobject_t hoid2) {
220         db->rename(hoid, hoid2);
221       }
222     
223       void clear(const string &objname) {

** CID 1403551:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/test/ObjectMap/test_object_map.cc: 186 in ObjectMapTester::remove_keys(ghobject_t, const std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &)()


________________________________________________________________________________________________________
*** CID 1403551:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/test/ObjectMap/test_object_map.cc: 186 in ObjectMapTester::remove_keys(ghobject_t, const std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &)()
180     		  string key) {
181         set<string> to_remove;
182         to_remove.insert(key);
183         db->rm_keys(hoid, to_remove);
184       }
185     
>>>     CID 1403551:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter hoid of type "ghobject_t" (size 144 bytes) by value.
186       void remove_keys(ghobject_t hoid,
187                        const set<string> &to_remove) {
188         db->rm_keys(hoid, to_remove);
189       }
190     
191       void remove_xattr(const string &objname, const string &key) {

** CID 1403552:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/test/ObjectMap/test_object_map.cc: 232 in ObjectMapTester::legacy_clone(ghobject_t, ghobject_t)()


________________________________________________________________________________________________________
*** CID 1403552:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/test/ObjectMap/test_object_map.cc: 232 in ObjectMapTester::legacy_clone(ghobject_t, ghobject_t)()
226     
227       void legacy_clone(const string &objname, const string &target) {
228         legacy_clone(ghobject_t(hobject_t(sobject_t(objname, CEPH_NOSNAP))),
229     	  ghobject_t(hobject_t(sobject_t(target, CEPH_NOSNAP))));
230       }
231     
>>>     CID 1403552:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter hoid of type "ghobject_t" (size 144 bytes) by value.
232       void legacy_clone(ghobject_t hoid,
233     	     ghobject_t hoid2) {
234         db->legacy_clone(hoid, hoid2);
235       }
236     
237       void clear(ghobject_t hoid) {

** CID 1403553:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/test/ObjectMap/test_object_map.cc: 76 in ObjectMapTester::set_keys(ghobject_t, const std::map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>> &)()


________________________________________________________________________________________________________
*** CID 1403553:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/test/ObjectMap/test_object_map.cc: 76 in ObjectMapTester::set_keys(ghobject_t, const std::map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>> &)()
70         bufferlist bl;
71         bl.append(bp);
72         to_write.insert(make_pair(key, bl));
73         db->set_keys(hoid, to_write);
74       }
75     
>>>     CID 1403553:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter hoid of type "ghobject_t" (size 144 bytes) by value.
76       void set_keys(ghobject_t hoid, const map<string, string> &to_set) {
77         map<string, bufferlist> to_write;
78         for (auto &&i: to_set) {
79           bufferptr bp(i.second.data(), i.second.size());
80           bufferlist bl;
81           bl.append(bp);

** CID 1403554:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1276 in GarbageCollector_BasicTest_Test::TestBody()()
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1343 in GarbageCollector_BasicTest_Test::TestBody()()
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1344 in GarbageCollector_BasicTest_Test::TestBody()()
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1346 in GarbageCollector_BasicTest_Test::TestBody()()
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1392 in GarbageCollector_BasicTest_Test::TestBody()()
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1463 in GarbageCollector_BasicTest_Test::TestBody()()
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1464 in GarbageCollector_BasicTest_Test::TestBody()()
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1466 in GarbageCollector_BasicTest_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1403554:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1276 in GarbageCollector_BasicTest_Test::TestBody()()
1270         b2->get_ref(coll.get(), 200, 10);
1271         em.extent_map.insert(*new BlueStore::Extent(300, 300, 100, b4));
1272         b4->get_ref(coll.get(), 300, 100);
1273         em.extent_map.insert(*new BlueStore::Extent(4096, 0, 10, b3));
1274         b3->get_ref(coll.get(), 0, 10);
1275     
>>>     CID 1403554:    (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "new BlueStore::OldExtent(300U, 300U, 10U, b1)" leaks it.
1276         old_extents.push_back(*new BlueStore::OldExtent(300, 300, 10, b1)); 
1277     
1278         saving = gc.estimate(300, 100, em, old_extents, 4096);
1279         ASSERT_EQ(saving, 1);
1280         auto& to_collect = gc.get_extents_to_collect();
1281         ASSERT_EQ(to_collect.size(), 1u);
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1343 in GarbageCollector_BasicTest_Test::TestBody()()
1337         em.extent_map.insert(
1338           *new BlueStore::Extent(0x30000, 0, 0xf000, b4)); // new extent
1339         b4->get_ref(coll.get(), 0, 0xf000);
1340         em.extent_map.insert(*new BlueStore::Extent(0x3f000, 0x3f000, 0x1000, b1));
1341         b1->get_ref(coll.get(), 0x3f000, 0x1000);
1342     
>>>     CID 1403554:    (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "new BlueStore::OldExtent(32768U, 32768U, 32768U, b1)" leaks it.
1343         old_extents.push_back(*new BlueStore::OldExtent(0x8000, 0x8000, 0x8000, b1)); 
1344         old_extents.push_back(
1345           *new BlueStore::OldExtent(0x10000, 0x10000, 0x20000, b1));
1346         old_extents.push_back(*new BlueStore::OldExtent(0x30000, 0x30000, 0xf000, b1)); 
1347     
1348         saving = gc.estimate(0x30000, 0xf000, em, old_extents, 0x10000);
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1344 in GarbageCollector_BasicTest_Test::TestBody()()
1338           *new BlueStore::Extent(0x30000, 0, 0xf000, b4)); // new extent
1339         b4->get_ref(coll.get(), 0, 0xf000);
1340         em.extent_map.insert(*new BlueStore::Extent(0x3f000, 0x3f000, 0x1000, b1));
1341         b1->get_ref(coll.get(), 0x3f000, 0x1000);
1342     
1343         old_extents.push_back(*new BlueStore::OldExtent(0x8000, 0x8000, 0x8000, b1)); 
>>>     CID 1403554:    (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "new BlueStore::OldExtent(65536U, 65536U, 131072U, b1)" leaks it.
1344         old_extents.push_back(
1345           *new BlueStore::OldExtent(0x10000, 0x10000, 0x20000, b1));
1346         old_extents.push_back(*new BlueStore::OldExtent(0x30000, 0x30000, 0xf000, b1)); 
1347     
1348         saving = gc.estimate(0x30000, 0xf000, em, old_extents, 0x10000);
1349         ASSERT_EQ(saving, 2);
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1346 in GarbageCollector_BasicTest_Test::TestBody()()
1340         em.extent_map.insert(*new BlueStore::Extent(0x3f000, 0x3f000, 0x1000, b1));
1341         b1->get_ref(coll.get(), 0x3f000, 0x1000);
1342     
1343         old_extents.push_back(*new BlueStore::OldExtent(0x8000, 0x8000, 0x8000, b1)); 
1344         old_extents.push_back(
1345           *new BlueStore::OldExtent(0x10000, 0x10000, 0x20000, b1));
>>>     CID 1403554:    (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "new BlueStore::OldExtent(196608U, 196608U, 61440U, b1)" leaks it.
1346         old_extents.push_back(*new BlueStore::OldExtent(0x30000, 0x30000, 0xf000, b1)); 
1347     
1348         saving = gc.estimate(0x30000, 0xf000, em, old_extents, 0x10000);
1349         ASSERT_EQ(saving, 2);
1350         auto& to_collect = gc.get_extents_to_collect();
1351         ASSERT_EQ(to_collect.size(), 2u);
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1392 in GarbageCollector_BasicTest_Test::TestBody()()
1386         em.extent_map.insert(*new BlueStore::Extent(0, 0, 0x3000, b1));
1387         b1->get_ref(coll.get(), 0, 0x3000);
1388         em.extent_map.insert(
1389           *new BlueStore::Extent(0x3000, 0, 0x4000, b2)); // new extent
1390         b2->get_ref(coll.get(), 0, 0x4000);
1391     
>>>     CID 1403554:    (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "new BlueStore::OldExtent(12288U, 12288U, 4096U, b1)" leaks it.
1392         old_extents.push_back(*new BlueStore::OldExtent(0x3000, 0x3000, 0x1000, b1)); 
1393     
1394         saving = gc.estimate(0x3000, 0x4000, em, old_extents, 0x1000);
1395         ASSERT_EQ(saving, 0);
1396         auto& to_collect = gc.get_extents_to_collect();
1397         ASSERT_EQ(to_collect.size(), 0u);
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1463 in GarbageCollector_BasicTest_Test::TestBody()()
1457         em.extent_map.insert(
1458           *new BlueStore::Extent(0x30000, 0, 0xf000, b4)); // new extent
1459         b4->get_ref(coll.get(), 0, 0xf000);
1460         em.extent_map.insert(*new BlueStore::Extent(0x3f000, 0x1f000, 0x1000, b1));
1461         b1->get_ref(coll.get(), 0x1f000, 0x1000);
1462     
>>>     CID 1403554:    (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "new BlueStore::OldExtent(32768U, 32768U, 32768U, b0)" leaks it.
1463         old_extents.push_back(*new BlueStore::OldExtent(0x8000, 0x8000, 0x8000, b0)); 
1464         old_extents.push_back(
1465           *new BlueStore::OldExtent(0x10000, 0x10000, 0x10000, b0)); 
1466         old_extents.push_back(
1467           *new BlueStore::OldExtent(0x20000, 0x00000, 0x1f000, b1)); 
1468     
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1464 in GarbageCollector_BasicTest_Test::TestBody()()
1458           *new BlueStore::Extent(0x30000, 0, 0xf000, b4)); // new extent
1459         b4->get_ref(coll.get(), 0, 0xf000);
1460         em.extent_map.insert(*new BlueStore::Extent(0x3f000, 0x1f000, 0x1000, b1));
1461         b1->get_ref(coll.get(), 0x1f000, 0x1000);
1462     
1463         old_extents.push_back(*new BlueStore::OldExtent(0x8000, 0x8000, 0x8000, b0)); 
>>>     CID 1403554:    (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "new BlueStore::OldExtent(65536U, 65536U, 65536U, b0)" leaks it.
1464         old_extents.push_back(
1465           *new BlueStore::OldExtent(0x10000, 0x10000, 0x10000, b0)); 
1466         old_extents.push_back(
1467           *new BlueStore::OldExtent(0x20000, 0x00000, 0x1f000, b1)); 
1468     
1469         saving = gc.estimate(0x30000, 0xf000, em, old_extents, 0x10000);
/home/brad/working/src/ceph/src/test/objectstore/test_bluestore_types.cc: 1466 in GarbageCollector_BasicTest_Test::TestBody()()
1460         em.extent_map.insert(*new BlueStore::Extent(0x3f000, 0x1f000, 0x1000, b1));
1461         b1->get_ref(coll.get(), 0x1f000, 0x1000);
1462     
1463         old_extents.push_back(*new BlueStore::OldExtent(0x8000, 0x8000, 0x8000, b0)); 
1464         old_extents.push_back(
1465           *new BlueStore::OldExtent(0x10000, 0x10000, 0x10000, b0)); 
>>>     CID 1403554:    (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "new BlueStore::OldExtent(131072U, 0U, 126976U, b1)" leaks it.
1466         old_extents.push_back(
1467           *new BlueStore::OldExtent(0x20000, 0x00000, 0x1f000, b1)); 
1468     
1469         saving = gc.estimate(0x30000, 0xf000, em, old_extents, 0x10000);
1470         ASSERT_EQ(saving, 2);
1471         auto& to_collect = gc.get_extents_to_collect();

** CID 1403555:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 2745 in BlueStore::ExtentMap::punch_hole(boost::intrusive_ptr<BlueStore::Collection> &, unsigned long, unsigned long, boost::intrusive::list<BlueStore::OldExtent, boost::intrusive::member_hook<BlueStore::OldExtent, boost::intrusive::list_member_hook<void, void, void>, (&BlueStore::OldExtent::old_extent_item)>, void, void, void> *)()
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 2755 in BlueStore::ExtentMap::punch_hole(boost::intrusive_ptr<BlueStore::Collection> &, unsigned long, unsigned long, boost::intrusive::list<BlueStore::OldExtent, boost::intrusive::member_hook<BlueStore::OldExtent, boost::intrusive::list_member_hook<void, void, void>, (&BlueStore::OldExtent::old_extent_item)>, void, void, void> *)()
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 2764 in BlueStore::ExtentMap::punch_hole(boost::intrusive_ptr<BlueStore::Collection> &, unsigned long, unsigned long, boost::intrusive::list<BlueStore::OldExtent, boost::intrusive::member_hook<BlueStore::OldExtent, boost::intrusive::list_member_hook<void, void, void>, (&BlueStore::OldExtent::old_extent_item)>, void, void, void> *)()
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 2774 in BlueStore::ExtentMap::punch_hole(boost::intrusive_ptr<BlueStore::Collection> &, unsigned long, unsigned long, boost::intrusive::list<BlueStore::OldExtent, boost::intrusive::member_hook<BlueStore::OldExtent, boost::intrusive::list_member_hook<void, void, void>, (&BlueStore::OldExtent::old_extent_item)>, void, void, void> *)()


________________________________________________________________________________________________________
*** CID 1403555:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 2745 in BlueStore::ExtentMap::punch_hole(boost::intrusive_ptr<BlueStore::Collection> &, unsigned long, unsigned long, boost::intrusive::list<BlueStore::OldExtent, boost::intrusive::member_hook<BlueStore::OldExtent, boost::intrusive::list_member_hook<void, void, void>, (&BlueStore::OldExtent::old_extent_item)>, void, void, void> *)()
2739     	old_extents->push_back(*oe);
2740     	add(end,
2741     	    p->blob_offset + front + length,
2742     	    p->length - front - length,
2743     	    p->blob);
2744     	p->length = front;
>>>     CID 1403555:    (RESOURCE_LEAK)
>>>     Variable "oe" going out of scope leaks the storage it points to.
2745     	break;
2746           } else {
2747     	// deref tail
2748     	assert(p->logical_end() > offset); // else seek_lextent bug
2749     	uint64_t keep = offset - p->logical_offset;
2750     	OldExtent* oe = OldExtent::create(c, offset, p->blob_offset + keep,
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 2755 in BlueStore::ExtentMap::punch_hole(boost::intrusive_ptr<BlueStore::Collection> &, unsigned long, unsigned long, boost::intrusive::list<BlueStore::OldExtent, boost::intrusive::member_hook<BlueStore::OldExtent, boost::intrusive::list_member_hook<void, void, void>, (&BlueStore::OldExtent::old_extent_item)>, void, void, void> *)()
2749     	uint64_t keep = offset - p->logical_offset;
2750     	OldExtent* oe = OldExtent::create(c, offset, p->blob_offset + keep,
2751     					  p->length - keep, p->blob);
2752     	old_extents->push_back(*oe);
2753     	p->length = keep;
2754     	++p;
>>>     CID 1403555:    (RESOURCE_LEAK)
>>>     Variable "oe" going out of scope leaks the storage it points to.
2755     	continue;
2756           }
2757         }
2758         if (p->logical_offset + p->length <= end) {
2759           // deref whole lextent
2760           OldExtent* oe = OldExtent::create(c, p->logical_offset, p->blob_offset,
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 2764 in BlueStore::ExtentMap::punch_hole(boost::intrusive_ptr<BlueStore::Collection> &, unsigned long, unsigned long, boost::intrusive::list<BlueStore::OldExtent, boost::intrusive::member_hook<BlueStore::OldExtent, boost::intrusive::list_member_hook<void, void, void>, (&BlueStore::OldExtent::old_extent_item)>, void, void, void> *)()
2758         if (p->logical_offset + p->length <= end) {
2759           // deref whole lextent
2760           OldExtent* oe = OldExtent::create(c, p->logical_offset, p->blob_offset,
2761     				        p->length, p->blob);
2762           old_extents->push_back(*oe);
2763           rm(p++);
>>>     CID 1403555:    (RESOURCE_LEAK)
>>>     Variable "oe" going out of scope leaks the storage it points to.
2764           continue;
2765         }
2766         // deref head
2767         uint64_t keep = p->logical_end() - end;
2768         OldExtent* oe = OldExtent::create(c, p->logical_offset, p->blob_offset,
2769     				      p->length - keep, p->blob);
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 2774 in BlueStore::ExtentMap::punch_hole(boost::intrusive_ptr<BlueStore::Collection> &, unsigned long, unsigned long, boost::intrusive::list<BlueStore::OldExtent, boost::intrusive::member_hook<BlueStore::OldExtent, boost::intrusive::list_member_hook<void, void, void>, (&BlueStore::OldExtent::old_extent_item)>, void, void, void> *)()
2768         OldExtent* oe = OldExtent::create(c, p->logical_offset, p->blob_offset,
2769     				      p->length - keep, p->blob);
2770         old_extents->push_back(*oe);
2771     
2772         add(end, p->blob_offset + p->length - keep, keep, p->blob);
2773         rm(p);
>>>     CID 1403555:    (RESOURCE_LEAK)
>>>     Variable "oe" going out of scope leaks the storage it points to.
2774         break;
2775       }
2776     }
2777     
2778     BlueStore::Extent *BlueStore::ExtentMap::set_lextent(
2779       CollectionRef &c,

** CID 1403556:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/common/test_mutex.cc: 66 in Mutex_DeleteLocked_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1403556:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/common/test_mutex.cc: 66 in Mutex_DeleteLocked_Test::TestBody()()
60     }
61     
62     TEST(Mutex, DeleteLocked) {
63       Mutex* m = new Mutex("Recursive3",false);
64       m->Lock();
65       EXPECT_DEATH(delete m,".*");
>>>     CID 1403556:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "m" going out of scope leaks the storage it points to.

** CID 1403557:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/common/test_mutex.cc: 38 in Mutex_NormalAsserts_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1403557:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/common/test_mutex.cc: 38 in Mutex_NormalAsserts_Test::TestBody()()
32     }
33     
34     TEST(Mutex, NormalAsserts) {
35       Mutex* m = new Mutex("Normal",false);
36       m->Lock();
37       EXPECT_THROW(m->Lock(), int);
>>>     CID 1403557:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "m" going out of scope leaks the storage it points to.
38     }
39     
40     TEST(Mutex, RecursiveWithLockdep) {
41       do_init();
42       g_lockdep = 1;
43       Mutex* m = new Mutex("Recursive1",true);

** CID 1403558:  Null pointer dereferences  (REVERSE_INULL)
/home/brad/working/src/ceph/src/osd/OSDMap.cc: 1865 in OSDMap::pg_to_raw_osds(pg_t, std::vector<int, std::allocator<int>> *, int *) const()


________________________________________________________________________________________________________
*** CID 1403558:  Null pointer dereferences  (REVERSE_INULL)
/home/brad/working/src/ceph/src/osd/OSDMap.cc: 1865 in OSDMap::pg_to_raw_osds(pg_t, std::vector<int, std::allocator<int>> *, int *) const()
1859       *primary = -1;
1860       raw->clear();
1861       const pg_pool_t *pool = get_pg_pool(pg.pool());
1862       if (!pool)
1863         return 0;
1864       int r = _pg_to_raw_osds(*pool, pg, raw, NULL);
>>>     CID 1403558:  Null pointer dereferences  (REVERSE_INULL)
>>>     Null-checking "primary" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
1865       if (primary)
1866         *primary = _pick_primary(*raw);
1867       return r;
1868     }
1869     
1870     void OSDMap::pg_to_raw_up(pg_t pg, vector<int> *up, int *primary) const

** CID 1403559:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_osdomap_tool.cc: 28 in main()


________________________________________________________________________________________________________
*** CID 1403559:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_osdomap_tool.cc: 28 in main()
22     #include "os/filestore/DBObjectMap.h"
23     #include "kv/KeyValueDB.h"
24     
25     namespace po = boost::program_options;
26     using namespace std;
27     
>>>     CID 1403559:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
28     int main(int argc, char **argv) {
29       po::options_description desc("Allowed options");
30       string store_path, cmd, out_path, oid;
31       bool debug = false;
32       desc.add_options()
33         ("help", "produce help message")


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GYMtHP0iqDhJxrU2AKca4ybxq6StALc9b-2BGuPG3Yqi-2F9J4j3HDwRf2mwV2kze1N8-2FpItURbqegcqxi0Nphv3-2Fq314GLlAGn8fRnUOfhOtg0emKzA7b7PMg2Td2FqEZE2Cn2L4hfEGWlqk0ghg1o6yofSlbduOfL8lEuGtf8o0E-2Fo9YZYYSEjXLsCZHZLRK2us-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GYMtHP0iqDhJxrU2AKca4ybxq6StALc9b-2BGuPG3Yqi-2Fz1eOK5Q-2Btu6cS8EvVZdb5DrJUxs807FnfVQn5feiqNRW1qTsWr1MdcgOXPNj7wl2F6D3hDB2RwV-2BFZy-2BcvhEJ2lYyy9w6um6G8VqFpWyFEjW3kVyVOaqFVHH9r6mYM2a1BUEec-2BZoBPDjN0yFEcwFE-3D

