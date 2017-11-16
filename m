From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH v2] ceph: snapshot nfs re-export
Date: Thu, 16 Nov 2017 21:52:05 +0800
Message-ID: <20171116135205.10335-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759232AbdKPNwJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Nov 2017 08:52:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09CD8A8342
        for <ceph-devel@vger.kernel.org>; Thu, 16 Nov 2017 13:52:09 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, bfields@redhat.com, "Yan, Zheng" <zyan@redhat.com>

To support snapshot nfs re-export, we need a way to lookup snapped
inode by file handle. For directory inode, snapped metadata are always
stored together with head inode. Client just need to pass vinodeno_t
to MDS. For non-directory inode, there can be multiple version of
snapped inodes and they can be stored in different dirfrags. Besides
vinodeno_t, client also need to tell mds from which dirfrag it got the
snapped inode.

Another problem of supporting snapshot nfs re-export is that there
can be multiple paths to access a snapped inode. For example:

mkdir -p d1/d2/d3
mkdir d1/.snap/s1

Paths 'd1/.snap/s1/d2/d3', 'd1/d2/.snap/_s1_<inode number of d1>/d3'
and 'd1/d2/d3/.snap/_s1_<inode number of d1>' are all reference to the
same snapped inode. For a given snapped inode, There is no convenient
way to get the first form and the second form paths. For simplicity,
ceph_get_parent() return snapdir.

Furthermore, client may access snapshot of deleted directory. For
example:

mkdir -p d1/d2
mkdir d1/.snap/s1
open d1/.snap/s1/d2
rm -rf d1/d2
<nfs server restart>

The path constucted by ceph_get_parent() and ceph_get_name() is
'<inode of d2>/.snap/_s1_<inode number of d1>'. Futher lookup parent
of <inode of d2> will fail. To workaround this case, this patch uses
d_obtain_root() to get dentry for snapdir of deleted directory.
snapdir dentry has no DCACHE_DISCONNECTED flag set, reconnect_path()
stops when it reaches snapdir dentry.

MDS patch is at https://github.com/ceph/ceph/pull/18942

Fixes: http://tracker.ceph.com/issues/22105
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/export.c             | 344 +++++++++++++++++++++++++++++++++++++++----
 include/linux/ceph/ceph_fs.h |   6 +
 2 files changed, 324 insertions(+), 26 deletions(-)

change since v1:
 handle deleted directory

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 7df550c13d7f..24190725f996 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -21,18 +21,77 @@ struct ceph_nfs_confh {
 	u64 ino, parent_ino;
 } __attribute__ ((packed));
 
