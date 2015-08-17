From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] fs/ceph: No need get inode of parent in ceph_open.
Date: Mon, 17 Aug 2015 17:51:44 +0800
Message-ID: <E5A1FE0E-8303-4BD6-BDD5-F88B153768C6@redhat.com>
References: <6AA21C22F0A5DA478922644AD2EC308C1D19FBFC@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58063 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbbHQJvv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Aug 2015 05:51:51 -0400
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C1D19FBFC@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It seems all of your patches are malformed. please use 'git send-email=E2=
=80=99 to send patch.

Regards
Yan, Zheng


> On Aug 17, 2015, at 16:43, Ma, Jianpeng <jianpeng.ma@intel.com> wrote=
:
>=20
> For ceph_open, it already get the parent inode. So no need to get aga=
in.
>=20
> Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
> ---
> fs/ceph/file.c | 3 ---
> 1 file changed, 3 deletions(-)
>=20
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 8b79d87..5ecd3dc 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -210,10 +210,7 @@ int ceph_open(struct inode *inode, struct file *=
file)
>        ihold(inode);
>=20
>        req->r_num_caps =3D 1;
> -       if (flags & O_CREAT)
> -               parent_inode =3D ceph_get_dentry_parent_inode(file->f=
_path.dentry);
>        err =3D ceph_mdsc_do_request(mdsc, parent_inode, req);
> -       iput(parent_inode);
>        if (!err)
>                err =3D ceph_init_file(inode, file, req->r_fmode);
>        ceph_mdsc_put_request(req);
> --
> 2.4.3
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
