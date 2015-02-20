From: Loic Dachary <loic@dachary.org>
Subject: giant branch for v0.87.1 is ready for release
Date: Fri, 20 Feb 2015 23:10:02 +0100
Message-ID: <54E7B0BA.8020909@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jJEj8STSIpNjiGaFESaiWUonmRd2xxKVA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46852 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755174AbbBTWKG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Feb 2015 17:10:06 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id A3C0F420B5
	for <ceph-devel@vger.kernel.org>; Fri, 20 Feb 2015 23:10:02 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jJEj8STSIpNjiGaFESaiWUonmRd2xxKVA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

QE approved https://github.com/ceph/ceph/commit/4178e32dd085adeead84fb168=
ab8a8a121256259 for release. The release notes should now be written base=
d on the content of the issues and pull requests mentioned here http://wo=
rkbench.dachary.org/ceph/ceph-backports/wikis/giant#already-merged

I'm not sure how it was done for the past releases. I suspect Sage wrote =
most of them, asking details to Josh, Greg, Yehuda and Sam when needed. H=
ow far am I from what really happened ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--jJEj8STSIpNjiGaFESaiWUonmRd2xxKVA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTnsLoACgkQ8dLMyEl6F20CGACfXgnK9GSDvGzXcc+gVVJYLl+m
T7YAoJDS0JgJWpu6xplof9G0qUEdgWOy
=Gu0a
-----END PGP SIGNATURE-----

--jJEj8STSIpNjiGaFESaiWUonmRd2xxKVA--
