From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 4/5] ceph: handle 'session get evicted while there are file locks'
Date: Tue, 12 Sep 2017 10:53:50 +0800
Message-ID: <20170912025351.42147-5-zyan@redhat.com>
References: <20170912025351.42147-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbdILCyb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 11 Sep 2017 22:54:31 -0400
In-Reply-To: <20170912025351.42147-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

When session get evicted, all file locks associated with the session
get released remotely by mds. File locks tracked by kernel become
stale. In this situation, set an error flag on inode. The flag makes
further file locks return -EIO.

Another option to handle this situation is cleanup file locks tracked
kernel. I do not choose it because it is inconvenient to notify user
program about the error.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/locks.c      | 52 ++++++++++++++++++++++++++++++++++++++++------------
 fs/ceph/mds_client.c | 21 ++++++++++++++++-----
 fs/ceph/super.h      |  2 ++
 3 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 4addd18ac6f9..e240ac0903e4 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -38,7 +38,13 @@ static void ceph_fl_copy_lock(struct file_lock *dst, struct file_lock *src)
 static void ceph_fl_release_lock(struct file_lock *fl)
 {
 	struct inode *inode = file_inode(fl->fl_file);
-	atomic_dec(&ceph_inode(inode)->i_filelock_ref);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	if (atomic_dec_and_test(&ci->i_filelock_ref)) {
+		/* clear error when all locks are released */
+		spin_lock(&ci->i_ceph_lock);
+		ci->i_ceph_flags &= ~CEPH_I_ERROR_FILELOCK;
+		spin_unlock(&ci->i_ceph_lock);
+	}
 }
 
 static const struct file_lock_operations ceph_fl_lock_ops = {
@@ -207,10 +213,11 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
-	int err;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	int err = 0;
 	u16 op = CEPH_MDS_OP_SETFILELOCK;
-	u8 lock_cmd;
 	u8 wait = 0;
+	u8 lock_cmd;
 
 	if (!(fl->fl_flags & FL_POSIX))
 		return -ENOLCK;
@@ -226,7 +233,10 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	else if (IS_SETLKW(cmd))
 		wait = 1;
 
-	if (op == CEPH_MDS_OP_SETFILELOCK) {
+	spin_lock(&ci->i_ceph_lock);
+	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
+		err = -EIO;
+	} else if (op == CEPH_MDS_OP_SETFILELOCK) {
 		/*
 		 * increasing i_filelock_ref closes race window between
 		 * handling request reply and adding file_lock struct to
@@ -234,7 +244,13 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 		 * window. Caller function will decrease the counter.
 		 */
 		fl->fl_ops = &ceph_fl_lock_ops;
-		atomic_inc(&ceph_inode(inode)->i_filelock_ref);
+		atomic_inc(&ci->i_filelock_ref);
+	}
+	spin_unlock(&ci->i_ceph_lock);
+	if (err < 0) {
+		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK == fl->fl_type)
+			posix_lock_file(file, fl, NULL);
+		return err;
 	}
 
 	if (F_RDLCK == fl->fl_type)
