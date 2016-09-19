From: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/5] xfs: Propagate dentry down to inode_change_ok()
Date: Mon, 19 Sep 2016 17:30:55 +0200
Message-ID: <1474299059-14806-2-git-send-email-jack@suse.cz>
References: <1474299059-14806-1-git-send-email-jack@suse.cz>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1474299059-14806-1-git-send-email-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, xfs@oss.sgi.org, Dave Chinner <david@fromorbit.com>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
List-Id: ceph-devel.vger.kernel.org

To avoid clearing of capabilities or security related extended
attributes too early, inode_change_ok() will need to take dentry instead
of inode. Propagate dentry down to functions calling inode_change_ok().
This is rather straightforward except for xfs_set_mode() function which
does not have dentry easily available. Luckily that function does not
call inode_change_ok() anyway so we just have to do a little dance with
function prototypes.

Acked-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_file.c  |  2 +-
 fs/xfs/xfs_inode.c |  2 +-
 fs/xfs/xfs_ioctl.c |  2 +-
 fs/xfs/xfs_iops.c  | 94 ++++++++++++++++++++++++++++++++++++------------------
 fs/xfs/xfs_iops.h  |  3 +-
 5 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e612a0233710..fcb81ede2cb0 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -984,7 +984,7 @@ xfs_file_fallocate(
 
 		iattr.ia_valid = ATTR_SIZE;
 		iattr.ia_size = new_size;
-		error = xfs_setattr_size(ip, &iattr);
+		error = xfs_vn_setattr_size(file_dentry(file), &iattr);
 		if (error)
 			goto out_unlock;
 	}
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index e08eaea6327b..df22e1254c98 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1710,7 +1710,7 @@ xfs_inactive_truncate(
 	/*
 	 * Log the inode size first to prevent stale data exposure in the event
 	 * of a system crash before the truncate completes. See the related
-	 * comment in xfs_setattr_size() for details.
+	 * comment in xfs_vn_setattr_size() for details.
 	 */
 	ip->i_d.di_size = 0;
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 96a70fd1f5d6..0d9021f0551e 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -720,7 +720,7 @@ xfs_ioc_space(
 		iattr.ia_valid = ATTR_SIZE;
 		iattr.ia_size = bf->l_start;
 
-		error = xfs_setattr_size(ip, &iattr);
+		error = xfs_vn_setattr_size(file_dentry(filp), &iattr);
 		break;
 	default:
 		ASSERT(0);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index b24c3102fa93..ffde761fbeff 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -542,6 +542,30 @@ xfs_setattr_time(
 		inode->i_mtime = iattr->ia_mtime;
 }
 
+static int
+xfs_vn_change_ok(
+	struct dentry	*dentry,
+	struct iattr	*iattr)
+{
+	struct inode		*inode = d_inode(dentry);
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (mp->m_flags & XFS_MOUNT_RDONLY)
+		return -EROFS;
+
+	if (XFS_FORCED_SHUTDOWN(mp))
+		return -EIO;
+
+	return inode_change_ok(inode, iattr);
+}
+
+/*
+ * Set non-size attributes of an inode.
+ *
+ * Caution: The caller of this function is responsible for calling
+ * inode_change_ok() or otherwise verifying the change is fine.
+ */
 int
 xfs_setattr_nonsize(
 	struct xfs_inode	*ip,
@@ -558,21 +582,6 @@ xfs_setattr_nonsize(
 	struct xfs_dquot	*udqp = NULL, *gdqp = NULL;
 	struct xfs_dquot	*olddquot1 = NULL, *olddquot2 = NULL;
 
-	trace_xfs_setattr(ip);
-
-	/* If acls are being inherited, we already have this checked */
-	if (!(flags & XFS_ATTR_NOACL)) {
-		if (mp->m_flags & XFS_MOUNT_RDONLY)
-			return -EROFS;
-
-		if (XFS_FORCED_SHUTDOWN(mp))
-			return -EIO;
-
-		error = inode_change_ok(inode, iattr);
-		if (error)
-			return error;
-	}
-
 	ASSERT((mask & ATTR_SIZE) == 0);
 
 	/*
@@ -743,8 +752,27 @@ out_dqrele:
 	return error;
 }
 
+int
+xfs_vn_setattr_nonsize(
+	struct dentry		*dentry,
+	struct iattr		*iattr)
+{
+	struct xfs_inode	*ip = XFS_I(d_inode(dentry));
+	int error;
+
+	trace_xfs_setattr(ip);
+
+	error = xfs_vn_change_ok(dentry, iattr);
+	if (error)
+		return error;
+	return xfs_setattr_nonsize(ip, iattr, 0);
+}
+
 /*
  * Truncate file.  Must have write permission and not be a directory.
+ *
+ * Caution: The caller of this function is responsible for calling
+ * inode_change_ok() or otherwise verifying the change is fine.
  */
 int
 xfs_setattr_size(
@@ -759,18 +787,6 @@ xfs_setattr_size(
 	uint			lock_flags = 0;
 	bool			did_zeroing = false;
 
-	trace_xfs_setattr(ip);
-
-	if (mp->m_flags & XFS_MOUNT_RDONLY)
-		return -EROFS;
-
-	if (XFS_FORCED_SHUTDOWN(mp))
-		return -EIO;
-
-	error = inode_change_ok(inode, iattr);
-	if (error)
-		return error;
-
 	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
 	ASSERT(xfs_isilocked(ip, XFS_MMAPLOCK_EXCL));
 	ASSERT(S_ISREG(inode->i_mode));
@@ -942,16 +958,32 @@ out_trans_cancel:
 	goto out_unlock;
 }
 
+int
+xfs_vn_setattr_size(
+	struct dentry		*dentry,
+	struct iattr		*iattr)
+{
+	struct xfs_inode	*ip = XFS_I(d_inode(dentry));
+	int error;
+
+	trace_xfs_setattr(ip);
+
+	error = xfs_vn_change_ok(dentry, iattr);
+	if (error)
+		return error;
+	return xfs_setattr_size(ip, iattr);
+}
+
 STATIC int
 xfs_vn_setattr(
 	struct dentry		*dentry,
 	struct iattr		*iattr)
 {
-	struct xfs_inode	*ip = XFS_I(d_inode(dentry));
 	int			error;
 
 	if (iattr->ia_valid & ATTR_SIZE) {
-		uint		iolock = XFS_IOLOCK_EXCL;
+		struct xfs_inode	*ip = XFS_I(d_inode(dentry));
+		uint			iolock = XFS_IOLOCK_EXCL;
 
 		xfs_ilock(ip, iolock);
 		error = xfs_break_layouts(d_inode(dentry), &iolock, true);
@@ -959,11 +991,11 @@ xfs_vn_setattr(
 			xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
 			iolock |= XFS_MMAPLOCK_EXCL;
 
-			error = xfs_setattr_size(ip, iattr);
+			error = xfs_vn_setattr_size(dentry, iattr);
 		}
 		xfs_iunlock(ip, iolock);
 	} else {
-		error = xfs_setattr_nonsize(ip, iattr, 0);
+		error = xfs_vn_setattr_nonsize(dentry, iattr);
 	}
 
 	return error;
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index a0f84abb0d09..0259a383721a 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -33,6 +33,7 @@ extern ssize_t xfs_vn_listxattr(struct dentry *, char *data, size_t size);
 extern void xfs_setattr_time(struct xfs_inode *ip, struct iattr *iattr);
 extern int xfs_setattr_nonsize(struct xfs_inode *ip, struct iattr *vap,
 			       int flags);
-extern int xfs_setattr_size(struct xfs_inode *ip, struct iattr *vap);
+extern int xfs_vn_setattr_nonsize(struct dentry *dentry, struct iattr *vap);
+extern int xfs_vn_setattr_size(struct dentry *dentry, struct iattr *vap);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.6.6

