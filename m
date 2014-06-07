From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Sat, 7 Jun 2014 09:12:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406070911560.11424@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-298666001-1402157531=:11424"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53366 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbaFGQMM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Jun 2014 12:12:12 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5AA6D80446
	for <ceph-devel@vger.kernel.org>; Sat,  7 Jun 2014 09:12:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2D29E80446
	for <ceph-devel@vger.kernel.org>; Sat,  7 Jun 2014 09:12:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-298666001-1402157531=:11424
Content-Type: TEXT/PLAIN; charset=US-ASCII

Mostly stuff in teh new libradosstriper code, it looks like.
--557981400-298666001-1402157531=:11424
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1406070911561.11424@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id F25B08048A
	for <sage@cobra.newdream.net>; Sat,  7 Jun 2014 07:47:46 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id EBB2E1208BE; Sat,  7 Jun 2014 07:47:46 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from alc-junkmail-backend3.dreamhost.com (caiajhbdcbae.dreamhost.com
	[208.97.132.104])
	by destro.newdream.net (Postfix) with ESMTP id E8AEB1208BC
	for <sage@newdream.net>; Sat,  7 Jun 2014 07:47:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by alc-junkmail-backend3.dreamhost.com (Postfix) with ESMTP id
	E38B91616071
	for <sage@newdream.net>; Sat,  7 Jun 2014 07:47:46 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at alc-junkmail-backend3.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
Received: from godfather.dreamhost.com ([208.97.132.17])
	by localhost (alc-junkmail-backend3.dreamhost.com [208.97.132.104])
	(amavisd-new, port 10024)
	with ESMTP id Ms4TkJ9N8UWX for <sage@newdream.net>;
	Sat,  7 Jun 2014 07:47:46 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by godfather.dreamhost.com (Postfix) with ESMTP id B20251B0059
	for <sage@newdream.net>; Sat,  7 Jun 2014 07:47:46 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Sat, 7 Jun 2014 07:47:46 -0700
Date: Sat, 07 Jun 2014 07:47:45 -0700
From: scan-admin@coverity.com
Message-ID: <53932611e02a6_1b1f6b531474516@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2014 14:47:46.0395 (UTC)
	FILETIME=[720C5AB0:01CF825F]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 20 of 41 defect(s)


** CID 1221498:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/test/libradosstriper/striping.cc: 59 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()

** CID 1221499:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/test/libradosstriper/striping.cc: 68 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()

** CID 1221500:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/io.cc: 341 in StriperTest_XattrIter_Test::TestBody()()
/test/libradosstriper/io.cc: 335 in StriperTest_XattrIter_Test::TestBody()()

** CID 1221501:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 513 in StriperTestPP_RoundTripWriteFullPP_Test::TestBody()()

** CID 1221502:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 537 in StriperTestPP_RoundTripWriteFullPP_Test::TestBody()()
/test/libradosstriper/aio.cc: 538 in StriperTestPP_RoundTripWriteFullPP_Test::TestBody()()
/test/libradosstriper/aio.cc: 532 in StriperTestPP_RoundTripWriteFullPP_Test::TestBody()()

** CID 1221503:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 440 in StriperTest_Flush_Test::TestBody()()
/test/libradosstriper/aio.cc: 435 in StriperTest_Flush_Test::TestBody()()
/test/libradosstriper/aio.cc: 433 in StriperTest_Flush_Test::TestBody()()

** CID 1221504:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 428 in StriperTest_Flush_Test::TestBody()()
/test/libradosstriper/aio.cc: 433 in StriperTest_Flush_Test::TestBody()()
/test/libradosstriper/aio.cc: 435 in StriperTest_Flush_Test::TestBody()()
/test/libradosstriper/aio.cc: 440 in StriperTest_Flush_Test::TestBody()()
/test/libradosstriper/aio.cc: 424 in StriperTest_Flush_Test::TestBody()()

** CID 1221505:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 306 in StriperTest_IsSafe_Test::TestBody()()
/test/libradosstriper/aio.cc: 301 in StriperTest_IsSafe_Test::TestBody()()
/test/libradosstriper/aio.cc: 299 in StriperTest_IsSafe_Test::TestBody()()

** CID 1221506:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 299 in StriperTest_IsSafe_Test::TestBody()()
/test/libradosstriper/aio.cc: 301 in StriperTest_IsSafe_Test::TestBody()()
/test/libradosstriper/aio.cc: 306 in StriperTest_IsSafe_Test::TestBody()()
/test/libradosstriper/aio.cc: 285 in StriperTest_IsSafe_Test::TestBody()()
/test/libradosstriper/aio.cc: 281 in StriperTest_IsSafe_Test::TestBody()()

** CID 1221507:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 453 in StriperTestPP_FlushPP_Test::TestBody()()
/test/libradosstriper/aio.cc: 458 in StriperTestPP_FlushPP_Test::TestBody()()
/test/libradosstriper/aio.cc: 463 in StriperTestPP_FlushPP_Test::TestBody()()

** CID 1221508:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 463 in StriperTestPP_FlushPP_Test::TestBody()()
/test/libradosstriper/aio.cc: 458 in StriperTestPP_FlushPP_Test::TestBody()()

** CID 1221509:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 124 in StriperTest_RoundTrip_Test::TestBody()()
/test/libradosstriper/aio.cc: 119 in StriperTest_RoundTrip_Test::TestBody()()
/test/libradosstriper/aio.cc: 117 in StriperTest_RoundTrip_Test::TestBody()()

** CID 1221510:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 108 in StriperTest_RoundTrip_Test::TestBody()()
/test/libradosstriper/aio.cc: 117 in StriperTest_RoundTrip_Test::TestBody()()
/test/libradosstriper/aio.cc: 119 in StriperTest_RoundTrip_Test::TestBody()()
/test/libradosstriper/aio.cc: 124 in StriperTest_RoundTrip_Test::TestBody()()
/test/libradosstriper/aio.cc: 104 in StriperTest_RoundTrip_Test::TestBody()()

** CID 1221511:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 333 in StriperTestPP_IsSafePP_Test::TestBody()()
/test/libradosstriper/aio.cc: 338 in StriperTestPP_IsSafePP_Test::TestBody()()
/test/libradosstriper/aio.cc: 319 in StriperTestPP_IsSafePP_Test::TestBody()()

