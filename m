From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 04/11] ceph: fix trim caps
Date: Tue, 21 Jan 2014 12:15:38 +0800
Message-ID: <1390277745-20142-4-git-send-email-zheng.z.yan@intel.com>
References: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62235 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916AbaAUEPx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Jan 2014 23:15:53 -0500
In-Reply-To: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

- don't trim auth cap if there are flusing caps
- don't trim auth cap if any 'write' cap is wanted
- allow trimming non-auth cap even if the inode is dirty

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/mds_client.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4a13f6e..73c7943 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1214,7 +1214,7 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
 {
 	struct ceph_mds_session *session = arg;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	int used, oissued, mine;
+	int used, wanted, oissued, mine;
 
 	if (session->s_trim_caps <= 0)
 		return -1;
@@ -1222,14 +1222,19 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
 	spin_lock(&ci->i_ceph_lock);
 	mine = cap->issued | cap->implemented;
 	used = __ceph_caps_used(ci);
+	wanted = __ceph_caps_file_wanted(ci);
 	oissued = __ceph_caps_issued_other(ci, cap);
 
-	dout("trim_caps_cb %p cap %p mine %s oissued %s used %s\n",
+	dout("trim_caps_cb %p cap %p mine %s oissued %s used %s wanted %s\n",
 	     inode, cap, ceph_cap_string(mine), ceph_cap_string(oissued),
-	     ceph_cap_string(used));
-	if (ci->i_dirty_caps)
-		goto out;   /* dirty caps */
-	if ((used & ~oissued) & mine)
+	     ceph_cap_string(used), ceph_cap_string(wanted));
+	if (cap == ci->i_auth_cap) {
+		if (ci->i_dirty_caps | ci->i_flushing_caps)
+			goto out;
+		if ((used | wanted) & CEPH_CAP_ANY_WR)
+			goto out;
+	}
+	if ((used | wanted) & ~oissued & mine)
 		goto out;   /* we need these caps */
 
 	session->s_trim_caps--;
-- 
1.8.4.2

