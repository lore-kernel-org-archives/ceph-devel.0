From: Loic Dachary <loic@dachary.org>
Subject: Improving shared backport efforts
Date: Sun, 30 Aug 2015 17:39:11 +0200
Message-ID: <55E3239F.7030806@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Oh6aJhD664eP2PWt3TDI69fpDIJfXaF3N"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46287 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753468AbbH3PjQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Aug 2015 11:39:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Oh6aJhD664eP2PWt3TDI69fpDIJfXaF3N
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ken,

The tip you left at http://tracker.ceph.com/issues/12591 regarding the ba=
ckport of "rgw: create a tool for orphaned objects cleanup" was quite use=
ful, thank you !

I'm curious about what made it inconvenient for you to push a pull reques=
t when you did that backport. Maybe you just did not have time to do it, =
in which case all is well. But maybe it was because something in the back=
port procedures was confusing or blocking you, in which case I'm eager to=
 fix it. It's really selfish of me: every backport you publish is one les=
s in the queue of the stable release team ;-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Oh6aJhD664eP2PWt3TDI69fpDIJfXaF3N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXjI6AACgkQ8dLMyEl6F23qoQCdGHYCZ/vCl0ODoCGO3lSaLvmE
lAEAoI29yfGlm2DUT7Lq+4AE09p7Hk9U
=ZzNi
-----END PGP SIGNATURE-----

--Oh6aJhD664eP2PWt3TDI69fpDIJfXaF3N--
