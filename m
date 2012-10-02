From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 07/12] mds: Avoid save unnecessary parent snaprealm
Date: Tue,  2 Oct 2012 16:55:47 +0800
Message-ID: <1349168152-13281-7-git-send-email-zheng.z.yan@intel.com>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51424 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674Ab2JBI4O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Oct 2012 04:56:14 -0400
In-Reply-To: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We can avoid save parent snaprealm if current_parent_since is greater
than parent snaprealm's newest sequence.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.cc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 8fed424..8566e55 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -386,8 +386,10 @@ void CInode::project_past_snaprealm_parent(SnapRealm *newparent)
 
   if (newparent != oldparent) {
     snapid_t oldparentseq = oldparent->get_newest_seq();
-    new_snap->past_parents[oldparentseq].ino = oldparent->inode->ino();
-    new_snap->past_parents[oldparentseq].first = new_snap->current_parent_since;
+    if (oldparentseq + 1 > new_snap->current_parent_since) {
+      new_snap->past_parents[oldparentseq].ino = oldparent->inode->ino();
+      new_snap->past_parents[oldparentseq].first = new_snap->current_parent_since;
+    }
     new_snap->current_parent_since = MAX(oldparentseq, newparent->get_last_created()) + 1;
   }
 }
-- 
1.7.11.4

