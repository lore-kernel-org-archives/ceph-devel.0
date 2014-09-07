From: Loic Dachary <loic@dachary.org>
Subject: Placement Groups : chosing the right pg_num
Date: Sun, 07 Sep 2014 23:00:31 +0200
Message-ID: <540CC76F.8010807@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pMwGhJBCLOTocDr0Nff22fM3Qj2k9x5ED"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46897 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752010AbaIGVAo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Sep 2014 17:00:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent Guerby <laurent@guerby.net>, Mehdi Abaakouk <sileht@sileht.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pMwGhJBCLOTocDr0Nff22fM3Qj2k9x5ED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Laurent & Mehdi,

I tried to translate our discussions about how to choose the number of pl=
acement groups into a revision of the documentation. Here is how it looks=
 at the moment:

   https://github.com/dachary/ceph/blob/9177da52f7aa358484f4d9074522da21c=
9336e49/doc/rados/operations/placement-groups.rst

and the corresponding pull request is at

   https://github.com/ceph/ceph/pull/2417

This is a draft and I would very much appreciate your comments. I cc the =
Ceph development list because it is entirely possible that something sign=
ificant is missing. Someone knowledgeable will hopefully rectify my mista=
kes ;-)

Cheers
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--pMwGhJBCLOTocDr0Nff22fM3Qj2k9x5ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQMx28ACgkQ8dLMyEl6F20DzgCguCu9vUwrrbmtj8u5fy+HJqqN
K7kAoK/JiY7cHk2DGfFVvBEMW4IItwE9
=cZC5
-----END PGP SIGNATURE-----

--pMwGhJBCLOTocDr0Nff22fM3Qj2k9x5ED--
