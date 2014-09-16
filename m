From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 3/3] ceph: include the initial ACL in create/mkdir/mknod MDS requests
Date: Tue, 16 Sep 2014 21:39:19 +0800
Message-ID: <1410874759-11562-3-git-send-email-zyan@redhat.com>
References: <1410874759-11562-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16835 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259AbaIPNjg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Sep 2014 09:39:36 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8GDdaW7029434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 16 Sep 2014 09:39:36 -0400
In-Reply-To: <1410874759-11562-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>

Current code set new file/directory's initial ACL in a non-atomic
manner.
Client first sends request to MDS to create new file/directory, then set
the initial ACL after the new file/directory is successfully created.

The fix is include the initial ACL in create/mkdir/mknod MDS requests.
So MDS can handle creating file/directory and setting the initial ACL in
one request.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/acl.c   | 125 ++++++++++++++++++++++++++++++++++++++++++++------------
 fs/ceph/dir.c   |  41 ++++++++++++++-----
 fs/ceph/file.c  |  27 +++++++++---
 fs/ceph/super.h |  24 ++++++++---
 4 files changed, 170 insertions(+), 47 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index cebf2eb..5bd853b 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -169,36 +169,109 @@ out:
 	return ret;
 }
 
-int ceph_init_acl(struct dentry *dentry, struct inode *inode, struct inode *dir)
+int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
+		       struct ceph_acls_info *info)
 {
-	struct posix_acl *default_acl, *acl;
-	umode_t new_mode = inode->i_mode;
-	int error;
-
-	error = posix_acl_create(dir, &new_mode, &default_acl, &acl);
-	if (error)
-		return error;
-
-	if (!default_acl && !acl) {
-		cache_no_acl(inode);
-		if (new_mode != inode->i_mode) {
-			struct iattr newattrs = {
-				.ia_mode = new_mode,
-				.ia_valid = ATTR_MODE,
-			};
-			error = ceph_setattr(dentry, &newattrs);
+	struct posix_acl *acl, *default_acl;
+	size_t val_size1 = 0, val_size2 = 0;
+	struct ceph_pagelist *pagelist = NULL;
+	void *tmp_buf = NULL;
+	int err;
+
+	err = posix_acl_create(dir, mode, &default_acl, &acl);
+	if (err)
+		return err;
+
+	if (acl) {
+		int ret = posix_acl_equiv_mode(acl, mode);
+		if (ret < 0)
+			goto out_err;
+		if (ret == 0) {
+			posix_acl_release(acl);
+			acl = NULL;
 		}
-		return error;
 	}
 
-	if (default_acl) {
-		error = ceph_set_acl(inode, default_acl, ACL_TYPE_DEFAULT);
-		posix_acl_release(default_acl);
-	}
+	if (!default_acl && !acl)
+		return 0;
+
+	if (acl)
+		val_size1 = posix_acl_xattr_size(acl->a_count);
+	if (default_acl)
+		val_size2 = posix_acl_xattr_size(default_acl->a_count);
+
+	err = -ENOMEM;
+	tmp_buf = kmalloc(max(val_size1, val_size2), GFP_NOFS);
+	if (!tmp_buf)
+		goto out_err;
+	pagelist = kmalloc(sizeof(struct ceph_pagelist), GFP_NOFS);
+	if (!pagelist)
+		goto out_err;
+	ceph_pagelist_init(pagelist);
+
+	err = ceph_pagelist_reserve(pagelist, PAGE_SIZE);
+	if (err)
+		goto out_err;
+
+	ceph_pagelist_encode_32(pagelist, acl && default_acl ? 2 : 1);
+
 	if (acl) {
-		if (!error)
-			error = ceph_set_acl(inode, acl, ACL_TYPE_ACCESS);
-		posix_acl_release(acl);
+		size_t len = strlen(POSIX_ACL_XATTR_ACCESS);
+		err = ceph_pagelist_reserve(pagelist, len + val_size1 + 8);
+		if (err)
+			goto out_err;
+		ceph_pagelist_encode_string(pagelist, POSIX_ACL_XATTR_ACCESS,
+					    len);
+		err = posix_acl_to_xattr(&init_user_ns, acl,
+					 tmp_buf, val_size1);
+		if (err < 0)
+			goto out_err;
+		ceph_pagelist_encode_32(pagelist, val_size1);
+		ceph_pagelist_append(pagelist, tmp_buf, val_size1);
 	}
-	return error;
+	if (default_acl) {
+		size_t len = strlen(POSIX_ACL_XATTR_DEFAULT);
+		err = ceph_pagelist_reserve(pagelist, len + val_size2 + 8);
+		if (err)
+			goto out_err;
+		err = ceph_pagelist_encode_string(pagelist,
+						  POSIX_ACL_XATTR_DEFAULT, len);
+		err = posix_acl_to_xattr(&init_user_ns, default_acl,
+					 tmp_buf, val_size2);
+		if (err < 0)
+			goto out_err;
+		ceph_pagelist_encode_32(pagelist, val_size2);
+		ceph_pagelist_append(pagelist, tmp_buf, val_size2);
+	}
+
+	kfree(tmp_buf);
+
+	info->acl = acl;
+	info->default_acl = default_acl;
+	info->pagelist = pagelist;
+	return 0;
+
+out_err:
+	posix_acl_release(acl);
+	posix_acl_release(default_acl);
+	kfree(tmp_buf);
+	if (pagelist)
+		ceph_pagelist_release(pagelist);
+	return err;
+}
+
+void ceph_init_inode_acls(struct inode* inode, struct ceph_acls_info *info)
+{
+	if (!inode)
+		return;
+	ceph_set_cached_acl(inode, ACL_TYPE_ACCESS, info->acl);
+	ceph_set_cached_acl(inode, ACL_TYPE_DEFAULT, info->default_acl);
+}
+
+void ceph_release_acls_info(struct ceph_acls_info *info)
+{
+	posix_acl_release(info->acl);
+	posix_acl_release(info->default_acl);
+	if (info->pagelist)
+		ceph_pagelist_release(info->pagelist);
 }
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index c29d6ae..26be849 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -682,17 +682,22 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
+	struct ceph_acls_info acls = {};
 	int err;
 
 	if (ceph_snap(dir) != CEPH_NOSNAP)
 		return -EROFS;
 
+	err = ceph_pre_init_acls(dir, &mode, &acls);
+	if (err < 0)
+		return err;
+
 	dout("mknod in dir %p dentry %p mode 0%ho rdev %d\n",
 	     dir, dentry, mode, rdev);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_MKNOD, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
-		d_drop(dentry);
-		return PTR_ERR(req);
+		err = PTR_ERR(req);
+		goto out;
 	}
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
@@ -701,15 +706,20 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
 	req->r_args.mknod.rdev = cpu_to_le32(rdev);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
+	if (acls.pagelist) {
+		req->r_pagelist = acls.pagelist;
+		acls.pagelist = NULL;
+	}
 	err = ceph_mdsc_do_request(mdsc, dir, req);
 	if (!err && !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
 	ceph_mdsc_put_request(req);
-
+out:
 	if (!err)
-		ceph_init_acl(dentry, dentry->d_inode, dir);
+		ceph_init_inode_acls(dentry->d_inode, &acls);
 	else
 		d_drop(dentry);
+	ceph_release_acls_info(&acls);
 	return err;
 }
 
@@ -733,8 +743,8 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 	dout("symlink in dir %p dentry %p to '%s'\n", dir, dentry, dest);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SYMLINK, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
-		d_drop(dentry);
-		return PTR_ERR(req);
+		err = PTR_ERR(req);
+		goto out;
 	}
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
@@ -746,9 +756,8 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 	if (!err && !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
 	ceph_mdsc_put_request(req);
-	if (!err)
-		ceph_init_acl(dentry, dentry->d_inode, dir);
-	else
+out:
+	if (err)
 		d_drop(dentry);
 	return err;
 }
