From: Jeff Layton <jlayton@samba.org>
Subject: [samba RFC PATCH 3/6] vfs:ceph: convert cephwrap_stat to use ceph_statx
Date: Wed, 31 Aug 2016 09:01:11 -0400
Message-ID: <1472648474-3131-4-git-send-email-jlayton@samba.org>
References: <1472648474-3131-1-git-send-email-jlayton@samba.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:31412 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934281AbcHaNBz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 09:01:55 -0400
In-Reply-To: <1472648474-3131-1-git-send-email-jlayton@samba.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: samba-technical@lists.samba.org
Cc: ira@wakeful.net, ceph-devel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 source3/modules/vfs_ceph.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/source3/modules/vfs_ceph.c b/source3/modules/vfs_ceph.c
index 62ed469843de..f8c43f93f4b5 100644
--- a/source3/modules/vfs_ceph.c
+++ b/source3/modules/vfs_ceph.c
@@ -564,7 +564,41 @@ static void init_stat_ex_from_ceph_statx(struct stat_ex *dst, const struct ceph_
 	dst->st_ex_blksize = stx->stx_blksize;
 	dst->st_ex_blocks = stx->stx_blocks;
 }
-#endif /* HAVE_CEPH_STATX */
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
+#else /* HAVE_CEPH_STATX */
 
 static int cephwrap_stat(struct vfs_handle_struct *handle,
 			struct smb_filename *smb_fname)
@@ -597,6 +631,7 @@ static int cephwrap_stat(struct vfs_handle_struct *handle,
 	DEBUG(10, ("[CEPH] mode = 0x%x\n", smb_fname->st.st_ex_mode));
 	return result;
 }
+#endif /* HAVE_CEPH_STATX */
 
 static int cephwrap_fstat(struct vfs_handle_struct *handle, files_struct *fsp, SMB_STRUCT_STAT *sbuf)
 {
-- 
2.7.4

