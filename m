From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/6] ceph: move dirty inode to migrating list when clearing auth caps
Date: Fri,  4 Jan 2013 19:34:17 +0800
Message-ID: <1357299261-20591-3-git-send-email-zheng.z.yan@intel.com>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48663 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870Ab3ADLe3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 06:34:29 -0500
In-Reply-To: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index a1d9bb3..a9fe2d5 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -611,8 +611,16 @@ retry:
 
 	if (flags & CEPH_CAP_FLAG_AUTH)
 		ci->i_auth_cap = cap;
-	else if (ci->i_auth_cap == cap)
+	else if (ci->i_auth_cap == cap) {
 		ci->i_auth_cap = NULL;
+		spin_lock(&mdsc->cap_dirty_lock);
+		if (!list_empty(&ci->i_dirty_item)) {
+			dout(" moving %p to cap_dirty_migrating\n", inode);
+			list_move(&ci->i_dirty_item,
+				  &mdsc->cap_dirty_migrating);
+		}
+		spin_unlock(&mdsc->cap_dirty_lock);
+	}
 
 	dout("add_cap inode %p (%llx.%llx) cap %p %s now %s seq %d mds%d\n",
 	     inode, ceph_vinop(inode), cap, ceph_cap_string(issued),
-- 
1.7.11.7

