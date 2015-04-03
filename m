From: Loic Dachary <loic@dachary.org>
Subject: Re: the tarbal gitbuilders are currently broken
Date: Fri, 03 Apr 2015 20:41:02 +0200
Message-ID: <551EDEBE.6060906@dachary.org>
References: <551DFF73.4040700@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oVdL5rBCfxbtjvq32gtAJK6lfbfA7Ku8q"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41448 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752536AbbDCSlG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Apr 2015 14:41:06 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 36D4042B21
	for <ceph-devel@vger.kernel.org>; Fri,  3 Apr 2015 20:41:03 +0200 (CEST)
In-Reply-To: <551DFF73.4040700@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oVdL5rBCfxbtjvq32gtAJK6lfbfA7Ku8q
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

They have been fixed and run make check.

On 03/04/2015 04:48, Loic Dachary wrote:
> Hi,
>=20
> After re-installing the tarbal gitbuilders so that they run make check =
(which they didn't in the past few weeks), it turns out that some of them=
 timeout. https://github.com/ceph/autobuild-ceph/pull/39/files will hopef=
ully fix this by running make -jX check. It has been installed on gitbuil=
der-ceph-tarball-trusty-amd64-basic for testing.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--oVdL5rBCfxbtjvq32gtAJK6lfbfA7Ku8q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUe3r4ACgkQ8dLMyEl6F21AzgCfTeuhzaYnOd+Plw8R8eldTQjs
Vw0AoMJwMBeWiLoRSm0EZ9qqfeccuO+K
=0fiY
-----END PGP SIGNATURE-----

--oVdL5rBCfxbtjvq32gtAJK6lfbfA7Ku8q--
