From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 5/5] ceph: do a LOOKUP in d_revalidate instead of GETATTR
Date: Mon, 30 Jan 2017 11:19:42 -0500
Message-ID: <20170130161942.16537-6-jlayton@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932165AbdA3QTq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Jan 2017 11:19:46 -0500
In-Reply-To: <20170130161942.16537-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

In commit c3f4688a08f (ceph: don't set req->r_locked_dir in
ceph_d_revalidate), we changed the code to do a GETATTR instead of a
LOOKUP as the parent info isn't strictly necessary to revalidate the
dentry. What we missed there though is that in order to update the lease
on the dentry after revalidating it, we _do_ need parent info.

Change ceph_d_revalidate back to doing a LOOKUP instead of a GETATTR so
that we can get the parent info in order to update the lease from
ceph_fill_trace. Note too that because we don't set r_locked_dir in this
codepath, we must also  remove the WARN_ON_ONCE from ceph_fill_trace or
it will pop here.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/dir.c   | 4 ++--
 fs/ceph/inode.c | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index d4385563b70a..33da70514a95 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1237,11 +1237,11 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 			return -ECHILD;
 
 		op = ceph_snap(dir) == CEPH_SNAPDIR ?
-			CEPH_MDS_OP_LOOKUPSNAP : CEPH_MDS_OP_GETATTR;
+			CEPH_MDS_OP_LOOKUPSNAP : CEPH_MDS_OP_LOOKUP;
 		req = ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS);
 		if (!IS_ERR(req)) {
 			req->r_dentry = dget(dentry);
-			req->r_num_caps = op == CEPH_MDS_OP_GETATTR ? 1 : 2;
+			req->r_num_caps = 2;
 
 			mask = CEPH_STAT_CAP_INODE | CEPH_CAP_AUTH_SHARED;
 			if (ceph_security_xattr_wanted(dir))
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index bb2413d711ce..870a0cfb8647 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1175,8 +1175,6 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 					 &req->r_caps_reservation);
 			if (err < 0)
 				goto done;
-		} else {
-			WARN_ON_ONCE(1);
 		}
 
 		if (dir && req->r_op == CEPH_MDS_OP_LOOKUPNAME) {
-- 
2.9.3