** CID 1221512:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 338 in StriperTestPP_IsSafePP_Test::TestBody()()
/test/libradosstriper/aio.cc: 333 in StriperTestPP_IsSafePP_Test::TestBody()()

** CID 1221513:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 240 in StriperTest_IsComplete_Test::TestBody()()
/test/libradosstriper/aio.cc: 229 in StriperTest_IsComplete_Test::TestBody()()
/test/libradosstriper/aio.cc: 227 in StriperTest_IsComplete_Test::TestBody()()

** CID 1221514:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 218 in StriperTest_IsComplete_Test::TestBody()()
/test/libradosstriper/aio.cc: 227 in StriperTest_IsComplete_Test::TestBody()()
/test/libradosstriper/aio.cc: 229 in StriperTest_IsComplete_Test::TestBody()()
/test/libradosstriper/aio.cc: 240 in StriperTest_IsComplete_Test::TestBody()()
/test/libradosstriper/aio.cc: 214 in StriperTest_IsComplete_Test::TestBody()()

** CID 1221515:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 152 in StriperTest_RoundTrip2_Test::TestBody()()
/test/libradosstriper/aio.cc: 147 in StriperTest_RoundTrip2_Test::TestBody()()
/test/libradosstriper/aio.cc: 145 in StriperTest_RoundTrip2_Test::TestBody()()

** CID 1221516:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 136 in StriperTest_RoundTrip2_Test::TestBody()()
/test/libradosstriper/aio.cc: 145 in StriperTest_RoundTrip2_Test::TestBody()()
/test/libradosstriper/aio.cc: 147 in StriperTest_RoundTrip2_Test::TestBody()()
/test/libradosstriper/aio.cc: 152 in StriperTest_RoundTrip2_Test::TestBody()()
/test/libradosstriper/aio.cc: 132 in StriperTest_RoundTrip2_Test::TestBody()()

