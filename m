From: Loic Dachary <loic@dachary.org>
Subject: webmastering jerasure.org
Date: Sun, 11 Jan 2015 14:08:30 +0100
Message-ID: <54B275CE.9080206@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AJsm1oXg07hDCvxridWL6tjjFM79pk9FE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36731 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751049AbbAKNId (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Jan 2015 08:08:33 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AJsm1oXg07hDCvxridWL6tjjFM79pk9FE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

The http://jerasure.org/ page was initially setup as a custom gitlab home=
 page ( http://dachary.org/?p=3D3470 ) but it turns out to be a bad idea,=
 from a SEO point of view. When searching for jerasure, the http://jerasu=
re.org page is nowhere to be found. By default gitlab redirects the home =
page to the sign up page and that's probably the reason why it does not s=
how at all.=20

To improve the situation I moved gitlab from http://jerasure.org/ to http=
://lab.jerasure.org/ and turned http://jerasure.org/ into a static page t=
hat links to it. The static page looks similar and will hopefully not con=
fuse people too much.=20

If you see something odd / not working, it's probably because I did a mis=
take. Please let me know if that's the case and I'll fix it :-)

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--AJsm1oXg07hDCvxridWL6tjjFM79pk9FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSydc4ACgkQ8dLMyEl6F22E6QCeOCG0LbuyVq2eqUtMTUDRofnq
M2gAoMPOgb7ZEllhA7u3p445s3sjHZZ9
=5e2A
-----END PGP SIGNATURE-----

--AJsm1oXg07hDCvxridWL6tjjFM79pk9FE--
