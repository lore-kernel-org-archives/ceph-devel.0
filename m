From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 02/16] mds: fix anchor table update
Date: Mon, 19 Nov 2012 10:43:34 +0800
Message-ID: <1353293028-15238-3-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27822 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab2KSCny (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:43:54 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The reference count of an anchor table entry that corresponds to
directory is number of anchored inodes under the directory. But
when updating anchor trace for an directory inode, the code only
increases/decreases its new/old ancestor anchor table entries'
reference counts by one.

This patch probably resolves BUG #1850.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/AnchorServer.cc | 13 +++++++------
 src/mds/AnchorServer.h  |  4 ++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/mds/AnchorServer.cc b/src/mds/AnchorServer.cc
index 731ec96..cd2e625 100644
--- a/src/mds/AnchorServer.cc
+++ b/src/mds/AnchorServer.cc
@@ -73,7 +73,7 @@ bool AnchorServer::add(inodeno_t ino, inodeno_t dirino, __u32 dn_hash,
   return true;
 }
 
-void AnchorServer::inc(inodeno_t ino)
+void AnchorServer::inc(inodeno_t ino, int ref)
 {
   dout(7) << "inc " << ino << dendl;
 
@@ -81,7 +81,7 @@ void AnchorServer::inc(inodeno_t ino)
 
   while (1) {
     Anchor &anchor = anchor_map[ino];
-    anchor.nref++;
+    anchor.nref += ref;
     anchor.updated = version;
       
     dout(10) << "inc now " << anchor << dendl;
@@ -92,14 +92,14 @@ void AnchorServer::inc(inodeno_t ino)
   }
 }
 
-void AnchorServer::dec(inodeno_t ino) 
+void AnchorServer::dec(inodeno_t ino, int ref)
 {
   dout(7) << "dec " << ino << dendl;
   assert(anchor_map.count(ino));
 
   while (true) {
     Anchor &anchor = anchor_map[ino];
-    anchor.nref--;
+    anchor.nref -= ref;
     anchor.updated = version;
 
     if (anchor.nref == 0) {
@@ -186,13 +186,14 @@ void AnchorServer::_commit(version_t tid)
     if (anchor_map.count(ino)) {
       dout(7) << "commit " << tid << " update " << ino << dendl;
 
+      int ref = anchor_map[ino].nref;
       // remove old
-      dec(ino);
+      dec(ino, ref);
       
       // add new
       for (unsigned i=0; i<trace.size(); i++) 
 	add(trace[i].ino, trace[i].dirino, trace[i].dn_hash, true);
-      inc(ino);
+      inc(ino, ref);
     } else {
       dout(7) << "commit " << tid << " update " << ino << " -- DNE" << dendl;
     }
diff --git a/src/mds/AnchorServer.h b/src/mds/AnchorServer.h
index ca70aa2..aa5588a 100644
--- a/src/mds/AnchorServer.h
+++ b/src/mds/AnchorServer.h
@@ -50,8 +50,8 @@ class AnchorServer : public MDSTableServer {
   }
 
   bool add(inodeno_t ino, inodeno_t dirino, __u32 dn_hash, bool replace);
-  void inc(inodeno_t ino);
-  void dec(inodeno_t ino);
+  void inc(inodeno_t ino, int ref=1);
+  void dec(inodeno_t ino, int ref=1);
 
   void dump();
 
-- 
1.7.11.7

