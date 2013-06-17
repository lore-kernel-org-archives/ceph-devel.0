From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 6/8] mds: don't journal bare dirfrag
Date: Mon, 17 Jun 2013 20:10:27 +0800
Message-ID: <1371471029-10589-7-git-send-email-zheng.z.yan@intel.com>
References: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48783 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932719Ab3FQMLe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Jun 2013 08:11:34 -0400
In-Reply-To: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

don't journal bare dirfrag when starting scatter. also add debug
code for bare dirfrag modification.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDir.cc   | 1 +
 src/mds/CInode.cc | 2 ++
 src/mds/Server.cc | 5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 211cec0..8c83eba 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -1211,6 +1211,7 @@ void CDir::finish_waiting(uint64_t mask, int result)
 
 fnode_t *CDir::project_fnode()
 {
+  assert(get_version() != 0);
   fnode_t *p = new fnode_t;
   *p = *get_projected_fnode();
   projected_fnode.push_back(p);
diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 4a592bc..8936acd 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -1625,6 +1625,8 @@ void CInode::finish_scatter_update(ScatterLock *lock, CDir *dir,
 
   if (dir->is_frozen()) {
     dout(10) << "finish_scatter_update " << fg << " frozen, marking " << *lock << " stale " << *dir << dendl;
+  } else if (dir->get_version() == 0) {
+    dout(10) << "finish_scatter_update " << fg << " not loaded, marking " << *lock << " stale " << *dir << dendl;
   } else {
     if (dir_accounted_version != inode_version) {
       dout(10) << "finish_scatter_update " << fg << " journaling accounted scatterstat update v" << inode_version << dendl;
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 00bf018..1d16d04 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -4010,7 +4010,8 @@ public:
     if (newi->inode.is_dir()) { 
       CDir *dir = newi->get_dirfrag(frag_t());
       assert(dir);
-      dir->mark_dirty(1, mdr->ls);
+      dir->fnode.version--;
+      dir->mark_dirty(dir->fnode.version + 1, mdr->ls);
       dir->mark_new(mdr->ls);
     }
 
@@ -4169,7 +4170,7 @@ void Server::handle_client_mkdir(MDRequest *mdr)
   // ...and that new dir is empty.
   CDir *newdir = newi->get_or_open_dirfrag(mds->mdcache, frag_t());
   newdir->mark_complete();
-  newdir->pre_dirty();
+  newdir->fnode.version = newdir->pre_dirty();
 
   // prepare finisher
   mdr->ls = mdlog->get_current_segment();
-- 
1.8.1.4

