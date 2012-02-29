From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 5/6] ceph: avoid repeatedly computing the size of constant
 vxattr names
Date: Tue, 28 Feb 2012 20:47:13 -0800
Message-ID: <CAC-hyiGKYNacy7ivUk-dyc4hviif4Bdq7NUfaAhhAfWZL6=X3Q@mail.gmail.com>
References: <4F4D98D5.1010506@dreamhost.com>
	<4F4D99CF.9020507@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56928 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965408Ab2B2ErP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:47:15 -0500
Received: by bkcik5 with SMTP id ik5so1930775bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:47:14 -0800 (PST)
In-Reply-To: <4F4D99CF.9020507@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Feb 28, 2012 at 7:21 PM, Alex Elder <elder@dreamhost.com> wrote=
:
> All names defined in the directory and file virtual extended
> attribute tables are constant, and the size of each is known at
> compile time. =A0So there's no need to compute their length every
> time any file's attribute is listed.
>
> Record the length of each string and use it when needed to determine
> the space need to represent them. =A0In addition, compute the
> aggregate size of strings in each table just once at initialization
> time.
>
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
> =A0fs/ceph/super.c | =A0 =A03 ++
> =A0fs/ceph/super.h | =A0 =A02 +
> =A0fs/ceph/xattr.c | =A0 56
> ++++++++++++++++++++++++++++++++++++++++++++++++++----
> =A03 files changed, 56 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index b48f15f..e6325f0 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -906,6 +906,7 @@ static int __init init_ceph(void)
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> + =A0 =A0 =A0 ceph_xattr_init();
> =A0 =A0 =A0 =A0ret =3D register_filesystem(&ceph_fs_type);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_icache;
> @@ -915,6 +916,7 @@ static int __init init_ceph(void)
> =A0 =A0 =A0 =A0return 0;
>
> =A0out_icache:
> + =A0 =A0 =A0 ceph_xattr_exit();
> =A0 =A0 =A0 =A0destroy_caches();
> =A0out:
> =A0 =A0 =A0 =A0return ret;
> @@ -924,6 +926,7 @@ static void __exit exit_ceph(void)
> =A0{
> =A0 =A0 =A0 =A0dout("exit_ceph\n");
> =A0 =A0 =A0 =A0unregister_filesystem(&ceph_fs_type);
> + =A0 =A0 =A0 ceph_xattr_exit();
> =A0 =A0 =A0 =A0destroy_caches();
> =A0}
>
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 5f00e82..4be2dc4 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -732,6 +732,8 @@ extern ssize_t ceph_listxattr(struct dentry *, ch=
ar *,
> size_t);
> =A0extern int ceph_removexattr(struct dentry *, const char *);
> =A0extern void __ceph_build_xattrs_blob(struct ceph_inode_info *ci);
> =A0extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
> +extern void __init ceph_xattr_init(void);
> +extern void ceph_xattr_exit(void);
>
> =A0/* caps.c */
> =A0extern const char *ceph_cap_string(int c);
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 83366f9..984c863 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -26,6 +26,7 @@ static bool ceph_is_valid_xattr(const char *name)
> =A0*/
> =A0struct ceph_vxattr {
> =A0 =A0 =A0 =A0char *name;
> + =A0 =A0 =A0 size_t name_size; =A0 =A0 =A0 /* strlen(name) + 1 (for =
'\0') */
> =A0 =A0 =A0 =A0size_t (*getxattr_cb)(struct ceph_inode_info *ci, char=
 *val,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t siz=
e);
> =A0 =A0 =A0 =A0bool readonly;
> @@ -87,6 +88,7 @@ static size_t ceph_vxattrcb_dir_rctime(struct
> ceph_inode_info *ci, char *val,
> =A0#define XATTR_NAME_CEPH(_type, _name) \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D CEPH_XATTR_N=
AME(_type, _name), \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name_size =3D sizeof C=
EPH_XATTR_NAME(_type, _name), \

You should use sizeof(x) instead of sizeof x.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.getxattr_cb =3D ceph_=
vxattrcb_ ## _type ## _ ## _name,
> \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.readonly =3D true, \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -102,6 +104,7 @@ static struct ceph_vxattr ceph_dir_vxattrs[] =3D =
{
> =A0 =A0 =A0 =A0XATTR_NAME_CEPH(dir, rctime),
> =A0 =A0 =A0 =A0{ 0 } =A0 /* Required table terminator */
> =A0};
> +static size_t ceph_dir_vxattrs_name_size; =A0 =A0 =A0/* total size o=
f all names
> */
>
> =A0/* files */
>
> @@ -127,11 +130,13 @@ static struct ceph_vxattr ceph_file_vxattrs[] =3D=
 {
> =A0 =A0 =A0 =A0/* The following extended attribute name is deprecated=
 */
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D XATTR_CEPH_PREFIX "layout",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name_size =3D sizeof XATTR_CEPH_PREFIX=
 "layout",

here too.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.getxattr_cb =3D ceph_vxattrcb_file_la=
yout,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.readonly =3D true,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{ 0 } =A0 /* Required table terminator */
> =A0};
> +static size_t ceph_file_vxattrs_name_size; =A0 =A0 /* total size of =
all names
> */
>
> =A0static struct ceph_vxattr *ceph_inode_vxattrs(struct inode *inode)
> =A0{
> @@ -142,6 +147,46 @@ static struct ceph_vxattr *ceph_inode_vxattrs(st=
ruct
> inode *inode)
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> +static size_t ceph_vxattrs_name_size(struct ceph_vxattr *vxattrs)
> +{
> + =A0 =A0 =A0 if (vxattrs =3D=3D ceph_dir_vxattrs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ceph_dir_vxattrs_name_size;
> + =A0 =A0 =A0 if (vxattrs =3D=3D ceph_file_vxattrs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ceph_file_vxattrs_name_size;
> + =A0 =A0 =A0 BUG();
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * Compute the aggregate size (including terminating '\0') of all
> + * virtual extended attribute names in the given vxattr table.
> + */
> +static size_t __init vxattrs_name_size(struct ceph_vxattr *vxattrs)
> +{sizeof
> + =A0 =A0 =A0 struct ceph_vxattr *vxattr;
> + =A0 =A0 =A0 size_t size =3D 0;
> +
> + =A0 =A0 =A0 for (vxattr =3D vxattrs; vxattr->name; vxattr++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size +=3D vxattr->name_size;
> +
> + =A0 =A0 =A0 return size;
> +}
> +
> +/* Routines called at initialization and exit time */
> +
> +void __init ceph_xattr_init(void)
> +{
> + =A0 =A0 =A0 ceph_dir_vxattrs_name_size =3D vxattrs_name_size(ceph_d=
ir_vxattrs);
> + =A0 =A0 =A0 ceph_file_vxattrs_name_size =3D vxattrs_name_size(ceph_=
file_vxattrs);
> +}
> +
> +void ceph_xattr_exit(void)
> +{
> + =A0 =A0 =A0 ceph_dir_vxattrs_name_size =3D 0;
> + =A0 =A0 =A0 ceph_file_vxattrs_name_size =3D 0;
> +}
> +
> =A0static struct ceph_vxattr *ceph_match_vxattr(struct inode *inode,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0const char *name)
> =A0{
> @@ -614,11 +659,12 @@ ssize_t ceph_listxattr(struct dentry *dentry, c=
har
> *names, size_t size)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> =A0list_xattr:
> - =A0 =A0 =A0 vir_namelen =3D 0;
> - =A0 =A0 =A0 /* include virtual dir xattrs */
> - =A0 =A0 =A0 if (vxattrs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; vxattrs[i].name; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vir_namelen +=3D strlen=
(vxattrs[i].name) + 1;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Start with virtual dir xattr names (if any) (inclu=
ding
> + =A0 =A0 =A0 =A0* terminating '\0' characters for each).
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 vir_namelen =3D ceph_vxattrs_name_size(vxattrs);
> +
> =A0 =A0 =A0 =A0/* adding 1 byte per each variable due to the null ter=
mination */
> =A0 =A0 =A0 =A0namelen =3D vir_namelen + ci->i_xattrs.names_size + ci=
->i_xattrs.count;
> =A0 =A0 =A0 =A0err =3D -ERANGE;
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
