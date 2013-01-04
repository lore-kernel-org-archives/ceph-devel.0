From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 17/29] mds: call maybe_eval_stray after removing a replica dentry
Date: Fri,  4 Jan 2013 17:02:08 +0800
Message-ID: <1357290140-17044-18-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28255 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab3ADJCp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:45 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

MDCache::handle_cache_expire() processes dentries after inodes, so the
MDCache::maybe_eval_stray() in MDCache::inode_remove_replica() always
fails to remove stray inode because MDCache::eval_stray() checks if the
stray inode's dentry is replicated.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 3410b0f..5adf4b7 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -6120,9 +6120,11 @@ void MDCache::dentry_remove_replica(CDentry *dn, int from)
   // fix lock
   if (dn->lock.remove_replica(from))
     mds->locker->eval_gather(&dn->lock);
-}
-
 
+  CDentry::linkage_t *dnl = dn->get_projected_linkage();
+  if (dnl->is_primary())
+    maybe_eval_stray(dnl->get_inode());
+}
 
 void MDCache::trim_client_leases()
 {
-- 
1.7.11.7

