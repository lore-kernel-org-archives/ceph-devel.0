From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: [PATCH 1/2] support for xattrs in libceph
Date: Tue, 10 May 2011 12:44:50 -0700
Message-ID: <BANLkTin=Pmsb2v5J+OPS_f5kW6ZCyN=xSQ@mail.gmail.com>
References: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
	<1305056329-482-2-git-send-email-brchrisman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39333 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab1EJTox convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 15:44:53 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id F2B2DC068
	for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 12:44:52 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 7C165C066
	for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 12:44:52 -0700 (PDT)
Received: by ewy4 with SMTP id 4so1932557ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 12:44:50 -0700 (PDT)
In-Reply-To: <1305056329-482-2-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel@vger.kernel.org

What are the 'l'-prefixed functions for? They look like they're just
duplicates except for the prefix.
-Greg

On Tue, May 10, 2011 at 12:38 PM, Brian Chrisman <brchrisman@gmail.com>=
 wrote:
> From: Brian Chrisman <bchrisman@gmail.com>
>
>
> Signed-off-by: Brian Chrisman <brchrisman@gmail.com>
> ---
> =A0src/client/Client.cc =A0 =A0 =A0 | =A0 67 ++++++++++++++++++++++++=
+++++++++++++++++++-
> =A0src/client/Client.h =A0 =A0 =A0 =A0| =A0 10 ++++++
> =A0src/include/ceph/libceph.h | =A0 15 ++++++++++
> =A0src/libceph.cc =A0 =A0 =A0 =A0 =A0 =A0 | =A0 42 ++++++++++++++++++=
+++++++++
> =A04 files changed, 133 insertions(+), 1 deletions(-)
>
> diff --git a/src/client/Client.cc b/src/client/Client.cc
> index 6a27273..5083e99 100644
> --- a/src/client/Client.cc
> +++ b/src/client/Client.cc
> @@ -5563,6 +5563,71 @@ int Client::ll_setattr(vinodeno_t vino, struct=
 stat *attr, int mask, int uid, in
> =A0// ----------
> =A0// xattrs
>
> +int Client::getxattr(const char *path, const char *name, void *value=
, size_t size)
> +{
> + =A0Mutex::Locker lock(client_lock);
> + =A0Inode *ceph_inode;
> + =A0Client::path_walk(path, &ceph_inode, true);
> + =A0return Client::_getxattr(ceph_inode, name, value, size, getuid()=
, getgid());
> +}
> +
> +int Client::lgetxattr(const char *path, const char *name, void *valu=
e, size_t size)
> +{
> + =A0Mutex::Locker lock(client_lock);
> + =A0Inode *ceph_inode;
> + =A0Client::path_walk(path, &ceph_inode, false);
> + =A0return Client::_getxattr(ceph_inode, name, value, size, getuid()=
, getgid());
> +}
> +
> +int Client::listxattr(const char *path, char *list, size_t size)
> +{
> + =A0Mutex::Locker lock(client_lock);
> + =A0Inode *ceph_inode;
> + =A0Client::path_walk(path, &ceph_inode, true);
> + =A0return Client::_listxattr(ceph_inode, list, size, getuid(), getg=
id());
> +}
> +
> +int Client::llistxattr(const char *path, char *list, size_t size)
> +{
> + =A0Mutex::Locker lock(client_lock);
> + =A0Inode *ceph_inode;
> + =A0Client::path_walk(path, &ceph_inode, false);
> + =A0return Client::_listxattr(ceph_inode, list, size, getuid(), getg=
id());
> +}
> +
> +int Client::removexattr(const char *path, const char *name)
> +{
> + =A0Mutex::Locker lock(client_lock);
> + =A0Inode *ceph_inode;
> + =A0Client::path_walk(path, &ceph_inode, true);
> + =A0return Client::_removexattr(ceph_inode, name, getuid(), getgid()=
);
> +}
> +
> +int Client::lremovexattr(const char *path, const char *name)
> +{
> + =A0Mutex::Locker lock(client_lock);
> + =A0Inode *ceph_inode;
> + =A0Client::path_walk(path, &ceph_inode, false);
> + =A0return Client::_removexattr(ceph_inode, name, getuid(), getgid()=
);
> +}
> +
> +int Client::setxattr(const char *path, const char *name, const void =
*value, size_t size, int flags)
> +{
> + =A0Mutex::Locker lock(client_lock);
> + =A0Inode *ceph_inode;
> + =A0Client::path_walk(path, &ceph_inode, true);
> + =A0return Client::_setxattr(ceph_inode, name, value, size, flags, g=
etuid(), getgid());
> +}
> +
> +int Client::lsetxattr(const char *path, const char *name, const void=
 *value, size_t size, int flags)
> +{
> + =A0Mutex::Locker lock(client_lock);
> + =A0Inode *ceph_inode;
> + =A0Client::path_walk(path, &ceph_inode, false);
> + =A0return Client::_setxattr(ceph_inode, name, value, size, flags, g=
etuid(), getgid());
> +}
> +
> +
> =A0int Client::_getxattr(Inode *in, const char *name, void *value, si=
ze_t size,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int uid, int gid)
> =A0{
> @@ -5708,7 +5773,7 @@ int Client::ll_removexattr(vinodeno_t vino, con=
st char *name, int uid, int gid)
> =A0 tout << name << std::endl;
>
> =A0 // only user xattrs, for now
> - =A0if (strncmp(name, "user.", 5))
> + =A0if (strncmp(name, "user.", 5) && strncmp(name, "security.", 9) &=
& strncmp(name, "trusted.", 8))
> =A0 =A0 return -EOPNOTSUPP;
>
> =A0 Inode *in =3D _ll_get_inode(vino);
> diff --git a/src/client/Client.h b/src/client/Client.h
> index ab21dc8..b36621d 100644
> --- a/src/client/Client.h
> +++ b/src/client/Client.h
> @@ -1258,6 +1258,16 @@ public:
> =A0 int fsync(int fd, bool syncdataonly);
> =A0 int fstat(int fd, struct stat *stbuf);
>
> + =A0// full path xattr ops
> + =A0int getxattr(const char *path, const char *name, void *value, si=
ze_t size);
> + =A0int lgetxattr(const char *path, const char *name, void *value, s=
ize_t size);
> + =A0int listxattr(const char *path, char *list, size_t size);
> + =A0int llistxattr(const char *path, char *list, size_t size);
> + =A0int removexattr(const char *path, const char *name);
> + =A0int lremovexattr(const char *path, const char *name);
> + =A0int setxattr(const char *path, const char *name, const void *val=
ue, size_t size, int flags);
> + =A0int lsetxattr(const char *path, const char *name, const void *va=
lue, size_t size, int flags);
> +
> =A0 int sync_fs();
> =A0 int64_t drop_caches();
>
> diff --git a/src/include/ceph/libceph.h b/src/include/ceph/libceph.h
> index 3ed3369..f9fc29e 100644
> --- a/src/include/ceph/libceph.h
> +++ b/src/include/ceph/libceph.h
> @@ -121,6 +121,21 @@ int ceph_fstat(struct ceph_mount_info *cmount, i=
nt fd, struct stat *stbuf);
>
> =A0int ceph_sync_fs(struct ceph_mount_info *cmount);
>
> +/* xattr support */
> +int ceph_getxattr(struct ceph_mount_info *cmount, const char *path, =
const char *name,
> + =A0 =A0 =A0 void *value, size_t size);
> +int ceph_lgetxattr(struct ceph_mount_info *cmount, const char *path,=
 const char *name,
> + =A0 =A0 =A0 void *value, size_t size);
> +int ceph_listxattr(struct ceph_mount_info *cmount, const char *path,=
 char *list, size_t size);
> +int ceph_llistxattr(struct ceph_mount_info *cmount, const char *path=
, char *list, size_t size);
> +int ceph_removexattr(struct ceph_mount_info *cmount, const char *pat=
h, const char *name);
> +int ceph_lremovexattr(struct ceph_mount_info *cmount, const char *pa=
th, const char *name);
> +int ceph_setxattr(struct ceph_mount_info *cmount, const char *path, =
const char *name,
> + =A0 =A0 =A0 const void *value, size_t size, int flags);
> +int ceph_lsetxattr(struct ceph_mount_info *cmount, const char *path,=
 const char *name,
> + =A0 =A0 =A0 const void *value, size_t size, int flags);
> +
> +
>
> =A0/* expose file layout */
> =A0int ceph_get_file_stripe_unit(struct ceph_mount_info *cmount, int =
fh);
> diff --git a/src/libceph.cc b/src/libceph.cc
> index d1143d6..6388bde 100644
> --- a/src/libceph.cc
> +++ b/src/libceph.cc
> @@ -416,6 +416,48 @@ extern "C" int ceph_setattr(struct ceph_mount_in=
fo *cmount, const char *relpath,
> =A0 return cmount->get_client()->setattr(relpath, attr, mask);
> =A0}
>
> +// *xattr() calls supporting samba/vfs
> +extern "C" int ceph_getxattr(struct ceph_mount_info *cmount, const c=
har *path, const char *name, void *value, size_t size)
> +{
> + =A0return cmount->get_client()->getxattr(path, name, value, size);
> +}
> +
> +extern "C" int ceph_lgetxattr(struct ceph_mount_info *cmount, const =
char *path, const char *name, void *value, size_t size)
> +{
> + =A0return cmount->get_client()->lgetxattr(path, name, value, size);
> +}
> +
> +extern "C" int ceph_listxattr(struct ceph_mount_info *cmount, const =
char *path, char *list, size_t size)
> +{
> + =A0return cmount->get_client()->listxattr(path, list, size);
> +}
> +
> +extern "C" int ceph_llistxattr(struct ceph_mount_info *cmount, const=
 char *path, char *list, size_t size)
> +{
> + =A0return cmount->get_client()->llistxattr(path, list, size);
> +}
> +
> +extern "C" int ceph_removexattr(struct ceph_mount_info *cmount, cons=
t char *path, const char *name)
> +{
> + =A0return cmount->get_client()->removexattr(path, name);
> +}
> +
> +extern "C" int ceph_lremovexattr(struct ceph_mount_info *cmount, con=
st char *path, const char *name)
> +{
> + =A0return cmount->get_client()->lremovexattr(path, name);
> +}
> +
> +extern "C" int ceph_setxattr(struct ceph_mount_info *cmount, const c=
har *path, const char *name, const void *value, size_t size, int flags)
> +{
> + =A0return cmount->get_client()->setxattr(path, name, value, size, f=
lags);
> +}
> +
> +extern "C" int ceph_lsetxattr(struct ceph_mount_info *cmount, const =
char *path, const char *name, const void *value, size_t size, int flags=
)
> +{
> + =A0return cmount->get_client()->lsetxattr(path, name, value, size, =
flags);
> +}
> +/* end xattr support */
> +
> =A0extern "C" int ceph_chmod(struct ceph_mount_info *cmount, const ch=
ar *path, mode_t mode)
> =A0{
> =A0 return cmount->get_client()->chmod(path, mode);
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