** CID 1221517:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 52 in StriperTest_SimpleWrite_Test::TestBody()()
/test/libradosstriper/aio.cc: 48 in StriperTest_SimpleWrite_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1221498:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/test/libradosstriper/striping.cc: 59 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
53         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
54         uint64_t xa_size = strtoll(s_xattr.c_str(), NULL, 10);
55         ASSERT_EQ(xa_size, size);
56         // checking object content from rados point of view
57         // we will go stripe by stripe, read the content of each of them and
58         // check with expectations
>>>     CID 1221498:  Division or modulo by zero  (DIVIDE_BY_ZERO)
>>>     In expression "object_size / stripe_unit", division by expression "stripe_unit" which may be zero has undefined behavior.
59         uint64_t stripe_per_object = object_size / stripe_unit;
60         uint64_t stripe_per_objectset = stripe_per_object * stripe_count;
61         uint64_t nb_stripes_in_object = (size+stripe_unit-1)/stripe_unit;
62         for (uint64_t stripe_nb = 0;
63              stripe_nb < nb_stripes_in_object;
64              stripe_nb++) {

________________________________________________________________________________________________________
*** CID 1221499:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/test/libradosstriper/striping.cc: 68 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
62         for (uint64_t stripe_nb = 0;
63              stripe_nb < nb_stripes_in_object;
64              stripe_nb++) {
65           // find out where this stripe is stored
66           uint64_t objectset = stripe_nb / stripe_per_objectset;
67           uint64_t stripe_in_object_set = stripe_nb % stripe_per_objectset;
>>>     CID 1221499:  Division or modulo by zero  (DIVIDE_BY_ZERO)
>>>     In expression "stripe_in_object_set % stripe_count", modulo by expression "stripe_count" which may be zero has undefined behavior.
68           uint64_t object_in_set = stripe_in_object_set % stripe_count;
69           uint64_t stripe_in_object = stripe_in_object_set / stripe_count;
70           uint64_t object_nb = objectset * stripe_count + object_in_set;
71           uint64_t start = stripe_in_object * stripe_unit;
72           uint64_t len = stripe_unit;
73           if (stripe_nb == nb_stripes_in_object-1 and size % stripe_unit != 0) {

________________________________________________________________________________________________________
*** CID 1221500:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/io.cc: 341 in StriperTest_XattrIter_Test::TestBody()()
335       ASSERT_EQ(0, rados_striper_getxattrs(striper, "RmXattr", &iter));
336       int num_seen = 0;
337       while (true) {
338         const char *name;
339         const char *val;
340         size_t len;
>>>     CID 1221500:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "iter" going out of scope leaks the storage it points to.
341         ASSERT_EQ(0, rados_getxattrs_next(iter, &name, &val, &len));
342         if (name == NULL) {
343           break;
344         }
345         ASSERT_LT(num_seen, 2) << "Extra attribute : " << name;
346         if ((strcmp(name, "attr1") == 0) && (memcmp(val, attr1_buf, len) == 0)) {
/test/libradosstriper/io.cc: 335 in StriperTest_XattrIter_Test::TestBody()()
329       }
330       memset(buf, 0xaa, sizeof(buf));
331       ASSERT_EQ(0, rados_striper_write(striper, "RmXattr", buf, sizeof(buf), 0));
332       ASSERT_EQ(0, rados_striper_setxattr(striper, "RmXattr", "attr1", attr1_buf, sizeof(attr1_buf)));
333       ASSERT_EQ(0, rados_striper_setxattr(striper, "RmXattr", "attr2", attr2_buf, sizeof(attr2_buf)));
334       rados_xattrs_iter_t iter;
>>>     CID 1221500:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "iter" going out of scope leaks the storage it points to.
335       ASSERT_EQ(0, rados_striper_getxattrs(striper, "RmXattr", &iter));
336       int num_seen = 0;
337       while (true) {
338         const char *name;
339         const char *val;
340         size_t len;

________________________________________________________________________________________________________
*** CID 1221501:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 513 in StriperTestPP_RoundTripWriteFullPP_Test::TestBody()()
507       AioCompletion *my_completion = librados::Rados::aio_create_completion
508         ((void*)&test_data, set_completion_complete, set_completion_safe);
509       char buf[128];
510       memset(buf, 0xcc, sizeof(buf));
511       bufferlist bl1;
512       bl1.append(buf, sizeof(buf));
>>>     CID 1221501:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
513       ASSERT_EQ(0, striper.aio_write("RoundTripWriteFullPP", my_completion, bl1, sizeof(buf), 0));
514       {
515         TestAlarm alarm;
516         my_completion->wait_for_complete();
517       }
518       char buf2[64];

________________________________________________________________________________________________________
*** CID 1221502:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 537 in StriperTestPP_RoundTripWriteFullPP_Test::TestBody()()
531         ((void*)&test_data, set_completion_complete, set_completion_safe);
532       ASSERT_EQ(0, striper.aio_read("RoundTripWriteFullPP", my_completion3, &bl3, sizeof(buf), 0));
533       {
534         TestAlarm alarm;
535         my_completion3->wait_for_complete();
536       }
>>>     CID 1221502:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion3" going out of scope leaks the storage it points to.
537       ASSERT_EQ(sizeof(buf2), my_completion3->get_return_value());
538       ASSERT_EQ(0, memcmp(bl3.c_str(), buf2, sizeof(buf2)));
539       my_completion->release();
540       my_completion2->release();
541       my_completion3->release();
/test/libradosstriper/aio.cc: 538 in StriperTestPP_RoundTripWriteFullPP_Test::TestBody()()
532       ASSERT_EQ(0, striper.aio_read("RoundTripWriteFullPP", my_completion3, &bl3, sizeof(buf), 0));
533       {
534         TestAlarm alarm;
535         my_completion3->wait_for_complete();
536       }
537       ASSERT_EQ(sizeof(buf2), my_completion3->get_return_value());
>>>     CID 1221502:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion3" going out of scope leaks the storage it points to.
538       ASSERT_EQ(0, memcmp(bl3.c_str(), buf2, sizeof(buf2)));
539       my_completion->release();
540       my_completion2->release();
541       my_completion3->release();
/test/libradosstriper/aio.cc: 532 in StriperTestPP_RoundTripWriteFullPP_Test::TestBody()()
526         TestAlarm alarm;
527         my_completion2->wait_for_complete();
528       }
529       bufferlist bl3;
530       AioCompletion *my_completion3 = librados::Rados::aio_create_completion
531         ((void*)&test_data, set_completion_complete, set_completion_safe);
>>>     CID 1221502:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion3" going out of scope leaks the storage it points to.
532       ASSERT_EQ(0, striper.aio_read("RoundTripWriteFullPP", my_completion3, &bl3, sizeof(buf), 0));
533       {
534         TestAlarm alarm;
535         my_completion3->wait_for_complete();
536       }
537       ASSERT_EQ(sizeof(buf2), my_completion3->get_return_value());

________________________________________________________________________________________________________
*** CID 1221503:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 440 in StriperTest_Flush_Test::TestBody()()
434                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
435       ASSERT_EQ(0, rados_striper_aio_read(striper, "Flush", my_completion2, buf2, sizeof(buf2), 0));
436       {
437         TestAlarm alarm;
438         rados_aio_wait_for_complete(my_completion2);
439       }
>>>     CID 1221503:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
440       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
441       rados_aio_release(my_completion);
442       rados_aio_release(my_completion2);
443     }
444     
445     TEST_F(StriperTestPP, FlushPP) {
/test/libradosstriper/aio.cc: 435 in StriperTest_Flush_Test::TestBody()()
429       rados_striper_aio_flush(striper);
430       char buf2[128];
431       memset(buf2, 0, sizeof(buf2));
432       rados_completion_t my_completion2;
433       ASSERT_EQ(0, rados_aio_create_completion
434                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
>>>     CID 1221503:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
435       ASSERT_EQ(0, rados_striper_aio_read(striper, "Flush", my_completion2, buf2, sizeof(buf2), 0));
436       {
437         TestAlarm alarm;
438         rados_aio_wait_for_complete(my_completion2);
439       }
440       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
/test/libradosstriper/aio.cc: 433 in StriperTest_Flush_Test::TestBody()()
427       memset(buf, 0xee, sizeof(buf));
428       ASSERT_EQ(0, rados_striper_aio_write(striper, "Flush", my_completion, buf, sizeof(buf), 0));
429       rados_striper_aio_flush(striper);
430       char buf2[128];
431       memset(buf2, 0, sizeof(buf2));
432       rados_completion_t my_completion2;
>>>     CID 1221503:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
433       ASSERT_EQ(0, rados_aio_create_completion
434                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
435       ASSERT_EQ(0, rados_striper_aio_read(striper, "Flush", my_completion2, buf2, sizeof(buf2), 0));
436       {
437         TestAlarm alarm;
438         rados_aio_wait_for_complete(my_completion2);

________________________________________________________________________________________________________
*** CID 1221504:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 428 in StriperTest_Flush_Test::TestBody()()
422       AioTestData test_data;
423       rados_completion_t my_completion;
424       ASSERT_EQ(0, rados_aio_create_completion
425                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion));
426       char buf[128];
427       memset(buf, 0xee, sizeof(buf));
>>>     CID 1221504:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
428       ASSERT_EQ(0, rados_striper_aio_write(striper, "Flush", my_completion, buf, sizeof(buf), 0));
429       rados_striper_aio_flush(striper);
430       char buf2[128];
431       memset(buf2, 0, sizeof(buf2));
432       rados_completion_t my_completion2;
433       ASSERT_EQ(0, rados_aio_create_completion
/test/libradosstriper/aio.cc: 433 in StriperTest_Flush_Test::TestBody()()
427       memset(buf, 0xee, sizeof(buf));
428       ASSERT_EQ(0, rados_striper_aio_write(striper, "Flush", my_completion, buf, sizeof(buf), 0));
429       rados_striper_aio_flush(striper);
430       char buf2[128];
431       memset(buf2, 0, sizeof(buf2));
432       rados_completion_t my_completion2;
>>>     CID 1221504:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
433       ASSERT_EQ(0, rados_aio_create_completion
434                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
435       ASSERT_EQ(0, rados_striper_aio_read(striper, "Flush", my_completion2, buf2, sizeof(buf2), 0));
436       {
437         TestAlarm alarm;
438         rados_aio_wait_for_complete(my_completion2);
/test/libradosstriper/aio.cc: 435 in StriperTest_Flush_Test::TestBody()()
429       rados_striper_aio_flush(striper);
430       char buf2[128];
431       memset(buf2, 0, sizeof(buf2));
432       rados_completion_t my_completion2;
433       ASSERT_EQ(0, rados_aio_create_completion
434                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
>>>     CID 1221504:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
435       ASSERT_EQ(0, rados_striper_aio_read(striper, "Flush", my_completion2, buf2, sizeof(buf2), 0));
436       {
437         TestAlarm alarm;
438         rados_aio_wait_for_complete(my_completion2);
439       }
440       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
/test/libradosstriper/aio.cc: 440 in StriperTest_Flush_Test::TestBody()()
434                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
435       ASSERT_EQ(0, rados_striper_aio_read(striper, "Flush", my_completion2, buf2, sizeof(buf2), 0));
436       {
437         TestAlarm alarm;
438         rados_aio_wait_for_complete(my_completion2);
439       }
>>>     CID 1221504:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
440       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
441       rados_aio_release(my_completion);
442       rados_aio_release(my_completion2);
443     }
444     
445     TEST_F(StriperTestPP, FlushPP) {
/test/libradosstriper/aio.cc: 424 in StriperTest_Flush_Test::TestBody()()
418       my_completion3->release();
419     }
420     
421     TEST_F(StriperTest, Flush) {
422       AioTestData test_data;
423       rados_completion_t my_completion;
>>>     CID 1221504:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
424       ASSERT_EQ(0, rados_aio_create_completion
425                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion));
426       char buf[128];
427       memset(buf, 0xee, sizeof(buf));
428       ASSERT_EQ(0, rados_striper_aio_write(striper, "Flush", my_completion, buf, sizeof(buf), 0));
429       rados_striper_aio_flush(striper);

________________________________________________________________________________________________________
*** CID 1221505:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 306 in StriperTest_IsSafe_Test::TestBody()()
300                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
301       ASSERT_EQ(0, rados_striper_aio_read(striper, "IsSafe", my_completion2, buf2, sizeof(buf2), 0));
302       {
303         TestAlarm alarm;
304         rados_aio_wait_for_complete(my_completion2);
305       }
>>>     CID 1221505:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
306       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
307       rados_aio_release(my_completion);
308       rados_aio_release(my_completion2);
309     }
310     
311     TEST_F(StriperTestPP, IsSafePP) {
/test/libradosstriper/aio.cc: 301 in StriperTest_IsSafe_Test::TestBody()()
295       }
296       char buf2[128];
297       memset(buf2, 0, sizeof(buf2));
298       rados_completion_t my_completion2;
299       ASSERT_EQ(0, rados_aio_create_completion
300                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
>>>     CID 1221505:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
301       ASSERT_EQ(0, rados_striper_aio_read(striper, "IsSafe", my_completion2, buf2, sizeof(buf2), 0));
302       {
303         TestAlarm alarm;
304         rados_aio_wait_for_complete(my_completion2);
305       }
306       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
/test/libradosstriper/aio.cc: 299 in StriperTest_IsSafe_Test::TestBody()()
293     	break;
294         }
295       }
296       char buf2[128];
297       memset(buf2, 0, sizeof(buf2));
298       rados_completion_t my_completion2;
>>>     CID 1221505:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
299       ASSERT_EQ(0, rados_aio_create_completion
300                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
301       ASSERT_EQ(0, rados_striper_aio_read(striper, "IsSafe", my_completion2, buf2, sizeof(buf2), 0));
302       {
303         TestAlarm alarm;
304         rados_aio_wait_for_complete(my_completion2);

________________________________________________________________________________________________________
*** CID 1221506:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 299 in StriperTest_IsSafe_Test::TestBody()()
293     	break;
294         }
295       }
296       char buf2[128];
297       memset(buf2, 0, sizeof(buf2));
298       rados_completion_t my_completion2;
>>>     CID 1221506:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
299       ASSERT_EQ(0, rados_aio_create_completion
300                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
301       ASSERT_EQ(0, rados_striper_aio_read(striper, "IsSafe", my_completion2, buf2, sizeof(buf2), 0));
302       {
303         TestAlarm alarm;
304         rados_aio_wait_for_complete(my_completion2);
/test/libradosstriper/aio.cc: 301 in StriperTest_IsSafe_Test::TestBody()()
295       }
296       char buf2[128];
297       memset(buf2, 0, sizeof(buf2));
298       rados_completion_t my_completion2;
299       ASSERT_EQ(0, rados_aio_create_completion
300                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
>>>     CID 1221506:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
301       ASSERT_EQ(0, rados_striper_aio_read(striper, "IsSafe", my_completion2, buf2, sizeof(buf2), 0));
302       {
303         TestAlarm alarm;
304         rados_aio_wait_for_complete(my_completion2);
305       }
306       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
/test/libradosstriper/aio.cc: 306 in StriperTest_IsSafe_Test::TestBody()()
300                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
301       ASSERT_EQ(0, rados_striper_aio_read(striper, "IsSafe", my_completion2, buf2, sizeof(buf2), 0));
302       {
303         TestAlarm alarm;
304         rados_aio_wait_for_complete(my_completion2);
305       }
>>>     CID 1221506:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
306       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
307       rados_aio_release(my_completion);
308       rados_aio_release(my_completion2);
309     }
310     
311     TEST_F(StriperTestPP, IsSafePP) {
/test/libradosstriper/aio.cc: 285 in StriperTest_IsSafe_Test::TestBody()()
279       AioTestData test_data;
280       rados_completion_t my_completion;
281       ASSERT_EQ(0, rados_aio_create_completion
282                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion));
283       char buf[128];
284       memset(buf, 0xcc, sizeof(buf));
>>>     CID 1221506:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
285       ASSERT_EQ(0, rados_striper_aio_write(striper, "IsSafe", my_completion, buf, sizeof(buf), 0));
286       {
287         TestAlarm alarm;
288         // Busy-wait until the AIO completes.
289         // Normally we wouldn't do this, but we want to test rados_aio_is_safe.
290         while (true) {
/test/libradosstriper/aio.cc: 281 in StriperTest_IsSafe_Test::TestBody()()
275       my_completion2->release();
276     }
277     
278     TEST_F(StriperTest, IsSafe) {
279       AioTestData test_data;
280       rados_completion_t my_completion;
>>>     CID 1221506:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
281       ASSERT_EQ(0, rados_aio_create_completion
282                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion));
283       char buf[128];
284       memset(buf, 0xcc, sizeof(buf));
285       ASSERT_EQ(0, rados_striper_aio_write(striper, "IsSafe", my_completion, buf, sizeof(buf), 0));
286       {

________________________________________________________________________________________________________
*** CID 1221507:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 453 in StriperTestPP_FlushPP_Test::TestBody()()
447       AioCompletion *my_completion = librados::Rados::aio_create_completion
448         ((void*)&test_data, set_completion_complete, set_completion_safe);
449       char buf[128];
450       memset(buf, 0xee, sizeof(buf));
451       bufferlist bl1;
452       bl1.append(buf, sizeof(buf));
>>>     CID 1221507:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
453       ASSERT_EQ(0, striper.aio_write("FlushPP", my_completion, bl1, sizeof(buf), 0));
454       striper.aio_flush();
455       bufferlist bl2;
456       AioCompletion *my_completion2 = librados::Rados::aio_create_completion
457         ((void*)&test_data, set_completion_complete, set_completion_safe);
458       ASSERT_EQ(0, striper.aio_read("FlushPP", my_completion2, &bl2, sizeof(buf), 0));
/test/libradosstriper/aio.cc: 458 in StriperTestPP_FlushPP_Test::TestBody()()
452       bl1.append(buf, sizeof(buf));
453       ASSERT_EQ(0, striper.aio_write("FlushPP", my_completion, bl1, sizeof(buf), 0));
454       striper.aio_flush();
455       bufferlist bl2;
456       AioCompletion *my_completion2 = librados::Rados::aio_create_completion
457         ((void*)&test_data, set_completion_complete, set_completion_safe);
>>>     CID 1221507:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
458       ASSERT_EQ(0, striper.aio_read("FlushPP", my_completion2, &bl2, sizeof(buf), 0));
459       {
460         TestAlarm alarm;
461         my_completion2->wait_for_complete();
462       }
463       ASSERT_EQ(0, memcmp(buf, bl2.c_str(), sizeof(buf)));
/test/libradosstriper/aio.cc: 463 in StriperTestPP_FlushPP_Test::TestBody()()
457         ((void*)&test_data, set_completion_complete, set_completion_safe);
458       ASSERT_EQ(0, striper.aio_read("FlushPP", my_completion2, &bl2, sizeof(buf), 0));
459       {
460         TestAlarm alarm;
461         my_completion2->wait_for_complete();
462       }
>>>     CID 1221507:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
463       ASSERT_EQ(0, memcmp(buf, bl2.c_str(), sizeof(buf)));
464       my_completion->release();
465       my_completion2->release();
466     }
467     
468     TEST_F(StriperTest, RoundTripWriteFull) {

________________________________________________________________________________________________________
*** CID 1221508:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 463 in StriperTestPP_FlushPP_Test::TestBody()()
457         ((void*)&test_data, set_completion_complete, set_completion_safe);
458       ASSERT_EQ(0, striper.aio_read("FlushPP", my_completion2, &bl2, sizeof(buf), 0));
459       {
460         TestAlarm alarm;
461         my_completion2->wait_for_complete();
462       }
>>>     CID 1221508:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
463       ASSERT_EQ(0, memcmp(buf, bl2.c_str(), sizeof(buf)));
464       my_completion->release();
465       my_completion2->release();
466     }
467     
468     TEST_F(StriperTest, RoundTripWriteFull) {
/test/libradosstriper/aio.cc: 458 in StriperTestPP_FlushPP_Test::TestBody()()
452       bl1.append(buf, sizeof(buf));
453       ASSERT_EQ(0, striper.aio_write("FlushPP", my_completion, bl1, sizeof(buf), 0));
454       striper.aio_flush();
455       bufferlist bl2;
456       AioCompletion *my_completion2 = librados::Rados::aio_create_completion
457         ((void*)&test_data, set_completion_complete, set_completion_safe);
>>>     CID 1221508:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
458       ASSERT_EQ(0, striper.aio_read("FlushPP", my_completion2, &bl2, sizeof(buf), 0));
459       {
460         TestAlarm alarm;
461         my_completion2->wait_for_complete();
462       }
463       ASSERT_EQ(0, memcmp(buf, bl2.c_str(), sizeof(buf)));

________________________________________________________________________________________________________
*** CID 1221509:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 124 in StriperTest_RoundTrip_Test::TestBody()()
118                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
119       ASSERT_EQ(0, rados_striper_aio_read(striper, "RoundTrip", my_completion2, buf2, sizeof(buf2), 0));
120       {
121         TestAlarm alarm;
122         rados_aio_wait_for_complete(my_completion2);
123       }
>>>     CID 1221509:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
124       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
125       rados_aio_release(my_completion);
126       rados_aio_release(my_completion2);
127     }
128     
129     TEST_F(StriperTest, RoundTrip2) {
/test/libradosstriper/aio.cc: 119 in StriperTest_RoundTrip_Test::TestBody()()
113       }
114       char buf2[128];
115       memset(buf2, 0, sizeof(buf2));
116       rados_completion_t my_completion2;
117       ASSERT_EQ(0, rados_aio_create_completion
118                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
>>>     CID 1221509:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
119       ASSERT_EQ(0, rados_striper_aio_read(striper, "RoundTrip", my_completion2, buf2, sizeof(buf2), 0));
120       {
121         TestAlarm alarm;
122         rados_aio_wait_for_complete(my_completion2);
123       }
124       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
/test/libradosstriper/aio.cc: 117 in StriperTest_RoundTrip_Test::TestBody()()
111         sem_wait(&test_data.m_sem);
112         sem_wait(&test_data.m_sem);
113       }
114       char buf2[128];
115       memset(buf2, 0, sizeof(buf2));
116       rados_completion_t my_completion2;
>>>     CID 1221509:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
117       ASSERT_EQ(0, rados_aio_create_completion
118                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
119       ASSERT_EQ(0, rados_striper_aio_read(striper, "RoundTrip", my_completion2, buf2, sizeof(buf2), 0));
120       {
121         TestAlarm alarm;
122         rados_aio_wait_for_complete(my_completion2);

________________________________________________________________________________________________________
*** CID 1221510:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 108 in StriperTest_RoundTrip_Test::TestBody()()
102       AioTestData test_data;
103       rados_completion_t my_completion;
104       ASSERT_EQ(0, rados_aio_create_completion
105                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion));
106       char buf[128];
107       memset(buf, 0xcc, sizeof(buf));
>>>     CID 1221510:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
108       ASSERT_EQ(0, rados_striper_aio_write(striper, "RoundTrip", my_completion, buf, sizeof(buf), 0));
109       {
110         TestAlarm alarm;
111         sem_wait(&test_data.m_sem);
112         sem_wait(&test_data.m_sem);
113       }
/test/libradosstriper/aio.cc: 117 in StriperTest_RoundTrip_Test::TestBody()()
111         sem_wait(&test_data.m_sem);
112         sem_wait(&test_data.m_sem);
113       }
114       char buf2[128];
115       memset(buf2, 0, sizeof(buf2));
116       rados_completion_t my_completion2;
>>>     CID 1221510:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
117       ASSERT_EQ(0, rados_aio_create_completion
118                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
119       ASSERT_EQ(0, rados_striper_aio_read(striper, "RoundTrip", my_completion2, buf2, sizeof(buf2), 0));
120       {
121         TestAlarm alarm;
122         rados_aio_wait_for_complete(my_completion2);
/test/libradosstriper/aio.cc: 119 in StriperTest_RoundTrip_Test::TestBody()()
113       }
114       char buf2[128];
115       memset(buf2, 0, sizeof(buf2));
116       rados_completion_t my_completion2;
117       ASSERT_EQ(0, rados_aio_create_completion
118                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
>>>     CID 1221510:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
119       ASSERT_EQ(0, rados_striper_aio_read(striper, "RoundTrip", my_completion2, buf2, sizeof(buf2), 0));
120       {
121         TestAlarm alarm;
122         rados_aio_wait_for_complete(my_completion2);
123       }
124       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
/test/libradosstriper/aio.cc: 124 in StriperTest_RoundTrip_Test::TestBody()()
118                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
119       ASSERT_EQ(0, rados_striper_aio_read(striper, "RoundTrip", my_completion2, buf2, sizeof(buf2), 0));
120       {
121         TestAlarm alarm;
122         rados_aio_wait_for_complete(my_completion2);
123       }
>>>     CID 1221510:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
124       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
125       rados_aio_release(my_completion);
126       rados_aio_release(my_completion2);
127     }
128     
129     TEST_F(StriperTest, RoundTrip2) {
/test/libradosstriper/aio.cc: 104 in StriperTest_RoundTrip_Test::TestBody()()
98       my_completion->release();
99     }
100     
101     TEST_F(StriperTest, RoundTrip) {
102       AioTestData test_data;
103       rados_completion_t my_completion;
>>>     CID 1221510:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
104       ASSERT_EQ(0, rados_aio_create_completion
105                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion));
106       char buf[128];
107       memset(buf, 0xcc, sizeof(buf));
108       ASSERT_EQ(0, rados_striper_aio_write(striper, "RoundTrip", my_completion, buf, sizeof(buf), 0));
109       {

________________________________________________________________________________________________________
*** CID 1221511:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 333 in StriperTestPP_IsSafePP_Test::TestBody()()
327     	break;
328         }
329       }
330       bufferlist bl2;
331       AioCompletion *my_completion2 = librados::Rados::aio_create_completion
332         ((void*)&test_data, set_completion_complete, set_completion_safe);
>>>     CID 1221511:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
333       ASSERT_EQ(0, striper.aio_read("IsSafePP", my_completion2, &bl2, sizeof(buf), 0));
334       {
335         TestAlarm alarm;
336         my_completion2->wait_for_complete();
337       }
338       ASSERT_EQ(0, memcmp(buf, bl2.c_str(), sizeof(buf)));
/test/libradosstriper/aio.cc: 338 in StriperTestPP_IsSafePP_Test::TestBody()()
332         ((void*)&test_data, set_completion_complete, set_completion_safe);
333       ASSERT_EQ(0, striper.aio_read("IsSafePP", my_completion2, &bl2, sizeof(buf), 0));
334       {
335         TestAlarm alarm;
336         my_completion2->wait_for_complete();
337       }
>>>     CID 1221511:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
338       ASSERT_EQ(0, memcmp(buf, bl2.c_str(), sizeof(buf)));
339       my_completion->release();
340       my_completion2->release();
341     }
342     
343     TEST_F(StriperTest, RoundTripAppend) {
/test/libradosstriper/aio.cc: 319 in StriperTestPP_IsSafePP_Test::TestBody()()
313       AioCompletion *my_completion = librados::Rados::aio_create_completion
314         ((void*)&test_data, set_completion_complete, set_completion_safe);
315       char buf[128];
316       memset(buf, 0xcc, sizeof(buf));
317       bufferlist bl1;
318       bl1.append(buf, sizeof(buf));
>>>     CID 1221511:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
319       ASSERT_EQ(0, striper.aio_write("IsSafePP", my_completion, bl1, sizeof(buf), 0));
320       {
321         TestAlarm alarm;
322         // Busy-wait until the AIO completes.
323         // Normally we wouldn't do this, but we want to test rados_aio_is_safe.
324         while (true) {

________________________________________________________________________________________________________
*** CID 1221512:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 338 in StriperTestPP_IsSafePP_Test::TestBody()()
332         ((void*)&test_data, set_completion_complete, set_completion_safe);
333       ASSERT_EQ(0, striper.aio_read("IsSafePP", my_completion2, &bl2, sizeof(buf), 0));
334       {
335         TestAlarm alarm;
336         my_completion2->wait_for_complete();
337       }
>>>     CID 1221512:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
338       ASSERT_EQ(0, memcmp(buf, bl2.c_str(), sizeof(buf)));
339       my_completion->release();
340       my_completion2->release();
341     }
342     
343     TEST_F(StriperTest, RoundTripAppend) {
/test/libradosstriper/aio.cc: 333 in StriperTestPP_IsSafePP_Test::TestBody()()
327     	break;
328         }
329       }
330       bufferlist bl2;
331       AioCompletion *my_completion2 = librados::Rados::aio_create_completion
332         ((void*)&test_data, set_completion_complete, set_completion_safe);
>>>     CID 1221512:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
333       ASSERT_EQ(0, striper.aio_read("IsSafePP", my_completion2, &bl2, sizeof(buf), 0));
334       {
335         TestAlarm alarm;
336         my_completion2->wait_for_complete();
337       }
338       ASSERT_EQ(0, memcmp(buf, bl2.c_str(), sizeof(buf)));

________________________________________________________________________________________________________
*** CID 1221513:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 240 in StriperTest_IsComplete_Test::TestBody()()
234         while (true) {
235           int is_complete = rados_aio_is_complete(my_completion2);
236           if (is_complete)
237     	break;
238         }
239       }
>>>     CID 1221513:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
240       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
241       rados_aio_release(my_completion);
242       rados_aio_release(my_completion2);
243     }
244     
245     TEST_F(StriperTestPP, IsCompletePP) {
/test/libradosstriper/aio.cc: 229 in StriperTest_IsComplete_Test::TestBody()()
223       }
224       char buf2[128];
225       memset(buf2, 0, sizeof(buf2));
226       rados_completion_t my_completion2;
227       ASSERT_EQ(0, rados_aio_create_completion
228                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
>>>     CID 1221513:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
229       ASSERT_EQ(0, rados_striper_aio_read(striper, "IsComplete", my_completion2, buf2, sizeof(buf2), 0));
230       {
231         TestAlarm alarm;
232         // Busy-wait until the AIO completes.
233         // Normally we wouldn't do this, but we want to test rados_aio_is_complete.
234         while (true) {
/test/libradosstriper/aio.cc: 227 in StriperTest_IsComplete_Test::TestBody()()
221         sem_wait(&test_data.m_sem);
222         sem_wait(&test_data.m_sem);
223       }
224       char buf2[128];
225       memset(buf2, 0, sizeof(buf2));
226       rados_completion_t my_completion2;
>>>     CID 1221513:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
227       ASSERT_EQ(0, rados_aio_create_completion
228                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
229       ASSERT_EQ(0, rados_striper_aio_read(striper, "IsComplete", my_completion2, buf2, sizeof(buf2), 0));
230       {
231         TestAlarm alarm;
232         // Busy-wait until the AIO completes.

________________________________________________________________________________________________________
*** CID 1221514:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 218 in StriperTest_IsComplete_Test::TestBody()()
212       AioTestData test_data;
213       rados_completion_t my_completion;
214       ASSERT_EQ(0, rados_aio_create_completion
215                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion));
216       char buf[128];
217       memset(buf, 0xcc, sizeof(buf));
>>>     CID 1221514:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
218       ASSERT_EQ(0, rados_striper_aio_write(striper, "IsComplete", my_completion, buf, sizeof(buf), 0));
219       {
220         TestAlarm alarm;
221         sem_wait(&test_data.m_sem);
222         sem_wait(&test_data.m_sem);
223       }
/test/libradosstriper/aio.cc: 227 in StriperTest_IsComplete_Test::TestBody()()
221         sem_wait(&test_data.m_sem);
222         sem_wait(&test_data.m_sem);
223       }
224       char buf2[128];
225       memset(buf2, 0, sizeof(buf2));
226       rados_completion_t my_completion2;
>>>     CID 1221514:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
227       ASSERT_EQ(0, rados_aio_create_completion
228                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
229       ASSERT_EQ(0, rados_striper_aio_read(striper, "IsComplete", my_completion2, buf2, sizeof(buf2), 0));
230       {
231         TestAlarm alarm;
232         // Busy-wait until the AIO completes.
/test/libradosstriper/aio.cc: 229 in StriperTest_IsComplete_Test::TestBody()()
223       }
224       char buf2[128];
225       memset(buf2, 0, sizeof(buf2));
226       rados_completion_t my_completion2;
227       ASSERT_EQ(0, rados_aio_create_completion
228                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
>>>     CID 1221514:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
229       ASSERT_EQ(0, rados_striper_aio_read(striper, "IsComplete", my_completion2, buf2, sizeof(buf2), 0));
230       {
231         TestAlarm alarm;
232         // Busy-wait until the AIO completes.
233         // Normally we wouldn't do this, but we want to test rados_aio_is_complete.
234         while (true) {
/test/libradosstriper/aio.cc: 240 in StriperTest_IsComplete_Test::TestBody()()
234         while (true) {
235           int is_complete = rados_aio_is_complete(my_completion2);
236           if (is_complete)
237     	break;
238         }
239       }
>>>     CID 1221514:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
240       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
241       rados_aio_release(my_completion);
242       rados_aio_release(my_completion2);
243     }
244     
245     TEST_F(StriperTestPP, IsCompletePP) {
/test/libradosstriper/aio.cc: 214 in StriperTest_IsComplete_Test::TestBody()()
208       my_completion2->release();
209     }
210     
211     TEST_F(StriperTest, IsComplete) {
212       AioTestData test_data;
213       rados_completion_t my_completion;
>>>     CID 1221514:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
214       ASSERT_EQ(0, rados_aio_create_completion
215                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion));
216       char buf[128];
217       memset(buf, 0xcc, sizeof(buf));
218       ASSERT_EQ(0, rados_striper_aio_write(striper, "IsComplete", my_completion, buf, sizeof(buf), 0));
219       {

________________________________________________________________________________________________________
*** CID 1221515:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 152 in StriperTest_RoundTrip2_Test::TestBody()()
146                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
147       ASSERT_EQ(0, rados_striper_aio_read(striper, "RoundTrip2", my_completion2, buf2, sizeof(buf2), 0));
148       {
149         TestAlarm alarm;
150         rados_aio_wait_for_safe(my_completion2);
151       }
>>>     CID 1221515:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
152       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
153       rados_aio_release(my_completion);
154       rados_aio_release(my_completion2);
155     }
156     
157     TEST_F(StriperTestPP, RoundTripPP) {
/test/libradosstriper/aio.cc: 147 in StriperTest_RoundTrip2_Test::TestBody()()
141       }
142       char buf2[128];
143       memset(buf2, 0, sizeof(buf2));
144       rados_completion_t my_completion2;
145       ASSERT_EQ(0, rados_aio_create_completion
146                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
>>>     CID 1221515:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
147       ASSERT_EQ(0, rados_striper_aio_read(striper, "RoundTrip2", my_completion2, buf2, sizeof(buf2), 0));
148       {
149         TestAlarm alarm;
150         rados_aio_wait_for_safe(my_completion2);
151       }
152       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
/test/libradosstriper/aio.cc: 145 in StriperTest_RoundTrip2_Test::TestBody()()
139         sem_wait(&test_data.m_sem);
140         sem_wait(&test_data.m_sem);
141       }
142       char buf2[128];
143       memset(buf2, 0, sizeof(buf2));
144       rados_completion_t my_completion2;
>>>     CID 1221515:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion2" going out of scope leaks the storage it points to.
145       ASSERT_EQ(0, rados_aio_create_completion
146                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
147       ASSERT_EQ(0, rados_striper_aio_read(striper, "RoundTrip2", my_completion2, buf2, sizeof(buf2), 0));
148       {
149         TestAlarm alarm;
150         rados_aio_wait_for_safe(my_completion2);

________________________________________________________________________________________________________
*** CID 1221516:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 136 in StriperTest_RoundTrip2_Test::TestBody()()
130       AioTestData test_data;
131       rados_completion_t my_completion;
132       ASSERT_EQ(0, rados_aio_create_completion
133                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion));
134       char buf[128];
135       memset(buf, 0xcc, sizeof(buf));
>>>     CID 1221516:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
136       ASSERT_EQ(0, rados_striper_aio_write(striper, "RoundTrip2", my_completion, buf, sizeof(buf), 0));
137       {
138         TestAlarm alarm;
139         sem_wait(&test_data.m_sem);
140         sem_wait(&test_data.m_sem);
141       }
/test/libradosstriper/aio.cc: 145 in StriperTest_RoundTrip2_Test::TestBody()()
139         sem_wait(&test_data.m_sem);
140         sem_wait(&test_data.m_sem);
141       }
142       char buf2[128];
143       memset(buf2, 0, sizeof(buf2));
144       rados_completion_t my_completion2;
>>>     CID 1221516:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
145       ASSERT_EQ(0, rados_aio_create_completion
146                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
147       ASSERT_EQ(0, rados_striper_aio_read(striper, "RoundTrip2", my_completion2, buf2, sizeof(buf2), 0));
148       {
149         TestAlarm alarm;
150         rados_aio_wait_for_safe(my_completion2);
/test/libradosstriper/aio.cc: 147 in StriperTest_RoundTrip2_Test::TestBody()()
141       }
142       char buf2[128];
143       memset(buf2, 0, sizeof(buf2));
144       rados_completion_t my_completion2;
145       ASSERT_EQ(0, rados_aio_create_completion
146                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
>>>     CID 1221516:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
147       ASSERT_EQ(0, rados_striper_aio_read(striper, "RoundTrip2", my_completion2, buf2, sizeof(buf2), 0));
148       {
149         TestAlarm alarm;
150         rados_aio_wait_for_safe(my_completion2);
151       }
152       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
/test/libradosstriper/aio.cc: 152 in StriperTest_RoundTrip2_Test::TestBody()()
146                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion2));
147       ASSERT_EQ(0, rados_striper_aio_read(striper, "RoundTrip2", my_completion2, buf2, sizeof(buf2), 0));
148       {
149         TestAlarm alarm;
150         rados_aio_wait_for_safe(my_completion2);
151       }
>>>     CID 1221516:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
152       ASSERT_EQ(0, memcmp(buf, buf2, sizeof(buf)));
153       rados_aio_release(my_completion);
154       rados_aio_release(my_completion2);
155     }
156     
157     TEST_F(StriperTestPP, RoundTripPP) {
/test/libradosstriper/aio.cc: 132 in StriperTest_RoundTrip2_Test::TestBody()()
126       rados_aio_release(my_completion2);
127     }
128     
129     TEST_F(StriperTest, RoundTrip2) {
130       AioTestData test_data;
131       rados_completion_t my_completion;
>>>     CID 1221516:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
132       ASSERT_EQ(0, rados_aio_create_completion
133                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion));
134       char buf[128];
135       memset(buf, 0xcc, sizeof(buf));
136       ASSERT_EQ(0, rados_striper_aio_write(striper, "RoundTrip2", my_completion, buf, sizeof(buf), 0));
137       {

________________________________________________________________________________________________________
*** CID 1221517:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/aio.cc: 52 in StriperTest_SimpleWrite_Test::TestBody()()
46       AioTestData test_data;
47       rados_completion_t my_completion;
48       ASSERT_EQ(0, rados_aio_create_completion
49                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion));
50       char buf[128];
51       memset(buf, 0xcc, sizeof(buf));
>>>     CID 1221517:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
52       ASSERT_EQ(0, rados_striper_aio_write(striper, "StriperTest", my_completion, buf, sizeof(buf), 0));
53       TestAlarm alarm;
54       sem_wait(&test_data.m_sem);
55       sem_wait(&test_data.m_sem);
56       rados_aio_release(my_completion);
57     }
/test/libradosstriper/aio.cc: 48 in StriperTest_SimpleWrite_Test::TestBody()()
42       sem_post(&test->m_sem);
43     }
44     
45     TEST_F(StriperTest, SimpleWrite) {
46       AioTestData test_data;
47       rados_completion_t my_completion;
>>>     CID 1221517:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
48       ASSERT_EQ(0, rados_aio_create_completion
49                 ((void*)&test_data, set_completion_complete, set_completion_safe, &my_completion));
50       char buf[128];
51       memset(buf, 0xcc, sizeof(buf));
52       ASSERT_EQ(0, rados_striper_aio_write(striper, "StriperTest", my_completion, buf, sizeof(buf), 0));
53       TestAlarm alarm;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-298666001-1402157531=:11424--
