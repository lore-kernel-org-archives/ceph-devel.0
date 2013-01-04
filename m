From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 08/29] mds: only export directory fragments in stray to their auth MDS
Date: Fri,  4 Jan 2013 17:01:59 +0800
Message-ID: <1357290140-17044-9-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47205 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752996Ab3ADJCf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:35 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Migrator.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 5db21cd..8686c86 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -642,12 +642,11 @@ void Migrator::export_dir(CDir *dir, int dest)
   }
 
   if (!dir->inode->is_base() && dir->get_parent_dir()->get_inode()->is_stray() &&
-      dir->get_parent_dir()->get_parent_dir()->ino() == MDS_INO_MDSDIR(mds->get_nodeid())) {
+      dir->get_parent_dir()->get_parent_dir()->ino() != MDS_INO_MDSDIR(dest)) {
     dout(7) << "i won't export anything in stray" << dendl;
     return;
   }
 
-
   if (dir->is_frozen() ||
       dir->is_freezing()) {
     dout(7) << " can't export, freezing|frozen.  wait for other exports to finish first." << dendl;
-- 
1.7.11.7

