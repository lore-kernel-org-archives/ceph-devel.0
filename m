From: Loic Dachary <loic@dachary.org>
Subject: [PATCH] buffer::ptr::cmp only compares up to the smallest length
Date: Sun, 17 Feb 2013 09:41:09 +0100
Message-ID: <1361090470-14891-1-git-send-email-loic@dachary.org>
References: <1361065465-11115-1-git-send-email-loic@dachary.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:48564 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab3BQIlN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Feb 2013 03:41:13 -0500
Received: from bet.dachary.org (unknown [10.8.0.50])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id F2B2226394
	for <ceph-devel@vger.kernel.org>; Sun, 17 Feb 2013 09:41:10 +0100 (CET)
In-Reply-To: <1361065465-11115-1-git-send-email-loic@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When running

  bufferptr a("A", 1);
  bufferptr ab("AB", 2);
  a.cmp(ab);

it returned zero because. cmp only compared up to the length of the
smallest buffer and returned if they are identical. The function is
modified to compare the length of the buffers instead of returning.

http://tracker.ceph.com/issues/4170 refs #4170

Signed-off-by: Loic Dachary <loic@dachary.org>
---
 src/common/buffer.cc   |    2 +-
 src/test/bufferlist.cc |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/src/common/buffer.cc b/src/common/buffer.cc
index e10d6c9..df50cfc 100644
--- a/src/common/buffer.cc
+++ b/src/common/buffer.cc
@@ -371,7 +371,7 @@ bool buffer_track_alloc = get_env_bool("CEPH_BUFFER_TRACK");
     int l = _len < o._len ? _len : o._len;
     if (l) {
       int r = memcmp(c_str(), o.c_str(), l);
-      if (!r)
+      if (r)
 	return r;
     }
     if (_len < o._len)
diff --git a/src/test/bufferlist.cc b/src/test/bufferlist.cc
index 71c2e79..7abced1 100644
--- a/src/test/bufferlist.cc
+++ b/src/test/bufferlist.cc
@@ -9,6 +9,23 @@
 
 #define MAX_TEST 1000000
 
+TEST(BufferPtr, cmp) {
+  bufferptr empty;
+  bufferptr a("A", 1);
+  bufferptr ab("AB", 2);
+  bufferptr af("AF", 2);
+  bufferptr acc("ACC", 3);
+  EXPECT_GE(-1, empty.cmp(a));
+  EXPECT_LE(1, a.cmp(empty));
+  EXPECT_GE(-1, a.cmp(ab));
+  EXPECT_LE(1, ab.cmp(a));
+  EXPECT_EQ(0, ab.cmp(ab));
+  EXPECT_GE(-1, ab.cmp(af));
+  EXPECT_LE(1, af.cmp(ab));
+  EXPECT_GE(-1, acc.cmp(af));
+  EXPECT_LE(1, af.cmp(acc));
+}
+
 TEST(BufferList, zero) {
   //
   // void zero()
-- 
1.7.10.4

