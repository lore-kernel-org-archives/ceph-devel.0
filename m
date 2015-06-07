From: Loic Dachary <loic@dachary.org>
Subject: provisioning teuthology targets with OpenStack
Date: Sun, 07 Jun 2015 19:04:52 +0200
Message-ID: <557479B4.9060207@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OHE3K3EctTUoR75INLnH2IS9hpmA4OrpR"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57837 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751722AbbFGRFA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Jun 2015 13:05:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zcerza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OHE3K3EctTUoR75INLnH2IS9hpmA4OrpR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zack,

I'm motivated by my recent experience with hacking teuthology and contain=
ers :-) I'd like to give

http://tracker.ceph.com/issues/6502 "provision targets using a cloud API"=


a shot with OpenStack in mind (because I know nothing of EC2 really). The=
 idea is to make it relatively easy for someone with access to an OpenSta=
ck tenant to using instead of downburst. Not only would that simplify the=
 development process for people without access to the lab, it would also =
allow the addition of more horsepower to the lab. What do you think ?

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--OHE3K3EctTUoR75INLnH2IS9hpmA4OrpR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlV0ebQACgkQ8dLMyEl6F23FzwCgxKJDAdmEAb05TClhqEIUJfxx
w88AmgOZPRi01xQLn6e8QfRV9Wk9Nqdy
=2lPv
-----END PGP SIGNATURE-----

--OHE3K3EctTUoR75INLnH2IS9hpmA4OrpR--
