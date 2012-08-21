From: Sage Weil <sage@inktank.com>
Subject: [PATCH 2/4] ceph: tolerate (and warn on) extraneous dentry from mds
Date: Tue, 21 Aug 2012 12:19:30 -0700
Message-ID: <1345576772-3284-3-git-send-email-sage@inktank.com>
References: <1345576772-3284-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42592 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756618Ab2HUTHT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Aug 2012 15:07:19 -0400
In-Reply-To: <1345576772-3284-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

If the MDS gives us a dentry and we weren't prepared to handle it,
WARN_ON_ONCE instead of crashing.

Reported-by: Yan, Zheng <zheng.z.yan@intel.com>
Signed-off-by: Sage Weil <sage@inktank.com>
---
 fs/ceph/inode.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 9fff9f3..4b5762e 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -992,11 +992,15 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 	if (rinfo->head->is_dentry) {
 		struct inode *dir = req->r_locked_dir;
 
-		err = fill_inode(dir, &rinfo->diri, rinfo->dirfrag,
-				 session, req->r_request_started, -1,
-				 &req->r_caps_reservation);
-		if (err < 0)
-			return err;
+		if (dir) {
+			err = fill_inode(dir, &rinfo->diri, rinfo->dirfrag,
+					 session, req->r_request_started, -1,
+					 &req->r_caps_reservation);
+			if (err < 0)
+				return err;
+		} else {
+			WARN_ON_ONCE(1);
+		}
 	}
 
 	/*
@@ -1004,6 +1008,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 	 * will have trouble splicing in the virtual snapdir later
 	 */
 	if (rinfo->head->is_dentry && !req->r_aborted &&
+	    req->r_locked_dir &&
 	    (rinfo->head->is_target || strncmp(req->r_dentry->d_name.name,
 					       fsc->mount_options->snapdir_name,
 					       req->r_dentry->d_name.len))) {
-- 
1.7.9

