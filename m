From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 4/6] ceph: Don't add dirty inode to dirty list if caps is in migration
Date: Mon, 19 Nov 2012 10:49:07 +0800
Message-ID: <1353293349-15494-5-git-send-email-zheng.z.yan@intel.com>
References: <1353293349-15494-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10829 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab2KSCtR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:49:17 -0500
In-Reply-To: <1353293349-15494-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Add dirty inode to cap_dirty_migrating list instead, this can avoid
ceph_flush_dirty_caps() entering infinite loop.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 8072aef..5efa3f5 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1351,11 +1351,15 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask)
 		if (!ci->i_head_snapc)
 			ci->i_head_snapc = ceph_get_snap_context(
 				ci->i_snap_realm->cached_context);
-		dout(" inode %p now dirty snapc %p\n", &ci->vfs_inode,
-			ci->i_head_snapc);
+		dout(" inode %p now dirty snapc %p auth cap %p\n",
+		     &ci->vfs_inode, ci->i_head_snapc, ci->i_auth_cap);
 		BUG_ON(!list_empty(&ci->i_dirty_item));
 		spin_lock(&mdsc->cap_dirty_lock);
-		list_add(&ci->i_dirty_item, &mdsc->cap_dirty);
+		if (ci->i_auth_cap)
+			list_add(&ci->i_dirty_item, &mdsc->cap_dirty);
+		else
+			list_add(&ci->i_dirty_item,
+				 &mdsc->cap_dirty_migrating);
 		spin_unlock(&mdsc->cap_dirty_lock);
 		if (ci->i_flushing_caps == 0) {
 			ihold(inode);
-- 
1.7.11.7