+/*
+ * fh for snapped inode
+ */
+struct ceph_nfs_snapfh {
+	u64 ino;
+	u64 snapid;
+	u64 parent_ino;
+	u32 hash;
+} __attribute__ ((packed));
+
+static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_len,
+			      struct inode *parent_inode)
+{
+	const static int snap_handle_length =
+		sizeof(struct ceph_nfs_snapfh) >> 2;
+	struct ceph_nfs_snapfh *sfh = (void *)rawfh;
+	u64 snapid = ceph_snap(inode);
+	int ret;
+	bool no_parent = true;
+
+	if (*max_len < snap_handle_length) {
+		*max_len = snap_handle_length;
+		ret = FILEID_INVALID;
+		goto out;
+	}
+
+	ret =  -EINVAL;
+	if (snapid != CEPH_SNAPDIR) {
+		struct inode *dir;
+		struct dentry *dentry = d_find_alias(inode);
+		if (!dentry)
+			goto out;
+
+		rcu_read_lock();
+		dir = d_inode_rcu(dentry->d_parent);
+		if (ceph_snap(dir) != CEPH_SNAPDIR) {
+			sfh->parent_ino = ceph_ino(dir);
+			sfh->hash = ceph_dentry_hash(dir, dentry);
+			no_parent = false;
+		}
+		rcu_read_unlock();
+		dput(dentry);
+	}
+
+	if (no_parent) {
+		if (!S_ISDIR(inode->i_mode))
+			goto out;
+		sfh->parent_ino = sfh->ino;
+		sfh->hash = 0;
+	}
+	sfh->ino = ceph_ino(inode);
+	sfh->snapid = snapid;
+
+	*max_len = snap_handle_length;
+	ret = FILEID_BTRFS_WITH_PARENT;
+out:
+	dout("encode_snapfh %llx.%llx ret=%d\n", ceph_vinop(inode), ret);
+	return ret;
+}
+
 static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 			  struct inode *parent_inode)
 {
+	const static int handle_length =
+		sizeof(struct ceph_nfs_fh) >> 2;
+	const static int connected_handle_length =
+		sizeof(struct ceph_nfs_confh) >> 2;
 	int type;
-	struct ceph_nfs_fh *fh = (void *)rawfh;
-	struct ceph_nfs_confh *cfh = (void *)rawfh;
-	int connected_handle_length = sizeof(*cfh)/4;
-	int handle_length = sizeof(*fh)/4;
 
-	/* don't re-export snaps */
 	if (ceph_snap(inode) != CEPH_NOSNAP)
-		return -EINVAL;
+		return ceph_encode_snapfh(inode, rawfh, max_len, parent_inode);
 
 	if (parent_inode && (*max_len < connected_handle_length)) {
 		*max_len = connected_handle_length;
@@ -43,6 +102,7 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 	}
 
 	if (parent_inode) {
+		struct ceph_nfs_confh *cfh = (void *)rawfh;
 		dout("encode_fh %llx with parent %llx\n",
 		     ceph_ino(inode), ceph_ino(parent_inode));
 		cfh->ino = ceph_ino(inode);
@@ -50,6 +110,7 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 		*max_len = connected_handle_length;
 		type = FILEID_INO32_GEN_PARENT;
 	} else {
+		struct ceph_nfs_fh *fh = (void *)rawfh;
 		dout("encode_fh %llx\n", ceph_ino(inode));
 		fh->ino = ceph_ino(inode);
 		*max_len = handle_length;
@@ -58,7 +119,7 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 	return type;
 }
 
-static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
+static struct inode *__lookup_inode(struct super_block *sb, u64 ino)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
 	struct inode *inode;
@@ -80,7 +141,7 @@ static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
 		mask = CEPH_STAT_CAP_INODE;
 		if (ceph_security_xattr_wanted(d_inode(sb->s_root)))
 			mask |= CEPH_CAP_XATTR_SHARED;
-		req->r_args.getattr.mask = cpu_to_le32(mask);
+		req->r_args.lookupino.mask = cpu_to_le32(mask);
 
 		req->r_ino1 = vino;
 		req->r_num_caps = 1;
@@ -89,17 +150,101 @@ static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
 		if (inode)
 			ihold(inode);
 		ceph_mdsc_put_request(req);
-		if (!inode)
-			return ERR_PTR(-ESTALE);
-		if (inode->i_nlink == 0) {
-			iput(inode);
-			return ERR_PTR(-ESTALE);
-		}
 	}
+	return inode ? inode : ERR_PTR(-ESTALE);
+}
 
