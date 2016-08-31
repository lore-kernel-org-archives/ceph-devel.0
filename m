From: Jeff Layton <jlayton@samba.org>
Subject: [samba RFC PATCH 5/6] vfs:ceph: convert cephwrap_lstat to use ceph_statx
Date: Wed, 31 Aug 2016 09:01:13 -0400
Message-ID: <1472648474-3131-6-git-send-email-jlayton@samba.org>
References: <1472648474-3131-1-git-send-email-jlayton@samba.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:31422 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934320AbcHaNBz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 09:01:55 -0400
In-Reply-To: <1472648474-3131-1-git-send-email-jlayton@samba.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: samba-technical@lists.samba.org
Cc: ira@wakeful.net, ceph-devel@vger.kernel.org

We can use AT_SYMLINK_NOFOLLOW flag to get the right lookup semantics.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 source3/modules/vfs_ceph.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/source3/modules/vfs_ceph.c b/source3/modules/vfs_ceph.c
index a1480201c628..b3c26ad4f4c1 100644
--- a/source3/modules/vfs_ceph.c
+++ b/source3/modules/vfs_ceph.c
@@ -624,6 +624,30 @@ static int cephwrap_fstat(struct vfs_handle_struct *handle, files_struct *fsp, S
 	return result;
 }
 
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
 #else /* HAVE_CEPH_STATX */
 
 static int cephwrap_stat(struct vfs_handle_struct *handle,
@@ -683,7 +707,6 @@ static int cephwrap_fstat(struct vfs_handle_struct *handle, files_struct *fsp, S
 	DEBUG(10, ("[CEPH] mode = 0x%x\n", sbuf->st_ex_mode));
 	return result;
 }
-#endif /* HAVE_CEPH_STATX */
 
 static int cephwrap_lstat(struct vfs_handle_struct *handle,
 			 struct smb_filename *smb_fname)
@@ -708,6 +731,7 @@ static int cephwrap_lstat(struct vfs_handle_struct *handle,
 			lp_fake_directory_create_times(SNUM(handle->conn)));
 	return result;
 }
+#endif /* HAVE_CEPH_STATX */
 
 static int cephwrap_unlink(struct vfs_handle_struct *handle,
 			  const struct smb_filename *smb_fname)
-- 
2.7.4

