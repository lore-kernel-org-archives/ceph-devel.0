From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/4] ceph: simply ceph_fh_to_dentry()
Date: Sat,  1 Mar 2014 23:23:28 +0800
Message-ID: <1393687411-2457-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:8582 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871AbaCAPYE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 1 Mar 2014 10:24:04 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

MDS handles LOOKUPHASH and LOOKUPINO MDS requests in the same way.
So __cfh_to_dentry() is redundant.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/export.c | 167 +++++++++++--------------------------------------------
 1 file changed, 32 insertions(+), 135 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 16796be..905d7f2 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -8,23 +8,6 @@
 #include "mds_client.h"
 
 /*
- * NFS export support
- *
- * NFS re-export of a ceph mount is, at present, only semireliable.
- * The basic issue is that the Ceph architectures doesn't lend itself
- * well to generating filehandles that will remain valid forever.
- *
- * So, we do our best.  If you're lucky, your inode will be in the
- * client's cache.  If it's not, and you have a connectable fh, then
- * the MDS server may be able to find it for you.  Otherwise, you get
- * ESTALE.
- *
- * There are ways to this more reliable, but in the non-connectable fh
- * case, we won't every work perfectly, and in the connectable case,
- * some changes are needed on the MDS side to work better.
- */
-
-/*
  * Basic fh
  */
 struct ceph_nfs_fh {
@@ -32,22 +15,12 @@ struct ceph_nfs_fh {
 } __attribute__ ((packed));
 
 /*
- * Larger 'connectable' fh that includes parent ino and name hash.
- * Use this whenever possible, as it works more reliably.
+ * Larger fh that includes parent ino.
  */
 struct ceph_nfs_confh {
 	u64 ino, parent_ino;
-	u32 parent_name_hash;
 } __attribute__ ((packed));
 
-/*
- * The presence of @parent_inode here tells us whether NFS wants a
- * connectable file handle.  However, we want to make a connectionable
- * file handle unconditionally so that the MDS gets as much of a hint
- * as possible.  That means we only use @parent_dentry to indicate
- * whether nfsd wants a connectable fh, and whether we should indicate
- * failure from a too-small @max_len.
- */
 static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 			  struct inode *parent_inode)
 {
@@ -56,54 +29,36 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 	struct ceph_nfs_confh *cfh = (void *)rawfh;
 	int connected_handle_length = sizeof(*cfh)/4;
 	int handle_length = sizeof(*fh)/4;
-	struct dentry *dentry;
-	struct dentry *parent;
 
 	/* don't re-export snaps */
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EINVAL;
 
-	dentry = d_find_alias(inode);
+	if (parent_inode && (*max_len < connected_handle_length)) {
+		*max_len = connected_handle_length;
+		return FILEID_INVALID;
+	} else if (*max_len < handle_length) {
+		*max_len = handle_length;
+		return FILEID_INVALID;
+	}
 
-	/* if we found an alias, generate a connectable fh */
-	if (*max_len >= connected_handle_length && dentry) {
-		dout("encode_fh %p connectable\n", dentry);
-		spin_lock(&dentry->d_lock);
-		parent = dentry->d_parent;
+	if (parent_inode) {
+		dout("encode_fh %llx with parent %llx\n",
+		     ceph_ino(inode), ceph_ino(parent_inode));
 		cfh->ino = ceph_ino(inode);
-		cfh->parent_ino = ceph_ino(parent->d_inode);
-		cfh->parent_name_hash = ceph_dentry_hash(parent->d_inode,
-							 dentry);
+		cfh->parent_ino = ceph_ino(parent_inode);
 		*max_len = connected_handle_length;
-		type = 2;
-		spin_unlock(&dentry->d_lock);
-	} else if (*max_len >= handle_length) {
-		if (parent_inode) {
-			/* nfsd wants connectable */
-			*max_len = connected_handle_length;
-			type = FILEID_INVALID;
-		} else {
-			dout("encode_fh %p\n", dentry);
-			fh->ino = ceph_ino(inode);
-			*max_len = handle_length;
-			type = 1;
-		}
+		type = FILEID_INO32_GEN_PARENT;
 	} else {
+		dout("encode_fh %llx\n", ceph_ino(inode));
+		fh->ino = ceph_ino(inode);
 		*max_len = handle_length;
-		type = FILEID_INVALID;
+		type = FILEID_INO32_GEN;
 	}
-	if (dentry)
-		dput(dentry);
 	return type;
 }
 
-/*
- * convert regular fh to dentry
- *
- * FIXME: we should try harder by querying the mds for the ino.
- */
-static struct dentry *__fh_to_dentry(struct super_block *sb,
-				     struct ceph_nfs_fh *fh, int fh_len)
+static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
 	struct inode *inode;
@@ -111,16 +66,12 @@ static struct dentry *__fh_to_dentry(struct super_block *sb,
 	struct ceph_vino vino;
 	int err;
 
-	if (fh_len < sizeof(*fh) / 4)
-		return ERR_PTR(-ESTALE);
-
-	dout("__fh_to_dentry %llx\n", fh->ino);
-	vino.ino = fh->ino;
+	dout("__fh_to_dentry %llx\n", ino);
+	vino.ino = ino;
 	vino.snap = CEPH_NOSNAP;
 	inode = ceph_find_inode(sb, vino);
 	if (!inode) {
 		struct ceph_mds_request *req;
-
 		req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPINO,
 					       USE_ANY_MDS);
 		if (IS_ERR(req))
@@ -139,89 +90,35 @@ static struct dentry *__fh_to_dentry(struct super_block *sb,
 
 	dentry = d_obtain_alias(inode);
 	if (IS_ERR(dentry)) {
-		pr_err("fh_to_dentry %llx -- inode %p but ENOMEM\n",
-		       fh->ino, inode);
 		iput(inode);
 		return dentry;
 	}
 	err = ceph_init_dentry(dentry);
 	if (err < 0) {
-		iput(inode);
+		dput(dentry);
 		return ERR_PTR(err);
 	}
-	dout("__fh_to_dentry %llx %p dentry %p\n", fh->ino, inode, dentry);
+	dout("__fh_to_dentry %llx %p dentry %p\n", ino, inode, dentry);
 	return dentry;
 }
 
 /*
- * convert connectable fh to dentry
+ * convert regular fh to dentry
  */
-static struct dentry *__cfh_to_dentry(struct super_block *sb,
-				      struct ceph_nfs_confh *cfh, int fh_len)
+static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
+					struct fid *fid,
+					int fh_len, int fh_type)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
-	struct inode *inode;
-	struct dentry *dentry;
-	struct ceph_vino vino;
-	int err;
+	struct ceph_nfs_fh *fh = (void *)fid->raw;
 
-	if (fh_len < sizeof(*cfh) / 4)
+	if (fh_type != FILEID_INO32_GEN  &&
+	    fh_type != FILEID_INO32_GEN_PARENT)
+		return ERR_PTR(-ESTALE);
+	if (fh_len < sizeof(*fh) / 4)
 		return ERR_PTR(-ESTALE);
 
-	dout("__cfh_to_dentry %llx (%llx/%x)\n",
-	     cfh->ino, cfh->parent_ino, cfh->parent_name_hash);
-
-	vino.ino = cfh->ino;
-	vino.snap = CEPH_NOSNAP;
-	inode = ceph_find_inode(sb, vino);
-	if (!inode) {
-		struct ceph_mds_request *req;
-
-		req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPHASH,
-					       USE_ANY_MDS);
-		if (IS_ERR(req))
-			return ERR_CAST(req);
-
-		req->r_ino1 = vino;
-		req->r_ino2.ino = cfh->parent_ino;
-		req->r_ino2.snap = CEPH_NOSNAP;
-		req->r_path2 = kmalloc(16, GFP_NOFS);
-		snprintf(req->r_path2, 16, "%d", cfh->parent_name_hash);
-		req->r_num_caps = 1;
-		err = ceph_mdsc_do_request(mdsc, NULL, req);
-		inode = req->r_target_inode;
-		if (inode)
-			ihold(inode);
-		ceph_mdsc_put_request(req);
-		if (!inode)
-			return ERR_PTR(err ? err : -ESTALE);
-	}
-
-	dentry = d_obtain_alias(inode);
-	if (IS_ERR(dentry)) {
-		pr_err("cfh_to_dentry %llx -- inode %p but ENOMEM\n",
-		       cfh->ino, inode);
-		iput(inode);
-		return dentry;
-	}
-	err = ceph_init_dentry(dentry);
-	if (err < 0) {
-		iput(inode);
-		return ERR_PTR(err);
-	}
-	dout("__cfh_to_dentry %llx %p dentry %p\n", cfh->ino, inode, dentry);
-	return dentry;
-}
-
-static struct dentry *ceph_fh_to_dentry(struct super_block *sb, struct fid *fid,
-					int fh_len, int fh_type)
-{
-	if (fh_type == 1)
-		return __fh_to_dentry(sb, (struct ceph_nfs_fh *)fid->raw,
-								fh_len);
-	else
-		return __cfh_to_dentry(sb, (struct ceph_nfs_confh *)fid->raw,
-								fh_len);
+	pr_debug("fh_to_dentry %llx\n", fh->ino);
+	return __fh_to_dentry(sb, fh->ino);
 }
 
 /*
-- 
1.8.5.3

