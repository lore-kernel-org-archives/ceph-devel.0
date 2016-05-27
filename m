From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/5] xfs: Propagate dentry down to inode_change_ok()
Date: Fri, 27 May 2016 18:12:33 +0200
Message-ID: <20160527161233.GE21780@quack2.suse.cz>
References: <1464279600-13009-1-git-send-email-jack@suse.cz>
 <1464279600-13009-2-git-send-email-jack@suse.cz>
 <20160526215304.GO21200@dastard>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160526215304.GO21200@dastard>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, xfs@oss.sgi.com
List-Id: ceph-devel.vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri 27-05-16 07:53:04, Dave Chinner wrote:
> On Thu, May 26, 2016 at 06:19:56PM +0200, Jan Kara wrote:
> > To avoid clearing of capabilities or security related extended
> > attributes too early, inode_change_ok() will need to take dentry instead
> > of inode. Propagate dentry down to functions calling inode_change_ok().
> > This is rather straightforward except for xfs_set_mode() function which
> > does not have dentry easily available. Luckily that function does not
> > call inode_change_ok() anyway so we just have to do a little dance with
> > function prototypes.
> 
> The idea behind the change is good, but I think the little dance
> could be improved as it makes the layering of the code seem weirdly
> unbalanced to me. e.g.
> 
> xfs_vn_setattr()
>   xfs_vn_setattr_size()		<<<< inode_change_ok() here
> 
> xfs_vn_setattr()
>   xfs_vn_setattr_nonsize()	<<<< inode_change_ok() here
>     xfs_setattr_nonsize()
> 
> xfs_vn_setattr()
>   xfs_vn_setattr_size()
>     xfs_vn_setattr_nonsize()	<<<< inode_change_ok() here
>       xfs_setattr_nonsize()
> 
> And to be more confusing, the externally callable functions for the
> rest of the XFS code are now xfs_vn_setattr_size() and
> xfs_setattr_nonsize() which now have different calling context
> limitations.
> 
> I think adding a little symmetric make sense. i.e:
> 
> xfs_vn_change_ok(dentry, iattr)
> {
> +	if (mp->m_flags & XFS_MOUNT_RDONLY)
> +		return -EROFS;
> +
> +	if (XFS_FORCED_SHUTDOWN(mp))
> +		return -EIO;
> +
> +	error = inode_change_ok(inode, iattr);
> +	if (error)
> +		return error;
> +
> }
> 
> xfs_vn_setattr_size(d, i)
> {
> 	xfs_vn_change_ok(d, i)
> 	xfs_setattr_size(ip, i)
> }
> 
> xfs_vn_setattr_nonsize(d, i)
> {
> 	xfs_vn_change_ok(d, i)
> 	xfs_setattr_nonsize(ip, i)
> }
> 
> xfs_vn_setattr(d, i)
> {
> 	xfs_vn_change_ok(d, i)
> 	<rest of xfs_vn_setattr unchanged>
> }
> 
> And remove the inode_change_ok() code from xfs_setattr_size and
> xfs_setattr_nonsize() completely.  You've already done this with
> xfs_vn_setattr_nonsize() - it just needs to be made symmetric to
> keep a clean layering between VFS interfaces and internal XFS
> interfaces...

Ok, something like attached patch?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--6TrnltStXW4iwmi0
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-xfs-Propagate-dentry-down-to-inode_change_ok.patch"

From 163d931793395f4d19c9f55cae1168d3f7cc26ba Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 26 May 2016 14:46:43 +0200
Subject: [PATCH] xfs: Propagate dentry down to inode_change_ok()

To avoid clearing of capabilities or security related extended
attributes too early, inode_change_ok() will need to take dentry instead
of inode. Propagate dentry down to functions calling inode_change_ok().
This is rather straightforward except for xfs_set_mode() function which
does not have dentry easily available. Luckily that function does not
call inode_change_ok() anyway so we just have to do a little dance with
function prototypes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_file.c  |  2 +-
 fs/xfs/xfs_inode.c |  2 +-
 fs/xfs/xfs_ioctl.c |  2 +-
 fs/xfs/xfs_iops.c  | 94 ++++++++++++++++++++++++++++++++++++------------------
 fs/xfs/xfs_iops.h  |  3 +-
 5 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 85ce3032f815..b562cc5faae1 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1024,7 +1024,7 @@ xfs_file_fallocate(
 
 		iattr.ia_valid = ATTR_SIZE;
 		iattr.ia_size = new_size;
-		error = xfs_setattr_size(ip, &iattr);
+		error = xfs_vn_setattr_size(file_dentry(file), &iattr);
 		if (error)
 			goto out_unlock;
 	}
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 96f606deee31..6adfc757d8c6 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1724,7 +1724,7 @@ xfs_inactive_truncate(
 	/*
 	 * Log the inode size first to prevent stale data exposure in the event
 	 * of a system crash before the truncate completes. See the related
-	 * comment in xfs_setattr_size() for details.
+	 * comment in xfs_vn_setattr_size() for details.
 	 */
 	ip->i_d.di_size = 0;
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index bcb6c19ce3ea..1d441bfacf59 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -731,7 +731,7 @@ xfs_ioc_space(
 		iattr.ia_valid = ATTR_SIZE;
 		iattr.ia_size = bf->l_start;
 
-		error = xfs_setattr_size(ip, &iattr);
+		error = xfs_vn_setattr_size(file_dentry(filp), &iattr);
 		break;
 	default:
 		ASSERT(0);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index fb7dc61f4a29..9e40c1c5dfe6 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -527,6 +527,30 @@ xfs_setattr_time(
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
@@ -543,21 +567,6 @@ xfs_setattr_nonsize(
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
@@ -731,8 +740,27 @@ out_trans_cancel:
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
@@ -747,18 +775,6 @@ xfs_setattr_size(
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
@@ -931,16 +947,32 @@ out_trans_cancel:
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
@@ -948,11 +980,11 @@ xfs_vn_setattr(
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


--6TrnltStXW4iwmi0--
