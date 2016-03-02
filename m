From: Jevon Qiao <scaleqiao@gmail.com>
Subject: [PATCH] hw/9pfs: Add CephFS support in VirtFS
Date: Wed,  2 Mar 2016 23:41:43 +0800
Message-ID: <1456933303-1225-1-git-send-email-scaleqiao@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33862 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbcCBPmA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 10:42:00 -0500
Received: by mail-pf0-f193.google.com with SMTP id 184so7171342pff.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 07:42:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, berrange@redhat.com, gkurz@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com
Cc: mst@redhat.com, sage@newdream.net, gfarnum@redhat.com, haomaiwang@gmail.com, Jevon Qiao <scaleqiao@gmail.com>

Ceph as a promising unified distributed storage system is widely used in the
world of OpenStack. OpenStack users deploying Ceph for block (Cinder) and
object (S3/Swift) are unsurprisingly looking at Manila and CephFS to round out
a unified storage solution. Since the typical hypervisor people are using is
Qemu/KVM, it is necessary to provide a high performance, easy to use, file
system service in it. VirtFS aims to offers paravirtualized system services and
simple passthrough for directories from host to guest, which currently only
support local file system, this patch wants to add CephFS support in VirtFS.

Signed-off-by: Jevon Qiao <scaleqiao@gmail.com>
---
 configure                         |  33 ++
 fsdev/qemu-fsdev.c                |   1 +
 fsdev/qemu-fsdev.h                |   3 +-
 hw/9pfs/9p-cephfs.c               | 739 ++++++++++++++++++++++++++++++++++++++
 hw/9pfs/Makefile.objs             |   3 +
 scripts/analyse-9p-simpletrace.py |  96 +++++
 trace-events                      |  33 ++
 7 files changed, 907 insertions(+), 1 deletion(-)
 create mode 100644 hw/9pfs/9p-cephfs.c

diff --git a/configure b/configure
index 0c0472a..a2627be 100755
--- a/configure
+++ b/configure
@@ -275,6 +275,7 @@ trace_backends="log"
 trace_file="trace"
 spice=""
 rbd=""
+cephfs=""
 smartcard=""
 libusb=""
 usb_redir=""
@@ -1019,6 +1020,10 @@ for opt do
   ;;
   --enable-rbd) rbd="yes"
   ;;
+  --disable-cephfs) cephfs="no"
+  ;;
+  --enable-cephfs) cephfs="yes"
+  ;;
   --disable-xfsctl) xfs="no"
   ;;
   --enable-xfsctl) xfs="yes"
@@ -1345,6 +1350,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vhost-net       vhost-net acceleration support
   spice           spice
   rbd             rados block device (rbd)
+  cephfs          Ceph File System 
   libiscsi        iscsi support
   libnfs          nfs support
   smartcard       smartcard support (libcacard)
@@ -3087,6 +3093,28 @@ EOF
 fi
 
 ##########################################
+# cephfs probe
+if test "$cephfs" != "no" ; then
+  cat > $TMPC <<EOF
+#include <stdio.h>
+#include <cephfs/libcephfs.h>
+int main(void) {
+    struct ceph_mount_info *cmount;
+    ceph_create(&cmount, NULL);
+    return 0;
+}
+EOF
+  cephfs_libs="-lcephfs -lrados"
+  if compile_prog "" "$cephfs_libs" ; then
+    cephfs=yes
+  else
+    if test "$cephfs" = "yes" ; then
+      feature_not_found "cephfs" "Install libcephfs/ceph devel"
+    fi
+    cephfs=no
+  fi
+fi
+##########################################
 # libssh2 probe
 min_libssh2_version=1.2.8
 if test "$libssh2" != "no" ; then
@@ -4760,6 +4788,7 @@ else
 echo "spice support     $spice"
 fi
 echo "rbd support       $rbd"
+echo "cephfs support    $cephfs"
 echo "xfsctl support    $xfs"
 echo "smartcard support $smartcard"
 echo "libusb            $libusb"
@@ -5224,6 +5253,10 @@ if test "$rbd" = "yes" ; then
   echo "RBD_CFLAGS=$rbd_cflags" >> $config_host_mak
   echo "RBD_LIBS=$rbd_libs" >> $config_host_mak
 fi
+if test "$cephfs" = "yes" ; then
+  echo "CONFIG_CEPHFS=m" >> $config_host_mak
+  echo "CEPHFS_LIBS=$cephfs_libs" >> $config_host_mak
+fi
 
 echo "CONFIG_COROUTINE_BACKEND=$coroutine" >> $config_host_mak
 if test "$coroutine_pool" = "yes" ; then
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index bf7f0b0..7f07a2a 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -27,6 +27,7 @@ static FsDriverTable FsDrivers[] = {
 #endif
     { .name = "synth", .ops = &synth_ops},
     { .name = "proxy", .ops = &proxy_ops},
+    { .name = "cephfs", .ops = &cephfs_ops},
 };
 
 int qemu_fsdev_add(QemuOpts *opts)
diff --git a/fsdev/qemu-fsdev.h b/fsdev/qemu-fsdev.h
index 9fa45bf..86a17b8 100644
--- a/fsdev/qemu-fsdev.h
+++ b/fsdev/qemu-fsdev.h
@@ -22,7 +22,7 @@
  * fstype | ops
  * -----------------
  *  local | local_ops
