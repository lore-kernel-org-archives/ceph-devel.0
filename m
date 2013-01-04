From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 10/29] mds: skip frozen inode when assimilating dirty inodes' rstat
Date: Fri,  4 Jan 2013 17:02:01 +0800
Message-ID: <1357290140-17044-11-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17477 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454Ab3ADJCj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:39 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

CDir::assimilate_dirty_rstat_inodes() may encounter frozen inodes that
are being renamed. Skip these frozen inodes because assimilating inode's
rstat require auth pinning the inode.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDir.cc | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 20ff469..91636cc 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -1022,6 +1022,9 @@ void CDir::assimilate_dirty_rstat_inodes()
   for (elist<CInode*>::iterator p = dirty_rstat_inodes.begin_use_current();
        !p.end(); ++p) {
     CInode *in = *p;
+    if (in->is_frozen())
+      continue;
+
     inode_t *pi = in->project_inode();
     pi->version = in->pre_dirty();
 
@@ -1040,16 +1043,22 @@ void CDir::assimilate_dirty_rstat_inodes_finish(Mutation *mut, EMetaBlob *blob)
   elist<CInode*>::iterator p = dirty_rstat_inodes.begin_use_current();
   while (!p.end()) {
     CInode *in = *p;
-    CDentry *dn = in->get_projected_parent_dn();
     ++p;
 
+    if (in->is_frozen())
+      continue;
+
+    CDentry *dn = in->get_projected_parent_dn();
+
     mut->auth_pin(in);
     mut->add_projected_inode(in);
 
     in->clear_dirty_rstat();
     blob->add_primary_dentry(dn, true, in);
   }
-  assert(dirty_rstat_inodes.empty());
+
+  if (!dirty_rstat_inodes.empty())
+    inode->mdcache->mds->locker->mark_updated_scatterlock(&inode->nestlock);
 }
 
 
-- 
1.7.11.7

