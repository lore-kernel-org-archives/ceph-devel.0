Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6260407CEE
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283147; cv=none; b=Mk3af5KILlvnqqnWJjFbArcW8AB8wg0XX9YB5iKpydAb8lYsP+Z+vhzHJJUhylMvv4+UtFvHYuRA4ufXBe7oHM6ApEcnIZauVlwTkweI/AbXupV64VqzRtITOA5aiZ7dYhTBO3atKGR+DpZ+nRhHPG1FHzXnypva+GCh9naHBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283147; c=relaxed/simple;
	bh=sOkcOEqIJNWjFdLt1dQ3JXhKzkVNG2NcU/q8G5T0YlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtwL6QK5KZR4BqCPCp+ZGV24x0KXdF1rk4xlwQZAdX1t7a8lpdEnLRPDlm1l6lpydSBoooOO3Lg9Io9vtdl6wDXmG+AiBbxVaPkI7iea52z0Lm6yitCOswVKcrIzpDtpTo4zTNuzXP0VyXLRx4bXt4nlqj9TNLqIy/tKimlJiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=E7QfzdXg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="E7QfzdXg"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef29c5561so608613f8f.0
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283143; x=1781887943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX9fzPNqfXztTslKlJdfwDHkzmp44yYoKixG2O7WIwE=;
        b=E7QfzdXg+awWvKFPCIXd2vtj3OrFPrDApAdPgQnP/1Sn11Ao5BaqlUF/rtoALI6f+A
         z/jWWm3I2AfM0RbMShD0NUh15k8kol1HhiUlVwjzCd957vCILeh/DbW2tG2r4yFnX2u9
         /1ZkpptZMjFH564D8ap9BrK0kPDwkzVKDTi8SmJb6eQcQorhoQwEoQUHaLnYFhRXjlQq
         RArJzJURcP+GouKpSgZ4YWrleMYtf+x2xiBlzk7vUoSRXaVLI4+rnjDqjbMmhG/IFg1e
         Fj15TxyNkcU54crUwLEdXmP36OPpa6+VHX0DjPQNmWfSZTLMgaQmgkd+zKgaBwwyb3sd
         h55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283143; x=1781887943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kX9fzPNqfXztTslKlJdfwDHkzmp44yYoKixG2O7WIwE=;
        b=PJgjbpimwHycTtkoRaXxueKpuPfMkSrUIRJ81hqf2CLiT4JLE7BGdc+219ZNJETkJA
         shosCGlOKQj9eVVUGa+gJJ9DB+tEoky8rhXhznC0qC/nnmfOpHgC8jMxxsZos2GSfPut
         SgqadGAlUSQwP9ICR5qb7d+esRemcWuUs8K+BZsl9D56RLvFdqvFxLHJmErKewyeCrul
         KW8W2BW93NTJU00MUVWwh4FadZokATJJphANAdacWqQUCSpbefh9ANph7Awz9L4MSexi
         4t/AF354LgVZyci9u12U2x9P0/xEXkLMzU20GjFZM5Mo7IxkoAz4ctfdyuRzkv4djQE1
         dJFA==
X-Forwarded-Encrypted: i=1; AFNElJ94RbhwXwZASSiNDQ7NeXUtuJH8ro/14uowj7/wEfaOzg/n2lmothNXLKKzL93OnNDRRrRlyQ4pmN6F@vger.kernel.org
X-Gm-Message-State: AOJu0YxITxoNl0SWD3+/cHmJcQSARR5A1AcKB1P55gk0SW0qofij1rwS
	pdjjELwvVvVUMGl/3XZUygeD9VlvlZFGrTpWO026Lcjc5MRNcdNE876y+JEom4Zmawvygs3KtyZ
	dleX32KM=
X-Gm-Gg: Acq92OGiov7qagA2hfDA6VaqESrGC66izhl5DwDXpYaklpHD4uTyi0CRIfsE0Tq4qcL
	Y/zTvni1te/Ewrk2aa4j7IVSapahwe6Qsp5/XSVPNtNbYY0cmPcUL1YIa1v4/RhlSgUIbToX4Gi
	k1GUBPu2KcTaOOd+h7y2ewTbWs10hdvox6CoMxCQ1HGjSmXI484iimZriaMjNGdko99P0dT8Nby
	B203y7Pu8w/TBqGSyH/K+UjXKzEhBlVXQycZtWvkRQyp1pguXvemGS3J/jaGd0Bg/sdwh3NEE5D
	CM8VD7dDkPGTtQl1oaBd8cwbfo3zIceyxzhGgLoLSYmtuMjFFfEX7pajzw7+qaw2ty8Y9LS71c8
	S9gcd++egZSFn7Ot3kTJRhZr32M11a+hWSqieTuyIijQPvNxLSNvkvWvXNp5e2G1mrwunVhwXPL
	U5lYls5Zj2ERL+qiCJ8ZbW13T/72cdB7gq0owy9oyxRh+MJwyrlxrD8Q0f73kBr2B7d09VBgHjp
	47eCCKcXzwlG7LrlfmsvXOQGDk=
