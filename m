From: Loic Dachary <loic@dachary.org>
Subject: partprobe or partx or ... ?
Date: Sat, 19 Sep 2015 17:23:36 +0200
Message-ID: <55FD7DF8.7060601@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Fhg3BrkXgnK54gX4XNOo3ouCrQecsQOHB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57972 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754712AbbISPXi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Sep 2015 11:23:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fhg3BrkXgnK54gX4XNOo3ouCrQecsQOHB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

At present ceph-disk uses partprobe to ensure the kernel is aware of the =
latest partition changes after a new one is created, or after zapping the=
 partition table. Although it works reliably (in the sense that the kerne=
l is indeed aware of the desired partition layout), it goes as far as to =
remove all partition devices of the current kernel table, only to re-add =
them with the new partition table. The delay it implies is not an issue b=
ecause ceph-disk is rarely called. It however generate many udev events (=
dozens remove/change/add for a two partition disk) and almost always crea=
tes border cases that are difficult to figure out and debug. While it is =
a good way to ensure that ceph-disk is idempotent and immune to race cond=
itions, maybe it is needlessly hard.

Do you know of a light weight alternative to partprobe ? In the past we'v=
e used partx but I remember it failed to address some border cases in non=
-intuitive ways. Do you know of another, simpler, approach to this ?

Thanks in advance for your help :-)

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Fhg3BrkXgnK54gX4XNOo3ouCrQecsQOHB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlX9ffgACgkQ8dLMyEl6F201lACgjzp7NZ8Rn59g9izaMuuMmt6W
d94An2qY6ClDbt/YUJ4pr8hNT9Yh01ub
=1PMt
-----END PGP SIGNATURE-----

--Fhg3BrkXgnK54gX4XNOo3ouCrQecsQOHB--
