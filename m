From: Loic Dachary <loic@dachary.org>
Subject: make check bot resumed
Date: Mon, 9 Nov 2015 15:33:22 +0100
Message-ID: <5640AEB2.6030802@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="49JhnlHKCJia0q0FivrXJV65Qf5k5GHjq"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57376 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751797AbbKIOd1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 09:33:27 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id C57D142B29
	for <ceph-devel@vger.kernel.org>; Mon,  9 Nov 2015 15:33:22 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--49JhnlHKCJia0q0FivrXJV65Qf5k5GHjq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The machine sending notifications for the make check bot failed during th=
e week-end. It was rebooted and it should resume its work.=20

The virtual machine was actually re-built because the underlying OpenStac=
k cloud was unable to find the volume used for root after a hard reboot. =
There were also issues with the devicemapper docker backend that was corr=
upted. Wiping them out was enough to resolve the problem: they did not ha=
ve any persistent data anyway.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--49JhnlHKCJia0q0FivrXJV65Qf5k5GHjq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZArrIACgkQ8dLMyEl6F20oDgCgubuSnznc23o7kXAi+Qd6ftm/
XjUAn0XipJFuVh52sTw2quWWrzG3eM0w
=Phmj
-----END PGP SIGNATURE-----

--49JhnlHKCJia0q0FivrXJV65Qf5k5GHjq--
