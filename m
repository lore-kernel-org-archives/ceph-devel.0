From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/8] mds: handle undefined dirfrags when opening inode
Date: Mon, 17 Jun 2013 20:10:24 +0800
Message-ID: <1371471029-10589-4-git-send-email-zheng.z.yan@intel.com>
References: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1943 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932719Ab3FQMLn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Jun 2013 08:11:43 -0400
In-Reply-To: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When MDS is rejoin stage, cache rejoin message can add undefined
inodes and dirfrags to the cache. These undefined objects can affect
"lookup-by-ino" processes. If an undefined dirfrag is encountered,
we should fetch it from disk.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 37 +++++++++++++++++++++++++++++++++----
 src/mds/MDCache.h  |  1 +
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 2b7ad71..b9b154d 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -8015,6 +8015,29 @@ void MDCache::_open_ino_traverse_dir(inodeno_t ino, open_ino_info_t& info, int r
   do_open_ino(ino, info, ret);
 }
 
+void MDCache::_open_ino_fetch_dir(inodeno_t ino, MMDSOpenIno *m, CDir *dir)
+{
+  if (dir->state_test(CDir::STATE_REJOINUNDEF) && dir->get_frag() == frag_t()) {
+    rejoin_undef_dirfrags.erase(dir);
+    dir->state_clear(CDir::STATE_REJOINUNDEF);
+
+    CInode *diri = dir->get_inode();
+    diri->force_dirfrags();
+    list<CDir*> ls;
+    diri->get_dirfrags(ls);
+
+    C_GatherBuilder gather(g_ceph_context, _open_ino_get_waiter(ino, m));
+    for (list<CDir*>::iterator p = ls.begin(); p != ls.end(); ++p) {
+      rejoin_undef_dirfrags.insert(*p);
+      (*p)->state_set(CDir::STATE_REJOINUNDEF);
+      (*p)->fetch(gather.new_sub());
+    }
+    assert(gather.has_subs());
+    gather.activate();
+  } else
+    dir->fetch(_open_ino_get_waiter(ino, m));
+}
+
 int MDCache::open_ino_traverse_dir(inodeno_t ino, MMDSOpenIno *m,
 				   vector<inode_backpointer_t>& ancestors,
 				   bool discover, bool want_xlocked, int *hint)
@@ -8032,8 +8055,14 @@ int MDCache::open_ino_traverse_dir(inodeno_t ino, MMDSOpenIno *m,
       continue;
     }
 
-    if (diri->state_test(CInode::STATE_REJOINUNDEF))
-      continue;
+    if (diri->state_test(CInode::STATE_REJOINUNDEF)) {
+      CDir *dir = diri->get_parent_dir();
+      while (dir->state_test(CDir::STATE_REJOINUNDEF) &&
+	     dir->get_inode()->state_test(CInode::STATE_REJOINUNDEF))
+	dir = dir->get_inode()->get_parent_dir();
+      _open_ino_fetch_dir(ino, m, dir);
+      return 1;
+    }
 
     if (!diri->is_dir()) {
       dout(10) << " " << *diri << " is not dir" << dendl;
@@ -8067,14 +8096,14 @@ int MDCache::open_ino_traverse_dir(inodeno_t ino, MMDSOpenIno *m,
 	if (dnl && dnl->is_primary() &&
 	    dnl->get_inode()->state_test(CInode::STATE_REJOINUNDEF)) {
 	  dout(10) << " fetching undef " << *dnl->get_inode() << dendl;
-	  dir->fetch(_open_ino_get_waiter(ino, m));
+	  _open_ino_fetch_dir(ino, m, dir);
 	  return 1;
 	}
 
 	if (!dnl && !dir->is_complete() &&
 	    (!dir->has_bloom() || dir->is_in_bloom(name))) {
 	  dout(10) << " fetching incomplete " << *dir << dendl;
-	  dir->fetch(_open_ino_get_waiter(ino, m));
+	  _open_ino_fetch_dir(ino, m, dir);
 	  return 1;
 	}
 
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index 3da8a36..36a322c 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -790,6 +790,7 @@ protected:
   void _open_ino_backtrace_fetched(inodeno_t ino, bufferlist& bl, int err);
   void _open_ino_parent_opened(inodeno_t ino, int ret);
   void _open_ino_traverse_dir(inodeno_t ino, open_ino_info_t& info, int err);
+  void _open_ino_fetch_dir(inodeno_t ino, MMDSOpenIno *m, CDir *dir);
   Context* _open_ino_get_waiter(inodeno_t ino, MMDSOpenIno *m);
   int open_ino_traverse_dir(inodeno_t ino, MMDSOpenIno *m,
 			    vector<inode_backpointer_t>& ancestors,
-- 
1.8.1.4

