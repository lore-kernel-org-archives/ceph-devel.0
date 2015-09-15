From: Loic Dachary <loic@dachary.org>
Subject: Backporting from Infernalis and c++11
Date: Tue, 15 Sep 2015 09:21:47 +0200
Message-ID: <55F7C70B.4000308@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="l7vOdwE4phE0oBQNxi2hd4cdI07JnaXK7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55528 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750698AbbIOHVt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 03:21:49 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id B87FC42130
	for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 09:21:47 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l7vOdwE4phE0oBQNxi2hd4cdI07JnaXK7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

With Infernalis Ceph move to c++11 (and CMake), we will see more conflict=
s when backporting bug fixes to Hammer. Any ideas you may have to better =
deal with this would be most welcome. Since these conflicts will be mostl=
y cosmetic, they should not be too difficult to resolve. The trick will b=
e for someone not familiar with the codebase to separate what is cosmetic=
 and what is not.

This does not happen yet, no immediate concern :-) Maybe if we think abou=
t that well in advance we'll be in a better position to deal with it late=
r on ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--l7vOdwE4phE0oBQNxi2hd4cdI07JnaXK7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlX3xwsACgkQ8dLMyEl6F22FBQCguaZZ0rpWMD83oCTCveYNCfw3
6soAn2pISz/Yh48NoPqxhVv8ojIzsyyS
=ToAl
-----END PGP SIGNATURE-----

--l7vOdwE4phE0oBQNxi2hd4cdI07JnaXK7--
