From: Loic Dachary <loic@dachary.org>
Subject: ghobjects: assert in FileStore::lfn_open
Date: Fri, 27 Sep 2013 16:12:04 +0200
Message-ID: <52459234.9060609@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GCHReASSLEiI7uSB9vDBLnLODj6thGDqb"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:47379 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab3I0OMG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Sep 2013 10:12:06 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GCHReASSLEiI7uSB9vDBLnLODj6thGDqb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi David,

In

int FileStore::lfn_open(coll_t cid,
			const ghobject_t& oid,
			bool create,
			FDRef *outfd,
			IndexedPath *path,
			Index *index)
{
  assert(get_allow_sharded_objects() || oid.shard_id =3D=3D ghobject_t::N=
O_SHARD);
  assert(outfd);

would it make sense to

assert(get_allow_sharded_objects() || ( oid.shard_id =3D=3D ghobject_t::N=
O_SHARD) && oid.generation =3D=3D ghobject_t::NO_GEN) )

instead ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--GCHReASSLEiI7uSB9vDBLnLODj6thGDqb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJFkjQACgkQ8dLMyEl6F23fFwCgxzc3dZgzSLKsxdL0xZd5maTv
aYcAn2mFHDDl2fkN05/5uKuMduZhA7gk
=OveQ
-----END PGP SIGNATURE-----

--GCHReASSLEiI7uSB9vDBLnLODj6thGDqb--
