From: Loic Dachary <loic@dachary.org>
Subject: [PATCH] fix operator>=(bufferlist& l, bufferlist& r)
Date: Sat, 16 Feb 2013 10:11:15 +0100
Message-ID: <1361005875-768-1-git-send-email-loic@dachary.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:46349 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab3BPJLR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 04:11:17 -0500
Received: from bet.dachary.org (unknown [10.8.0.50])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 0ABCD26394
	for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 10:11:15 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  bufferlist a;
  a.append("A");
  bufferlist ab;
  ab.append("AB");

a >= ab failed, throwing an instance of 'ceph::buffer::end_of_buffer'
because it tried to access a[1]. All comparison operators should be
tested using a lexicographic sort like strcmp or memcmp (-1, 0, 1).
In the meantime, the missing test is added:

  if (l.length() == p && r.length() > p) return false;

A set of unit tests demonstrating the problem and covering all comparison
operators are added to show that the proposed fix works as expected.

http://tracker.ceph.com/issues/4157 refs #4157

Signed-off-by: Loic Dachary <loic@dachary.org>
---
 src/include/buffer.h   |    1 +
 src/test/bufferlist.cc |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/src/include/buffer.h b/src/include/buffer.h
index 4f87ed7..b84e7f4 100644
--- a/src/include/buffer.h
+++ b/src/include/buffer.h
@@ -467,6 +467,7 @@ inline bool operator>=(bufferlist& l, bufferlist& r) {
   for (unsigned p = 0; ; p++) {
     if (l.length() > p && r.length() == p) return true;
     if (r.length() == p && l.length() == p) return true;
+    if (l.length() == p && r.length() > p) return false;
     if (l[p] > r[p]) return true;
     if (l[p] < r[p]) return false;
   }
diff --git a/src/test/bufferlist.cc b/src/test/bufferlist.cc
index 91e37e6..71c2e79 100644
--- a/src/test/bufferlist.cc
+++ b/src/test/bufferlist.cc
@@ -57,6 +57,53 @@ TEST(BufferList, zero) {
   }
 }
 
+TEST(BufferList, compare) {
+  bufferlist a;
+  a.append("A");
+  bufferlist ab;
+  ab.append("AB");
+  bufferlist ac;
+  ac.append("AC");
+  //
+  // bool operator>(bufferlist& l, bufferlist& r)
+  //
+  ASSERT_FALSE(a > ab);
+  ASSERT_TRUE(ab > a);
+  ASSERT_TRUE(ac > ab);
+  ASSERT_FALSE(ab > ac);
+  ASSERT_FALSE(ab > ab);
+  //
+  // bool operator>=(bufferlist& l, bufferlist& r)
+  //
+  ASSERT_FALSE(a >= ab);
+  ASSERT_TRUE(ab >= a);
+  ASSERT_TRUE(ac >= ab);
+  ASSERT_FALSE(ab >= ac);
+  ASSERT_TRUE(ab >= ab);
+  //
+  // bool operator<(bufferlist& l, bufferlist& r)
+  //
+  ASSERT_TRUE(a < ab);
+  ASSERT_FALSE(ab < a);
+  ASSERT_FALSE(ac < ab);
+  ASSERT_TRUE(ab < ac);
+  ASSERT_FALSE(ab < ab);
+  //
+  // bool operator<=(bufferlist& l, bufferlist& r)
+  //
+  ASSERT_TRUE(a <= ab);
+  ASSERT_FALSE(ab <= a);
+  ASSERT_FALSE(ac <= ab);
+  ASSERT_TRUE(ab <= ac);
+  ASSERT_TRUE(ab <= ab);
+  //
+  // bool operator==(bufferlist &l, bufferlist &r)
+  //
+  ASSERT_FALSE(a == ab);
+  ASSERT_FALSE(ac == ab);
+  ASSERT_TRUE(ab == ab);
+}
+
 TEST(BufferList, EmptyAppend) {
   bufferlist bl;
   bufferptr ptr;
-- 
1.7.10.4