X-Received: by 2002:a5d:5f82:0:b0:460:25f3:b25a with SMTP id ffacd0b85a97d-4606dbb1b3emr5096879f8f.34.1781283143319;
        Fri, 12 Jun 2026 09:52:23 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:23 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 10/12] fs/ceph/super.h: add helper ceph_in_snap()
Date: Fri, 12 Jun 2026 18:52:02 +0200
Message-ID: <20260612165204.86137-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165204.86137-1-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some code simplification.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/acl.c        |  2 +-
 fs/ceph/addr.c       |  2 +-
 fs/ceph/dir.c        | 20 ++++++++++----------
 fs/ceph/export.c     |  8 ++++----
 fs/ceph/file.c       | 14 +++++++-------
 fs/ceph/inode.c      | 14 +++++++-------
 fs/ceph/mds_client.c | 10 +++++-----
 fs/ceph/quota.c      |  4 ++--
 fs/ceph/super.h      |  8 ++++++++
 fs/ceph/xattr.c      |  4 ++--
 10 files changed, 47 insertions(+), 39 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 85d3dd48b167..dbc64ab60308 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -99,7 +99,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct timespec64 old_ctime = inode_get_ctime(inode);
 	umode_t new_mode = inode->i_mode, old_mode = inode->i_mode;
 
