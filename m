From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 13 Jul 2017 05:11:05 +0000 (UTC)
Message-ID: <596700e8c997c_4d9460132840235@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:14558 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750807AbdGMFMt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 13 Jul 2017 01:12:49 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id e_GMp3RsRniH25_WCGS6Sw
        for <ceph-devel@vger.kernel.org>; Thu, 13 Jul 2017 05:11:04.864 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

11 new defect(s) introduced to ceph found with Coverity Scan.
11 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 11 of 11 defect(s)


** CID 1414864:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1414864:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/mgr/ServiceMap.cc: 57 in ServiceMap::Service::encode(ceph::buffer::list &, unsigned long) const()
51     }
52     
53     // Service
54     
55     void ServiceMap::Service::encode(bufferlist& bl, uint64_t features) const
56     {
>>>     CID 1414864:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
57       ENCODE_START(1, 1, bl);
58       ::encode(daemons, bl, features);
59       ::encode(summary, bl);
60       ENCODE_FINISH(bl);
61     }
62     

** CID 1414865:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/os/filestore/HashIndex.cc: 382 in HashIndex::write_settings()()


________________________________________________________________________________________________________
*** CID 1414865:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/os/filestore/HashIndex.cc: 382 in HashIndex::write_settings()()
376         return r;
377       return write_settings();
378     }
379     
380     int HashIndex::write_settings() {
381       if (cct->_conf->filestore_split_rand_factor > 0) {
>>>     CID 1414865:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
382         settings.split_rand_factor = rand() % cct->_conf->filestore_split_rand_factor;
383       } else {
384         settings.split_rand_factor = 0;
385       }
386       vector<string> path;
387       bufferlist bl;

** CID 1414866:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1414866:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/mgr/ServiceMap.cc: 12 in ServiceMap::Daemon::encode(ceph::buffer::list &, unsigned long) const()
6     #include "common/Formatter.h"
7     
8     // Daemon
9     
10     void ServiceMap::Daemon::encode(bufferlist& bl, uint64_t features) const
11     {
>>>     CID 1414866:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
12       ENCODE_START(1, 1, bl);
13       ::encode(gid, bl);
14       ::encode(addr, bl, features);
15       ::encode(start_epoch, bl);
16       ::encode(start_stamp, bl);
17       ::encode(metadata, bl);

** CID 1414867:  Memory - illegal accesses  (USE_AFTER_FREE)
/home/brad/working/src/ceph/src/mon/Monitor.cc: 1596 in Monitor::reset_probe_timeout()()


________________________________________________________________________________________________________
*** CID 1414867:  Memory - illegal accesses  (USE_AFTER_FREE)
/home/brad/working/src/ceph/src/mon/Monitor.cc: 1596 in Monitor::reset_probe_timeout()()
1590       cancel_probe_timeout();
1591       probe_timeout_event = new C_MonContext(this, [this](int r) {
1592           probe_timeout(r);
1593         });
1594       double t = g_conf->mon_probe_timeout;
1595       timer.add_event_after(t, probe_timeout_event);
>>>     CID 1414867:  Memory - illegal accesses  (USE_AFTER_FREE)
>>>     Passing freed pointer "this->probe_timeout_event" as an argument to "operator <<".
1596       dout(10) << "reset_probe_timeout " << probe_timeout_event << " after " << t << " seconds" << dendl;
1597     }
1598     
1599     void Monitor::probe_timeout(int r)
1600     {
1601       dout(4) << "probe_timeout " << probe_timeout_event << dendl;

** CID 1414868:  Control flow issues  (MISSING_RESTORE)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 4119 in BlueStore::_open_bdev(bool)()


________________________________________________________________________________________________________
*** CID 1414868:  Control flow issues  (MISSING_RESTORE)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 4119 in BlueStore::_open_bdev(bool)()
4113       assert(block_size == 1u << block_size_order);
4114       // and set cache_size based on device type
4115       r = _set_cache_sizes();
4116       if (r < 0) {
4117         goto fail_close;
4118       }
>>>     CID 1414868:  Control flow issues  (MISSING_RESTORE)
>>>     Value of non-local "this->bdev" that was verified to be "NULL" is not restored as it was along other paths.
4119       return 0;
4120     
4121      fail_close:
4122       bdev->close();
4123      fail:
4124       delete bdev;

** CID 1414869:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1414869:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/mgr/ServiceMap.cc: 93 in ServiceMap::encode(ceph::buffer::list &, unsigned long) const()
87     }
88     
89     // ServiceMap
90     
91     void ServiceMap::encode(bufferlist& bl, uint64_t features) const
92     {
>>>     CID 1414869:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
93       ENCODE_START(1, 1, bl);
94       ::encode(epoch, bl);
95       ::encode(modified, bl);
96       ::encode(services, bl, features);
97       ENCODE_FINISH(bl);
98     }

** CID 1414870:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1414870:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/cls/lock/cls_lock_types.h: 108 in rados::cls::lock::lock_info_t::encode(ceph::buffer::list &, unsigned long) const()
102             ClsLockType lock_type;                   // lock type (exclusive / shared)
103             string tag;                              // tag: operations on lock can only succeed with this tag
104                                                      //      as long as set of non expired lockers
105                                                      //      is bigger than 0.
106     
107             void encode(bufferlist &bl, uint64_t features) const {
>>>     CID 1414870:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
108               ENCODE_START(1, 1, bl);
109               ::encode(lockers, bl, features);
110               uint8_t t = (uint8_t)lock_type;
111               ::encode(t, bl);
112               ::encode(tag, bl);
113               ENCODE_FINISH(bl);

** CID 1414871:  Incorrect expression  (SIZEOF_MISMATCH)
/home/brad/working/src/ceph/src/isa-l/igzip/huff_codes.c: 1390 in isal_create_hufftables()


________________________________________________________________________________________________________
*** CID 1414871:  Incorrect expression  (SIZEOF_MISMATCH)
/home/brad/working/src/ceph/src/isa-l/igzip/huff_codes.c: 1390 in isal_create_hufftables()
1384     
1385     	create_code_tables(lit_table, lit_table_sizes, IGZIP_LIT_TABLE_SIZE, lit_huff_table);
1386     
1387     	create_packed_len_table(len_table, lit_huff_table);
1388     	create_packed_dist_table(dist_table, IGZIP_DIST_TABLE_SIZE, dist_huff_table);
1389     
>>>     CID 1414871:  Incorrect expression  (SIZEOF_MISMATCH)
>>>     Passing argument "deflate_hdr" of type "uint8_t *" and argument "8U /* sizeof (deflate_hdr) */" to function "set_buf" is suspicious.
1390     	set_buf(&header_bitbuf, deflate_hdr, sizeof(deflate_hdr));
1391     	init(&header_bitbuf);
1392     
1393     	hlit = max_lit_len_sym - 256;
1394     	hdist = max_dist_sym;
1395     

** CID 1414872:  Incorrect expression  (SIZEOF_MISMATCH)
/home/brad/working/src/ceph/src/isa-l/igzip/huff_codes.c: 1481 in isal_create_hufftables_subset()


________________________________________________________________________________________________________
*** CID 1414872:  Incorrect expression  (SIZEOF_MISMATCH)
/home/brad/working/src/ceph/src/isa-l/igzip/huff_codes.c: 1481 in isal_create_hufftables_subset()
1475     
1476     	create_code_tables(lit_table, lit_table_sizes, IGZIP_LIT_TABLE_SIZE, lit_huff_table);
1477     
1478     	create_packed_len_table(len_table, lit_huff_table);
1479     	create_packed_dist_table(dist_table, IGZIP_DIST_TABLE_SIZE, dist_huff_table);
1480     
>>>     CID 1414872:  Incorrect expression  (SIZEOF_MISMATCH)
>>>     Passing argument "deflate_hdr" of type "uint8_t *" and argument "8U /* sizeof (deflate_hdr) */" to function "set_buf" is suspicious.
1481     	set_buf(&header_bitbuf, deflate_hdr, sizeof(deflate_hdr));
1482     	init(&header_bitbuf);
1483     
1484     	hlit = max_lit_len_sym - 256;
1485     	hdist = max_dist_sym;
1486     

** CID 1414873:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/rgw/rgw_op.cc: 3716 in RGWPostObj::execute()()


________________________________________________________________________________________________________
*** CID 1414873:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/rgw/rgw_op.cc: 3716 in RGWPostObj::execute()()
3710           op_ret = -ERR_TOO_SMALL;
3711           return;
3712         }
3713     
3714         s->obj_size = ofs;
3715     
>>>     CID 1414873:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized element of array "calc_md5" when calling "strcmp".
3716         if (supplied_md5_b64 && strcmp(calc_md5, supplied_md5)) {
3717           op_ret = -ERR_BAD_DIGEST;
3718           return;
3719         }
3720     
3721         op_ret = store->check_quota(s->bucket_owner.get_id(), s->bucket,

** CID 1414874:  Memory - illegal accesses  (UNINIT)
/home/brad/working/src/ceph/src/compressor/zlib/ZlibCompressor.cc: 115 in ZlibCompressor::isal_compress(const ceph::buffer::list &, ceph::buffer::list &)()


________________________________________________________________________________________________________
*** CID 1414874:  Memory - illegal accesses  (UNINIT)
/home/brad/working/src/ceph/src/compressor/zlib/ZlibCompressor.cc: 115 in ZlibCompressor::isal_compress(const ceph::buffer::list &, ceph::buffer::list &)()
109     
110     #if __x86_64__ && defined(HAVE_BETTER_YASM_ELF64)
111     int ZlibCompressor::isal_compress(const bufferlist &in, bufferlist &out)
112     {
113       int ret;
114       unsigned have;
>>>     CID 1414874:  Memory - illegal accesses  (UNINIT)
>>>     Declaring variable "strm" without initializer.
115       isal_zstream strm;
116       unsigned char* c_in;
117       int begin = 1;
118     
119       /* allocate deflate state */
120       isal_deflate_init(&strm);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GgUHDK3UdKUZb0vpG-2Fz19Ghj7-2Bx-2FKWvgGtKe2pBI0awbrnxqUxRLcPqBM1Vp1NF-2F3gwQrwIAPVElxtQMRscsFh1WtQdX4JANyHU0xgmGaBVUjmpp2BBqSvQ25-2FOLVbF8wvW2cvH68a1zd9mDtBJS8ZJrA0IYUr4qd0W8Ak6WUG6ZU0WPgJbVubSULSlFFd250-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GgUHDK3UdKUZb0vpG-2Fz19Ghj7-2Bx-2FKWvgGtKe2pBI0awYdxU42XtgK12zM2JW75KTpHQ0BnOgU3rYwE29D-2FETObwGymbUVyYoPhnWuZOz0pwMmFoOpgrKXxi4pqD-2FnlXTQODJDxsXnXttjVj0EN41ZxTnq428Ik05KCr97hRWjUpE-2B26YTDaxHAe3dkT99VIWw-3D

