From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Wed, 08 Mar 2017 22:12:34 -0800
Message-ID: <58c0f252eb0b_1a4712f73207029a@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:35121 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750724AbdCIGNn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Mar 2017 01:13:43 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0010p1las1.sendgrid.net (SG) with ESMTP id omOMWa0fQq2BhM62xU9wCw
        for <ceph-devel@vger.kernel.org>; Thu, 09 Mar 2017 06:12:34.308 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

12 new defect(s) introduced to ceph found with Coverity Scan.
10 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 12 of 12 defect(s)


** CID 1402131:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_internal.cc: 90 in generate_random_iomap(librbd::Image &, int, int, int, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>> &)()
/home/brad/working/src/ceph/src/test/librbd/test_internal.cc: 91 in generate_random_iomap(librbd::Image &, int, int, int, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>> &)()


________________________________________________________________________________________________________
*** CID 1402131:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_internal.cc: 90 in generate_random_iomap(librbd::Image &, int, int, int, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>> &)()
84       stripe_count = image.get_stripe_count();
85     
86       while (max_count-- > 0) {
87         // generate random image offset based on base random object
88         // number and object offset and then map that back to an
89         // object number based on stripe unit and count.
>>>     CID 1402131:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
90         uint64_t ono = rand() % num_objects;
91         uint64_t offset = rand() % (object_size - TEST_IO_SIZE);
92         uint64_t imageoff = (ono * object_size) + offset;
93     
94         file_layout_t layout;
95         layout.object_size = object_size;
/home/brad/working/src/ceph/src/test/librbd/test_internal.cc: 91 in generate_random_iomap(librbd::Image &, int, int, int, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>> &)()
85     
86       while (max_count-- > 0) {
87         // generate random image offset based on base random object
88         // number and object offset and then map that back to an
89         // object number based on stripe unit and count.
90         uint64_t ono = rand() % num_objects;
>>>     CID 1402131:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
91         uint64_t offset = rand() % (object_size - TEST_IO_SIZE);
92         uint64_t imageoff = (ono * object_size) + offset;
93     
94         file_layout_t layout;
95         layout.object_size = object_size;
96         layout.stripe_unit = stripe_unit;

** CID 1402132:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_internal.cc: 1145 in TestInternal_FlattenNoEmptyObjects_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1402132:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_internal.cc: 1145 in TestInternal_FlattenNoEmptyObjects_Test::TestBody()()
1139       printf("made parent image \"%s\": %ldK (%d * %ldK)\n", m_image_name.c_str(),
1140              (unsigned long)m_image_size, object_num, info.obj_size/1024);
1141     
1142       // write something into parent
1143       char test_data[TEST_IO_SIZE + 1];
1144       for (int i = 0; i < TEST_IO_SIZE; ++i) {
>>>     CID 1402132:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
1145         test_data[i] = (char) (rand() % (126 - 33) + 33);
1146       }
1147       test_data[TEST_IO_SIZE] = '\0';
1148     
1149       // generate a random map which covers every objects with random
1150       // offset

** CID 1402133:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_internal.cc: 1008 in TestInternal_TestCoR_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1402133:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_internal.cc: 1008 in TestInternal_TestCoR_Test::TestBody()()
1002       printf("made parent image \"%s\": %ldK (%d * %ldK)\n", m_image_name.c_str(),
1003              (unsigned long)m_image_size, object_num, info.obj_size/1024);
1004     
1005       // write something into parent
1006       char test_data[TEST_IO_SIZE + 1];
1007       for (int i = 0; i < TEST_IO_SIZE; ++i) {
>>>     CID 1402133:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
1008         test_data[i] = (char) (rand() % (126 - 33) + 33);
1009       }
1010       test_data[TEST_IO_SIZE] = '\0';
1011     
1012       // generate a random map which covers every objects with random
1013       // offset

** CID 1402134:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/rgw/rgw_file.h: 550 in rgw::RGWFileHandle::set_atime(const timespec &)()


________________________________________________________________________________________________________
*** CID 1402134:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/rgw/rgw_file.h: 550 in rgw::RGWFileHandle::set_atime(const timespec &)()
544     
545         void set_mtime(const struct timespec &ts) {
546           state.mtime = ts;
547         }
548     
549         void set_atime(const struct timespec &ts) {
>>>     CID 1402134:  Concurrent data access violations  (MISSING_LOCK)
>>>     Accessing "this->state.atime" without holding lock "rgw::RGWFileHandle.mtx". Elsewhere, "_ZN3rgw13RGWFileHandle5StateE.atime" is accessed with "rgw::RGWFileHandle.mtx" held 2 out of 5 times (2 of these accesses strongly imply that it is necessary).
550           state.atime = ts;
551         }
552     
553         void encode(buffer::list& bl) const {
554           ENCODE_START(1, 1, bl);
555           ::encode(uint32_t(fh.fh_type), bl);

** CID 1402135:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/rgw/rgw_file.h: 347 in rgw::RGWFileHandle::create_stat(stat *, unsigned int)()


________________________________________________________________________________________________________
*** CID 1402135:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/rgw/rgw_file.h: 347 in rgw::RGWFileHandle::create_stat(stat *, unsigned int)()
341           default:
342     	break;
343     	}
344           }
345     
346           if (mask & RGW_SETATTR_ATIME)
>>>     CID 1402135:  Concurrent data access violations  (MISSING_LOCK)
>>>     Accessing "this->state.atime" without holding lock "rgw::RGWFileHandle.mtx". Elsewhere, "_ZN3rgw13RGWFileHandle5StateE.atime" is accessed with "rgw::RGWFileHandle.mtx" held 2 out of 5 times (2 of these accesses strongly imply that it is necessary).
347     	state.atime = st->st_atim;
348           if (mask & RGW_SETATTR_MTIME)
349     	state.mtime = st->st_mtim;
350           if (mask & RGW_SETATTR_CTIME)
351     	state.ctime = st->st_ctim;
352         }

