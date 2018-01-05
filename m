From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v4 2/6] ceph: quota: support for ceph.quota.max_files
Date: Fri,  5 Jan 2018 10:47:19 +0000
Message-ID: <20180105104723.16202-3-lhenriques@suse.com>
References: <20180105104723.16202-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeAEKrg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 Jan 2018 05:47:36 -0500
In-Reply-To: <20180105104723.16202-1-lhenriques@suse.com>
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
 fs/ceph/dir.c   | 11 ++++++++
 fs/ceph/file.c  |  4 ++-
 fs/ceph/quota.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/super.h |  1 +
 4 files changed, 95 insertions(+), 1 deletion(-)

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
index 1b69d8365ec2..cf1c78c4a4d2 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -63,3 +63,83 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
 
 	iput(inode);
 }
+
+enum quota_check_op {
+	QUOTA_CHECK_MAX_FILES_OP	/* check quota max_files limit */
+};
+
+/*
+ * check_quota_exceeded() will walk up the snaprealm hierarchy and, for each
+ * realm, it will execute quota check operation defined by the 'op' parameter.
+ * The snaprealm walk is interrupted if the quota check detects that the quota
+ * is exceeded or if the root inode is reached.
+ */
+static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
+				 loff_t delta)
+{
+	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_inode_info *ci;
+	struct ceph_snap_realm *realm, *next;
+	struct ceph_vino vino;
+	struct inode *in;
+	u64 max, rvalue;
+	bool is_root;
+	bool exceeded = false;
+
+	down_read(&mdsc->snap_rwsem);
+	realm = ceph_inode(inode)->i_snap_realm;
+	ceph_get_snap_realm(mdsc, realm);
+	while (realm) {
+		vino.ino = realm->ino;
+		vino.snap = CEPH_NOSNAP;
+		in = ceph_find_inode(inode->i_sb, vino);
+		if (!in) {
+			pr_warn("Failed to find inode for %llu\n", vino.ino);
+			break;
+		}
+		ci = ceph_inode(in);
+		spin_lock(&ci->i_ceph_lock);
+		if (op == QUOTA_CHECK_MAX_FILES_OP) {
+			max = ci->i_max_files;
+			rvalue = ci->i_rfiles + ci->i_rsubdirs;
+		}
+		is_root = (ci->i_vino.ino == CEPH_INO_ROOT);
+		spin_unlock(&ci->i_ceph_lock);
+		switch (op) {
+		case QUOTA_CHECK_MAX_FILES_OP:
+			exceeded = (max && (rvalue >= max));
+			break;
+		default:
+			/* Shouldn't happen */
+			pr_warn("Invalid quota check op (%d)\n", op);
+			exceeded = true; /* Just break the loop */
+		}
+		iput(in);
+
+		if (is_root || exceeded)
+			break;
+		next = realm->parent;
+		ceph_get_snap_realm(mdsc, next);
+		ceph_put_snap_realm(mdsc, realm);
+		realm = next;
+	}
+	ceph_put_snap_realm(mdsc, realm);
+	up_read(&mdsc->snap_rwsem);
+
+	return exceeded;
+}
+
+/*
+ * ceph_quota_is_max_files_exceeded - check if we can create a new file
+ * @inode:	directory where a new file is being created
+ *
+ * This functions returns true is max_files quota allows a new file to be
+ * created.  It is necessary to walk through the snaprealm hierarchy (until the
+ * FS root) to check all realms with quotas set.
+ */
+bool ceph_quota_is_max_files_exceeded(struct inode *inode)
+{
+	WARN_ON(!S_ISDIR(inode->i_mode));
+
+	return check_quota_exceeded(inode, QUOTA_CHECK_MAX_FILES_OP, 0);
+}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index f998b7f076cf..20197e29a7f0 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1026,5 +1026,6 @@ extern void ceph_fs_debugfs_cleanup(struct ceph_fs_client *client);
 extern void ceph_handle_quota(struct ceph_mds_client *mdsc,
 			      struct ceph_mds_session *session,
 			      struct ceph_msg *msg);
+extern bool ceph_quota_is_max_files_exceeded(struct inode *inode);
 
 #endif /* _FS_CEPH_SUPER_H */
