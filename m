From: Loic Dachary <loic@dachary.org>
Subject: Deferred deletion of ObjectContext
Date: Thu, 15 Aug 2013 16:12:55 +0200
Message-ID: <520CE1E7.8070301@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig481D219E3739E8126DC9520A"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:34200 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757675Ab3HOOM7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Aug 2013 10:12:59 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig481D219E3739E8126DC9520A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I've amended https://github.com/ceph/ceph/pull/414 with

https://github.com/dachary/ceph/commit/66e42d0ec29ffdd2edc225f4090a132a50=
d9665b#L0R4668

  bool locked =3D is_locked();
  if (!locked)
    lock();

  if (obc->ssc)
    put_snapset_context(obc->ssc);

  if (object_contexts.empty())
    kick();

  if (!locked)
    unlock();

This callback may be called at any time and it is not possible to assume =
the PG is locked when it happens. With manual reference counting, this pa=
rt of code was guaranteed to be called when the PG was locked. PG::lock()=
 is called at the beginning and PG::unlock() at the end to provide the sa=
me guarantee.

It runs ok with https://github.com/ceph/ceph/pull/414#issuecomment-227050=
40 and https://github.com/ceph/ceph/pull/414#issuecomment-22705040 . If i=
t sounds reasonable to you I'll schedule another rados suite.=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig481D219E3739E8126DC9520A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIM4ecACgkQ8dLMyEl6F23bJwCgkTY5oRKc8+FeQmjVlTedgruQ
kPsAoKmhcXEBii16Aybf03MEpp8OdH4B
=n9kb
-----END PGP SIGNATURE-----

--------------enig481D219E3739E8126DC9520A--
