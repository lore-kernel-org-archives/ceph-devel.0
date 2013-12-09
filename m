From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH V2] ceph: initialize inode before instantiating dentry
Date: Mon,  9 Dec 2013 11:21:12 +0800
Message-ID: <1386559272-9441-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1671 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932105Ab3LIDVR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 8 Dec 2013 22:21:17 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, dave@bob-the-boat.me.uk, malcolm@sgi.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

commit b18825a7c8 (Put a small type field into struct dentry::d_flags)
put a type field into struct dentry::d_flags. __d_instantiate() set the
field by checking inode->i_mode. So we should initialize inode before
instantiating dentry when handling mds reply.

Fixes: #6930
Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
Changes since v1:
 - set dentry offset after calling splice_dentry(). because the dentry
   may be spliced.

---
 fs/ceph/inode.c | 136 ++++++++++++++++++++++++--------------------------------
 1 file changed, 58 insertions(+), 78 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 9a8e396..b11c360 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -978,7 +978,6 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 	struct ceph_mds_reply_inode *ininfo;
 	struct ceph_vino vino;
 	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
-	int i = 0;
 	int err = 0;
 
 	dout("fill_trace %p is_dentry %d is_target %d\n", req,
@@ -1039,6 +1038,29 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 		}
 	}
 
+	if (rinfo->head->is_target) {
+		vino.ino = le64_to_cpu(rinfo->targeti.in->ino);
+		vino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
+
+		in = ceph_get_inode(sb, vino);
+		if (IS_ERR(in)) {
+			err = PTR_ERR(in);
+			goto done;
+		}
+		req->r_target_inode = in;
+
+		err = fill_inode(in, &rinfo->targeti, NULL,
+				session, req->r_request_started,
+				(le32_to_cpu(rinfo->head->result) == 0) ?
+				req->r_fmode : -1,
+				&req->r_caps_reservation);
+		if (err < 0) {
+			pr_err("fill_inode badness %p %llx.%llx\n",
+				in, ceph_vinop(in));
+			goto done;
+		}
+	}
+
 	/*
 	 * ignore null lease/binding on snapdir ENOENT, or else we
 	 * will have trouble splicing in the virtual snapdir later
@@ -1108,7 +1130,6 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 			     ceph_dentry(req->r_old_dentry)->offset);
 
 			dn = req->r_old_dentry;  /* use old_dentry */
-			in = dn->d_inode;
 		}
 
 		/* null dentry? */
@@ -1130,44 +1151,28 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 		}
 
 		/* attach proper inode */
-		ininfo = rinfo->targeti.in;
-		vino.ino = le64_to_cpu(ininfo->ino);
-		vino.snap = le64_to_cpu(ininfo->snapid);
-		in = dn->d_inode;
-		if (!in) {
-			in = ceph_get_inode(sb, vino);
-			if (IS_ERR(in)) {
-				pr_err("fill_trace bad get_inode "
-				       "%llx.%llx\n", vino.ino, vino.snap);
-				err = PTR_ERR(in);
-				d_drop(dn);
-				goto done;
-			}
+		if (!dn->d_inode) {
+			ihold(in);
 			dn = splice_dentry(dn, in, &have_lease, true);
 			if (IS_ERR(dn)) {
 				err = PTR_ERR(dn);
 				goto done;
 			}
 			req->r_dentry = dn;  /* may have spliced */
-			ihold(in);
-		} else if (ceph_ino(in) == vino.ino &&
-			   ceph_snap(in) == vino.snap) {
-			ihold(in);
-		} else {
+		} else if (dn->d_inode && dn->d_inode != in) {
 			dout(" %p links to %p %llx.%llx, not %llx.%llx\n",
-			     dn, in, ceph_ino(in), ceph_snap(in),
-			     vino.ino, vino.snap);
+			     dn, dn->d_inode, ceph_vinop(dn->d_inode),
+			     ceph_vinop(in));
 			have_lease = false;
-			in = NULL;
 		}
 
 		if (have_lease)
 			update_dentry_lease(dn, rinfo->dlease, session,
 					    req->r_request_started);
 		dout(" final dn %p\n", dn);
