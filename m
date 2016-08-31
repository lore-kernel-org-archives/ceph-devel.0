From: Jeff Layton <jlayton@samba.org>
Subject: [samba RFC PATCH 2/6] vfs:ceph: add init_stat_ex_from_ceph_statx
Date: Wed, 31 Aug 2016 09:01:10 -0400
Message-ID: <1472648474-3131-3-git-send-email-jlayton@samba.org>
References: <1472648474-3131-1-git-send-email-jlayton@samba.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:31407 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934231AbcHaNBz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 09:01:55 -0400
In-Reply-To: <1472648474-3131-1-git-send-email-jlayton@samba.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: samba-technical@lists.samba.org
Cc: ira@wakeful.net, ceph-devel@vger.kernel.org

Add a helper function that will convert a ceph_statx structure to a
stat_ex. The main difference is that we can now get a proper btime.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 source3/modules/vfs_ceph.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/source3/modules/vfs_ceph.c b/source3/modules/vfs_ceph.c
index 59e9b9cf9b3e..62ed469843de 100644
--- a/source3/modules/vfs_ceph.c
+++ b/source3/modules/vfs_ceph.c
@@ -535,6 +535,37 @@ static int cephwrap_fsync(struct vfs_handle_struct *handle, files_struct *fsp)
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
+#endif /* HAVE_CEPH_STATX */
+
 static int cephwrap_stat(struct vfs_handle_struct *handle,
 			struct smb_filename *smb_fname)
 {
-- 
2.7.4

