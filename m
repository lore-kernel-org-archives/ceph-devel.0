From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC v2 PATCH 3/4] ceph: quotas: support for ceph.quota.max_files
Date: Mon, 18 Dec 2017 15:39:01 +0000
Message-ID: <20171218153902.7455-4-lhenriques@suse.com>
References: <20171218153902.7455-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33695 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753083AbdLRPjP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 18 Dec 2017 10:39:15 -0500
In-Reply-To: <20171218153902.7455-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>, Luis Henriques <lhenriques@suse.com>

This patch adds support for the max_files quota.  It hooks into all the
ceph functions that add new filesystem objects that need to be checked
against the quota limits.  When these limits are hit, -EDQUOT is returned.

Note that we're not checking quotas on ceph_link().  ceph_link doesn't
really create a new inode,  and since the MDS doesn't update the directory
statistics when a new (hard) link is created (only with symlinks), they
are not accounted as a new file.

Link: http://tracker.ceph.com/issues/22372
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/dir.c   | 11 +++++++++
 fs/ceph/file.c  |  4 ++-
 fs/ceph/quota.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/super.h |  1 +
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8a5266699b67..66550d92b1ac 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -818,6 +818,9 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
 	if (ceph_snap(dir) != CEPH_NOSNAP)
 		return -EROFS;
 
+	if (ceph_quota_is_max_files_exceeded(dir))
+		return -EDQUOT;
+
 	err = ceph_pre_init_acls(dir, &mode, &acls);
 	if (err < 0)
 		return err;
@@ -871,6 +874,9 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 	if (ceph_snap(dir) != CEPH_NOSNAP)
 		return -EROFS;
 
+	if (ceph_quota_is_max_files_exceeded(dir))
+		return -EDQUOT;
+
 	dout("symlink in dir %p dentry %p to '%s'\n", dir, dentry, dest);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SYMLINK, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
@@ -920,6 +926,11 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		goto out;
 	}
 
+	if (ceph_quota_is_max_files_exceeded(dir)) {
+		err = -EDQUOT;
+		goto out;
+	}
+
 	mode |= S_IFDIR;
 	err = ceph_pre_init_acls(dir, &mode, &acls);
 	if (err < 0)
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5c17125f45c7..5a77a66e3d6b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -371,7 +371,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct ceph_mds_request *req;
 	struct dentry *dn;
 	struct ceph_acls_info acls = {};
-       int mask;
+	int mask;
 	int err;
 
 	dout("atomic_open %p dentry %p '%pd' %s flags %d mode 0%o\n",
@@ -382,6 +382,8 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		return -ENAMETOOLONG;
 
 	if (flags & O_CREAT) {
+		if (ceph_quota_is_max_files_exceeded(dir))
+			return -EDQUOT;
 		err = ceph_pre_init_acls(dir, &mode, &acls);
 		if (err < 0)
 			return err;
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 69d74d7b73ad..06f28f11be25 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -57,3 +57,78 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
 
 	iput(inode);
 }
+
+/*
+ * check_quota_exceeded() will walk up the snaprealm hierarchy and, for each
+ * realm, it will execute quota check operation defined by the 'op' parameter.
+ * The snaprealm walk is interrupted if the quota check detects that the quota
+ * is exceeded or if the root inode is reached.
+ * The whole operation is restarted if a snaprealm change is detected through
+ * the snaprealm_lock seqlock.
+ */
+enum quota_check_op {
+	QUOTA_CHECK_MAX_FILES_OP /* check quota max_files limit */
+};
+
+static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
+				 loff_t size)
+{
+	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_inode_info *ci;
+	struct ceph_snap_realm *realm, *next;
+	struct ceph_vino vino;
+	struct inode *ino;
+	u64 max = 0, rvalue = 0;
+	bool quota_exceeded, is_root;
+	unsigned seq;
+
+	WARN_ON(!S_ISDIR(inode->i_mode));
+retry:
+	quota_exceeded = false;
+	seq = read_seqbegin(&snaprealm_lock);
+	realm = ceph_inode(inode)->i_snap_realm;
+	ceph_get_snap_realm(mdsc, realm);
+	while (realm) {
+		vino.ino = realm->ino;
+		vino.snap = CEPH_NOSNAP;
+		ino = ceph_find_inode(inode->i_sb, vino);
+		if (!ino) {
+			pr_warn("Failed to find inode for %llu\n", vino.ino);
+			break;
+		}
+		ci = ceph_inode(ino);
+		switch(op) {
+		case QUOTA_CHECK_MAX_FILES_OP:
+			spin_lock(&ci->i_ceph_lock);
+			max = ci->i_max_files;
+			rvalue = ci->i_rfiles + ci->i_rsubdirs;
+			is_root = (ci->i_vino.ino == CEPH_INO_ROOT);
+			spin_unlock(&ci->i_ceph_lock);
+			quota_exceeded = (max && (rvalue >= max));
+			break;
+		default:
+			/* Shouldn't happen */
+			pr_warn("Invalid quota check op (%d)\n", op);
+			is_root = true; /* Just break the look */
+		}
+		iput(ino);
+
+		if (quota_exceeded || is_root)
+			break;
+		next = realm->parent;
+		ceph_get_snap_realm(mdsc, next);
+		ceph_put_snap_realm(mdsc, realm);
+		realm = next;
+	}
+	ceph_put_snap_realm(mdsc, realm);
+
+	if (read_seqretry(&snaprealm_lock, seq))
+		goto retry;
+
+	return quota_exceeded;
+}
+
+bool ceph_quota_is_max_files_exceeded(struct inode *inode)
+{
+	return check_quota_exceeded(inode, QUOTA_CHECK_MAX_FILES_OP, 0);
+}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index e3e68448f55c..a83847d6f8f9 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1028,5 +1028,6 @@ extern void ceph_fs_debugfs_cleanup(struct ceph_fs_client *client);
 extern void ceph_handle_quota(struct ceph_mds_client *mdsc,
 			      struct ceph_mds_session *session,
 			      struct ceph_msg *msg);
+extern bool ceph_quota_is_max_files_exceeded(struct inode *inode);
 
 #endif /* _FS_CEPH_SUPER_H */
