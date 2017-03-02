From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Wed, 01 Mar 2017 23:44:34 -0800
Message-ID: <58b7cd62dde19_5e3a12f732070268@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:53462 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750771AbdCBHyK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Mar 2017 02:54:10 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0001p1sjc2.sendgrid.net (SG) with ESMTP id RU7JrhRVR2ygA-8-W-yJkw
        for <ceph-devel@vger.kernel.org>; Thu, 02 Mar 2017 07:44:34.946 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

23 new defect(s) introduced to ceph found with Coverity Scan.
3 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 23 defect(s)


** CID 717332:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/filestore/FileJournal.h: 260 in FileJournal::aio_info::aio_info(ceph::buffer::list &, unsigned long, unsigned long)()


________________________________________________________________________________________________________
*** CID 717332:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/filestore/FileJournal.h: 260 in FileJournal::aio_info::aio_info(ceph::buffer::list &, unsigned long, unsigned long)()
254         uint64_t off, len;    ///< these are for debug only
255         uint64_t seq;         ///< seq number to complete on aio completion, if non-zero
256     
257         aio_info(bufferlist& b, uint64_t o, uint64_t s)
258           : iov(NULL), done(false), off(o), len(b.length()), seq(s) {
259           bl.claim(b);
>>>     CID 717332:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member field "iocb.aio_fildes" is not initialized in this constructor nor in any functions that it calls.
260         }
261         ~aio_info() {
262           delete[] iov;
263         }
264       };
265       Mutex aio_lock;

** CID 1251086:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.2.1/functional: 2111 in std::function<void (boost::scoped_ptr<ObjectStore> &, unsigned long, unsigned long, unsigned long, unsigned long)>::function(const std::function<void (boost::scoped_ptr<ObjectStore> &, unsigned long, unsigned long, unsigned long, unsigned long)>&)()


________________________________________________________________________________________________________
*** CID 1251086:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.2.1/functional: 2111 in std::function<void (boost::scoped_ptr<ObjectStore> &, unsigned long, unsigned long, unsigned long, unsigned long)>::function(const std::function<void (boost::scoped_ptr<ObjectStore> &, unsigned long, unsigned long, unsigned long, unsigned long)>&)()
2105           if (static_cast<bool>(__x))
2106     	{
2107     	  __x._M_manager(_M_functor, __x._M_functor, __clone_functor);
2108     	  _M_invoker = __x._M_invoker;
2109     	  _M_manager = __x._M_manager;
2110     	}
>>>     CID 1251086:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "_M_invoker" is not initialized in this constructor nor in any functions that it calls.
2111         }
2112     
2113       template<typename _Res, typename... _ArgTypes>
2114         template<typename _Functor, typename, typename>
2115           function<_Res(_ArgTypes...)>::
2116           function(_Functor __f)

** CID 1369577:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.2.1/functional: 2127 in std::function<void (boost::scoped_ptr<ObjectStore> &, unsigned long, unsigned long, unsigned long, unsigned long)>::function<void (*)(boost::scoped_ptr<ObjectStore> &, int, unsigned long, unsigned long, unsigned long), void, void>(T1)()


________________________________________________________________________________________________________
*** CID 1369577:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.2.1/functional: 2127 in std::function<void (boost::scoped_ptr<ObjectStore> &, unsigned long, unsigned long, unsigned long, unsigned long)>::function<void (*)(boost::scoped_ptr<ObjectStore> &, int, unsigned long, unsigned long, unsigned long), void, void>(T1)()
2121     	if (_My_handler::_M_not_empty_function(__f))
2122     	  {
2123     	    _My_handler::_M_init_functor(_M_functor, std::move(__f));
2124     	    _M_invoker = &_My_handler::_M_invoke;
2125     	    _M_manager = &_My_handler::_M_manager;
2126     	  }
>>>     CID 1369577:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "_M_invoker" is not initialized in this constructor nor in any functions that it calls.
2127           }
2128     
2129       template<typename _Res, typename... _ArgTypes>
2130         _Res
2131         function<_Res(_ArgTypes...)>::
2132         operator()(_ArgTypes... __args) const

