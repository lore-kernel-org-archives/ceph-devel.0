From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: Fix oops when mounting cephfs with non-existing path
Date: Fri, 17 Aug 2012 13:55:59 +0800
Message-ID: <1345182959-6486-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:32012 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab2HQF4C (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Aug 2012 01:56:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

req->r_locked_dir is NULL if the request was created by
open_root_dentry(). ceph_fill_trace() lacks check for this case.
It causes oops when mounting cephfs with non-existing path.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 9fff9f3..40e2ef1 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -992,6 +992,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 	if (rinfo->head->is_dentry) {
 		struct inode *dir = req->r_locked_dir;
 
+		/*
+		 * req->r_locked_dir is null if the request was created
+		 * by open_root_dentry()
+		 */
+		if (!dir)
+			return le32_to_cpu(rinfo->head->result);
+
 		err = fill_inode(dir, &rinfo->diri, rinfo->dirfrag,
 				 session, req->r_request_started, -1,
 				 &req->r_caps_reservation);
-- 
1.7.11.2

