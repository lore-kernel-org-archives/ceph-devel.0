From: Loic Dachary <loic@dachary.org>
Subject: /sys/block and /dev and partitions
Date: Sat, 15 Aug 2015 13:16:41 +0200
Message-ID: <55CF1F99.5050807@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8QciKhtlpdtLOvh3v06Dmq5VORNlUtx2b"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38498 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750943AbbHOLQn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Aug 2015 07:16:43 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 681C242B2B
	for <ceph-devel@vger.kernel.org>; Sat, 15 Aug 2015 13:16:41 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8QciKhtlpdtLOvh3v06Dmq5VORNlUtx2b
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Is there a portable and consistent way to figure out if a given /dev/XXX =
path (for instance /dev/dm-1) is a partition of a whole device ? Although=
 checking /sys/block/dm-1/dm/name for a number at the end (like mpatha1 o=
r mpatha2) would probably work, it feels like a fragile hack. Looking int=
o /sys/block/dm-1/slaves will lead to /sys/block/dm-1/slaves/dm-0 and we =
can check that /sys/block/dm-*/subsystem is class/block. But that does no=
t necessarily mean dm-1 is a partition of dm-0, just that it's a slave of=
 dm-0.=20

Any idea ?

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--8QciKhtlpdtLOvh3v06Dmq5VORNlUtx2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXPH5kACgkQ8dLMyEl6F22KrgCfeR9dTa+vfJ+G/8C0QZF+xXlk
NWwAoKsO3I1PtG9NgGxxdI/zbhuIXH+A
=/lfq
-----END PGP SIGNATURE-----

--8QciKhtlpdtLOvh3v06Dmq5VORNlUtx2b--
