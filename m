From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH] hw/9pfs: Add CephFS support in VirtFS
Date: Thu, 7 Apr 2016 17:50:30 +0200
Message-ID: <20160407175030.5b6f2edb@bahia.huguette.org>
References: <1457971368-1335-1-git-send-email-scaleqiao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from e06smtp09.uk.ibm.com ([195.75.94.105]:43723 "EHLO
	e06smtp09.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbcDGPun (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 11:50:43 -0400
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <ceph-devel@vger.kernel.org> from <gkurz@linux.vnet.ibm.com>;
	Thu, 7 Apr 2016 16:50:41 +0100
In-Reply-To: <1457971368-1335-1-git-send-email-scaleqiao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>
Cc: berrange@redhat.com, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, sage@newdream.net, gfarnum@redhat.com, haomaiwang@gmail.com

On Tue, 15 Mar 2016 00:02:48 +0800
Jevon Qiao <scaleqiao@gmail.com> wrote:

> Ceph as a promising unified distributed storage system is widely used in the
> world of OpenStack. OpenStack users deploying Ceph for block (Cinder) and
> object (S3/Swift) are unsurprisingly looking at Manila and CephFS to round out
> a unified storage solution. Since the typical hypervisor people are using is
> Qemu/KVM, it is necessary to provide a high performance, easy to use, file
> system service in it. VirtFS aims to offers paravirtualized system services and
> simple passthrough for directories from host to guest, which currently only
> support local file system, this patch wants to add CephFS support in VirtFS.
> 
> Signed-off-by: Jevon Qiao <scaleqiao@gmail.com>
> ---

Jevon,

There's still work to be done on this patch.

One general remark is that there are far too many traces: it obfuscates the code
and does not bring much benefit in my opinion. If you look at the other fsdev
drivers, you see they don't do traces at all !

Also, I've found several errors where the code simply cannot work... please run
a file/io oriented testsuite in the guest to check all the fsdev operations are
working as expected... maybe some tests from LTP ?

Don't forget to list all the changes when you post your v3.

You'll find detailed comments below.

Cheers.

--
Greg

>  configure                         |  33 ++
>  fsdev/qemu-fsdev.c                |   1 +
>  fsdev/qemu-fsdev.h                |   3 +-
>  hw/9pfs/9p-cephfs.c               | 836 ++++++++++++++++++++++++++++++++++++++
>  hw/9pfs/Makefile.objs             |   3 +
>  scripts/analyse-9p-simpletrace.py | 213 ----------
>  scripts/analyze-9p-simpletrace.py | 306 ++++++++++++++

Hmm... even though 'analyze' is the preferred spelling in the QEMU code,
'analyse' is correct. I don't think it is useful to rename a script
that's been around since 2011... And even if it was, I'd prefer it to
be done in a separate patch, because it just makes review more difficult
here...

>  trace-events                      |  33 ++
>  8 files changed, 1214 insertions(+), 214 deletions(-)
>  create mode 100644 hw/9pfs/9p-cephfs.c
>  delete mode 100755 scripts/analyse-9p-simpletrace.py
>  create mode 100755 scripts/analyze-9p-simpletrace.py
> 
> diff --git a/configure b/configure
> index 0c0472a..c48f1af 100755
> --- a/configure
> +++ b/configure
> @@ -275,6 +275,7 @@ trace_backends="log"
>  trace_file="trace"
>  spice=""
>  rbd=""
> +cephfs=""
>  smartcard=""
>  libusb=""
>  usb_redir=""
> @@ -1019,6 +1020,10 @@ for opt do
>    ;;
>    --enable-rbd) rbd="yes"
>    ;;
> +  --disable-cephfs) cephfs="no"
> +  ;;
> +  --enable-cephfs) cephfs="yes"
> +  ;;
>    --disable-xfsctl) xfs="no"
>    ;;
>    --enable-xfsctl) xfs="yes"
> @@ -1345,6 +1350,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    vhost-net       vhost-net acceleration support
>    spice           spice
>    rbd             rados block device (rbd)
> +  cephfs          Ceph File System
>    libiscsi        iscsi support
>    libnfs          nfs support
>    smartcard       smartcard support (libcacard)
> @@ -3087,6 +3093,28 @@ EOF
>  fi
> 
>  ##########################################
> +# cephfs probe
> +if test "$cephfs" != "no" ; then
> +  cat > $TMPC <<EOF
> +#include <stdio.h>
> +#include <cephfs/libcephfs.h>
> +int main(void) {
> +    struct ceph_mount_info *cmount;
> +    ceph_create(&cmount, NULL);
> +    return 0;
> +}
> +EOF
> +  cephfs_libs="-lcephfs"
> +  if compile_prog "" "$cephfs_libs" ; then
> +    cephfs=yes
> +  else
> +    if test "$cephfs" = "yes" ; then
> +      feature_not_found "cephfs" "Install libcephfs/ceph devel"
> +    fi
> +    cephfs=no
> +  fi
> +fi
> +##########################################
>  # libssh2 probe
>  min_libssh2_version=1.2.8
>  if test "$libssh2" != "no" ; then
> @@ -4760,6 +4788,7 @@ else
>  echo "spice support     $spice"
>  fi
>  echo "rbd support       $rbd"
> +echo "cephfs support    $cephfs"
>  echo "xfsctl support    $xfs"
>  echo "smartcard support $smartcard"
>  echo "libusb            $libusb"
> @@ -5224,6 +5253,10 @@ if test "$rbd" = "yes" ; then
>    echo "RBD_CFLAGS=$rbd_cflags" >> $config_host_mak
>    echo "RBD_LIBS=$rbd_libs" >> $config_host_mak
>  fi
> +if test "$cephfs" = "yes" ; then
> +  echo "CONFIG_CEPHFS=m" >> $config_host_mak
> +  echo "CEPHFS_LIBS=$cephfs_libs" >> $config_host_mak
> +fi
> 
>  echo "CONFIG_COROUTINE_BACKEND=$coroutine" >> $config_host_mak
>  if test "$coroutine_pool" = "yes" ; then
> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> index bf7f0b0..7f07a2a 100644
> --- a/fsdev/qemu-fsdev.c
> +++ b/fsdev/qemu-fsdev.c
> @@ -27,6 +27,7 @@ static FsDriverTable FsDrivers[] = {
>  #endif
>      { .name = "synth", .ops = &synth_ops},
>      { .name = "proxy", .ops = &proxy_ops},
> +    { .name = "cephfs", .ops = &cephfs_ops},
>  };
> 
>  int qemu_fsdev_add(QemuOpts *opts)
> diff --git a/fsdev/qemu-fsdev.h b/fsdev/qemu-fsdev.h
> index 9fa45bf..86a17b8 100644
> --- a/fsdev/qemu-fsdev.h
> +++ b/fsdev/qemu-fsdev.h
> @@ -22,7 +22,7 @@
>   * fstype | ops
>   * -----------------
>   *  local | local_ops
> - *  .     |
> + *  cephfs| cephfs_ops
>   *  .     |
>   *  .     |
>   *  .     |
> @@ -45,4 +45,5 @@ extern FileOperations local_ops;
>  extern FileOperations handle_ops;
>  extern FileOperations synth_ops;
>  extern FileOperations proxy_ops;
> +extern FileOperations cephfs_ops;
>  #endif
> diff --git a/hw/9pfs/9p-cephfs.c b/hw/9pfs/9p-cephfs.c
> new file mode 100644
> index 0000000..e2d659d
> --- /dev/null
> +++ b/hw/9pfs/9p-cephfs.c
> @@ -0,0 +1,836 @@
> +/*
> + * 9p cephfs callback
> + *
> + * Copyright UnitedStack, Corp. 2016
> + *
> + * Authors:
> + *    Jevon Qiao <scaleqiao@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *

 * This work is licensed under the terms of the GNU GPL, version 2 or later.
 * See the COPYING file in the top-level directory.

as suggested by Michael during the previous round.

> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/iov.h"
> +#include "9p.h"
> +#include "9p-xattr.h"
> +#include "trace.h"
> +#include <cephfs/libcephfs.h>
> +#include "fsdev/qemu-fsdev.h"   /* cephfs_ops */
> +#include <arpa/inet.h>
> +#include <pwd.h>
> +#include <grp.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include "qemu/xattr.h"
> +#include "qemu/error-report.h"
> +#include <libgen.h>
> +#include <unistd.h>
> +#include <linux/fs.h>
> +#ifdef CONFIG_LINUX_MAGIC_H
> +#include <linux/magic.h>
> +#endif
> +#include <sys/ioctl.h>
> +
> +#define CEPH_VER_LEN        32
> +#define MON_NAME_LEN        32
> +#define MON_SECRET_LEN      64
> +
> +#ifndef LIBCEPHFS_VERSION
> +#define LIBCEPHFS_VERSION(maj, min, extra) ((maj << 16) + (min << 8) + extra)
> +#define LIBCEPHFS_VERSION_CODE LIBCEPHFS_VERSION(0, 0, 0)
> +#endif
> +
> +#if defined(LIBCEPHFS_VERSION) && LIBCEPHFS_VERSION_CODE >= \
> +LIBCEPHFS_VERSION(10, 0, 2)
> +#define HAVE_CEPH_READV 1
> +#endif
> +
> +struct cephfs_data {
> +    int major, minor, patch;
> +    char ceph_version[CEPH_VER_LEN];

what's the use for ^^ ? There are no readers for this in your patch.

> +    struct  ceph_mount_info *cmount;
> +};
> +
> +static int cephfs_update_file_cred(struct ceph_mount_info *cmount,
> +                                   const char *name, FsCred *credp)
> +{
> +    int fd, ret;
> +    fd = ceph_open(cmount, name, O_NONBLOCK | O_NOFOLLOW, credp->fc_mode);
> +    if (fd < 0) {
> +        return fd;
> +    }
> +    ret = ceph_fchown(cmount, fd, credp->fc_uid, credp->fc_gid);
> +    if (ret < 0) {
> +        goto err_out;
> +    }
> +    ret = ceph_fchmod(cmount, fd, credp->fc_mode & 07777);
> +err_out:
> +    close(fd);

I guess it we must call ceph_close(fd) here.

> +    return ret;
> +}
> +
> +static int cephfs_lstat(FsContext *fs_ctx, V9fsPath *fs_path,
> +                        struct stat *stbuf)
> +{
> +    int ret;
> +    char *path = fs_path->data;
> +    struct cephfs_data *cfsdata = fs_ctx->private;
> +
> +    ret = ceph_lstat(cfsdata->cmount, path, stbuf);
> +    trace_cephfs_lstat_return(path, stbuf->st_mode, stbuf->st_uid,
> +                              stbuf->st_gid, stbuf->st_size, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static ssize_t cephfs_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
> +                               char *buf, size_t bufsz)
> +{
> +    int ret;
> +    char *path = fs_path->data;
> +    struct cephfs_data *cfsdata = fs_ctx->private;
> +
> +    ret = ceph_readlink(cfsdata->cmount, path, buf, bufsz);
> +    trace_cephfs_readlink_return(path, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;
> +}
> +
> +static int cephfs_close(FsContext *ctx, V9fsFidOpenState *fs)
> +{
> +    int ret;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_close(cfsdata->cmount, fs->fd);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static int cephfs_closedir(FsContext *ctx, V9fsFidOpenState *fs)
> +{
> +    int ret;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_closedir(cfsdata->cmount, (struct ceph_dir_result *)fs->dir);

I don't see any good reason to hijack fs->dir, which has DIR * type: please use
fs->private, which is void *, instead, and you won't need to cast.

> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static int cephfs_open(FsContext *ctx, V9fsPath *fs_path,
> +                       int flags, V9fsFidOpenState *fs)
> +{
> +    int ret;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_open(cfsdata->cmount, fs_path->data, flags, 0777);
> +    trace_cephfs_open_return(fs_path->data, flags, 0777, fs->fd);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    fs->fd = ret;
> +    return ret;
> +}
> +
> +static int cephfs_opendir(FsContext *ctx,
> +                          V9fsPath *fs_path, V9fsFidOpenState *fs)
> +{
> +    int ret;
> +    struct ceph_dir_result *result;
> +    struct cephfs_data *cfsdata = ctx->private;
> +    char *path = fs_path->data;
> +
> +    ret = ceph_opendir(cfsdata->cmount, path, &result);
> +    trace_cephfs_opendir_return(path, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        error_report("failed to open %s, %s", path, strerror(errno));
> +        return -1;
> +    }
> +    fs->dir = (DIR *)result;

    fs->private = result;

> +    return 0;
> +}
> +
> +static void cephfs_rewinddir(FsContext *ctx, V9fsFidOpenState *fs)
> +{
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    trace_cephfs_rewinddir(fs->dir);
> +    ceph_rewinddir(cfsdata->cmount, (struct ceph_dir_result *)fs->dir);

    fs->private = result;

> +}
> +
> +static off_t cephfs_telldir(FsContext *ctx, V9fsFidOpenState *fs)
> +{
> +    off_t ret;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    trace_cephfs_telldir(fs->dir);
> +    ret = ceph_telldir(cfsdata->cmount, (struct ceph_dir_result *)fs->dir);

    fs->private = result;

> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;
> +}
> +
> +static int cephfs_readdir_r(FsContext *ctx, V9fsFidOpenState *fs,
> +                            struct dirent *entry,
> +                            struct dirent **result)
> +{
> +    int ret;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_readdir_r(cfsdata->cmount, (struct ceph_dir_result *)fs->dir,

    fs->private = result;

> +                         entry);
> +    if (ret > 0) {
> +        *result = entry;
> +        return 0;
> +    } else if (ret == 0) {
> +        *result = NULL;
> +        return 0;
> +    }
> +    errno = -ret;

AFAIK the readdir_r(3) call in the C library does not set errno, nor do
the readdir_r op of the other fsdev drivers.

> +    return -ret;
> +}
> +
> +static void cephfs_seekdir(FsContext *ctx, V9fsFidOpenState *fs, off_t off)
> +{
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    trace_cephfs_seekdir(fs->dir, off);
> +    ceph_seekdir(cfsdata->cmount, (struct ceph_dir_result *)fs->dir, off);

    fs->private = result;

> +}
> +
> +#ifndef HAVE_CEPH_READV
> +static ssize_t ceph_preadv(struct ceph_mount_info *cmount, int fd,
> +                           const struct iovec *iov, int iov_cnt,
> +                           off_t offset)
> +{
> +    ssize_t ret;
> +    size_t i;
> +    size_t len, tmp;
> +    void *buf;
> +    size_t bufoffset = 0;
> +
> +    len = iov_size(iov, iov_cnt);
> +    buf = g_new0(uint8_t, len);
> +    ret = ceph_read(cmount, fd, buf, len, offset);
> +    if (ret < 0) {
> +        return ret;

buf is leaked.

> +    } else {
> +        tmp = ret;
> +        for (i = 0; (i < iov_cnt && tmp > 0); i++) {

tmp is <= to the sum of all iov_len: unless I miss something, it
isn't possible for i to reach iov_cnt. Also the parenthesis aren't
needed.

> +            if (tmp < iov[i].iov_len) {
> +                memcpy(iov[i].iov_base, (buf + bufoffset), tmp);
> +            } else {
> +                memcpy(iov[i].iov_base, (buf + bufoffset), iov[i].iov_len);
> +                bufoffset += iov[i].iov_len;
> +            }
> +            tmp -= iov[i].iov_len;
> +        }
> +    }
> +

Hmmm... this approach raises some issues:
- the extra copy is sub optimal
- allocation of the intermediate big buffer may fail and kill QEMU

I'd rather call directly ceph_read() from this loop instead.

> +    free(buf);
> +    return ret;
> +}
> +
> +static ssize_t ceph_pwritev(struct ceph_mount_info *cmount, int fd,
> +                            const struct iovec *iov, int iov_cnt,
> +                            off_t offset)
> +{
> +    ssize_t ret;
> +    size_t i;
> +    size_t len;
> +    void *buf;
> +    size_t bufoffset = 0;
> +
> +    len = iov_size(iov, iov_cnt);
> +    buf = g_new0(uint8_t, len);
> +    for (i = 0; i < iov_cnt; i++) {
> +        memcpy((buf + bufoffset), iov[i].iov_base, iov[i].iov_len);
> +        bufoffset += iov[i].iov_len;
> +    }
> +    ret = ceph_write(cmount, fd, buf, len, offset);
> +
> +    free(buf);
> +    return ret;

Same remark as for ceph_preadv(): drop the intermediate buffer and
call directly ceph_write() in a loop.

> +}
> +#endif
> +
> +static ssize_t cephfs_preadv(FsContext *ctx, V9fsFidOpenState *fs,
> +                             const struct iovec *iov,
> +                             int iovcnt, off_t offset)
> +{
> +    ssize_t ret = 0;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    trace_cephfs_preadv(iovcnt, iov_size(iov, iovcnt));
> +    if (iovcnt < 0) {
> +        errno = EINVAL;
> +        return -1;
> +    }

Please move this check to ceph_readv() where it belongs.

FYI the implementation in ceph:src/client/Client.cc does the check:

int Client::preadv(int fd, const struct iovec *iov, int iovcnt, loff_t offset)
{
  if (iovcnt < 0)
    return EINVAL;
  return _preadv_pwritev(fd, iov, iovcnt, offset, false);
}

> +    ret = ceph_preadv(cfsdata->cmount, fs->fd, iov, iovcnt, offset);
> +    trace_cephfs_preadv_return(iovcnt, iov_size(iov, iovcnt), ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;
> +}
> +
> +static ssize_t cephfs_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
> +                              const struct iovec *iov,
> +                              int iovcnt, off_t offset)
> +{
> +    ssize_t ret = 0;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    trace_cephfs_pwritev(iovcnt, iov_size(iov, iovcnt), offset);
> +    if (iovcnt < 0) {
> +        errno = EINVAL;
> +        return -1;
> +    }

Same as above, move this check to ceph_writev().

> +    ret = ceph_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offset);
> +    trace_cephfs_pwritev_return(iovcnt, iov_size(iov, iovcnt), offset, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +
> +#ifdef CONFIG_SYNC_FILE_RANGE
> +    if (ret > 0 && ctx->export_flags & V9FS_IMMEDIATE_WRITEOUT) {
> +        /*
> +         * Initiate a writeback. This is not a data integrity sync.
> +         * We want to ensure that we don't leave dirty pages in the cache
> +         * after write when writeout=immediate is sepcified.
> +         */
> +        sync_file_range(fs->fd, offset, ret,
> +                        SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE);

Does it make sense to use this API with a ceph originated fd ? Shouldn't we
use ceph_fsync() to ensure data is written to the storage ?

> +    }
> +#endif
> +    return ret;
> +}
> +
> +static int cephfs_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
> +{
> +    int  ret;
> +    struct cephfs_data *cfsdata = fs_ctx->private;
> +
> +    ret = ceph_chmod(cfsdata->cmount, fs_path->data, credp->fc_mode);
> +    trace_cephfs_chmod_return(fs_path->data, credp->fc_mode, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

Let's make it explicit:

       return 0;

> +}
> +
> +static int cephfs_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
> +                        const char *name, FsCred *credp)
> +{
> +    int ret;
> +    V9fsString fullname;
> +    struct cephfs_data *cfsdata = fs_ctx->private;
> +
> +    v9fs_string_init(&fullname);
> +    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
> +    ret = ceph_mknod(cfsdata->cmount, fullname.data, credp->fc_mode,
> +                     credp->fc_rdev);
> +    trace_cephfs_mknod_return(fullname.data, credp->fc_mode,
> +                              credp->fc_rdev, ret);
> +    v9fs_string_free(&fullname);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

       return 0;

> +}
> +
> +static int cephfs_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
> +                       const char *name, FsCred *credp)
> +{
> +    int ret;
> +    V9fsString fullname;
> +    struct cephfs_data *cfsdata = fs_ctx->private;
> +
> +    v9fs_string_init(&fullname);
> +    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
> +    ret = ceph_mkdir(cfsdata->cmount, fullname.data, credp->fc_mode);
> +    trace_cephfs_mkdir_return(fullname.data, credp->fc_mode, ret);
> +    v9fs_string_free(&fullname);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

       return 0;

> +}
> +
> +static int cephfs_fstat(FsContext *fs_ctx, int fid_type,
> +                        V9fsFidOpenState *fs, struct stat *stbuf)
> +{
> +    int fd;
> +    int ret;
> +    struct cephfs_data *cfsdata = fs_ctx->private;
> +
> +    if (fid_type == P9_FID_DIR) {
> +        fd = dirfd(fs->dir);

Unless I've missed something, cephfs_opendir() caches a pointer to an opaque
struct ceph_dir_result in the V9fsFidOpenState union. Calling dirfd() here
looks really wrong: you need an equivalent API in libcephfs.h but I could
not spot any...

I suggest you implement a ceph_dirfd() helper with ceph_readdirplus_r().

/**
 * A safe version of ceph_readdir that also returns the file statistics (readdir+stat).
 *
...

int ceph_readdirplus_r(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp, struct dirent *de,
		       struct stat *st, int *stmask);

and also use fs->private, so that in the end we have:

           fd = ceph_dirfd(fs->private);

> +    } else {
> +        fd = fs->fd;
> +    }
> +    ret = ceph_fstat(cfsdata->cmount, fd, stbuf);
> +    trace_cephfs_fstat_return(fid_type, fd, stbuf->st_uid, stbuf->st_gid,
> +                              stbuf->st_size, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

       return 0;

> +}
> +
> +static int cephfs_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
> +                        int flags, FsCred *credp, V9fsFidOpenState *fs)
> +{
> +    int fd, ret;
> +    V9fsString fullname;
> +    struct cephfs_data *cfsdata = fs_ctx->private;
> +
> +    v9fs_string_init(&fullname);
> +    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
> +    fd = ceph_open(cfsdata->cmount, fullname.data, flags, credp->fc_mode);
> +    trace_cephfs_open2_return(fullname.data, flags, credp->fc_mode);
> +    v9fs_string_free(&fullname);
> +    if (fd >= 0) {
> +        /* After creating the file, need to set the cred */
> +        ret = cephfs_update_file_cred(cfsdata->cmount, name, credp);

Shouldn't we pass fullname.data instead of name ?

If yes, then maybe we can even pass the fd and avoid an extra call
to ceph_open().

> +        if (ret < 0) {
> +            ceph_close(cfsdata->cmount, fd);
> +            errno = -ret;
> +            fd = -1;
> +        } else {
> +            fs->fd = fd;
> +        }
> +    } else {
> +       errno = -fd;
> +       return -1;
> +    }
> +
> +    return fd;
> +}

I'd prefer clearer paths:

    fd = ceph_open(...)
    v9fs_string_free(...);
    if (fd < 0) {
        errno = -fd;
        return -1;
    }

    ret = cephfs_update_file_cred(...);
    if (ret < 0) {
        ceph_close(...);
        errno = -ret;
        return -1
    }

    fs->fd = fd;
    return fd;

> +
> +static int cephfs_symlink(FsContext *fs_ctx, const char *oldpath,
> +                          V9fsPath *dir_path, const char *name, FsCred *credp)
> +{
> +    int ret;
> +    V9fsString fullname;
> +    struct cephfs_data *cfsdata = fs_ctx->private;
> +
> +    v9fs_string_init(&fullname);
> +    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
> +    ret = ceph_symlink(cfsdata->cmount, oldpath, fullname.data);
> +    trace_cephfs_symlink_return(oldpath, fullname.data, ret);
> +    v9fs_string_free(&fullname);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

       return 0;

> +}
> +
> +static int cephfs_link(FsContext *ctx, V9fsPath *oldpath,
> +                       V9fsPath *dirpath, const char *name)
> +{
> +    int ret;
> +    V9fsString newpath;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    v9fs_string_init(&newpath);
> +    v9fs_string_sprintf(&newpath, "%s/%s", dirpath->data, name);
> +    ret = ceph_link(cfsdata->cmount, oldpath->data, newpath.data);
> +    trace_cephfs_link_return(oldpath->data, newpath.data, ret);
> +    v9fs_string_free(&newpath);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

       return 0;

> +}
> +
> +static int cephfs_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
> +{
> +    int ret;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_truncate(cfsdata->cmount, fs_path->data, size);
> +    trace_cephfs_truncate_return(fs_path->data, size, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;
> +}
> +
> +static int cephfs_rename(FsContext *ctx, const char *oldpath,
> +                         const char *newpath)
> +{
> +    int ret;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_rename(cfsdata->cmount, oldpath, newpath);
> +    trace_cephfs_rename_return(oldpath, newpath, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

       return 0;

> +}
> +
> +static int cephfs_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
> +{
> +    int ret;
> +    struct cephfs_data *cfsdata = fs_ctx->private;
> +
> +    ret = ceph_chown(cfsdata->cmount, fs_path->data, credp->fc_uid,
> +                     credp->fc_gid);
> +    trace_cephfs_chown_return(fs_path->data, credp->fc_uid, credp->fc_gid, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

       return 0;

> +}
> +
> +static int cephfs_utimensat(FsContext *ctx, V9fsPath *fs_path,
> +                            const struct timespec *buf)
> +{
> +    int ret;
> +
> +#ifdef CONFIG_UTIMENSAT

CONFIG_UTIMENSAT only indicates that QEMU can call the utimensat() syscall,
which isn't the case here obviously.

> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_utime(cfsdata->cmount, fs_path->data, (struct utimbuf *)buf);

Ouch... struct utimbuf is indeed the right API for ceph_utime() but the current
function follows the utimensat() API which is quite different.

You cannot blindly cast here... you need to implement utimensat() semantics using
ceph_utime().

> +    trace_cephfs_utimensat_return(fs_path->data, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +#else
> +    ret = -1;
> +    errno = ENOSYS;
> +#endif
> +
> +    return ret;

       return 0;

> +}
> +
> +static int cephfs_remove(FsContext *ctx, const char *path)
> +{
> +    errno = EOPNOTSUPP;
> +    return -1;

I see libcephfs has ceph_rmdir() and ceph_unlink(), which is all
you need to implement the remove(3) API.

> +}
> +
> +static int cephfs_fsync(FsContext *ctx, int fid_type,
> +                        V9fsFidOpenState *fs, int datasync)
> +{
> +    int ret, fd;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    if (fid_type == P9_FID_DIR) {
> +        fd = dirfd(fs->dir);

           fd = ceph_dirfd(fs->private);

> +    } else {
> +        fd = fs->fd;
> +    }
> +    ret = ceph_fsync(cfsdata->cmount, fd, datasync);
> +    trace_cephfs_fsync_return(fd, datasync, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

       return 0;

> +}
> +
> +static int cephfs_statfs(FsContext *ctx, V9fsPath *fs_path,
> +                         struct statfs *stbuf)
> +{
> +    int ret;
> +    char *path = fs_path->data;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_statfs(cfsdata->cmount, path, (struct statvfs *)stbuf);
> +    if (ret < 0) {
> +        error_report("cephfs_statfs failed for %s, %s", path, strerror(errno));
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

       return 0;

> +}
> +
> +/*
> + * Get the extended attribute of normal file, if the path refer to a symbolic
> + * link, just return the extended attributes of the syslink rather than the
> + * attributes of the link itself.
> + */
> +static ssize_t cephfs_lgetxattr(FsContext *ctx, V9fsPath *fs_path,
> +                                const char *name, void *value, size_t size)
> +{
> +    int ret;
> +    char *path = fs_path->data;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_lgetxattr(cfsdata->cmount, path, name, value, size);
> +    trace_cephfs_lgetxattr_return(path, name, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;
> +}
> +
> +static ssize_t cephfs_llistxattr(FsContext *ctx, V9fsPath *fs_path,
> +                                 void *value, size_t size)
> +{
> +    int ret;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_llistxattr(cfsdata->cmount, fs_path->data, value, size);
> +    trace_cephfs_llistxattr_return(fs_path->data, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;
> +}
> +
> +static int cephfs_lsetxattr(FsContext *ctx, V9fsPath *fs_path, const char *name,
> +                            void *value, size_t size, int flags)
> +{
> +    int ret;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_lsetxattr(cfsdata->cmount, fs_path->data, name, value, size,
> +                         flags);
> +    trace_cephfs_lsetxattr_return(fs_path->data, name, flags, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

       return 0;

> +}
> +
> +static int cephfs_lremovexattr(FsContext *ctx, V9fsPath *fs_path,
> +                               const char *name)
> +{
> +    int ret;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_lremovexattr(cfsdata->cmount, fs_path->data, name);
> +    trace_cephfs_lremovexattr_return(fs_path->data, name, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

       return 0;

> +}
> +
> +static int cephfs_name_to_path(FsContext *ctx, V9fsPath *dir_path,
> +                              const char *name, V9fsPath *target)
> +{
> +    if (dir_path) {
> +        v9fs_string_sprintf((V9fsString *)target, "%s/%s",
> +                            dir_path->data, name);
> +    } else {
> +        /* if the path does not start from '/' */
> +        v9fs_string_sprintf((V9fsString *)target, "%s", name);
> +    }
> +
> +    /* Bump the size for including terminating NULL */
> +    target->size++;
> +    return 0;
> +}
> +
> +static int cephfs_renameat(FsContext *ctx, V9fsPath *olddir,
> +                           const char *old_name, V9fsPath *newdir,
> +                           const char *new_name)
> +{
> +    int ret = -1;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    ret = ceph_rename(cfsdata->cmount, old_name, new_name);
> +    trace_cephfs_renameat_return(old_name, new_name, ret);
> +    if (ret < 0) {
> +        errno = -ret;
> +        return -1;
> +    }
> +    return ret;

       return 0;

> +}
> +
> +static int cephfs_unlinkat(FsContext *ctx, V9fsPath *dir,
> +                           const char *name, int flags)
> +{
> +    int ret = 0;
> +    char *path = dir->data;

No need to initialize ret and path since they are being assigned
a value a few lines below.

> +    struct stat fstat;
> +    V9fsString fullname;
> +    struct cephfs_data *cfsdata = ctx->private;
> +
> +    v9fs_string_init(&fullname);
> +    v9fs_string_sprintf(&fullname, "%s/%s", dir->data, name);
> +    path = fullname.data;
> +    /* determine which kind of file is being destroyed */
> +    ret = ceph_lstat(cfsdata->cmount, path, &fstat);
> +    if (!ret) {

I'd prefer you handle the error case first.

> +        switch (fstat.st_mode & S_IFMT) {
> +        case S_IFDIR:
> +            ret = ceph_rmdir(cfsdata->cmount, path);
> +            break;
> +
> +        case S_IFBLK:
> +        case S_IFCHR:
> +        case S_IFIFO:
> +        case S_IFLNK:
> +        case S_IFREG:
> +        case S_IFSOCK:
> +            ret = ceph_unlink(cfsdata->cmount, path);
> +            break;
> +
> +        default:
> +            error_report("ceph_lstat unknown stmode %s, %s", path,
> +                         strerror(errno));
> +            break;

I don't believe this can happen... and if it does, we should probably abort
or at least return an error.

You can make it as simple as:

    if (fstat.st_mode & S_IFMT == S_IFDIR) {
        ret = ceph_rmdir(cfsdata->cmount, path);
    } else {
        ret = ceph_unlink(cfsdata->cmount, path);
    }

BTW, this looks like the implementation of ceph_remove() :)

> +        }
> +        if (ret < 0) {
> +            errno = -ret;
> +            ret = -1;
> +        }



> +    } else {
> +        errno = -ret;
> +        ret = -1;
> +    }
> +    trace_cephfs_unlinkat_return(path, fstat.st_mode, ret);
> +
> +    v9fs_string_free(&fullname);
> +    return ret;
> +}
> +
> +/*
> + * Do two things in the init function:
> + * 1) Create a mount handle used by all cephfs interfaces.
> + * 2) Invoke ceph_mount() to initialize a link between the client and
> + * ceph monitor
> + */
> +static int cephfs_init(FsContext *ctx)
> +{
> +    int ret;
> +    const char *ver = NULL;
> +    struct cephfs_data *data = g_malloc(sizeof(struct cephfs_data));
> +
> +    if (data == NULL) {
> +        errno = ENOMEM;
> +        return -1;
> +    }

g_malloc() aborts the application if it cannot allocate the requested memory.

https://developer.gnome.org/glib/unstable/glib-Memory-Allocation.html#glib-Memory-Allocation.description

> +    trace_cephfs_init(ctx->fs_root);
> +    memset(data, 0, sizeof(struct cephfs_data));

If you want zeroed memory, call g_malloc0() then.

> +    ret = ceph_create(&data->cmount, NULL);
> +    if (ret < 0) {
> +        errno = -ret;
> +        error_report("ceph_create failed %s", strerror(errno));
> +        goto err_out;
> +    }
> +
> +    ret = ceph_conf_read_file(data->cmount, NULL);
> +    if (ret) {
> +        errno = -ret;
> +        error_report("ceph_conf_read_file failed %s", strerror(errno));
> +        goto err_out;

I guess we need a rollback path for data->cmount as well.

        goto err_create;

> +    }
> +
> +    ret = ceph_mount(data->cmount, ctx->fs_root);
> +    if (ret) {
> +        errno = -ret;
> +        error_report("ceph_mount failed %s", strerror(errno));
> +        goto err_out;

        goto err_create;

> +    } else {

Since the if block ends with goto, the else construct is uneeded.

> +        ctx->private = data;
> +        /* CephFS does not support FS_IOC_GETVERSION */
> +        ctx->exops.get_st_gen = NULL;
> +        goto out;

This goto looks wrong and...

> +    }
> +
> +    ver = ceph_version(&data->major, &data->minor, &data->patch);
> +    memcpy(data->ceph_version, ver, strlen(ver) + 1);
> +

... prevents the above code to be reached.

This makes me think again that the versioning related bits in struct cephfs_data
are useless. I suggest you simply remove them.

We're on the success path here, so you just need:

    return 0;

err_create:
    ceph_release(data->cmount);

> +err_out:

Maybe just name it err.

> +    g_free(data);
> +out:

Uneeded out label.

> +    return ret;
> +}
> +
> +static int cephfs_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
> +{
> +    const char *sec_model = qemu_opt_get(opts, "security_model");
> +    const char *path = qemu_opt_get(opts, "path");
> +
> +    if (!sec_model) {

The check is wrong, you don't want security_model so:

    if (sec_model) {

> +        error_report("Invalid argument security_model specified "
> +                     "with cephfs fsdriver");
> +        return -1;
> +    }
> +
> +    if (!path) {
> +        error_report("fsdev: No path specified.");
> +        return -1;
> +    }
> +
> +    fse->path = g_strdup(path);
> +    return 0;
> +}
> +
> +FileOperations cephfs_ops = {
> +    .parse_opts   = cephfs_parse_opts,
> +    .init         = cephfs_init,
> +    .lstat        = cephfs_lstat,
> +    .readlink     = cephfs_readlink,
> +    .close        = cephfs_close,
> +    .closedir     = cephfs_closedir,
> +    .open         = cephfs_open,
> +    .opendir      = cephfs_opendir,
> +    .rewinddir    = cephfs_rewinddir,
> +    .telldir      = cephfs_telldir,
> +    .readdir_r    = cephfs_readdir_r,
> +    .seekdir      = cephfs_seekdir,
> +    .preadv       = cephfs_preadv,
> +    .pwritev      = cephfs_pwritev,
> +    .chmod        = cephfs_chmod,
> +    .mknod        = cephfs_mknod,
> +    .mkdir        = cephfs_mkdir,
> +    .fstat        = cephfs_fstat,
> +    .open2        = cephfs_open2,
> +    .symlink      = cephfs_symlink,
> +    .link         = cephfs_link,
> +    .truncate     = cephfs_truncate,
> +    .rename       = cephfs_rename,
> +    .chown        = cephfs_chown,
> +    .utimensat    = cephfs_utimensat,
> +    .remove       = cephfs_remove,
> +    .fsync        = cephfs_fsync,
> +    .statfs       = cephfs_statfs,
> +    .lgetxattr    = cephfs_lgetxattr,
> +    .llistxattr   = cephfs_llistxattr,
> +    .lsetxattr    = cephfs_lsetxattr,
> +    .lremovexattr = cephfs_lremovexattr,
> +    .name_to_path = cephfs_name_to_path,
> +    .renameat     = cephfs_renameat,
> +    .unlinkat     = cephfs_unlinkat,
> +};
> diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
> index da0ae0c..a77a6f4 100644
> --- a/hw/9pfs/Makefile.objs
> +++ b/hw/9pfs/Makefile.objs
> @@ -5,5 +5,8 @@ common-obj-y += coth.o cofs.o codir.o cofile.o
>  common-obj-y += coxattr.o 9p-synth.o
>  common-obj-$(CONFIG_OPEN_BY_HANDLE) +=  9p-handle.o
>  common-obj-y += 9p-proxy.o
> +common-obj-y += 9p-cephfs.o
> 
>  obj-y += virtio-9p-device.o
> +
> +9p-cephfs.o-libs := $(CEPHFS_LIBS)
> diff --git a/scripts/analyse-9p-simpletrace.py b/scripts/analyse-9p-simpletrace.py
> deleted file mode 100755
> index 3c3dee4..0000000
> --- a/scripts/analyse-9p-simpletrace.py
> +++ /dev/null
> @@ -1,213 +0,0 @@
> -#!/usr/bin/env python
> -# Pretty print 9p simpletrace log
> -# Usage: ./analyse-9p-simpletrace <trace-events> <trace-pid>
> -#
> -# Author: Harsh Prateek Bora
> -import os
> -import simpletrace
> -
> -symbol_9p = {
> -    6   : 'TLERROR',
> -    7   : 'RLERROR',
> -    8   : 'TSTATFS',
> -    9   : 'RSTATFS',
> -    12  : 'TLOPEN',
> -    13  : 'RLOPEN',
> -    14  : 'TLCREATE',
> -    15  : 'RLCREATE',
> -    16  : 'TSYMLINK',
> -    17  : 'RSYMLINK',
> -    18  : 'TMKNOD',
> -    19  : 'RMKNOD',
> -    20  : 'TRENAME',
> -    21  : 'RRENAME',
> -    22  : 'TREADLINK',
> -    23  : 'RREADLINK',
> -    24  : 'TGETATTR',
> -    25  : 'RGETATTR',
> -    26  : 'TSETATTR',
> -    27  : 'RSETATTR',
> -    30  : 'TXATTRWALK',
> -    31  : 'RXATTRWALK',
> -    32  : 'TXATTRCREATE',
> -    33  : 'RXATTRCREATE',
> -    40  : 'TREADDIR',
> -    41  : 'RREADDIR',
> -    50  : 'TFSYNC',
> -    51  : 'RFSYNC',
> -    52  : 'TLOCK',
> -    53  : 'RLOCK',
> -    54  : 'TGETLOCK',
> -    55  : 'RGETLOCK',
> -    70  : 'TLINK',
> -    71  : 'RLINK',
> -    72  : 'TMKDIR',
> -    73  : 'RMKDIR',
> -    74  : 'TRENAMEAT',
> -    75  : 'RRENAMEAT',
> -    76  : 'TUNLINKAT',
> -    77  : 'RUNLINKAT',
> -    100 : 'TVERSION',
> -    101 : 'RVERSION',
> -    102 : 'TAUTH',
> -    103 : 'RAUTH',
> -    104 : 'TATTACH',
> -    105 : 'RATTACH',
> -    106 : 'TERROR',
> -    107 : 'RERROR',
> -    108 : 'TFLUSH',
> -    109 : 'RFLUSH',
> -    110 : 'TWALK',
> -    111 : 'RWALK',
> -    112 : 'TOPEN',
> -    113 : 'ROPEN',
> -    114 : 'TCREATE',
> -    115 : 'RCREATE',
> -    116 : 'TREAD',
> -    117 : 'RREAD',
> -    118 : 'TWRITE',
> -    119 : 'RWRITE',
> -    120 : 'TCLUNK',
> -    121 : 'RCLUNK',
> -    122 : 'TREMOVE',
> -    123 : 'RREMOVE',
> -    124 : 'TSTAT',
> -    125 : 'RSTAT',
> -    126 : 'TWSTAT',
> -    127 : 'RWSTAT'
> -}
> -
> -class VirtFSRequestTracker(simpletrace.Analyzer):
> -        def begin(self):
> -                print "Pretty printing 9p simpletrace log ..."
> -
> -        def v9fs_rerror(self, tag, id, err):
> -                print "RERROR (tag =", tag, ", id =", symbol_9p[id], ", err = \"", os.strerror(err), "\")"
> -
> -        def v9fs_version(self, tag, id, msize, version):
> -                print "TVERSION (tag =", tag, ", msize =", msize, ", version =", version, ")"
> -
> -        def v9fs_version_return(self, tag, id, msize, version):
> -                print "RVERSION (tag =", tag, ", msize =", msize, ", version =", version, ")"
> -
> -        def v9fs_attach(self, tag, id, fid, afid, uname, aname):
> -                print "TATTACH (tag =", tag, ", fid =", fid, ", afid =", afid, ", uname =", uname, ", aname =", aname, ")"
> -
> -        def v9fs_attach_return(self, tag, id, type, version, path):
> -                print "RATTACH (tag =", tag, ", qid={type =", type, ", version =", version, ", path =", path, "})"
> -
> -        def v9fs_stat(self, tag, id, fid):
> -                print "TSTAT (tag =", tag, ", fid =", fid, ")"
> -
> -        def v9fs_stat_return(self, tag, id, mode, atime, mtime, length):
> -                print "RSTAT (tag =", tag, ", mode =", mode, ", atime =", atime, ", mtime =", mtime, ", length =", length, ")"
> -
> -        def v9fs_getattr(self, tag, id, fid, request_mask):
> -                print "TGETATTR (tag =", tag, ", fid =", fid, ", request_mask =", hex(request_mask), ")"
> -
> -        def v9fs_getattr_return(self, tag, id, result_mask, mode, uid, gid):
> -                print "RGETATTR (tag =", tag, ", result_mask =", hex(result_mask), ", mode =", oct(mode), ", uid =", uid, ", gid =", gid, ")"
> -
> -        def v9fs_walk(self, tag, id, fid, newfid, nwnames):
> -                print "TWALK (tag =", tag, ", fid =", fid, ", newfid =", newfid, ", nwnames =", nwnames, ")"
> -
> -        def v9fs_walk_return(self, tag, id, nwnames, qids):
> -                print "RWALK (tag =", tag, ", nwnames =", nwnames, ", qids =", hex(qids), ")"
> -
> -        def v9fs_open(self, tag, id, fid, mode):
> -                print "TOPEN (tag =", tag, ", fid =", fid, ", mode =", oct(mode), ")"
> -
> -        def v9fs_open_return(self, tag, id, type, version, path, iounit):
> -                print "ROPEN (tag =", tag,  ", qid={type =", type, ", version =", version, ", path =", path, "}, iounit =", iounit, ")"
> -
> -        def v9fs_lcreate(self, tag, id, dfid, flags, mode, gid):
> -                print "TLCREATE (tag =", tag, ", dfid =", dfid, ", flags =", oct(flags), ", mode =", oct(mode), ", gid =", gid, ")"
> -
> -        def v9fs_lcreate_return(self, tag, id, type, version, path, iounit):
> -                print "RLCREATE (tag =", tag,  ", qid={type =", type, ", version =", version, ", path =", path, "}, iounit =", iounit, ")"
> -
> -        def v9fs_fsync(self, tag, id, fid, datasync):
> -                print "TFSYNC (tag =", tag, ", fid =", fid, ", datasync =", datasync, ")"
> -
> -        def v9fs_clunk(self, tag, id, fid):
> -                print "TCLUNK (tag =", tag, ", fid =", fid, ")"
> -
> -        def v9fs_read(self, tag, id, fid, off, max_count):
> -                print "TREAD (tag =", tag, ", fid =", fid, ", off =", off, ", max_count =", max_count, ")"
> -
> -        def v9fs_read_return(self, tag, id, count, err):
> -                print "RREAD (tag =", tag, ", count =", count, ", err =", err, ")"
> -
> -        def v9fs_readdir(self, tag, id, fid, offset, max_count):
> -                print "TREADDIR (tag =", tag, ", fid =", fid, ", offset =", offset, ", max_count =", max_count, ")"
> -
> -        def v9fs_readdir_return(self, tag, id, count, retval):
> -                print "RREADDIR (tag =", tag, ", count =", count, ", retval =", retval, ")"
> -
> -        def v9fs_write(self, tag, id, fid, off, count, cnt):
> -                print "TWRITE (tag =", tag, ", fid =", fid, ", off =", off, ", count =", count, ", cnt =", cnt, ")"
> -
> -        def v9fs_write_return(self, tag, id, total, err):
> -                print "RWRITE (tag =", tag, ", total =", total, ", err =", err, ")"
> -
> -        def v9fs_create(self, tag, id, fid, name, perm, mode):
> -                print "TCREATE (tag =", tag, ", fid =", fid, ", perm =", oct(perm), ", name =", name, ", mode =", oct(mode), ")"
> -
> -        def v9fs_create_return(self, tag, id, type, version, path, iounit):
> -                print "RCREATE (tag =", tag,  ", qid={type =", type, ", version =", version, ", path =", path, "}, iounit =", iounit, ")"
> -
> -        def v9fs_symlink(self, tag, id, fid, name, symname, gid):
> -                print "TSYMLINK (tag =", tag, ", fid =", fid, ", name =", name, ", symname =", symname, ", gid =", gid, ")"
> -
> -        def v9fs_symlink_return(self, tag, id, type, version, path):
> -                print "RSYMLINK (tag =", tag,  ", qid={type =", type, ", version =", version, ", path =", path, "})"
> -
> -        def v9fs_flush(self, tag, id, flush_tag):
> -                print "TFLUSH (tag =", tag, ", flush_tag =", flush_tag, ")"
> -
> -        def v9fs_link(self, tag, id, dfid, oldfid, name):
> -                print "TLINK (tag =", tag, ", dfid =", dfid, ", oldfid =", oldfid, ", name =", name, ")"
> -
> -        def v9fs_remove(self, tag, id, fid):
> -                print "TREMOVE (tag =", tag, ", fid =", fid, ")"
> -
> -        def v9fs_wstat(self, tag, id, fid, mode, atime, mtime):
> -                print "TWSTAT (tag =", tag, ", fid =", fid, ", mode =", oct(mode), ", atime =", atime, "mtime =", mtime, ")"
> -
> -        def v9fs_mknod(self, tag, id, fid, mode, major, minor):
> -                print "TMKNOD (tag =", tag, ", fid =", fid, ", mode =", oct(mode), ", major =", major, ", minor =", minor, ")"
> -
> -        def v9fs_lock(self, tag, id, fid, type, start, length):
> -                print "TLOCK (tag =", tag, ", fid =", fid, "type =", type, ", start =", start, ", length =", length, ")"
> -
> -        def v9fs_lock_return(self, tag, id, status):
> -                print "RLOCK (tag =", tag, ", status =", status, ")"
> -
> -        def v9fs_getlock(self, tag, id, fid, type, start, length):
> -                print "TGETLOCK (tag =", tag, ", fid =", fid, "type =", type, ", start =", start, ", length =", length, ")"
> -
> -        def v9fs_getlock_return(self, tag, id, type, start, length, proc_id):
> -                print "RGETLOCK (tag =", tag, "type =", type, ", start =", start, ", length =", length, ", proc_id =", proc_id,  ")"
> -
> -        def v9fs_mkdir(self, tag, id, fid, name, mode, gid):
> -                print "TMKDIR (tag =", tag, ", fid =", fid, ", name =", name, ", mode =", mode, ", gid =", gid, ")"
> -
> -        def v9fs_mkdir_return(self, tag, id, type, version, path, err):
> -                print "RMKDIR (tag =", tag,  ", qid={type =", type, ", version =", version, ", path =", path, "}, err =", err, ")"
> -
> -        def v9fs_xattrwalk(self, tag, id, fid, newfid, name):
> -                print "TXATTRWALK (tag =", tag, ", fid =", fid, ", newfid =", newfid, ", xattr name =", name, ")"
> -
> -        def v9fs_xattrwalk_return(self, tag, id, size):
> -                print "RXATTRWALK (tag =", tag, ", xattrsize  =", size, ")"
> -
> -        def v9fs_xattrcreate(self, tag, id, fid, name, size, flags):
> -                print "TXATTRCREATE (tag =", tag, ", fid =", fid, ", name =", name, ", xattrsize =", size, ", flags =", flags, ")"
> -
> -        def v9fs_readlink(self, tag, id, fid):
> -                print "TREADLINK (tag =", tag, ", fid =", fid, ")"
> -
> -        def v9fs_readlink_return(self, tag, id, target):
> -                print "RREADLINK (tag =", tag, ", target =", target, ")"
> -
> -simpletrace.run(VirtFSRequestTracker())
> diff --git a/scripts/analyze-9p-simpletrace.py b/scripts/analyze-9p-simpletrace.py
> new file mode 100755
> index 0000000..e9c6737
> --- /dev/null
> +++ b/scripts/analyze-9p-simpletrace.py
> @@ -0,0 +1,306 @@
> +#!/usr/bin/env python
> +# Pretty print 9p simpletrace log
> +# Usage: ./analyse-9p-simpletrace <trace-events> <trace-pid>
> +#
> +# Author: Harsh Prateek Bora
> +import os
> +import simpletrace
> +
> +symbol_9p = {
> +    6   : 'TLERROR',
> +    7   : 'RLERROR',
> +    8   : 'TSTATFS',
> +    9   : 'RSTATFS',
> +    12  : 'TLOPEN',
> +    13  : 'RLOPEN',
> +    14  : 'TLCREATE',
> +    15  : 'RLCREATE',
> +    16  : 'TSYMLINK',
> +    17  : 'RSYMLINK',
> +    18  : 'TMKNOD',
> +    19  : 'RMKNOD',
> +    20  : 'TRENAME',
> +    21  : 'RRENAME',
> +    22  : 'TREADLINK',
> +    23  : 'RREADLINK',
> +    24  : 'TGETATTR',
> +    25  : 'RGETATTR',
> +    26  : 'TSETATTR',
> +    27  : 'RSETATTR',
> +    30  : 'TXATTRWALK',
> +    31  : 'RXATTRWALK',
> +    32  : 'TXATTRCREATE',
> +    33  : 'RXATTRCREATE',
> +    40  : 'TREADDIR',
> +    41  : 'RREADDIR',
> +    50  : 'TFSYNC',
> +    51  : 'RFSYNC',
> +    52  : 'TLOCK',
> +    53  : 'RLOCK',
> +    54  : 'TGETLOCK',
> +    55  : 'RGETLOCK',
> +    70  : 'TLINK',
> +    71  : 'RLINK',
> +    72  : 'TMKDIR',
> +    73  : 'RMKDIR',
> +    74  : 'TRENAMEAT',
> +    75  : 'RRENAMEAT',
> +    76  : 'TUNLINKAT',
> +    77  : 'RUNLINKAT',
> +    100 : 'TVERSION',
> +    101 : 'RVERSION',
> +    102 : 'TAUTH',
> +    103 : 'RAUTH',
> +    104 : 'TATTACH',
> +    105 : 'RATTACH',
> +    106 : 'TERROR',
> +    107 : 'RERROR',
> +    108 : 'TFLUSH',
> +    109 : 'RFLUSH',
> +    110 : 'TWALK',
> +    111 : 'RWALK',
> +    112 : 'TOPEN',
> +    113 : 'ROPEN',
> +    114 : 'TCREATE',
> +    115 : 'RCREATE',
> +    116 : 'TREAD',
> +    117 : 'RREAD',
> +    118 : 'TWRITE',
> +    119 : 'RWRITE',
> +    120 : 'TCLUNK',
> +    121 : 'RCLUNK',
> +    122 : 'TREMOVE',
> +    123 : 'RREMOVE',
> +    124 : 'TSTAT',
> +    125 : 'RSTAT',
> +    126 : 'TWSTAT',
> +    127 : 'RWSTAT'
> +}
> +
> +class VirtFSRequestTracker(simpletrace.Analyzer):
> +        def begin(self):
> +                print "Pretty printing 9p simpletrace log ..."
> +
> +        def v9fs_rerror(self, tag, id, err):
> +                print "RERROR (tag =", tag, ", id =", symbol_9p[id], ", err = \"", os.strerror(err), "\")"
> +
> +        def v9fs_version(self, tag, id, msize, version):
> +                print "TVERSION (tag =", tag, ", msize =", msize, ", version =", version, ")"
> +
> +        def v9fs_version_return(self, tag, id, msize, version):
> +                print "RVERSION (tag =", tag, ", msize =", msize, ", version =", version, ")"
> +
> +        def v9fs_attach(self, tag, id, fid, afid, uname, aname):
> +                print "TATTACH (tag =", tag, ", fid =", fid, ", afid =", afid, ", uname =", uname, ", aname =", aname, ")"
> +
> +        def v9fs_attach_return(self, tag, id, type, version, path):
> +                print "RATTACH (tag =", tag, ", qid={type =", type, ", version =", version, ", path =", path, "})"
> +
> +        def v9fs_stat(self, tag, id, fid):
> +                print "TSTAT (tag =", tag, ", fid =", fid, ")"
> +
> +        def v9fs_stat_return(self, tag, id, mode, atime, mtime, length):
> +                print "RSTAT (tag =", tag, ", mode =", mode, ", atime =", atime, ", mtime =", mtime, ", length =", length, ")"
> +
> +        def v9fs_getattr(self, tag, id, fid, request_mask):
> +                print "TGETATTR (tag =", tag, ", fid =", fid, ", request_mask =", hex(request_mask), ")"
> +
> +        def v9fs_getattr_return(self, tag, id, result_mask, mode, uid, gid):
> +                print "RGETATTR (tag =", tag, ", result_mask =", hex(result_mask), ", mode =", oct(mode), ", uid =", uid, ", gid =", gid, ")"
> +
> +        def v9fs_walk(self, tag, id, fid, newfid, nwnames):
> +                print "TWALK (tag =", tag, ", fid =", fid, ", newfid =", newfid, ", nwnames =", nwnames, ")"
> +
> +        def v9fs_walk_return(self, tag, id, nwnames, qids):
> +                print "RWALK (tag =", tag, ", nwnames =", nwnames, ", qids =", hex(qids), ")"
> +
> +        def v9fs_open(self, tag, id, fid, mode):
> +                print "TOPEN (tag =", tag, ", fid =", fid, ", mode =", oct(mode), ")"
> +
> +        def v9fs_open_return(self, tag, id, type, version, path, iounit):
> +                print "ROPEN (tag =", tag,  ", qid={type =", type, ", version =", version, ", path =", path, "}, iounit =", iounit, ")"
> +
> +        def v9fs_lcreate(self, tag, id, dfid, flags, mode, gid):
> +                print "TLCREATE (tag =", tag, ", dfid =", dfid, ", flags =", oct(flags), ", mode =", oct(mode), ", gid =", gid, ")"
> +
> +        def v9fs_lcreate_return(self, tag, id, type, version, path, iounit):
> +                print "RLCREATE (tag =", tag,  ", qid={type =", type, ", version =", version, ", path =", path, "}, iounit =", iounit, ")"
> +
> +        def v9fs_fsync(self, tag, id, fid, datasync):
> +                print "TFSYNC (tag =", tag, ", fid =", fid, ", datasync =", datasync, ")"
> +
> +        def v9fs_clunk(self, tag, id, fid):
> +                print "TCLUNK (tag =", tag, ", fid =", fid, ")"
> +
> +        def v9fs_read(self, tag, id, fid, off, max_count):
> +                print "TREAD (tag =", tag, ", fid =", fid, ", off =", off, ", max_count =", max_count, ")"
> +
> +        def v9fs_read_return(self, tag, id, count, err):
> +                print "RREAD (tag =", tag, ", count =", count, ", err =", err, ")"
> +
> +        def v9fs_readdir(self, tag, id, fid, offset, max_count):
> +                print "TREADDIR (tag =", tag, ", fid =", fid, ", offset =", offset, ", max_count =", max_count, ")"
> +
> +        def v9fs_readdir_return(self, tag, id, count, retval):
> +                print "RREADDIR (tag =", tag, ", count =", count, ", retval =", retval, ")"
> +
> +        def v9fs_write(self, tag, id, fid, off, count, cnt):
> +                print "TWRITE (tag =", tag, ", fid =", fid, ", off =", off, ", count =", count, ", cnt =", cnt, ")"
> +
> +        def v9fs_write_return(self, tag, id, total, err):
> +                print "RWRITE (tag =", tag, ", total =", total, ", err =", err, ")"
> +
> +        def v9fs_create(self, tag, id, fid, name, perm, mode):
> +                print "TCREATE (tag =", tag, ", fid =", fid, ", perm =", oct(perm), ", name =", name, ", mode =", oct(mode), ")"
> +
> +        def v9fs_create_return(self, tag, id, type, version, path, iounit):
> +                print "RCREATE (tag =", tag,  ", qid={type =", type, ", version =", version, ", path =", path, "}, iounit =", iounit, ")"
> +
> +        def v9fs_symlink(self, tag, id, fid, name, symname, gid):
> +                print "TSYMLINK (tag =", tag, ", fid =", fid, ", name =", name, ", symname =", symname, ", gid =", gid, ")"
> +
> +        def v9fs_symlink_return(self, tag, id, type, version, path):
> +                print "RSYMLINK (tag =", tag,  ", qid={type =", type, ", version =", version, ", path =", path, "})"
> +
> +        def v9fs_flush(self, tag, id, flush_tag):
> +                print "TFLUSH (tag =", tag, ", flush_tag =", flush_tag, ")"
> +
> +        def v9fs_link(self, tag, id, dfid, oldfid, name):
> +                print "TLINK (tag =", tag, ", dfid =", dfid, ", oldfid =", oldfid, ", name =", name, ")"
> +
> +        def v9fs_remove(self, tag, id, fid):
> +                print "TREMOVE (tag =", tag, ", fid =", fid, ")"
> +
> +        def v9fs_wstat(self, tag, id, fid, mode, atime, mtime):
> +                print "TWSTAT (tag =", tag, ", fid =", fid, ", mode =", oct(mode), ", atime =", atime, "mtime =", mtime, ")"
> +
> +        def v9fs_mknod(self, tag, id, fid, mode, major, minor):
> +                print "TMKNOD (tag =", tag, ", fid =", fid, ", mode =", oct(mode), ", major =", major, ", minor =", minor, ")"
> +
> +        def v9fs_lock(self, tag, id, fid, type, start, length):
> +                print "TLOCK (tag =", tag, ", fid =", fid, "type =", type, ", start =", start, ", length =", length, ")"
> +
> +        def v9fs_lock_return(self, tag, id, status):
> +                print "RLOCK (tag =", tag, ", status =", status, ")"
> +
> +        def v9fs_getlock(self, tag, id, fid, type, start, length):
> +                print "TGETLOCK (tag =", tag, ", fid =", fid, "type =", type, ", start =", start, ", length =", length, ")"
> +
> +        def v9fs_getlock_return(self, tag, id, type, start, length, proc_id):
> +                print "RGETLOCK (tag =", tag, "type =", type, ", start =", start, ", length =", length, ", proc_id =", proc_id,  ")"
> +
> +        def v9fs_mkdir(self, tag, id, fid, name, mode, gid):
> +                print "TMKDIR (tag =", tag, ", fid =", fid, ", name =", name, ", mode =", mode, ", gid =", gid, ")"
> +
> +        def v9fs_mkdir_return(self, tag, id, type, version, path, err):
> +                print "RMKDIR (tag =", tag,  ", qid={type =", type, ", version =", version, ", path =", path, "}, err =", err, ")"
> +
> +        def v9fs_xattrwalk(self, tag, id, fid, newfid, name):
> +                print "TXATTRWALK (tag =", tag, ", fid =", fid, ", newfid =", newfid, ", xattr name =", name, ")"
> +
> +        def v9fs_xattrwalk_return(self, tag, id, size):
> +                print "RXATTRWALK (tag =", tag, ", xattrsize  =", size, ")"
> +
> +        def v9fs_xattrcreate(self, tag, id, fid, name, size, flags):
> +                print "TXATTRCREATE (tag =", tag, ", fid =", fid, ", name =", name, ", xattrsize =", size, ", flags =", flags, ")"
> +
> +        def v9fs_readlink(self, tag, id, fid):
> +                print "TREADLINK (tag =", tag, ", fid =", fid, ")"
> +
> +        def v9fs_readlink_return(self, tag, id, target):
> +                print "RREADLINK (tag =", tag, ", target =", target, ")"
> +
> +	def cephfs_lstat_return(self, path, stmode, stuid, stgid, stsize, ret):
> +		print "RCEPHFSLSTAT (path =", path, ", stmode =", stmode, ", stuid =", stuid, ", stgid =", stgid, ", stsize =", stsize, ", ret =", ret, ")"
> +
> +	def cephfs_readlink_return(self, path, ret):
> +		print "RCEPHFSREADLINK (path =", path, ", ret =", ret, ")"
> +
> +	def cephfs_open_return(self, path, flags, mode, fd):
> +		print "RCEPHFSOPEN (path =", path, ", flags =", flags, ", mode =", mode, ", fd =", fd, ")"
> +
> +	def cephfs_opendir_return(self, path, ret):
> +		print "RCEPHFSOPENDIR (path =", path, ", ret =", ret, ")"
> +
> +	def cephfs_rewinddir(self, dir):
> +		print "TCEPHFSREWINDDIR (dir =", dir, ")"
> +
> +	def cephfs_telldir(self, dir):
> +		print "TCEPHFSTELLDIR (dir =", dir, ")"
> +
> +	def cephfs_readdir_r_return(self, tmpent, entry, ret):
> +		print "RCEPHFSREADDIRR (tmpent =", tmpent, ", entry =", entry, ", ret =", ret, ")"
> +
> +	def cephfs_seekdir(self, dir, off):
> +		print "TCEPHFSSEEKDIR (dir =", dir, ", off =", off, ")"
> +
> +	def cephfs_preadv(self, iovcnt, len):
> +		print "TCEPHFSPREADV (iovcnt=", iovcnt, ", len =", len, ")"
> +
> +	def cephfs_preadv_return(self, iovcnt, len, ret):
> +		print "RCEPHFSPREADV (iovcnt=", iovcnt, ", len =", len, ", ret = ", ret, ")"
> +
> +	def cephfs_pwritev(self, iovcnt, len, offset):
> +		print "TCEPHFSPWRITEV (iovcnt=", iovcnt, ", len =", len, ", offset =", offset, ")"
> +
> +	def cephfs_pwritev_return(self, iovcnt, len, offset, ret):
> +		print "RCEPHFSPWRITEV (iovcnt=", iovcnt, ", len =", len, ", offset =", offset, ", ret = ", ret, ")"
> +
> +	def cephfs_chmod_return(self, path, fcmode, ret):
> +		print "RCEPHFSCHMOD (path =", path, ", fcmode =", fcmode, ", ret =", ret, ")"
> +
> +	def cephfs_mknod_return(self, path, fcmode, fcrdev, ret):
> +		print "RCEPHFSMKNOD (path =", path, ", fcmode =", fcmode, ", fcrdev =", fcrdev, ", ret =", ret, ")"
> +
> +	def cephfs_mkdir_return(self, path, fcmode, ret):
> +		print "RCEPHFSMKDIR (path =", path, ", fcmode =", fcmode, ", ret =", ret, ")"
> +
> +	def cephfs_fstat_return(self, fidtype, fd, stuid, stgid, stsize, ret):
> +		print "RCEPHFSFSTAT (fidtype =", fidtype, ", fd =", fd, ", stuid =", stuid, ", stgid =", stgid, ", stsize =", stsize, ", ret =", ret, ")"
> +
> +	def cephfs_open2_return(self, path, flags, fcmode):
> +		print "RCEPHFSOPEN2 (path =", path, ", flags =", flags, "fcmode =", fcmode, ")"
> +
> +	def cephfs_symlink_return(self, oldpath, path, ret):
> +		print "RCEPHFSSYMLINK (oldpath =", oldpath, ", path =", path, ", ret =", ret, ")"
> +
> +	def cephfs_link_return(self, oldpath, path, ret):
> +		print "RCEPHFSLINK (oldpath =", oldpath, ", path =", path, ", ret =", ret, ")"
> +
> +	def cephfs_truncate_return(self, path, size, ret):
> +		print "RCEPHFSTRUNCATE (path =", path, ", size =", size, ", ret =", ret, ")"
> +
> +	def cephfs_rename_return(self, oldpath, newpath, ret):
> +		print "RCEPHFSRENAME (oldpath =", oldpath, ", newpath =", newpath, ", ret =", ret, ")"
> +
> +	def cephfs_chown_return(self, path, fcuid, fcgid, ret):
> +		print "RCEPHFSCHOWN (path =", path, ", fcuid =", fcuid, ", fcgid =", fcgid, ", ret =", ret, ")"
> +
> +	def cephfs_utimensat_return(self, path, ret):
> +		print "RCEPHFSUTIMENSAT (path =", path, ", ret =", ret, ")"
> +
> +	def cephfs_fsync_return(self, fd, datasync, ret):
> +		print "RCEPHFSFSYNC (fd =", fd, ", datasync =", datasync, ", ret =", ret, ")"
> +
> +	def cephfs_lgetxattr_return(self, path, name, ret):
> +		print "RCEPHFSLGETXATTR (path =", path, ", name =", name, ", ret =", ret, ")"
> +
> +	def cephfs_llistxattr_return(self, path, ret):
> +		print "RCEPHFSLLISTXATTR (path =", path, ", ret =", ret, ")"
> +
> +	def cephfs_lsetxattr_return(self, path, name, flags, ret):
> +		print "RCEPHFSLSETXATTR (path =", path, ", name =", name, ", flags =", flags, ", ret =", ret, ")"
> +
> +	def cephfs_lremovexattr_return(self, path, name, ret):
> +		print "RCEPHFSLREMOVEXATTR (path =", path, ", name =", name, ", ret =", ret, ")"
> +
> +	def cephfs_renameat_return(self, oldname, newname, ret):
> +		print "RCEPHFSRENAMEAT (oldname =", oldname, ", newname =", newname, ", ret =", ret, ")"
> +
> +	def cephfs_unlinkat_return(self, path, stmode, ret):
> +		print "RCEPHFSUNLINKAT (path =", path, ", stmode =", stmode, ", ret =", ret, ")"
> +
> +	def cephfs_init(self, path):
> +		print "RCEPHFSINIT (path =", path, ")"
> +
> +simpletrace.run(VirtFSRequestTracker())
> diff --git a/trace-events b/trace-events
> index 6fba6cc..48aa9cb 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -1118,6 +1118,39 @@ v9fs_xattrcreate(uint16_t tag, uint8_t id, int32_t fid, char* name, int64_t size
>  v9fs_readlink(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
>  v9fs_readlink_return(uint16_t tag, uint8_t id, char* target) "tag %d id %d name %s"
> 
> +# hw/9pfs/9p-cephfs.c
> +cephfs_lstat_return(char *path, int stmode, int stuid, int stgid, int stsize, int ret) "path %s stmode %d stuid %d stgid %d stsize %d ret %d"
> +cephfs_readlink_return(char *path, int ret) "path %s ret %d"
> +cephfs_open_return(char *path, int flags, int mode, int fd) "path %s flags %d mode %d fd %d"
> +cephfs_opendir_return(char *path, int ret) "path %s ret %d"
> +cephfs_rewinddir(void *dir) "dir %p"
> +cephfs_telldir(void *dir) "dir %p"
> +cephfs_readdir_r_return(void *tmpent, void *entry, int ret) "tmpent %p entry %p ret %d"
> +cephfs_seekdir(void *dir, int off) "dir %p off %d"
> +cephfs_preadv(int iovcnt, int len) "iovcnt %d len %d"
> +cephfs_preadv_return(int iovcnt, int len, long ret) "iovcnt %d len %d ret %ld"
> +cephfs_pwritev(int iovcnt, int len, int offset) "iovcnt %d len %d offset %d"
> +cephfs_pwritev_return(int iovcnt, int len, int offset, long ret) "iovcnt %d len %d offset %d ret %ld"
> +cephfs_chmod_return(char *path, int fcmode, int ret) "path %s fcmode %d ret %d"
> +cephfs_mknod_return(char *path, int fcmode, uint32_t fcrdev, int ret) "path %s fcmode %d fcrdev %u ret %d"
> +cephfs_mkdir_return(char *path, int fcmode, int ret) " path %s fcmode %d ret %d"
> +cephfs_fstat_return(int fidtype, int fd, int stuid, int stgid, int stsize, int ret) "fidtype %d fd %d stuid %d stgid %d stsize %d ret %d"
> +cephfs_open2_return(char *path, int flags, int fcmode) "path %s flags %d fcmode %d"
> +cephfs_symlink_return(const char *oldpath, char *path, int ret) "oldpath %s path %s ret %d"
> +cephfs_link_return(char *oldpath, char *path, int ret) "oldpath %s path %s ret %d"
> +cephfs_truncate_return(char *path, int size, int ret) "path %s size %d ret %d"
> +cephfs_rename_return(const char *oldpath, const char *newpath, int ret) "oldpath %s newpath %s ret %d"
> +cephfs_chown_return(char *path, int fcuid, int fcgid, int ret) "path %s fcuid %d fcgid %d ret %d"
> +cephfs_utimensat_return(char *path, int ret) "path %s ret %d"
> +cephfs_fsync_return(int fd, int datasync, int ret) "fd %d datasync %d ret %d"
> +cephfs_lgetxattr_return(char *path, const char *name, int ret) "path %s name %s ret %d"
> +cephfs_llistxattr_return(char *path, int ret) "path %s ret %d"
> +cephfs_lsetxattr_return(char *path, const char *name, int flags, int ret) "path %s name %s flags %d ret %d"
> +cephfs_lremovexattr_return(char *path, const char *name, int ret) "path %s name %s ret %d"
> +cephfs_renameat_return(const char *oldname, const char *newname, int ret) "oldname %s newname %s ret %d"
> +cephfs_unlinkat_return(char *path, int stmode, int ret) "path %s stmode %d ret %d"
> +cephfs_init(char *path) "path %s"
> +

Yeah, that's definitely a lot of traces...

>  # target-sparc/mmu_helper.c
>  mmu_helper_dfault(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DFAULT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"
>  mmu_helper_dprot(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DPROT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"

