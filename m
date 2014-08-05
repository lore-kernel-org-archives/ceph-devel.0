From: Loic Dachary <loic@dachary.org>
Subject: ErasureCode base class
Date: Tue, 05 Aug 2014 09:53:49 +0200
Message-ID: <53E08D8D.1010303@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Sf3BmFGktFoH6BU9efxrFCpogh5rQ83Ae"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54011 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753743AbaHEHx4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Aug 2014 03:53:56 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sf3BmFGktFoH6BU9efxrFCpogh5rQ83Ae
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Would you have time to review the ErasureCode base class at https://githu=
b.com/ceph/ceph/pull/2201 ? It factorizes code that is common to ErasureC=
odeJerasure and ErasureCodeIsa. While doing so it really helped that you =
wrote the ErasureCodeIsa decode functions with only minimal changes compa=
red to those in ErasureCodeJerasure. Thanks for that :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--Sf3BmFGktFoH6BU9efxrFCpogh5rQ83Ae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPgjY0ACgkQ8dLMyEl6F23npQCfc26R5V5f824pSqW91C/qvuLf
cE0AnRYbKvqV1MrBaMIrt+BRuvbT+izG
=ZJ7m
-----END PGP SIGNATURE-----

--Sf3BmFGktFoH6BU9efxrFCpogh5rQ83Ae--
