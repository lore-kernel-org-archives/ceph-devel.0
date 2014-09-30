From: Sage Weil <sweil@redhat.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Tue, 30 Sep 2014 06:59:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409300658510.6593@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1891662852-1412085542=:6593"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53723 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbaI3N7g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 09:59:36 -0400
Content-ID: <alpine.DEB.2.00.1409300659070.6593@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: greg@inktank.com, loic@dachary.org
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1891662852-1412085542=:6593
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1409300659071.6593@cobra.newdream.net>

Looks like recent changes from Greg, Loic, and I.
--557981400-1891662852-1412085542=:6593
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1409300658520.6593@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: INLINE

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 02E398004B
	for <sage@cobra.newdream.net>; Tue, 30 Sep 2014 06:21:26 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id F35F4120EAA; Tue, 30 Sep 2014 06:21:25 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from alc-junkmail-backend3.dreamhost.com (caiajhbdcbae.dreamhost.com
	[208.97.132.104])
	by destro.newdream.net (Postfix) with ESMTP id F1B83120E82
	for <sage@newdream.net>; Tue, 30 Sep 2014 06:21:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by alc-junkmail-backend3.dreamhost.com (Postfix) with ESMTP id
	DEC7BA0C4F5
	for <sage@newdream.net>; Tue, 30 Sep 2014 06:21:25 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at alc-junkmail-backend3.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
Received: from godfather.dreamhost.com ([208.97.132.17])
	by localhost (alc-junkmail-backend3.dreamhost.com [208.97.132.104])
	(amavisd-new, port 10024)
	with ESMTP id Pp916bDsr5U0 for <sage@newdream.net>;
	Tue, 30 Sep 2014 06:21:25 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by godfather.dreamhost.com (Postfix) with ESMTP id 3DE4E1B01BF
	for <sage@newdream.net>; Tue, 30 Sep 2014 06:21:09 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Tue, 30 Sep 2014 06:21:19 -0700
Date: Tue, 30 Sep 2014 06:21:08 -0700
From: scan-admin@coverity.com
Message-ID: <542aae4497872_6695f0f3345816@scan.coverity.com.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2014 13:21:19.0679 (UTC)
	FILETIME=[6C078CF0:01CFDCB1]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 1242019:  Data race condition  (MISSING_LOCK)
/msg/Pipe.cc: 230 in Pipe::DelayedDelivery::entry()()

** CID 1242021:  Resource leak  (RESOURCE_LEAK)
/test/librados/tier.cc: 1026 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
/test/librados/tier.cc: 1022 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
/test/librados/tier.cc: 1040 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
/test/librados/tier.cc: 1037 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()

** CID 1242020:  Resource leak  (RESOURCE_LEAK)
/test/librados/aio.cc: 168 in LibRadosAio_TooBig_Test::TestBody()()

