From: Sage Weil <sage@newdream.net>
Subject: [PATCH 22/23] ceph: explicitly reference rename old_dentry parent dir in request
Date: Fri, 22 Jul 2011 17:03:01 -0700
Message-ID: <1311379382-9218-23-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44322 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab1GWAF4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:56 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

We carry a pin on the parent directory for the rename source and dest
dentries.  For the source it's r_locked_dir; we need to explicitly
reference the old_dentry parent as well, since the dentry's d_parent may
change between when the request was created and pinned and when it is
freed.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/debugfs.c    |    2 +-
 fs/ceph/dir.c        |    2 ++
 fs/ceph/mds_client.c |   23 +++++++++++++----------
 fs/ceph/mds_client.h |    1 +
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 0dba691..fb962ef 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -102,7 +102,7 @@ static int mdsc_show(struct seq_file *s, void *p)
 				path = NULL;
 			spin_lock(&req->r_old_dentry->d_lock);
 			seq_printf(s, " #%llx/%.*s (%s)",
-			   ceph_ino(req->r_old_dentry->d_parent->d_inode),
+			   ceph_ino(req->r_old_dentry_dir),
 				   req->r_old_dentry->d_name.len,
 				   req->r_old_dentry->d_name.name,
 				   path ? path : "");
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 1d6aef4..32359cc 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -809,6 +809,7 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
 	req->r_old_dentry = dget(old_dentry); /* or inode? hrm. */
+	req->r_old_dentry_dir = ceph_get_dentry_parent_inode(old_dentry);
 	req->r_locked_dir = dir;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
@@ -907,6 +908,7 @@ static int ceph_rename(struct inode *old_dir, struct dentry *old_dentry,
 	req->r_dentry = dget(new_dentry);
 	req->r_num_caps = 2;
 	req->r_old_dentry = dget(old_dentry);
+	req->r_old_dentry_dir = ceph_get_dentry_parent_inode(old_dentry);
 	req->r_locked_dir = new_dir;
 	req->r_old_dentry_drop = CEPH_CAP_FILE_SHARED;
 	req->r_old_dentry_unless = CEPH_CAP_FILE_EXCL;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 8a09cd5..66a8939 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -483,22 +483,26 @@ void ceph_mdsc_release_request(struct kref *kref)
 		destroy_reply_info(&req->r_reply_info);
 	}
 	if (req->r_inode) {
-		ceph_put_cap_refs(ceph_inode(req->r_inode),
-				  CEPH_CAP_PIN);
+		ceph_put_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
 		iput(req->r_inode);
 	}
 	if (req->r_locked_dir)
-		ceph_put_cap_refs(ceph_inode(req->r_locked_dir),
-				  CEPH_CAP_PIN);
+		ceph_put_cap_refs(ceph_inode(req->r_locked_dir), CEPH_CAP_PIN);
 	if (req->r_target_inode)
 		iput(req->r_target_inode);
 	if (req->r_dentry)
 		dput(req->r_dentry);
 	if (req->r_old_dentry) {
-		ceph_put_cap_refs(
-			ceph_inode(req->r_old_dentry->d_parent->d_inode),
-			CEPH_CAP_PIN);
+		/*
+		 * track (and drop pins for) r_old_dentry_dir
+		 * separately, since r_old_dentry's d_parent may have
+		 * changed between the dir mutex being dropped and
+		 * this request being freed.
+		 */
+		ceph_put_cap_refs(ceph_inode(req->r_old_dentry_dir),
+				  CEPH_CAP_PIN);
 		dput(req->r_old_dentry);
+		iput(req->r_old_dentry_dir);
 	}
 	kfree(req->r_path1);
 	kfree(req->r_path2);
@@ -1931,9 +1935,8 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
 	if (req->r_locked_dir)
 		ceph_get_cap_refs(ceph_inode(req->r_locked_dir), CEPH_CAP_PIN);
 	if (req->r_old_dentry)
-		ceph_get_cap_refs(
-			ceph_inode(req->r_old_dentry->d_parent->d_inode),
-			CEPH_CAP_PIN);
+		ceph_get_cap_refs(ceph_inode(req->r_old_dentry_dir),
+				  CEPH_CAP_PIN);
 
 	/* issue */
 	mutex_lock(&mdsc->mutex);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 8a40f06..4bb2399 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -171,6 +171,7 @@ struct ceph_mds_request {
 	struct inode *r_inode;              /* arg1 */
 	struct dentry *r_dentry;            /* arg1 */
 	struct dentry *r_old_dentry;        /* arg2: rename from or link from */
+	struct inode *r_old_dentry_dir;     /* arg2: old dentry's parent dir */
 	char *r_path1, *r_path2;
 	struct ceph_vino r_ino1, r_ino2;
 
-- 
1.7.0

