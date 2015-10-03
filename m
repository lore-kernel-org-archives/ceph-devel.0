From: Loic Dachary <loic@dachary.org>
Subject: Preparing hammer v0.94.5
Date: Sat, 03 Oct 2015 10:39:02 +0200
Message-ID: <560F9426.80208@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hRtvPIr1Ftr2vNpw7sEoo6Iw9Ma8PuN4v"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36839 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751805AbbJCIjH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Oct 2015 04:39:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hRtvPIr1Ftr2vNpw7sEoo6Iw9Ma8PuN4v
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

The v0.94.5 version was added to the list of versions and you should now =
be able to create the issue to track its progress. Since v0.94.4 is in th=
e process of being tested, most of the ~50 backports in flight[1] will ac=
tually be for v0.94.5 and we can start testing them. The worst that can h=
appen is that a few of them shift to v0.94.4 because they are needed afte=
r all. From the point of view of v0.94.5 that's all the same.

The next step is to create the issue[2] and you should have all the crede=
ntials you need to do so.=20

This will be your first time driving a point release but there should be =
no surprises: you already know all about the process :-)

Cheers

[1] https://github.com/ceph/ceph/pulls?q=3Dis%3Aopen+is%3Apr+milestone%3A=
hammer
[2] http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start_worki=
ng_on_a_new_point_release#Create-new-task

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--hRtvPIr1Ftr2vNpw7sEoo6Iw9Ma8PuN4v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYPlCYACgkQ8dLMyEl6F20+jgCglz4I7y/W4ymfh8yZ872101Zp
MXwAoMBXJGXDv0kRHn+Lj7Rki4RTj7s1
=YBDw
-----END PGP SIGNATURE-----

--hRtvPIr1Ftr2vNpw7sEoo6Iw9Ma8PuN4v--
