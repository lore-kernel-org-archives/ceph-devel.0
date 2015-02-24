From: Loic Dachary <loic@dachary.org>
Subject: generic plugin support
Date: Tue, 24 Feb 2015 22:19:04 +0100
Message-ID: <54ECEAC8.7060206@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="or0FlWoeIjNHRWnNBLpD2t6maeNqJA7Lo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48368 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752234AbbBXVTI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 16:19:08 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>, "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--or0FlWoeIjNHRWnNBLpD2t6maeNqJA7Lo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I proposed a blueprint to add generic plugin support to Ceph for the upco=
ming Ceph Developer Summit that will be held next week:

    https://wiki.ceph.com/Planning/Blueprints/Infernalis/Generic_support_=
for_plugins_installation_and_upgrade

It's a rough draft still and I've created an feature request to track it =
http://tracker.ceph.com/issues/10941. Samuel Just actually created a tick=
et a year ago that proposes part of the solution at http://tracker.ceph.c=
om/issues/7291.=20

Takeshi, if such a mechanism was available, it would help deploy your new=
 shec plugin on an existing cluster, even on a giant cluster as long as t=
he plugin is ABI compatible.

Varada, it looks like a necessary first step for a generic key/value stor=
e pluggable backend.

Would you be interested to participate in such a design session ?=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--or0FlWoeIjNHRWnNBLpD2t6maeNqJA7Lo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTs6skACgkQ8dLMyEl6F227DgCeNpAwbcgLn8xSjTHUpzfdhncU
cO0AniOw0mdDPs+rhS7cHkrK9TGxICSv
=Vxpd
-----END PGP SIGNATURE-----

--or0FlWoeIjNHRWnNBLpD2t6maeNqJA7Lo--
