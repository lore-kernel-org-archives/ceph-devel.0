From: Loic Dachary <loic@dachary.org>
Subject: Testing the next giant release
Date: Wed, 07 Jan 2015 15:02:51 +0100
Message-ID: <54AD3C8B.4030705@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="moqeaKa00Du92P5I5wjdnjPqJETt72HLA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34810 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753157AbbAGOCx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jan 2015 09:02:53 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tamil Muthamizhan <tmuthamizhan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--moqeaKa00Du92P5I5wjdnjPqJETt72HLA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tamil,

I've merged / integrated the giant backports found at

https://github.com/ceph/ceph/pull/3186
https://github.com/ceph/ceph/pull/3178
https://github.com/ceph/ceph/pull/2954
https://github.com/ceph/ceph/pull/3191
https://github.com/ceph/ceph/pull/3168
https://github.com/ceph/ceph/pull/3289

into=20

http://workbench.dachary.org/ceph/ceph/commit/0ea20e6c51208d6710f469454ab=
3f964bfa7c9d2

and successfully ran make check on it

http://workbench.dachary.org:8080/projects/10?ref=3Dgiant-backports

If I'm not mistaken the next step would be to run teuthology. If I'm to d=
o it, would you be so kind as to let me know which suites are most releva=
nt ? If someone else will take care of it, should I push the integration =
branch somewhere ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--moqeaKa00Du92P5I5wjdnjPqJETt72HLA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlStPIsACgkQ8dLMyEl6F2148gCglxNRpMpXXgF/lF4jp2Hd5jQd
oDkAn258bU7MvtOx78Pudd37ovqdUH4A
=3Dv/
-----END PGP SIGNATURE-----

--moqeaKa00Du92P5I5wjdnjPqJETt72HLA--
