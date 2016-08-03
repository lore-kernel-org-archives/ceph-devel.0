From: Jan Kara <jack@suse.cz>
Subject: [PATCH 3/5] fuse: Propagate dentry down to inode_change_ok()
Date: Wed,  3 Aug 2016 13:28:07 +0200
Message-ID: <1470223689-17783-4-git-send-email-jack@suse.cz>
References: <1470223689-17783-1-git-send-email-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xfs-bounces@oss.sgi.com>
In-Reply-To: <1470223689-17783-1-git-send-email-jack@suse.cz>
List-Unsubscribe: <http://oss.sgi.com/mailman/options/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=unsubscribe>
List-Archive: <http://oss.sgi.com/pipermail/xfs>
List-Post: <mailto:xfs@oss.sgi.com>
List-Help: <mailto:xfs-request@oss.sgi.com?subject=help>
List-Subscribe: <http://oss.sgi.com/mailman/listinfo/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=subscribe>
Errors-To: xfs-bounces@oss.sgi.com
Sender: xfs-bounces@oss.sgi.com
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, xfs@oss.sgi.com, "Yan, Zheng" <zyan@redhat.com>, linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

To avoid clearing of capabilities or security related extended
attributes too early, inode_change_ok() will need to take dentry instead
of inode. Propagate it down to fuse_do_setattr().

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fuse/dir.c    | 7 ++++---
 fs/fuse/file.c   | 2 +-
 fs/fuse/fuse_i.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5f1627725791..f29ce9cb30e6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1591,9 +1591,10 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
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
@@ -1707,9 +1708,9 @@ static int fuse_setattr(struct dentry *entry, struct iattr *attr)
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
index f394aff59c36..4b9201b7c80b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2841,7 +2841,7 @@ static void fuse_do_truncate(struct file *file)
 	attr.ia_file = file;
 	attr.ia_valid |= ATTR_FILE;
 
-	fuse_do_setattr(inode, &attr, file);
+	fuse_do_setattr(file_dentry(file), &attr, file);
 }
 
 static inline loff_t fuse_round_up(loff_t off)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5db5d24f91a5..c6a3bef34fd3 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -958,7 +958,7 @@ bool fuse_write_update_size(struct inode *inode, loff_t pos);
 int fuse_flush_times(struct inode *inode, struct fuse_file *ff);
 int fuse_write_inode(struct inode *inode, struct writeback_control *wbc);
 
-int fuse_do_setattr(struct inode *inode, struct iattr *attr,
+int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		    struct file *file);
 
 void fuse_set_initialized(struct fuse_conn *fc);
-- 
2.6.6

_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs
