From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCH] rbd: report unsupported features to syslog
Date: Thu, 28 Apr 2016 12:42:15 -0400
Message-ID: <796104EE-5477-4AA9-84B7-FE79EFBAF277@redhat.com>
References: <1460748345-3717-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33739 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbcD1QmW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2016 12:42:22 -0400
Received: by mail-pa0-f47.google.com with SMTP id zm5so37887664pac.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 09:42:20 -0700 (PDT)
In-Reply-To: <1460748345-3717-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Looks good to me.

Reviewed-by: Douglas Fuller <dfuller@redhat.com>

Cheers,
=E2=80=94Doug

> On Apr 15, 2016, at 3:25 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>=20
> ... instead of just returning an error.
>=20
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
> drivers/block/rbd.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 9f1eb00b5e64..78aca585e7e5 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4184,7 +4184,7 @@ static int _rbd_dev_v2_snap_features(struct rbd=
_device *rbd_dev, u64 snap_id,
> 		__le64 features;
> 		__le64 incompat;
> 	} __attribute__ ((packed)) features_buf =3D { 0 };
> -	u64 incompat;
> +	u64 unsup;
> 	int ret;
>=20
> 	ret =3D rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
> @@ -4197,9 +4197,12 @@ static int _rbd_dev_v2_snap_features(struct rb=
d_device *rbd_dev, u64 snap_id,
> 	if (ret < sizeof (features_buf))
> 		return -ERANGE;
>=20
> -	incompat =3D le64_to_cpu(features_buf.incompat);
> -	if (incompat & ~RBD_FEATURES_SUPPORTED)
> +	unsup =3D le64_to_cpu(features_buf.incompat) & ~RBD_FEATURES_SUPPOR=
TED;
> +	if (unsup) {
> +		rbd_warn(rbd_dev, "image uses unsupported features: 0x%llx",
> +			 unsup);
> 		return -ENXIO;
> +	}
>=20
> 	*snap_features =3D le64_to_cpu(features_buf.features);
>=20
> --=20
> 2.4.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
