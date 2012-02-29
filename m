From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH] ceph: pass inode rather than table to ceph_match_vxattr()
Date: Tue, 28 Feb 2012 20:33:32 -0800
Message-ID: <CAC-hyiFM6W51ZDZez9kz0cTJPC0+tOpCnyrJ7JFKbgAAWtQ8SA@mail.gmail.com>
References: <4F4D97CA.5060302@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54944 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143Ab2B2Edd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:33:33 -0500
Received: by bkcik5 with SMTP id ik5so1925722bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:33:32 -0800 (PST)
In-Reply-To: <4F4D97CA.5060302@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Feb 28, 2012 at 7:13 PM, Alex Elder <elder@dreamhost.com> wrote=
:
>
> All callers of ceph_match_vxattr() determine what to pass as the
> first argument by calling ceph_inode_vxattrs(inode). =A0Just do that
> inside ceph_match_vxattr() itself, changing it to take an inode
> rather than the vxattr pointer as its first argument.
>
> Also ensure the function works correctly for an empty table (i.e.,
> containing only a terminating null entry).
>
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
> =A0fs/ceph/xattr.c | =A0 42 +++++++++++++++++++----------------------=
-
> =A01 files changed, 19 insertions(+), 23 deletions(-)
>
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index b98b91d..bec9c30 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -126,14 +126,18 @@ static struct ceph_vxattr_cb
> *ceph_inode_vxattrs(struct inode *inode)
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> -static struct ceph_vxattr_cb *ceph_match_vxattr(struct ceph_vxattr_c=
b
> *vxattr,
> +static struct ceph_vxattr_cb *ceph_match_vxattr(struct inode *inode,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0const char *name)
> =A0{
> - =A0 =A0 =A0 do {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(vxattr->name, name) =3D=3D 0=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return vxattr;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vxattr++;
> - =A0 =A0 =A0 } while (vxattr->name);
> + =A0 =A0 =A0 struct ceph_vxattr_cb *vxattr =3D ceph_inode_vxattrs(in=
ode);
> +
> + =A0 =A0 =A0 if (vxattr)

if (vxattr) {

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (vxattr->name) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(vxattr->nam=
e, name))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
vxattr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vxattr++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +

}

> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> @@ -502,7 +506,6 @@ ssize_t ceph_getxattr(struct dentry *dentry, cons=
t
> char *name, void *value,
> =A0{
> =A0 =A0 =A0 =A0struct inode *inode =3D dentry->d_inode;
> =A0 =A0 =A0 =A0struct ceph_inode_info *ci =3D ceph_inode(inode);
> - =A0 =A0 =A0 struct ceph_vxattr_cb *vxattrs =3D ceph_inode_vxattrs(i=
node);
> =A0 =A0 =A0 =A0int err;
> =A0 =A0 =A0 =A0struct ceph_inode_xattr *xattr;
> =A0 =A0 =A0 =A0struct ceph_vxattr_cb *vxattr =3D NULL;
> @@ -511,8 +514,7 @@ ssize_t ceph_getxattr(struct dentry *dentry, cons=
t
> char *name, void *value,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODATA;
>
> =A0 =A0 =A0 =A0/* let's see if a virtual xattr was requested */
> - =A0 =A0 =A0 if (vxattrs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vxattr =3D ceph_match_vxattr(vxattrs, n=
ame);
> + =A0 =A0 =A0 vxattr =3D ceph_match_vxattr(inode, name);
>
> =A0 =A0 =A0 =A0spin_lock(&ci->i_ceph_lock);
> =A0 =A0 =A0 =A0dout("getxattr %p ver=3D%lld index_ver=3D%lld\n", inod=
e,
> @@ -698,8 +700,8 @@ int ceph_setxattr(struct dentry *dentry, const ch=
ar
> *name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const void *value, size_t size, in=
t flags)
> =A0{
> =A0 =A0 =A0 =A0struct inode *inode =3D dentry->d_inode;
> + =A0 =A0 =A0 struct ceph_vxattr_cb *vxattr;
> =A0 =A0 =A0 =A0struct ceph_inode_info *ci =3D ceph_inode(inode);
> - =A0 =A0 =A0 struct ceph_vxattr_cb *vxattrs =3D ceph_inode_vxattrs(i=
node);
> =A0 =A0 =A0 =A0int err;
> =A0 =A0 =A0 =A0int name_len =3D strlen(name);
> =A0 =A0 =A0 =A0int val_len =3D size;
> @@ -716,12 +718,9 @@ int ceph_setxattr(struct dentry *dentry, const c=
har
> *name,
> =A0 =A0 =A0 =A0if (!ceph_is_valid_xattr(name))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EOPNOTSUPP;
>
> - =A0 =A0 =A0 if (vxattrs) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ceph_vxattr_cb *vxattr =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_match_vxattr(vxatt=
rs, name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vxattr && vxattr->readonly)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 vxattr =3D ceph_match_vxattr(inode, name);
> + =A0 =A0 =A0 if (vxattr && vxattr->readonly)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>
> =A0 =A0 =A0 =A0/* preallocate memory for xattr name, value, index nod=
e */
> =A0 =A0 =A0 =A0err =3D -ENOMEM;
> @@ -814,8 +813,8 @@ static int ceph_send_removexattr(struct dentry
> *dentry, const char *name)
> =A0int ceph_removexattr(struct dentry *dentry, const char *name)
> =A0{
> =A0 =A0 =A0 =A0struct inode *inode =3D dentry->d_inode;
> + =A0 =A0 =A0 struct ceph_vxattr_cb *vxattr;
> =A0 =A0 =A0 =A0struct ceph_inode_info *ci =3D ceph_inode(inode);
> - =A0 =A0 =A0 struct ceph_vxattr_cb *vxattrs =3D ceph_inode_vxattrs(i=
node);
> =A0 =A0 =A0 =A0int issued;
> =A0 =A0 =A0 =A0int err;
> =A0 =A0 =A0 =A0int dirty;
> @@ -826,12 +825,9 @@ int ceph_removexattr(struct dentry *dentry, cons=
t
> char *name)
> =A0 =A0 =A0 =A0if (!ceph_is_valid_xattr(name))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EOPNOTSUPP;
>
> - =A0 =A0 =A0 if (vxattrs) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ceph_vxattr_cb *vxattr =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_match_vxattr(vxatt=
rs, name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vxattr && vxattr->readonly)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 vxattr =3D ceph_match_vxattr(inode, name);
> + =A0 =A0 =A0 if (vxattr && vxattr->readonly)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>
> =A0 =A0 =A0 =A0spin_lock(&ci->i_ceph_lock);
> =A0 =A0 =A0 =A0__build_xattrs(inode);
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
