From: Loic Dachary <loic@dachary.org>
Subject: Should we create a "Stable releases" project on tracker.ceph.com
 ?
Date: Sun, 01 Mar 2015 00:51:36 +0100
Message-ID: <54F25488.6050703@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2aQptE1PmsKVSXhiqlDdCOn1PT3IrQr4h"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50764 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750885AbbB1Xvi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Feb 2015 18:51:38 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id B8CF842137
	for <ceph-devel@vger.kernel.org>; Sun,  1 Mar 2015 00:51:36 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2aQptE1PmsKVSXhiqlDdCOn1PT3IrQr4h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

In the past few weeks I issues in the tracker of the Ceph project to upda=
te the progress of the ongoing effort to publish stable point releases (i=
=2Ee. backports) at http://tracker.ceph.com/issues/10640. It started some=
what messy but turned out to be a convenient point of reference, with one=
 issue for each stable release (see http://tracker.ceph.com/issues/10641 =
for firefly v0.80.9 for instance). The issues were set a priority "low" b=
ecause they are squatting the Ceph issue namespace but follow a completel=
y different workflow.=20

Would it make sense to create a "Stable releases" project in http://track=
er.ceph.com/ ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--2aQptE1PmsKVSXhiqlDdCOn1PT3IrQr4h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTyVIgACgkQ8dLMyEl6F2379wCgpKIrS1s+rQNMNEXm31ejrccd
Xm8Anj++772+vyFrQ098wR/UQFDcAU9X
=u/wY
-----END PGP SIGNATURE-----

--2aQptE1PmsKVSXhiqlDdCOn1PT3IrQr4h--
