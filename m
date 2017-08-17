From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 17 Aug 2017 03:29:47 +0000 (UTC)
Message-ID: <59950dabb5fd6_f1744931445964@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:44913 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751856AbdHQDb3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 16 Aug 2017 23:31:29 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0011p1las1.sendgrid.net (SG) with ESMTP id E5APw1wmTY2S8OXzGneWDA
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 03:29:47.941 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

8 new defect(s) introduced to ceph found with Coverity Scan.
35 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 8 of 8 defect(s)


** CID 1416590:  Memory - corruptions  (USE_AFTER_FREE)


________________________________________________________________________________________________________
*** CID 1416590:  Memory - corruptions  (USE_AFTER_FREE)
/home/brad/working/src/ceph/src/msg/async/rdma/RDMAStack.cc: 552 in RDMAStack::~RDMAStack()()
546     {
547       if (cct->_conf->ms_async_rdma_enable_hugepage) {
548         unsetenv("RDMAV_HUGEPAGES_SAFE");	//remove env variable on destruction
549       }
550     
551       dispatcher.polling_stop();
>>>     CID 1416590:  Memory - corruptions  (USE_AFTER_FREE)
>>>     Calling "~RDMADispatcher" frees pointer "this->dispatcher.rx_cq" which has already been freed.
552     }
553     
554     void RDMAStack::spawn_worker(unsigned i, std::function<void ()> &&func)
555     {
556       threads.resize(i+1);
557       threads[i] = std::thread(func);

** CID 1416591:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1239 in PGLog::read_log_and_missing(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, bool, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool)()


________________________________________________________________________________________________________
*** CID 1416591:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1239 in PGLog::read_log_and_missing(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, bool, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool)()
1233         );
1234     
1235       void read_log_and_missing(
1236         ObjectStore *store,
1237         coll_t pg_coll,
1238         coll_t log_coll,
>>>     CID 1416591:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter log_oid of type "ghobject_t" (size 144 bytes) by value.
1239         ghobject_t log_oid,
1240         const pg_info_t &info,
1241         bool force_rebuild_missing,
1242         ostringstream &oss,
1243         bool tolerate_divergent_missing_log,
1244         bool debug_verify_stored_missing = false

** CID 1416592:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1261 in PGLog::read_log_and_missing<pg_missing_set<(bool)1>>(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, PGLog::IndexedLog &, T1 &, bool, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool *, const DoutPrefixProvider *, std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> *, bool)()


________________________________________________________________________________________________________
*** CID 1416592:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/osd/PGLog.h: 1261 in PGLog::read_log_and_missing<pg_missing_set<(bool)1>>(ObjectStore *, coll_t, coll_t, ghobject_t, const pg_info_t &, PGLog::IndexedLog &, T1 &, bool, std::__cxx11::basic_ostringstream<char, std::char_traits<char>, std::allocator<char>> &, bool, bool *, const DoutPrefixProvider *, std::set<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> *, bool)()
1255     
1256       template <typename missing_type>
1257       static void read_log_and_missing(
1258         ObjectStore *store,
1259         coll_t pg_coll,
1260         coll_t log_coll,
>>>     CID 1416592:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter log_oid of type "ghobject_t" (size 144 bytes) by value.
1261         ghobject_t log_oid,
1262         const pg_info_t &info,
1263         IndexedLog &log,
1264         missing_type &missing,
1265         bool force_rebuild_missing,
1266         ostringstream &oss,

** CID 1416593:  Memory - illegal accesses  (USE_AFTER_FREE)


________________________________________________________________________________________________________
*** CID 1416593:  Memory - illegal accesses  (USE_AFTER_FREE)
/home/brad/working/src/ceph/src/msg/async/rdma/RDMAStack.cc: 552 in RDMAStack::~RDMAStack()()
546     {
547       if (cct->_conf->ms_async_rdma_enable_hugepage) {
548         unsetenv("RDMAV_HUGEPAGES_SAFE");	//remove env variable on destruction
549       }
550     
551       dispatcher.polling_stop();
>>>     CID 1416593:  Memory - illegal accesses  (USE_AFTER_FREE)
>>>     Calling "~RDMADispatcher" dereferences freed pointer "this->dispatcher.tx_cc".
552     }
553     
554     void RDMAStack::spawn_worker(unsigned i, std::function<void ()> &&func)
555     {
556       threads.resize(i+1);
557       threads[i] = std::thread(func);

** CID 1416594:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rgw/rgw_file.h: 275 in rgw::RGWFileHandle::RGWFileHandle(rgw::RGWLibFS *)()


________________________________________________________________________________________________________
*** CID 1416594:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rgw/rgw_file.h: 275 in rgw::RGWFileHandle::RGWFileHandle(rgw::RGWLibFS *)()
269     	fh.fh_type = RGW_FS_TYPE_DIRECTORY;
270     	variant_type = directory();
271     	/* stat */
272     	state.unix_mode = RGW_RWXMODE|S_IFDIR;
273     	/* pointer to self */
274     	fh.fh_private = this;
>>>     CID 1416594:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member field "fh.fh_hk" is not initialized in this constructor nor in any functions that it calls.
275           }
276     
277         uint64_t init_fsid(std::string& uid) {
278           return XXH64(uid.c_str(), uid.length(), fh_key::seed);
279         }
280     

** CID 1416595:  Memory - corruptions  (USE_AFTER_FREE)


________________________________________________________________________________________________________
*** CID 1416595:  Memory - corruptions  (USE_AFTER_FREE)
/home/brad/working/src/ceph/src/msg/async/rdma/RDMAStack.cc: 552 in RDMAStack::~RDMAStack()()
546     {
547       if (cct->_conf->ms_async_rdma_enable_hugepage) {
548         unsetenv("RDMAV_HUGEPAGES_SAFE");	//remove env variable on destruction
549       }
550     
551       dispatcher.polling_stop();
>>>     CID 1416595:  Memory - corruptions  (USE_AFTER_FREE)
>>>     Calling "~RDMADispatcher" frees pointer "this->dispatcher.tx_cq" which has already been freed.
552     }
553     
554     void RDMAStack::spawn_worker(unsigned i, std::function<void ()> &&func)
555     {
556       threads.resize(i+1);
557       threads[i] = std::thread(func);

** CID 1416596:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/test/librados/c_read_operations.cc: 208 in CReadOpsTest_CmpXattr_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1416596:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/test/librados/c_read_operations.cc: 208 in CReadOpsTest_CmpXattr_Test::TestBody()()
202     TEST_F(CReadOpsTest, CmpXattr) {
203       write_object();
204     
205       char buf[len];
206       memset(buf, 0xcc, sizeof(buf));
207     
>>>     CID 1416596:  Memory - corruptions  (OVERRUN)
>>>     Assigning: "xattr" = ""test"". "xattr" now points to byte 0 of ""test"" (which consists of 5 bytes).
208       const char *xattr = "test";
209       rados_setxattr(ioctx, obj, xattr, buf, sizeof(buf));
210     
211       // equal value
212       EXPECT_EQ(1, cmp_xattr(xattr, buf, sizeof(buf), LIBRADOS_CMPXATTR_OP_EQ));
213       EXPECT_EQ(-ECANCELED, cmp_xattr(xattr, buf, sizeof(buf), LIBRADOS_CMPXATTR_OP_NE));

** CID 1416597:  Memory - illegal accesses  (USE_AFTER_FREE)


________________________________________________________________________________________________________
*** CID 1416597:  Memory - illegal accesses  (USE_AFTER_FREE)
/home/brad/working/src/ceph/src/msg/async/rdma/RDMAStack.cc: 552 in RDMAStack::~RDMAStack()()
546     {
547       if (cct->_conf->ms_async_rdma_enable_hugepage) {
548         unsetenv("RDMAV_HUGEPAGES_SAFE");	//remove env variable on destruction
549       }
550     
551       dispatcher.polling_stop();
>>>     CID 1416597:  Memory - illegal accesses  (USE_AFTER_FREE)
>>>     Calling "~RDMADispatcher" dereferences freed pointer "this->dispatcher.rx_cc".
552     }
553     
554     void RDMAStack::spawn_worker(unsigned i, std::function<void ()> &&func)
555     {
556       threads.resize(i+1);
557       threads[i] = std::thread(func);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HJuCdf6fOv6U-2BT-2FfxU234HHO-2FU-2FrdVWrCSKfN5YOY7DbgEhZ8-2B5UG-2FCD2FKz16j4yX1c25Rx7w8cLzh-2B0uCtoEqAhGkEdn8LgdY2K479hJQQJf4vG00srBglzIdO0iy-2FPfTr4yPpAvOVQIFRf6A1qhI7VgiPd5XTAUK-2FxfTx-2BoZauSqnNJtdG258mhSM8Wyo0-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HJuCdf6fOv6U-2BT-2FfxU234HHO-2FU-2FrdVWrCSKfN5YOY7DSNDX-2Bz11nsM28QQkT1KXJKulzaEQCTA-2B0-2BawaUgFrmRszuh1esycUBL296O3a82EtXZ2HKdnqLp4EVd9gr3-2F1jjk0K0YkF170up7pT-2BT2-2F1TlXxCKINLnM8OEgjCRl5ddJPr1lhGeYIEgRuTVpQ6XM-3D

