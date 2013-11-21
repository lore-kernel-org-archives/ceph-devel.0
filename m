From: Loic Dachary <loic@dachary.org>
Subject: Re: possible bug in init-ceph.in
Date: Thu, 21 Nov 2013 18:18:41 +0100
Message-ID: <528E4071.3070603@dachary.org>
References: <24E144B8C0207547AD09C467A8259F7559232FA2@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KsueldJjT9GuqcR4aivsSN2qcxe6vvbLX"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:45268 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab3KURSn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Nov 2013 12:18:43 -0500
In-Reply-To: <24E144B8C0207547AD09C467A8259F7559232FA2@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KsueldJjT9GuqcR4aivsSN2qcxe6vvbLX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I believe there is either a pull request or a ticket with this fix. Defin=
itely a typo ;-)

Cheers

On 21/11/2013 08:23, Dietmar Maurer wrote:
> http://ceph.com/git/?p=3Dceph.git;a=3Dblob;f=3Dsrc/init-ceph.in;h=3D739=
9abb8f85855f2248c4afb22bf94f2e2f080a2;hb=3DHEAD
>=20
> line 320:
>=20
>       if [ "${update_crush:-1}" =3D "1" -o "{$update_crush:-1}" =3D "tr=
ue" ]; then
>=20
> looks strange to me. Maybe that should be:
>=20
> -		if [ "${update_crush:-1}" =3D "1" -o "{$update_crush:-1}" =3D "true"=
 ]; then
> +		if [ "${update_crush:-1}" =3D "1" -o "${update_crush:-1}" =3D "true"=
 ]; then
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--KsueldJjT9GuqcR4aivsSN2qcxe6vvbLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKOQHEACgkQ8dLMyEl6F21q5ACfaKagxqVMt1ggpGbf1k3Xve0G
e/IAoKjzznAZbdWOrLgxzASJuO1a/gqV
=++P0
-----END PGP SIGNATURE-----

--KsueldJjT9GuqcR4aivsSN2qcxe6vvbLX--
