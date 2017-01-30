From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 3/5] ceph: clean up r_aborted handling in ceph_fill_trace
Date: Mon, 30 Jan 2017 11:19:40 -0500
Message-ID: <20170130161942.16537-4-jlayton@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753639AbdA3QTp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Jan 2017 11:19:45 -0500
In-Reply-To: <20170130161942.16537-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

When r_aborted is true, then we can just "goto done".

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 2b4863e82c1d..b5d4594b434d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1247,12 +1247,14 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 		}
 	}
 
+	if (req->r_aborted)
+		goto done;
+
 	/*
 	 * ignore null lease/binding on snapdir ENOENT, or else we
 	 * will have trouble splicing in the virtual snapdir later
 	 */
-	if (rinfo->head->is_dentry && !req->r_aborted &&
-	    req->r_locked_dir &&
+	if (rinfo->head->is_dentry && req->r_locked_dir &&
 	    (rinfo->head->is_target || strncmp(req->r_dentry->d_name.name,
 					       fsc->mount_options->snapdir_name,
 					       req->r_dentry->d_name.len))) {
@@ -1358,9 +1360,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 			update_dentry_lease(dn, rinfo->dlease, session,
 					    req->r_request_started, &vino);
 		dout(" final dn %p\n", dn);
-	} else if (!req->r_aborted &&
-		   (req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
-		    req->r_op == CEPH_MDS_OP_MKSNAP)) {
+	} else if (req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
+		   req->r_op == CEPH_MDS_OP_MKSNAP) {
 		struct dentry *dn = req->r_dentry;
 		struct inode *dir = req->r_locked_dir;
 
-- 
2.9.3

