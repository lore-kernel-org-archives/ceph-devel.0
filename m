From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 39/39] mds: clear scatter dirty if replica inode has no auth subtree
Date: Sun, 17 Mar 2013 22:51:42 +0800
Message-ID: <1363531902-24909-40-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932755Ab3CQOyN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:54:13 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

This avoids sending superfluous scatterlock state to recovering MDS

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.cc   |  5 +++--
 src/mds/CInode.h    |  2 +-
 src/mds/MDCache.cc  | 13 ++++++-------
 src/mds/Migrator.cc | 15 +++++++++++++++
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 42137f3..25cb6c1 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -615,12 +615,13 @@ void CInode::close_dirfrags()
     close_dirfrag(dirfrags.begin()->first);
 }
 
-bool CInode::has_subtree_root_dirfrag()
+bool CInode::has_subtree_root_dirfrag(int auth)
 {
   for (map<frag_t,CDir*>::iterator p = dirfrags.begin();
        p != dirfrags.end();
        ++p)
-    if (p->second->is_subtree_root())
+    if (p->second->is_subtree_root() &&
+	(auth == -1 || p->second->dir_auth.first == auth))
       return true;
   return false;
 }
diff --git a/src/mds/CInode.h b/src/mds/CInode.h
index f7b8f33..bea7430 100644
--- a/src/mds/CInode.h
+++ b/src/mds/CInode.h
@@ -344,7 +344,7 @@ public:
   CDir *add_dirfrag(CDir *dir);
   void close_dirfrag(frag_t fg);
   void close_dirfrags();
-  bool has_subtree_root_dirfrag();
+  bool has_subtree_root_dirfrag(int auth=-1);
 
   void force_dirfrags();
   void verify_dirfrags();
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index d730ff1..75c7ded 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -3330,8 +3330,10 @@ void MDCache::recalc_auth_bits()
   set<CInode*> subtree_inodes;
   for (map<CDir*,set<CDir*> >::iterator p = subtrees.begin();
        p != subtrees.end();
-       ++p)
-    subtree_inodes.insert(p->first->inode);      
+       ++p) {
+    if (p->first->dir_auth.first == mds->get_nodeid())
+      subtree_inodes.insert(p->first->inode);
+  }
 
   for (map<CDir*,set<CDir*> >::iterator p = subtrees.begin();
        p != subtrees.end();
@@ -3390,11 +3392,8 @@ void MDCache::recalc_auth_bits()
 	    if (dnl->get_inode()->is_dirty())
 	      dnl->get_inode()->mark_clean();
 	    // avoid touching scatterlocks for our subtree roots!
-	    if (subtree_inodes.count(dnl->get_inode()) == 0) {
-	      dnl->get_inode()->filelock.remove_dirty();
-	      dnl->get_inode()->nestlock.remove_dirty();
-	      dnl->get_inode()->dirfragtreelock.remove_dirty();
-	    }
+	    if (subtree_inodes.count(dnl->get_inode()) == 0)
+	      dnl->get_inode()->clear_scatter_dirty();
 	  }
 
 	  // recurse?
diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 9cbad87..49d21ab 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -1095,6 +1095,10 @@ void Migrator::finish_export_inode(CInode *in, utime_t now, list<Context*>& fini
   
   in->clear_dirty_rstat();
 
+  // no more auth subtree? clear scatter dirty
+  if (!in->has_subtree_root_dirfrag(mds->get_nodeid()))
+    in->clear_scatter_dirty();
+
   in->item_open_file.remove_myself();
 
   // waiters
@@ -1534,6 +1538,11 @@ void Migrator::export_finish(CDir *dir)
   cache->adjust_subtree_auth(dir, export_peer[dir]);
   cache->try_subtree_merge(dir);  // NOTE: may journal subtree_map as sideeffect
 
+  // no more auth subtree? clear scatter dirty
+  if (!dir->get_inode()->is_auth() &&
+      !dir->get_inode()->has_subtree_root_dirfrag(mds->get_nodeid()))
+    dir->get_inode()->clear_scatter_dirty();
+
   // unpin path
   export_unlock(dir);
 
@@ -2020,6 +2029,10 @@ void Migrator::import_reverse(CDir *dir)
     cache->trim_non_auth_subtree(dir);
   cache->adjust_subtree_auth(dir, import_peer[dir->dirfrag()]);
 
+  if (!dir->get_inode()->is_auth() &&
+      !dir->get_inode()->has_subtree_root_dirfrag(mds->get_nodeid()))
+    dir->get_inode()->clear_scatter_dirty();
+
   // adjust auth bits.
   list<CDir*> q;
   q.push_back(dir);
@@ -2053,6 +2066,8 @@ void Migrator::import_reverse(CDir *dir)
 	if (in->is_dirty()) 
 	  in->mark_clean();
 	in->clear_dirty_rstat();
+	if (!in->has_subtree_root_dirfrag(mds->get_nodeid()))
+	  in->clear_scatter_dirty();
 
 	in->authlock.clear_gather();
 	in->linklock.clear_gather();
-- 
1.7.11.7

