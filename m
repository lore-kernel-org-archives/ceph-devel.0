From: Jan Kara <jack@suse.cz>
Subject: [PATCH 3/5] fuse: Propagate dentry down to inode_change_ok()
Date: Thu, 26 May 2016 18:19:58 +0200
Message-ID: <1464279600-13009-4-git-send-email-jack@suse.cz>
References: <1464279600-13009-1-git-send-email-jack@suse.cz>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54488 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522AbcEZQUK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 May 2016 12:20:10 -0400
In-Reply-To: <1464279600-13009-1-git-send-email-jack@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, xfs@oss.sgi.com, ceph-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>

To avoid clearing of capabilities or security related extended
attributes too early, inode_change_ok() will need to take dentry instead
of inode. Propagate it down to fuse_do_setattr().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fuse/dir.c    | 7 ++++---
 fs/fuse/file.c   | 2 +-
 fs/fuse/fuse_i.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b9419058108f..4a613d1e9e75 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1586,9 +1586,10 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
  * vmtruncate() doesn't allow for this case, so do the rlimit checking
  * and the actual truncation by hand.
  */
-int fuse_do_setattr(struct inode *inode, struct iattr *attr,
+int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		    struct file *file)
 {
+	struct inode *inode = d_inode(dentry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	FUSE_ARGS(args);
@@ -1702,9 +1703,9 @@ static int fuse_setattr(struct dentry *entry, struct iattr *attr)
 		return -EACCES;
 
 	if (attr->ia_valid & ATTR_FILE)
-		return fuse_do_setattr(inode, attr, attr->ia_file);
+		return fuse_do_setattr(entry, attr, attr->ia_file);
 	else
-		return fuse_do_setattr(inode, attr, NULL);
+		return fuse_do_setattr(entry, attr, NULL);
 }
 
 static int fuse_getattr(struct vfsmount *mnt, struct dentry *entry,
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9154f8679024..46d65f1a79d2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2828,7 +2828,7 @@ static void fuse_do_truncate(struct file *file)
 	attr.ia_file = file;
 	attr.ia_valid |= ATTR_FILE;
 
-	fuse_do_setattr(inode, &attr, file);
+	fuse_do_setattr(file_dentry(file), &attr, file);
 }
 
 static inline loff_t fuse_round_up(loff_t off)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index eddbe02c4028..59a26446762b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -951,7 +951,7 @@ bool fuse_write_update_size(struct inode *inode, loff_t pos);
 int fuse_flush_times(struct inode *inode, struct fuse_file *ff);
 int fuse_write_inode(struct inode *inode, struct writeback_control *wbc);
 
-int fuse_do_setattr(struct inode *inode, struct iattr *attr,
+int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		    struct file *file);
 
 void fuse_set_initialized(struct fuse_conn *fc);
-- 
2.6.6