** CID 1242018:  Resource leak  (RESOURCE_LEAK)
/test/librados/aio.cc: 188 in LibRadosAio_TooBigPP_Test::TestBody()()
/test/librados/aio.cc: 190 in LibRadosAio_TooBigPP_Test::TestBody()()
/test/librados/aio.cc: 187 in LibRadosAio_TooBigPP_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1242019:  Data race condition  (MISSING_LOCK)
/msg/Pipe.cc: 230 in Pipe::DelayedDelivery::entry()()
224         if (flush_count > 0) {
225           --flush_count;
226           active_flush = true;
227         }
228         if (pipe->in_q->can_fast_dispatch(m)) {
229           if (!stop_fast_dispatching_flag) {
>>>     CID 1242019:  Data race condition  (MISSING_LOCK)
>>>     Accessing "this->delay_dispatching" without holding lock "Mutex._m". Elsewhere, "_ZN4Pipe15DelayedDeliveryE.delay_dispatching" is accessed with "Mutex._m" held 1 out of 2 times (1 of these accesses strongly imply that it is necessary).
230             delay_dispatching = true;
231             delay_lock.Unlock();
232             pipe->in_q->fast_dispatch(m);
233             delay_lock.Lock();
234             delay_dispatching = false;
235             if (stop_fast_dispatching_flag) {

________________________________________________________________________________________________________
*** CID 1242021:  Resource leak  (RESOURCE_LEAK)
/test/librados/tier.cc: 1026 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
1020         op.cache_evict();
1021         librados::AioCompletion *completion = cluster.aio_create_completion();
1022         ASSERT_EQ(0, cache_ioctx.aio_operate(
1023           "foo", completion, &op,
1024           librados::OPERATION_IGNORE_CACHE, NULL));
1025         completion->wait_for_safe();
>>>     CID 1242021:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
1026         ASSERT_EQ(0, completion->get_return_value());
1027         completion->release();
1028       }
1029     
1030       // verify the snapdir is not present in the cache pool
1031       {
/test/librados/tier.cc: 1022 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
1016     
1017       // evict
1018       {
1019         ObjectReadOperation op;
1020         op.cache_evict();
1021         librados::AioCompletion *completion = cluster.aio_create_completion();
>>>     CID 1242021:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
1022         ASSERT_EQ(0, cache_ioctx.aio_operate(
1023           "foo", completion, &op,
1024           librados::OPERATION_IGNORE_CACHE, NULL));
1025         completion->wait_for_safe();
1026         ASSERT_EQ(0, completion->get_return_value());
1027         completion->release();
/test/librados/tier.cc: 1040 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
1034         op.list_snaps(&snapset, NULL);
1035         ioctx.snap_set_read(librados::SNAP_DIR);
1036         librados::AioCompletion *completion = cluster.aio_create_completion();
1037         ASSERT_EQ(0, ioctx.aio_operate("foo", completion, &op,
1038     				   librados::OPERATION_IGNORE_CACHE, NULL));
1039         completion->wait_for_safe();
>>>     CID 1242021:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
1040         ASSERT_EQ(-ENOENT, completion->get_return_value());
1041         completion->release();
1042       }
1043     }
1044     
1045     TEST_F(LibRadosTwoPoolsPP, TryFlush) {
/test/librados/tier.cc: 1037 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
1031       {
1032         ObjectReadOperation op;
1033         librados::snap_set_t snapset;
1034         op.list_snaps(&snapset, NULL);
1035         ioctx.snap_set_read(librados::SNAP_DIR);
1036         librados::AioCompletion *completion = cluster.aio_create_completion();
>>>     CID 1242021:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
1037         ASSERT_EQ(0, ioctx.aio_operate("foo", completion, &op,
1038     				   librados::OPERATION_IGNORE_CACHE, NULL));
1039         completion->wait_for_safe();
1040         ASSERT_EQ(-ENOENT, completion->get_return_value());
1041         completion->release();
1042       }

________________________________________________________________________________________________________
*** CID 1242020:  Resource leak  (RESOURCE_LEAK)
/test/librados/aio.cc: 168 in LibRadosAio_TooBig_Test::TestBody()()
162     }
163     
164     TEST(LibRadosAio, TooBig) {
165       AioTestData test_data;
166       rados_completion_t my_completion;
167       ASSERT_EQ("", test_data.init());
>>>     CID 1242020:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
168       ASSERT_EQ(0, rados_aio_create_completion((void*)&test_data,
169     	      set_completion_complete, set_completion_safe, &my_completion));
170       char buf[128];
171       memset(buf, 0xcc, sizeof(buf));
172       ASSERT_EQ(-E2BIG, rados_aio_write(test_data.m_ioctx, "foo",
173                                         my_completion, buf, UINT_MAX, 0));

________________________________________________________________________________________________________
*** CID 1242018:  Resource leak  (RESOURCE_LEAK)
/test/librados/aio.cc: 188 in LibRadosAio_TooBigPP_Test::TestBody()()
182       ASSERT_EQ("", test_data.init());
183     
184       bufferlist bl;
185       AioCompletion *aio_completion = test_data.m_cluster.aio_create_completion(
186                                                                                 (void*)&test_data, NULL, NULL);
187       ASSERT_EQ(-E2BIG, test_data.m_ioctx.aio_write("foo", aio_completion, bl, UINT_MAX, 0));
>>>     CID 1242018:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "aio_completion" going out of scope leaks the storage it points to.
188       ASSERT_EQ(-E2BIG, test_data.m_ioctx.aio_append("foo", aio_completion, bl, UINT_MAX));
189       // ioctx.aio_write_full no way to overflow bl.length()
190     }
191     
192     TEST(LibRadosAio, SimpleWrite) {
193       AioTestData test_data;
/test/librados/aio.cc: 190 in LibRadosAio_TooBigPP_Test::TestBody()()
184       bufferlist bl;
185       AioCompletion *aio_completion = test_data.m_cluster.aio_create_completion(
186                                                                                 (void*)&test_data, NULL, NULL);
187       ASSERT_EQ(-E2BIG, test_data.m_ioctx.aio_write("foo", aio_completion, bl, UINT_MAX, 0));
188       ASSERT_EQ(-E2BIG, test_data.m_ioctx.aio_append("foo", aio_completion, bl, UINT_MAX));
189       // ioctx.aio_write_full no way to overflow bl.length()
>>>     CID 1242018:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "aio_completion" going out of scope leaks the storage it points to.
190     }
191     
192     TEST(LibRadosAio, SimpleWrite) {
193       AioTestData test_data;
194       rados_completion_t my_completion;
195       ASSERT_EQ("", test_data.init());
/test/librados/aio.cc: 187 in LibRadosAio_TooBigPP_Test::TestBody()()
181       AioTestDataPP test_data;
182       ASSERT_EQ("", test_data.init());
183     
184       bufferlist bl;
185       AioCompletion *aio_completion = test_data.m_cluster.aio_create_completion(
186                                                                                 (void*)&test_data, NULL, NULL);
>>>     CID 1242018:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "aio_completion" going out of scope leaks the storage it points to.
187       ASSERT_EQ(-E2BIG, test_data.m_ioctx.aio_write("foo", aio_completion, bl, UINT_MAX, 0));
188       ASSERT_EQ(-E2BIG, test_data.m_ioctx.aio_append("foo", aio_completion, bl, UINT_MAX));
189       // ioctx.aio_write_full no way to overflow bl.length()
190     }
191     
192     TEST(LibRadosAio, SimpleWrite) {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-1891662852-1412085542=:6593--
