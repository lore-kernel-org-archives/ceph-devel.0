From: Loic Dachary <loic@dachary.org>
Subject: Intel Erasure Code library
Date: Mon, 16 Dec 2013 10:56:50 +0100
Message-ID: <52AECE62.9030102@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qIJJmr9M3odqPWqBJ1DBcjnddxPAp7FQ4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41373 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab3LPJ4w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 04:56:52 -0500
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id E5F6026394
	for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 10:56:50 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qIJJmr9M3odqPWqBJ1DBcjnddxPAp7FQ4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

A new Erasure Code library has been released as Free Software

https://01.org/storage-acceleration-library/downloads/2013/isa-l-open-sou=
rce-release

It is quite tempting to write a Ceph erasure code plugin for it and see h=
ow it performs :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--qIJJmr9M3odqPWqBJ1DBcjnddxPAp7FQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKuzmIACgkQ8dLMyEl6F20yXgCgmKAB1lajkuZgBN2k7XIVICFm
SHkAn3DFytkVO+Y5trXeDbCkQZOS7CeI
=KorZ
-----END PGP SIGNATURE-----

--qIJJmr9M3odqPWqBJ1DBcjnddxPAp7FQ4--
