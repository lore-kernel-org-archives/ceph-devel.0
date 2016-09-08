From: Jeff Layton <jlayton@samba.org>
Subject: [samba PATCH] vfs:ceph: convert to using ceph_statx structures and functions, when available
Date: Thu,  8 Sep 2016 10:29:44 -0400
Message-ID: <1473344984-22564-1-git-send-email-jlayton@samba.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.7.4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:58450 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965157AbcIHOaH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Sep 2016 10:30:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: samba-technical@lists.samba.org
Cc: ceph-devel@vger.kernel.org, ira@wakeful.net

This is a multi-part message in MIME format.
--------------2.7.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Add a configure test for the ceph_statx function, and use that to
determine whether to compile in new functions that use it and its
variants, or whether to use a the older code that fetches birthtimes
from an xattr.

For cephwrap_lstat, we can use ceph_statx with the AT_SYMLINK_NOFOLLOW
flag to get the right lookup semantics.

For setting the times via cephwrap_ntimes, We can just use ceph_setattrx
and pass them all in at the same time.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 source3/modules/vfs_ceph.c | 216 ++++++++++++++++++++++++++++++++++++++-------
 source3/wscript            |   2 +
 2 files changed, 185 insertions(+), 33 deletions(-)


--------------2.7.4
Content-Type: text/x-patch; name="0001-vfs-ceph-convert-to-using-ceph_statx-structures-and-.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-vfs-ceph-convert-to-using-ceph_statx-structures-and-.patch"

diff --git a/source3/modules/vfs_ceph.c b/source3/modules/vfs_ceph.c
index 59e9b9cf9b3e..338642e311b9 100644
--- a/source3/modules/vfs_ceph.c
+++ b/source3/modules/vfs_ceph.c
@@ -535,6 +535,155 @@ static int cephwrap_fsync(struct vfs_handle_struct *handle, files_struct *fsp)
 	WRAP_RETURN(result);
 }
 