** CID 1401633:  Concurrent data access violations  (ATOMICITY)
/home/brad/working/src/ceph/src/osd/OSD.cc: 9237 in OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d *)()


________________________________________________________________________________________________________
*** CID 1401633:  Concurrent data access violations  (ATOMICITY)
/home/brad/working/src/ceph/src/osd/OSD.cc: 9237 in OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d *)()
9231           pg->unlock();
9232         }
9233         sdata->sdata_op_ordering_lock.Unlock();
9234         return;
9235       }
9236       if (requeue_seq != slot.requeue_seq) {
>>>     CID 1401633:  Concurrent data access violations  (ATOMICITY)
>>>     Using an unreliable value of "requeue_seq" inside the second locked section. If the data that "requeue_seq" depends on was changed by another thread, this use might be incorrect.
9237         dout(20) << __func__ << " " << item.first
9238     	     << " requeue_seq " << slot.requeue_seq << " > our "
9239     	     << requeue_seq << ", we raced with wake_pg_waiters"
9240     	     << dendl;
9241         if (pg) {
9242           pg->unlock();

** CID 1401634:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osd/OSD.h: 481 in OSDService::maybe_inject_dispatch_delay()()


________________________________________________________________________________________________________
*** CID 1401634:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osd/OSD.h: 481 in OSDService::maybe_inject_dispatch_delay()()
475     
476       void enqueue_back(spg_t pgid, PGQueueable qi);
477       void enqueue_front(spg_t pgid, PGQueueable qi);
478     
479       void maybe_inject_dispatch_delay() {
480         if (g_conf->osd_debug_inject_dispatch_delay_probability > 0) {
>>>     CID 1401634:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
481           if (rand() % 10000 <
482     	  g_conf->osd_debug_inject_dispatch_delay_probability * 10000) {
483     	utime_t t;
484     	t.set_from_double(g_conf->osd_debug_inject_dispatch_delay_duration);
485     	t.sleep();
486           }

** CID 1401635:  Incorrect expression  (COPY_PASTE_ERROR)
/home/brad/working/src/ceph/src/test/objectstore/store_test.cc: 5915 in StoreTestSpecificAUSize_garbageCollection_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1401635:  Incorrect expression  (COPY_PASTE_ERROR)
/home/brad/working/src/ceph/src/test/objectstore/store_test.cc: 5915 in StoreTestSpecificAUSize_garbageCollection_Test::TestBody()()
5909           ASSERT_EQ(statfs.compressed_allocated, 0x20000);
5910           const PerfCounters* counters = store->get_perf_counters();
5911           ASSERT_EQ(counters->get(l_bluestore_gc_merged), 0x20000u);
5912         }
5913         {
5914           struct store_statfs_t statfs;
>>>     CID 1401635:  Incorrect expression  (COPY_PASTE_ERROR)
>>>     "overlap_offset" in "(uint64_t)overlap_offset - 1UL" looks like a copy-paste error.
5915           WRITE_AT(write_offset + 1, overlap_offset-1);
5916           int r = store->statfs(&statfs);
5917           ASSERT_EQ(r, 0);
5918           ASSERT_EQ(statfs.compressed_allocated, 0x20000);
5919           const PerfCounters* counters = store->get_perf_counters();
5920           ASSERT_EQ(counters->get(l_bluestore_gc_merged), 0x20000u);

** CID 1401636:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 1307 in generate_random_iomap(void *, int, int, int, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>> &)()
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 1308 in generate_random_iomap(void *, int, int, int, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>> &)()


________________________________________________________________________________________________________
*** CID 1401636:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 1307 in generate_random_iomap(void *, int, int, int, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>> &)()
1301       ASSERT_EQ(0, rbd_get_stripe_count(image, &stripe_count));
1302     
1303       while (max_count-- > 0) {
1304         // generate random image offset based on base random object
1305         // number and object offset and then map that back to an
1306         // object number based on stripe unit and count.
>>>     CID 1401636:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
1307         uint64_t ono = rand() % num_objects;
1308         uint64_t offset = rand() % (object_size - TEST_IO_SIZE);
1309         uint64_t imageoff = (ono * object_size) + offset;
1310     
1311         file_layout_t layout;
1312         layout.object_size = object_size;
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 1308 in generate_random_iomap(void *, int, int, int, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>> &)()
1302     
1303       while (max_count-- > 0) {
1304         // generate random image offset based on base random object
1305         // number and object offset and then map that back to an
1306         // object number based on stripe unit and count.
1307         uint64_t ono = rand() % num_objects;
>>>     CID 1401636:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
1308         uint64_t offset = rand() % (object_size - TEST_IO_SIZE);
1309         uint64_t imageoff = (ono * object_size) + offset;
1310     
1311         file_layout_t layout;
1312         layout.object_size = object_size;
1313         layout.stripe_unit = stripe_unit;

** CID 1401637:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI30bluestore_compression_header_tE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1401637:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI30bluestore_compression_header_tE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1401637:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1401638:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI17bluestore_onode_tE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1401638:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI17bluestore_onode_tE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1401638:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1401639:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI26bluestore_extent_ref_map_tE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1401639:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI26bluestore_extent_ref_map_tE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1401639:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1401640:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI27bluestore_wal_transaction_tE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1401640:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI27bluestore_wal_transaction_tE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1401640:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1401641:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI18bluestore_wal_op_tE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1401641:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI18bluestore_wal_op_tE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1401641:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1401642:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI17bluestore_cnode_tE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1401642:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI17bluestore_cnode_tE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1401642:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1401643:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI19bluestore_pextent_tE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1401643:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI19bluestore_pextent_tE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1401643:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1401644:  Integer handling issues  (NO_EFFECT)
/include/tracing/librbd.h: 970 in __event_prepare_filter_stack__librbd___aio_writesame_enter()


________________________________________________________________________________________________________
*** CID 1401644:  Integer handling issues  (NO_EFFECT)
/include/tracing/librbd.h: 970 in __event_prepare_filter_stack__librbd___aio_writesame_enter()
964     
965     TRACEPOINT_EVENT(librbd, aio_complete_exit,
966         TP_ARGS(),
967         TP_FIELDS()
968     )
969     
>>>     CID 1401644:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "18446744073709551615UL < 0UL".
970     TRACEPOINT_EVENT(librbd, aio_writesame_enter,
971         TP_ARGS(
972             void*, imagectx,
973             const char*, name,
974             const char*, snap_name,
975             char, read_only,

** CID 1401645:  Null pointer dereferences  (NULL_RETURNS)
/home/brad/working/src/ceph/src/mds/MDCache.cc: 2503 in MDCache::create_subtree_map()()


________________________________________________________________________________________________________
*** CID 1401645:  Null pointer dereferences  (NULL_RETURNS)
/home/brad/working/src/ceph/src/mds/MDCache.cc: 2503 in MDCache::create_subtree_map()()
2497       ESubtreeMap *le = new ESubtreeMap();
2498       mds->mdlog->_start_entry(le);
2499       
2500       map<dirfrag_t, CDir*> dirs_to_add;
2501     
2502       if (myin) {
>>>     CID 1401645:  Null pointer dereferences  (NULL_RETURNS)
>>>     Assigning: "mydir" = null return value from "get_dirfrag".
2503         CDir* mydir = myin->get_dirfrag(frag_t());
2504         dirs_to_add[mydir->dirfrag()] = mydir;
2505       }
2506     
2507       // include all auth subtrees, and their bounds.
2508       // and a spanning tree to tie it to the root.

** CID 1401646:  Integer handling issues  (NO_EFFECT)
/include/tracing/librbd.h: 187 in __event_prepare_filter_stack__librbd___writesame_enter()


________________________________________________________________________________________________________
*** CID 1401646:  Integer handling issues  (NO_EFFECT)
/include/tracing/librbd.h: 187 in __event_prepare_filter_stack__librbd___writesame_enter()
181             int, retval),
182         TP_FIELDS(
183             ctf_integer(int, retval, retval)
184         )
185     )
186     
>>>     CID 1401646:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "18446744073709551615UL < 0UL".
187     TRACEPOINT_EVENT(librbd, writesame_enter,
188         TP_ARGS(
189             void*, imagectx,
190             const char*, name,
191             const char*, snap_name,
192             char, read_only,

** CID 1401647:    (PASS_BY_VALUE)
/usr/include/c++/6.2.1/bits/list.tcc: 484 in std::__cxx11::list<obj_watch_t, std::allocator<obj_watch_t>>::remove_if<librbd::image::RemoveRequest<librbd::MockImageCtx>::filter_out_mirror_watchers()::[lambda(obj_watch_t &) (instance 1)]>(T1)()
/usr/include/c++/6.2.1/bits/list.tcc: 484 in std::__cxx11::list<obj_watch_t, std::allocator<obj_watch_t>>::remove_if<librbd::image::RemoveRequest<librbd::ImageCtx>::filter_out_mirror_watchers()::[lambda(obj_watch_t &) (instance 1)]>(T1)()


________________________________________________________________________________________________________
*** CID 1401647:    (PASS_BY_VALUE)
/usr/include/c++/6.2.1/bits/list.tcc: 484 in std::__cxx11::list<obj_watch_t, std::allocator<obj_watch_t>>::remove_if<librbd::image::RemoveRequest<librbd::MockImageCtx>::filter_out_mirror_watchers()::[lambda(obj_watch_t &) (instance 1)]>(T1)()
478         }
479     
480       template<typename _Tp, typename _Alloc>
481         template <typename _Predicate>
482           void
483           list<_Tp, _Alloc>::
>>>     CID 1401647:    (PASS_BY_VALUE)
>>>     Passing parameter __pred of type "librbd::image::RemoveRequest<librbd::MockImageCtx>::filter_out_mirror_watchers()::[lambda(obj_watch_t &) (instance 1)]" (size 280 bytes) by value.
484           remove_if(_Predicate __pred)
485           {
486             iterator __first = begin();
487             iterator __last = end();
488             while (__first != __last)
489     	  {
/usr/include/c++/6.2.1/bits/list.tcc: 484 in std::__cxx11::list<obj_watch_t, std::allocator<obj_watch_t>>::remove_if<librbd::image::RemoveRequest<librbd::ImageCtx>::filter_out_mirror_watchers()::[lambda(obj_watch_t &) (instance 1)]>(T1)()
478         }
479     
480       template<typename _Tp, typename _Alloc>
481         template <typename _Predicate>
482           void
483           list<_Tp, _Alloc>::
>>>     CID 1401647:    (PASS_BY_VALUE)
>>>     Passing parameter __pred of type "librbd::image::RemoveRequest<librbd::ImageCtx>::filter_out_mirror_watchers()::[lambda(obj_watch_t &) (instance 1)]" (size 280 bytes) by value.
484           remove_if(_Predicate __pred)
485           {
486             iterator __first = begin();
487             iterator __last = end();
488             while (__first != __last)
489     	  {

** CID 1401648:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/tools/rbd_mirror/InstanceWatcher.cc: 92 in rbd::mirror::InstanceWatcher<librbd::ImageCtx>::remove_instance(librados::IoCtx &, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, Context *)()
/home/brad/working/src/ceph/src/tools/rbd_mirror/InstanceWatcher.cc: 92 in rbd::mirror::InstanceWatcher<librbd::<unnamed>::MockTestImageCtx>::remove_instance(librados::IoCtx &, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, Context *)()


________________________________________________________________________________________________________
*** CID 1401648:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/tools/rbd_mirror/InstanceWatcher.cc: 92 in rbd::mirror::InstanceWatcher<librbd::ImageCtx>::remove_instance(librados::IoCtx &, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, Context *)()
86                                              ContextWQ *work_queue,
87                                              const std::string &instance_id,
88                                              Context *on_finish) {
89       auto req = new RemoveInstanceRequest<I>(io_ctx, work_queue, instance_id,
90                                               on_finish);
91       req->send();
>>>     CID 1401648:    (RESOURCE_LEAK)
>>>     Variable "req" going out of scope leaks the storage it points to.
92     }
93     
94     template <typename I>
95     InstanceWatcher<I>::InstanceWatcher(librados::IoCtx &io_ctx,
96                                         ContextWQ *work_queue,
97                                         const boost::optional<std::string> &id)
/home/brad/working/src/ceph/src/tools/rbd_mirror/InstanceWatcher.cc: 92 in rbd::mirror::InstanceWatcher<librbd::<unnamed>::MockTestImageCtx>::remove_instance(librados::IoCtx &, ContextWQ *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, Context *)()
86                                              ContextWQ *work_queue,
87                                              const std::string &instance_id,
88                                              Context *on_finish) {
89       auto req = new RemoveInstanceRequest<I>(io_ctx, work_queue, instance_id,
90                                               on_finish);
91       req->send();
>>>     CID 1401648:    (RESOURCE_LEAK)
>>>     Variable "req" going out of scope leaks the storage it points to.
92     }
93     
94     template <typename I>
95     InstanceWatcher<I>::InstanceWatcher(librados::IoCtx &io_ctx,
96                                         ContextWQ *work_queue,
97                                         const boost::optional<std::string> &id)

** CID 1401649:  Null pointer dereferences  (REVERSE_INULL)
/home/brad/working/src/ceph/src/osd/OSD.cc: 6061 in OSD::maybe_share_map(Session *, boost::intrusive_ptr<OpRequest>, std::shared_ptr<const OSDMap>)()


________________________________________________________________________________________________________
*** CID 1401649:  Null pointer dereferences  (REVERSE_INULL)
/home/brad/working/src/ceph/src/osd/OSD.cc: 6061 in OSD::maybe_share_map(Session *, boost::intrusive_ptr<OpRequest>, std::shared_ptr<const OSDMap>)()
6055       const Message *m = op->get_req();
6056       service.share_map(
6057         m->get_source(),
6058         m->get_connection().get(),
6059         op->sent_epoch,
6060         osdmap,
>>>     CID 1401649:  Null pointer dereferences  (REVERSE_INULL)
>>>     Null-checking "session" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
6061         session ? &last_sent_epoch : NULL);
6062     
6063       session->sent_epoch_lock.lock();
6064       if (session->last_sent_epoch < last_sent_epoch) {
6065         session->last_sent_epoch = last_sent_epoch;
6066       }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Eo0ddxQLgim1t9h3RZhGlTH-2BvBf3jux2qSsSeJcAE-2FT1-2FrKYdyzl7Dvnz3caEpQ4qrEJDkuGcNtcFN7wsACxMoY264sCzoQRXTq29tL1VL4o6pqhnDs9CwbVoH8wC6jb-2BRFs-2F8H6SKtQhFuYUqEAq5UVf4MYC7TyGLOH413WfbWA4jt9vqmVYoJ9EyPJMlaFU-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Eo0ddxQLgim1t9h3RZhGlTH-2BvBf3jux2qSsSeJcAE-2FT3L3Enill0f-2F8s7t6KnAn6mcAIv1GHFiHZsl8cDdSTZSfnNlxpTtxRfQ-2BEUwpAGaxhmHSvI0kmth3rj9nvuZ6yCMxyFu674aqXNqVmOHPgPCa6MjRxMXcFGv-2Fp9se3qn3oz8VOPdt-2BDrJuGhaEaiNA4-3D

