From: Loic Dachary <loic@dachary.org>
Subject: Time to move the make check bot to jenkins.ceph.com
Date: Mon, 21 Dec 2015 11:13:38 +0100
Message-ID: <5677D0D2.5090801@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OT5GxPJquRE2Bnl5h7ViWas0E7hRuTDB0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53749 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751074AbbLUKNk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Dec 2015 05:13:40 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 93A06420A9
	for <ceph-devel@vger.kernel.org>; Mon, 21 Dec 2015 11:13:38 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OT5GxPJquRE2Bnl5h7ViWas0E7hRuTDB0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The make check bot is broken in a way that I can't figure out right now. =
Maybe now is the time to move it to jenkins.ceph.com ? It should not be m=
ore difficult than launching the run-make-check.sh script. It does not ne=
ed network or root access.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--OT5GxPJquRE2Bnl5h7ViWas0E7hRuTDB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZ30NIACgkQ8dLMyEl6F22p1ACgnTceWCitUxAEqpCZcVFkO/hW
9EwAoJf7RblYc735FKnTGBM3Nd9YdSam
=qatl
-----END PGP SIGNATURE-----

--OT5GxPJquRE2Bnl5h7ViWas0E7hRuTDB0--
