From: Loic Dachary <loic@dachary.org>
Subject: Re: questions about erasure coded pool and rados
Date: Fri, 17 Oct 2014 06:10:52 -0700
Message-ID: <5441155C.3030401@dachary.org>
References: <CAPaK2r_B8TjUo63P3d-XOOQzdvz_bUhpgPHw9TXLngms4=4c9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="THsfKX5fIlXeRna7MlvVdl6nxuC6QgSBl"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47421 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751251AbaJQNKz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Oct 2014 09:10:55 -0400
In-Reply-To: <CAPaK2r_B8TjUo63P3d-XOOQzdvz_bUhpgPHw9TXLngms4=4c9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yue longguang <yuelongguang@gmail.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--THsfKX5fIlXeRna7MlvVdl6nxuC6QgSBl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

In addition to Owen's answer:

On 17/10/2014 03:13, yue longguang wrote:
> 1. why erasure coded pool does not work with rbd?
> 2. i used rados command to put a file into erasue coded pool,then rm
> it. why the file remains on osd's backend fs all the time?

They will go away at some point but they are not removed from the file sy=
stem immediately. There is however no risk that they re-appear in ceph ;-=
)

Cheers

> 3. what is the best use case with erasure coded pool?
> 4. command of 'rados ls' is to list objects, where are the object-name =
stored?
> 5.when a rbd file is put on erasure coded pool, where is the
> infomation(rbd name) of the rbd stored?
>=20
> thanks
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--THsfKX5fIlXeRna7MlvVdl6nxuC6QgSBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRBFVwACgkQ8dLMyEl6F22i/QCgrUiAJ3JefamV7yFSgswjxE3e
YScAoMXhHdCpxrGjqp7sY1CxlqM1Ci43
=Wi4W
-----END PGP SIGNATURE-----

--THsfKX5fIlXeRna7MlvVdl6nxuC6QgSBl--
