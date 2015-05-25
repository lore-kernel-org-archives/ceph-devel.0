From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 2/2] Rados: add test case for CEPH_OP_FLAG_TIER_NOCACHE
Date: Mon, 25 May 2015 11:32:17 +0800
Message-ID: <5def53d1d0f1ec1a7d3756b33ff54483a260e9ef.1432523122.git.liwang@ubuntukylin.com>
References: <cover.1432523122.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:58210 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbbEYDd4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 May 2015 23:33:56 -0400
In-Reply-To: <cover.1432523122.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1432523122.git.liwang@ubuntukylin.com>
References: <cover.1432523122.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, Min Chen <minchen@ubuntukylin.com>

From: Min Chen <minchen@ubuntukylin.com>

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Reviewed-by: Li Wang <liwang@ubuntukylin.com>
---
 src/test/librados/tier.cc | 176 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/src/test/librados/tier.cc b/src/test/librados/tier.cc
index 60b56f9..0b3368e 100644
--- a/src/test/librados/tier.cc
+++ b/src/test/librados/tier.cc
@@ -2390,6 +2390,94 @@ TEST_F(LibRadosTwoPoolsPP, ProxyRead) {
   cluster.wait_for_latest_osdmap();
 }
 
+TEST_F(LibRadosTwoPoolsPP, TierNocache) {
+  // configure cache
+  bufferlist inbl;
+  ASSERT_EQ(0, cluster.mon_command(
+    "{\"prefix\": \"osd tier add\", \"pool\": \"" + pool_name +
+    "\", \"tierpool\": \"" + cache_pool_name +
+    "\", \"force_nonempty\": \"--force-nonempty\" }",
+    inbl, NULL, NULL));
+  ASSERT_EQ(0, cluster.mon_command(
+    "{\"prefix\": \"osd tier set-overlay\", \"pool\": \"" + pool_name +
+    "\", \"overlaypool\": \"" + cache_pool_name + "\"}",
+    inbl, NULL, NULL));
+
+  std::string cache_modes[] = {"writeback", "forward", "readonly", "readforward", "readproxy"};
+  int count = (int) sizeof(cache_modes)/sizeof(cache_modes[0]);
+  int i;
+  // test write/read with TierNocache in each cache-mode
+  for (i = 0; i < count; i++)
+  {
+    std::cout << "set cache-mode:" + cache_modes[i] << std::endl;
+    ASSERT_EQ(0, cluster.mon_command(
+      "{\"prefix\": \"osd tier cache-mode\", \"pool\": \"" + cache_pool_name +
+      "\", \"mode\": \"" + cache_modes[i] + "\"}",
+      inbl, NULL, NULL));
+
+    // wait for maps to settle
+    cluster.wait_for_latest_osdmap();
+
+    std::string content(cache_modes[i]);
+    std::string object(cache_modes[i]+"_obj");
+    ObjectWriteOperation wr;
+    librados::AioCompletion *completion = cluster.aio_create_completion();
+
+    //writeback: create a new object
+    bufferlist bl;
+    bl.append(content);
+    wr.write_full(bl);
+    ioctx.aio_operate(object, completion, &wr, librados::OPERATION_TIER_NOCACHE);
+    completion->wait_for_safe();
+    completion->release();
+
+    // verify the object is NOT present in the cache tier
+    {
+      NObjectIterator it = cache_ioctx.nobjects_begin();
+      ASSERT_TRUE(it == cache_ioctx.nobjects_end());
+    }
+
+    //writeback: read the object content
+    ObjectReadOperation rd;
+    uint64_t len = bl.length();
+    completion = cluster.aio_create_completion();
+    bufferlist bl2;
+    bufferlist bl3;
+    rd.read(0, len+1, &bl3, NULL);
+    ASSERT_EQ(0, ioctx.aio_operate(
+	object, completion, &rd,
+	librados::OPERATION_TIER_NOCACHE, NULL));
+    completion->wait_for_complete();
+
+    ASSERT_EQ(0, completion->get_return_value());
+    uint64_t n = 0;
+    for (n = 0; n < len; n++) {
+	bl2.append(bl3[n]);
+    }
+    ASSERT_EQ(content, bl2.c_str());
+    completion->release();
+
+    // verify the object is NOT present in the cache tier
+    {
+      NObjectIterator it = cache_ioctx.nobjects_begin();
+      ASSERT_TRUE(it == cache_ioctx.nobjects_end());
+    }
+  }
+
+  // tear down tiers
+  ASSERT_EQ(0, cluster.mon_command(
+    "{\"prefix\": \"osd tier remove-overlay\", \"pool\": \"" + pool_name +
+    "\"}",
+    inbl, NULL, NULL));
+  ASSERT_EQ(0, cluster.mon_command(
+    "{\"prefix\": \"osd tier remove\", \"pool\": \"" + pool_name +
+    "\", \"tierpool\": \"" + cache_pool_name + "\"}",
+    inbl, NULL, NULL));
+
+  // wait for maps to settle before next test
+  cluster.wait_for_latest_osdmap();
+}
+
 class LibRadosTwoPoolsECPP : public RadosTestECPP
 {
 public:
@@ -4439,6 +4527,94 @@ TEST_F(LibRadosTwoPoolsECPP, ProxyRead) {
   cluster.wait_for_latest_osdmap();
 }
 
+TEST_F(LibRadosTwoPoolsECPP, TierNocache) {
+  // configure cache
+  bufferlist inbl;
+  ASSERT_EQ(0, cluster.mon_command(
+    "{\"prefix\": \"osd tier add\", \"pool\": \"" + pool_name +
+    "\", \"tierpool\": \"" + cache_pool_name +
+    "\", \"force_nonempty\": \"--force-nonempty\" }",
+    inbl, NULL, NULL));
+  ASSERT_EQ(0, cluster.mon_command(
+    "{\"prefix\": \"osd tier set-overlay\", \"pool\": \"" + pool_name +
+    "\", \"overlaypool\": \"" + cache_pool_name + "\"}",
+    inbl, NULL, NULL));
+
+  std::string cache_modes[] = {"writeback", "forward", "readonly", "readforward", "readproxy"};
+  int count = (int) sizeof(cache_modes)/sizeof(cache_modes[0]);
+  int i;
+  // test write/read with TierNocache in each cache-mode
+  for (i = 0; i < count; i++)
+  {
+    std::cout << "set cache-mode:" + cache_modes[i] << std::endl;
+    ASSERT_EQ(0, cluster.mon_command(
+      "{\"prefix\": \"osd tier cache-mode\", \"pool\": \"" + cache_pool_name +
+      "\", \"mode\": \"" + cache_modes[i] + "\"}",
+      inbl, NULL, NULL));
+
+    // wait for maps to settle
+    cluster.wait_for_latest_osdmap();
+
+    std::string content(cache_modes[i]);
+    std::string object(cache_modes[i]+"_obj");
+    ObjectWriteOperation wr;
+    librados::AioCompletion *completion = cluster.aio_create_completion();
+
+    //writeback: create a new object
+    bufferlist bl;
+    bl.append(content);
+    wr.write_full(bl);
+    ioctx.aio_operate(object, completion, &wr, librados::OPERATION_TIER_NOCACHE);
+    completion->wait_for_safe();
+    completion->release();
+
+    // verify the object is NOT present in the cache tier
+    {
+      NObjectIterator it = cache_ioctx.nobjects_begin();
+      ASSERT_TRUE(it == cache_ioctx.nobjects_end());
+    }
+
+    //writeback: read the object content
+    ObjectReadOperation rd;
+    uint64_t len = bl.length();
+    completion = cluster.aio_create_completion();
+    bufferlist bl2;
+    bufferlist bl3;
+    rd.read(0, len+1, &bl3, NULL);
+    ASSERT_EQ(0, ioctx.aio_operate(
+	object, completion, &rd,
+	librados::OPERATION_TIER_NOCACHE, NULL));
+    completion->wait_for_complete();
+
+    ASSERT_EQ(0, completion->get_return_value());
+    uint64_t n = 0;
+    for (n = 0; n < len; n++) {
+	bl2.append(bl3[n]);
+    }
+    ASSERT_EQ(content, bl2.c_str());
+    completion->release();
+
+    // verify the object is NOT present in the cache tier
+    {
+      NObjectIterator it = cache_ioctx.nobjects_begin();
+      ASSERT_TRUE(it == cache_ioctx.nobjects_end());
+    }
+  }
+
+  // tear down tiers
+  ASSERT_EQ(0, cluster.mon_command(
+    "{\"prefix\": \"osd tier remove-overlay\", \"pool\": \"" + pool_name +
+    "\"}",
+    inbl, NULL, NULL));
+  ASSERT_EQ(0, cluster.mon_command(
+    "{\"prefix\": \"osd tier remove\", \"pool\": \"" + pool_name +
+    "\", \"tierpool\": \"" + cache_pool_name + "\"}",
+    inbl, NULL, NULL));
+
+  // wait for maps to settle before next test
+  cluster.wait_for_latest_osdmap();
+}
+
 //Make ecpool as cache pool; no-ecpool as data pool
 //Judge promote object which has omap from no-ecpool into ecpool.
 TEST_F(LibRadosTwoPoolsECPP, OmapOperation) {
-- 
1.9.1

