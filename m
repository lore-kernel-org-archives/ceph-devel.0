From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: [PATCH 1/2] support for xattrs in libceph
Date: Tue, 10 May 2011 13:22:48 -0700
Message-ID: <BANLkTinQA+rc4=UaknJopb+h3CG4diDskQ@mail.gmail.com>
References: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
	<1305056329-482-2-git-send-email-brchrisman@gmail.com>
	<BANLkTin=Pmsb2v5J+OPS_f5kW6ZCyN=xSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56950 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab1EJUWt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 16:22:49 -0400
Received: by vxi39 with SMTP id 39so6994838vxi.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 13:22:49 -0700 (PDT)
In-Reply-To: <BANLkTin=Pmsb2v5J+OPS_f5kW6ZCyN=xSQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

They differentiate between xattrs on symlinks or on the files at which
they point.
If I recall, it's a slight difference internally to the Client class
whether a value is passed to path_walk as true/false, though I may be
misinterpreting that.  I can look at that again.

On Tue, May 10, 2011 at 12:44 PM, Gregory Farnum <gregf@hq.newdream.net=
> wrote:
> What are the 'l'-prefixed functions for? They look like they're just
> duplicates except for the prefix.
> -Greg
>
> On Tue, May 10, 2011 at 12:38 PM, Brian Chrisman <brchrisman@gmail.co=
m> wrote:
>> From: Brian Chrisman <bchrisman@gmail.com>
>>
>>
>> Signed-off-by: Brian Chrisman <brchrisman@gmail.com>
>> ---
>> =A0src/client/Client.cc =A0 =A0 =A0 | =A0 67 +++++++++++++++++++++++=
++++++++++++++++++++-
>> =A0src/client/Client.h =A0 =A0 =A0 =A0| =A0 10 ++++++
>> =A0src/include/ceph/libceph.h | =A0 15 ++++++++++
>> =A0src/libceph.cc =A0 =A0 =A0 =A0 =A0 =A0 | =A0 42 +++++++++++++++++=
++++++++++
>> =A04 files changed, 133 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/client/Client.cc b/src/client/Client.cc
>> index 6a27273..5083e99 100644
>> --- a/src/client/Client.cc
>> +++ b/src/client/Client.cc
>> @@ -5563,6 +5563,71 @@ int Client::ll_setattr(vinodeno_t vino, struc=
t stat *attr, int mask, int uid, in
>> =A0// ----------
>> =A0// xattrs
>>
>> +int Client::getxattr(const char *path, const char *name, void *valu=
e, size_t size)
>> +{
>> + =A0Mutex::Locker lock(client_lock);
>> + =A0Inode *ceph_inode;
>> + =A0Client::path_walk(path, &ceph_inode, true);
>> + =A0return Client::_getxattr(ceph_inode, name, value, size, getuid(=
), getgid());
>> +}
>> +
>> +int Client::lgetxattr(const char *path, const char *name, void *val=
ue, size_t size)
>> +{
>> + =A0Mutex::Locker lock(client_lock);
>> + =A0Inode *ceph_inode;
>> + =A0Client::path_walk(path, &ceph_inode, false);
>> + =A0return Client::_getxattr(ceph_inode, name, value, size, getuid(=
), getgid());
>> +}
>> +
>> +int Client::listxattr(const char *path, char *list, size_t size)
>> +{
>> + =A0Mutex::Locker lock(client_lock);
>> + =A0Inode *ceph_inode;
>> + =A0Client::path_walk(path, &ceph_inode, true);
>> + =A0return Client::_listxattr(ceph_inode, list, size, getuid(), get=
gid());
>> +}
>> +
>> +int Client::llistxattr(const char *path, char *list, size_t size)
>> +{
>> + =A0Mutex::Locker lock(client_lock);
>> + =A0Inode *ceph_inode;
>> + =A0Client::path_walk(path, &ceph_inode, false);
>> + =A0return Client::_listxattr(ceph_inode, list, size, getuid(), get=
gid());
>> +}
>> +
>> +int Client::removexattr(const char *path, const char *name)
>> +{
>> + =A0Mutex::Locker lock(client_lock);
>> + =A0Inode *ceph_inode;
>> + =A0Client::path_walk(path, &ceph_inode, true);
>> + =A0return Client::_removexattr(ceph_inode, name, getuid(), getgid(=
));
>> +}
>> +
>> +int Client::lremovexattr(const char *path, const char *name)
>> +{
>> + =A0Mutex::Locker lock(client_lock);
>> + =A0Inode *ceph_inode;
>> + =A0Client::path_walk(path, &ceph_inode, false);
>> + =A0return Client::_removexattr(ceph_inode, name, getuid(), getgid(=
));
>> +}
>> +
>> +int Client::setxattr(const char *path, const char *name, const void=
 *value, size_t size, int flags)
>> +{
>> + =A0Mutex::Locker lock(client_lock);
>> + =A0Inode *ceph_inode;
>> + =A0Client::path_walk(path, &ceph_inode, true);
>> + =A0return Client::_setxattr(ceph_inode, name, value, size, flags, =
getuid(), getgid());
>> +}
>> +
>> +int Client::lsetxattr(const char *path, const char *name, const voi=
d *value, size_t size, int flags)
>> +{
>> + =A0Mutex::Locker lock(client_lock);
>> + =A0Inode *ceph_inode;
>> + =A0Client::path_walk(path, &ceph_inode, false);
>> + =A0return Client::_setxattr(ceph_inode, name, value, size, flags, =
getuid(), getgid());
>> +}
>> +
>> +
>> =A0int Client::_getxattr(Inode *in, const char *name, void *value, s=
ize_t size,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int uid, int gid)
>> =A0{
>> @@ -5708,7 +5773,7 @@ int Client::ll_removexattr(vinodeno_t vino, co=
nst char *name, int uid, int gid)
>> =A0 tout << name << std::endl;
>>
>> =A0 // only user xattrs, for now
>> - =A0if (strncmp(name, "user.", 5))
>> + =A0if (strncmp(name, "user.", 5) && strncmp(name, "security.", 9) =
&& strncmp(name, "trusted.", 8))
>> =A0 =A0 return -EOPNOTSUPP;
>>
>> =A0 Inode *in =3D _ll_get_inode(vino);
>> diff --git a/src/client/Client.h b/src/client/Client.h
>> index ab21dc8..b36621d 100644
>> --- a/src/client/Client.h
>> +++ b/src/client/Client.h
>> @@ -1258,6 +1258,16 @@ public:
>> =A0 int fsync(int fd, bool syncdataonly);
>> =A0 int fstat(int fd, struct stat *stbuf);
>>
>> + =A0// full path xattr ops
>> + =A0int getxattr(const char *path, const char *name, void *value, s=
ize_t size);
>> + =A0int lgetxattr(const char *path, const char *name, void *value, =
size_t size);
>> + =A0int listxattr(const char *path, char *list, size_t size);
>> + =A0int llistxattr(const char *path, char *list, size_t size);
>> + =A0int removexattr(const char *path, const char *name);
>> + =A0int lremovexattr(const char *path, const char *name);
>> + =A0int setxattr(const char *path, const char *name, const void *va=
lue, size_t size, int flags);
>> + =A0int lsetxattr(const char *path, const char *name, const void *v=
alue, size_t size, int flags);
>> +
>> =A0 int sync_fs();
>> =A0 int64_t drop_caches();
>>
>> diff --git a/src/include/ceph/libceph.h b/src/include/ceph/libceph.h
>> index 3ed3369..f9fc29e 100644
>> --- a/src/include/ceph/libceph.h
>> +++ b/src/include/ceph/libceph.h
>> @@ -121,6 +121,21 @@ int ceph_fstat(struct ceph_mount_info *cmount, =
int fd, struct stat *stbuf);
>>
>> =A0int ceph_sync_fs(struct ceph_mount_info *cmount);
>>
>> +/* xattr support */
>> +int ceph_getxattr(struct ceph_mount_info *cmount, const char *path,=
 const char *name,
>> + =A0 =A0 =A0 void *value, size_t size);
>> +int ceph_lgetxattr(struct ceph_mount_info *cmount, const char *path=
, const char *name,
>> + =A0 =A0 =A0 void *value, size_t size);
>> +int ceph_listxattr(struct ceph_mount_info *cmount, const char *path=
, char *list, size_t size);
>> +int ceph_llistxattr(struct ceph_mount_info *cmount, const char *pat=
h, char *list, size_t size);
>> +int ceph_removexattr(struct ceph_mount_info *cmount, const char *pa=
th, const char *name);
>> +int ceph_lremovexattr(struct ceph_mount_info *cmount, const char *p=
ath, const char *name);
>> +int ceph_setxattr(struct ceph_mount_info *cmount, const char *path,=
 const char *name,
>> + =A0 =A0 =A0 const void *value, size_t size, int flags);
>> +int ceph_lsetxattr(struct ceph_mount_info *cmount, const char *path=
, const char *name,
>> + =A0 =A0 =A0 const void *value, size_t size, int flags);
>> +
>> +
>>
>> =A0/* expose file layout */
>> =A0int ceph_get_file_stripe_unit(struct ceph_mount_info *cmount, int=
 fh);
>> diff --git a/src/libceph.cc b/src/libceph.cc
>> index d1143d6..6388bde 100644
>> --- a/src/libceph.cc
>> +++ b/src/libceph.cc
>> @@ -416,6 +416,48 @@ extern "C" int ceph_setattr(struct ceph_mount_i=
nfo *cmount, const char *relpath,
>> =A0 return cmount->get_client()->setattr(relpath, attr, mask);
>> =A0}
>>
>> +// *xattr() calls supporting samba/vfs
>> +extern "C" int ceph_getxattr(struct ceph_mount_info *cmount, const =
char *path, const char *name, void *value, size_t size)
>> +{
>> + =A0return cmount->get_client()->getxattr(path, name, value, size);
>> +}
>> +
>> +extern "C" int ceph_lgetxattr(struct ceph_mount_info *cmount, const=
 char *path, const char *name, void *value, size_t size)
>> +{
>> + =A0return cmount->get_client()->lgetxattr(path, name, value, size)=
;
>> +}
>> +
>> +extern "C" int ceph_listxattr(struct ceph_mount_info *cmount, const=
 char *path, char *list, size_t size)
>> +{
>> + =A0return cmount->get_client()->listxattr(path, list, size);
>> +}
>> +
>> +extern "C" int ceph_llistxattr(struct ceph_mount_info *cmount, cons=
t char *path, char *list, size_t size)
>> +{
>> + =A0return cmount->get_client()->llistxattr(path, list, size);
>> +}
>> +
>> +extern "C" int ceph_removexattr(struct ceph_mount_info *cmount, con=
st char *path, const char *name)
>> +{
>> + =A0return cmount->get_client()->removexattr(path, name);
>> +}
>> +
>> +extern "C" int ceph_lremovexattr(struct ceph_mount_info *cmount, co=
nst char *path, const char *name)
>> +{
>> + =A0return cmount->get_client()->lremovexattr(path, name);
>> +}
>> +
>> +extern "C" int ceph_setxattr(struct ceph_mount_info *cmount, const =
char *path, const char *name, const void *value, size_t size, int flags=
)
>> +{
>> + =A0return cmount->get_client()->setxattr(path, name, value, size, =
flags);
>> +}
>> +
>> +extern "C" int ceph_lsetxattr(struct ceph_mount_info *cmount, const=
 char *path, const char *name, const void *value, size_t size, int flag=
s)
>> +{
>> + =A0return cmount->get_client()->lsetxattr(path, name, value, size,=
 flags);
>> +}
>> +/* end xattr support */
>> +
>> =A0extern "C" int ceph_chmod(struct ceph_mount_info *cmount, const c=
har *path, mode_t mode)
>> =A0{
>> =A0 return cmount->get_client()->chmod(path, mode);
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