- *  .     |
+ *  cephfs| cephfs_ops
  *  .     |
  *  .     |
  *  .     |
@@ -45,4 +45,5 @@ extern FileOperations local_ops;
 extern FileOperations handle_ops;
 extern FileOperations synth_ops;
 extern FileOperations proxy_ops;
+extern FileOperations cephfs_ops;
 #endif
diff --git a/hw/9pfs/9p-cephfs.c b/hw/9pfs/9p-cephfs.c
new file mode 100644
index 0000000..f18ec89
--- /dev/null
+++ b/hw/9pfs/9p-cephfs.c
@@ -0,0 +1,739 @@
+/*
+ * Virtio 9p cephfs callback
+ *
+ * Copyright UnitedStack, Corp. 2016
+ *
+ * Authors:
+ *    Jevon Qiao <scaleqiao@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "9p.h"
+#include "9p-xattr.h"
+#include "trace.h"
+#include <cephfs/libcephfs.h>
+#include "fsdev/qemu-fsdev.h"   /* cephfs_ops */
+#include <arpa/inet.h>
+#include <pwd.h>
+#include <grp.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include "qemu/xattr.h"
+#include "qemu/error-report.h"
+#include <libgen.h>
+#include <unistd.h>
+#include <linux/fs.h>
+#ifdef CONFIG_LINUX_MAGIC_H
+#include <linux/magic.h>
+#endif
+#include <sys/ioctl.h>
+
+#define CEPH_VER_LEN        32
+#define MON_NAME_LEN        32
+#define MON_SECRET_LEN      64
+
+#ifndef LIBCEPHFS_VERSION
+#define LIBCEPHFS_VERSION(maj, min, extra) ((maj << 16) + (min << 8) + extra)
+#define LIBCEPHFS_VERSION_CODE LIBCEPHFS_VERSION(0, 0, 0)
+#endif
+
+struct cephfs_data {
+    int	major, minor, patch;
+    char ceph_version[CEPH_VER_LEN];
+    struct  ceph_mount_info *cmount;
+};
+
+/*
+ * Helper function for cephfs_preadv and cephfs_pwritev
+ */
+inline static ssize_t preadv_pwritev(struct ceph_mount_info *cmount, int fd,
+                              	    const struct iovec *iov, int iov_cnt,
+                              	    off_t offset, bool do_write)
+{
+    ssize_t ret = 0;
+    size_t i = 0;
+    size_t len = 0;
+    void *buf, *buftmp;
+    size_t bufoffset = 0;
+
+    len = iov_size(iov, iov_cnt);
+    buf = g_new0(uint8_t, len);
+    buftmp = buf;
+    if (do_write) {
+        for (i = 0; i < iov_cnt; i++) {
+            memcpy((buftmp + bufoffset), iov[i].iov_base, iov[i].iov_len);
+            bufoffset += iov[i].iov_len;
+        }
+        ret = ceph_write(cmount, fd, buf, len, offset);
+        if (ret <= 0) {
+           errno = -ret;
+           ret = -1;
+        }
+    } else {
+        ret = ceph_read(cmount, fd, buf, len, offset);
+        if (ret <= 0) {
+            errno = -ret;
+            ret = -1;
+        } else {
+            for (i = 0; i < iov_cnt; i++) {
+                memcpy(iov[i].iov_base, (buftmp + bufoffset), iov[i].iov_len);
+                bufoffset += iov[i].iov_len;
+            }
+        }
+    }
+
+    free(buf);
+    return ret;
+}
+
+static int cephfs_update_file_cred(struct ceph_mount_info *cmount,
+				   const char *name, FsCred *credp)
+{
+    int fd, ret;
+    fd = ceph_open(cmount, name, O_NONBLOCK | O_NOFOLLOW, credp->fc_mode);
+    if (fd < 0) {
+        return fd;
+    }
+    ret = ceph_fchown(cmount, fd, credp->fc_uid, credp->fc_gid);
+    if (ret < 0) {
+        goto err_out;
+    }
+    ret = ceph_fchmod(cmount, fd, credp->fc_mode & 07777);
+err_out:
+    close(fd);
+    return ret;
+}
+
+static int cephfs_lstat(FsContext *fs_ctx, V9fsPath *fs_path,
+                        struct stat *stbuf)
+{
+    int ret;
+    char *path = fs_path->data;
+    struct cephfs_data *cfsdata = fs_ctx->private;
+
+    ret = ceph_lstat(cfsdata->cmount, path, stbuf);
+    trace_cephfs_lstat_return(path, stbuf->st_mode, stbuf->st_uid, stbuf->st_gid, stbuf->st_size, ret);
+    if (ret){
+        errno = -ret; 
+        ret = -1;
+    }
+    return ret;
+}
+
+static ssize_t cephfs_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
+                               char *buf, size_t bufsz)
+{
+    int ret;
+    char *path = fs_path->data;
+    struct cephfs_data *cfsdata = fs_ctx->private;
+
+    ret = ceph_readlink(cfsdata->cmount, path, buf, bufsz);
+    trace_cephfs_readlink_return(path, ret);
+    return ret;
+}
+
+static int cephfs_close(FsContext *ctx, V9fsFidOpenState *fs)
+{
+    struct cephfs_data *cfsdata = ctx->private;
+
+    return ceph_close(cfsdata->cmount, fs->fd);
+}
+
+static int cephfs_closedir(FsContext *ctx, V9fsFidOpenState *fs)
+{
+    struct cephfs_data *cfsdata = ctx->private;
+   
+    return ceph_closedir(cfsdata->cmount, (struct ceph_dir_result *)fs->dir);
+}
+
+static int cephfs_open(FsContext *ctx, V9fsPath *fs_path,
+                       int flags, V9fsFidOpenState *fs)
+{
+    struct cephfs_data *cfsdata = ctx->private;
+
+    fs->fd = ceph_open(cfsdata->cmount, fs_path->data, flags, 0777);
+    trace_cephfs_open_return(fs_path->data, flags, 0777, fs->fd);
+    return fs->fd;
+}
+
+static int cephfs_opendir(FsContext *ctx,
+                          V9fsPath *fs_path, V9fsFidOpenState *fs)
+{
+    int ret;
+    struct ceph_dir_result *result;
+    struct cephfs_data *cfsdata = ctx->private;
+    char *path = fs_path->data;
+  
+    ret = ceph_opendir(cfsdata->cmount, path, &result);
+    trace_cephfs_opendir_return(path, ret);
+    if (ret) {
+        fprintf(stderr, "ceph_opendir=%d\n", ret);
+        return ret;
+    }
+    fs->dir = (DIR *)result;
+    if (!fs->dir) {
+        fprintf(stderr, "ceph_opendir return NULL for ceph_dir_result\n");
+        return -1;
+    }
+    return 0;
+}
+ 
+static void cephfs_rewinddir(FsContext *ctx, V9fsFidOpenState *fs)
+{
+    struct cephfs_data *cfsdata = ctx->private;
+
+    trace_cephfs_rewinddir(fs->dir);
+    return ceph_rewinddir(cfsdata->cmount, (struct ceph_dir_result *)fs->dir);
+}
+
+static off_t cephfs_telldir(FsContext *ctx, V9fsFidOpenState *fs)
+{
+    int ret;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    trace_cephfs_telldir(fs->dir);
+    ret = ceph_telldir(cfsdata->cmount, (struct ceph_dir_result *)fs->dir);
+    return ret;
+}
+
+static int cephfs_readdir_r(FsContext *ctx, V9fsFidOpenState *fs,
+                            struct dirent *entry,
+                            struct dirent **result)
+{
+    int ret;
+    struct dirent *tmpent;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    tmpent = entry;
+    ret = ceph_readdir_r(cfsdata->cmount, (struct ceph_dir_result *)fs->dir,
+		    	entry);
+    trace_cephfs_readdir_r_return(tmpent, entry, ret);
+    if (ret > 0 && entry != NULL)
+    {
+        *result = entry;
+    } else if (!ret)
+    {
+        *result = NULL;
+        entry = tmpent;
+    }
+    
+    return ret;
+}
+
+static void cephfs_seekdir(FsContext *ctx, V9fsFidOpenState *fs, off_t off)
+{
+    struct cephfs_data *cfsdata = ctx->private;
+
+    trace_cephfs_seekdir(fs->dir, off);
+    return ceph_seekdir(cfsdata->cmount, (struct ceph_dir_result*)fs->dir, off);
+}
+
+static ssize_t cephfs_preadv(FsContext *ctx, V9fsFidOpenState *fs,
+                             const struct iovec *iov,
+                             int iovcnt, off_t offset)
+{
+    ssize_t ret = 0;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    trace_cephfs_preadv(iovcnt, iov_size(iov, iovcnt));
+#if defined(LIBCEPHFS_VERSION) && LIBCEPHFS_VERSION_CODE >= LIBCEPHFS_VERSION(9, 0, 3) 
+    ret = ceph_preadv(cfsdata->cmount, fs->fd, iov, iovcnt, offset); 
+#else
+    if (iovcnt > 1) {
+	ret = preadv_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offset, 0);
+    } else if (iovcnt > 0) {
+	ret = ceph_read(cfsdata->cmount, fs->fd, iov[0].iov_base,
+			iov[0].iov_len, offset);
+    }
+#endif
+    trace_cephfs_preadv_return(iovcnt, iov_size(iov, iovcnt), ret);
+
+    return ret;
+}
+
+static ssize_t cephfs_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
+                              const struct iovec *iov,
+                              int iovcnt, off_t offset)
+{
+    ssize_t ret = 0;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    trace_cephfs_pwritev(iovcnt, iov_size(iov, iovcnt), offset);
+#if defined(LIBCEPHFS_VERSION) && LIBCEPHFS_VERSION_CODE >= LIBCEPHFS_VERSION(9, 0, 3) 
+    ret = ceph_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offset);
+#else
+    if (iovcnt > 1) {
+	ret = preadv_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offset, 1);
+    } else if (iovcnt > 0) {
+	ret = ceph_write(cfsdata->cmount, fs->fd, iov[0].iov_base,
+			iov[0].iov_len, offset);
+    }
+#endif
+    trace_cephfs_pwritev_return(iovcnt, iov_size(iov, iovcnt), offset, ret);
+
+#ifdef CONFIG_SYNC_FILE_RANGE
+    if (ret > 0 && ctx->export_flags & V9FS_IMMEDIATE_WRITEOUT) {
+        /*
+         * Initiate a writeback. This is not a data integrity sync.
+         * We want to ensure that we don't leave dirty pages in the cache
+         * after write when writeout=immediate is sepcified.
+         */
+        sync_file_range(fs->fd, offset, ret,
+                        SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE);
+    }
+#endif
+    return ret;
+}
+
+static int cephfs_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
+{
+    int  ret = -1;
+    struct cephfs_data *cfsdata = fs_ctx->private;
+
+    ret = ceph_chmod(cfsdata->cmount, fs_path->data, credp->fc_mode);
+    trace_cephfs_chmod_return(fs_path->data, credp->fc_mode, ret);
+    return ret;
+}
+
+static int cephfs_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
+                       const char *name, FsCred *credp)
+{
+    int ret;
+    V9fsString fullname;
+    struct cephfs_data *cfsdata = fs_ctx->private;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    ret = ceph_mknod(cfsdata->cmount, fullname.data, credp->fc_mode,
+		    credp->fc_rdev);
+    trace_cephfs_mknod_return(fullname.data, credp->fc_mode, credp->fc_rdev, ret);
+
+    v9fs_string_free(&fullname);
+    return ret;
+}
+
+static int cephfs_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
+                       const char *name, FsCred *credp)
+{
+    int ret;
+    V9fsString fullname;
+    struct cephfs_data *cfsdata = fs_ctx->private;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    ret = ceph_mkdir(cfsdata->cmount, fullname.data, credp->fc_mode);
+    trace_cephfs_mkdir_return(fullname.data, credp->fc_mode, ret);
+
+    v9fs_string_free(&fullname);
+    return ret;
+}
+
+static int cephfs_fstat(FsContext *fs_ctx, int fid_type,
+                        V9fsFidOpenState *fs, struct stat *stbuf)
+{
+    int fd = -1;
+    int ret;
+    struct cephfs_data *cfsdata = fs_ctx->private;
+
+    if (fid_type == P9_FID_DIR) {
+        fd = dirfd(fs->dir);
+    } else {
+        fd = fs->fd;
+    }
+    ret = ceph_fstat(cfsdata->cmount, fd, stbuf);
+    trace_cephfs_fstat_return(fid_type, fd, stbuf->st_uid, stbuf->st_gid, stbuf->st_size, ret);
+
+    return ret;
+}
+
+static int cephfs_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
+                        int flags, FsCred *credp, V9fsFidOpenState *fs)
+{
+    int fd = -1, ret = -1;
+    V9fsString fullname;
+    struct cephfs_data *cfsdata = fs_ctx->private;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    fd = ceph_open(cfsdata->cmount, fullname.data, flags, credp->fc_mode);
+    trace_cephfs_open2_return(fullname.data, flags, credp->fc_mode);
+    if (fd >= 0) {
+        /* After creating the file, need to set the cred */
+        ret = cephfs_update_file_cred(cfsdata->cmount, name, credp);
+        if (ret < 0) {
+            ceph_close(cfsdata->cmount, fd);
+            errno = -ret;
+            fd = ret;
+        } else {
+            fs->fd = fd;
+        }
+    } else {
+       errno = -fd;
+    }
+
+    v9fs_string_free(&fullname);
+    return fd;
+}
+
+static int cephfs_symlink(FsContext *fs_ctx, const char *oldpath,
+                          V9fsPath *dir_path, const char *name, FsCred *credp)
+{
+    int ret = -1;
+    V9fsString fullname;
+    struct cephfs_data *cfsdata = fs_ctx->private;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    ret = ceph_symlink(cfsdata->cmount, oldpath, fullname.data);
+    trace_cephfs_symlink_return(oldpath, fullname.data, ret);
+
+    v9fs_string_free(&fullname);
+    return ret;
+}
+
+static int cephfs_link(FsContext *ctx, V9fsPath *oldpath,
+                       V9fsPath *dirpath, const char *name)
+{
+    int ret = -1;
+    V9fsString newpath;
+    struct cephfs_data *cfsdata = ctx->private;
+    
+    v9fs_string_init(&newpath);
+    v9fs_string_sprintf(&newpath, "%s/%s", dirpath->data, name);
+    ret = ceph_link(cfsdata->cmount, oldpath->data, newpath.data);
+    trace_cephfs_link_return(oldpath->data, newpath.data, ret);
+
+    v9fs_string_free(&newpath); 
+    return ret;
+}
+
+static int cephfs_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
+{
+    int ret = -1;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    ret = ceph_truncate(cfsdata->cmount, fs_path->data, size);
+    trace_cephfs_truncate_return(fs_path->data, size, ret);
+
+    return ret;
+}
+
+static int cephfs_rename(FsContext *ctx, const char *oldpath,
+                         const char *newpath)
+{
+    int ret = -1;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    ret = ceph_rename(cfsdata->cmount, oldpath, newpath);
+    trace_cephfs_rename_return(oldpath, newpath, ret);
+
+    return ret;
+}
+
+static int cephfs_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
+{
+    int ret = -1;
+    struct cephfs_data *cfsdata = fs_ctx->private;
+
+    ret = ceph_chown(cfsdata->cmount, fs_path->data, credp->fc_uid,
+		    credp->fc_gid);
+    trace_cephfs_chown_return(fs_path->data, credp->fc_uid, credp->fc_gid, ret);
+
+    return ret;
+}
+
+static int cephfs_utimensat(FsContext *ctx, V9fsPath *fs_path,
+                            const struct timespec *buf)
+{
+    int ret = -1;
+
+#ifdef CONFIG_UTIMENSAT
+    struct cephfs_data *cfsdata = ctx->private;
+
+    ret = ceph_utime(cfsdata->cmount, fs_path->data, (struct utimbuf *)buf);
+    trace_cephfs_utimensat_return(fs_path->data, ret);
+#else
+    ret = -1;
+    errno = ENOSYS;
+#endif
+
+    return ret;
+}
+
+static int cephfs_remove(FsContext *ctx, const char *path)
+{
+    errno = EOPNOTSUPP;
+    return -1;
+}
+
+static int cephfs_fsync(FsContext *ctx, int fid_type,
+                        V9fsFidOpenState *fs, int datasync)
+{
+    int ret = -1, fd = -1;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    if (fid_type == P9_FID_DIR) {
+        fd = dirfd(fs->dir);
+    } else {
+        fd = fs->fd;
+    }
+    ret = ceph_fsync(cfsdata->cmount, fd, datasync);
+    trace_cephfs_fsync_return(fd, datasync, ret);
+
+    return ret;
+}
+
+static int cephfs_statfs(FsContext *ctx, V9fsPath *fs_path,
+                         struct statfs *stbuf)
+{
+    int ret;
+    char *path = fs_path->data;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    ret = ceph_statfs(cfsdata->cmount, path, (struct statvfs*)stbuf);
+    if (ret) {
+        fprintf(stderr, "ceph_statfs=%d\n", ret); 
+    }
+
+    return ret;
+}
+
+/*
+ * Get the extended attribute of normal file, if the path refer to a symbolic
+ * link, just return the extended attributes of the syslink rather than the
+ * attributes of the link itself.
+ */
+static ssize_t cephfs_lgetxattr(FsContext *ctx, V9fsPath *fs_path,
+                                const char *name, void *value, size_t size)
+{
+    int ret;
+    char *path = fs_path->data;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    ret = ceph_lgetxattr(cfsdata->cmount, path, name, value, size);
+    trace_cephfs_lgetxattr_return(path, name, ret);
+
+    return ret;
+}
+
+static ssize_t cephfs_llistxattr(FsContext *ctx, V9fsPath *fs_path,
+                                 void *value, size_t size)
+{
+    int ret = -1;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    ret = ceph_llistxattr(cfsdata->cmount, fs_path->data, value, size);
+    trace_cephfs_llistxattr_return(fs_path->data, ret);
+
+    return ret;
+}
+
+static int cephfs_lsetxattr(FsContext *ctx, V9fsPath *fs_path, const char *name,
+                            void *value, size_t size, int flags)
+{
+    int ret = -1;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    ret = ceph_lsetxattr(cfsdata->cmount, fs_path->data, name, value, size,
+	flags);
+    trace_cephfs_lsetxattr_return(fs_path->data, name, flags, ret);
+
+    return ret;
+}
+
+static int cephfs_lremovexattr(FsContext *ctx, V9fsPath *fs_path,
+                               const char *name)
+{
+    int ret = -1;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    ret = ceph_lremovexattr(cfsdata->cmount, fs_path->data, name);
+    trace_cephfs_lremovexattr_return(fs_path->data, name, ret);
+
+    return ret;
+}
+
+static int cephfs_name_to_path(FsContext *ctx, V9fsPath *dir_path,
+                              const char *name, V9fsPath *target)
+{
+    if (dir_path) {
+        v9fs_string_sprintf((V9fsString *)target, "%s/%s",
+                            dir_path->data, name);
+    } else {
+        /* if the path does not start from '/' */
+        v9fs_string_sprintf((V9fsString *)target, "%s", name);
+    }
+
+    /* Bump the size for including terminating NULL */ 
+    target->size++;
+    return 0;
+}
+
+static int cephfs_renameat(FsContext *ctx, V9fsPath *olddir,
+                           const char *old_name, V9fsPath *newdir,
+                           const char *new_name)
+{
+    int ret = -1;
+    struct cephfs_data *cfsdata = ctx->private;
+    
+    ret = ceph_rename(cfsdata->cmount, old_name, new_name);
+    trace_cephfs_renameat_return(old_name, new_name, ret);
+
+    return ret;
+}
+
+static int cephfs_unlinkat(FsContext *ctx, V9fsPath *dir,
+                           const char *name, int flags)
+{
+    int ret = 0;
+    char *path = dir->data;
+    struct stat fstat;
+    V9fsString fullname;
+    struct cephfs_data *cfsdata = ctx->private;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir->data, name);
+    path = fullname.data;
+    /* determine which kind of file is being destroyed */ 
+    ret = ceph_lstat(cfsdata->cmount, path, &fstat);
+    if (!ret) {
+        switch (fstat.st_mode & S_IFMT) {
+        case S_IFDIR:
+            ret = ceph_rmdir(cfsdata->cmount, path);
+            break;
+
+        case S_IFBLK:
+        case S_IFCHR:
+        case S_IFIFO:
+        case S_IFLNK:
+        case S_IFREG:
+        case S_IFSOCK:
+            ret = ceph_unlink(cfsdata->cmount, path);
+            break;
+
+        default:
+            fprintf(stderr, "ceph_lstat unknown stmode\n");
+            break;
+        }
+    } else {
+        errno = -ret;
+        ret = -1;
+    }
+    trace_cephfs_unlinkat_return(path, fstat.st_mode, ret);
+
+    v9fs_string_free(&fullname);
+    return ret;
+}
+
+/*
+ * Do two things in the init function:
+ * 1) Create a mount handle used by all cephfs interfaces.
+ * 2) Invoke ceph_mount() to initialize a link between the client and 
+ *    ceph monitor
+ */
+static int cephfs_init(FsContext *ctx)
+{
+    int ret;
+    const char *ver = NULL;
+    struct cephfs_data *data = g_malloc(sizeof(struct cephfs_data));
+
+    if (data == NULL) {
+	errno = ENOMEM;
+	return -1;
+    }
+    trace_cephfs_init(ctx->fs_root);
+    memset(data, 0, sizeof(struct cephfs_data));
+    ret = ceph_create(&data->cmount, NULL);
+    if (ret) {
+        fprintf(stderr, "ceph_create=%d\n", ret);
+        goto err_out;
+    }
+
+    ret = ceph_conf_read_file(data->cmount, NULL);
+    if (ret) {
+        fprintf(stderr, "ceph_conf_read_file=%d\n", ret);
+        goto err_out;
+    }
+
+    ret = ceph_mount(data->cmount, ctx->fs_root);
+    if (ret) {
+        fprintf(stderr, "ceph_mount=%d\n", ret);
+        goto err_out;
+    } else {
+        ctx->private = data;
+	/* CephFS does not support FS_IOC_GETVERSIO */ 
+	ctx->exops.get_st_gen = NULL;
+        goto out;
+    }
+
+    ver = ceph_version(&data->major, &data->minor, &data->patch);
+    memcpy(data->ceph_version, ver, strlen(ver) + 1);
+    
+err_out:
+    g_free(data);
+out:
+    return ret;
+}
+
+static int cephfs_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
+{
+    const char *sec_model = qemu_opt_get(opts, "security_model");
+    const char *path = qemu_opt_get(opts, "path");
+
+    if (!sec_model) {
+        fprintf(stderr, "Invalid argument security_model specified with "
+		"cephfs fsdriver\n");
+        return -1;
+    }
+
+    if (!path) {
+        fprintf(stderr, "fsdev: No path specified.\n");
+        return -1;
+    }
+
+    fse->path = g_strdup(path);
+    return 0;
+}
+
+FileOperations cephfs_ops = {
+    .parse_opts   = cephfs_parse_opts,
+    .init         = cephfs_init,
+    .lstat        = cephfs_lstat,
+    .readlink     = cephfs_readlink,
+    .close        = cephfs_close,
+    .closedir     = cephfs_closedir,
+    .open         = cephfs_open,
+    .opendir      = cephfs_opendir,
+    .rewinddir    = cephfs_rewinddir,
+    .telldir      = cephfs_telldir,
+    .readdir_r    = cephfs_readdir_r,
+    .seekdir      = cephfs_seekdir,
+    .preadv       = cephfs_preadv,
+    .pwritev      = cephfs_pwritev,
+    .chmod        = cephfs_chmod,
+    .mknod        = cephfs_mknod,
+    .mkdir        = cephfs_mkdir,
+    .fstat        = cephfs_fstat,
+    .open2        = cephfs_open2,
+    .symlink      = cephfs_symlink,
+    .link         = cephfs_link,
+    .truncate     = cephfs_truncate,
+    .rename       = cephfs_rename,
+    .chown        = cephfs_chown,
+    .utimensat    = cephfs_utimensat,
+    .remove       = cephfs_remove,
+    .fsync        = cephfs_fsync,
+    .statfs       = cephfs_statfs,
+    .lgetxattr    = cephfs_lgetxattr,
+    .llistxattr   = cephfs_llistxattr,
+    .lsetxattr    = cephfs_lsetxattr,
+    .lremovexattr = cephfs_lremovexattr,
+    .name_to_path = cephfs_name_to_path,
+    .renameat     = cephfs_renameat,
+    .unlinkat     = cephfs_unlinkat,
+};
diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
index da0ae0c..a77a6f4 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -5,5 +5,8 @@ common-obj-y += coth.o cofs.o codir.o cofile.o
 common-obj-y += coxattr.o 9p-synth.o
 common-obj-$(CONFIG_OPEN_BY_HANDLE) +=  9p-handle.o
 common-obj-y += 9p-proxy.o
