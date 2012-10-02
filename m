From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 04/12] mds: Allow rename request for stray migration/reintegration
Date: Tue,  2 Oct 2012 16:55:44 +0800
Message-ID: <1349168152-13281-4-git-send-email-zheng.z.yan@intel.com>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51424 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754782Ab2JBI4H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Oct 2012 04:56:07 -0400
In-Reply-To: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Allow rename request to modify system directory if it is for stray
migration/reintegration.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 4c52ca2..8584e60 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -1983,7 +1983,7 @@ CDentry* Server::rdlock_path_xlock_dentry(MDRequest *mdr, int n,
   }
 
   CInode *diri = dir->get_inode();
-  if (diri->is_system() && !diri->is_root()) {
+  if (!mdr->reqid.name.is_mds() && diri->is_system() && !diri->is_root()) {
     reply_request(mdr, -EROFS);
     return 0;
   }
@@ -5126,10 +5126,12 @@ void Server::handle_client_rename(MDRequest *mdr)
     pdn = pdn->get_dir()->inode->parent;
   }
 
-  // is this a stray reintegration or merge? (sanity checks!)
+  // is this a stray migration, reintegration or merge? (sanity checks!)
   if (mdr->reqid.name.is_mds() &&
-      (!destdnl->is_remote() ||
-       destdnl->get_remote_ino() != srci->ino())) {
+      !(MDS_INO_IS_STRAY(srcpath.get_ino()) &&
+	MDS_INO_IS_STRAY(destpath.get_ino())) &&
+      !(destdnl->is_remote() &&
+	destdnl->get_remote_ino() == srci->ino())) {
     reply_request(mdr, -EINVAL);  // actually, this won't reply, but whatev.
     return;
   }
-- 
1.7.11.4