@@ -758,6 +767,7 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
+	struct ceph_acls_info acls = {};
 	int err = -EROFS;
 	int op;
 
@@ -772,6 +782,12 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	} else {
 		goto out;
 	}
+
+	mode |= S_IFDIR;
+	err = ceph_pre_init_acls(dir, &mode, &acls);
+	if (err < 0)
+		goto out;
+
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -784,15 +800,20 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	req->r_args.mkdir.mode = cpu_to_le32(mode);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
+	if (acls.pagelist) {
+		req->r_pagelist = acls.pagelist;
+		acls.pagelist = NULL;
+	}
 	err = ceph_mdsc_do_request(mdsc, dir, req);
 	if (!err && !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
 	ceph_mdsc_put_request(req);
 out:
 	if (!err)
-		ceph_init_acl(dentry, dentry->d_inode, dir);
+		ceph_init_inode_acls(dentry->d_inode, &acls);
 	else
 		d_drop(dentry);
+	ceph_release_acls_info(&acls);
 	return err;
 }
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index e520317..1c1df08 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -235,6 +235,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct dentry *dn;
+	struct ceph_acls_info acls = {};
 	int err;
 
 	dout("atomic_open %p dentry %p '%.*s' %s flags %d mode 0%o\n",
@@ -248,22 +249,34 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (err < 0)
 		return err;
 
+	if (flags & O_CREAT) {
+		err = ceph_pre_init_acls(dir, &mode, &acls);
+		if (err < 0)
+			return err;
+	}
+
 	/* do the open */
 	req = prepare_open_request(dir->i_sb, flags, mode);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		goto out_acl;
+	}
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
 	if (flags & O_CREAT) {
 		req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
 		req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
+		if (acls.pagelist) {
+			req->r_pagelist = acls.pagelist;
+			acls.pagelist = NULL;
+		}
 	}
 	req->r_locked_dir = dir;           /* caller holds dir->i_mutex */
 	err = ceph_mdsc_do_request(mdsc,
 				   (flags & (O_CREAT|O_TRUNC)) ? dir : NULL,
 				   req);
 	if (err)
