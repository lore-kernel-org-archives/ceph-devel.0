From: Loic Dachary <loic@dachary.org>
Subject: testing the /dev/cciss/c0d0 device names
Date: Sat, 5 Dec 2015 19:36:28 +0100
Message-ID: <56632EAC.3040105@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hEaBsu4Gut7w5uxTVfsn25os7RQqJIVBT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44835 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750813AbbLESga (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Dec 2015 13:36:30 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Stolte, Felix" <f.stolte@fz-juelich.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hEaBsu4Gut7w5uxTVfsn25os7RQqJIVBT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

ceph-disk has special handling for device names like /dev/cciss/c0d1 [1] =
and it was partially broken when support for device mapper was introduced=
=2E Ideally there would be a way to test that support when running the ce=
ph-disk suite [2]. Do you know of a way to do that without having the har=
dware for which this driver is designed ?=20

Maybe this convention (/dev/cciss/c0d0 being mapped to /sys/block/cciss!c=
0d0 is not unique to this driver and I could use another to validate the =
name conversion from X/Y to X!Y and vice versa is handled as it should ?

Cheers

[1] https://github.com/ceph/ceph/blob/infernalis/src/ceph-disk#L438
[2] https://github.com/ceph/ceph/blob/infernalis/qa/workunits/ceph-disk/c=
eph-disk-test.py
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--hEaBsu4Gut7w5uxTVfsn25os7RQqJIVBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZjLqwACgkQ8dLMyEl6F23B2ACeJm2SyRvThNvryTFGaA4LQBNv
dvYAn11877mYZoGFlsBWmbgXFhlF1DM6
=drh8
-----END PGP SIGNATURE-----

--hEaBsu4Gut7w5uxTVfsn25os7RQqJIVBT--
