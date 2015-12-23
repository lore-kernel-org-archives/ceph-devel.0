From: Loic Dachary <loic@dachary.org>
Subject: jenkins on ceph pull requests: clarify which Operating System is used
Date: Wed, 23 Dec 2015 10:02:12 +0100
Message-ID: <567A6314.9020602@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Tvx5egnqCrkPaHMUT4DLwaLuAk7O5BiDp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54668 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753914AbbLWJCR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Dec 2015 04:02:17 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tvx5egnqCrkPaHMUT4DLwaLuAk7O5BiDp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alfredo,

I see a make check slave currently runs on jessie and I think to remember=
 it ran on trusty slaves before. It's a good thing operating systems are =
mixed but there does not seem to be a clear indication about which operat=
ing system is used. For instance regarding:

https://jenkins.ceph.com/job/ceph-pull-requests/44/

one has to click on the console and know that it shows in the first few l=
ines as:

Building remotely on centos6+158.69.78.199 (x86_64 huge centos6 amd64) in=
 workspace=20

Side note: as CentOS 6 is no longer a supported platform, trying to build=
 on it will fail.

Another problem is that chosing an operating system randomly may lead to =
different test results and the inability for the author of the pull reque=
st to chose repeat the bug because the operating system on which it happe=
ns is not selected.

Unless there is a know strategy with jenkins to deal with that kind of pr=
oblem, it probably is best to stick to a single Operating System and Cent=
OS 7 would be my choice.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Tvx5egnqCrkPaHMUT4DLwaLuAk7O5BiDp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZ6YxQACgkQ8dLMyEl6F21YkwCeJDT38qcyu5HDGjeDQ6Io0ZZL
lasAoIeWOhKN91AoV8np2xQTa9qlyT5d
=gnrl
-----END PGP SIGNATURE-----

--Tvx5egnqCrkPaHMUT4DLwaLuAk7O5BiDp--
