From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 1/8] ceph: remove "Debugging hook" from ceph_fill_trace
Date: Fri,  3 Feb 2017 13:03:57 -0500
Message-ID: <20170203180404.31930-2-jlayton@redhat.com>
References: <20170201114914.20808-1-jlayton@redhat.com>
 <20170203180404.31930-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbdBCSEH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 3 Feb 2017 13:04:07 -0500
In-Reply-To: <20170203180404.31930-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

Keeping around commented out code is just asking for it to bitrot and
makes viewing the code under cscope more confusing.  If
we really need this, then we can revert this patch and put it under a
Kconfig option.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/inode.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 4926265f4223..38a54ebf647d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1120,40 +1120,6 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 	dout("fill_trace %p is_dentry %d is_target %d\n", req,
 	     rinfo->head->is_dentry, rinfo->head->is_target);
 
-#if 0
-	/*
-	 * Debugging hook:
-	 *
-	 * If we resend completed ops to a recovering mds, we get no
-	 * trace.  Since that is very rare, pretend this is the case
-	 * to ensure the 'no trace' handlers in the callers behave.
-	 *
-	 * Fill in inodes unconditionally to avoid breaking cap
-	 * invariants.
-	 */
-	if (rinfo->head->op & CEPH_MDS_OP_WRITE) {
-		pr_info("fill_trace faking empty trace on %lld %s\n",
-			req->r_tid, ceph_mds_op_name(rinfo->head->op));
-		if (rinfo->head->is_dentry) {
-			rinfo->head->is_dentry = 0;
-			err = fill_inode(req->r_locked_dir,
-					 &rinfo->diri, rinfo->dirfrag,
-					 session, req->r_request_started, -1);
-		}
-		if (rinfo->head->is_target) {
-			rinfo->head->is_target = 0;
-			ininfo = rinfo->targeti.in;
-			vino.ino = le64_to_cpu(ininfo->ino);
-			vino.snap = le64_to_cpu(ininfo->snapid);
-			in = ceph_get_inode(sb, vino);
-			err = fill_inode(in, &rinfo->targeti, NULL,
-					 session, req->r_request_started,
-					 req->r_fmode);
-			iput(in);
-		}
-	}
-#endif
-
 	if (!rinfo->head->is_target && !rinfo->head->is_dentry) {
 		dout("fill_trace reply is empty!\n");
 		if (rinfo->head->result == 0 && req->r_locked_dir)
-- 
2.9.3

