From: Loic Dachary <loic@dachary.org>
Subject: dealing with conflicting pull requests
Date: Thu, 09 Jul 2015 12:39:14 +0200
Message-ID: <559E4F52.9070007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IrHRoCXavjREqVcVQVjaNMqrtwmQRs8t0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47265 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750939AbbGIKjS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jul 2015 06:39:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>, Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IrHRoCXavjREqVcVQVjaNMqrtwmQRs8t0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear co-backporters,

For the first time we have a few conflicting pull requests that prevent m=
erging all in the integration branch.

https://github.com/ceph/ceph/pull/4597
https://github.com/ceph/ceph/pull/5043
https://github.com/ceph/ceph/pull/4788
https://github.com/ceph/ceph/pull/4636
https://github.com/ceph/ceph/pull/4635

I think the simplest way to deal with that is to arbitrarily pick a few t=
hat apply cleanly and just DNM the others so they wait for the next round=
 of integration testing. After the first round of integration test, the c=
hosen one will be merged and the DNM will have to be rebased to resolve t=
he conflict, but that's what we do routinely.

What do you think ?

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--IrHRoCXavjREqVcVQVjaNMqrtwmQRs8t0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWeT1MACgkQ8dLMyEl6F20IMACeL45j1ReYVvhba4ewEKoo24qx
XhAAnRWyWTzFnywTKblGjcte8vDpmuae
=P3Bf
-----END PGP SIGNATURE-----

--IrHRoCXavjREqVcVQVjaNMqrtwmQRs8t0--
