From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 09/16] mds: check parent inode's versionlock when propagating rstats
Date: Mon, 19 Nov 2012 10:43:41 +0800
Message-ID: <1353293028-15238-10-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17039 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921Ab2KSCoB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:44:01 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

To propagate rstats to one level up, we need lock both parent
inode's nestlock and versionlock.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 88a248b..690c2ed 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -1917,7 +1917,8 @@ void MDCache::predirty_journal_parents(Mutation *mut, EMetaBlob *blob,
     // rstat
     if (!primary_dn) {
       // don't update parent this pass
-    } else if (!linkunlink && !parent->inode->nestlock.can_wrlock(-1)) {
+    } else if (!linkunlink && !(parent->inode->nestlock.can_wrlock(-1) &&
+			        parent->inode->versionlock.can_wrlock())) {
       dout(20) << " unwritable parent nestlock " << parent->inode->nestlock
 	       << ", marking dirty rstat on " << *cur << dendl;
       cur->mark_dirty_rstat();
-- 
1.7.11.7

