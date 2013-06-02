From: Loic Dachary <loic@dachary.org>
Subject: rationale for a PGLog::merge_old_entry case
Date: Sun, 02 Jun 2013 13:09:55 +0200
Message-ID: <51AB2803.9010807@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0354007AEE79BC0321560A71"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:42000 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab3FBLJ7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Jun 2013 07:09:59 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0354007AEE79BC0321560A71
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

TL;DR:

When there no new entry, what is the rationale for merge_old_entry to rem=
ove the object from missing only if the tail is eversion_t() and the obje=
ct prior_version is also eversion_t() ?
https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa76245=
e57d/src/osd/PGLog.cc#L330

Long version:

The conditions are created with:

    info.log_tail =3D eversion_t();
    oe.soid.hash =3D 1;
    oe.op =3D pg_log_entry_t::DELETE;
    oe.prior_version =3D eversion_t();
   =20
    missing.add(oe.soid, eversion_t(1,1), eversion_t());

as shown in
https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa76245=
e57d/src/test/osd/TestPGLog.cc#L467
I double checked with gdb and when called with

EXPECT_FALSE(merge_old_entry(t, oe, info, remove_snap, dirty_log));
https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa76245=
e57d/src/test/osd/TestPGLog.cc#L481

it reaches

missing.rm(oe.soid, missing.missing[oe.soid].need);
https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa76245=
e57d/src/osd/PGLog.cc#L330

and the expected side effects are observed:

    EXPECT_FALSE(dirty_log);
    EXPECT_TRUE(remove_snap.empty());
    EXPECT_TRUE(t.empty());
    EXPECT_FALSE(missing.have_missing());
    EXPECT_TRUE(log.empty());
    EXPECT_EQ(0U, ondisklog.length());
https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa76245=
e57d/src/test/osd/TestPGLog.cc#L483

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig0354007AEE79BC0321560A71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGrKAMACgkQ8dLMyEl6F23OFQCbBRmxcm9f8OjMjpZGcMo5a+9C
DF8AnjJ75+tTVvZemPrwgGyR/sYDzhVQ
=sngw
-----END PGP SIGNATURE-----

--------------enig0354007AEE79BC0321560A71--