+common-obj-y += 9p-cephfs.o
 
 obj-y += virtio-9p-device.o
+
+9p-cephfs.o-libs := $(CEPHFS_LIBS)
diff --git a/scripts/analyse-9p-simpletrace.py b/scripts/analyse-9p-simpletrace.py
index 3c3dee4..fe0a496 100755
--- a/scripts/analyse-9p-simpletrace.py
+++ b/scripts/analyse-9p-simpletrace.py
@@ -210,4 +210,100 @@ class VirtFSRequestTracker(simpletrace.Analyzer):
         def v9fs_readlink_return(self, tag, id, target):
                 print "RREADLINK (tag =", tag, ", target =", target, ")"
 
+	def cephfs_lstat_return(self, path, stmode, stuid, stgid, stsize, ret):
+		print "RCEPHFSLSTAT (path =", path, ", stmode =", stmode, ", stuid =", stuid, ", stgid =", stgid, ", stsize =", stsize, ", ret =", ret, ")"
+
+	def cephfs_readlink_return(self, path, ret):
+		print "RCEPHFSREADLINK (path =", path, ", ret =", ret, ")"
+
+	def cephfs_open_return(self, path, flags, mode, fd):
+		print "RCEPHFSOPEN (path =", path, ", flags =", flags, ", mode =", mode, ", fd =", fd, ")"
+
+	def cephfs_opendir_return(self, path, ret):
+		print "RCEPHFSOPENDIR (path =", path, ", ret =", ret, ")"
+
+	def cephfs_rewinddir(self, dir):
+		print "TCEPHFSREWINDDIR (dir =", dir, ")"
+
+	def cephfs_telldir(self, dir):
+		print "TCEPHFSTELLDIR (dir =", dir, ")"
+
+	def cephfs_readdir_r_return(self, tmpent, entry, ret):
+		print "RCEPHFSREADDIRR (tmpent =", tmpent, ", entry =", entry, ", ret =", ret, ")"
+
+	def cephfs_seekdir(self, dir, off):
+		print "TCEPHFSSEEKDIR (dir =", dir, ", off =", off, ")"
+
+	def cephfs_preadv(self, iovcnt, len):
+		print "TCEPHFSPREADV (iovcnt=", iovcnt, ", len =", len, ")"
+
+	def cephfs_preadv_return(self, iovcnt, len, ret):
+		print "RCEPHFSPREADV (iovcnt=", iovcnt, ", len =", len, ", ret = ", ret, ")"
+
+	def cephfs_pwritev(self, iovcnt, len, offset):
+		print "TCEPHFSPWRITEV (iovcnt=", iovcnt, ", len =", len, ", offset =", offset, ")"
+
+	def cephfs_pwritev_return(self, iovcnt, len, offset, ret):
+		print "RCEPHFSPWRITEV (iovcnt=", iovcnt, ", len =", len, ", offset =", offset, ", ret = ", ret, ")"
+
+	def cephfs_chmod(self, path, fcmode):
+		print "TCEPHFSCHMOD (path =", path, ", fcmode =", fcmode, ")"
+
+	def cephfs_chmod_return(self, path, fcmode, ret):
+		print "RCEPHFSCHMOD (path =", path, ", fcmode =", fcmode, ", ret =", ret, ")"
+
+	def cephfs_mknod_return(self, path, fcmode, fcrdev, ret):
+		print "RCEPHFSMKNOD (path =", path, ", fcmode =", fcmode, ", fcrdev =", fcrdev, ", ret =", ret, ")"
+
+	def cephfs_mkdir_return(self, path, fcmode, ret):
+		print "RCEPHFSMKDIR (path =", path, ", fcmode =", fcmode, ", ret =", ret, ")"
+
+	def cephfs_fstat_return(self, fidtype, fd, stuid, stgid, stsize, ret):
+		print "RCEPHFSFSTAT (fidtype =", fidtype, ", fd =", fd, ", stuid =", stuid, ", stgid =", stgid, ", stsize =", stsize, ", ret =", ret, ")"
+
+	def cephfs_open2_return(self, path, flags, fcmode):
+		print "RCEPHFSOPEN2 (path =", path, ", flags =", flags, "fcmode =", fcmode, ")"
+
+	def cephfs_symlink_return(self, oldpath, path, ret):
+		print "RCEPHFSSYMLINK (oldpath =", oldpath, ", path =", path, ", ret =", ret, ")"
+
+	def cephfs_link_return(self, oldpath, path, ret):
+		print "RCEPHFSLINK (oldpath =", oldpath, ", path =", path, ", ret =", ret, ")"
+
+	def cephfs_truncate_return(self, path, size, ret):
+		print "RCEPHFSTRUNCATE (path =", path, ", size =", size, ", ret =", ret, ")"
+
+	def cephfs_rename_return(self, oldpath, newpath, ret):
+		print "RCEPHFSRENAME (oldpath =", oldpath, ", newpath =", newpath, ", ret =", ret, ")"
+
+	def cephfs_chown_return(self, path, fcuid, fcgid, ret):
+		print "RCEPHFSCHOWN (path =", path, ", fcuid =", fcuid, ", fcgid =", fcgid, ", ret =", ret, ")"
+
+	def cephfs_utimensat_return(self, path, ret):
+		print "RCEPHFSUTIMENSAT (path =", path, ", ret =", ret, ")"
+
+	def cephfs_fsync_return(self, fd, datasync, ret):
+		print "RCEPHFSFSYNC (fd =", fd, ", datasync =", datasync, ", ret =", ret, ")"
+
+	def cephfs_lgetxattr_return(self, path, name, ret):
+		print "RCEPHFSLGETXATTR (path =", path, ", name =", name, ", ret =", ret, ")"
+
+	def cephfs_llistxattr_return(self, path, ret):
+		print "RCEPHFSLLISTXATTR (path =", path, ", ret =", ret, ")"
+
+	def cephfs_lsetxattr_return(self, path, name, flags, ret):
+		print "RCEPHFSLSETXATTR (path =", path, ", name =", name, ", flags =", flags, ", ret =", ret, ")"
+
+	def cephfs_lremovexattr_return(self, path, name, ret):
+		print "RCEPHFSLREMOVEXATTR (path =", path, ", name =", name, ", ret =", ret, ")"
+
+	def cephfs_renameat_return(self, oldname, newname, ret):
+		print "RCEPHFSRENAMEAT (oldname =", oldname, ", newname =", newname, ", ret =", ret, ")"
+
+	def cephfs_unlinkat_return(self, path, stmode, ret):
+		print "RCEPHFSUNLINKAT (path =", path, ", stmode =", stmode, ", ret =", ret, ")"
+
+	def cephfs_init(self, path):
+		print "RCEPHFSINIT (path =", path, ")"
+
 simpletrace.run(VirtFSRequestTracker())
