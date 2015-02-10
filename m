From: Loic Dachary <loic@dachary.org>
Subject: rbd and the next giant release
Date: Tue, 10 Feb 2015 16:17:31 +0100
Message-ID: <54DA210B.1000901@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="f8MKGMBsdL2cbr5HJfuAMFF1GeC90vIwd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41802 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750726AbbBJPRf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 10:17:35 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f8MKGMBsdL2cbr5HJfuAMFF1GeC90vIwd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Josh,

The rbd teuthology suite for the next giant release as found in https://g=
ithub.com/ceph/ceph/commits/giant-backports came back (see http://pulpito=
=2Eceph.com/loic-2015-02-02_23:28:17-rbd-giant-backports---basic-multi) w=
ith one ceph-qa-suite error which was fixed (see http://tracker.ceph.com/=
issues/10501#teuthology-run-6b08a729540c61f3c8b15c5a3ce9382634bf800c-febr=
uary-2015 for the details).=20

Do you think it is ready for QE to start their own round of testing ?

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre






--f8MKGMBsdL2cbr5HJfuAMFF1GeC90vIwd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTaIQsACgkQ8dLMyEl6F23H4wCdFGWvOvFNlNiAm1VOaUdLPlha
OMkAnjeIDG/g1ZS7T2SV8NCoRv78KB/9
=sI+k
-----END PGP SIGNATURE-----

--f8MKGMBsdL2cbr5HJfuAMFF1GeC90vIwd--
