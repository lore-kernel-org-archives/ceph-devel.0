From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 08/12] mds: Allow export subtrees in other MDS' stray directory
Date: Tue,  2 Oct 2012 16:55:48 +0800
Message-ID: <1349168152-13281-8-git-send-email-zheng.z.yan@intel.com>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51424 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858Ab2JBI4Q (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Oct 2012 04:56:16 -0400
In-Reply-To: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Stray migration is implemented by rename, it may create auth subtrees
in other MDS' stray directory.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Migrator.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 5f727a9..98ab4e1 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -640,7 +640,8 @@ void Migrator::export_dir(CDir *dir, int dest)
     return;
   }
 
-  if (!dir->inode->is_base() && dir->inode->get_parent_dir()->get_inode()->is_stray()) {
+  if (!dir->inode->is_base() &&
+      dir->inode->get_parent_dir()->ino() == MDS_INO_MDSDIR(mds->get_nodeid())) {
     dout(7) << "i won't export anything in stray" << dendl;
     return;
   }
-- 
1.7.11.4

