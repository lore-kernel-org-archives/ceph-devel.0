From: Jevon Qiao <scaleqiao@gmail.com>
Subject: [PATCH] add CephFS support in VirtFS
Date: Sun, 14 Feb 2016 13:06:40 +0800
Message-ID: <56C00B60.6000502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, qemu-devel@nongnu.org
Cc: haomaiwang@gmail.com, mst@redhat.com, aneesh.kumar@linux.vnet.ibm.com, Sage Weil <sage@newdream.net>, gfarnum@redhat.com, gkurz@linux.vnet.ibm.com
List-Id: ceph-devel.vger.kernel.org

The following patch made over v2.5.50 of the upstream Qemu aims to add
functionality needed to support CephFS in VirtFS, which enables VirtFS 
to talk
directly with CephFS via libcephfs.

This patch provides a switch in the configure script of Qemu to allow 
users to
turn on CephFS support on demand, which means it is turned off by default.

This patch implements all interfaces needed by VirtFS except for the three
security models, I'll implement it later.

The patch can also be found here:
https://github.com/JevonQ/qemu/commit/506d25adc3c501a951f73b314414897279420657

Thanks,
Jevon

From: Jevon Qiao <scaleqiao@gmail.com>
Date: Sun, 10 Jan 2016 13:52:29 +0800
Subject: [PATCH] add CephFS support in VirtFS

Ceph as a promising unified distributed storage system is widely used in the
world of OpenStack. OpenStack users deploying Ceph for block (Cinder) and
object (S3/Swift) are unsurprisingly looking at Manila and CephFS to 
round out
a unified storage solution. Since the typical hypervisor people are using is
Qemu/KVM, it is necessary to provide a high performance, easy to use, file
system service in it. VirtFS aims to offers paravirtualized system 
services and
simple passthrough for directories from host to guest, which currently only
support local file system, this patch wants to add CephFS support in VirtFS.

Signed-off-by: Jevon Qiao <scaleqiao@gmail.com>
---
  configure                  |  34 +++
  fsdev/qemu-fsdev.c         |   1 +
  fsdev/qemu-fsdev.h         |   2 +
  hw/9pfs/Makefile.objs      |   3 +
  hw/9pfs/virtio-9p-cephfs.c | 748 
+++++++++++++++++++++++++++++++++++++++++++++
  hw/9pfs/virtio-9p.c        |  19 +-
  6 files changed, 804 insertions(+), 3 deletions(-)
  create mode 100644 hw/9pfs/virtio-9p-cephfs.c

diff --git a/configure b/configure
index 83b40fc..cecece7 100755
--- a/configure
+++ b/configure
@@ -306,6 +306,7 @@ trace_backends="nop"
  trace_file="trace"
  spice=""
  rbd=""
+cephfs=""
  smartcard=""
  libusb=""
  usb_redir=""
@@ -1046,6 +1047,10 @@ for opt do
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
@@ -1372,6 +1377,7 @@ disabled with --disable-FEATURE, default is 
enabled if available:
    vhost-net       vhost-net acceleration support
    spice           spice
    rbd             rados block device (rbd)
+  cephfs      Ceph File System
    libiscsi        iscsi support
    libnfs          nfs support
    smartcard       smartcard support (libcacard)
@@ -3166,6 +3172,29 @@ EOF
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
+
+##########################################
  # libssh2 probe
  min_libssh2_version=1.2.8
  if test "$libssh2" != "no" ; then
@@ -4826,6 +4855,7 @@ else
  echo "spice support     $spice"
  fi
  echo "rbd support       $rbd"
+echo "cephfs support    $cephfs"
  echo "xfsctl support    $xfs"
  echo "smartcard support $smartcard"
  echo "libusb            $libusb"
@@ -5282,6 +5312,10 @@ if test "$rbd" = "yes" ; then
    echo "RBD_CFLAGS=$rbd_cflags" >> $config_host_mak
    echo "RBD_LIBS=$rbd_libs" >> $config_host_mak
  fi
+if test "$cephfs" = "yes" ; then
+  echo "COFIG_CEHFS=m" >> $config_host_mak
+  echo "CEHFS_LIBS=$cephfs_libs" >> $config_host_mak
+fi

  echo "CONFIG_COROUTINE_BACKEND=$coroutine" >> $config_host_mak
  if test "$coroutine_pool" = "yes" ; then
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index ccfec13..e7b1936 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -28,6 +28,7 @@ static FsDriverTable FsDrivers[] = {
  #endif
      { .name = "synth", .ops = &synth_ops},
      { .name = "proxy", .ops = &proxy_ops},
+    { .name = "cephfs", .ops = &cephfs_ops},
  };

  int qemu_fsdev_add(QemuOpts *opts)
