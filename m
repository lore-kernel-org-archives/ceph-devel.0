From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] ceph: fix sizeof(struct tYpO *) typo
Date: Fri, 25 Jul 2014 07:52:32 -0500
Message-ID: <53D25310.4090001@ieee.org>
References: <1406280385-30275-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:49176 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbaGYMwb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 08:52:31 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so3447860iec.26
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 05:52:31 -0700 (PDT)
In-Reply-To: <1406280385-30275-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org
Cc: Yan Zheng <zheng.z.yan@intel.com>

On 07/25/2014 04:26 AM, Ilya Dryomov wrote:
> struct ceph_xattr -> struct ceph_inode_xattr

Looks good.  I can't find the definition of ceph_xattr.

Reviewed-by: Alex Elder <elder@linaro.org>

> Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  fs/ceph/xattr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index f89698cdbc41..12f58d22e017 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -592,7 +592,7 @@ start:
>  		xattr_version =3D ci->i_xattrs.version;
>  		spin_unlock(&ci->i_ceph_lock);
> =20
> -		xattrs =3D kcalloc(numattr, sizeof(struct ceph_xattr *),
> +		xattrs =3D kcalloc(numattr, sizeof(struct ceph_inode_xattr *),
>  				 GFP_NOFS);
>  		err =3D -ENOMEM;
>  		if (!xattrs)
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
