From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Tue, 25 Nov 2014 06:09:30 -0800
Message-ID: <54748d9a843bb_604965d31c998a8@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:55977 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbaKYOJb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Nov 2014 09:09:31 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

5 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 5 of 5 defect(s)


** CID 1256098:  Resource leak  (RESOURCE_LEAK)
/test/librados/tier.cc: 2792 in LibRadosTwoPoolsECPP_Whiteout_Test::TestBody()()
/test/librados/tier.cc: 2789 in LibRadosTwoPoolsECPP_Whiteout_Test::TestBody()()

** CID 1256096:  Resource leak  (RESOURCE_LEAK)
/test/librados/TestCase.cc: 336 in RadosTestPP::cleanup_namespace(librados::IoCtx, std::basic_string<char, std::char_traits<char>, std::allocator<char>>)()
/test/librados/TestCase.cc: 333 in RadosTestPP::cleanup_namespace(librados::IoCtx, std::basic_string<char, std::char_traits<char>, std::allocator<char>>)()

** CID 1256097:  Resource leak  (RESOURCE_LEAK)
/test/librados/tier.cc: 648 in LibRadosTwoPoolsPP_Whiteout_Test::TestBody()()
/test/librados/tier.cc: 645 in LibRadosTwoPoolsPP_Whiteout_Test::TestBody()()

** CID 1256100:  Uninitialized pointer read  (UNINIT)
/librados/librados.cc: 4516 in librados::ListObject::ListObject(const librados::ListObject&)()

** CID 1256099:  Uninitialized pointer read  (UNINIT)
/librados/librados.cc: 650 in librados::NObjectIterator::NObjectIterator(const librados::NObjectIterator&)()


________________________________________________________________________________________________________
*** CID 1256098:  Resource leak  (RESOURCE_LEAK)
/test/librados/tier.cc: 2792 in LibRadosTwoPoolsECPP_Whiteout_Test::TestBody()()
2786         ObjectWriteOperation op;
2787         op.remove();
2788         librados::AioCompletion *completion = cluster.aio_create_completion();
2789         ASSERT_EQ(0, ioctx.aio_operate("bar", completion, &op,
2790     				   librados::OPERATION_IGNORE_CACHE));
2791         completion->wait_for_safe();
>>>     CID 1256098:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
2792         ASSERT_EQ(0, completion->get_return_value());
2793         completion->release();
2794     
2795         NObjectIterator it = cache_ioctx.nobjects_begin();
2796         ASSERT_TRUE(it != cache_ioctx.nobjects_end());
2797         ASSERT_TRUE(it->get_oid() == string("foo"));
/test/librados/tier.cc: 2789 in LibRadosTwoPoolsECPP_Whiteout_Test::TestBody()()
2783       // delete a whiteout and verify it goes away
2784       ASSERT_EQ(-ENOENT, ioctx.remove("foo"));
2785       {
2786         ObjectWriteOperation op;
2787         op.remove();
2788         librados::AioCompletion *completion = cluster.aio_create_completion();
>>>     CID 1256098:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
2789         ASSERT_EQ(0, ioctx.aio_operate("bar", completion, &op,
2790     				   librados::OPERATION_IGNORE_CACHE));
2791         completion->wait_for_safe();
2792         ASSERT_EQ(0, completion->get_return_value());
2793         completion->release();
2794     

________________________________________________________________________________________________________
*** CID 1256096:  Resource leak  (RESOURCE_LEAK)
/test/librados/TestCase.cc: 336 in RadosTestPP::cleanup_namespace(librados::IoCtx, std::basic_string<char, std::char_traits<char>, std::allocator<char>>)()
330         ObjectWriteOperation op;
331         op.remove();
332         librados::AioCompletion *completion = s_cluster.aio_create_completion();
333         ASSERT_EQ(0, ioctx.aio_operate(it->get_oid(), completion, &op,
334     				   librados::OPERATION_IGNORE_CACHE));
335         completion->wait_for_safe();
>>>     CID 1256096:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
336         ASSERT_EQ(0, completion->get_return_value());
337         completion->release();
338       }
339     }
340     
341     std::string RadosTestParamPP::pool_name;
/test/librados/TestCase.cc: 333 in RadosTestPP::cleanup_namespace(librados::IoCtx, std::basic_string<char, std::char_traits<char>, std::allocator<char>>)()
327       for (NObjectIterator it = ioctx.nobjects_begin();
328            it != ioctx.nobjects_end(); ++it) {
329         ioctx.locator_set_key(it->get_locator());
330         ObjectWriteOperation op;
331         op.remove();
332         librados::AioCompletion *completion = s_cluster.aio_create_completion();
>>>     CID 1256096:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
333         ASSERT_EQ(0, ioctx.aio_operate(it->get_oid(), completion, &op,
334     				   librados::OPERATION_IGNORE_CACHE));
335         completion->wait_for_safe();
336         ASSERT_EQ(0, completion->get_return_value());
337         completion->release();
338       }

