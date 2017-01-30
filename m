From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 2/5] ceph: vet the parent inode before updating dentry lease
Date: Mon, 30 Jan 2017 11:19:39 -0500
Message-ID: <20170130161942.16537-3-jlayton@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932246AbdA3QTo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Jan 2017 11:19:44 -0500
In-Reply-To: <20170130161942.16537-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

In a later patch, we're going to need to allow ceph_fill_trace to
update the dentry's lease when the parent is not locked. This is
potentially racy though -- by the time we get around to processing the
trace, the parent may have already changed.

Change update_dentry_lease to take a ceph_vino pointer and use that to
ensure that the dentry's parent still matches it before updating the
lease.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/inode.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index ad1ca46a058d..2b4863e82c1d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1016,7 +1016,8 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 static void update_dentry_lease(struct dentry *dentry,
 				struct ceph_mds_reply_lease *lease,
 				struct ceph_mds_session *session,
-				unsigned long from_time)
+				unsigned long from_time,
+				struct ceph_vino *dir_vino)
 {
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	long unsigned duration = le32_to_cpu(lease->duration_ms);
@@ -1031,6 +1032,9 @@ static void update_dentry_lease(struct dentry *dentry,
 	/* make lease_rdcache_gen match directory */
 	dir = d_inode(dentry->d_parent);
 
+	if (!ceph_ino_compare(dir, dir_vino))
+		goto out_unlock;
+
 	/* only track leases on regular dentries */
 	if (ceph_snap(dir) != CEPH_NOSNAP)
 		goto out_unlock;
@@ -1264,10 +1268,12 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 		BUG_ON(!dn);
 		BUG_ON(!dir);
 		BUG_ON(d_inode(dn->d_parent) != dir);
-		BUG_ON(ceph_ino(dir) !=
-		       le64_to_cpu(rinfo->diri.in->ino));
-		BUG_ON(ceph_snap(dir) !=
-		       le64_to_cpu(rinfo->diri.in->snapid));
+
+		vino.ino = le64_to_cpu(rinfo->diri.in->ino);
+		vino.snap = le64_to_cpu(rinfo->diri.in->snapid);
+
+		BUG_ON(ceph_ino(dir) != vino.ino);
+		BUG_ON(ceph_snap(dir) != vino.snap);
 
 		/* do we have a lease on the whole dir? */
 		have_dir_cap =
@@ -1324,7 +1330,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 					d_add(dn, NULL);
 				update_dentry_lease(dn, rinfo->dlease,
 						    session,
-						    req->r_request_started);
+						    req->r_request_started,
+						    &vino);
 			}
 			goto done;
 		}
@@ -1349,7 +1356,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 
 		if (have_lease)
 			update_dentry_lease(dn, rinfo->dlease, session,
-					    req->r_request_started);
+					    req->r_request_started, &vino);
 		dout(" final dn %p\n", dn);
 	} else if (!req->r_aborted &&
 		   (req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
@@ -1617,8 +1624,9 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 		ceph_dentry(dn)->offset = rde->offset;
 
+		vino = ceph_vino(d_inode(parent));
 		update_dentry_lease(dn, rde->lease, req->r_session,
-				    req->r_request_started);
+				    req->r_request_started, &vino);
 
 		if (err == 0 && skipped == 0 && cache_ctl.index >= 0) {
 			ret = fill_readdir_cache(d_inode(parent), dn,
-- 
2.9.3

