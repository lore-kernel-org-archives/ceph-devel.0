From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH] hw/9pfs: Add CephFS support in VirtFS
Date: Wed, 9 Mar 2016 20:02:43 +0100
Message-ID: <20160309200243.5b00eea7@bahia.lab.toulouse-stg.fr.ibm.com>
References: <1456933303-1225-1-git-send-email-scaleqiao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:50094 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbcCITCx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 14:02:53 -0500
Received: from localhost
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <ceph-devel@vger.kernel.org> from <gkurz@linux.vnet.ibm.com>;
	Wed, 9 Mar 2016 19:02:51 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7BA3917D8059
	for <ceph-devel@vger.kernel.org>; Wed,  9 Mar 2016 19:03:17 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u29J2nS27209410
	for <ceph-devel@vger.kernel.org>; Wed, 9 Mar 2016 19:02:49 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u29J2miV016752
	for <ceph-devel@vger.kernel.org>; Wed, 9 Mar 2016 12:02:49 -0700
In-Reply-To: <1456933303-1225-1-git-send-email-scaleqiao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>
Cc: ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, berrange@redhat.com, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, sage@newdream.net, gfarnum@redhat.com, haomaiwang@gmail.com

On Wed,  2 Mar 2016 23:41:43 +0800
Jevon Qiao <scaleqiao@gmail.com> wrote:

> Ceph as a promising unified distributed storage system is widely used=
 in the
> world of OpenStack. OpenStack users deploying Ceph for block (Cinder)=
 and
> object (S3/Swift) are unsurprisingly looking at Manila and CephFS to =
round out
> a unified storage solution. Since the typical hypervisor people are u=
sing is
> Qemu/KVM, it is necessary to provide a high performance, easy to use,=
 file
> system service in it. VirtFS aims to offers paravirtualized system se=
rvices and
> simple passthrough for directories from host to guest, which currentl=
y only
> support local file system, this patch wants to add CephFS support in =
VirtFS.
>=20
> Signed-off-by: Jevon Qiao <scaleqiao@gmail.com>
> ---

Please fix all the formatting errors and warnings spit by checkpatch.pl=
, as
mentioned previously.

I also have comments, see below.

>  configure                         |  33 ++
>  fsdev/qemu-fsdev.c                |   1 +
>  fsdev/qemu-fsdev.h                |   3 +-
>  hw/9pfs/9p-cephfs.c               | 739 ++++++++++++++++++++++++++++=
++++++++++
>  hw/9pfs/Makefile.objs             |   3 +
>  scripts/analyse-9p-simpletrace.py |  96 +++++
>  trace-events                      |  33 ++
>  7 files changed, 907 insertions(+), 1 deletion(-)
>  create mode 100644 hw/9pfs/9p-cephfs.c
>=20
> diff --git a/configure b/configure
> index 0c0472a..a2627be 100755
> --- a/configure
> +++ b/configure
> @@ -275,6 +275,7 @@ trace_backends=3D"log"
>  trace_file=3D"trace"
>  spice=3D""
>  rbd=3D""
> +cephfs=3D""
>  smartcard=3D""
>  libusb=3D""
>  usb_redir=3D""
> @@ -1019,6 +1020,10 @@ for opt do
>    ;;
>    --enable-rbd) rbd=3D"yes"
>    ;;
> +  --disable-cephfs) cephfs=3D"no"
> +  ;;
> +  --enable-cephfs) cephfs=3D"yes"
> +  ;;
>    --disable-xfsctl) xfs=3D"no"
>    ;;
>    --enable-xfsctl) xfs=3D"yes"
> @@ -1345,6 +1350,7 @@ disabled with --disable-FEATURE, default is ena=
bled if available:
>    vhost-net       vhost-net acceleration support
>    spice           spice
>    rbd             rados block device (rbd)
> +  cephfs          Ceph File System=20
>    libiscsi        iscsi support
>    libnfs          nfs support
>    smartcard       smartcard support (libcacard)
> @@ -3087,6 +3093,28 @@ EOF
>  fi
>=20
>  ##########################################
> +# cephfs probe
> +if test "$cephfs" !=3D "no" ; then
> +  cat > $TMPC <<EOF
> +#include <stdio.h>
> +#include <cephfs/libcephfs.h>
> +int main(void) {
> +    struct ceph_mount_info *cmount;
> +    ceph_create(&cmount, NULL);
> +    return 0;
> +}
> +EOF
> +  cephfs_libs=3D"-lcephfs -lrados"

I don't think -lrados is needed here.

> +  if compile_prog "" "$cephfs_libs" ; then
> +    cephfs=3Dyes
> +  else
> +    if test "$cephfs" =3D "yes" ; then
> +      feature_not_found "cephfs" "Install libcephfs/ceph devel"
> +    fi
> +    cephfs=3Dno
> +  fi
> +fi
> +##########################################
>  # libssh2 probe
>  min_libssh2_version=3D1.2.8
>  if test "$libssh2" !=3D "no" ; then
> @@ -4760,6 +4788,7 @@ else
>  echo "spice support     $spice"
>  fi
>  echo "rbd support       $rbd"
> +echo "cephfs support    $cephfs"
>  echo "xfsctl support    $xfs"
>  echo "smartcard support $smartcard"
>  echo "libusb            $libusb"
> @@ -5224,6 +5253,10 @@ if test "$rbd" =3D "yes" ; then
>    echo "RBD_CFLAGS=3D$rbd_cflags" >> $config_host_mak
>    echo "RBD_LIBS=3D$rbd_libs" >> $config_host_mak
>  fi
> +if test "$cephfs" =3D "yes" ; then
> +  echo "CONFIG_CEPHFS=3Dm" >> $config_host_mak
> +  echo "CEPHFS_LIBS=3D$cephfs_libs" >> $config_host_mak
> +fi
>=20
>  echo "CONFIG_COROUTINE_BACKEND=3D$coroutine" >> $config_host_mak
>  if test "$coroutine_pool" =3D "yes" ; then
> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> index bf7f0b0..7f07a2a 100644
> --- a/fsdev/qemu-fsdev.c
> +++ b/fsdev/qemu-fsdev.c
> @@ -27,6 +27,7 @@ static FsDriverTable FsDrivers[] =3D {
>  #endif
>      { .name =3D "synth", .ops =3D &synth_ops},
>      { .name =3D "proxy", .ops =3D &proxy_ops},
> +    { .name =3D "cephfs", .ops =3D &cephfs_ops},
>  };
>=20
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
> index 0000000..f18ec89
> --- /dev/null
> +++ b/hw/9pfs/9p-cephfs.c
> @@ -0,0 +1,739 @@
> +/*
> + * Virtio 9p cephfs callback

s/Virtio // since transport isn't involved here.

> + *
> + * Copyright UnitedStack, Corp. 2016
> + *
> + * Authors:
> + *    Jevon Qiao <scaleqiao@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. =
 See
> + * the COPYING file in the top-level directory.
> + *
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
> +#define LIBCEPHFS_VERSION(maj, min, extra) ((maj << 16) + (min << 8)=
 + extra)
> +#define LIBCEPHFS_VERSION_CODE LIBCEPHFS_VERSION(0, 0, 0)
> +#endif
> +
> +struct cephfs_data {
> +    int	major, minor, patch;
> +    char ceph_version[CEPH_VER_LEN];
> +    struct  ceph_mount_info *cmount;
> +};
> +
> +/*
> + * Helper function for cephfs_preadv and cephfs_pwritev
> + */
> +inline static ssize_t preadv_pwritev(struct ceph_mount_info *cmount,=
 int fd,
> +                              	    const struct iovec *iov, int iov_=
cnt,
> +                              	    off_t offset, bool do_write)

