From: Jeff Layton <jlayton@samba.org>
Subject: [samba RFC PATCH 6/6] vfs:ceph: allow vfs_ceph to set the btime using setattrx
Date: Wed, 31 Aug 2016 09:01:14 -0400
Message-ID: <1472648474-3131-7-git-send-email-jlayton@samba.org>
References: <1472648474-3131-1-git-send-email-jlayton@samba.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:31425 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934400AbcHaNBz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 09:01:55 -0400
In-Reply-To: <1472648474-3131-1-git-send-email-jlayton@samba.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: samba-technical@lists.samba.org
Cc: ira@wakeful.net, ceph-devel@vger.kernel.org

...as well as the mtime and atime.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 source3/modules/vfs_ceph.c | 100 ++++++++++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 33 deletions(-)

diff --git a/source3/modules/vfs_ceph.c b/source3/modules/vfs_ceph.c
index b3c26ad4f4c1..338642e311b9 100644
--- a/source3/modules/vfs_ceph.c
+++ b/source3/modules/vfs_ceph.c
@@ -648,6 +648,40 @@ static int cephwrap_lstat(struct vfs_handle_struct *handle,
 	return result;
 }
 
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
 #else /* HAVE_CEPH_STATX */
 
 static int cephwrap_stat(struct vfs_handle_struct *handle,
@@ -731,6 +765,39 @@ static int cephwrap_lstat(struct vfs_handle_struct *handle,
 			lp_fake_directory_create_times(SNUM(handle->conn)));
 	return result;
 }
+
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
 #endif /* HAVE_CEPH_STATX */
 
 static int cephwrap_unlink(struct vfs_handle_struct *handle,
@@ -885,39 +952,6 @@ static char *cephwrap_getwd(struct vfs_handle_struct *handle)
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
-- 
2.7.4

