From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 20/29] mds: forbid creating file in deleted directory
Date: Fri,  4 Jan 2013 17:02:11 +0800
Message-ID: <1357290140-17044-21-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6783 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995Ab3ADJCt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:49 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.cc |  5 ++++-
 src/mds/CInode.h  |  2 ++
 src/mds/Server.cc | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 9d29b46..4314ab5 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -245,7 +245,10 @@ void CInode::print(ostream& out)
   out << *this;
 }
 
-
+bool CInode::is_in_stray()
+{
+  return !is_base() && get_projected_parent_dir()->inode->is_stray();
+}
 
 void CInode::add_need_snapflush(CInode *snapin, snapid_t snapid, client_t client)
 {
diff --git a/src/mds/CInode.h b/src/mds/CInode.h
index a627a4f..6eb396d 100644
--- a/src/mds/CInode.h
+++ b/src/mds/CInode.h
@@ -520,6 +520,8 @@ private:
 
   bool is_head() { return last == CEPH_NOSNAP; }
 
+  bool is_in_stray();
+
   // note: this overloads MDSCacheObject
   bool is_ambiguous_auth() {
     return state_test(STATE_AMBIGUOUSAUTH) ||
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 517339f..8d05a37 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2633,6 +2633,13 @@ void Server::handle_client_openc(MDRequest *mdr)
     reply_request(mdr, -EROFS);
     return;
   }
+
+  CInode *diri = dn->get_dir()->get_inode();
+  if (diri->is_in_stray()) {
+    reply_request(mdr, -ENOENT);
+    return;
+  }
+
   // set layout
   ceph_file_layout layout;
   if (dir_layout)
@@ -2669,7 +2676,6 @@ void Server::handle_client_openc(MDRequest *mdr)
     return;
   }
 
-  CInode *diri = dn->get_dir()->get_inode();
   rdlocks.insert(&diri->authlock);
   if (!mds->locker->acquire_locks(mdr, rdlocks, wrlocks, xlocks))
     return;
@@ -5123,6 +5129,11 @@ void Server::handle_client_rename(MDRequest *mdr)
   CDir *destdir = destdn->get_dir();
   assert(destdir->is_auth());
 
+  if (destdir->get_inode()->is_in_stray()) {
+    reply_request(mdr, -ENOENT);
+    return;
+  }
+
   int r = mdcache->path_traverse(mdr, NULL, NULL, srcpath, &srctrace, NULL, MDS_TRAVERSE_DISCOVER);
   if (r > 0)
     return; // delayed
-- 
1.7.11.7

