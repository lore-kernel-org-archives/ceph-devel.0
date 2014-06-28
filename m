From: Loic Dachary <loic@dachary.org>
Subject: Highbank ARM benchmarks for erasure code jerasure plugin
Date: Sat, 28 Jun 2014 19:43:04 +0200
Message-ID: <53AEFEA8.5000209@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2QoVKrOs1n6xpkJHRi6RFkqmJgWPuvF5W"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59568 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751425AbaF1RnL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Jun 2014 13:43:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2QoVKrOs1n6xpkJHRi6RFkqmJgWPuvF5W
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Mark,

The benchmarks described here http://dachary.org/?p=3D3099 were run on sa=
ya001 (for rev0) and saya037 (for rev2). If you have time to look into it=
, you can screen -x to find the shell used to run the command. The machin=
es are locked but feel free to impersonate me and steal them ;-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--2QoVKrOs1n6xpkJHRi6RFkqmJgWPuvF5W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOu/qgACgkQ8dLMyEl6F20/ZwCeJ/wxxWNP0WsTTW0UcCAEQPqN
yeAAn1VNqMjOGVVKoRCOztDHk23HoNq3
=I4Vn
-----END PGP SIGNATURE-----

--2QoVKrOs1n6xpkJHRi6RFkqmJgWPuvF5W--