@@ -246,10 +262,10 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, inode, lock_cmd, wait, fl);
 	if (!err) {
-		if (op != CEPH_MDS_OP_GETFILELOCK) {
+		if (op == CEPH_MDS_OP_SETFILELOCK) {
 			dout("mds locked, locking locally");
 			err = posix_lock_file(file, fl, NULL);
-			if (err && (CEPH_MDS_OP_SETFILELOCK == op)) {
+			if (err) {
 				/* undo! This should only happen if
 				 * the kernel detects local
 				 * deadlock. */
@@ -266,9 +282,10 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
-	int err;
-	u8 lock_cmd;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	int err = 0;
 	u8 wait = 0;
+	u8 lock_cmd;
 
 	if (!(fl->fl_flags & FL_FLOCK))
 		return -ENOLCK;
@@ -278,9 +295,20 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	dout("ceph_flock, fl_file: %p", fl->fl_file);
 
-	/* see comment in ceph_lock */
-	fl->fl_ops = &ceph_fl_lock_ops;
-	atomic_inc(&ceph_inode(inode)->i_filelock_ref);
+	spin_lock(&ci->i_ceph_lock);
+	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
+		err = -EIO;
+	} else {
+		/* see comment in ceph_lock */
+		fl->fl_ops = &ceph_fl_lock_ops;
+		atomic_inc(&ci->i_filelock_ref);
+	}
+	spin_unlock(&ci->i_ceph_lock);
+	if (err < 0) {
+		if (F_UNLCK == fl->fl_type)
+			locks_lock_file_wait(file, fl);
+		return err;
+	}
 
 	if (IS_SETLKW(cmd))
 		wait = 1;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 817ea438aa19..26893cc1fbee 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1214,6 +1214,13 @@ static int remove_session_caps_cb(struct inode *inode, struct ceph_cap *cap,
 		}
 		spin_unlock(&mdsc->cap_dirty_lock);
 
+		if (atomic_read(&ci->i_filelock_ref) > 0) {
+			/* make further file lock syscall return -EIO */
+			ci->i_ceph_flags |= CEPH_I_ERROR_FILELOCK;
+			pr_warn_ratelimited(" dropping file locks for %p %lld\n",
+					    inode, ceph_ino(inode));
+		}
+
 		if (!ci->i_dirty_caps && ci->i_prealloc_cap_flush) {
 			list_add(&ci->i_prealloc_cap_flush->i_list, &to_remove);
 			ci->i_prealloc_cap_flush = NULL;
@@ -2828,7 +2835,7 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
 		struct ceph_mds_cap_reconnect v2;
 		struct ceph_mds_cap_reconnect_v1 v1;
 	} rec;
-	struct ceph_inode_info *ci;
+	struct ceph_inode_info *ci = cap->ci;
 	struct ceph_reconnect_state *recon_state = arg;
 	struct ceph_pagelist *pagelist = recon_state->pagelist;
 	char *path;
@@ -2837,8 +2844,6 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
 	u64 snap_follows;
 	struct dentry *dentry;
 
-	ci = cap->ci;
-
 	dout(" adding %p ino %llx.%llx cap %p %lld %s\n",
 	     inode, ceph_vinop(inode), cap, cap->cap_id,
 	     ceph_cap_string(cap->issued));
@@ -2871,7 +2876,8 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
 		rec.v2.issued = cpu_to_le32(cap->issued);
 		rec.v2.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
 		rec.v2.pathbase = cpu_to_le64(pathbase);
-		rec.v2.flock_len = 0;
+		rec.v2.flock_len =
+			(ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1;
 	} else {
 		rec.v1.cap_id = cpu_to_le64(cap->cap_id);
 		rec.v1.wanted = cpu_to_le32(__ceph_caps_wanted(ci));
@@ -2900,7 +2906,12 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
 		u8 struct_v = 0;
 
 encode_again:
-		ceph_count_locks(inode, &num_fcntl_locks, &num_flock_locks);
+		if (rec.v2.flock_len) {
+			ceph_count_locks(inode, &num_fcntl_locks, &num_flock_locks);
+		} else {
+			num_fcntl_locks = 0;
+			num_flock_locks = 0;
+		}
 		if (num_fcntl_locks + num_flock_locks > 0) {
 			flocks = kmalloc((num_fcntl_locks + num_flock_locks) *
 					 sizeof(struct ceph_filelock), GFP_NOFS);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 88cbc0981c23..6fe4a2c5fd24 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -487,6 +487,8 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 #define CEPH_I_KICK_FLUSH	(1 << 9)  /* kick flushing caps */
 #define CEPH_I_FLUSH_SNAPS	(1 << 10) /* need flush snapss */
 #define CEPH_I_ERROR_WRITE	(1 << 11) /* have seen write errors */
+#define CEPH_I_ERROR_FILELOCK	(1 << 12) /* have seen file lock errors */
+
 
 /*
  * We set the ERROR_WRITE bit when we start seeing write errors on an inode
-- 
2.13.5

