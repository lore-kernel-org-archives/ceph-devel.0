From: Loic Dachary <loic@dachary.org>
Subject: BlaumRoth with w=7 : what are the consequences ?
Date: Wed, 24 Sep 2014 18:51:07 +0200
Message-ID: <5422F67B.3000302@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lS8tvcpPsUH8EB5WaSWK0Jh6DHmAAJhaC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59145 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751940AbaIXQvM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Sep 2014 12:51:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lS8tvcpPsUH8EB5WaSWK0Jh6DHmAAJhaC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

When implementing the plugin for Ceph, the check for isprime(w+1) was not=
 added and w=3D7 was made the default for the BlaumRoth technique. As a r=
esult all content encoded with the BlaumRoth technique have used this par=
ameter. I do not know what the consequences are. It does not crash and fr=
om what I've tried content can be encoded/decoded/repaired fine. But mayb=
e I was lucky ?=20

Your expert opinion on the consequence of chosing w=3D7 would be greatly =
appreciated :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--lS8tvcpPsUH8EB5WaSWK0Jh6DHmAAJhaC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQi9nsACgkQ8dLMyEl6F22ccACePZTbfA1S1ikKMfFXGPV0gYXR
z2QAoJeTdaau7ltMcZHXs/eng6KOxQ8d
=IqDq
-----END PGP SIGNATURE-----

--lS8tvcpPsUH8EB5WaSWK0Jh6DHmAAJhaC--
