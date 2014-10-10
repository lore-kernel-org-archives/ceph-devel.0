From: Loic Dachary <loic@dachary.org>
Subject: arm7 gitbuilder ?
Date: Fri, 10 Oct 2014 11:28:32 +0200
Message-ID: <5437A6C0.3000005@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IuIcRwUFIwf3Xd9psR8DiwawH2SxAKul0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41757 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751944AbaJJJ2i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 05:28:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sandon Van Ness <sandon@inktank.com>
Cc: Janne Grunau <j@jannau.net>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IuIcRwUFIwf3Xd9psR8DiwawH2SxAKul0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sandon,

Would it be possible to resurect / create an arm7 gitbuilder for whatever=
 distribution is more convenient ? Janne made a great contribution to era=
sure code optimization on NEON ( https://bitbucket.org/jannau/gf-complete=
/branch/neon ) and it would make it easier to have a gitbuilder to run it=
 throught teuthology and torture it ;-) If that's complicated or there is=
 another way to run teuthology jobs for this purpose, I'm open to suggest=
ions.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--IuIcRwUFIwf3Xd9psR8DiwawH2SxAKul0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ3psAACgkQ8dLMyEl6F230UgCdH3T/iUFBNeOsIQMtg9zrTagd
/V0AnjRjMb6Y4vYHUAJq2c4aLQh/URCm
=lCGj
-----END PGP SIGNATURE-----

--IuIcRwUFIwf3Xd9psR8DiwawH2SxAKul0--