diff --git a/fsdev/qemu-fsdev.h b/fsdev/qemu-fsdev.h
index 9fa45bf..80e88ff 100644
--- a/fsdev/qemu-fsdev.h
+++ b/fsdev/qemu-fsdev.h
@@ -22,6 +22,7 @@
   * fstype | ops
   * -----------------
   *  local | local_ops
+ *  cephfs| cephfs_ops
   *  .     |
   *  .     |
   *  .     |
@@ -45,4 +46,5 @@ extern FileOperations local_ops;
  extern FileOperations handle_ops;
  extern FileOperations synth_ops;
  extern FileOperations proxy_ops;
+extern FileOperations cephfs_ops;
  #endif
diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
index 1e9b595..7deb523 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -5,5 +5,8 @@ common-obj-y += virtio-9p-coth.o cofs.o codir.o cofile.o
  common-obj-y += coxattr.o virtio-9p-synth.o
  common-obj-$(CONFIG_OPEN_BY_HANDLE) +=  virtio-9p-handle.o
  common-obj-y += virtio-9p-proxy.o
+common-obj-y += virtio-9p-cephfs.o

  obj-y += virtio-9p-device.o
+
+virtio-9p-cephfs.o-libs         := $(CEHFS_LIBS)
diff --git a/hw/9pfs/virtio-9p-cephfs.c b/hw/9pfs/virtio-9p-cephfs.c
new file mode 100644
index 0000000..b9ece1a
--- /dev/null
+++ b/hw/9pfs/virtio-9p-cephfs.c
@@ -0,0 +1,748 @@
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
+#include "hw/virtio/virtio.h"
+#include "virtio-9p.h"
+#include "virtio-9p-xattr.h"
+#include <cephfs/libcephfs.h>
+#include <arpa/inet.h>
+#include <pwd.h>
+#include <grp.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include "qemu/xattr.h"
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
+#define LIBCEPHFS_VERSION(maj, min, extra) ((maj << 16) + (min << 8) + 
extra)
+#define LIBCEPHFS_VERSION_CODE LIBCEPHFS_VERSION(0, 0, 0)
+#endif
+
+/*
+ * control the debug log
+ */
+#ifdef DEBUG_CEPHFS
+#define D_CEPHFS(s) fprintf(stderr, "CEPHFS_DEBUG: entering %s\n", s)
+#else
+#define D_CEPHFS(s)
+#endif
+
+struct cephfs_data {
+    int    major, minor, patch;
+    char ceph_version[CEPH_VER_LEN];
+    struct  ceph_mount_info *cmount;
+};
+
+/*
+ * Helper function for cephfs_preadv and cephfs_pwritev
+ */
+inline static ssize_t preadv_pwritev(struct ceph_mount_info *cmount, 
int fd,
+                              const struct iovec *iov, int iov_cnt,
+                              off_t offset, bool do_write)
+{
+    ssize_t ret = 0;
+    int i = 0;
+    size_t len = 0;
+    void *buf, *buftmp;
+    size_t bufoffset = 0;
+
+    for (; i < iov_cnt; i++) {
+        len += iov[i].iov_len;
+    }
+
+    buf = malloc(len);
+    if (buf == NULL) {
+        errno = ENOMEM;
+        return -1;
+    }
+
+    i = 0;
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
+                memcpy(iov[i].iov_base, (buftmp + bufoffset), 
iov[i].iov_len);
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
+                   const char *name, FsCred *credp)
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
+    D_CEPHFS("cephfs_lstat");
+    int ret;
+    char *path = fs_path->data;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
+
+    ret = ceph_lstat(cfsdata->cmount, path, stbuf);
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
+    D_CEPHFS("cephfs_readlink");
+    int ret;
+    char *path = fs_path->data;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
+
+    ret = ceph_readlink(cfsdata->cmount, path, buf, bufsz);
+    return ret;
+}
+
+static int cephfs_close(FsContext *ctx, V9fsFidOpenState *fs)
+{
+    D_CEPHFS("cephfs_close");
+    struct cephfs_data *cfsdata = (struct cephfs_data*)ctx->private;
+
+    return ceph_close(cfsdata->cmount, fs->fd);
+}
+
+static int cephfs_closedir(FsContext *ctx, V9fsFidOpenState *fs)
+{
+    D_CEPHFS("cephfs_closedir");
+    struct cephfs_data *cfsdata = (struct cephfs_data*)ctx->private;
+
+    return ceph_closedir(cfsdata->cmount, (struct ceph_dir_result 
*)fs->dir);
+}
+
+static int cephfs_open(FsContext *ctx, V9fsPath *fs_path,
+                       int flags, V9fsFidOpenState *fs)
+{
+    D_CEPHFS("cephfs_open");
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    fs->fd = ceph_open(cfsdata->cmount, fs_path->data, flags, 0777);
+    return fs->fd;
+}
+
+static int cephfs_opendir(FsContext *ctx,
+                          V9fsPath *fs_path, V9fsFidOpenState *fs)
+{
+    D_CEPHFS("cephfs_opendir");
+    int ret;
+    //char buffer[PATH_MAX];
+    struct ceph_dir_result *result;
+    struct cephfs_data *cfsdata = (struct cephfs_data*)ctx->private;
+    char *path = fs_path->data;
+
+    ret = ceph_opendir(cfsdata->cmount, path, &result);
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
+    D_CEPHFS("cephfs_rewinddir");
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    return ceph_rewinddir(cfsdata->cmount, (struct ceph_dir_result 
*)fs->dir);
+}
+
+static off_t cephfs_telldir(FsContext *ctx, V9fsFidOpenState *fs)
+{
+    D_CEPHFS("cephfs_telldir");
+    int ret;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    ret = ceph_telldir(cfsdata->cmount, (struct ceph_dir_result *)fs->dir);
+    return ret;
+}
+
+static int cephfs_readdir_r(FsContext *ctx, V9fsFidOpenState *fs,
+                            struct dirent *entry,
+                            struct dirent **result)
+{
+    D_CEPHFS("cephfs_readdir_r");
+    int ret;
+    struct dirent *tmpent;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    tmpent = entry;
+    ret = ceph_readdir_r(cfsdata->cmount, (struct ceph_dir_result 
*)fs->dir,
+                entry);
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
+    D_CEPHFS("cephfs_seekdir");
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    return ceph_seekdir(cfsdata->cmount, (struct 
ceph_dir_result*)fs->dir, off);
+}
+
+static ssize_t cephfs_preadv(FsContext *ctx, V9fsFidOpenState *fs,
+                             const struct iovec *iov,
+                             int iovcnt, off_t offset)
+{
+    D_CEPHFS("cephfs_preadv");
+    ssize_t ret = 0;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+#if defined(LIBCEPHFS_VERSION) && LIBCEPHFS_VERSION_CODE >= 
LIBCEPHFS_VERSION(9,
+    0, 3)
+    ret = ceph_preadv(cfsdata->cmount, fs->fd, iov, iovcnt, offset);
+#else
+    if (iovcnt > 1) {
+    ret = preadv_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offset, 0);
+    } else if (iovcnt > 0) {
+    ret = ceph_read(cfsdata->cmount, fs->fd, iov[0].iov_base,
+            iov[0].iov_len, offset);
+    }
+#endif
+
+    return ret;
+}
+
+static ssize_t cephfs_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
+                              const struct iovec *iov,
+                              int iovcnt, off_t offset)
+{
+    D_CEPHFS("cephfs_pwritev");
+    ssize_t ret = 0;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+#if defined(LIBCEPHFS_VERSION) && LIBCEPHFS_VERSION_CODE >= 
LIBCEPHFS_VERSION(9,
+    0, 3)
+    ret = ceph_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offset);
+#else
+    if (iovcnt > 1) {
+    ret = preadv_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offset, 1);
+    } else if (iovcnt > 0) {
+    ret = ceph_write(cfsdata->cmount, fs->fd, iov[0].iov_base,
+            iov[0].iov_len, offset);
+    }
+#endif
+
+#ifdef CONFIG_SYNC_FILE_RANGE
+    if (ret > 0 && ctx->export_flags & V9FS_IMMEDIATE_WRITEOUT) {
+        /*
+         * Initiate a writeback. This is not a data integrity sync.
+         * We want to ensure that we don't leave dirty pages in the cache
+         * after write when writeout=immediate is sepcified.
+         */
+        sync_file_range(fs->fd, offset, ret,
+                        SYNC_FILE_RANGE_WAIT_BEFORE | 
SYNC_FILE_RANGE_WRITE);
+    }
+#endif
+    return ret;
+}
+
+static int cephfs_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred 
*credp)
+{
+    D_CEPHFS("cephfs_chmod");
+    int  ret = -1;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
+
+    ret = ceph_chmod(cfsdata->cmount, fs_path->data, credp->fc_mode);
+    return ret;
+}
+
+static int cephfs_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
+                       const char *name, FsCred *credp)
+{
+    D_CEPHFS("cephfs_mknod");
+    int ret;
+    V9fsString fullname;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    ret = ceph_mknod(cfsdata->cmount, fullname.data, credp->fc_mode,
+            credp->fc_rdev);
+
+    v9fs_string_free(&fullname);
+    return ret;
+}
+
+static int cephfs_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
+                       const char *name, FsCred *credp)
+{
+    D_CEPHFS("cephfs_mkdir");
+    int ret;
+    V9fsString fullname;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    ret = ceph_mkdir(cfsdata->cmount, fullname.data, credp->fc_mode);
+
+    v9fs_string_free(&fullname);
+    return ret;
+}
+
+static int cephfs_fstat(FsContext *fs_ctx, int fid_type,
+                        V9fsFidOpenState *fs, struct stat *stbuf)
+{
+    D_CEPHFS("cephfs_fstat");
+    int fd = -1;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
+
+    if (fid_type == P9_FID_DIR) {
+        fd = dirfd(fs->dir);
+    } else {
+        fd = fs->fd;
+    }
+    return ceph_fstat(cfsdata->cmount, fd, stbuf);
+}
+
+static int cephfs_open2(FsContext *fs_ctx, V9fsPath *dir_path, const 
char *name,
+                        int flags, FsCred *credp, V9fsFidOpenState *fs)
+{
+    D_CEPHFS("cephfs_open2");
+    int fd = -1, ret = -1;
+    V9fsString fullname;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    fd = ceph_open(cfsdata->cmount, fullname.data, flags, credp->fc_mode);
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
+                          V9fsPath *dir_path, const char *name, FsCred 
*credp)
+{
+    D_CEPHFS("cephfs_symlink");
+    int ret = -1;
+    V9fsString fullname;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    ret = ceph_symlink(cfsdata->cmount, oldpath, fullname.data);
+
+    v9fs_string_free(&fullname);
+    return ret;
+}
+
+static int cephfs_link(FsContext *ctx, V9fsPath *oldpath,
+                       V9fsPath *dirpath, const char *name)
+{
+    D_CEPHFS("cephfs_link");
+    int ret = -1;
+    V9fsString newpath;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    v9fs_string_init(&newpath);
+    v9fs_string_sprintf(&newpath, "%s/%s", dirpath->data, name);
+    ret = ceph_link(cfsdata->cmount, oldpath->data, newpath.data);
+
+    v9fs_string_free(&newpath);
+    return ret;
+}
+
+static int cephfs_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
+{
+    D_CEPHFS("cephfs_truncate");
+    int ret = -1;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    ret = ceph_truncate(cfsdata->cmount, fs_path->data, size);
+
+    return ret;
+}
+
+static int cephfs_rename(FsContext *ctx, const char *oldpath,
+                         const char *newpath)
+{
+    D_CEPHFS("cephfs_rename");
+    int ret = -1;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    ret = ceph_rename(cfsdata->cmount, oldpath, newpath);
+    return ret;
+}
+
+static int cephfs_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred 
*credp)
+{
+    D_CEPHFS("cephfs_chown");
+    int ret = -1;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)fs_ctx->private;
+
+    ret = ceph_chown(cfsdata->cmount, fs_path->data, credp->fc_uid,
+            credp->fc_gid);
+    return ret;
+}
+
+static int cephfs_utimensat(FsContext *ctx, V9fsPath *fs_path,
+                            const struct timespec *buf)
+{
+    D_CEPHFS("cephfs_utimensat");
+    int ret = -1;
+
+#ifdef CONFIG_UTIMENSAT
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    ret = ceph_utime(cfsdata->cmount, fs_path->data, (struct utimbuf 
*)buf);
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
+    D_CEPHFS("cephfs_remove");
+    errno = EOPNOTSUPP;
+    return -1;
+}
+
+static int cephfs_fsync(FsContext *ctx, int fid_type,
+                        V9fsFidOpenState *fs, int datasync)
+{
+    D_CEPHFS("cephfs_fsync");
+    int ret = -1, fd = -1;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    if (fid_type == P9_FID_DIR) {
+        fd = dirfd(fs->dir);
+    } else {
+        fd = fs->fd;
+    }
+
+    ret = ceph_fsync(cfsdata->cmount, fd, datasync);
+    return ret;
+}
+
+static int cephfs_statfs(FsContext *ctx, V9fsPath *fs_path,
+                         struct statfs *stbuf)
+{
+    D_CEPHFS("cephfs_statfs");
+    int ret;
+    char *path = fs_path->data;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
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
+ * Get the extended attribute of normal file, if the path refer to a 
symbolic
+ * link, just return the extended attributes of the syslink rather than the
+ * attributes of the link itself.
+ */
+static ssize_t cephfs_lgetxattr(FsContext *ctx, V9fsPath *fs_path,
+                                const char *name, void *value, size_t size)
+{
+    D_CEPHFS("cephfs_lgetxattr");
+    int ret;
+    char *path = fs_path->data;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    ret = ceph_lgetxattr(cfsdata->cmount, path, name, value, size);
+    return ret;
+}
+
+static ssize_t cephfs_llistxattr(FsContext *ctx, V9fsPath *fs_path,
+                                 void *value, size_t size)
+{
+    D_CEPHFS("cephfs_llistxattr");
+    int ret = -1;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    ret = ceph_llistxattr(cfsdata->cmount, fs_path->data, value, size);
+    return ret;
+}
+
+static int cephfs_lsetxattr(FsContext *ctx, V9fsPath *fs_path, const 
char *name,
+                            void *value, size_t size, int flags)
+{
+    D_CEPHFS("cephfs_lsetxattr");
+    int ret = -1;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    ret = ceph_lsetxattr(cfsdata->cmount, fs_path->data, name, value, size,
+    flags);
+    return ret;
+}
+
+static int cephfs_lremovexattr(FsContext *ctx, V9fsPath *fs_path,
+                               const char *name)
+{
+    D_CEPHFS("cephfs_lremovexattr");
+    int ret = -1;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    ret = ceph_lremovexattr(cfsdata->cmount, fs_path->data, name);
+    return ret;
+}
+
+static int cephfs_name_to_path(FsContext *ctx, V9fsPath *dir_path,
+                              const char *name, V9fsPath *target)
+{
+    D_CEPHFS("cephfs_name_to_path");
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
+    D_CEPHFS("cephfs_renameat");
+    int ret = -1;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
+
+    ret = ceph_rename(cfsdata->cmount, old_name, new_name);
+    return ret;
+}
+
+static int cephfs_unlinkat(FsContext *ctx, V9fsPath *dir,
+                           const char *name, int flags)
+{
+    D_CEPHFS("cephfs_unlinkat");
+    int ret = 0;
+    char *path = dir->data;
+    struct stat fstat;
+    V9fsString fullname;
+    struct cephfs_data *cfsdata = (struct cephfs_data *)ctx->private;
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
+    D_CEPHFS("cephfs_init");
+    int ret;
+    const char *ver = NULL;
+    struct cephfs_data *data = g_malloc(sizeof(struct cephfs_data));
+
+    if (data == NULL) {
+    errno = ENOMEM;
+    return -1;
+    }
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
+    /* CephFS does not support FS_IOC_GETVERSIO */
+    ctx->exops.get_st_gen = NULL;
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
+        "cephfs fsdriver\n");
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
diff --git a/hw/9pfs/virtio-9p.c b/hw/9pfs/virtio-9p.c
index f972731..385c01d 100644
--- a/hw/9pfs/virtio-9p.c
+++ b/hw/9pfs/virtio-9p.c
@@ -1326,7 +1326,7 @@ out_nofid:
  static int32_t get_iounit(V9fsPDU *pdu, V9fsPath *path)
  {
      struct statfs stbuf;
-    int32_t iounit = 0;
+    int32_t iounit = 0, unit = 0;
      V9fsState *s = pdu->s;

      /*
@@ -1334,8 +1334,21 @@ static int32_t get_iounit(V9fsPDU *pdu, V9fsPath 
*path)
       * and as well as less than (client msize - P9_IOHDRSZ))
       */
      if (!v9fs_co_statfs(pdu, path, &stbuf)) {
-        iounit = stbuf.f_bsize;
-        iounit *= (s->msize - P9_IOHDRSZ)/stbuf.f_bsize;
+    /*
+     * If host filesystem block size is larger than client msize,
+     * we will use AGESIZE as the unit. The reason why we choose
+     * AGESIZE is because the data will be splitted in terms of
+     * AGESIZE in the virtio layer. In this case, the final
+     * iounit is equal to the value of ((msize/unit) - 1) * unit.
+     */
+    if (stbuf.f_bsize > s->msize) {
+        iounit = 4096;
+        unit = 4096;
+    } else {
+            iounit = stbuf.f_bsize;
+        unit = stbuf.f_bsize;
+    }
+        iounit *= (s->msize - P9_IOHDRSZ)/unit;
      }
      if (!iounit) {
          iounit = s->msize - P9_IOHDRSZ;
--
