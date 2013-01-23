From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 02/25] mds: check deleted directory in Server::rdlock_path_xlock_dentry
Date: Wed, 23 Jan 2013 11:08:38 +0800
Message-ID: <1358910541-15535-3-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7278 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab3AWDJH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:07 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Commit b03eab22e4 (mds: forbid creating file in deleted directory)
is not complete, mknod, mkdir and symlink are missed. Move the ckeck
into Server::rdlock_path_xlock_dentry() fixes the issue.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.cc |  5 +----
 src/mds/CInode.h  |  2 --
 src/mds/Server.cc | 25 ++++++++++---------------
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 3009f0c..ebc94ba 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -245,10 +245,7 @@ void CInode::print(ostream& out)
   out << *this;
 }
 
-bool CInode::is_in_stray()
-{
-  return !is_base() && get_projected_parent_dir()->inode->is_stray();
-}
+
 
 void CInode::add_need_snapflush(CInode *snapin, snapid_t snapid, client_t client)
 {
diff --git a/src/mds/CInode.h b/src/mds/CInode.h
index 140353d..f2de6e5 100644
--- a/src/mds/CInode.h
+++ b/src/mds/CInode.h
@@ -524,8 +524,6 @@ private:
 
   bool is_head() { return last == CEPH_NOSNAP; }
 
-  bool is_in_stray();
-
   // note: this overloads MDSCacheObject
   bool is_ambiguous_auth() {
     return state_test(STATE_AMBIGUOUSAUTH) ||
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 45eed81..ebdbfe4 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2019,9 +2019,15 @@ CDentry* Server::rdlock_path_xlock_dentry(MDRequest *mdr, int n,
   }
 
   CInode *diri = dir->get_inode();
-  if (!mdr->reqid.name.is_mds() && diri->is_system() && !diri->is_root()) {
-    reply_request(mdr, -EROFS);
-    return 0;
+  if (!mdr->reqid.name.is_mds()) {
+    if (diri->is_system() && !diri->is_root()) {
+      reply_request(mdr, -EROFS);
+      return 0;
+    }
+    if (!diri->is_base() && diri->get_projected_parent_dir()->inode->is_stray()) {
+      reply_request(mdr, -ENOENT);
+      return 0;
+    }
   }
 
   // make a null dentry?
@@ -2641,13 +2647,6 @@ void Server::handle_client_openc(MDRequest *mdr)
     reply_request(mdr, -EROFS);
     return;
   }
-
-  CInode *diri = dn->get_dir()->get_inode();
-  if (diri->is_in_stray()) {
-    reply_request(mdr, -ENOENT);
-    return;
-  }
-
   // set layout
   ceph_file_layout layout;
   if (dir_layout)
@@ -2684,6 +2683,7 @@ void Server::handle_client_openc(MDRequest *mdr)
     return;
   }
 
+  CInode *diri = dn->get_dir()->get_inode();
   rdlocks.insert(&diri->authlock);
   if (!mds->locker->acquire_locks(mdr, rdlocks, wrlocks, xlocks))
     return;
@@ -5140,11 +5140,6 @@ void Server::handle_client_rename(MDRequest *mdr)
   CDir *destdir = destdn->get_dir();
   assert(destdir->is_auth());
 
-  if (destdir->get_inode()->is_in_stray()) {
-    reply_request(mdr, -ENOENT);
-    return;
-  }
-
   int r = mdcache->path_traverse(mdr, NULL, NULL, srcpath, &srctrace, NULL, MDS_TRAVERSE_DISCOVER);
   if (r > 0)
     return; // delayed
-- 
1.7.11.7