________________________________________________________________________________________________________
*** CID 1256097:  Resource leak  (RESOURCE_LEAK)
/test/librados/tier.cc: 648 in LibRadosTwoPoolsPP_Whiteout_Test::TestBody()()
642         ObjectWriteOperation op;
643         op.remove();
644         librados::AioCompletion *completion = cluster.aio_create_completion();
645         ASSERT_EQ(0, ioctx.aio_operate("bar", completion, &op,
646     				   librados::OPERATION_IGNORE_CACHE));
647         completion->wait_for_safe();
>>>     CID 1256097:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
648         ASSERT_EQ(0, completion->get_return_value());
649         completion->release();
650     
651         NObjectIterator it = cache_ioctx.nobjects_begin();
652         ASSERT_TRUE(it != cache_ioctx.nobjects_end());
653         ASSERT_TRUE(it->get_oid() == string("foo"));
/test/librados/tier.cc: 645 in LibRadosTwoPoolsPP_Whiteout_Test::TestBody()()
639       // delete a whiteout and verify it goes away
640       ASSERT_EQ(-ENOENT, ioctx.remove("foo"));
641       {
642         ObjectWriteOperation op;
643         op.remove();
644         librados::AioCompletion *completion = cluster.aio_create_completion();
>>>     CID 1256097:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
645         ASSERT_EQ(0, ioctx.aio_operate("bar", completion, &op,
646     				   librados::OPERATION_IGNORE_CACHE));
647         completion->wait_for_safe();
648         ASSERT_EQ(0, completion->get_return_value());
649         completion->release();
650     

________________________________________________________________________________________________________
*** CID 1256100:  Uninitialized pointer read  (UNINIT)
/librados/librados.cc: 4516 in librados::ListObject::ListObject(const librados::ListObject&)()
4510     {
4511     }
4512     
4513     librados::ListObject::ListObject(const ListObject& rhs)
4514     {
4515       if (rhs.impl == NULL) {
>>>     CID 1256100:  Uninitialized pointer read  (UNINIT)
>>>     Using uninitialized value "this->impl".
4516         delete impl;
4517         impl = NULL;
4518         return;
4519       }
4520       impl = new ListObjectImpl();
4521       *impl = *(rhs.impl);

________________________________________________________________________________________________________
*** CID 1256099:  Uninitialized pointer read  (UNINIT)
/librados/librados.cc: 650 in librados::NObjectIterator::NObjectIterator(const librados::NObjectIterator&)()
644       delete impl;
645     }
646     
647     librados::NObjectIterator::NObjectIterator(const NObjectIterator &rhs)
648     {
649       if (rhs.impl == NULL) {
>>>     CID 1256099:  Uninitialized pointer read  (UNINIT)
>>>     Using uninitialized value "this->impl".
650         delete impl;
651         impl = NULL;
652         return;
653       }
654       impl = new NObjectIteratorImpl();
655       *impl = *(rhs.impl);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