Why inline ? I'd rather leave this to the compiler.

> +{
> +    ssize_t ret =3D 0;
> +    size_t i =3D 0;
> +    size_t len =3D 0;

These variables are assigned a value in all branches: no need to initia=
lize
them to 0.

> +    void *buf, *buftmp;
> +    size_t bufoffset =3D 0;
> +
> +    len =3D iov_size(iov, iov_cnt);
> +    buf =3D g_new0(uint8_t, len);
> +    buftmp =3D buf;
> +    if (do_write) {
> +        for (i =3D 0; i < iov_cnt; i++) {
> +            memcpy((buftmp + bufoffset), iov[i].iov_base, iov[i].iov=
_len);
> +            bufoffset +=3D iov[i].iov_len;
> +        }
> +        ret =3D ceph_write(cmount, fd, buf, len, offset);
> +        if (ret <=3D 0) {
> +           errno =3D -ret;
> +           ret =3D -1;
> +        }
> +    } else {
> +        ret =3D ceph_read(cmount, fd, buf, len, offset);
> +        if (ret <=3D 0) {
> +            errno =3D -ret;
> +            ret =3D -1;
> +        } else {
> +            for (i =3D 0; i < iov_cnt; i++) {
> +                memcpy(iov[i].iov_base, (buftmp + bufoffset), iov[i]=
=2Eiov_len);
> +                bufoffset +=3D iov[i].iov_len;
> +            }
> +        }
> +    }
> +

Since all the meaningful code is different for read and write, I'm not
convinced of the interest of having a single helper... Please split.

> +    free(buf);
> +    return ret;
> +}
> +
> +static int cephfs_update_file_cred(struct ceph_mount_info *cmount,
> +				   const char *name, FsCred *credp)
> +{
> +    int fd, ret;
> +    fd =3D ceph_open(cmount, name, O_NONBLOCK | O_NOFOLLOW, credp->f=
c_mode);
> +    if (fd < 0) {
> +        return fd;
> +    }
> +    ret =3D ceph_fchown(cmount, fd, credp->fc_uid, credp->fc_gid);
> +    if (ret < 0) {
> +        goto err_out;
> +    }
> +    ret =3D ceph_fchmod(cmount, fd, credp->fc_mode & 07777);
> +err_out:
> +    close(fd);
> +    return ret;
> +}
> +
> +static int cephfs_lstat(FsContext *fs_ctx, V9fsPath *fs_path,
> +                        struct stat *stbuf)
> +{
> +    int ret;
> +    char *path =3D fs_path->data;
> +    struct cephfs_data *cfsdata =3D fs_ctx->private;
> +
> +    ret =3D ceph_lstat(cfsdata->cmount, path, stbuf);
> +    trace_cephfs_lstat_return(path, stbuf->st_mode, stbuf->st_uid, s=
tbuf->st_gid, stbuf->st_size, ret);
> +    if (ret){

I prefer ret < 0, as you already do it in most places.

> +        errno =3D -ret;=20
> +        ret =3D -1;

s/ret =3D -1/return -1/

> +    }
> +    return ret;

s/return ret/return 0/

> +}
> +
> +static ssize_t cephfs_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
> +                               char *buf, size_t bufsz)
> +{
> +    int ret;
> +    char *path =3D fs_path->data;
> +    struct cephfs_data *cfsdata =3D fs_ctx->private;
> +
> +    ret =3D ceph_readlink(cfsdata->cmount, path, buf, bufsz);
> +    trace_cephfs_readlink_return(path, ret);
> +    return ret;

ceph_readlink() returns a negative errno, unlike the readlink() call
from the C library.

You need the same "if (ret < 0)" thing to set errno as in cephfs_lstat(=
),
and the function should return -1.

> +}
> +
> +static int cephfs_close(FsContext *ctx, V9fsFidOpenState *fs)
> +{
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    return ceph_close(cfsdata->cmount, fs->fd);

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_closedir(FsContext *ctx, V9fsFidOpenState *fs)
> +{
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +  =20
> +    return ceph_closedir(cfsdata->cmount, (struct ceph_dir_result *)=
fs->dir);

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_open(FsContext *ctx, V9fsPath *fs_path,
> +                       int flags, V9fsFidOpenState *fs)
> +{
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    fs->fd =3D ceph_open(cfsdata->cmount, fs_path->data, flags, 0777=
);
> +    trace_cephfs_open_return(fs_path->data, flags, 0777, fs->fd);
> +    return fs->fd;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_opendir(FsContext *ctx,
> +                          V9fsPath *fs_path, V9fsFidOpenState *fs)
> +{
> +    int ret;
> +    struct ceph_dir_result *result;
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +    char *path =3D fs_path->data;
> + =20
> +    ret =3D ceph_opendir(cfsdata->cmount, path, &result);
> +    trace_cephfs_opendir_return(path, ret);
> +    if (ret) {
> +        fprintf(stderr, "ceph_opendir=3D%d\n", ret);

Please use error_report() and print a meaningful message... at
least strerror(-ret).

> +        return ret;

Set errno and return -1 on error.

> +    }
> +    fs->dir =3D (DIR *)result;
> +    if (!fs->dir) {
> +        fprintf(stderr, "ceph_opendir return NULL for ceph_dir_resul=
t\n");

Hmm... is this a message for the QEMU user, so that she can fix somethi=
ng and
retry ? I suspect it is more for debugging purposes, in which case I'd =
rather
add a result argument to trace_cephfs_opendir_return() above.

And BTW, can ceph_opendir() return success without filling the structur=
e ?

> +        return -1;
> +    }
> +    return 0;
> +}
> +=20
> +static void cephfs_rewinddir(FsContext *ctx, V9fsFidOpenState *fs)
> +{
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    trace_cephfs_rewinddir(fs->dir);
> +    return ceph_rewinddir(cfsdata->cmount, (struct ceph_dir_result *=
)fs->dir);

Set errno and return -1 on error.

> +}
> +
> +static off_t cephfs_telldir(FsContext *ctx, V9fsFidOpenState *fs)
> +{
> +    int ret;
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    trace_cephfs_telldir(fs->dir);
> +    ret =3D ceph_telldir(cfsdata->cmount, (struct ceph_dir_result *)=
fs->dir);
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_readdir_r(FsContext *ctx, V9fsFidOpenState *fs,
> +                            struct dirent *entry,
> +                            struct dirent **result)
> +{
> +    int ret;
> +    struct dirent *tmpent;
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    tmpent =3D entry;
> +    ret =3D ceph_readdir_r(cfsdata->cmount, (struct ceph_dir_result =
*)fs->dir,
> +		    	entry);
> +    trace_cephfs_readdir_r_return(tmpent, entry, ret);

Hmm... I don't see the point here since tmpent =3D=3D entry...

> +    if (ret > 0 && entry !=3D NULL)
> +    {
> +        *result =3D entry;
> +    } else if (!ret)
> +    {
> +        *result =3D NULL;
> +        entry =3D tmpent;

This looks even weirder since entry has no users...

> +    }
> +   =20
> +    return ret;

This function should behave like the original readdir_r() function from=
 the
C library, but it doesn't.

According to the the libcephfs.h header:

 * @returns 1 if the next entry was filled in, 0 if the end of the dire=
ctory stream was reached,
 *          and a negative error code on failure.
 */
int ceph_readdir_r(struct ceph_mount_info *cmount, struct ceph_dir_resu=
lt *dirp, struct dirent *de);

and the readdir_r() manual page says:

   The  readdir_r() function returns 0 on success.  On error, it return=
s a
   positive error number (listed under ERRORS).  If the end of the  dir=
ec=E2=80=90
   tory  stream  is  reached,  readdir_r()  returns 0, and returns NULL=
 in
   *result.

If ceph_readdir_r() returns 1, we should return 0 instead of 1.

If ceph_readdir_r() returns 0, we should also return 0 and nullify *res=
ult,
while your patch doesn't update *result.

If ceph_readdir_r() returns a negative value ret, we should return -ret
instead of ret.

The code to set errno is also missing.

> +}
> +
> +static void cephfs_seekdir(FsContext *ctx, V9fsFidOpenState *fs, off=
_t off)
> +{
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    trace_cephfs_seekdir(fs->dir, off);
> +    return ceph_seekdir(cfsdata->cmount, (struct ceph_dir_result*)fs=
->dir, off);

This is a void function, return is not needed.

> +}
> +
> +static ssize_t cephfs_preadv(FsContext *ctx, V9fsFidOpenState *fs,
> +                             const struct iovec *iov,
> +                             int iovcnt, off_t offset)
> +{
> +    ssize_t ret =3D 0;
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    trace_cephfs_preadv(iovcnt, iov_size(iov, iovcnt));
> +#if defined(LIBCEPHFS_VERSION) && LIBCEPHFS_VERSION_CODE >=3D LIBCEP=
HFS_VERSION(9, 0, 3)=20
> +    ret =3D ceph_preadv(cfsdata->cmount, fs->fd, iov, iovcnt, offset=
);=20
> +#else

According to the preadv() manual page:

   EINVAL The  vector  count  iovcnt is less than zero or greater than =
the
          permitted maximum.

so we should do the same. Since this is a sanity check, it is better pl=
aced
before functional checks.

if (iovcnt < 0) {
    errno =3D EINVAL;
    ret =3D -1;
} else ...

> +    if (iovcnt > 1) {
> +	ret =3D preadv_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offset=
, 0);
> +    } else if (iovcnt > 0) {

I'd rather make it explicitly iovcnt =3D=3D 1.

> +	ret =3D ceph_read(cfsdata->cmount, fs->fd, iov[0].iov_base,
> +			iov[0].iov_len, offset);
> +    }
> +#endif

Ok, so IIUC, only newer versions of libcephfs have ceph_preadv().

I suggest you move all the code in the #else part to a local
ceph_preadv() implementation that only gets compiled when
libcephfs is too old. A bit like this:

#if defined(LIBCEPHFS_VERSION) && LIBCEPHFS_VERSION_CODE >=3D LIBCEPHFS=
_VERSION(9, 0, 3)=20
#define HAVE_CEPH_PREADV 1
#endif

#ifndef HAVE_CEPH_PREADV
static int ceph_preadv(struct ceph_mount_info *cmount, int fd, const st=
ruct iovec *iov,
                       int iovcnt, int64_t offset)
{
	...
}
#endif

The cephfs_preadv() function then just needs to call ceph_preadv().

> +    trace_cephfs_preadv_return(iovcnt, iov_size(iov, iovcnt), ret);
> +

Set errno and return -1 on error.

> +    return ret;
> +}
> +
> +static ssize_t cephfs_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
> +                              const struct iovec *iov,
> +                              int iovcnt, off_t offset)
> +{
> +    ssize_t ret =3D 0;
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    trace_cephfs_pwritev(iovcnt, iov_size(iov, iovcnt), offset);
> +#if defined(LIBCEPHFS_VERSION) && LIBCEPHFS_VERSION_CODE >=3D LIBCEP=
HFS_VERSION(9, 0, 3)=20
> +    ret =3D ceph_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offse=
t);
> +#else
> +    if (iovcnt > 1) {
> +	ret =3D preadv_pwritev(cfsdata->cmount, fs->fd, iov, iovcnt, offset=
, 1);
> +    } else if (iovcnt > 0) {
> +	ret =3D ceph_write(cfsdata->cmount, fs->fd, iov[0].iov_base,
> +			iov[0].iov_len, offset);
> +    }
> +#endif
> +    trace_cephfs_pwritev_return(iovcnt, iov_size(iov, iovcnt), offse=
t, ret);
> +
> +#ifdef CONFIG_SYNC_FILE_RANGE
> +    if (ret > 0 && ctx->export_flags & V9FS_IMMEDIATE_WRITEOUT) {
> +        /*
> +         * Initiate a writeback. This is not a data integrity sync.
> +         * We want to ensure that we don't leave dirty pages in the =
cache
> +         * after write when writeout=3Dimmediate is sepcified.
> +         */
> +        sync_file_range(fs->fd, offset, ret,
> +                        SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANG=
E_WRITE);
> +    }
> +#endif
> +    return ret;

Same remarks as for cephfs_preadv().

> +}
> +
> +static int cephfs_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred=
 *credp)
> +{
> +    int  ret =3D -1;

Initialization isn't needed.

> +    struct cephfs_data *cfsdata =3D fs_ctx->private;
> +
> +    ret =3D ceph_chmod(cfsdata->cmount, fs_path->data, credp->fc_mod=
e);
> +    trace_cephfs_chmod_return(fs_path->data, credp->fc_mode, ret);
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
> +                       const char *name, FsCred *credp)
> +{
> +    int ret;
> +    V9fsString fullname;
> +    struct cephfs_data *cfsdata =3D fs_ctx->private;
> +
> +    v9fs_string_init(&fullname);
> +    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
> +    ret =3D ceph_mknod(cfsdata->cmount, fullname.data, credp->fc_mod=
e,
> +		    credp->fc_rdev);
> +    trace_cephfs_mknod_return(fullname.data, credp->fc_mode, credp->=
fc_rdev, ret);
> +
> +    v9fs_string_free(&fullname);
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
> +                       const char *name, FsCred *credp)
> +{
> +    int ret;
> +    V9fsString fullname;
> +    struct cephfs_data *cfsdata =3D fs_ctx->private;
> +
> +    v9fs_string_init(&fullname);
> +    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
> +    ret =3D ceph_mkdir(cfsdata->cmount, fullname.data, credp->fc_mod=
e);
> +    trace_cephfs_mkdir_return(fullname.data, credp->fc_mode, ret);
> +
> +    v9fs_string_free(&fullname);
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_fstat(FsContext *fs_ctx, int fid_type,
> +                        V9fsFidOpenState *fs, struct stat *stbuf)
> +{
> +    int fd =3D -1;

Initialization isn't needed.

> +    int ret;
> +    struct cephfs_data *cfsdata =3D fs_ctx->private;
> +
> +    if (fid_type =3D=3D P9_FID_DIR) {
> +        fd =3D dirfd(fs->dir);
> +    } else {
> +        fd =3D fs->fd;
> +    }
> +    ret =3D ceph_fstat(cfsdata->cmount, fd, stbuf);
> +    trace_cephfs_fstat_return(fid_type, fd, stbuf->st_uid, stbuf->st=
_gid, stbuf->st_size, ret);
> +
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_open2(FsContext *fs_ctx, V9fsPath *dir_path, const=
 char *name,
> +                        int flags, FsCred *credp, V9fsFidOpenState *=
fs)
> +{
> +    int fd =3D -1, ret =3D -1;

Initialization isn't needed.

> +    V9fsString fullname;
> +    struct cephfs_data *cfsdata =3D fs_ctx->private;
> +
> +    v9fs_string_init(&fullname);
> +    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
> +    fd =3D ceph_open(cfsdata->cmount, fullname.data, flags, credp->f=
c_mode);
> +    trace_cephfs_open2_return(fullname.data, flags, credp->fc_mode);
> +    if (fd >=3D 0) {
> +        /* After creating the file, need to set the cred */
> +        ret =3D cephfs_update_file_cred(cfsdata->cmount, name, credp=
);
> +        if (ret < 0) {
> +            ceph_close(cfsdata->cmount, fd);
> +            errno =3D -ret;
> +            fd =3D ret;

s/fd =3D ret/fd =3D -1/

> +        } else {
> +            fs->fd =3D fd;
> +        }
> +    } else {
> +       errno =3D -fd;

and

fd =3D -1;

> +    }
> +
> +    v9fs_string_free(&fullname);
> +    return fd;
> +}
> +
> +static int cephfs_symlink(FsContext *fs_ctx, const char *oldpath,
> +                          V9fsPath *dir_path, const char *name, FsCr=
ed *credp)
> +{
> +    int ret =3D -1;

Initialization isn't needed.

> +    V9fsString fullname;
> +    struct cephfs_data *cfsdata =3D fs_ctx->private;
> +
> +    v9fs_string_init(&fullname);
> +    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
> +    ret =3D ceph_symlink(cfsdata->cmount, oldpath, fullname.data);
> +    trace_cephfs_symlink_return(oldpath, fullname.data, ret);
> +
> +    v9fs_string_free(&fullname);

Set errno and return -1 on error.

> +    return ret;
> +}
> +
> +static int cephfs_link(FsContext *ctx, V9fsPath *oldpath,
> +                       V9fsPath *dirpath, const char *name)
> +{
> +    int ret =3D -1;

Initialization isn't needed.

> +    V9fsString newpath;
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +   =20
> +    v9fs_string_init(&newpath);
> +    v9fs_string_sprintf(&newpath, "%s/%s", dirpath->data, name);
> +    ret =3D ceph_link(cfsdata->cmount, oldpath->data, newpath.data);
> +    trace_cephfs_link_return(oldpath->data, newpath.data, ret);
> +
> +    v9fs_string_free(&newpath);=20
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_truncate(FsContext *ctx, V9fsPath *fs_path, off_t =
size)
> +{
> +    int ret =3D -1;

Initialization isn't needed.

> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    ret =3D ceph_truncate(cfsdata->cmount, fs_path->data, size);
> +    trace_cephfs_truncate_return(fs_path->data, size, ret);
> +
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_rename(FsContext *ctx, const char *oldpath,
> +                         const char *newpath)
> +{
> +    int ret =3D -1;

Initialization isn't needed.

> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    ret =3D ceph_rename(cfsdata->cmount, oldpath, newpath);
> +    trace_cephfs_rename_return(oldpath, newpath, ret);
> +
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred=
 *credp)
> +{
> +    int ret =3D -1;

Initialization isn't needed.

> +    struct cephfs_data *cfsdata =3D fs_ctx->private;
> +
> +    ret =3D ceph_chown(cfsdata->cmount, fs_path->data, credp->fc_uid=
,
> +		    credp->fc_gid);
> +    trace_cephfs_chown_return(fs_path->data, credp->fc_uid, credp->f=
c_gid, ret);
> +
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_utimensat(FsContext *ctx, V9fsPath *fs_path,
> +                            const struct timespec *buf)
> +{
> +    int ret =3D -1;

Initialization isn't needed.

> +
> +#ifdef CONFIG_UTIMENSAT
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    ret =3D ceph_utime(cfsdata->cmount, fs_path->data, (struct utimb=
uf *)buf);
> +    trace_cephfs_utimensat_return(fs_path->data, ret);
> +#else
> +    ret =3D -1;
> +    errno =3D ENOSYS;
> +#endif
> +
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_remove(FsContext *ctx, const char *path)
> +{
> +    errno =3D EOPNOTSUPP;
> +    return -1;
> +}
> +
> +static int cephfs_fsync(FsContext *ctx, int fid_type,
> +                        V9fsFidOpenState *fs, int datasync)
> +{
> +    int ret =3D -1, fd =3D -1;

Initialization isn't needed.

> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    if (fid_type =3D=3D P9_FID_DIR) {
> +        fd =3D dirfd(fs->dir);
> +    } else {
> +        fd =3D fs->fd;
> +    }
> +    ret =3D ceph_fsync(cfsdata->cmount, fd, datasync);
> +    trace_cephfs_fsync_return(fd, datasync, ret);
> +
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_statfs(FsContext *ctx, V9fsPath *fs_path,
> +                         struct statfs *stbuf)
> +{
> +    int ret;
> +    char *path =3D fs_path->data;
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    ret =3D ceph_statfs(cfsdata->cmount, path, (struct statvfs*)stbu=
f);
> +    if (ret) {
> +        fprintf(stderr, "ceph_statfs=3D%d\n", ret);=20

error_report() with a meaningful message.

> +    }
> +
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +/*
> + * Get the extended attribute of normal file, if the path refer to a=
 symbolic
> + * link, just return the extended attributes of the syslink rather t=
han the
> + * attributes of the link itself.
> + */
> +static ssize_t cephfs_lgetxattr(FsContext *ctx, V9fsPath *fs_path,
> +                                const char *name, void *value, size_=
t size)
> +{
> +    int ret;
> +    char *path =3D fs_path->data;
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    ret =3D ceph_lgetxattr(cfsdata->cmount, path, name, value, size)=
;
> +    trace_cephfs_lgetxattr_return(path, name, ret);
> +
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static ssize_t cephfs_llistxattr(FsContext *ctx, V9fsPath *fs_path,
> +                                 void *value, size_t size)
> +{
> +    int ret =3D -1;

Initialization isn't needed.

> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    ret =3D ceph_llistxattr(cfsdata->cmount, fs_path->data, value, s=
ize);
> +    trace_cephfs_llistxattr_return(fs_path->data, ret);
> +
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_lsetxattr(FsContext *ctx, V9fsPath *fs_path, const=
 char *name,
> +                            void *value, size_t size, int flags)
> +{
> +    int ret =3D -1;

Initialization isn't needed.

> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    ret =3D ceph_lsetxattr(cfsdata->cmount, fs_path->data, name, val=
ue, size,
> +	flags);
> +    trace_cephfs_lsetxattr_return(fs_path->data, name, flags, ret);
> +
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_lremovexattr(FsContext *ctx, V9fsPath *fs_path,
> +                               const char *name)
> +{
> +    int ret =3D -1;

Initialization isn't needed.

> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    ret =3D ceph_lremovexattr(cfsdata->cmount, fs_path->data, name);
> +    trace_cephfs_lremovexattr_return(fs_path->data, name, ret);
> +
> +    return ret;

Set errno and return -1 on error.

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
> +    /* Bump the size for including terminating NULL */=20
> +    target->size++;
> +    return 0;
> +}
> +
> +static int cephfs_renameat(FsContext *ctx, V9fsPath *olddir,
> +                           const char *old_name, V9fsPath *newdir,
> +                           const char *new_name)
> +{
> +    int ret =3D -1;

Initialization isn't needed.

> +    struct cephfs_data *cfsdata =3D ctx->private;
> +   =20
> +    ret =3D ceph_rename(cfsdata->cmount, old_name, new_name);
> +    trace_cephfs_renameat_return(old_name, new_name, ret);
> +
> +    return ret;

Set errno and return -1 on error.

> +}
> +
> +static int cephfs_unlinkat(FsContext *ctx, V9fsPath *dir,
> +                           const char *name, int flags)
> +{
> +    int ret =3D 0;

Initialization isn't needed.

> +    char *path =3D dir->data;
> +    struct stat fstat;
> +    V9fsString fullname;
> +    struct cephfs_data *cfsdata =3D ctx->private;
> +
> +    v9fs_string_init(&fullname);
> +    v9fs_string_sprintf(&fullname, "%s/%s", dir->data, name);
> +    path =3D fullname.data;
> +    /* determine which kind of file is being destroyed */=20
> +    ret =3D ceph_lstat(cfsdata->cmount, path, &fstat);
> +    if (!ret) {
> +        switch (fstat.st_mode & S_IFMT) {
> +        case S_IFDIR:
> +            ret =3D ceph_rmdir(cfsdata->cmount, path);
> +            break;
> +
> +        case S_IFBLK:
> +        case S_IFCHR:
> +        case S_IFIFO:
> +        case S_IFLNK:
> +        case S_IFREG:
> +        case S_IFSOCK:
> +            ret =3D ceph_unlink(cfsdata->cmount, path);
> +            break;
> +
> +        default:
> +            fprintf(stderr, "ceph_lstat unknown stmode\n");

error_report()

> +            break;
> +        }
> +    } else {
> +        errno =3D -ret;
> +        ret =3D -1;
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
> + * 2) Invoke ceph_mount() to initialize a link between the client an=
d=20
> + *    ceph monitor
> + */
> +static int cephfs_init(FsContext *ctx)
> +{
> +    int ret;
> +    const char *ver =3D NULL;
> +    struct cephfs_data *data =3D g_malloc(sizeof(struct cephfs_data)=
);
> +
> +    if (data =3D=3D NULL) {
> +	errno =3D ENOMEM;
> +	return -1;
> +    }
> +    trace_cephfs_init(ctx->fs_root);
> +    memset(data, 0, sizeof(struct cephfs_data));
> +    ret =3D ceph_create(&data->cmount, NULL);
> +    if (ret) {
> +        fprintf(stderr, "ceph_create=3D%d\n", ret);

error_report()

> +        goto err_out;
> +    }
> +
> +    ret =3D ceph_conf_read_file(data->cmount, NULL);
> +    if (ret) {
> +        fprintf(stderr, "ceph_conf_read_file=3D%d\n", ret);

error_report()

> +        goto err_out;
> +    }
> +
> +    ret =3D ceph_mount(data->cmount, ctx->fs_root);
> +    if (ret) {
> +        fprintf(stderr, "ceph_mount=3D%d\n", ret);

error_report()

> +        goto err_out;
> +    } else {
> +        ctx->private =3D data;
> +	/* CephFS does not support FS_IOC_GETVERSIO */=20
> +	ctx->exops.get_st_gen =3D NULL;
> +        goto out;
> +    }
> +
> +    ver =3D ceph_version(&data->major, &data->minor, &data->patch);
> +    memcpy(data->ceph_version, ver, strlen(ver) + 1);
> +   =20
> +err_out:
> +    g_free(data);
> +out:
> +    return ret;
> +}
> +
> +static int cephfs_parse_opts(QemuOpts *opts, struct FsDriverEntry *f=
se)
> +{
> +    const char *sec_model =3D qemu_opt_get(opts, "security_model");
> +    const char *path =3D qemu_opt_get(opts, "path");
> +
> +    if (!sec_model) {
> +        fprintf(stderr, "Invalid argument security_model specified w=
ith "
> +		"cephfs fsdriver\n");
> +        return -1;
> +    }
> +
> +    if (!path) {
> +        fprintf(stderr, "fsdev: No path specified.\n");
> +        return -1;
> +    }
> +
> +    fse->path =3D g_strdup(path);
> +    return 0;
> +}
> +
> +FileOperations cephfs_ops =3D {
> +    .parse_opts   =3D cephfs_parse_opts,
> +    .init         =3D cephfs_init,
> +    .lstat        =3D cephfs_lstat,
> +    .readlink     =3D cephfs_readlink,
> +    .close        =3D cephfs_close,
> +    .closedir     =3D cephfs_closedir,
> +    .open         =3D cephfs_open,
> +    .opendir      =3D cephfs_opendir,
> +    .rewinddir    =3D cephfs_rewinddir,
> +    .telldir      =3D cephfs_telldir,
> +    .readdir_r    =3D cephfs_readdir_r,
> +    .seekdir      =3D cephfs_seekdir,
> +    .preadv       =3D cephfs_preadv,
> +    .pwritev      =3D cephfs_pwritev,
> +    .chmod        =3D cephfs_chmod,
> +    .mknod        =3D cephfs_mknod,
> +    .mkdir        =3D cephfs_mkdir,
> +    .fstat        =3D cephfs_fstat,
> +    .open2        =3D cephfs_open2,
> +    .symlink      =3D cephfs_symlink,
> +    .link         =3D cephfs_link,
> +    .truncate     =3D cephfs_truncate,
> +    .rename       =3D cephfs_rename,
> +    .chown        =3D cephfs_chown,
> +    .utimensat    =3D cephfs_utimensat,
> +    .remove       =3D cephfs_remove,
> +    .fsync        =3D cephfs_fsync,
> +    .statfs       =3D cephfs_statfs,
> +    .lgetxattr    =3D cephfs_lgetxattr,
> +    .llistxattr   =3D cephfs_llistxattr,
> +    .lsetxattr    =3D cephfs_lsetxattr,
> +    .lremovexattr =3D cephfs_lremovexattr,
> +    .name_to_path =3D cephfs_name_to_path,
> +    .renameat     =3D cephfs_renameat,
> +    .unlinkat     =3D cephfs_unlinkat,
> +};
> diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
> index da0ae0c..a77a6f4 100644
> --- a/hw/9pfs/Makefile.objs
> +++ b/hw/9pfs/Makefile.objs
> @@ -5,5 +5,8 @@ common-obj-y +=3D coth.o cofs.o codir.o cofile.o
>  common-obj-y +=3D coxattr.o 9p-synth.o
>  common-obj-$(CONFIG_OPEN_BY_HANDLE) +=3D  9p-handle.o
>  common-obj-y +=3D 9p-proxy.o
> +common-obj-y +=3D 9p-cephfs.o
>=20
>  obj-y +=3D virtio-9p-device.o
> +
> +9p-cephfs.o-libs :=3D $(CEPHFS_LIBS)
> diff --git a/scripts/analyse-9p-simpletrace.py b/scripts/analyse-9p-s=
impletrace.py
> index 3c3dee4..fe0a496 100755
> --- a/scripts/analyse-9p-simpletrace.py
> +++ b/scripts/analyse-9p-simpletrace.py

Even if both spellings are correct according to http://www.thefreedicti=
onary.com/,
it seems that the QEMU code only uses analyze currently. Please rename =
for consistency.

> @@ -210,4 +210,100 @@ class VirtFSRequestTracker(simpletrace.Analyzer=
):
>          def v9fs_readlink_return(self, tag, id, target):
>                  print "RREADLINK (tag =3D", tag, ", target =3D", tar=
get, ")"
>=20
> +	def cephfs_lstat_return(self, path, stmode, stuid, stgid, stsize, r=
et):
> +		print "RCEPHFSLSTAT (path =3D", path, ", stmode =3D", stmode, ", s=
tuid =3D", stuid, ", stgid =3D", stgid, ", stsize =3D", stsize, ", ret =
=3D", ret, ")"
> +
> +	def cephfs_readlink_return(self, path, ret):
> +		print "RCEPHFSREADLINK (path =3D", path, ", ret =3D", ret, ")"
> +
> +	def cephfs_open_return(self, path, flags, mode, fd):
> +		print "RCEPHFSOPEN (path =3D", path, ", flags =3D", flags, ", mode=
 =3D", mode, ", fd =3D", fd, ")"
> +
> +	def cephfs_opendir_return(self, path, ret):
> +		print "RCEPHFSOPENDIR (path =3D", path, ", ret =3D", ret, ")"
> +
> +	def cephfs_rewinddir(self, dir):
> +		print "TCEPHFSREWINDDIR (dir =3D", dir, ")"
> +
> +	def cephfs_telldir(self, dir):
> +		print "TCEPHFSTELLDIR (dir =3D", dir, ")"
> +
> +	def cephfs_readdir_r_return(self, tmpent, entry, ret):
> +		print "RCEPHFSREADDIRR (tmpent =3D", tmpent, ", entry =3D", entry,=
 ", ret =3D", ret, ")"
> +
> +	def cephfs_seekdir(self, dir, off):
> +		print "TCEPHFSSEEKDIR (dir =3D", dir, ", off =3D", off, ")"
> +
> +	def cephfs_preadv(self, iovcnt, len):
> +		print "TCEPHFSPREADV (iovcnt=3D", iovcnt, ", len =3D", len, ")"
> +
> +	def cephfs_preadv_return(self, iovcnt, len, ret):
> +		print "RCEPHFSPREADV (iovcnt=3D", iovcnt, ", len =3D", len, ", ret=
 =3D ", ret, ")"
> +
> +	def cephfs_pwritev(self, iovcnt, len, offset):
> +		print "TCEPHFSPWRITEV (iovcnt=3D", iovcnt, ", len =3D", len, ", of=
fset =3D", offset, ")"
> +
> +	def cephfs_pwritev_return(self, iovcnt, len, offset, ret):
> +		print "RCEPHFSPWRITEV (iovcnt=3D", iovcnt, ", len =3D", len, ", of=
fset =3D", offset, ", ret =3D ", ret, ")"
> +
> +	def cephfs_chmod(self, path, fcmode):
> +		print "TCEPHFSCHMOD (path =3D", path, ", fcmode =3D", fcmode, ")"
> +
> +	def cephfs_chmod_return(self, path, fcmode, ret):
> +		print "RCEPHFSCHMOD (path =3D", path, ", fcmode =3D", fcmode, ", r=
et =3D", ret, ")"
> +
> +	def cephfs_mknod_return(self, path, fcmode, fcrdev, ret):
> +		print "RCEPHFSMKNOD (path =3D", path, ", fcmode =3D", fcmode, ", f=
crdev =3D", fcrdev, ", ret =3D", ret, ")"
> +
> +	def cephfs_mkdir_return(self, path, fcmode, ret):
> +		print "RCEPHFSMKDIR (path =3D", path, ", fcmode =3D", fcmode, ", r=
et =3D", ret, ")"
> +
> +	def cephfs_fstat_return(self, fidtype, fd, stuid, stgid, stsize, re=
t):
> +		print "RCEPHFSFSTAT (fidtype =3D", fidtype, ", fd =3D", fd, ", stu=
id =3D", stuid, ", stgid =3D", stgid, ", stsize =3D", stsize, ", ret =3D=
", ret, ")"
> +
> +	def cephfs_open2_return(self, path, flags, fcmode):
> +		print "RCEPHFSOPEN2 (path =3D", path, ", flags =3D", flags, "fcmod=
e =3D", fcmode, ")"
> +
> +	def cephfs_symlink_return(self, oldpath, path, ret):
> +		print "RCEPHFSSYMLINK (oldpath =3D", oldpath, ", path =3D", path, =
", ret =3D", ret, ")"
> +
> +	def cephfs_link_return(self, oldpath, path, ret):
> +		print "RCEPHFSLINK (oldpath =3D", oldpath, ", path =3D", path, ", =
ret =3D", ret, ")"
> +
> +	def cephfs_truncate_return(self, path, size, ret):
> +		print "RCEPHFSTRUNCATE (path =3D", path, ", size =3D", size, ", re=
t =3D", ret, ")"
> +
> +	def cephfs_rename_return(self, oldpath, newpath, ret):
> +		print "RCEPHFSRENAME (oldpath =3D", oldpath, ", newpath =3D", newp=
ath, ", ret =3D", ret, ")"
> +
> +	def cephfs_chown_return(self, path, fcuid, fcgid, ret):
> +		print "RCEPHFSCHOWN (path =3D", path, ", fcuid =3D", fcuid, ", fcg=
id =3D", fcgid, ", ret =3D", ret, ")"
> +
> +	def cephfs_utimensat_return(self, path, ret):
> +		print "RCEPHFSUTIMENSAT (path =3D", path, ", ret =3D", ret, ")"
> +
> +	def cephfs_fsync_return(self, fd, datasync, ret):
> +		print "RCEPHFSFSYNC (fd =3D", fd, ", datasync =3D", datasync, ", r=
et =3D", ret, ")"
> +
> +	def cephfs_lgetxattr_return(self, path, name, ret):
> +		print "RCEPHFSLGETXATTR (path =3D", path, ", name =3D", name, ", r=
et =3D", ret, ")"
> +
> +	def cephfs_llistxattr_return(self, path, ret):
> +		print "RCEPHFSLLISTXATTR (path =3D", path, ", ret =3D", ret, ")"
> +
> +	def cephfs_lsetxattr_return(self, path, name, flags, ret):
> +		print "RCEPHFSLSETXATTR (path =3D", path, ", name =3D", name, ", f=
lags =3D", flags, ", ret =3D", ret, ")"
> +
> +	def cephfs_lremovexattr_return(self, path, name, ret):
> +		print "RCEPHFSLREMOVEXATTR (path =3D", path, ", name =3D", name, "=
, ret =3D", ret, ")"
> +
> +	def cephfs_renameat_return(self, oldname, newname, ret):
> +		print "RCEPHFSRENAMEAT (oldname =3D", oldname, ", newname =3D", ne=
wname, ", ret =3D", ret, ")"
> +
> +	def cephfs_unlinkat_return(self, path, stmode, ret):
> +		print "RCEPHFSUNLINKAT (path =3D", path, ", stmode =3D", stmode, "=
, ret =3D", ret, ")"
> +
> +	def cephfs_init(self, path):
> +		print "RCEPHFSINIT (path =3D", path, ")"
> +
>  simpletrace.run(VirtFSRequestTracker())
> diff --git a/trace-events b/trace-events
> index 6fba6cc..11879d2 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -1118,6 +1118,39 @@ v9fs_xattrcreate(uint16_t tag, uint8_t id, int=
32_t fid, char* name, int64_t size
>  v9fs_readlink(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d f=
id %d"
>  v9fs_readlink_return(uint16_t tag, uint8_t id, char* target) "tag %d=
 id %d name %s"
>=20
> +# hw/9pfs/9p-cephfs.c=20
> +cephfs_lstat_return(char *path, int stmode, int stuid, int stgid, in=
t stsize, int ret) "path %s stmode %d stuid %d stgid %d stsize %d ret %=
d"
> +cephfs_readlink_return(char *path, int ret) "path %s ret %d"
> +cephfs_open_return(char *path, int flags, int mode, int fd) "path %s=
 flags %d mode %d fd %d"
> +cephfs_opendir_return(char *path, int ret) "path %s ret %d"
> +cephfs_rewinddir(void *dir) "dir %p"
> +cephfs_telldir(void *dir) "dir %p"
> +cephfs_readdir_r_return(void *tmpent, void *entry, int ret) "tmpent =
%p entry %p ret %d"
> +cephfs_seekdir(void *dir, int off) "dir %p off %d"
> +cephfs_preadv(int iovcnt, int len) "iovcnt %d len %d"
> +cephfs_preadv_return(int iovcnt, int len, long ret) "iovcnt %d len %=
d ret %l"

ret %ld

> +cephfs_pwritev(int iovcnt, int len, int offset) "iovcnt %d len %d of=
fset %d"
> +cephfs_pwritev_return(int iovcnt, int len, int offset, long ret) "io=
vcnt %d len %d offset %d ret %l"cephfs_chmod(char *path, int fcmode) "p=
ath %s fcmode %d"

ret %ld for cephfs_pwritev_return() and missing newline before cephfs_c=
hmod()

I'm wondering if this patch was build tested before being posted to the=
 list.

> +cephfs_chmod_return(char *path, int fcmode, int ret) "path %s fcmode=
 %d ret %d"
> +cephfs_mknod_return(char *path, int fcmode, uint32_t fcrdev, int ret=
) "path %s fcmode %d fcrdev %u ret %d"
> +cephfs_mkdir_return(char *path, int fcmode, int ret) " path %s fcmod=
e %d ret %d"
> +cephfs_fstat_return(int fidtype, int fd, int stuid, int stgid, int s=
tsize, int ret) "fidtype %d fd %d stuid %d stgid %d stsize %d ret %d"
> +cephfs_open2_return(char *path, int flags, int fcmode) "path %s flag=
s %d fcmode %d"
> +cephfs_symlink_return(const char *oldpath, char *path, int ret) "old=
path %s path %s ret %d"
> +cephfs_link_return(char *oldpath, char *path, int ret) "oldpath %s p=
ath %s ret %d"
> +cephfs_truncate_return(char *path, int size, int ret) "path %s size =
%d ret %d"
> +cephfs_rename_return(const char *oldpath, const char *newpath, int r=
et) "oldpath %s newpath %s ret %d"
> +cephfs_chown_return(char *path, int fcuid, int fcgid, int ret) "path=
 %s fcuid %d fcgid %d ret %d"
> +cephfs_utimensat_return(char *path, int ret) "path %s ret %d"
> +cephfs_fsync_return(int fd, int datasync, int ret) "fd %d datasync %=
d ret %d"
> +cephfs_lgetxattr_return(char *path, const char *name, int ret) "path=
 %s name %s ret %d"
> +cephfs_llistxattr_return(char *path, int ret) "path %s ret %d"
> +cephfs_lsetxattr_return(char *path, const char *name, int flags, int=
 ret) "path %s name %s flags %d ret %d"
> +cephfs_lremovexattr_return(char *path, const char *name, int ret) "p=
ath %s name %s ret %d"
> +cephfs_renameat_return(const char *oldname, const char *newname, int=
 ret) "oldname %s newname %s ret %d"
> +cephfs_unlinkat_return(char *path, int stmode, int ret) "path %s stm=
ode %d ret %d"
> +cephfs_init(char *path) "path %s"
> +
>  # target-sparc/mmu_helper.c
>  mmu_helper_dfault(uint64_t address, uint64_t context, int mmu_idx, u=
int32_t tl) "DFAULT at %"PRIx64" context %"PRIx64" mmu_idx=3D%d tl=3D%d=
"
>  mmu_helper_dprot(uint64_t address, uint64_t context, int mmu_idx, ui=
nt32_t tl) "DPROT at %"PRIx64" context %"PRIx64" mmu_idx=3D%d tl=3D%d"

--=20
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.c=
om
Software Engineer @ IBM/LTC                      http://www.ibm.com
Tel 33-5-6218-1607

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
