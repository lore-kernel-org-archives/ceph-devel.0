Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751BF485CEF
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076720; cv=none; b=c31f1wfA0w4wAZ9zIt8CsaUppRrdHlNL5wuy98YEAypj/FXaCnjC730t0tLpL5E/hpw6wYqkB17GeVCSvDbCBpMM30sPWLRnzS361rkAxGXIgv1ZhZEhZwMynPWbJBHoMytfkJVuRkeGxNGS4IivKvxxC44HKCh6jg9BTrB3cqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076720; c=relaxed/simple;
	bh=XIaAcsMDWqDAyfrb8kfi4hDQ8HlgRwTpnF2oNK/lVHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GF+t6vefHRvtipyZKwaAsWUYY52lhY/N0Nr/4L5+6C8T0DzciNmHMObMukVtckNWFox+aZTQIZkPDggj2jGMlXOg3lSZruDT/WbxQTBC5F4M4HgMtMjmotUdCNJQTnsCQXXTiLd1LSvs6/FJVh9Y8EqdXRWDzmfLazOgZ2vx/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XDwVzJi5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XDwVzJi5"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4994c49f588so696855e9.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076716; x=1787681516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wrA+HmPGA+F3fv34XjLm3D0Yr8NYT9tPwufva4MgP2Y=;
        b=XDwVzJi5VPy/QJeFmLHU+UEY/pd/qLc/fTVU/LJIj4ARmkKBhf8UEN7Eb7Owm54Qij
         aeBg0AHdjWpc8aHRXc/Oe3MxTb5JWZp4PB39C7TF9KS/LHgzA9fbLP5bGp19IGyZivy5
         PJxscpwv+5sHtuEo4WW0+46YlOj44A/WynSGrBEQjABkmZK4pkHqX/sVbMljpjCCs3oQ
         sD03hCZSiv/xhtZic0UR01ktnjjFbDM/jEss4tFbPO4C7WFR0Hpqm+ckDzo7v+PbDSLC
         p9/eDD/1aBXMXtlMs+gI+qS8gOJWHt48GglrlLTBlxtS6jbc42zN8GppuJghnl5CLEYb
         w8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076716; x=1787681516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wrA+HmPGA+F3fv34XjLm3D0Yr8NYT9tPwufva4MgP2Y=;
        b=Tux86+Wc536+Q/pRvaE7AH2Qv6i8Ev+Bi+I+/4TzDlV6v6fUkNyAilpl5Ryh4PzhIo
         ef8pmosgrwnQeiyDru3aZH2vye5Q51qXhgcLFdXc57L7Tczd4kk5PvCURpLXl1pt3x1E
         WaNMAZ0L4dcNtUpUrPL048wCtVdAOSDhDnUbhwHOIqRxF0acu0Bew+22YVojtf2GSJ8e
         SZcsbzubOTNNSOD6vhUun0JjRw/cSH4PNltDwmhPtz0tInKAU6VE5ful24LqH1yXNYjw
         9K9DtAoLsuAXAdMCBSgotv+1PhkMFpKjBQrrqijBv5nkdPrKo0fezpTUk3BXcVGuffQ4
         C7cw==
X-Forwarded-Encrypted: i=1; AHgh+RqmuVF/r09WhO6olV2oS8iKYuyMs7DvgxYw7RvGWb3Ef0m5lODMMPZAdmRIJ96WwCKa1TSJgEYgxzY3@vger.kernel.org
X-Gm-Message-State: AOJu0YxMp3AyDdjVU4J7nCGN3Tff0e4/HxQOte8d1z19tPwWKTVYh+Uo
	xOXJf+ZW0d4zRwl0QfzPk8eQsx9z7wM761mfBkbPTMl+G0GKQMOzKxT6ykUeDCRggKA=
