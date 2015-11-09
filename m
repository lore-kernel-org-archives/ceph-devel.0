From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph:Fix error handling in the function ceph_readddir_prepopulate
Date: Mon, 9 Nov 2015 18:20:16 +0800
Message-ID: <9C9783A1-571B-48D9-8403-B05A3CCE7A8C@redhat.com>
References: <1447017196-32012-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33315 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbbKIKU2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 05:20:28 -0500
In-Reply-To: <1447017196-32012-1-git-send-email-xerofoify@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org


> On Nov 9, 2015, at 05:13, Nicholas Krause <xerofoify@gmail.com> wrote=
:
>=20
> This fixes error handling in the function ceph_readddir_prepopulate
> to properly check if the call to the function ceph_fill_dirfrag has
> failed by returning a error code. Further more if this does arise
> jump to the goto label, out of the function ceph_readdir_prepopulate
> in order to clean up previously allocated resources by this function
> before returning to the caller this errror code in order for all call=
ers
> to be now aware and able to handle this failure in their own intended
> error paths.
>=20
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
> fs/ceph/inode.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 96d2bd8..7738be6 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1417,8 +1417,11 @@ int ceph_readdir_prepopulate(struct ceph_mds_r=
equest *req,
> 	} else {
> 		dout("readdir_prepopulate %d items under dn %p\n",
> 		     rinfo->dir_nr, parent);
> -		if (rinfo->dir_dir)
> -			ceph_fill_dirfrag(d_inode(parent), rinfo->dir_dir);
> +		if (rinfo->dir_dir) {
> +			err =3D ceph_fill_dirfrag(d_inode(parent), rinfo->dir_dir);
> +			if (err)
> +				goto out;
> +		}
> 	}
>=20

ceph_fill_dirfrag() failure is not fatal. I think it=E2=80=99s better t=
o not skip later code when it happens.

Regards
Yan, Zheng=20


> 	if (ceph_frag_is_leftmost(frag) && req->r_readdir_offset =3D=3D 2) {
> --=20
> 2.5.0
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
