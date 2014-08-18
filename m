From: Loic Dachary <loic@dachary.org>
Subject: Stopping ceph daemons during the upgrade
Date: Mon, 18 Aug 2014 17:19:48 +0200
Message-ID: <53F21994.5000202@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LUBRelWcv1RNOVIIxsbnoRkOnFdPM4Wcu"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33305 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751284AbaHRPTz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 11:19:55 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 98CEE4209E
	for <ceph-devel@vger.kernel.org>; Mon, 18 Aug 2014 17:19:48 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LUBRelWcv1RNOVIIxsbnoRkOnFdPM4Wcu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

To not confuse the ceph daemons during a package upgrade ( see http://tra=
cker.ceph.com/issues/9153#note-13 for instance ), it would be better to s=
top the ceph daemons while ceph is being upgraded. Does that sound reason=
able ?

Here is how it could be done for .deb packages : https://github.com/dacha=
ry/ceph/commit/cf3a0e7bef25e5190f3cdb69e57cb6b868d806fa and there probabl=
y is a way to do something similar with RPM packages.=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--LUBRelWcv1RNOVIIxsbnoRkOnFdPM4Wcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPyGZQACgkQ8dLMyEl6F214xQCfVaJhKYyVLUW5TvxNw9AHLUk0
7GcAoL3HJ7YXBGiNGqwBD7MDGSGw2MEg
=ZPPM
-----END PGP SIGNATURE-----

--LUBRelWcv1RNOVIIxsbnoRkOnFdPM4Wcu--
