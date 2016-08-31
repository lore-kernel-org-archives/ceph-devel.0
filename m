From: Jeff Layton <jlayton@samba.org>
Subject: [samba RFC PATCH 4/6] vfs:ceph: change cephwrap_fstatx to use ceph_fstatx
Date: Wed, 31 Aug 2016 09:01:12 -0400
Message-ID: <1472648474-3131-5-git-send-email-jlayton@samba.org>
References: <1472648474-3131-1-git-send-email-jlayton@samba.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:31417 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934309AbcHaNBz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 09:01:55 -0400
In-Reply-To: <1472648474-3131-1-git-send-email-jlayton@samba.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: samba-technical@lists.samba.org
Cc: ira@wakeful.net, ceph-devel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 source3/modules/vfs_ceph.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/source3/modules/vfs_ceph.c b/source3/modules/vfs_ceph.c
index f8c43f93f4b5..a1480201c628 100644
--- a/source3/modules/vfs_ceph.c
+++ b/source3/modules/vfs_ceph.c
@@ -598,6 +598,32 @@ static int cephwrap_stat(struct vfs_handle_struct *handle,
 	return result;
 }
 
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
 #else /* HAVE_CEPH_STATX */
 
 static int cephwrap_stat(struct vfs_handle_struct *handle,
@@ -631,7 +657,6 @@ static int cephwrap_stat(struct vfs_handle_struct *handle,
 	DEBUG(10, ("[CEPH] mode = 0x%x\n", smb_fname->st.st_ex_mode));
 	return result;
 }
-#endif /* HAVE_CEPH_STATX */
 
 static int cephwrap_fstat(struct vfs_handle_struct *handle, files_struct *fsp, SMB_STRUCT_STAT *sbuf)
 {
@@ -658,6 +683,7 @@ static int cephwrap_fstat(struct vfs_handle_struct *handle, files_struct *fsp, S
 	DEBUG(10, ("[CEPH] mode = 0x%x\n", sbuf->st_ex_mode));
 	return result;
 }
+#endif /* HAVE_CEPH_STATX */
 
 static int cephwrap_lstat(struct vfs_handle_struct *handle,
 			 struct smb_filename *smb_fname)
-- 
2.7.4

