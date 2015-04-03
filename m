From: Loic Dachary <loic@dachary.org>
Subject: the tarbal gitbuilders are currently broken
Date: Fri, 03 Apr 2015 04:48:19 +0200
Message-ID: <551DFF73.4040700@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SEcPGwWTVa0Qcm6FdpiulEJAWfCqmVAtU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41157 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876AbbDCCsW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Apr 2015 22:48:22 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 398A542093
	for <ceph-devel@vger.kernel.org>; Fri,  3 Apr 2015 04:48:20 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SEcPGwWTVa0Qcm6FdpiulEJAWfCqmVAtU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

After re-installing the tarbal gitbuilders so that they run make check (w=
hich they didn't in the past few weeks), it turns out that some of them t=
imeout. https://github.com/ceph/autobuild-ceph/pull/39/files will hopeful=
ly fix this by running make -jX check. It has been installed on gitbuilde=
r-ceph-tarball-trusty-amd64-basic for testing.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--SEcPGwWTVa0Qcm6FdpiulEJAWfCqmVAtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUd/3MACgkQ8dLMyEl6F23ugwCfWMsDcbOsRrKbkIAffdVtNkjW
sgsAnisy2Bp50I/qffuBOE6b9j9RvLmN
=ni80
-----END PGP SIGNATURE-----

--SEcPGwWTVa0Qcm6FdpiulEJAWfCqmVAtU--
