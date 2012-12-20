From: Filippos Giannakos <philipgian@grnet.gr>
Subject: [PATCH 2/2] Add librados aio stat tests
Date: Thu, 20 Dec 2012 22:05:11 +0200
Message-ID: <1356033911-14027-3-git-send-email-philipgian@grnet.gr>
References: <alpine.DEB.2.00.1212190741470.13122@cobra.newdream.net>
 <1356033911-14027-1-git-send-email-philipgian@grnet.gr>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:3187 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751851Ab2LTUF6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 20 Dec 2012 15:05:58 -0500
In-Reply-To: <1356033911-14027-1-git-send-email-philipgian@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: synnefo-devel@googlegroups.com, philipgian@grnet.gr

Implement simple write-stat test, and a write-stat-remove-stat test cycle.
---
 src/include/rados/librados.h |    2 +-
 src/test/librados/aio.cc     |  176 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/src/include/rados/librados.h b/src/include/rados/librados.h
index b2df767..d40d9b5 100644
--- a/src/include/rados/librados.h
+++ b/src/include/rados/librados.h
@@ -1454,7 +1454,7 @@ int rados_aio_flush(rados_ioctx_t io);
  * @param pmtime where to store modification time
  * @returns 0 on success, negative error code on failure
  */
-int rados_aio_stat(rados_ioctx_t io, const char *o, 
+int rados_aio_stat(rados_ioctx_t io, const char *o,
 		   rados_completion_t completion,
 		   uint64_t *psize, time_t *pmtime);
 
diff --git a/src/test/librados/aio.cc b/src/test/librados/aio.cc
index 4983fee..33b5942 100644
--- a/src/test/librados/aio.cc
+++ b/src/test/librados/aio.cc
@@ -762,6 +762,182 @@ TEST(LibRadosAio, RoundTripWriteFullPP) {
   delete my_completion3;
 }
 
+
+TEST(LibRadosAio, SimpleStat) {
+  AioTestData test_data;
+  rados_completion_t my_completion;
+  ASSERT_EQ("", test_data.init());
+  ASSERT_EQ(0, rados_aio_create_completion((void*)&test_data,
+	      set_completion_complete, set_completion_safe, &my_completion));
+  char buf[128];
+  memset(buf, 0xcc, sizeof(buf));
+  ASSERT_EQ(0, rados_aio_write(test_data.m_ioctx, "foo",
+			       my_completion, buf, sizeof(buf), 0));
+  {
+    TestAlarm alarm;
+    sem_wait(&test_data.m_sem);
+    sem_wait(&test_data.m_sem);
+  }
+  uint64_t psize;
+  time_t pmtime;
+  rados_completion_t my_completion2;
+  ASSERT_EQ(0, rados_aio_create_completion((void*)&test_data,
+	      set_completion_complete, set_completion_safe, &my_completion2));
+  ASSERT_EQ(0, rados_aio_stat(test_data.m_ioctx, "foo",
+			      my_completion2, &psize, &pmtime));
+  {
+    TestAlarm alarm;
+    ASSERT_EQ(0, rados_aio_wait_for_complete(my_completion2));
+  }
+  ASSERT_EQ(sizeof(buf), psize);
+  rados_aio_release(my_completion);
+  rados_aio_release(my_completion2);
+}
+
+TEST(LibRadosAio, SimpleStatPP) {
+  AioTestDataPP test_data;
+  ASSERT_EQ("", test_data.init());
+  AioCompletion *my_completion = test_data.m_cluster.aio_create_completion(
+	  (void*)&test_data, set_completion_complete, set_completion_safe);
+  AioCompletion *my_completion_null = NULL;
+  ASSERT_NE(my_completion, my_completion_null);
+  char buf[128];
+  memset(buf, 0xcc, sizeof(buf));
+  bufferlist bl1;
+  bl1.append(buf, sizeof(buf));
+  ASSERT_EQ(0, test_data.m_ioctx.aio_write("foo", my_completion,
+					   bl1, sizeof(buf), 0));
+  {
+    TestAlarm alarm;
+    sem_wait(&test_data.m_sem);
+    sem_wait(&test_data.m_sem);
+  }
+  uint64_t psize;
+  time_t pmtime;
+  AioCompletion *my_completion2 = test_data.m_cluster.aio_create_completion(
+	  (void*)&test_data, set_completion_complete, set_completion_safe);
+  ASSERT_NE(my_completion2, my_completion_null);
+  ASSERT_EQ(0, test_data.m_ioctx.aio_stat("foo", my_completion2,
+			  		&psize, &pmtime));
+  {
+    TestAlarm alarm;
+    ASSERT_EQ(0, my_completion2->wait_for_complete());
+  }
+  ASSERT_EQ(sizeof(buf), psize);
+  delete my_completion;
+  delete my_completion2;
+}
+
+TEST(LibRadosAio, StatRemove) {
+  AioTestData test_data;
+  rados_completion_t my_completion;
+  ASSERT_EQ("", test_data.init());
+  ASSERT_EQ(0, rados_aio_create_completion((void*)&test_data,
+	      set_completion_complete, set_completion_safe, &my_completion));
+  char buf[128];
+  memset(buf, 0xcc, sizeof(buf));
+  ASSERT_EQ(0, rados_aio_write(test_data.m_ioctx, "foo",
+			       my_completion, buf, sizeof(buf), 0));
+  {
+    TestAlarm alarm;
+    sem_wait(&test_data.m_sem);
+    sem_wait(&test_data.m_sem);
+  }
+  uint64_t psize;
+  time_t pmtime;
+  rados_completion_t my_completion2;
+  ASSERT_EQ(0, rados_aio_create_completion((void*)&test_data,
+	      set_completion_complete, set_completion_safe, &my_completion2));
+  ASSERT_EQ(0, rados_aio_stat(test_data.m_ioctx, "foo",
+			      my_completion2, &psize, &pmtime));
+  {
+    TestAlarm alarm;
+    ASSERT_EQ(0, rados_aio_wait_for_complete(my_completion2));
+  }
+  ASSERT_EQ(sizeof(buf), psize);
+  rados_completion_t my_completion3;
+  ASSERT_EQ(0, rados_aio_create_completion((void*)&test_data,
+	      set_completion_complete, set_completion_safe, &my_completion3));
+  ASSERT_EQ(0, rados_aio_remove(test_data.m_ioctx, "foo", my_completion3));
+  {
+    TestAlarm alarm;
+    ASSERT_EQ(0, rados_aio_wait_for_complete(my_completion3));
+  }
+  uint64_t psize2;
+  time_t pmtime2;
+  rados_completion_t my_completion4;
+  ASSERT_EQ(0, rados_aio_create_completion((void*)&test_data,
+	      set_completion_complete, set_completion_safe, &my_completion4));
+  ASSERT_EQ(0, rados_aio_stat(test_data.m_ioctx, "foo",
+			      my_completion4, &psize2, &pmtime2));
+  {
+    TestAlarm alarm;
+    ASSERT_EQ(0, rados_aio_wait_for_complete(my_completion4));
+  }
+  ASSERT_EQ(-ENOENT, rados_aio_get_return_value(my_completion4));
+  rados_aio_release(my_completion);
+  rados_aio_release(my_completion2);
+  rados_aio_release(my_completion3);
+  rados_aio_release(my_completion4);
+}
+
+TEST(LibRadosAio, StatRemovePP) {
+  AioTestDataPP test_data;
+  ASSERT_EQ("", test_data.init());
+  AioCompletion *my_completion = test_data.m_cluster.aio_create_completion(
+	  (void*)&test_data, set_completion_complete, set_completion_safe);
+  AioCompletion *my_completion_null = NULL;
+  ASSERT_NE(my_completion, my_completion_null);
+  char buf[128];
+  memset(buf, 0xcc, sizeof(buf));
+  bufferlist bl1;
+  bl1.append(buf, sizeof(buf));
+  ASSERT_EQ(0, test_data.m_ioctx.aio_write("foo", my_completion,
+					   bl1, sizeof(buf), 0));
+  {
+    TestAlarm alarm;
+    sem_wait(&test_data.m_sem);
+    sem_wait(&test_data.m_sem);
+  }
+  uint64_t psize;
+  time_t pmtime;
+  AioCompletion *my_completion2 = test_data.m_cluster.aio_create_completion(
+	  (void*)&test_data, set_completion_complete, set_completion_safe);
+  ASSERT_NE(my_completion2, my_completion_null);
+  ASSERT_EQ(0, test_data.m_ioctx.aio_stat("foo", my_completion2,
+			  		&psize, &pmtime));
+  {
+    TestAlarm alarm;
+    ASSERT_EQ(0, my_completion2->wait_for_complete());
+  }
+  ASSERT_EQ(sizeof(buf), psize);
+  uint64_t psize2;
+  time_t pmtime2;
+  AioCompletion *my_completion3 = test_data.m_cluster.aio_create_completion(
+	  (void*)&test_data, set_completion_complete, set_completion_safe);
+  ASSERT_NE(my_completion3, my_completion_null);
+  ASSERT_EQ(0, test_data.m_ioctx.aio_remove("foo", my_completion3));
+  {
+    TestAlarm alarm;
+    ASSERT_EQ(0, my_completion3->wait_for_complete());
+  }
+
+  AioCompletion *my_completion4 = test_data.m_cluster.aio_create_completion(
+	  (void*)&test_data, set_completion_complete, set_completion_safe);
+  ASSERT_NE(my_completion4, my_completion_null);
+  ASSERT_EQ(0, test_data.m_ioctx.aio_stat("foo", my_completion4,
+			  		&psize2, &pmtime2));
+  {
+    TestAlarm alarm;
+    ASSERT_EQ(0, my_completion4->wait_for_complete());
+  }
+  ASSERT_EQ(-ENOENT, my_completion4->get_return_value());
+  delete my_completion;
+  delete my_completion2;
+  delete my_completion3;
+  delete my_completion4;
+}
+
 using std::string;
 using std::map;
 using std::set;
-- 
1.7.10.4

