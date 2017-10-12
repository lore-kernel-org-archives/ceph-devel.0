From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 12 Oct 2017 05:54:59 +0000 (UTC)
Message-ID: <59df03b3a7fb8_7d5740932c35324@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.hv1nn.shared.sendgrid.net ([167.89.100.169]:59846 "EHLO
        o1.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751097AbdJLFzA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 12 Oct 2017 01:55:00 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id XgSVFzGuTMW5qEoJr0WJGw
        for <ceph-devel@vger.kernel.org>; Thu, 12 Oct 2017 05:54:59.724 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

42 new defect(s) introduced to ceph found with Coverity Scan.
41 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 42 defect(s)


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
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3588 in main()


________________________________________________________________________________________________________
*** CID 1316246:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rados/rados.cc: 3588 in main()
3582     
3583     out:
3584       delete formatter;
3585       return (ret < 0) ? 1 : 0;
3586     }
3587     
>>>     CID 1316246:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
3588     int main(int argc, const char **argv)
3589     {
3590       vector<const char*> args;
3591       argv_to_vec(argc, argv, args);
3592       env_to_vec(args);
3593     

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
/home/brad/working/src/ceph/src/test/kv_store_bench.cc: 553 in main()


________________________________________________________________________________________________________
*** CID 1316248:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/kv_store_bench.cc: 553 in main()
547       } else {
548         err = test_teuthology_sync(&KvStoreBench::rand_distr, probs);
549       }
550       return err;
551     }
552     
>>>     CID 1316248:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::runtime_error" is thrown and never caught.
553     int main(int argc, const char** argv) {
554       KvStoreBench kvsb;
555       int err = kvsb.setup(argc, argv);
556       if (err == 0) cout << "setup successful" << std::endl;
557       else{
558         cout << "error " << err << std::endl;

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

** CID 1416366:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rbd_mirror/main.cc: 32 in main()


________________________________________________________________________________________________________
*** CID 1416366:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rbd_mirror/main.cc: 32 in main()
26     static void handle_signal(int signum)
27     {
28       if (mirror)
29         mirror->handle_signal(signum);
30     }
31     
>>>     CID 1416366:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error> >" is thrown and never caught.
32     int main(int argc, const char **argv)
33     {
34       std::vector<const char*> args;
35       env_to_vec(args);
36       argv_to_vec(argc, argv, args);
37     

** CID 1419589:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1280 in PGLog::read_log_and_missing<pg_missing_set<(bool)1>>(ObjectStore *, coll_t, ghobject_t, const pg_info_t &, PGLog::IndexedLog &, T1 &, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool *, const DoutPrefixProvider *, std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> *, bool)()


________________________________________________________________________________________________________
*** CID 1419589:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1280 in PGLog::read_log_and_missing<pg_missing_set<(bool)1>>(ObjectStore *, coll_t, ghobject_t, const pg_info_t &, PGLog::IndexedLog &, T1 &, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool *, const DoutPrefixProvider *, std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> *, bool)()
1274       }
1275     
1276       template <typename missing_type>
1277       static void read_log_and_missing(
1278         ObjectStore *store,
1279         coll_t pg_coll,
>>>     CID 1419589:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter pgmeta_oid of type "ghobject_t" (size 144 bytes) by value.
1280         ghobject_t pgmeta_oid,
1281         const pg_info_t &info,
1282         IndexedLog &log,
1283         missing_type &missing,
1284         ostringstream &oss,
1285         bool tolerate_divergent_missing_log,

** CID 1419590:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 17416 in __pyx_pw_5rados_5Rados_59pg_command()


________________________________________________________________________________________________________
*** CID 1419590:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 17416 in __pyx_pw_5rados_5Rados_59pg_command()
17410           }
17411           kw_args = PyDict_Size(__pyx_kwds);
17412           switch (pos_args) {
17413             case  0:
17414             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_pgid)) != 0)) kw_args--;
17415             else goto __pyx_L5_argtuple_error;
>>>     CID 1419590:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
17416             case  1:
17417             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cmd)) != 0)) kw_args--;
17418             else {
17419               __Pyx_RaiseArgtupleInvalid("pg_command", 0, 3, 4, 1); __PYX_ERR(0, 1368, __pyx_L3_error)
17420             }
17421             case  2:

** CID 1419591:  Integer handling issues  (NEGATIVE_RETURNS)
/home/brad/working/src/ceph/src/os/bluestore/BlueRocksEnv.cc: 276 in BlueRocksWritableFile::Allocate(long, long)()