+static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
+{
+	struct inode *inode = __lookup_inode(sb, ino);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+	if (inode->i_nlink == 0) {
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
 	return d_obtain_alias(inode);
 }
 
+static struct dentry *__snapfh_to_dentry(struct super_block *sb,
+					  struct ceph_nfs_snapfh *sfh,
+					  bool want_parent)
+{
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
+	struct ceph_mds_request *req;
+	struct inode *inode;
+	struct ceph_vino vino;
+	int mask;
+	int err;
+	bool unlinked = false;
+
+	if (want_parent) {
+		vino.ino = sfh->parent_ino;
+		if (sfh->snapid == CEPH_SNAPDIR)
+			vino.snap = CEPH_NOSNAP;
+		else if (sfh->ino == sfh->parent_ino)
+			vino.snap = CEPH_SNAPDIR;
+		else
+			vino.snap = sfh->snapid;
+	} else {
+		vino.ino = sfh->ino;
+		vino.snap = sfh->snapid;
+	}
+	inode = ceph_find_inode(sb, vino);
+	if (inode)
+		return d_obtain_alias(inode);
+
+	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPINO,
+				       USE_ANY_MDS);
+	if (IS_ERR(req))
+		return ERR_CAST(req);
+
+	mask = CEPH_STAT_CAP_INODE;
+	if (ceph_security_xattr_wanted(d_inode(sb->s_root)))
+		mask |= CEPH_CAP_XATTR_SHARED;
+	req->r_args.lookupino.mask = cpu_to_le32(mask);
+	if (vino.snap < CEPH_NOSNAP) {
+		req->r_args.lookupino.snapid = cpu_to_le64(vino.snap);
+		if (!want_parent && sfh->ino != sfh->parent_ino) {
+			req->r_args.lookupino.parent =
+					cpu_to_le64(sfh->parent_ino);
+			req->r_args.lookupino.hash =
+					cpu_to_le32(sfh->hash);
+		}
+	}
+
+	req->r_ino1 = vino;
+	req->r_num_caps = 1;
+	err = ceph_mdsc_do_request(mdsc, NULL, req);
+	inode = req->r_target_inode;
+	if (inode) {
+		if (vino.snap == CEPH_SNAPDIR) {
+			if (inode->i_nlink == 0)
+				unlinked = true;
+			inode = ceph_get_snapdir(inode);
+		} else if (ceph_snap(inode) == vino.snap) {
+			ihold(inode);
+		} else {
+			/* mds does not support lookup snapped inode */
+			err = -EOPNOTSUPP;
+			inode = NULL;
+		}
+	}
+	ceph_mdsc_put_request(req);
+
+	if (want_parent) {
+		dout("snapfh_to_parent %llx.%llx\n err=%d\n",
+		     vino.ino, vino.snap, err);
+	} else {
+		dout("snapfh_to_dentry %llx.%llx parent %llx hash %x err=%d",
+		      vino.ino, vino.snap, sfh->parent_ino, sfh->hash, err);
+	}
+	if (!inode)
+		return ERR_PTR(-ESTALE);
+	/* see comments in ceph_get_parent() */
+	return unlinked ? d_obtain_root(inode) : d_obtain_alias(inode);
+}
+
 /*
  * convert regular fh to dentry
  */