+#ifdef HAVE_CEPH_STATX
+#define	MINORBITS	(20)
+#define	MINORMASK	((1U << MINORBITS) - 1)
+#define	MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
+#define	MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
+#define	MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
+
+static void init_stat_ex_from_ceph_statx(struct stat_ex *dst, const struct ceph_statx *stx)
+{
+	dst->st_ex_dev = MKDEV(stx->stx_dev_major, stx->stx_dev_minor);
+	dst->st_ex_rdev = MKDEV(stx->stx_rdev_major, stx->stx_rdev_minor);
+	dst->st_ex_ino = stx->stx_ino;
+	dst->st_ex_mode = stx->stx_mode;
+	dst->st_ex_uid = stx->stx_uid;
+	dst->st_ex_gid = stx->stx_gid;
+	dst->st_ex_size = stx->stx_size;
+	dst->st_ex_nlink = stx->stx_nlink;
+	dst->st_ex_atime.tv_sec = stx->stx_atime;
+	dst->st_ex_atime.tv_nsec = stx->stx_atime_ns;
+	dst->st_ex_btime.tv_sec = stx->stx_btime;
+	dst->st_ex_btime.tv_nsec = stx->stx_btime_ns;
+	dst->st_ex_ctime.tv_sec = stx->stx_ctime;
+	dst->st_ex_ctime.tv_nsec = stx->stx_ctime_ns;
+	dst->st_ex_mtime.tv_sec = stx->stx_mtime;
+	dst->st_ex_mtime.tv_nsec = stx->stx_mtime_ns;
+	dst->st_ex_calculated_birthtime = false;
+	dst->st_ex_blksize = stx->stx_blksize;
+	dst->st_ex_blocks = stx->stx_blocks;
+}
+
+static int cephwrap_stat(struct vfs_handle_struct *handle,
+			struct smb_filename *smb_fname)
+{
+	int result = -1;
+	struct ceph_statx stx;
+
+	DEBUG(10, ("[CEPH] stat(%p, %s)\n", handle, smb_fname_str_dbg(smb_fname)));
+
+	if (smb_fname->stream_name) {
+		errno = ENOENT;
+		return result;
+	}
+
+	result = ceph_statx(handle->data, smb_fname->base_name, &stx,
+			CEPH_STATX_BASIC_STATS|CEPH_STATX_BTIME, 0);
+	DEBUG(10, ("[CEPH] statx(...) = %d\n", result));
+	if (result < 0) {
+		WRAP_RETURN(result);
+	} else {
+		DEBUG(10, ("[CEPH]\tstx = {dev = %llx/%llx, ino = %llu, mode = 0x%x, nlink = %llu, "
+			   "uid = %d, gid = %d, rdev = %llx/%llx, size = %llu, blksize = %llu, "
+			   "blocks = %llu, atime = %llu, mtime = %llu, ctime = %llu, btime = %llu}\n",
+			   llu(stx.stx_dev_major), llu(stx.stx_dev_minor), llu(stx.stx_ino), stx.stx_mode,
+			   llu(stx.stx_nlink), stx.stx_uid, stx.stx_gid, llu(stx.stx_rdev_major),
+			   llu(stx.stx_rdev_minor), llu(stx.stx_size), llu(stx.stx_blksize),
+			   llu(stx.stx_blocks), llu(stx.stx_atime), llu(stx.stx_mtime), llu(stx.stx_ctime),
+			   llu(stx.stx_btime)));
+	}
+	init_stat_ex_from_ceph_statx(&smb_fname->st, &stx);
+	DEBUG(10, ("[CEPH] mode = 0x%x\n", smb_fname->st.st_ex_mode));
+	return result;
+}
+
+static int cephwrap_fstat(struct vfs_handle_struct *handle, files_struct *fsp, SMB_STRUCT_STAT *sbuf)
+{
+	int result = -1;
+	struct ceph_statx stx;
+
+	DEBUG(10, ("[CEPH] fstat(%p, %d)\n", handle, fsp->fh->fd));
+	result = ceph_fstatx(handle->data, fsp->fh->fd, &stx,
+			     CEPH_STATX_BASIC_STATS|CEPH_STATX_BTIME, 0);
+	DEBUG(10, ("[CEPH] fstat(...) = %d\n", result));
+	if (result < 0) {
+		WRAP_RETURN(result);
+	} else {
+		DEBUG(10, ("[CEPH]\tstx = {dev = %llx/%llx, ino = %llu, mode = 0x%x, nlink = %llu, "
+			   "uid = %d, gid = %d, rdev = %llx/%llx, size = %llu, blksize = %llu, "
+			   "blocks = %llu, atime = %llu, mtime = %llu, ctime = %llu, btime = %llu}\n",
+			   llu(stx.stx_dev_major), llu(stx.stx_dev_minor), llu(stx.stx_ino), stx.stx_mode,
+			   llu(stx.stx_nlink), stx.stx_uid, stx.stx_gid, llu(stx.stx_rdev_major),
+			   llu(stx.stx_rdev_minor), llu(stx.stx_size), llu(stx.stx_blksize),
+			   llu(stx.stx_blocks), llu(stx.stx_atime), llu(stx.stx_mtime), llu(stx.stx_ctime),
+			   llu(stx.stx_btime)));
+	}
+	init_stat_ex_from_ceph_statx(sbuf, &stx);
+	DEBUG(10, ("[CEPH] mode = 0x%x\n", sbuf->st_ex_mode));
+	return result;
+}
+
+static int cephwrap_lstat(struct vfs_handle_struct *handle,
+			 struct smb_filename *smb_fname)
+{
+	int result = -1;
+	struct ceph_statx stx;
+
+	DEBUG(10, ("[CEPH] lstat(%p, %s)\n", handle, smb_fname_str_dbg(smb_fname)));
+
+	if (smb_fname->stream_name) {
+		errno = ENOENT;
+		return result;
+	}
+
+	result = ceph_statx(handle->data, smb_fname->base_name, &stx,
+				CEPH_STATX_BASIC_STATS|CEPH_STATX_BTIME,
+				AT_SYMLINK_NOFOLLOW);
+	DEBUG(10, ("[CEPH] lstat(...) = %d\n", result));
+	if (result < 0) {
+		WRAP_RETURN(result);
+	}
+	init_stat_ex_from_ceph_statx(&smb_fname->st, &stx);
+	return result;
+}
+
+static int cephwrap_ntimes(struct vfs_handle_struct *handle,
+			 const struct smb_filename *smb_fname,
+			 struct smb_file_time *ft)
+{
+	struct ceph_statx stx = { 0 };
+	int result;
+	int mask = 0;
+
+	if (!null_timespec(ft->atime)) {
+		stx.stx_atime = ft->atime.tv_sec;
+		stx.stx_atime_ns = ft->atime.tv_nsec;
+		mask |= CEPH_SETATTR_ATIME;
+	}
+	if (!null_timespec(ft->mtime)) {
+		stx.stx_mtime = ft->mtime.tv_sec;
+		stx.stx_mtime_ns = ft->mtime.tv_nsec;
+		mask |= CEPH_SETATTR_MTIME;
+	}
+	if (!null_timespec(ft->create_time)) {
+		stx.stx_btime = ft->create_time.tv_sec;
+		stx.stx_btime_ns = ft->create_time.tv_nsec;
+		mask |= CEPH_SETATTR_BTIME;
+	}
+
+	if (!mask)
+		return 0;
+
+	result = ceph_setattrx(handle->data, smb_fname->base_name, &stx, mask, 0);
+	DEBUG(10, ("[CEPH] ntimes(%p, %s, {%ld, %ld, %ld, %ld}) = %d\n", handle, smb_fname_str_dbg(smb_fname),
+				ft->mtime.tv_sec, ft->atime.tv_sec, ft->ctime.tv_sec,
+				ft->create_time.tv_sec, result));
+	return result;
+}
+
+#else /* HAVE_CEPH_STATX */
+
 static int cephwrap_stat(struct vfs_handle_struct *handle,
 			struct smb_filename *smb_fname)
 {
@@ -617,6 +766,40 @@ static int cephwrap_lstat(struct vfs_handle_struct *handle,
 	return result;
 }
 
+static int cephwrap_ntimes(struct vfs_handle_struct *handle,
+			 const struct smb_filename *smb_fname,
+			 struct smb_file_time *ft)
+{
+	struct utimbuf buf;
+	int result;
+
+	if (null_timespec(ft->atime)) {
+		buf.actime = smb_fname->st.st_ex_atime.tv_sec;
+	} else {
+		buf.actime = ft->atime.tv_sec;
+	}
+	if (null_timespec(ft->mtime)) {
+		buf.modtime = smb_fname->st.st_ex_mtime.tv_sec;
+	} else {
+		buf.modtime = ft->mtime.tv_sec;
+	}
+	if (!null_timespec(ft->create_time)) {
+		set_create_timespec_ea(handle->conn, smb_fname,
+				       ft->create_time);
+	}
+	if (buf.actime == smb_fname->st.st_ex_atime.tv_sec &&
+	    buf.modtime == smb_fname->st.st_ex_mtime.tv_sec) {
+		return 0;
+	}
+
+	result = ceph_utime(handle->data, smb_fname->base_name, &buf);
+	DEBUG(10, ("[CEPH] ntimes(%p, %s, {%ld, %ld, %ld, %ld}) = %d\n", handle, smb_fname_str_dbg(smb_fname),
+				ft->mtime.tv_sec, ft->atime.tv_sec, ft->ctime.tv_sec,
+				ft->create_time.tv_sec, result));
+	return result;
+}
+#endif /* HAVE_CEPH_STATX */
+
 static int cephwrap_unlink(struct vfs_handle_struct *handle,
 			  const struct smb_filename *smb_fname)
 {
@@ -769,39 +952,6 @@ static char *cephwrap_getwd(struct vfs_handle_struct *handle)
 	return SMB_STRDUP(cwd);
 }
 
-static int cephwrap_ntimes(struct vfs_handle_struct *handle,
-			 const struct smb_filename *smb_fname,
-			 struct smb_file_time *ft)
-{
-	struct utimbuf buf;
-	int result;
-
-	if (null_timespec(ft->atime)) {
-		buf.actime = smb_fname->st.st_ex_atime.tv_sec;
-	} else {
-		buf.actime = ft->atime.tv_sec;
-	}
-	if (null_timespec(ft->mtime)) {
-		buf.modtime = smb_fname->st.st_ex_mtime.tv_sec;
-	} else {
-		buf.modtime = ft->mtime.tv_sec;
-	}
-	if (!null_timespec(ft->create_time)) {
-		set_create_timespec_ea(handle->conn, smb_fname,
-				       ft->create_time);
-	}
-	if (buf.actime == smb_fname->st.st_ex_atime.tv_sec &&
-	    buf.modtime == smb_fname->st.st_ex_mtime.tv_sec) {
-		return 0;
-	}
-
-	result = ceph_utime(handle->data, smb_fname->base_name, &buf);
-	DEBUG(10, ("[CEPH] ntimes(%p, %s, {%ld, %ld, %ld, %ld}) = %d\n", handle, smb_fname_str_dbg(smb_fname),
-				ft->mtime.tv_sec, ft->atime.tv_sec, ft->ctime.tv_sec,
-				ft->create_time.tv_sec, result));
-	return result;
-}
-
 static int strict_allocate_ftruncate(struct vfs_handle_struct *handle, files_struct *fsp, off_t len)
 {
 	off_t space_to_write;
diff --git a/source3/wscript b/source3/wscript
index 5ce1b77e23b1..c6b2421c45b7 100644
--- a/source3/wscript
+++ b/source3/wscript
@@ -1582,6 +1582,8 @@ main() {
     if conf.CHECK_HEADERS('cephfs/libcephfs.h', False, False, 'cephfs') and conf.CHECK_LIB('cephfs', shlib=True) and Options.options.with_cephfs:
         if Options.options.with_acl_support:
             conf.DEFINE('HAVE_CEPH', '1')
+            if conf.CHECK_FUNCS_IN('ceph_statx', 'cephfs', headers='cephfs/libcephfs.h'):
+                conf.DEFINE('HAVE_CEPH_STATX', '1')
         else:
             Logs.warn("ceph support disabled due to --without-acl-support")
             conf.undefine('HAVE_CEPH')

--------------2.7.4--


