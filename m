From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 10 Aug 2017 03:50:41 +0000 (UTC)
Message-ID: <598bd81140173_8f8449314459b7@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:30297 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752283AbdHJDwV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Aug 2017 23:52:21 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id 8UKjMYNRQT6mLQS937qg_w
        for <ceph-devel@vger.kernel.org>; Thu, 10 Aug 2017 03:50:41.328 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

37 new defect(s) introduced to ceph found with Coverity Scan.
195 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 37 defect(s)


** CID 1020033:  Memory - corruptions  (ARRAY_VS_SINGLETON)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 5303 in dlindependent_calloc()


________________________________________________________________________________________________________
*** CID 1020033:  Memory - corruptions  (ARRAY_VS_SINGLETON)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 5303 in dlindependent_calloc()
5297       return dlmemalign(pagesz, (bytes + pagesz - SIZE_T_ONE) & ~(pagesz - SIZE_T_ONE));
5298     }
5299     
5300     void** dlindependent_calloc(size_t n_elements, size_t elem_size,
5301                                 void* chunks[]) {
5302       size_t sz = elem_size; /* serves as 1-element array */
>>>     CID 1020033:  Memory - corruptions  (ARRAY_VS_SINGLETON)
>>>     Taking address with "&sz" yields a singleton pointer.
5303       return ialloc(gm, n_elements, &sz, 3, chunks);
5304     }
5305     
5306     void** dlindependent_comalloc(size_t n_elements, size_t sizes[],
5307                                   void* chunks[]) {
5308       return ialloc(gm, n_elements, sizes, 0, chunks);

** CID 1108113:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 3103 in init_mparams()


________________________________________________________________________________________________________
*** CID 1108113:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 3103 in init_mparams()
3097     static int init_mparams(void) {
3098     #ifdef NEED_GLOBAL_LOCK_INIT
3099       if (malloc_global_mutex_status <= 0)
3100         init_malloc_global_mutex();
3101     #endif
3102     
>>>     CID 1108113:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "spin_acquire_lock" without checking return value (as is done elsewhere 25 out of 29 times).
3103       ACQUIRE_MALLOC_GLOBAL_LOCK();
3104       if (mparams.magic == 0) {
3105         size_t magic;
3106         size_t psize;
3107         size_t gsize;
3108     

** CID 1129320:  Memory - corruptions  (ARRAY_VS_SINGLETON)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 5826 in mspace_independent_calloc()


________________________________________________________________________________________________________
*** CID 1129320:  Memory - corruptions  (ARRAY_VS_SINGLETON)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 5826 in mspace_independent_calloc()
5820       size_t sz = elem_size; /* serves as 1-element array */
5821       mstate ms = (mstate)msp;
5822       if (!ok_magic(ms)) {
5823         USAGE_ERROR_ACTION(ms,ms);
5824         return 0;
5825       }
>>>     CID 1129320:  Memory - corruptions  (ARRAY_VS_SINGLETON)
>>>     Taking address with "&sz" yields a singleton pointer.
5826       return ialloc(ms, n_elements, &sz, 3, chunks);
5827     }
5828     
5829     void** mspace_independent_comalloc(mspace msp, size_t n_elements,
5830                                        size_t sizes[], void* chunks[]) {
5831       mstate ms = (mstate)msp;

** CID 1202734:  Memory - corruptions  (BAD_FREE)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 4312 in sys_trim()


________________________________________________________________________________________________________
*** CID 1202734:  Memory - corruptions  (BAD_FREE)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 4312 in sys_trim()
4306                   sp->size >= extra &&
4307                   !has_segment_link(m, sp)) { /* can't shrink if pinned */
4308                 size_t newsize = sp->size - extra;
4309                 (void)newsize; /* placate people compiling -Wunused-variable */
4310                 /* Prefer mremap, fall back to munmap */
4311                 if ((CALL_MREMAP(sp->base, sp->size, newsize, 0) != MFAIL) ||
>>>     CID 1202734:  Memory - corruptions  (BAD_FREE)
>>>     "munmap" frees address offset from "sp->base".
4312                     (CALL_MUNMAP(sp->base + newsize, extra) == 0)) {
4313                   released = extra;
4314                 }
4315               }
4316             }
4317             else if (HAVE_MORECORE) {

** CID 1316245:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/cephfs/cephfs-data-scan.cc: 11 in main()


________________________________________________________________________________________________________
*** CID 1316245:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/cephfs/cephfs-data-scan.cc: 11 in main()
5     #include "common/errno.h"
6     #include "global/global_init.h"
7     
8     #include "DataScan.h"
9     
10     
>>>     CID 1316245:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
11     int main(int argc, const char **argv)
12     {
13       vector<const char*> args;
14       argv_to_vec(argc, argv, args);
15       env_to_vec(args);
16     

** CID 1316246:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3555 in main()


________________________________________________________________________________________________________
*** CID 1316246:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3555 in main()
3549     
3550     out:
3551       delete formatter;
3552       return (ret < 0) ? 1 : 0;
3553     }
3554     
>>>     CID 1316246:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
3555     int main(int argc, const char **argv)
3556     {
3557       vector<const char*> args;
3558       argv_to_vec(argc, argv, args);
3559       env_to_vec(args);
3560     

** CID 1316247:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/scratchtoolpp.cc: 56 in main()


________________________________________________________________________________________________________
*** CID 1316247:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/scratchtoolpp.cc: 56 in main()
50       while ((c = getchar()) != EOF) {
51         if (c == '\n')
52           break;
53       }
54     }
55     
>>>     CID 1316247:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
56     int main(int argc, const char **argv) 
57     {
58       Rados rados;
59       if (rados.init(NULL) < 0) {
60          cerr << "couldn't initialize rados!" << std::endl;
61          exit(1);

** CID 1316248:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/kv_store_bench.cc: 551 in main()


________________________________________________________________________________________________________
*** CID 1316248:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/kv_store_bench.cc: 551 in main()
545       } else {
546         err = test_teuthology_sync(&KvStoreBench::rand_distr, probs);
547       }
548       return err;
549     }
550     
>>>     CID 1316248:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
551     int main(int argc, const char** argv) {
552       KvStoreBench kvsb;
553       int err = kvsb.setup(argc, argv);
554       if (err == 0) cout << "setup successful" << std::endl;
555       else{
556         cout << "error " << err << std::endl;

** CID 1354457:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/watch_notify.cc: 728 in LibRadosWatchNotifyPP_WatchNotify2Timeout_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/watch_notify.cc: 727 in LibRadosWatchNotifyPP_WatchNotify2Timeout_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1354457:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/watch_notify.cc: 728 in LibRadosWatchNotifyPP_WatchNotify2Timeout_Test::TestBody()()
722       ioctx.unwatch2(handle);
723     
724       std::cout << " flushing" << std::endl;
725       librados::AioCompletion *comp = cluster.aio_create_completion();
726       cluster.aio_watch_flush(comp);
727       ASSERT_EQ(0, comp->wait_for_complete());
>>>     CID 1354457:    (RESOURCE_LEAK)
>>>     Variable "comp" going out of scope leaks the storage it points to.
728       ASSERT_EQ(0, comp->get_return_value());
729       std::cout << " flushed" << std::endl;
730       comp->release();
731     }
732     
733     TEST_P(LibRadosWatchNotifyPP, WatchNotify3) {
/home/brad/working/src/ceph/src/test/librados/watch_notify.cc: 727 in LibRadosWatchNotifyPP_WatchNotify2Timeout_Test::TestBody()()
721       ASSERT_GT(ioctx.watch_check(handle), 0);
722       ioctx.unwatch2(handle);
723     
724       std::cout << " flushing" << std::endl;
725       librados::AioCompletion *comp = cluster.aio_create_completion();
726       cluster.aio_watch_flush(comp);
>>>     CID 1354457:    (RESOURCE_LEAK)
>>>     Variable "comp" going out of scope leaks the storage it points to.
727       ASSERT_EQ(0, comp->wait_for_complete());
728       ASSERT_EQ(0, comp->get_return_value());
729       std::cout << " flushed" << std::endl;
730       comp->release();
731     }
732     

** CID 1354459:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/watch_notify.cc: 689 in LibRadosWatchNotify_WatchNotify2Timeout_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1354459:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/watch_notify.cc: 689 in LibRadosWatchNotify_WatchNotify2Timeout_Test::TestBody()()
683       ASSERT_EQ(1u, notify_cookies.size());
684       ASSERT_GT(rados_watch_check(ioctx, handle), 0);
685     
686       rados_unwatch2(ioctx, handle);
687     
688       rados_completion_t comp;
>>>     CID 1354459:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "comp" going out of scope leaks the storage it points to.
689       ASSERT_EQ(0, rados_aio_create_completion(NULL, NULL, NULL, &comp));
690       rados_aio_watch_flush(cluster, comp);
691       ASSERT_EQ(0, rados_aio_wait_for_complete(comp));
692       ASSERT_EQ(0, rados_aio_get_return_value(comp));
693       rados_aio_release(comp);
694       rados_buffer_free(reply_buf);

** CID 1395346:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 8226 in BlueStore::_kv_stop()()


________________________________________________________________________________________________________
*** CID 1395346:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 8226 in BlueStore::_kv_stop()()
8220       dout(10) << __func__ << dendl;
8221       {
8222         std::unique_lock<std::mutex> l(kv_lock);
8223         while (!kv_sync_started) {
8224           kv_cond.wait(l);
8225         }
>>>     CID 1395346:  Concurrent data access violations  (MISSING_LOCK)
>>>     Accessing "this->kv_stop" without holding lock "BlueStore.kv_lock". Elsewhere, "BlueStore.kv_stop" is accessed with "BlueStore.kv_lock" held 1 out of 2 times (1 of these accesses strongly imply that it is necessary).
8226         kv_stop = true;
8227         kv_cond.notify_all();
8228       }
8229       {
8230         std::unique_lock<std::mutex> l(kv_finalize_lock);
8231         while (!kv_finalize_started) {

** CID 1396032:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librbd/test_main.cc: 24 in main()


________________________________________________________________________________________________________
*** CID 1396032:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librbd/test_main.cc: 24 in main()
18     extern void register_test_object_map();
19     extern void register_test_operations();
20     extern void register_test_mirroring();
21     extern void register_test_mirroring_watcher();
22     #endif // TEST_LIBRBD_INTERNALS
23     
>>>     CID 1396032:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
24     int main(int argc, char **argv)
25     {
26       register_test_librbd();
27     #ifdef TEST_LIBRBD_INTERNALS
28       register_test_groups();
29       register_test_image_watcher();

** CID 1396041:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/rbd_mirror/test_main.cc: 20 in main()


________________________________________________________________________________________________________
*** CID 1396041:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/rbd_mirror/test_main.cc: 20 in main()
14     extern void register_test_instances();
15     extern void register_test_leader_watcher();
16     extern void register_test_pool_watcher();
17     extern void register_test_rbd_mirror();
18     extern void register_test_rbd_mirror_image_deleter();
19     
>>>     CID 1396041:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
20     int main(int argc, char **argv)
21     {
22       register_test_cluster_watcher();
23       register_test_image_sync();
24       register_test_instance_watcher();
25       register_test_instances();

** CID 1412767:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 4082 in sys_alloc()


________________________________________________________________________________________________________
*** CID 1412767:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 4082 in sys_alloc()
4076       */
4077     
4078       if (MORECORE_CONTIGUOUS && !use_noncontiguous(m)) {
4079         char* br = CMFAIL;
4080         size_t ssize = asize; /* sbrk call size */
4081         msegmentptr ss = (m->top == 0)? 0 : segment_holding(m, (char*)m->top);
>>>     CID 1412767:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "spin_acquire_lock" without checking return value (as is done elsewhere 25 out of 29 times).
4082         ACQUIRE_MALLOC_GLOBAL_LOCK();
4083     
4084         if (ss == 0) {  /* First time through or recovery */
4085           char* base = (char*)CALL_MORECORE(0);
4086           if (base != CMFAIL) {
4087             size_t fp;

** CID 1412771:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 4320 in sys_trim()


________________________________________________________________________________________________________
*** CID 1412771:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 4320 in sys_trim()
4314                 }
4315               }
4316             }
4317             else if (HAVE_MORECORE) {
4318               if (extra >= HALF_MAX_SIZE_T) /* Avoid wrapping negative */
4319                 extra = (HALF_MAX_SIZE_T) + SIZE_T_ONE - unit;
>>>     CID 1412771:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "spin_acquire_lock" without checking return value (as is done elsewhere 25 out of 29 times).
4320               ACQUIRE_MALLOC_GLOBAL_LOCK();
4321               {
4322                 /* Make sure end of memory is where we last set it. */
4323                 char* old_br = (char*)(CALL_MORECORE(0));
4324                 if (old_br == sp->base + sp->size) {
4325                   char* rel_br = (char*)(CALL_MORECORE(-extra));

** CID 1412774:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_ext_2_8_6.c: 899 in internal_node_multialloc()


________________________________________________________________________________________________________
*** CID 1412774:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_ext_2_8_6.c: 899 in internal_node_multialloc()
893           {
894              /* Default contiguous, just check that we can store at least one element */
895              elements_per_segment = INTERNAL_MULTIALLOC_DEFAULT_CONTIGUOUS_MEM/element_req_size;
896              elements_per_segment += (size_t)(!elements_per_segment);
897           }
898           break;
>>>     CID 1412774:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "case 18446744073709551615UL:".
899           case DL_MULTIALLOC_ALL_CONTIGUOUS:
900              /* All elements should be allocated in a single call */
901              elements_per_segment = n_elements;
902           break;
903           default:
904              /* Allocate in chunks of "contiguous_elements" */

** CID 1412779:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_ext_2_8_6.c: 1419 in boost_cont_sync_create()


________________________________________________________________________________________________________
*** CID 1412779:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_ext_2_8_6.c: 1419 in boost_cont_sync_create()
1413     
1414     void *boost_cont_sync_create()
1415     {
1416        void *p = boost_cont_malloc(sizeof(MLOCK_T));
1417        if(p){
1418           if(0 != INITIAL_LOCK((MLOCK_T*)p)){
>>>     CID 1412779:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "boost_cont_free(p);".
1419              boost_cont_free(p);
1420              p = 0;
1421           }
1422        }
1423        return p;
1424     }

** CID 1412790:  Parse warnings  (PARSE_ERROR)
/home/brad/working/src/ceph/src/boost/libs/config/checks/architecture/32.cpp: 9 in ()


________________________________________________________________________________________________________
*** CID 1412790:  Parse warnings  (PARSE_ERROR)
/home/brad/working/src/ceph/src/boost/libs/config/checks/architecture/32.cpp: 9 in ()
3     // Copyright (c) 2012 Steven Watanabe
4     //
5     // Distributed under the Boost Software License Version 1.0. (See
6     // accompanying file LICENSE_1_0.txt or copy at
7     // https://u2389337.ct.sendgrid.net/wf/click?upn=eMT-2BqXhL85kf4kjMp0VpWCFMlq1TlYlB11Ini8deNjCt00DxPrdVraoAU1pWqOFT_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8G18FYACrbQxvEA59Ai-2FYWMyqyg4NQd4x0x5MX8csLWt7-2Bt-2B4OjBBdJM6odqm-2BAUhp86LoxSp0VZms9snHpEsgtrz68Ce-2Bh5WpjedT7778OUyE34yCV-2F2EjO05WDTE29GHPWcbIgFPF4BAuyM5w1AMOxqPp0E6rAgd5kccpDNOcZZAwaeEIFD-2BcNcvCBEJHdZ8-3D
8     
>>>     CID 1412790:  Parse warnings  (PARSE_ERROR)
>>>     the size of an array must be greater than zero

** CID 1412791:  Parse warnings  (PARSE_ERROR)
/home/brad/working/src/ceph/src/boost/libs/config/checks/architecture/arm.cpp: 13 in ()


________________________________________________________________________________________________________
*** CID 1412791:  Parse warnings  (PARSE_ERROR)
/home/brad/working/src/ceph/src/boost/libs/config/checks/architecture/arm.cpp: 13 in ()
7     // https://u2389337.ct.sendgrid.net/wf/click?upn=eMT-2BqXhL85kf4kjMp0VpWCFMlq1TlYlB11Ini8deNjCt00DxPrdVraoAU1pWqOFT_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8G18FYACrbQxvEA59Ai-2FYWMyqyg4NQd4x0x5MX8csLWt6ylX8SjlIfUmKhcfo7X8Al-2BZlDHNqSQDb6srcWEWmRf4rHonYZQcq8-2BvzQjDYTem5B-2FQx5LcL6MKtBAwS-2BEnB6d8y0Owic2QGBLL8l2Tn6XFPJMvCSE1BcUNdoMG9fBPFv2keSd94gcBeuQRWWQLKM-3D
8     
9     #if !defined(__arm__) && !defined(__thumb__) && \
10         !defined(__TARGET_ARCH_ARM) && !defined(__TARGET_ARCH_THUMB) && \
11         !defined(_ARM) && !defined(_M_ARM) && \
12         !defined(__aarch64__) 
>>>     CID 1412791:  Parse warnings  (PARSE_ERROR)
>>>     #error directive: "Not ARM"
13     #error "Not ARM"

** CID 1412792:  Parse warnings  (PARSE_ERROR)
/home/brad/working/src/ceph/src/boost/libs/config/checks/architecture/sparc.cpp: 10 in ()


________________________________________________________________________________________________________
*** CID 1412792:  Parse warnings  (PARSE_ERROR)
/home/brad/working/src/ceph/src/boost/libs/config/checks/architecture/sparc.cpp: 10 in ()
4     //
5     // Distributed under the Boost Software License Version 1.0. (See
6     // accompanying file LICENSE_1_0.txt or copy at
7     // https://u2389337.ct.sendgrid.net/wf/click?upn=eMT-2BqXhL85kf4kjMp0VpWCFMlq1TlYlB11Ini8deNjCt00DxPrdVraoAU1pWqOFT_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8G18FYACrbQxvEA59Ai-2FYWMyqyg4NQd4x0x5MX8csLWt0Eb8KvLP0-2F-2FK3EaUuMjWkrD8xk6WH6I13j3HryKrS4OxI7-2B1wZv2p4NUurs3bEN6HQUGeea4n3Cd1hwJaIUmSCsVuEIkFaWw-2BZbB664dgXTcjBX0aHNSCN2JDh3Kh2BWGtTlRgDsU-2Fml-2F3AYcB79D4-3D
8     
9     #if !defined(__sparc__) && !defined(__sparc)
>>>     CID 1412792:  Parse warnings  (PARSE_ERROR)
>>>     #error directive: "Not SPARC"
10     #error "Not SPARC"


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8G18FYACrbQxvEA59Ai-2FYWMyqyg4NQd4x0x5MX8csLWt4AvL1Yos2j8VrXTWKko1MeQW0U5Ur0kILnCYdV-2BGpC7FFB5fI3GwuxzxIngd93mSjX7Wn9XFEP81S68N0nFhjiMlsYb0HH8w-2Fwul4vfrByqlsPbD-2FhhYrQ-2BuWcFtOqRcKHCIdC8RvngsVUWfwG0K8M-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8G18FYACrbQxvEA59Ai-2FYWMyqyg4NQd4x0x5MX8csLWtyjnraXDHKEbuiypqfZUMKgLiXzD5xGJBtBbsSBQ8Ffd3m6-2BOJzxegtmGKXyOJniqV7hbSiBN7mGu3nQyS4lFK3OnHI3iECLd1Yf-2BiuHR5OX1q4qVK0lR6hAiay2DuNnCLsnuBEPqPUytngiwYXwzwY-3D

