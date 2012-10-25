From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/4] mds: Fix stray check in Migrator::export_dir()
Date: Thu, 25 Oct 2012 20:26:50 +0800
Message-ID: <1351168012-4981-2-git-send-email-zheng.z.yan@intel.com>
References: <1351168012-4981-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50693 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758904Ab2JYM07 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Oct 2012 08:26:59 -0400
In-Reply-To: <1351168012-4981-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Commit f8110c (Allow export subtrees in other MDS' stray directory)
make the "directory in stray " check always return false. This is
because the directory in question is grandchild of mdsdir.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Migrator.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 98ab4e1..9829d68 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -640,8 +640,8 @@ void Migrator::export_dir(CDir *dir, int dest)
     return;
   }
 
-  if (!dir->inode->is_base() &&
-      dir->inode->get_parent_dir()->ino() == MDS_INO_MDSDIR(mds->get_nodeid())) {
+  if (!dir->inode->is_base() && dir->get_parent_dir()->get_inode()->is_stray() &&
+      dir->get_parent_dir()->get_parent_dir()->ino() == MDS_INO_MDSDIR(mds->get_nodeid())) {
     dout(7) << "i won't export anything in stray" << dendl;
     return;
   }
-- 
1.7.11.7

