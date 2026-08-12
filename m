Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999A39989B
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566611; cv=none; b=H/YztzLsl6eLhxNXgJrAVKR+ufgbox46Oc+ZYCwIaRMK73BAg17fEJ5/q6uueOBXaPvbSa9Imj723oypoyDgmkzLubjG0xvhgUgh3+h4j3ItQx3OTkFWbhYsG7Z/Hw/JdzVOOUkT+kk+q0jDBrejNwPrvA97/53EbvRS/Ba41Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566611; c=relaxed/simple;
	bh=dg4XycQgbP52ff/jMZ+ruw0UIVZtZYKbyBYR8u9n6iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0QwXBTHk/plqZFLpyB2VzjTkwiZf8aHtxWZ9pydt//OWEkK0WUi9FV28zU7h1aZoXjqeeLeeG6/F592NWdwkcUr7SGCZ/O8IIQx1srGuFiCrIOXlSxGktl8YA3pIftl4lVL6A4CZyKUHo6oJ3Qs9ULfT4UXBuGIuL5uA+2WByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=N93JHfts; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="N93JHfts"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4813ea321cdso159683f8f.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566603; x=1787171403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sr6Inj40Q52yIlmd6pGulinTuc3cDoTPWh/IL/dOKtI=;
        b=N93JHftsJ9XPsewJ7khKGz8RDmdM7P7TNQMa6MvkLcgDXXNdDBcsiikaui0Bazy0Yx
         54cmb0KI8Yc0AWKfNEcy9H2f/TTwmQnGALM1tHCzxo3HVf+ze8wwL/X4BEvKQcjnDDfX
         /gQYrQEDSJAGew4y+/iz4JMt/TDGzwrrY8vHAr+ZSX1A9jSTerRH1KkoCrVwd8qd+btf
         JBWPNSYrmofRT4i9YZxT9uOEDjfycU1+T2x2RbnZF0yJj4uIVI45yZ2JBy5agRnQeXCK
         gJ4zgvmCrVKJxDEyXHDn3KWzGGRZoDZ0sCDVQk2AAByIAVWS7/3OvTPJ/JfguXS8nzcR
         /G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566603; x=1787171403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sr6Inj40Q52yIlmd6pGulinTuc3cDoTPWh/IL/dOKtI=;
        b=O96Y3kt5P+E/5dRwgM3Wp4KrLNmB388PNS7CdxYcExFZNZ2tHGIGfXeNjmzuOSp6B8
         3jZ167vhhRu0MKjPJi3+iqJXB93dP4IQx5zHqOOQ1NR8u5OG0Ds8jjhP1L9PA6nSc4Ih
         t1pOKtW+FpNX0U+GdWLvbELq1HauU0vxP2qT7N9j4QCOMoTFD15VaBvOEpIBv44cNPPS
         +aBHSJheZvRKC0ojXf03qs4XQYgOokv3y0t7ynv8uMCYhyAvPY234hMLIDxfm0WzizH0
         dao1cR9h120EoZsUkMZIYVBrvlmQd11cxqvjMOk+WPCylxXLvOUvgdV50zOzAbf6A8ov
         2psQ==
X-Forwarded-Encrypted: i=1; AHgh+RrCtHnvnvfFhjsC5MfZV6/+532mR74UBIpaicOPI3bOA2vZoT+0vPb5cP/9h5JhdySnPtRDpexX42IE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2zat7ZQRn+tUZyliBzXwMQr/aYGyNhS7wiq69YXUapeCnPVy
	OrMxIJ8+2+fHh1EVtkvXmpeNVN6eAhMJNeOrr8+uDz6tOvVXG1Z6LlDEJAXpQ0K2+68=
X-Gm-Gg: AR+sD12Uucji+xcqmwKrAiZCNpPh85krqTFZKTEEisyWk7Qr9HkLl6twpDAR5UEpc6H
	OSq9Qy1VNIZ/M5xHLvJ/8cafInREKFV4NRV8nG2NKVvowMNLndqxFbgL1S4UY1vyp+SRvdR2dyp
	wvySX06cRJbrOaQQbBG/8ukCBi2yJDvyNGWuebqsqOi1IF8WNYc7V0mj7ch0vi1rMEIX87G0zjm
	lii4oE6tT9Zf1z/0HUclKhkQUnjTKHLnyUt6yKk+4F2Voog7SLj9vH4TYd7bTNvoanq+hIhp0iC
	LM6wyDeOab3Yl/VXzpBgJIVatj9obvS/A1H3YcXImqr4xhuXEXsRQvHg1Mmzi6+xpgUgLELNbuq
	8ktDy9k99YSEjX/xbnEx+he/z/AP1uOR1GdZ/nHWqfXp7rtls4vdHH2c9OYE32XcHEG2UFuJgQb
	BxzyXmv5Iu9mgKE0QVRAzOKoPTULJRULpKZhk3gBgqTwJK7SZXXGPLgc8Y5pixixxtqfX+5uomp
	Nbsz0spoJE2Riu65ohRS3f0y58VY2z54FFTxy0DNEgQ0sipQslFD7ZnPRr1nopl
