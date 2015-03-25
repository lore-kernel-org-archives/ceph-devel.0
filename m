From: Loic Dachary <loic@dachary.org>
Subject: Re: make check bot out of order
Date: Wed, 25 Mar 2015 01:59:27 +0100
Message-ID: <5512086F.6030508@dachary.org>
References: <5511F44F.5040007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IPVbX4sdTqtToi0Wjn3iIoPDUPKpguCrM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36079 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752858AbbCYA7a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Mar 2015 20:59:30 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 1939A42137
	for <ceph-devel@vger.kernel.org>; Wed, 25 Mar 2015 01:59:28 +0100 (CET)
In-Reply-To: <5511F44F.5040007@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IPVbX4sdTqtToi0Wjn3iIoPDUPKpguCrM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The make check bot is back.=20

Long story short : the google bot exposes a leak in gitlab and disrupts a=
bout everything ( see https://gitlab.com/gitlab-org/gitlab-ce/issues/1302=
 for a followup ).

Cheers

On 25/03/2015 00:33, Loic Dachary wrote:
> Hi,
>=20
> The make check bot stopped working a few hours ago and I'm fixing it. I=
t's a strange behavior (it makes gitlab use a lot of RAM and timeout) aft=
er rebooting the machine it runs on.
>=20
> Thanks for your patience
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--IPVbX4sdTqtToi0Wjn3iIoPDUPKpguCrM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUSCG8ACgkQ8dLMyEl6F20mjACfcRrF/LR3Dkv9hAm2ptO/JvmK
kEEAoMM7jbESowJq8S50q8sAEnQY+LK4
=Q2Lr
-----END PGP SIGNATURE-----

--IPVbX4sdTqtToi0Wjn3iIoPDUPKpguCrM--
