From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 13/18] client: Receive inline data pushed from mds
Date: Wed, 27 Nov 2013 21:40:52 +0800
Message-ID: <69d774668992879946841c8e67e562fd368efb29.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48496 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab3K0NlZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:25 -0500
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
 src/client/Client.cc |   22 ++++++++++++++++++++--
 src/client/Client.h  |    1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index a4d5550..19d31e0 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -494,6 +494,8 @@ void Client::update_inode_file_bits(Inode *in,
 				    uint64_t time_warp_seq, utime_t ctime,
 				    utime_t mtime,
 				    utime_t atime,
+				    uint64_t inline_version,
+				    bufferlist& inline_data,
 				    int issued)
 {
   bool warn = false;
@@ -504,6 +506,11 @@ void Client::update_inode_file_bits(Inode *in,
 	   << " local " << in->time_warp_seq << dendl;
   uint64_t prior_size = in->size;
 
+  if (inline_version > in->inline_version) {
+    in->inline_data = inline_data;
+    in->inline_version = inline_version;
+  }
+
   if (truncate_seq > in->truncate_seq ||
       (truncate_seq == in->truncate_seq && size > in->size)) {
     ldout(cct, 10) << "size " << in->size << " -> " << size << dendl;
@@ -520,6 +527,13 @@ void Client::update_inode_file_bits(Inode *in,
 	_invalidate_inode_cache(in, truncate_size, prior_size - truncate_size, true);
       }
     }
+
+    // truncate inline data
+    if (in->inline_version < CEPH_INLINE_NONE) {
+      uint32_t len = in->inline_data.length();
+      if (size < len)
+        in->inline_data.splice(size, len - size);
+    }
   }
   if (truncate_seq >= in->truncate_seq &&
       in->truncate_size != truncate_size) {
@@ -654,6 +668,7 @@ Inode * Client::add_update_inode(InodeStat *st, utime_t from, MetaSession *sessi
   
     update_inode_file_bits(in, st->truncate_seq, st->truncate_size, st->size,
 			   st->time_warp_seq, st->ctime, st->mtime, st->atime,
+			   st->inline_version, st->inline_data,
 			   issued);
   }
 
@@ -3524,7 +3539,9 @@ void Client::handle_cap_trunc(MetaSession *session, Inode *in, MClientCaps *m)
   issued |= implemented;
   update_inode_file_bits(in, m->get_truncate_seq(), m->get_truncate_size(),
                          m->get_size(), m->get_time_warp_seq(), m->get_ctime(),
-                         m->get_mtime(), m->get_atime(), issued);
+                         m->get_mtime(), m->get_atime(),
+                         m->inline_version, m->inline_data,
+                         issued);
   m->put();
 }
 
@@ -3674,7 +3691,8 @@ void Client::handle_cap_grant(MetaSession *session, Inode *in, Cap *cap, MClient
     in->xattr_version = m->head.xattr_version;
   }
   update_inode_file_bits(in, m->get_truncate_seq(), m->get_truncate_size(), m->get_size(),
-			 m->get_time_warp_seq(), m->get_ctime(), m->get_mtime(), m->get_atime(), issued);
+			 m->get_time_warp_seq(), m->get_ctime(), m->get_mtime(), m->get_atime(),
+			 m->inline_version, m->inline_data, issued);
 
   // max_size
   if (cap == in->auth_cap &&
diff --git a/src/client/Client.h b/src/client/Client.h
index 649bacc..48f1fea 100644
--- a/src/client/Client.h
+++ b/src/client/Client.h
@@ -508,6 +508,7 @@ protected:
   void update_inode_file_bits(Inode *in,
 			      uint64_t truncate_seq, uint64_t truncate_size, uint64_t size,
 			      uint64_t time_warp_seq, utime_t ctime, utime_t mtime, utime_t atime,
+			      uint64_t inline_version, bufferlist& inline_data,
 			      int issued);
   Inode *add_update_inode(InodeStat *st, utime_t ttl, MetaSession *session);
   Dentry *insert_dentry_inode(Dir *dir, const string& dname, LeaseStat *dlease, 
-- 
1.7.9.5