-		goto out_err;
+		goto out_req;
 
 	err = ceph_handle_snapdir(req, dentry, err);
 	if (err == 0 && (flags & O_CREAT) && !req->r_reply_info.head->is_dentry)
@@ -278,7 +291,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		dn = NULL;
 	}
 	if (err)
-		goto out_err;
+		goto out_req;
 	if (dn || dentry->d_inode == NULL || S_ISLNK(dentry->d_inode->i_mode)) {
 		/* make vfs retry on splice, ENOENT, or symlink */
 		dout("atomic_open finish_no_open on dn %p\n", dn);
@@ -286,15 +299,17 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	} else {
 		dout("atomic_open finish_open on dn %p\n", dn);
 		if (req->r_op == CEPH_MDS_OP_CREATE && req->r_reply_info.has_create_ino) {
-			ceph_init_acl(dentry, dentry->d_inode, dir);
+			ceph_init_inode_acls(dentry->d_inode, &acls);
 			*opened |= FILE_CREATED;
 		}
 		err = finish_open(file, dentry, ceph_open, opened);
 	}
-out_err:
+out_req:
 	if (!req->r_err && req->r_target_inode)
 		ceph_put_fmode(ceph_inode(req->r_target_inode), req->r_fmode);
 	ceph_mdsc_put_request(req);
+out_acl:
+	ceph_release_acls_info(&acls);
 	dout("atomic_open result=%d\n", err);
 	return err;
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index bbb44cd..f62a098 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -733,15 +733,23 @@ extern void __ceph_build_xattrs_blob(struct ceph_inode_info *ci);
 extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
 extern void __init ceph_xattr_init(void);
 extern void ceph_xattr_exit(void);
+extern const struct xattr_handler *ceph_xattr_handlers[];
 
 /* acl.c */
-extern const struct xattr_handler *ceph_xattr_handlers[];
+struct ceph_acls_info {
+	void *default_acl;
+	void *acl;
+	struct ceph_pagelist *pagelist;
+};
 
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 
 struct posix_acl *ceph_get_acl(struct inode *, int);
 int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type);
-int ceph_init_acl(struct dentry *, struct inode *, struct inode *);
+int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
+		       struct ceph_acls_info *info);
+void ceph_init_inode_acls(struct inode *inode, struct ceph_acls_info *info);
+void ceph_release_acls_info(struct ceph_acls_info *info);
 
 static inline void ceph_forget_all_cached_acls(struct inode *inode)
 {
@@ -753,12 +761,18 @@ static inline void ceph_forget_all_cached_acls(struct inode *inode)
 #define ceph_get_acl NULL
 #define ceph_set_acl NULL
 
-static inline int ceph_init_acl(struct dentry *dentry, struct inode *inode,
-				struct inode *dir)
+static inline int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
+				     struct ceph_acls_info *info)
 {
 	return 0;
 }
-
+static inline void ceph_init_inode_acls(struct inode *inode,
+					struct ceph_acls_info *info)
+{
+}
+static inline void ceph_release_acls_info(struct ceph_acls_info *info)
+{
+}
 static inline int ceph_acl_chmod(struct dentry *dentry, struct inode *inode)
 {
 	return 0;
-- 
1.9.3

