From: Loic Dachary <loic@dachary.org>
Subject: jerasure / gf-complete & 32 bits
Date: Fri, 28 Mar 2014 18:15:41 +0100
Message-ID: <5335AE3D.1050104@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SEsMla2aENBrswJTiL841Nexmo7mIHr8o"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:57643 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbaC1RPq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Mar 2014 13:15:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SEsMla2aENBrswJTiL841Nexmo7mIHr8o
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

Someone mentionned a problem (no more information at the moment ;-) about=
 running jerasure / gf-complete on a 32 bits machine. Does that ring a be=
ll ? I'll try it out with the test method you suggested:

"'gf_methods <w> -A -U' to run all of the tests for w=3D[4,8,16,32,64,128=
]. Then, I install a fresh Jerasure and run test_all_gfs.sh and time_all_=
gfs_argv_init.sh. Finally, I install PyECLib (Python library that wraps J=
erasure, ISA-L (soon) and has some homegrown XOR- codes) and run the scri=
pts under tests/."

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--SEsMla2aENBrswJTiL841Nexmo7mIHr8o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM1rkAACgkQ8dLMyEl6F22UUQCgqjBj7hwaUO2ak0Q3+u5FFf2E
JfEAoJZT3s+O90zF/Th76hgI7Cf2IqS5
=thSX
-----END PGP SIGNATURE-----

--SEsMla2aENBrswJTiL841Nexmo7mIHr8o--