________________________________________________________________________________________________________
*** CID 1419591:  Integer handling issues  (NEGATIVE_RETURNS)
/home/brad/working/src/ceph/src/os/bluestore/BlueRocksEnv.cc: 276 in BlueRocksWritableFile::Allocate(long, long)()
270      protected:
271       using rocksdb::WritableFile::Allocate;
272       /*
273        * Pre-allocate space for a file.
274        */
275       rocksdb::Status Allocate(off_t offset, off_t len) {
>>>     CID 1419591:  Integer handling issues  (NEGATIVE_RETURNS)
>>>     Assigning: signed variable "r" = "preallocate".
276         int r = fs->preallocate(h->file, offset, len);
277         return err_to_status(r);
278       }
279     };
280     
281     

** CID 1419592:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 15548 in __pyx_pw_5rados_5Rados_53mon_command()


________________________________________________________________________________________________________
*** CID 1419592:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 15548 in __pyx_pw_5rados_5Rados_53mon_command()
15542             }
15543             case  2:
15544             if (kw_args > 0) {
15545               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_timeout);
15546               if (value) { values[2] = value; kw_args--; }
15547             }
>>>     CID 1419592:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
15548             case  3:
15549             if (kw_args > 0) {
15550               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_target);
15551               if (value) { values[3] = value; kw_args--; }
15552             }
15553           }

** CID 1419593:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 18463 in __pyx_pw_5rados_5Rados_65monitor_log()


________________________________________________________________________________________________________
*** CID 1419593:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 18463 in __pyx_pw_5rados_5Rados_65monitor_log()
18457           }
18458           kw_args = PyDict_Size(__pyx_kwds);
18459           switch (pos_args) {
18460             case  0:
18461             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_level)) != 0)) kw_args--;
18462             else goto __pyx_L5_argtuple_error;
>>>     CID 1419593:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
18463             case  1:
18464             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_callback)) != 0)) kw_args--;
18465             else {
18466               __Pyx_RaiseArgtupleInvalid("monitor_log", 1, 3, 3, 1); __PYX_ERR(0, 1440, __pyx_L3_error)
18467             }
18468             case  2:

** CID 1419594:  Resource leaks  (RESOURCE_LEAK)
/src/pybind/rados/rados.c: 16806 in __pyx_pf_5rados_5Rados_54osd_command()


________________________________________________________________________________________________________
*** CID 1419594:  Resource leaks  (RESOURCE_LEAK)
/src/pybind/rados/rados.c: 16806 in __pyx_pf_5rados_5Rados_54osd_command()
16800       __Pyx_XDECREF(__pyx_v_my_outs);
16801       __Pyx_XDECREF(__pyx_v_my_outbuf);
16802       __Pyx_XDECREF(__pyx_v_cmd);
16803       __Pyx_XDECREF(__pyx_v_inbuf);
16804       __Pyx_XGIVEREF(__pyx_r);
16805       __Pyx_RefNannyFinishContext();
>>>     CID 1419594:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "__pyx_v__cmd" going out of scope leaks the storage it points to.
16806       return __pyx_r;
16807     }
16808     
16809     /* "rados.pyx":1327
16810      *             free(_cmd)
16811      * 

** CID 1419595:  Control flow issues  (UNREACHABLE)
/src/pybind/rados/rados.c: 16734 in __pyx_pf_5rados_5Rados_54osd_command()


________________________________________________________________________________________________________
*** CID 1419595:  Control flow issues  (UNREACHABLE)
/src/pybind/rados/rados.c: 16734 in __pyx_pf_5rados_5Rados_54osd_command()
16728      *             return (ret, my_outbuf, my_outs)
16729      *         finally:
16730      *             free(_cmd)             # <<<<<<<<<<<<<<
16731      * 
16732      *     def mgr_command(self, cmd, inbuf, timeout=0):
16733      */
>>>     CID 1419595:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    PyThreadState *__...".
16734       /*finally:*/ {
16735         /*exception exit:*/{
16736           __Pyx_PyThreadState_declare
16737           __pyx_L4_error:;
16738           __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0;
16739           __Pyx_PyThreadState_assign

** CID 1419596:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 18179 in __pyx_pw_5rados_5Rados_63blacklist_add()


________________________________________________________________________________________________________
*** CID 1419596:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 18179 in __pyx_pw_5rados_5Rados_63blacklist_add()
18173           }
18174           kw_args = PyDict_Size(__pyx_kwds);
18175           switch (pos_args) {
18176             case  0:
18177             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_client_address)) != 0)) kw_args--;
18178             else goto __pyx_L5_argtuple_error;
>>>     CID 1419596:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
18179             case  1:
18180             if (kw_args > 0) {
18181               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_expire_seconds);
18182               if (value) { values[1] = value; kw_args--; }
18183             }
18184           }

