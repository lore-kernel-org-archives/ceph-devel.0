From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 05/18] ceph: Add inline fields to MClientCaps
Date: Wed, 27 Nov 2013 21:40:44 +0800
Message-ID: <aa98d0d3443a288a5486f800246e072b260542e0.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48451 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583Ab3K0NlW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:22 -0500
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
 src/messages/MClientCaps.h |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/src/messages/MClientCaps.h b/src/messages/MClientCaps.h
index 117f241..a506c53 100644
--- a/src/messages/MClientCaps.h
+++ b/src/messages/MClientCaps.h
@@ -21,7 +21,7 @@
 
 class MClientCaps : public Message {
 
-  static const int HEAD_VERSION = 2;   // added flock metadata
+  static const int HEAD_VERSION = 3;   // added flock metadata, inline data
   static const int COMPAT_VERSION = 1;
 
  public:
@@ -29,6 +29,8 @@ class MClientCaps : public Message {
   bufferlist snapbl;
   bufferlist xattrbl;
   bufferlist flockbl;
+  uint64_t   inline_version;
+  bufferlist inline_data;
 
   int      get_caps() { return head.caps; }
   int      get_wanted() { return head.wanted; }
@@ -151,6 +153,13 @@ public:
     // conditionally decode flock metadata
     if (header.version >= 2)
       ::decode(flockbl, p);
+
+    if (header.version >= 3) {
+      ::decode(inline_version, p);
+      ::decode(inline_data, p);
+    } else {
+      inline_version = CEPH_INLINE_NONE;
+    }
   }
   void encode_payload(uint64_t features) {
     head.snap_trace_len = snapbl.length();
@@ -165,6 +174,14 @@ public:
       ::encode(flockbl, payload);
     } else {
       header.version = 1;  // old
+      return;
+    }
+
+    if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
+      ::encode(inline_version, payload);
+      ::encode(inline_data, payload);
+    } else {
+      header.version = 2;
     }
   }
 };
-- 
1.7.9.5

