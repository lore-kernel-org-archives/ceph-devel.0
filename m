From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 5/6] ceph: Fix __ceph_do_pending_vmtruncate
Date: Mon, 19 Nov 2012 10:49:08 +0800
Message-ID: <1353293349-15494-6-git-send-email-zheng.z.yan@intel.com>
References: <1353293349-15494-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10829 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786Ab2KSCtS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:49:18 -0500
In-Reply-To: <1353293349-15494-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

we should set i_truncate_pending to 0 after page cache is truncated
to i_truncate_size

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 4b5762e..81613bc 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1466,7 +1466,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u64 to;
-	int wrbuffer_refs, wake = 0;
+	int wrbuffer_refs, finish = 0;
 
 retry:
 	spin_lock(&ci->i_ceph_lock);
@@ -1498,15 +1498,18 @@ retry:
 	truncate_inode_pages(inode->i_mapping, to);
 
 	spin_lock(&ci->i_ceph_lock);
-	ci->i_truncate_pending--;
-	if (ci->i_truncate_pending == 0)
-		wake = 1;
+	if (to == ci->i_truncate_size) {
+		ci->i_truncate_pending = 0;
+		finish = 1;
+	}
 	spin_unlock(&ci->i_ceph_lock);
+	if (!finish)
+		goto retry;
 
 	if (wrbuffer_refs == 0)
 		ceph_check_caps(ci, CHECK_CAPS_AUTHONLY, NULL);
-	if (wake)
-		wake_up_all(&ci->i_cap_wq);
+
+	wake_up_all(&ci->i_cap_wq);
 }
 
 
-- 
1.7.11.7