X-Received: by 2002:a05:6000:2c0e:b0:481:314b:b041 with SMTP id ffacd0b85a97d-4815a5c9325mr304526f8f.7.1786566602654;
        Wed, 12 Aug 2026 13:30:02 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:30:02 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 10/12] fs/ceph/super.h: add helper ceph_in_snap()
Date: Wed, 12 Aug 2026 22:29:47 +0200
Message-ID: <20260812202950.1800340-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812202950.1800340-1-max.kellermann@ionos.com>
References: <20260812202950.1800340-1-max.kellermann@ionos.com>
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
index 77f1ff658663..ecfd0fed3471 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2577,7 +2577,7 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 	if (!S_ISREG(inode->i_mode))
 		return 0;
 
-	if (ci->i_vino.snap != CEPH_NOSNAP) {
+	if (ceph_in_snap(inode)) {
 		/*
 		 * Pool permission check needs to write to the first object.
 		 * But for snapshot, head of the first object may have already
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index ef9e92e362d3..484f86f6155f 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -732,7 +732,7 @@ struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
 	struct ceph_client *cl = ceph_inode_to_client(parent);
 
 	/* .snap dir? */
-	if (ceph_snap(parent) == CEPH_NOSNAP &&
+	if (!ceph_in_snap(parent) &&
 	    strcmp(dentry->d_name.name, fsc->mount_options->snapdir_name) == 0) {
 		struct dentry *res;
 		struct inode *inode = ceph_get_snapdir(parent);
@@ -924,7 +924,7 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	struct ceph_acl_sec_ctx as_ctx = {};
 	int err;
 
-	if (ceph_snap(dir) != CEPH_NOSNAP)
+	if (ceph_in_snap(dir))
 		return -EROFS;
 
 	err = ceph_wait_on_conflict_unlink(dentry);
@@ -1036,7 +1036,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	umode_t mode = S_IFLNK | 0777;
 	int err;
 
-	if (ceph_snap(dir) != CEPH_NOSNAP)
+	if (ceph_in_snap(dir))
 		return -EROFS;
 
 	err = ceph_wait_on_conflict_unlink(dentry);
@@ -1120,7 +1120,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		op = CEPH_MDS_OP_MKSNAP;
 		doutc(cl, "mksnap %llx.%llx/'%pd' dentry %p\n",
 		      ceph_vinop(dir), dentry, dentry);
-	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
+	} else if (!ceph_in_snap(dir)) {
 		doutc(cl, "mkdir %llx.%llx/'%pd' dentry %p mode 0%ho\n",
 		      ceph_vinop(dir), dentry, dentry, mode);
 		op = CEPH_MDS_OP_MKDIR;
@@ -1207,7 +1207,7 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 	if (err)
 		return err;
 
-	if (ceph_snap(dir) != CEPH_NOSNAP)
+	if (ceph_in_snap(dir))
 		return -EROFS;
 
 	err = fscrypt_prepare_link(old_dentry, dir, dentry);
@@ -1359,7 +1359,7 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 		doutc(cl, "rmsnap %llx.%llx/'%pd' dn\n", ceph_vinop(dir),
 		      dentry);
 		op = CEPH_MDS_OP_RMSNAP;
-	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
+	} else if (!ceph_in_snap(dir)) {
 		doutc(cl, "unlink/rmdir %llx.%llx/'%pd' inode %llx.%llx\n",
 		      ceph_vinop(dir), dentry, ceph_vinop(inode));
 		op = d_is_dir(dentry) ?
@@ -1488,7 +1488,7 @@ static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	if (ceph_snap(old_dir) != ceph_snap(new_dir))
 		return -EXDEV;
-	if (ceph_snap(old_dir) != CEPH_NOSNAP) {
+	if (ceph_in_snap(old_dir)) {
 		if (old_dir == new_dir && ceph_snap(old_dir) == CEPH_SNAPDIR)
 			op = CEPH_MDS_OP_RENAMESNAP;
 		else
@@ -1986,7 +1986,7 @@ static int ceph_d_revalidate(struct inode *dir, const struct qstr *name,
 	mdsc = ceph_sb_to_fs_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
-	if (ceph_snap(dir) != CEPH_NOSNAP) {
+	if (ceph_in_snap(dir)) {
 		doutc(cl, "%p '%pd' inode %p is SNAPPED\n", dentry,
 		      dentry, inode);
 		valid = 1;
@@ -2070,7 +2070,7 @@ static int ceph_d_delete(const struct dentry *dentry)
 	/* won't release caps */
 	if (d_really_is_negative(dentry))
 		return 0;
-	if (ceph_snap(d_inode(dentry)) != CEPH_NOSNAP)
+	if (ceph_in_snap(d_inode(dentry)))
 		return 0;
 	/* valid lease? */
 	di = ceph_dentry(dentry);
@@ -2125,7 +2125,7 @@ static void ceph_d_prune(struct dentry *dentry)
 
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
index a4a2a4b6a027..e79c18aee78d 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -438,7 +438,7 @@ int ceph_open(struct inode *inode, struct file *file)
 	}
 
 	/* snapped files are read-only */
-	if (ceph_snap(inode) != CEPH_NOSNAP && (file->f_mode & FMODE_WRITE))
+	if (ceph_in_snap(inode) && (file->f_mode & FMODE_WRITE))
 		return -EROFS;
 
 	/* trivially open snapdir */
@@ -470,7 +470,7 @@ int ceph_open(struct inode *inode, struct file *file)
 			ceph_check_caps(ci, 0);
 
 		return ceph_init_file(inode, file, fmode);
-	} else if (!do_sync && ceph_snap(inode) != CEPH_NOSNAP &&
+	} else if (!do_sync && ceph_in_snap(inode) &&
 		   (ci->i_snap_caps & wanted) == wanted) {
 		__ceph_touch_fmode(ci, mdsc, fmode);
 		spin_unlock(&ci->i_ceph_lock);
@@ -1540,7 +1540,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	bool should_dirty = !write && user_backed_iter(iter);
 	bool sparse = ceph_test_mount_opt(fsc, SPARSEREAD);
 
-	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
+	if (write && ceph_in_snap(file_inode(file)))
 		return -EROFS;
 
 	doutc(cl, "sync_direct_%s on file %p %lld~%u snapc %p seq %lld\n",
@@ -1776,7 +1776,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	struct timespec64 mtime = current_time(inode);
 	size_t count = iov_iter_count(from);
 
-	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
+	if (ceph_in_snap(file_inode(file)))
 		return -EROFS;
 
 	doutc(cl, "on file %p %lld~%u snapc %p seq %lld\n", file, pos,
@@ -2411,7 +2411,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	if (ceph_snap(inode) != CEPH_NOSNAP)
+	if (ceph_in_snap(inode))
 		return -EROFS;
 
 	prealloc_cf = ceph_alloc_cap_flush();
@@ -2763,7 +2763,7 @@ static long ceph_fallocate(struct file *file, int mode,
 
 	inode_lock(inode);
 
-	if (ceph_snap(inode) != CEPH_NOSNAP) {
+	if (ceph_in_snap(inode)) {
 		ret = -EROFS;
 		goto unlock;
 	}
@@ -3052,7 +3052,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 			return -EXDEV;
 		}
 	}
-	if (ceph_snap(dst_inode) != CEPH_NOSNAP)
+	if (ceph_in_snap(dst_inode))
 		return -EROFS;
 
 	/*
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 1f65aa387008..aba98975a8a3 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -766,7 +766,7 @@ void ceph_evict_inode(struct inode *inode)
 	 * caps in i_snap_caps.
 	 */
 	if (ci->i_snap_realm) {
-		if (ceph_snap(inode) == CEPH_NOSNAP) {
+		if (!ceph_in_snap(inode)) {
 			doutc(cl, " dropping residual ref to snap realm %p\n",
 			      ci->i_snap_realm);
 			ceph_change_snap_realm(inode, NULL);
@@ -1066,7 +1066,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	info_caps = le32_to_cpu(info->cap.caps);
 
 	/* prealloc new cap struct */
-	if (info_caps && ceph_snap(inode) == CEPH_NOSNAP) {
+	if (info_caps && !ceph_in_snap(inode)) {
 		new_cap = ceph_get_cap(mdsc, caps_reservation);
 		if (!new_cap)
 			return -ENOMEM;
@@ -1088,7 +1088,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		pool_ns = ceph_find_or_create_string(iinfo->pool_ns_data,
 						     iinfo->pool_ns_len);
 
-	if (ceph_snap(inode) != CEPH_NOSNAP && !ci->i_snapid_map)
+	if (ceph_in_snap(inode) && !ci->i_snapid_map)
 		ci->i_snapid_map = ceph_get_snapid_map(mdsc, ceph_snap(inode));
 
 	spin_lock(&ci->i_ceph_lock);
@@ -1333,7 +1333,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	/* were we issued a capability? */
 	if (info_caps) {
-		if (ceph_snap(inode) == CEPH_NOSNAP) {
+		if (!ceph_in_snap(inode)) {
 			ceph_add_cap(inode, session,
 				     le64_to_cpu(info->cap.cap_id),
 				     info_caps,
@@ -1433,7 +1433,7 @@ static void __update_dentry_lease(struct inode *dir, struct dentry *dentry,
 	doutc(cl, "%p duration %lu ms ttl %lu\n", dentry, duration, ttl);
 
 	/* only track leases on regular dentries */
-	if (ceph_snap(dir) != CEPH_NOSNAP)
+	if (ceph_in_snap(dir))
 		return;
 
 	if (mask & CEPH_LEASE_PRIMARY_LINK)
@@ -2930,7 +2930,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int err;
 
-	if (ceph_snap(inode) != CEPH_NOSNAP)
+	if (ceph_in_snap(inode))
 		return -EROFS;
 
 	if (ceph_inode_is_shutdown(inode))
@@ -3185,7 +3185,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 		valid_mask |= STATX_CHANGE_COOKIE;
 	}
 
-	if (ceph_snap(inode) == CEPH_NOSNAP)
+	if (!ceph_in_snap(inode))
 		stat->dev = sb->s_dev;
 	else
 		stat->dev = ci->i_snapid_map ? ci->i_snapid_map->dev : 0;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3c692ad02c85..30f8430b2825 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1311,7 +1311,7 @@ static struct inode *get_nonsnap_parent(struct dentry *dentry)
 
 	while (dentry && !IS_ROOT(dentry)) {
 		inode = d_inode_rcu(dentry);
-		if (!inode || ceph_snap(inode) == CEPH_NOSNAP)
+		if (!inode || !ceph_in_snap(inode))
 			break;
 		dentry = dentry->d_parent;
 	}
@@ -1385,7 +1385,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			inode = d_inode(req->r_dentry);
 			if (inode)
 				ihold(inode);
-		} else if (ceph_snap(dir) != CEPH_NOSNAP) {
+		} else if (ceph_in_snap(dir)) {
 			/* direct snapped/virtual snapdir requests
 			 * based on parent dir inode */
 			inode = get_nonsnap_parent(parent);
@@ -2878,7 +2878,7 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 			spin_unlock(&cur->d_lock);
 			parent = dget_parent(cur);
 		} else if (for_wire && inode && dentry != cur &&
-			   ceph_snap(inode) == CEPH_NOSNAP) {
+			   !ceph_in_snap(inode)) {
 			spin_unlock(&cur->d_lock);
 			pos++; /* get rid of any prepended '/' */
 			break;
@@ -2987,7 +2987,7 @@ static int build_dentry_path(struct ceph_mds_client *mdsc, struct dentry *dentry
 	rcu_read_lock();
 	if (!dir)
 		dir = d_inode_rcu(dentry->d_parent);
-	if (dir && parent_locked && ceph_snap(dir) == CEPH_NOSNAP &&
+	if (dir && parent_locked && !ceph_in_snap(dir) &&
 	    !IS_ENCRYPTED(dir)) {
 		path_info->vino.ino = ceph_ino(dir);
 		path_info->vino.snap = ceph_snap(dir);
@@ -3013,7 +3013,7 @@ static int build_inode_path(struct inode *inode, struct ceph_path_info *path_inf
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
index ab6fa8319c79..b0b8d04b594f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -608,6 +608,14 @@ static inline u64 ceph_snap(const struct inode *inode)
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
index 124dde705e79..af54480d9254 100644
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