** CID 1402136:  Parse warnings  (PARSE_ERROR)
/home/brad/working/src/ceph/src/mds/PurgeQueue.cc: 1 in ()


________________________________________________________________________________________________________
*** CID 1402136:  Parse warnings  (PARSE_ERROR)
/home/brad/working/src/ceph/src/mds/PurgeQueue.cc: 1 in ()
>>>     CID 1402136:  Parse warnings  (PARSE_ERROR)
>>>     The Coverity compiler fails to compile this file. Please see the build output log for more information.
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
2     // vim: ts=8 sw=2 smarttab
3     /*
4      * Ceph - scalable distributed file system
5      *
6      * Copyright (C) 2015 Red Hat

** CID 1402137:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librbd/test_internal.cc: 1102 in TestInternal_TestCoR_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1402137:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librbd/test_internal.cc: 1102 in TestInternal_TestCoR_Test::TestBody()()
1096       ASSERT_EQ(0, image.close());
1097     
1098       printf("check whether child image has the same set of objects as parent\n");
1099       ASSERT_EQ(0, m_rbd.open(m_ioctx, image, clonename.c_str(), NULL));
1100       ASSERT_EQ(0, image.stat(info, sizeof(info)));
1101     
>>>     CID 1402137:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "list_ctx" going out of scope leaks the storage it points to.
1102       ASSERT_EQ(0, rados_nobjects_list_open(d_ioctx, &list_ctx));
1103       while (rados_nobjects_list_next(list_ctx, &entry, NULL, NULL) != -ENOENT) {
1104         if (strstr(entry, info.block_name_prefix)) {
1105           const char *block_name_suffix = entry + strlen(info.block_name_prefix) + 1;
1106           set<string>::iterator it = obj_checker.find(block_name_suffix);
1107           ASSERT_TRUE(it != obj_checker.end());

** CID 1402138:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librbd/test_internal.cc: 1216 in TestInternal_FlattenNoEmptyObjects_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1402138:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librbd/test_internal.cc: 1216 in TestInternal_FlattenNoEmptyObjects_Test::TestBody()()
1210       printf("flattening clone: \"%s\"\n", clonename.c_str());
1211       ASSERT_EQ(0, image.flatten());
1212     
1213       printf("check whether child image has the same set of objects as parent\n");
1214       ASSERT_EQ(0, image.stat(info, sizeof(info)));
1215     
>>>     CID 1402138:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "list_ctx" going out of scope leaks the storage it points to.
1216       ASSERT_EQ(0, rados_nobjects_list_open(d_ioctx, &list_ctx));
1217       while (rados_nobjects_list_next(list_ctx, &entry, NULL, NULL) != -ENOENT) {
1218         if (strstr(entry, info.block_name_prefix)) {
1219           const char *block_name_suffix = entry + strlen(info.block_name_prefix) + 1;
1220           set<string>::iterator it = obj_checker.find(block_name_suffix);
1221           ASSERT_TRUE(it != obj_checker.end());

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

** CID 1402140:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/list.cc: 551 in LibRadosList_ListObjectsCursor_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/list.cc: 565 in LibRadosList_ListObjectsCursor_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/list.cc: 609 in LibRadosList_ListObjectsCursor_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1402140:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/librados/list.cc: 551 in LibRadosList_ListObjectsCursor_Test::TestBody()()
545       }
546     
547       {
548         rados_list_ctx_t ctx;
549         const char *entry;
550         rados_object_list_cursor cursor;
>>>     CID 1402140:    (RESOURCE_LEAK)
>>>     Variable "ctx" going out of scope leaks the storage it points to.
551         ASSERT_EQ(0, rados_nobjects_list_open(ioctx, &ctx));
552         ASSERT_EQ(rados_nobjects_list_get_cursor(ctx, &cursor), 0);
553         rados_object_list_cursor first_cursor = cursor;
554         cout << "x cursor=" << ObjectCursor(cursor) << std::endl;
555         while (rados_nobjects_list_next(ctx, &entry, NULL, NULL) == 0) {
556           string oid = entry;
/home/brad/working/src/ceph/src/test/librados/list.cc: 565 in LibRadosList_ListObjectsCursor_Test::TestBody()()
559         }
560         rados_nobjects_list_seek_cursor(ctx, first_cursor);
561         ASSERT_EQ(rados_nobjects_list_next(ctx, &entry, NULL, NULL), 0);
562         cout << "FIRST> seek to " << ObjectCursor(first_cursor) << " oid=" << string(entry) << std::endl;
563       }
564       rados_list_ctx_t ctx;
>>>     CID 1402140:    (RESOURCE_LEAK)
>>>     Variable "ctx" going out of scope leaks the storage it points to.
565       ASSERT_EQ(0, rados_nobjects_list_open(ioctx, &ctx));
566     
567       std::map<rados_object_list_cursor, string> cursor_to_obj;
568       int count = 0;
569     
570       const char *entry;
/home/brad/working/src/ceph/src/test/librados/list.cc: 609 in LibRadosList_ListObjectsCursor_Test::TestBody()()
603         ASSERT_EQ(p->second, string(entry));
604     
605         ++p;
606     
607         rados_object_list_cursor_free(ctx, cursor);
608       }
>>>     CID 1402140:    (RESOURCE_LEAK)
>>>     Variable "ctx" going out of scope leaks the storage it points to.
609     }
610     
611     TEST_F(LibRadosListEC, ListObjects) {
612       char buf[128];
613       memset(buf, 0xcc, sizeof(buf));
614       ASSERT_EQ(0, rados_write(ioctx, "foo", buf, sizeof(buf), 0));

** CID 1402141:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/librbd.cc: 88 in <unnamed>::C_OpenComplete::C_OpenComplete(librbd::ImageCtx *, librbd::io::AioCompletion *, void **)()


________________________________________________________________________________________________________
*** CID 1402141:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/librbd.cc: 88 in <unnamed>::C_OpenComplete::C_OpenComplete(librbd::ImageCtx *, librbd::io::AioCompletion *, void **)()
82       bool reopen;
83       C_OpenComplete(librbd::ImageCtx *ictx, librbd::io::AioCompletion* comp,
84     		 void **ictxp)
85         : ictx(ictx), comp(comp), ictxp(ictxp) {
86         comp->init_time(ictx, librbd::io::AIO_TYPE_OPEN);
87         comp->get();
>>>     CID 1402141:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "reopen" is not initialized in this constructor nor in any functions that it calls.
88       }
89       void finish(int r) override {
90         ldout(ictx->cct, 20) << "C_OpenComplete::finish: r=" << r << dendl;
91         if (r < 0) {
92           *ictxp = nullptr;
93           comp->fail(r);

** CID 1402142:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/mds/StrayManager.cc: 80 in C_IO_PurgeStrayPurged::C_IO_PurgeStrayPurged(StrayManager *, CDentry *, bool)()


________________________________________________________________________________________________________
*** CID 1402142:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/mds/StrayManager.cc: 80 in C_IO_PurgeStrayPurged::C_IO_PurgeStrayPurged(StrayManager *, CDentry *, bool)()
74       CDentry *dn;
75       bool only_head;
76       // How many ops_in_flight were allocated to this purge?
77       uint32_t ops_allowance;
78     public:
79       C_IO_PurgeStrayPurged(StrayManager *sm_, CDentry *d, bool oh) : 
>>>     CID 1402142:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "ops_allowance" is not initialized in this constructor nor in any functions that it calls.
80         StrayManagerIOContext(sm_), dn(d), only_head(oh) { }
81       void finish(int r) override {
82         assert(r == 0 || r == -ENOENT);
83         sm->_purge_stray_purged(dn, ops_allowance, only_head);
84       }
85     };


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FRQrrp6gq4YQyADNej-2FNo2ZF19zjsiMvGCVYO1x7dweDPC2oAq79dhYTDCP2U6Ht4pBO8zH9V7v58jBhiCyIUS3zRjtQir2D8-2BZqxPlV4bjDIMczAsYIGMPdZvoQYzWjYEqxhDoa361z1j4i7-2FmGG9qistCltj2M3ofYxDH18i5LYJmYbmmVKvBr4qtjzExv4-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FRQrrp6gq4YQyADNej-2FNo2ZF19zjsiMvGCVYO1x7dweAXRodHRN8fjeAvDpjDmqZJfNkHQT-2BKwfrn1E0oQUXw4L05l4v9-2Br5Ctyeo5zDGfQQMllbSVcYH7pjcWZVGyzvf2B-2B-2FViyy8E20bbc-2Bn2-2FK8xA4SrbkfLUrj1i1-2FeUYL0GeAxMp8TqwlYnIzIho5NX8-3D