X-Gm-Gg: AR+sD13SVu/JF+Zv6SBhXVIFDBxFE4KPUSp8FLabKk65NNKPkNINj7VUAQO2g+O4tVA
	r3BIrvWvipBnYnHGC9SCiPyN+LcwwK8NzNPYKSiuSkEPd3njx8Ygg/9tCO9o9b865HjEx8qUPAp
	f6cU4VZR+MS007+jhKbg5VIFyfiYrxuJeTAHLcLLECrjGvGBBabinG7Xw78Svqkm0RK4EIbhFz5
	KThAnVZTm1d+hlcg0l+092NGVz6NR0xwDXd1bX+DIPTVbdgswv7ckI/bn+XggYtcYXj6elZ42ab
	yndZXupz62g84GqPVW5tDkEwSbJ84atXhTBlBN5byLnt9OfQzOqhBYVuX5otPkrBzzegm0Qs4PY
	rhHqUNke7v25RV16UeZwL0fCb9nazRQ9I2cuOgMx9aGLHyJAvOfZlHsbujnJycronwlsIOSHFNY
	fXef+D6ShFZMHK1knN6gwtpcNg2FM1QWdZPDmOxDxMpCW7pG4rpeLMUfUUD9CbtHFtWwwXTITrF
	cxTEx/AZ5SAhrhH9j1cPGoUMog67jV7PDqRWCmoPGkjwNvWkgksa/ZEFXgp6TG9
X-Received: by 2002:a05:600c:5306:b0:493:e543:1dd9 with SMTP id 5b1f17b1804b1-499a0907846mr201086105e9.9.1787076715684;
        Tue, 18 Aug 2026 11:11:55 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:55 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 10/12] fs/ceph/super.h: add helper ceph_in_snap()
Date: Tue, 18 Aug 2026 20:11:42 +0200
Message-ID: <20260818181144.3541770-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818181144.3541770-1-max.kellermann@ionos.com>
References: <20260818181144.3541770-1-max.kellermann@ionos.com>
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
 fs/ceph/dir.c        | 18 +++++++++---------
 fs/ceph/export.c     |  8 ++++----
 fs/ceph/file.c       | 14 +++++++-------
 fs/ceph/inode.c      | 14 +++++++-------
 fs/ceph/mds_client.c | 10 +++++-----
 fs/ceph/quota.c      |  4 ++--
 fs/ceph/super.h      |  8 ++++++++
 fs/ceph/xattr.c      |  4 ++--
 10 files changed, 46 insertions(+), 38 deletions(-)

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
index 4a5e0290f2e3..aff72458d3f4 100644
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
@@ -1206,7 +1206,7 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 	if (err)
 		return err;
 
-	if (ceph_snap(dir) != CEPH_NOSNAP)
+	if (ceph_in_snap(dir))
 		return -EROFS;
 
 	err = fscrypt_prepare_link(old_dentry, dir, dentry);
@@ -1358,7 +1358,7 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 		doutc(cl, "rmsnap %llx.%llx/'%pd' dn\n", ceph_vinop(dir),
 		      dentry);
 		op = CEPH_MDS_OP_RMSNAP;
-	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
+	} else if (!ceph_in_snap(dir)) {
 		doutc(cl, "unlink/rmdir %llx.%llx/'%pd' inode %llx.%llx\n",
 		      ceph_vinop(dir), dentry, ceph_vinop(inode));
 		op = d_is_dir(dentry) ?
@@ -1487,7 +1487,7 @@ static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	if (ceph_snap(old_dir) != ceph_snap(new_dir))
 		return -EXDEV;
-	if (ceph_snap(old_dir) != CEPH_NOSNAP) {
+	if (ceph_in_snap(old_dir)) {
 		if (old_dir == new_dir && ceph_snap(old_dir) == CEPH_SNAPDIR)
 			op = CEPH_MDS_OP_RENAMESNAP;
 		else
@@ -1985,7 +1985,7 @@ static int ceph_d_revalidate(struct inode *dir, const struct qstr *name,
 	mdsc = ceph_sb_to_fs_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
-	if (ceph_snap(dir) != CEPH_NOSNAP) {
+	if (ceph_in_snap(dir)) {
 		doutc(cl, "%p '%pd' inode %p is SNAPPED\n", dentry,
 		      dentry, inode);
 		valid = 1;
@@ -2069,7 +2069,7 @@ static int ceph_d_delete(const struct dentry *dentry)
 	/* won't release caps */
 	if (d_really_is_negative(dentry))
 		return 0;
-	if (ceph_snap(d_inode(dentry)) != CEPH_NOSNAP)
+	if (ceph_in_snap(d_inode(dentry)))
 		return 0;
 	/* valid lease? */
 	di = ceph_dentry(dentry);
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

