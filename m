From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 21/39] mds: encode dirfrag base in cache rejoin ack
Date: Sun, 17 Mar 2013 22:51:24 +0800
Message-ID: <1363531902-24909-22-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932610Ab3CQOxC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:53:02 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Cache rejoin ack message already encodes inode base, make it also encode
dirfrag base. This allowes the message to replicate stray dentries like
MDentryUnlink message. The function will be used by later patch.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDir.h                 | 20 +++++++++++++-------
 src/mds/MDCache.cc             | 20 ++++++++++++++++++--
 src/messages/MMDSCacheRejoin.h | 12 +++++++++++-
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/src/mds/CDir.h b/src/mds/CDir.h
index 79946f1..f4a3a3d 100644
--- a/src/mds/CDir.h
+++ b/src/mds/CDir.h
@@ -437,23 +437,29 @@ private:
     ::encode(dist, bl);
   }
 
-  void encode_replica(int who, bufferlist& bl) {
-    __u32 nonce = add_replica(who);
-    ::encode(nonce, bl);
+  void _encode_base(bufferlist& bl) {
     ::encode(first, bl);
     ::encode(fnode, bl);
     ::encode(dir_rep, bl);
     ::encode(dir_rep_by, bl);
   }
-  void decode_replica(bufferlist::iterator& p) {
-    __u32 nonce;
-    ::decode(nonce, p);
-    replica_nonce = nonce;
+  void _decode_base(bufferlist::iterator& p) {
     ::decode(first, p);
     ::decode(fnode, p);
     ::decode(dir_rep, p);
     ::decode(dir_rep_by, p);
   }
+  void encode_replica(int who, bufferlist& bl) {
+    __u32 nonce = add_replica(who);
+    ::encode(nonce, bl);
+    _encode_base(bl);
+  }
+  void decode_replica(bufferlist::iterator& p) {
+    __u32 nonce;
+    ::decode(nonce, p);
+    replica_nonce = nonce;
+    _decode_base(p);
+  }
 
 
 
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 8ba676e..344777e 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -4510,8 +4510,22 @@ void MDCache::handle_cache_rejoin_ack(MMDSCacheRejoin *ack)
     }
   }
 
+  // full dirfrags
+  bufferlist::iterator p = ack->dirfrag_base.begin();
+  while (!p.end()) {
+    dirfrag_t df;
+    bufferlist basebl;
+    ::decode(df, p);
+    ::decode(basebl, p);
+    CDir *dir = get_dirfrag(df);
+    assert(dir);
+    bufferlist::iterator q = basebl.begin();
+    dir->_decode_base(q);
+    dout(10) << " got dir replica " << *dir << dendl;
+  }
+
   // full inodes
-  bufferlist::iterator p = ack->inode_base.begin();
+  p = ack->inode_base.begin();
   while (!p.end()) {
     inodeno_t ino;
     snapid_t last;
@@ -5178,8 +5192,10 @@ void MDCache::rejoin_send_acks()
       // dir
       for (map<int,int>::iterator r = dir->replicas_begin();
 	   r != dir->replicas_end();
-	   ++r) 
+	   ++r) {
 	ack[r->first]->add_strong_dirfrag(dir->dirfrag(), ++r->second, dir->dir_rep);
+	ack[r->first]->add_dirfrag_base(dir);
+      }
 	   
       for (CDir::map_t::iterator q = dir->items.begin();
 	   q != dir->items.end();
diff --git a/src/messages/MMDSCacheRejoin.h b/src/messages/MMDSCacheRejoin.h
index b88f551..7c37ab4 100644
--- a/src/messages/MMDSCacheRejoin.h
+++ b/src/messages/MMDSCacheRejoin.h
@@ -20,6 +20,7 @@
 #include "include/types.h"
 
 #include "mds/CInode.h"
+#include "mds/CDir.h"
 
 // sent from replica to auth
 
@@ -169,6 +170,7 @@ class MMDSCacheRejoin : public Message {
   // full
   bufferlist inode_base;
   bufferlist inode_locks;
+  bufferlist dirfrag_base;
 
   // authpins, xlocks
   struct slave_reqid {
@@ -258,7 +260,13 @@ public:
   void add_strong_dirfrag(dirfrag_t df, int n, int dr) {
     strong_dirfrags[df] = dirfrag_strong(n, dr);
   }
-   
+  void add_dirfrag_base(CDir *dir) {
+    ::encode(dir->dirfrag(), dirfrag_base);
+    bufferlist bl;
+    dir->_encode_base(bl);
+    ::encode(bl, dirfrag_base);
+  }
+
   // dentries
   void add_weak_dirfrag(dirfrag_t df) {
     weak_dirfrags.insert(df);
@@ -294,6 +302,7 @@ public:
     ::encode(wrlocked_inodes, payload);
     ::encode(cap_export_bl, payload);
     ::encode(strong_dirfrags, payload);
+    ::encode(dirfrag_base, payload);
     ::encode(weak, payload);
     ::encode(weak_dirfrags, payload);
     ::encode(weak_inodes, payload);
@@ -319,6 +328,7 @@ public:
       ::decode(cap_export_paths, q);
     }
     ::decode(strong_dirfrags, p);
+    ::decode(dirfrag_base, p);
     ::decode(weak, p);
     ::decode(weak_dirfrags, p);
     ::decode(weak_inodes, p);
-- 
1.7.11.7

