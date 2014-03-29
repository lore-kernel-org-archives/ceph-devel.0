From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure / gf-complete & 32 bits
Date: Sat, 29 Mar 2014 10:08:51 +0100
Message-ID: <53368DA3.7080206@dachary.org>
References: <5335AE3D.1050104@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wmJFXX9RhT9LxdLGOrMaGjpOwrn4Gms5v"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:58212 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbaC2JI4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Mar 2014 05:08:56 -0400
In-Reply-To: <5335AE3D.1050104@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wmJFXX9RhT9LxdLGOrMaGjpOwrn4Gms5v
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The gf-complete + jerasure tests run fine on Ubuntu saucy 32 bits. The pr=
oblem is when trying to compile on a 32 bits machine as shown here

http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-precise-i386-bas=
ic/log.cgi?log=3Dcb624fc9ed1e891e51cc0d20622d43f6fcd08cd5


On 28/03/2014 18:15, Loic Dachary wrote:
> Hi Kevin,
>=20
> Someone mentionned a problem (no more information at the moment ;-) abo=
ut running jerasure / gf-complete on a 32 bits machine. Does that ring a =
bell ? I'll try it out with the test method you suggested:
>=20
> "'gf_methods <w> -A -U' to run all of the tests for w=3D[4,8,16,32,64,1=
28]. Then, I install a fresh Jerasure and run test_all_gfs.sh and time_al=
l_gfs_argv_init.sh. Finally, I install PyECLib (Python library that wraps=
 Jerasure, ISA-L (soon) and has some homegrown XOR- codes) and run the sc=
ripts under tests/."
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--wmJFXX9RhT9LxdLGOrMaGjpOwrn4Gms5v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM2jaYACgkQ8dLMyEl6F21xEgCdEEvwZANxCb9xl8lesc0Y6T6n
vOIAn0PuOiCdeYHn6RxB194w1J6qvA3/
=D+CN
-----END PGP SIGNATURE-----

--wmJFXX9RhT9LxdLGOrMaGjpOwrn4Gms5v--