@@ -109,6 +254,11 @@ static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
 {
 	struct ceph_nfs_fh *fh = (void *)fid->raw;
 
+	if (fh_type == FILEID_BTRFS_WITH_PARENT) {
+		struct ceph_nfs_snapfh *sfh = (void *)fid->raw;
+		return __snapfh_to_dentry(sb, sfh, false);
+	}
+
 	if (fh_type != FILEID_INO32_GEN  &&
 	    fh_type != FILEID_INO32_GEN_PARENT)
 		return NULL;
@@ -162,13 +312,49 @@ static struct dentry *__get_parent(struct super_block *sb,
 
 static struct dentry *ceph_get_parent(struct dentry *child)
 {
-	/* don't re-export snaps */
-	if (ceph_snap(d_inode(child)) != CEPH_NOSNAP)
-		return ERR_PTR(-EINVAL);
-
-	dout("get_parent %p ino %llx.%llx\n",
-	     child, ceph_vinop(d_inode(child)));
-	return __get_parent(child->d_sb, child, 0);
+	struct inode *inode = d_inode(child);
+	struct dentry *dn;
+
+	if (ceph_snap(inode) != CEPH_NOSNAP) {
+		struct inode* dir;
+		bool unlinked = false;
+		/* do not support non-directory */
+		if (!d_is_dir(child)) {
+			dn = ERR_PTR(-EINVAL);
+			goto out;
+		}
+		dir = __lookup_inode(inode->i_sb, ceph_ino(inode));
+		if (IS_ERR(dir)) {
+			dn = ERR_CAST(dir);
+			goto out;
+		}
+		/* There can be multiple paths to access snapped inode.
+		 * For simplicity, treat snapdir of head inode as parent */
+		if (ceph_snap(inode) != CEPH_SNAPDIR) {
+			struct inode *snapdir = ceph_get_snapdir(dir);
+			if (dir->i_nlink == 0)
+				unlinked = true;
+			iput(dir);
+			if (IS_ERR(snapdir)) {
+				dn = ERR_CAST(snapdir);
+				goto out;
+			}
+			dir = snapdir;
+		}
+		/* If directory has already been deleted, futher get_parent
+		 * will fail. Do not mark snapdir dentry as disconnected,
+		 * this prevent exportfs from doing futher get_parent. */
+		if (unlinked)
+			dn = d_obtain_root(dir);
+		else
+			dn = d_obtain_alias(dir);
+	} else {
+		dn = __get_parent(child->d_sb, child, 0);
+	}
+out:
+	dout("get_parent %p ino %llx.%llx err=%ld\n",
+	     child, ceph_vinop(inode), (IS_ERR(dn) ? PTR_ERR(dn) : 0));
+	return dn;
 }
 
 /*
@@ -181,6 +367,11 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 	struct ceph_nfs_confh *cfh = (void *)fid->raw;
 	struct dentry *dentry;
 
+	if (fh_type == FILEID_BTRFS_WITH_PARENT) {
+		struct ceph_nfs_snapfh *sfh = (void *)fid->raw;
+		return __snapfh_to_dentry(sb, sfh, true);
+	}
+
 	if (fh_type != FILEID_INO32_GEN_PARENT)
 		return NULL;
 	if (fh_len < sizeof(*cfh) / 4)
@@ -193,14 +384,115 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 	return dentry;
 }
 
+static int __get_snap_name(struct dentry *parent, char *name,
+			   struct dentry *child)
+{
+	struct inode *inode = d_inode(child);
+	struct inode *dir = d_inode(parent);
+	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_mds_request *req = NULL;
+	char *last_name = NULL;
+	unsigned next_offset = 2;
+	int err = -EINVAL;
+
+	if (ceph_ino(inode) != ceph_ino(dir))
+		goto out;
+	if (ceph_snap(inode) == CEPH_SNAPDIR) {
+		if (ceph_snap(dir) == CEPH_NOSNAP) {
+			strcpy(name, fsc->mount_options->snapdir_name);
+			err = 0;
+		}
+		goto out;
+	}
+	if (ceph_snap(dir) != CEPH_SNAPDIR)
+		goto out;
+
+	while (1) {
+		struct ceph_mds_reply_info_parsed *rinfo;
+		struct ceph_mds_reply_dir_entry *rde;
+		int i;
+
+		req = ceph_mdsc_create_request(fsc->mdsc, CEPH_MDS_OP_LSSNAP,
+					       USE_AUTH_MDS);
+		if (IS_ERR(req)) {
+			err = PTR_ERR(req);
+			req = NULL;
+			goto out;
+		}
+		err = ceph_alloc_readdir_reply_buffer(req, inode);
+		if (err)
+			goto out;
+
+		req->r_direct_mode = USE_AUTH_MDS;
+		req->r_readdir_offset = next_offset;
+		req->r_args.readdir.flags =
+				cpu_to_le16(CEPH_READDIR_REPLY_BITFLAGS);
+		if (last_name) {
+			req->r_path2 = last_name;
+			last_name = NULL;
+		}
+
+		req->r_inode = dir;
+		ihold(dir);
+		req->r_dentry = dget(parent);
+
+		inode_lock(dir);
+		err = ceph_mdsc_do_request(fsc->mdsc, NULL, req);
+		inode_unlock(dir);
+
+		if (err < 0)
+			goto out;
+
+		 rinfo = &req->r_reply_info;
+		 for (i = 0; i < rinfo->dir_nr; i++) {
+			 rde = rinfo->dir_entries + i;
+			 BUG_ON(!rde->inode.in);
+			 if (ceph_snap(inode) ==
+			     le64_to_cpu(rde->inode.in->snapid)) {
+				 memcpy(name, rde->name, rde->name_len);
+				 name[rde->name_len] = '\0';
+				 err = 0;
+				 goto out;
+			 }
+		 }
+
+		 if (rinfo->dir_end)
+			 break;
+
+		 BUG_ON(rinfo->dir_nr <= 0);
+		 rde = rinfo->dir_entries + (rinfo->dir_nr - 1);
+		 next_offset += rinfo->dir_nr;
+		 last_name = kstrndup(rde->name, rde->name_len, GFP_KERNEL);
+		 if (!last_name) {
+			 err = -ENOMEM;
+			 goto out;
+		 }
+
+		 ceph_mdsc_put_request(req);
+		 req = NULL;
+	}
+	err = -ENOENT;
+out:
+	if (req)
+		ceph_mdsc_put_request(req);
+	kfree(last_name);
+	dout("get_snap_name %p ino %llx.%llx err=%d\n",
+	     child, ceph_vinop(inode), err);
+	return err;
+}
+
 static int ceph_get_name(struct dentry *parent, char *name,
 			 struct dentry *child)
 {
 	struct ceph_mds_client *mdsc;
 	struct ceph_mds_request *req;
+	struct inode *inode = d_inode(child);
 	int err;
 
-	mdsc = ceph_inode_to_client(d_inode(child))->mdsc;
+	if (ceph_snap(inode) != CEPH_NOSNAP)
+		return __get_snap_name(parent, name, child);
+
+	mdsc = ceph_inode_to_client(inode)->mdsc;
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPNAME,
 				       USE_ANY_MDS);
 	if (IS_ERR(req))
@@ -208,8 +500,8 @@ static int ceph_get_name(struct dentry *parent, char *name,
 
 	inode_lock(d_inode(parent));
 
-	req->r_inode = d_inode(child);
-	ihold(d_inode(child));
+	req->r_inode = inode;
+	ihold(inode);
 	req->r_ino2 = ceph_vino(d_inode(parent));
 	req->r_parent = d_inode(parent);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
@@ -223,10 +515,10 @@ static int ceph_get_name(struct dentry *parent, char *name,
 		memcpy(name, rinfo->dname, rinfo->dname_len);
 		name[rinfo->dname_len] = 0;
 		dout("get_name %p ino %llx.%llx name %s\n",
-		     child, ceph_vinop(d_inode(child)), name);
+		     child, ceph_vinop(inode), name);
 	} else {
 		dout("get_name %p ino %llx.%llx err %d\n",
-		     child, ceph_vinop(d_inode(child)), err);
+		     child, ceph_vinop(inode), err);
 	}
 
 	ceph_mdsc_put_request(req);
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index b422170b791a..4abb0fea4fd6 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -434,6 +434,12 @@ union ceph_mds_request_args {
 		__le64 length; /* num bytes to lock from start */
 		__u8 wait; /* will caller wait for lock to become available? */
 	} __attribute__ ((packed)) filelock_change;
+	struct {
+		__le32 mask;                 /* CEPH_CAP_* */
+		__le64 snapid;
+		__le64 parent;
+		__le32 hash;
+	} __attribute__ ((packed)) lookupino;
 } __attribute__ ((packed));
 
 #define CEPH_MDS_FLAG_REPLAY        1  /* this is a replayed op */
-- 
2.13.6

