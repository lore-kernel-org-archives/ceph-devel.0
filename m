From: Loic Dachary <loic@dachary.org>
Subject: warning: parallel make check just merged
Date: Mon, 10 Nov 2014 12:06:35 +0100
Message-ID: <54609C3B.2080502@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xBbd6aVEkFKm4MFkbUxulHXdMLTNBmkUF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34087 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752311AbaKJLGn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Nov 2014 06:06:43 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 835C442B45
	for <ceph-devel@vger.kernel.org>; Mon, 10 Nov 2014 12:06:36 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xBbd6aVEkFKm4MFkbUxulHXdMLTNBmkUF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

https://github.com/ceph/ceph/pull/2750 was merged a few minutes ago and m=
ake -j4 should now work (see http://dachary.org/?p=3D3313 for more inform=
ation). A few things are done differently but nothing that require a chan=
ge in how unit tests are written or run. The change primarily was about m=
aking sure the ceph mon and osd run by make check use different directori=
es and ports. Hopefully it will just be a benefit without any drawback. H=
owever, if anything seems suspicious to you regarding the result of make =
check (parallel or not), feel free to blame me and ask that I fix it ;-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--xBbd6aVEkFKm4MFkbUxulHXdMLTNBmkUF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRgnDwACgkQ8dLMyEl6F23/tACdHhRwJa61qSTZJgIDfXuZKtmG
bdwAnj2GF2syHTCF7AZGDdkRWLw7OCd8
=1vZF
-----END PGP SIGNATURE-----

--xBbd6aVEkFKm4MFkbUxulHXdMLTNBmkUF--
