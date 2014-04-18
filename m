From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 6/6] ceph: remember subtree root dirfrag's auth MDS
Date: Fri, 18 Apr 2014 22:48:42 +0800
Message-ID: <1397832522-9557-6-git-send-email-zheng.z.yan@intel.com>
References: <1397832522-9557-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42749 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbaDROtQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Apr 2014 10:49:16 -0400
In-Reply-To: <1397832522-9557-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

remember dirfrag's auth MDS when it's different from its parent inode's
auth MDS.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 80528ff..7736097 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -245,11 +245,17 @@ static int ceph_fill_dirfrag(struct inode *inode,
 	u32 id = le32_to_cpu(dirinfo->frag);
 	int mds = le32_to_cpu(dirinfo->auth);
 	int ndist = le32_to_cpu(dirinfo->ndist);
+	int diri_auth = -1;
 	int i;
 	int err = 0;
 
+	spin_lock(&ci->i_ceph_lock);
+	if (ci->i_auth_cap)
+		diri_auth = ci->i_auth_cap->mds;
+	spin_unlock(&ci->i_ceph_lock);
+
 	mutex_lock(&ci->i_fragtree_mutex);
-	if (ndist == 0) {
+	if (ndist == 0 && mds == diri_auth) {
 		/* no delegation info needed. */
 		frag = __ceph_find_frag(ci, id);
 		if (!frag)
-- 
1.9.0

