From: Loic Dachary <loic@dachary.org>
Subject: systemd support
Date: Sat, 04 Jul 2015 00:21:51 +0200
Message-ID: <55970AFF.3020603@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sW96AdcKpweNeWxkAJPabWkvam5ligQWv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44490 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755516AbbGCWVx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jul 2015 18:21:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sW96AdcKpweNeWxkAJPabWkvam5ligQWv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[cc'ing ceph-devel in case someone else has the answer]

Hi Ken,

I know very little about systemd and I'd like to learn more. My understan=
ding is that we have some support in the current master branch, but it is=
 incomplete. Are there differences with what I would find in the Red Hat =
Storage 1.3 packages ? If I'm not mistaken RHEL7 uses systemd, therefore =
I guess there may be a better support there. Unless it's using the legacy=
 sysvinit files ?

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--sW96AdcKpweNeWxkAJPabWkvam5ligQWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWXCv8ACgkQ8dLMyEl6F20p+QCfamw1lcLMzggrFstyRsVKYWEF
yq8AoIGUCZ4ToM8MpnaWrwFb9S8KeGD9
=L/kC
-----END PGP SIGNATURE-----

--sW96AdcKpweNeWxkAJPabWkvam5ligQWv--