-	if (ceph_snap(inode) != CEPH_NOSNAP) {
+	if (ceph_in_snap(inode)) {
 		ret = -EROFS;
 		goto out;
 	}
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a11b5c633358..b114ef483937 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2567,7 +2567,7 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 	if (!S_ISREG(inode->i_mode))
 		return 0;
 
-	if (ci->i_vino.snap != CEPH_NOSNAP) {
+	if (ceph_in_snap(inode)) {
 		/*
 		 * Pool permission check needs to write to the first object.
 		 * But for snapshot, head of the first object may have already
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 27ce9e55e947..c297cc57f88c 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -727,7 +727,7 @@ struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
 	struct ceph_client *cl = ceph_inode_to_client(parent);
 
 	/* .snap dir? */
-	if (ceph_snap(parent) == CEPH_NOSNAP &&
+	if (!ceph_in_snap(parent) &&
 	    strcmp(dentry->d_name.name, fsc->mount_options->snapdir_name) == 0) {
 		struct dentry *res;
 		struct inode *inode = ceph_get_snapdir(parent);
@@ -919,7 +919,7 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	struct ceph_acl_sec_ctx as_ctx = {};
 	int err;
 
-	if (ceph_snap(dir) != CEPH_NOSNAP)
+	if (ceph_in_snap(dir))
 		return -EROFS;
 
 	err = ceph_wait_on_conflict_unlink(dentry);
@@ -1031,7 +1031,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	umode_t mode = S_IFLNK | 0777;
 	int err;
 
-	if (ceph_snap(dir) != CEPH_NOSNAP)
+	if (ceph_in_snap(dir))
 		return -EROFS;
 
 	err = ceph_wait_on_conflict_unlink(dentry);
@@ -1115,7 +1115,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		op = CEPH_MDS_OP_MKSNAP;
 		doutc(cl, "mksnap %llx.%llx/'%pd' dentry %p\n",
 		      ceph_vinop(dir), dentry, dentry);
-	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
+	} else if (!ceph_in_snap(dir)) {
 		doutc(cl, "mkdir %llx.%llx/'%pd' dentry %p mode 0%ho\n",
 		      ceph_vinop(dir), dentry, dentry, mode);
 		op = CEPH_MDS_OP_MKDIR;
@@ -1202,7 +1202,7 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 	if (err)
 		return err;
 
-	if (ceph_snap(dir) != CEPH_NOSNAP)
+	if (ceph_in_snap(dir))
 		return -EROFS;
 
 	err = fscrypt_prepare_link(old_dentry, dir, dentry);
@@ -1354,7 +1354,7 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 		doutc(cl, "rmsnap %llx.%llx/'%pd' dn\n", ceph_vinop(dir),
 		      dentry);
 		op = CEPH_MDS_OP_RMSNAP;
-	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
+	} else if (!ceph_in_snap(dir)) {
 		doutc(cl, "unlink/rmdir %llx.%llx/'%pd' inode %llx.%llx\n",
 		      ceph_vinop(dir), dentry, ceph_vinop(inode));
 		op = d_is_dir(dentry) ?
@@ -1483,7 +1483,7 @@ static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	if (ceph_snap(old_dir) != ceph_snap(new_dir))
 		return -EXDEV;
-	if (ceph_snap(old_dir) != CEPH_NOSNAP) {
+	if (ceph_in_snap(old_dir)) {
 		if (old_dir == new_dir && ceph_snap(old_dir) == CEPH_SNAPDIR)
 			op = CEPH_MDS_OP_RENAMESNAP;
 		else
@@ -1981,7 +1981,7 @@ static int ceph_d_revalidate(struct inode *dir, const struct qstr *name,
 	mdsc = ceph_sb_to_fs_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
-	if (ceph_snap(dir) != CEPH_NOSNAP) {
+	if (ceph_in_snap(dir)) {
 		doutc(cl, "%p '%pd' inode %p is SNAPPED\n", dentry,
 		      dentry, inode);
 		valid = 1;
@@ -2065,7 +2065,7 @@ static int ceph_d_delete(const struct dentry *dentry)
 	/* won't release caps */
 	if (d_really_is_negative(dentry))
 		return 0;
-	if (ceph_snap(d_inode(dentry)) != CEPH_NOSNAP)
+	if (ceph_in_snap(d_inode(dentry)))
 		return 0;
 	/* valid lease? */
 	di = ceph_dentry(dentry);
@@ -2120,7 +2120,7 @@ static void ceph_d_prune(struct dentry *dentry)
 
 	/* we hold d_lock, so d_parent is stable */
 	dir_ci = ceph_inode(d_inode(dentry->d_parent));
-	if (dir_ci->i_vino.snap == CEPH_SNAPDIR)
+	if (ceph_in_snap(&dir_ci->netfs.inode))
 		return;
 
 	/* who calls d_delete() should also disable dcache readdir */
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index b2f2af104679..d132db40ba00 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -99,7 +99,7 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 	static const int connected_handle_length = CEPH_FH_WITH_PARENT_SIZE;
 	int type;
 
-	if (ceph_snap(inode) != CEPH_NOSNAP)
+	if (ceph_in_snap(inode))
 		return ceph_encode_snapfh(inode, rawfh, max_len, parent_inode);
 
 	if (parent_inode && (*max_len < connected_handle_length)) {
@@ -372,7 +372,7 @@ static struct dentry *ceph_get_parent(struct dentry *child)
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct dentry *dn;
 
-	if (ceph_snap(inode) != CEPH_NOSNAP) {
+	if (ceph_in_snap(inode)) {
 		struct inode* dir;
 		bool unlinked = false;
 		/* do not support non-directory */
@@ -456,7 +456,7 @@ static int __get_snap_name(struct dentry *parent, char *name,
 	if (ceph_ino(inode) != ceph_ino(dir))
 		goto out;
 	if (ceph_snap(inode) == CEPH_SNAPDIR) {
-		if (ceph_snap(dir) == CEPH_NOSNAP) {
+		if (!ceph_in_snap(dir)) {
 			/*
 			 * .get_name() from struct export_operations
 			 * assumes that its 'name' parameter is pointing
@@ -555,7 +555,7 @@ static int ceph_get_name(struct dentry *parent, char *name,
 	struct ceph_mds_reply_info_parsed *rinfo;
 	int err;
 
-	if (ceph_snap(inode) != CEPH_NOSNAP)
+	if (ceph_in_snap(inode))
 		return __get_snap_name(parent, name, child);
 
 	mdsc = ceph_inode_to_fs_client(inode)->mdsc;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d54d71669176..00e62991a416 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -437,7 +437,7 @@ int ceph_open(struct inode *inode, struct file *file)
 	}
 
 	/* snapped files are read-only */
-	if (ceph_snap(inode) != CEPH_NOSNAP && (file->f_mode & FMODE_WRITE))
+	if (ceph_in_snap(inode) && (file->f_mode & FMODE_WRITE))
 		return -EROFS;
 
 	/* trivially open snapdir */
@@ -469,7 +469,7 @@ int ceph_open(struct inode *inode, struct file *file)
 			ceph_check_caps(ci, 0);
 
 		return ceph_init_file(inode, file, fmode);
-	} else if (!do_sync && ceph_snap(inode) != CEPH_NOSNAP &&
+	} else if (!do_sync && ceph_in_snap(inode) &&
 		   (ci->i_snap_caps & wanted) == wanted) {
 		__ceph_touch_fmode(ci, mdsc, fmode);
 		spin_unlock(&ci->i_ceph_lock);
@@ -1534,7 +1534,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	bool should_dirty = !write && user_backed_iter(iter);
 	bool sparse = ceph_test_mount_opt(fsc, SPARSEREAD);
 
-	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
+	if (write && ceph_in_snap(file_inode(file)))
 		return -EROFS;
 
 	doutc(cl, "sync_direct_%s on file %p %lld~%u snapc %p seq %lld\n",
@@ -1770,7 +1770,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	struct timespec64 mtime = current_time(inode);
 	size_t count = iov_iter_count(from);
 
-	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
+	if (ceph_in_snap(file_inode(file)))
 		return -EROFS;
 
 	doutc(cl, "on file %p %lld~%u snapc %p seq %lld\n", file, pos,
@@ -2405,7 +2405,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	if (ceph_snap(inode) != CEPH_NOSNAP)
+	if (ceph_in_snap(inode))
 		return -EROFS;
 
 	prealloc_cf = ceph_alloc_cap_flush();
@@ -2757,7 +2757,7 @@ static long ceph_fallocate(struct file *file, int mode,
 
 	inode_lock(inode);
 
-	if (ceph_snap(inode) != CEPH_NOSNAP) {
+	if (ceph_in_snap(inode)) {
 		ret = -EROFS;
 		goto unlock;
 	}
@@ -3046,7 +3046,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 			return -EXDEV;
 		}
 	}
-	if (ceph_snap(dst_inode) != CEPH_NOSNAP)
+	if (ceph_in_snap(dst_inode))
 		return -EROFS;
 
 	/*
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index c0d88cf1f6e3..dcdbc24d1e21 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -765,7 +765,7 @@ void ceph_evict_inode(struct inode *inode)
 	 * caps in i_snap_caps.
 	 */
 	if (ci->i_snap_realm) {
-		if (ceph_snap(inode) == CEPH_NOSNAP) {
+		if (!ceph_in_snap(inode)) {
 			doutc(cl, " dropping residual ref to snap realm %p\n",
 			      ci->i_snap_realm);
 			ceph_change_snap_realm(inode, NULL);
@@ -1065,7 +1065,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	info_caps = le32_to_cpu(info->cap.caps);
 
 	/* prealloc new cap struct */
-	if (info_caps && ceph_snap(inode) == CEPH_NOSNAP) {
+	if (info_caps && !ceph_in_snap(inode)) {
 		new_cap = ceph_get_cap(mdsc, caps_reservation);
 		if (!new_cap)
 			return -ENOMEM;
@@ -1087,7 +1087,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		pool_ns = ceph_find_or_create_string(iinfo->pool_ns_data,
 						     iinfo->pool_ns_len);
 
-	if (ceph_snap(inode) != CEPH_NOSNAP && !ci->i_snapid_map)
+	if (ceph_in_snap(inode) && !ci->i_snapid_map)
 		ci->i_snapid_map = ceph_get_snapid_map(mdsc, ceph_snap(inode));
 
 	spin_lock(&ci->i_ceph_lock);
@@ -1332,7 +1332,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	/* were we issued a capability? */
 	if (info_caps) {
-		if (ceph_snap(inode) == CEPH_NOSNAP) {
+		if (!ceph_in_snap(inode)) {
 			ceph_add_cap(inode, session,
 				     le64_to_cpu(info->cap.cap_id),
 				     info_caps,
@@ -1432,7 +1432,7 @@ static void __update_dentry_lease(struct inode *dir, struct dentry *dentry,
 	doutc(cl, "%p duration %lu ms ttl %lu\n", dentry, duration, ttl);
 
 	/* only track leases on regular dentries */
-	if (ceph_snap(dir) != CEPH_NOSNAP)
+	if (ceph_in_snap(dir))
 		return;
 
 	if (mask & CEPH_LEASE_PRIMARY_LINK)
@@ -2929,7 +2929,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int err;
 
-	if (ceph_snap(inode) != CEPH_NOSNAP)
+	if (ceph_in_snap(inode))
 		return -EROFS;
 
 	if (ceph_inode_is_shutdown(inode))
@@ -3184,7 +3184,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 		valid_mask |= STATX_CHANGE_COOKIE;
 	}
 
-	if (ceph_snap(inode) == CEPH_NOSNAP)
+	if (!ceph_in_snap(inode))
 		stat->dev = sb->s_dev;
 	else
 		stat->dev = ci->i_snapid_map ? ci->i_snapid_map->dev : 0;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ed17e0023705..1534a91342a7 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1308,7 +1308,7 @@ static struct inode *get_nonsnap_parent(struct dentry *dentry)
 
 	while (dentry && !IS_ROOT(dentry)) {
 		inode = d_inode_rcu(dentry);
-		if (!inode || ceph_snap(inode) == CEPH_NOSNAP)
+		if (!inode || !ceph_in_snap(inode))
 			break;
 		dentry = dentry->d_parent;
 	}
@@ -1382,7 +1382,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			inode = d_inode(req->r_dentry);
 			if (inode)
 				ihold(inode);
-		} else if (ceph_snap(dir) != CEPH_NOSNAP) {
+		} else if (ceph_in_snap(dir)) {
 			/* direct snapped/virtual snapdir requests
 			 * based on parent dir inode */
 			inode = get_nonsnap_parent(parent);
@@ -2782,7 +2782,7 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 			spin_unlock(&cur->d_lock);
 			parent = dget_parent(cur);
 		} else if (for_wire && inode && dentry != cur &&
-			   ceph_snap(inode) == CEPH_NOSNAP) {
+			   !ceph_in_snap(inode)) {
 			spin_unlock(&cur->d_lock);
 			pos++; /* get rid of any prepended '/' */
 			break;
@@ -2891,7 +2891,7 @@ static int build_dentry_path(struct ceph_mds_client *mdsc, struct dentry *dentry
 	rcu_read_lock();
 	if (!dir)
 		dir = d_inode_rcu(dentry->d_parent);
-	if (dir && parent_locked && ceph_snap(dir) == CEPH_NOSNAP &&
+	if (dir && parent_locked && !ceph_in_snap(dir) &&
 	    !IS_ENCRYPTED(dir)) {
 		path_info->vino.ino = ceph_ino(dir);
 		path_info->vino.snap = ceph_snap(dir);
@@ -2917,7 +2917,7 @@ static int build_inode_path(struct inode *inode, struct ceph_path_info *path_inf
 	struct dentry *dentry;
 	char *path;
 
-	if (ceph_snap(inode) == CEPH_NOSNAP) {
+	if (!ceph_in_snap(inode)) {
 		path_info->vino.ino = ceph_ino(inode);
 		path_info->vino.snap = ceph_snap(inode);
 		path_info->pathlen = 0;
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 053d5bf0c9f0..08641d578a0b 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -223,7 +223,7 @@ static int get_quota_realm(struct ceph_mds_client *mdsc, struct inode *inode,
 
 	if (realmp)
 		*realmp = NULL;
-	if (ceph_snap(inode) != CEPH_NOSNAP)
+	if (ceph_in_snap(inode))
 		return 0;
 
 restart:
@@ -341,7 +341,7 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 	u64 max, rvalue;
 	bool exceeded = false;
 
-	if (ceph_snap(inode) != CEPH_NOSNAP)
+	if (ceph_in_snap(inode))
 		return false;
 
 	down_read(&mdsc->snap_rwsem);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index b1d38fa6647f..abdbffbdf0e6 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -601,6 +601,14 @@ static inline u64 ceph_snap(const struct inode *inode)
 	return ceph_inode(inode)->i_vino.snap;
 }
 
+/**
+ * Is this inode in a ".snap" directory?
+ */
+static inline bool ceph_in_snap(const struct inode *inode)
+{
+	return ceph_snap(inode) != CEPH_NOSNAP;
+}
+
 /**
  * ceph_present_ino - format an inode number for presentation to userland
  * @sb: superblock where the inode lives
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 9808eb10625d..c5e9ef656b5f 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -270,7 +270,7 @@ static bool ceph_vxattrcb_quota_exists(struct ceph_inode_info *ci)
 	bool ret = false;
 	spin_lock(&ci->i_ceph_lock);
 	if ((ci->i_max_files || ci->i_max_bytes) &&
-	    ci->i_vino.snap == CEPH_NOSNAP &&
+	    !ceph_in_snap(&ci->netfs.inode) &&
 	    ci->i_snap_realm &&
 	    ci->i_snap_realm->ino == ci->i_vino.ino)
 		ret = true;
@@ -1193,7 +1193,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	bool check_realm = false;
 	bool lock_snap_rwsem = false;
 
-	if (ceph_snap(inode) != CEPH_NOSNAP)
+	if (ceph_in_snap(inode))
 		return -EROFS;
 
 	vxattr = ceph_match_vxattr(inode, name);
-- 
2.47.3

