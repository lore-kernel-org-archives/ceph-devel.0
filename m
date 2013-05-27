From: Loic Dachary <loic@dachary.org>
Subject: pg_missing_t::is_missing semantics
Date: Mon, 27 May 2013 17:29:29 +0200
Message-ID: <51A37BD9.6080109@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7EFE72BAF804FC8F0EAE0FBF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:41609 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab3E0P3b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 May 2013 11:29:31 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 15D1A26394
	for <ceph-devel@vger.kernel.org>; Mon, 27 May 2013 17:29:30 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7EFE72BAF804FC8F0EAE0FBF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

When testing if a specific version of an object is missing with pg_missin=
g_t::is_missing
https://github.com/ceph/ceph/blob/master/src/osd/osd_types.cc#L2153
if the version needed is greater than the version given in argument, fals=
e is returned.

Each object in pg_missing_t *have* a version and *need* another and *have=
* is lower than *need*.=20
https://github.com/ceph/ceph/blob/master/src/osd/osd_types.h#L1470

Here is what gets me confused:

  if (item.need > v)
    return false;
  return true;

A version lower than *need* is considered to not be missing ( by is_missi=
ng )=20
where a version greater than *need* is considered to be missing.=20

This prototype of is_missing is used at

https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc#L5910

  if (missing.is_missing(oid, v)) {
    dout(10) << "got missing " << oid << " v " << v << dendl;
    missing.got(oid, v);
    if (is_primary())
      missing_loc.erase(oid);

If the version is greater than the one needed ( i.e. it is more recent ) =
then it is not considered missing and therefore not removed from missing =
( which is what pg_missing_t::got does ).=20

Does it mean that when an object version is in missing, it will always be=
 removed because the PG will receive an object that is either of the same=
 version or lower ? And never receive an object of a version greater than=
 the one in missing ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig7EFE72BAF804FC8F0EAE0FBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGje9kACgkQ8dLMyEl6F20FBwCeNx64r6FgrvYSCRzTgoaGsbLv
ehAAn2lrgd2XaUievyHgFYih1F3o7KgC
=uJwd
-----END PGP SIGNATURE-----

--------------enig7EFE72BAF804FC8F0EAE0FBF--
