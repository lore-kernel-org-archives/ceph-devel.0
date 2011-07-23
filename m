From: Sage Weil <sage@newdream.net>
Subject: [PATCH 11/23] ceph: fix ceph_lookup_open intent usage
Date: Fri, 22 Jul 2011 17:02:50 -0700
Message-ID: <1311379382-9218-12-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44322 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016Ab1GWAFy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:54 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

We weren't properly calling lookup_instantiate_filp when setting up the
lookup intent, which could lead to file leakage on errors.  So:

 - use separate helper for the hidden snapdir translation, immediately
   following the mds request
 - use ceph_finish_lookup for the final dentry/return value dance in the
   exit path
 - lookup_instantiate_filp on success

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/dir.c   |   31 ++++++++++++++++++++-----------
 fs/ceph/file.c  |   23 +++++++++++++++--------
 fs/ceph/super.h |    2 ++
 3 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 53b441f..f39a409 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -482,18 +482,10 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int origin)
 }
 
 /*
- * Process result of a lookup/open request.
- *
- * Mainly, make sure we return the final req->r_dentry (if it already
- * existed) in place of the original VFS-provided dentry when they
- * differ.
- *
- * Gracefully handle the case where the MDS replies with -ENOENT and
- * no trace (which it may do, at its discretion, e.g., if it doesn't
- * care to issue a lease on the negative dentry).
+ * Handle lookups for the hidden .snap directory.
  */
-struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
-				  struct dentry *dentry, int err)
+int ceph_handle_snapdir(struct ceph_mds_request *req,
+			struct dentry *dentry, int err)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
 	struct inode *parent = dentry->d_parent->d_inode;
@@ -510,7 +502,23 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 		d_add(dentry, inode);
 		err = 0;
 	}
+	return err;
+}
 
+/*
+ * Figure out final result of a lookup/open request.
+ *
+ * Mainly, make sure we return the final req->r_dentry (if it already
+ * existed) in place of the original VFS-provided dentry when they
+ * differ.
+ *
+ * Gracefully handle the case where the MDS replies with -ENOENT and
+ * no trace (which it may do, at its discretion, e.g., if it doesn't
+ * care to issue a lease on the negative dentry).
+ */
+struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
+				  struct dentry *dentry, int err)
+{
 	if (err == -ENOENT) {
 		/* no trace? */
 		err = 0;
@@ -605,6 +613,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	req->r_args.getattr.mask = cpu_to_le32(CEPH_STAT_CAP_INODE);
 	req->r_locked_dir = dir;
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
+	err = ceph_handle_snapdir(req, dentry, err);
 	dentry = ceph_finish_lookup(req, dentry, err);
 	ceph_mdsc_put_request(req);  /* will dput(dentry) */
 	dout("lookup result=%p\n", dentry);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index e0115eb..f34d47d 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -223,8 +223,9 @@ struct dentry *ceph_lookup_open(struct inode *dir, struct dentry *dentry,
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
-	struct file *file = nd->intent.open.file;
+	struct file *file;
 	struct ceph_mds_request *req;
+	struct dentry *ret;
 	int err;
 	int flags = nd->intent.open.flags - 1;  /* silly vfs! */
 
@@ -245,15 +246,21 @@ struct dentry *ceph_lookup_open(struct inode *dir, struct dentry *dentry,
 	err = ceph_mdsc_do_request(mdsc,
 				   (flags & (O_CREAT|O_TRUNC)) ? dir : NULL,
 				   req);
-	dentry = ceph_finish_lookup(req, dentry, err);
-	if (!err && (flags & O_CREAT) && !req->r_reply_info.head->is_dentry)
+	err = ceph_handle_snapdir(req, dentry, err);
+	if (err)
+		goto out;
+	if ((flags & O_CREAT) && !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
-	if (!err)
-		err = ceph_init_file(req->r_dentry->d_inode, file,
-				     req->r_fmode);
+	if (err)
+		goto out;
+	file = lookup_instantiate_filp(nd, req->r_dentry, ceph_open);
+	if (IS_ERR(file))
+		err = PTR_ERR(file);
+out:
+	ret = ceph_finish_lookup(req, dentry, err);
 	ceph_mdsc_put_request(req);
-	dout("ceph_lookup_open result=%p\n", dentry);
-	return dentry;
+	dout("ceph_lookup_open result=%p\n", ret);
+	return ret;
 }
 
 int ceph_release(struct inode *inode, struct file *file)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a8a2733..c24891a 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -791,6 +791,8 @@ extern const struct dentry_operations ceph_dentry_ops, ceph_snap_dentry_ops,
 	ceph_snapdir_dentry_ops;
 
 extern int ceph_handle_notrace_create(struct inode *dir, struct dentry *dentry);
+extern int ceph_handle_snapdir(struct ceph_mds_request *req,
+			       struct dentry *dentry, int err);
 extern struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 					 struct dentry *dentry, int err);
 
-- 
1.7.0

