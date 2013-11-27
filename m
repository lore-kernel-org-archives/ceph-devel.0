From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 10/18] mds: Push inline data to client in inodestat
Date: Wed, 27 Nov 2013 21:40:49 +0800
Message-ID: <5a5e6c71898d4fd2bad8e712095de978fc9f93ce.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48462 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab3K0NlW (ORCPT
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
 src/mds/CInode.cc           |   15 +++++++++++++++
 src/messages/MClientReply.h |    7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 4756865..ed51e1d 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -2824,6 +2824,16 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
   e.files = i->dirstat.nfiles;
   e.subdirs = i->dirstat.nsubdirs;
 
+  // inline data
+  uint64_t inline_version = 0;
+  bufferlist inline_data;
+  if (!cap || (cap->client_inline_version < i->inline_version)) {
+    inline_version = i->inline_version;
+    inline_data = i->inline_data;
+    if (cap)
+      cap->client_inline_version = i->inline_version;
+  }
+
   // nest (do same as file... :/)
   i->rstat.rctime.encode_timeval(&e.rctime);
   e.rbytes = i->rstat.rbytes;
@@ -2862,6 +2872,7 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
     bytes += (sizeof(__u32) + sizeof(__u32)) * dirfragtree._splits.size();
     bytes += sizeof(__u32) + symlink.length();
     bytes += sizeof(__u32) + xbl.length();
+    bytes += sizeof(__u64) + sizeof(__u32) + inline_data.length();
     if (bytes > max_bytes)
       return -ENOSPC;
   }
@@ -2957,6 +2968,10 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
     ::encode(i->dir_layout, bl);
   }
   ::encode(xbl, bl);
+  if (session->connection->has_feature(CEPH_FEATURE_MDS_INLINE_DATA)) {
+    ::encode(inline_version, bl);
+    ::encode(inline_data, bl);
+  }
 
   return valid;
 }
diff --git a/src/messages/MClientReply.h b/src/messages/MClientReply.h
index 47908e9..ebb3b9b 100644
--- a/src/messages/MClientReply.h
+++ b/src/messages/MClientReply.h
@@ -176,6 +176,13 @@ struct InodeStat {
 
     xattr_version = e.xattr_version;
     ::decode(xattrbl, p);
+
+    if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
+      ::decode(inline_version, p);
+      ::decode(inline_data, p);
+    } else {
+      inline_version = CEPH_INLINE_NONE;
+    }
   }
   
   // see CInode::encode_inodestat for encoder.
-- 
1.7.9.5