** CID 1419597:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 17421 in __pyx_pw_5rados_5Rados_59pg_command()


________________________________________________________________________________________________________
*** CID 1419597:  Control flow issues  (MISSING_BREAK)
/src/pybind/rados/rados.c: 17421 in __pyx_pw_5rados_5Rados_59pg_command()
17415             else goto __pyx_L5_argtuple_error;
17416             case  1:
17417             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cmd)) != 0)) kw_args--;
17418             else {
17419               __Pyx_RaiseArgtupleInvalid("pg_command", 0, 3, 4, 1); __PYX_ERR(0, 1368, __pyx_L3_error)
17420             }
>>>     CID 1419597:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
17421             case  2:
17422             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_inbuf)) != 0)) kw_args--;
17423             else {
17424               __Pyx_RaiseArgtupleInvalid("pg_command", 0, 3, 4, 2); __PYX_ERR(0, 1368, __pyx_L3_error)
17425             }
17426             case  3:

** CID 1419598:  Resource leaks  (RESOURCE_LEAK)
/src/pybind/rados/rados.c: 15495 in __pyx_pf_5rados_5Rados_50open_ioctx2()


________________________________________________________________________________________________________
*** CID 1419598:  Resource leaks  (RESOURCE_LEAK)
/src/pybind/rados/rados.c: 15495 in __pyx_pf_5rados_5Rados_50open_ioctx2()
15489       __Pyx_AddTraceback("rados.Rados.open_ioctx2", __pyx_clineno, __pyx_lineno, __pyx_filename);
15490       __pyx_r = NULL;
15491       __pyx_L0:;
15492       __Pyx_XDECREF((PyObject *)__pyx_v_io);
15493       __Pyx_XGIVEREF(__pyx_r);
15494       __Pyx_RefNannyFinishContext();
>>>     CID 1419598:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "__pyx_v_ioctx" going out of scope leaks the storage it points to.
15495       return __pyx_r;
15496     }
15497     
15498     /* "rados.pyx":1227
15499      *         return io
15500      * 

** CID 1419599:  Control flow issues  (UNREACHABLE)
/src/pybind/rados/rados.c: 17302 in __pyx_pf_5rados_5Rados_56mgr_command()


________________________________________________________________________________________________________
*** CID 1419599:  Control flow issues  (UNREACHABLE)
/src/pybind/rados/rados.c: 17302 in __pyx_pf_5rados_5Rados_56mgr_command()
17296      *             return (ret, my_outbuf, my_outs)
17297      *         finally:
17298      *             free(_cmd)             # <<<<<<<<<<<<<<
17299      * 
17300      *     def pg_command(self, pgid, cmd, inbuf, timeout=0):
17301      */
>>>     CID 1419599:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    PyThreadState *__...".
17302       /*finally:*/ {
17303         /*exception exit:*/{
17304           __Pyx_PyThreadState_declare
17305           __pyx_L4_error:;
17306           __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0;
17307           __Pyx_PyThreadState_assign


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FpQVpxf6iAfFYK9CqE8Bp8a6vktb-2BL-2FLohqNoNRJnz-2BwxxFcYe-2BvZ6uUBIH6-2FnU1Ys2ycENmvCoL5XAQA6gJunV8dHOcOQ17-2Fv1wJcNUBgJi7xMGp1kbucMloHJJtONUB7RuH6dmoqWuCOt1PfE40MjL-2BS4jZ-2FVJGuKzU34tvin9eHITLym8KVVzmggOcXGRg-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FpQVpxf6iAfFYK9CqE8Bp8a6vktb-2BL-2FLohqNoNRJnz-2B9uPnLuXej-2B7MQmcMDfBbSO5FDHDwLcqkZ-2FPMub3VWJFeLvNOn2c3KJ-2Fn-2Bet8bcegOhqFMQrYlyBc6rLeAtn22DgLguokZLyidUy4RFEb1NIBXzZc-2FJac9ILgy7CyPfU9mC0J-2FYmKfE2djHPjH7e-2FLo-3D

