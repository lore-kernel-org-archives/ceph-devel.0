From: Loic Dachary <loic@dachary.org>
Subject: AVX optimized gf-complete
Date: Wed, 26 Mar 2014 23:44:16 +0100
Message-ID: <53335840.2080702@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DnNSwcbl7MrwprjJcSWJdPBXTxCqS0J3M"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:55575 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbaCZWoV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Mar 2014 18:44:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DnNSwcbl7MrwprjJcSWJdPBXTxCqS0J3M
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

Although https://bitbucket.org/jimplank/gf-complete does not have explici=
t #if related to AVX http://en.wikipedia.org/wiki/Advanced_Vector_Extensi=
ons , it is used when the compiler supports it ( https://bitbucket.org/ji=
mplank/gf-complete/src/f8ff1e2f64fc88bf74861a0ceec44d130ff1902c/m4/ax_ext=
=2Em4?at=3Dmaster#cl-252 ) and some AVX specific instructions are used in=
 the compiled binary.

http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/i386-and-x86-64-Options.html#=
i386-and-x86-64-Options suggests that AVX is not widely spread.

How important is AVX to gf-complete ? Is it nice to have but with margina=
l benefits ? Or does it make a significant difference ?

Thanks for all the help :-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--DnNSwcbl7MrwprjJcSWJdPBXTxCqS0J3M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMzWEMACgkQ8dLMyEl6F22YFQCghVIx6aVau5pwZd/tU+tWnu+v
DkoAniL0AgBKe9G7g0CLXqq6DZNDYK5I
=M0k3
-----END PGP SIGNATURE-----

--DnNSwcbl7MrwprjJcSWJdPBXTxCqS0J3M--
