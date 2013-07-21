From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] ceph: drop CAP_LINK_SHARED when sending "link" request to MDS
Date: Sun, 21 Jul 2013 20:25:25 +0800
Message-ID: <1374409526-8297-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:10716 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754895Ab3GUMZd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 21 Jul 2013 08:25:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

To handle "link" request, the MDS need to xlock inode's linklock,
which requires revoking any CAP_LINK_SHARED.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index f02d82b..0e4da4a 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -796,6 +796,8 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 	req->r_locked_dir = dir;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
+	/* release LINK_SHARED on source inode (mds will lock it) */
+	req->r_old_inode_drop = CEPH_CAP_LINK_SHARED;
 	err = ceph_mdsc_do_request(mdsc, dir, req);
 	if (err) {
 		d_drop(dentry);
-- 
1.8.1.4