-		i++;
-	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
-		   req->r_op == CEPH_MDS_OP_MKSNAP) && !req->r_aborted) {
+	} else if (!req->r_aborted &&
+		   (req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
+		    req->r_op == CEPH_MDS_OP_MKSNAP)) {
 		struct dentry *dn = req->r_dentry;
 
 		/* fill out a snapdir LOOKUPSNAP dentry */
@@ -1177,52 +1182,15 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 		ininfo = rinfo->targeti.in;
 		vino.ino = le64_to_cpu(ininfo->ino);
 		vino.snap = le64_to_cpu(ininfo->snapid);
-		in = ceph_get_inode(sb, vino);
-		if (IS_ERR(in)) {
-			pr_err("fill_inode get_inode badness %llx.%llx\n",
-			       vino.ino, vino.snap);
-			err = PTR_ERR(in);
-			d_delete(dn);
-			goto done;
-		}
 		dout(" linking snapped dir %p to dn %p\n", in, dn);
+		ihold(in);
 		dn = splice_dentry(dn, in, NULL, true);
 		if (IS_ERR(dn)) {
 			err = PTR_ERR(dn);
 			goto done;
 		}
 		req->r_dentry = dn;  /* may have spliced */
-		ihold(in);
-		rinfo->head->is_dentry = 1;  /* fool notrace handlers */
-	}
-
-	if (rinfo->head->is_target) {
-		vino.ino = le64_to_cpu(rinfo->targeti.in->ino);
-		vino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
-
-		if (in == NULL || ceph_ino(in) != vino.ino ||
-		    ceph_snap(in) != vino.snap) {
-			in = ceph_get_inode(sb, vino);
-			if (IS_ERR(in)) {
-				err = PTR_ERR(in);
-				goto done;
-			}
-		}
-		req->r_target_inode = in;
-
-		err = fill_inode(in,
-				 &rinfo->targeti, NULL,
-				 session, req->r_request_started,
-				 (le32_to_cpu(rinfo->head->result) == 0) ?
-				 req->r_fmode : -1,
-				 &req->r_caps_reservation);
-		if (err < 0) {
-			pr_err("fill_inode badness %p %llx.%llx\n",
-			       in, ceph_vinop(in));
-			goto done;
-		}
 	}
-
 done:
 	dout("fill_trace done err=%d\n", err);
 	return err;
@@ -1272,7 +1240,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	struct qstr dname;
 	struct dentry *dn;
 	struct inode *in;
-	int err = 0, i;
+	int err = 0, ret, i;
 	struct inode *snapdir = NULL;
 	struct ceph_mds_request_head *rhead = req->r_request->front.iov_base;
 	struct ceph_dentry_info *di;
@@ -1305,6 +1273,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			ceph_fill_dirfrag(parent->d_inode, rinfo->dir_dir);
 	}
 
+	/* FIXME: release caps/leases if error occurs */
 	for (i = 0; i < rinfo->dir_nr; i++) {
 		struct ceph_vino vino;
 
@@ -1329,9 +1298,10 @@ retry_lookup:
 				err = -ENOMEM;
 				goto out;
 			}
-			err = ceph_init_dentry(dn);
-			if (err < 0) {
+			ret = ceph_init_dentry(dn);
+			if (ret < 0) {
 				dput(dn);
+				err = ret;
 				goto out;
 			}
 		} else if (dn->d_inode &&
@@ -1351,9 +1321,6 @@ retry_lookup:
 			spin_unlock(&parent->d_lock);
 		}
 
-		di = dn->d_fsdata;
-		di->offset = ceph_make_fpos(frag, i + r_readdir_offset);
-
 		/* inode */
 		if (dn->d_inode) {
 			in = dn->d_inode;
@@ -1366,26 +1333,39 @@ retry_lookup:
 				err = PTR_ERR(in);
 				goto out;
 			}
-			dn = splice_dentry(dn, in, NULL, false);
-			if (IS_ERR(dn))
-				dn = NULL;
 		}
 
 		if (fill_inode(in, &rinfo->dir_in[i], NULL, session,
 			       req->r_request_started, -1,
 			       &req->r_caps_reservation) < 0) {
 			pr_err("fill_inode badness on %p\n", in);
+			if (!dn->d_inode)
+				iput(in);
+			d_drop(dn);
 			goto next_item;
 		}
-		if (dn)
-			update_dentry_lease(dn, rinfo->dir_dlease[i],
-					    req->r_session,
-					    req->r_request_started);
+
+		if (!dn->d_inode) {
+			dn = splice_dentry(dn, in, NULL, false);
+			if (IS_ERR(dn)) {
+				err = PTR_ERR(dn);
+				dn = NULL;
+				goto next_item;
+			}
+		}
+
+		di = dn->d_fsdata;
+		di->offset = ceph_make_fpos(frag, i + r_readdir_offset);
+
+		update_dentry_lease(dn, rinfo->dir_dlease[i],
+				    req->r_session,
+				    req->r_request_started);
 next_item:
 		if (dn)
 			dput(dn);
 	}
-	req->r_did_prepopulate = true;
+	if (err == 0)
+		req->r_did_prepopulate = true;
 
 out:
 	if (snapdir) {
-- 
1.8.1.4

