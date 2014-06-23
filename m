From: Loic Dachary <loic@dachary.org>
Subject: Ceph Developer Summit : locally repairable codes
Date: Mon, 23 Jun 2014 11:55:55 +0200
Message-ID: <53A7F9AB.7050507@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3hs2qWMKBHvKP0WwB5NfcT859TWpe12xJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:52860 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbaFWJz6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jun 2014 05:55:58 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Koleos Fuscus <koleosfuscus@yahoo.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3hs2qWMKBHvKP0WwB5NfcT859TWpe12xJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

I shortly summarized the state of the locally repairable plugin implement=
ation for tomorrow's Ceph Developers Summit at:

  http://pad.ceph.com/p/GH-locally-repairable-code

There has been no significant changes since you last reviewed it, you sho=
uld not be surprised. If you see anything odd, feel free to update the pa=
d. Or let me know and I'll work on it ;-)

I also cc'ed koleosfuscus who's working on the erasure code reliability m=
odel. It would be great if you could attend although it's late (if I'm no=
t mistaken you're both in the same time zone).

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--3hs2qWMKBHvKP0WwB5NfcT859TWpe12xJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOn+asACgkQ8dLMyEl6F20n6gCbBe5oYXvKCrxZbu7o7D04jzvw
+tEAn1IsWrQn/3wUB1QyoMcNmRJ/76An
=P3TP
-----END PGP SIGNATURE-----

--3hs2qWMKBHvKP0WwB5NfcT859TWpe12xJ--
