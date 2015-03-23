From: =?gb2312?B?0c/V/Q==?= <zyan@redhat.com>
Subject: Re: [PATCH] ceph: kstrdup() memory handling
Date: Mon, 23 Mar 2015 12:03:42 +0800
Message-ID: <F755EC41-5076-4304-9D5A-42310655D96A@redhat.com>
References: <1426956898-32132-1-git-send-email-sanidhya.gatech@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426956898-32132-1-git-send-email-sanidhya.gatech@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sanidhya Kashyap <sanidhya.gatech@gmail.com>
Cc: sage@redhat.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, taesoo@gatech.edu, changwoo@gatech.edu, sanidhya@gatech.edu, blee@gatech.edu
List-Id: ceph-devel.vger.kernel.org


> =D4=DA 2015=C4=EA3=D4=C222=C8=D5=A3=AC00:54=A3=ACSanidhya Kashyap <sa=
nidhya.gatech@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> Currently, there is no check for the kstrdup() for r_path2, r_path1 a=
nd snapdir_name
> as various locations as there is a possibility of failure during memo=
ry pressure.
> Therefore, returning ENOMEM where the checks have been missed.
>=20
> Signed-off-by: Sanidhya Kashyap <sanidhya.gatech@gmail.com>
> ---
> fs/ceph/dir.c   | 11 +++++++++++
> fs/ceph/super.c |  8 ++++++++
> fs/ceph/xattr.c |  7 +++++++
> 3 files changed, 26 insertions(+)
>=20
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 83e9976..be32703 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -344,6 +344,12 @@ more:
> 		req->r_direct_hash =3D ceph_frag_value(frag);
> 		req->r_direct_is_hash =3D true;
> 		req->r_path2 =3D kstrdup(fi->last_name, GFP_NOFS);
> +		if (!req->r_path2) {
> +			iput(inode);
> +			ceph_mdsc_put_request(req);
> +			return -ENOMEM;
> +		}
> +
> 		req->r_readdir_offset =3D fi->next_offset;
> 		req->r_args.readdir.frag =3D cpu_to_le32(frag);
> 		err =3D ceph_mdsc_do_request(mdsc, NULL, req);
> @@ -758,6 +764,11 @@ static int ceph_symlink(struct inode *dir, struc=
t dentry *dentry,
> 	req->r_dentry =3D dget(dentry);
> 	req->r_num_caps =3D 2;
> 	req->r_path2 =3D kstrdup(dest, GFP_NOFS);
> +	if (!req->r_path2) {
> +		err =3D -ENOMEM;
> +		ceph_mdsc_put_request(req);
> +		goto out;
> +	}
> 	req->r_locked_dir =3D dir;
> 	req->r_dentry_drop =3D CEPH_CAP_FILE_SHARED;
> 	req->r_dentry_unless =3D CEPH_CAP_FILE_EXCL;
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index a63997b..8e68f53 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -345,6 +345,9 @@ static int parse_mount_options(struct ceph_mount_=
options **pfsopt,
> 	fsopt->rsize =3D CEPH_RSIZE_DEFAULT;
> 	fsopt->rasize =3D CEPH_RASIZE_DEFAULT;
> 	fsopt->snapdir_name =3D kstrdup(CEPH_SNAPDIRNAME_DEFAULT, GFP_KERNEL=
);
> +	if (!fsopt->snapdir_name)
> +		goto out;
> +
> 	fsopt->caps_wanted_delay_min =3D CEPH_CAPS_WANTED_DELAY_MIN_DEFAULT;
> 	fsopt->caps_wanted_delay_max =3D CEPH_CAPS_WANTED_DELAY_MAX_DEFAULT;
> 	fsopt->cap_release_safety =3D CEPH_CAP_RELEASE_SAFETY_DEFAULT;
> @@ -730,6 +733,11 @@ static struct dentry *open_root_dentry(struct ce=
ph_fs_client *fsc,
> 	if (IS_ERR(req))
> 		return ERR_CAST(req);
> 	req->r_path1 =3D kstrdup(path, GFP_NOFS);
> +	if (!req->r_path1) {
> +		root =3D ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
> 	req->r_ino1.ino =3D CEPH_INO_ROOT;
> 	req->r_ino1.snap =3D CEPH_NOSNAP;
> 	req->r_started =3D started;
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 5a492ca..299eb83 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -883,6 +883,11 @@ static int ceph_sync_setxattr(struct dentry *den=
try, const char *name,
> 	req->r_num_caps =3D 1;
> 	req->r_args.setxattr.flags =3D cpu_to_le32(flags);
> 	req->r_path2 =3D kstrdup(name, GFP_NOFS);
> +	if (!req->r_path2) {
> +		ceph_mdsc_put_request(req);
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
>=20
> 	req->r_pagelist =3D pagelist;
> 	pagelist =3D NULL;
> @@ -1024,6 +1029,8 @@ static int ceph_send_removexattr(struct dentry =
*dentry, const char *name)
> 	req->r_inode_drop =3D CEPH_CAP_XATTR_SHARED;
> 	req->r_num_caps =3D 1;
> 	req->r_path2 =3D kstrdup(name, GFP_NOFS);
> +	if (!req->r_path2)
> +		return -ENOMEM;
>=20
> 	err =3D ceph_mdsc_do_request(mdsc, NULL, req);
> 	ceph_mdsc_put_request(req);
> --=20

Added to our testing branch (with some minor modifications. take inode/=
dentry references after kstrdup)

Thank
Yan, Zheng

> 2.1.0
>=20