diff --git a/trace-events b/trace-events
index 6fba6cc..11879d2 100644
--- a/trace-events
+++ b/trace-events
@@ -1118,6 +1118,39 @@ v9fs_xattrcreate(uint16_t tag, uint8_t id, int32_t fid, char* name, int64_t size
 v9fs_readlink(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
 v9fs_readlink_return(uint16_t tag, uint8_t id, char* target) "tag %d id %d name %s"
 
+# hw/9pfs/9p-cephfs.c 
+cephfs_lstat_return(char *path, int stmode, int stuid, int stgid, int stsize, int ret) "path %s stmode %d stuid %d stgid %d stsize %d ret %d"
+cephfs_readlink_return(char *path, int ret) "path %s ret %d"
+cephfs_open_return(char *path, int flags, int mode, int fd) "path %s flags %d mode %d fd %d"
+cephfs_opendir_return(char *path, int ret) "path %s ret %d"
+cephfs_rewinddir(void *dir) "dir %p"
+cephfs_telldir(void *dir) "dir %p"
+cephfs_readdir_r_return(void *tmpent, void *entry, int ret) "tmpent %p entry %p ret %d"
+cephfs_seekdir(void *dir, int off) "dir %p off %d"
+cephfs_preadv(int iovcnt, int len) "iovcnt %d len %d"
+cephfs_preadv_return(int iovcnt, int len, long ret) "iovcnt %d len %d ret %l"
+cephfs_pwritev(int iovcnt, int len, int offset) "iovcnt %d len %d offset %d"
+cephfs_pwritev_return(int iovcnt, int len, int offset, long ret) "iovcnt %d len %d offset %d ret %l"cephfs_chmod(char *path, int fcmode) "path %s fcmode %d"
+cephfs_chmod_return(char *path, int fcmode, int ret) "path %s fcmode %d ret %d"
+cephfs_mknod_return(char *path, int fcmode, uint32_t fcrdev, int ret) "path %s fcmode %d fcrdev %u ret %d"
+cephfs_mkdir_return(char *path, int fcmode, int ret) " path %s fcmode %d ret %d"
+cephfs_fstat_return(int fidtype, int fd, int stuid, int stgid, int stsize, int ret) "fidtype %d fd %d stuid %d stgid %d stsize %d ret %d"
+cephfs_open2_return(char *path, int flags, int fcmode) "path %s flags %d fcmode %d"
+cephfs_symlink_return(const char *oldpath, char *path, int ret) "oldpath %s path %s ret %d"
+cephfs_link_return(char *oldpath, char *path, int ret) "oldpath %s path %s ret %d"
+cephfs_truncate_return(char *path, int size, int ret) "path %s size %d ret %d"
+cephfs_rename_return(const char *oldpath, const char *newpath, int ret) "oldpath %s newpath %s ret %d"
+cephfs_chown_return(char *path, int fcuid, int fcgid, int ret) "path %s fcuid %d fcgid %d ret %d"
+cephfs_utimensat_return(char *path, int ret) "path %s ret %d"
+cephfs_fsync_return(int fd, int datasync, int ret) "fd %d datasync %d ret %d"
+cephfs_lgetxattr_return(char *path, const char *name, int ret) "path %s name %s ret %d"
+cephfs_llistxattr_return(char *path, int ret) "path %s ret %d"
+cephfs_lsetxattr_return(char *path, const char *name, int flags, int ret) "path %s name %s flags %d ret %d"
+cephfs_lremovexattr_return(char *path, const char *name, int ret) "path %s name %s ret %d"
+cephfs_renameat_return(const char *oldname, const char *newname, int ret) "oldname %s newname %s ret %d"
+cephfs_unlinkat_return(char *path, int stmode, int ret) "path %s stmode %d ret %d"
+cephfs_init(char *path) "path %s"
+
 # target-sparc/mmu_helper.c
 mmu_helper_dfault(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DFAULT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"
 mmu_helper_dprot(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DPROT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"
-- 
2.3.2 (Apple Git-55)

