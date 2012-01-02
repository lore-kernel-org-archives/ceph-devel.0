From: =?ISO-8859-15?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Subject: scrubbing
Date: Mon, 02 Jan 2012 12:10:40 +0100
Message-ID: <4F0190B0.7070500@filoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0F9714A7C25DAF993A63F14B"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-7.de-punkt.de ([93.190.64.37]:38485 "EHLO
	mail-7.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab2ABLKs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jan 2012 06:10:48 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0F9714A7C25DAF993A63F14B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Happy new year  !!

another year another question:

I got the following from ceph -w :

2012-01-02 12:05:17.294350    pg v830384: 1254 pgs: 18 creating, 1235
active+clean, 1 active+clean+scrubbing; 586 GB data, 1378 GB used, 12763
GB / 14887 GB avail
2012-01-02 12:05:23.763982    pg v830385: 1254 pgs: 18 creating, 1235
active+clean, 1 active+clean+scrubbing; 586 GB data, 1378 GB used, 12763
GB / 14887 GB avail
2012-01-02 12:05:27.295568    pg v830386: 1254 pgs: 18 creating, 1235
active+clean, 1 active+clean+scrubbing; 586 GB data, 1378 GB used, 12763
GB / 14887 GB avail
2012-01-02 12:05:28.765457    pg v830387: 1254 pgs: 18 creating, 1235
active+clean, 1 active+clean+scrubbing; 586 GB data, 1378 GB used, 12763
GB / 14887 GB avail

ceph pg dump | grep scrub:
pg_stat    objects    mip    degr    unf    kb    bytes    log  =20
disklog    state    v    reported    up    acting    last_scrub
34.2    1583    0    0    0    6125554    6272545912    3319    3319  =20
active+clean+scrubbing    933'385350    926'63653    [3,4]    [3,4]  =20
927'337222    2011-12-27 13:20:42.436092

This happens once a week. If i restart ceph i takes a moment an the
"scrubbing" disappears.

--=20
mit freundlichen Gr=FCssen

Jens Rehp=F6hler

----------------------------------------------------------------------
Filoo GmbH
Moltkestr. 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz
Telefon: +49 5241 8673012 | Mobil: +49 151 54645798
Hotline: 07000-3378658 (14 Ct/min) Fax: +49 5241 8673020



--------------enig0F9714A7C25DAF993A63F14B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8BkLQACgkQrXbD/qaJ+dMoEQCgiuJJeoprZlWG2eMXjinunV3A
cqwAn2fo4ieM8wDsI1zxZl82R+1v4Exs
=9VaM
-----END PGP SIGNATURE-----

--------------enig0F9714A7C25DAF993A63F14B--
