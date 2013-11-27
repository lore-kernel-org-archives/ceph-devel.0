From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 04/18] mds: Add inline encode/decode to inode_t
Date: Wed, 27 Nov 2013 21:40:43 +0800
Message-ID: <bc77b1aee6c3fc99ebcf06393f904584b0d85320.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48420 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab3K0NlU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:20 -0500
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/mds/mdstypes.cc |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/mds/mdstypes.cc b/src/mds/mdstypes.cc
index df6cd8e..01a04e8 100644
--- a/src/mds/mdstypes.cc
+++ b/src/mds/mdstypes.cc
@@ -204,7 +204,7 @@ ostream& operator<<(ostream& out, const client_writeable_range_t& r)
  */
 void inode_t::encode(bufferlist &bl) const
 {
-  ENCODE_START(8, 6, bl);
+  ENCODE_START(9, 9, bl);
 
   ::encode(ino, bl);
   ::encode(rdev, bl);
@@ -239,13 +239,15 @@ void inode_t::encode(bufferlist &bl) const
   ::encode(backtrace_version, bl);
   ::encode(old_pools, bl);
   ::encode(max_size_ever, bl);
+  ::encode(inline_version, bl);
+  ::encode(inline_data, bl);
 
   ENCODE_FINISH(bl);
 }
 
 void inode_t::decode(bufferlist::iterator &p)
 {
-  DECODE_START_LEGACY_COMPAT_LEN(7, 6, 6, p);
+  DECODE_START_LEGACY_COMPAT_LEN(9, 6, 6, p);
 
   ::decode(ino, p);
   ::decode(rdev, p);
@@ -299,6 +301,12 @@ void inode_t::decode(bufferlist::iterator &p)
     backtrace_version = 0; // note inode which has no backtrace
   if (struct_v >= 8)
     ::decode(max_size_ever, p);
+  if (struct_v >= 9) {
+    ::decode(inline_version, p);
+    ::decode(inline_data, p);
+  } else {
+    inline_version = CEPH_INLINE_NONE;
+  }
 
   DECODE_FINISH(p);
 }
-- 
1.7.9.5

