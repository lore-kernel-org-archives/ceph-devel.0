From: Loic Dachary <loic@dachary.org>
Subject: review request : ReplicatedPG::AccessMode::wake removal
Date: Wed, 14 Aug 2013 12:17:29 +0200
Message-ID: <520B5939.9050503@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF8E37A047645FFBCD13D474B"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:50270 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab3HNKRc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 06:17:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF8E37A047645FFBCD13D474B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

IIRC, a few weeks ago you told me that=20

https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f58=
2/src/osd/ReplicatedPG.cc#L4626

  if (mode.wake) {
    requeue_ops(mode.waiting);
    for (list<Cond*>::iterator p =3D mode.waiting_cond.begin(); p !=3D mo=
de.waiting_cond.end(); ++p)
      (*p)->Signal();
    mode.wake =3D false;
  }=20

was not used and could be discarded. In the context of https://github.com=
/ceph/ceph/pull/414 I originally kept calling it wherever put_object_cont=
ext() was called, just to make sure no opportunity to signal the waiters =
was missed.=20

Since that could lead to very subtle bugs if I misunderstood what you mea=
nt, I would very much appreciate a review of this specific commit.=20

https://github.com/dachary/ceph/commit/014997d55aa8d614fe38a1f86faa246d3c=
13e21b

I've not hit anything suspicious yet while running teuthology. But that's=
 really the only part of this patch series that worries me.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigF8E37A047645FFBCD13D474B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlILWToACgkQ8dLMyEl6F22m4ACeI8yCIXFOhH8ziTi1jdJDkCiY
6UYAoKz4wctXh3zZmgqowMaG8Hlq8Gbp
=njC2
-----END PGP SIGNATURE-----

--------------enigF8E37A047645FFBCD13D474B--
