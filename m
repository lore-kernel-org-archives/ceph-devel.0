From: Loic Dachary <loic@dachary.org>
Subject: suites running on the hammer-backports branch
Date: Sun, 03 May 2015 15:08:10 +0200
Message-ID: <55461DBA.1060009@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="M2xrTFK8b7HflS7C9tspO1F2C6TdJC1v6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:56608 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750886AbbECNIM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 May 2015 09:08:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M2xrTFK8b7HflS7C9tspO1F2C6TdJC1v6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

The rados suite you scheduled ( http://tracker.ceph.com/issues/11492#rado=
s ) failed because of environmental noise and I re-scheduled the 84 faile=
d jobs on your behalf.

I've scheduled the rgw suite as well, suppressing the apache tests and ke=
eping the civetweb tests which should be enough for the purpose of the pu=
ll requests in the integration branch (44 jobs instead of 88 jobs). http:=
//tracker.ceph.com/issues/11492#rgw

The rbd and fs suites were also scheduled, as usual.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--M2xrTFK8b7HflS7C9tspO1F2C6TdJC1v6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVGHboACgkQ8dLMyEl6F23q+QCgh34JSspz76/GlUFlAgTRVThB
7KQAn12q068B/KuX7de1xuSDOv1i5vck
=8buq
-----END PGP SIGNATURE-----

--M2xrTFK8b7HflS7C9tspO1F2C6TdJC1v6--
