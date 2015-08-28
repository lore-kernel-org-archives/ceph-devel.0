From: Loic Dachary <loic@dachary.org>
Subject: Hammer backport and bypassing procedure
Date: Fri, 28 Aug 2015 21:16:38 +0200
Message-ID: <55E0B396.2090602@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="57MiWgjVFCeCNwS52G07uIocTaXa5WmG3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45506 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752164AbbH1TQl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Aug 2015 15:16:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--57MiWgjVFCeCNwS52G07uIocTaXa5WmG3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

We've just had an example of a backport merged into hammer although it di=
d not follow the procedure : https://github.com/ceph/ceph/pull/5691

It's a key aspect of backports : we're bound to follow procedure, but dev=
elopers are allowed to bypass it entirely. It may seem like something lea=
ding to chaos and frustration but it turns out to be exactly the opposite=
=2E In a nutshell, it would be constant source of frustration for develop=
ers to learn and obey the rules documented at http://tracker.ceph.com/pro=
jects/ceph-releases/wiki/HOWTO because it would not benefit them signific=
antly. It would also be a problem for us, backporters, because developers=
 would not be as interested in backporting and our workload would signifi=
cantly increase.

When a developer prepares a backport on his / her own, we update the pull=
 request and the issues to obey the procedure so the (s)he does not have =
to. Sure, it's a little tedious but it's a small price to pay for the ben=
efit of having a backport being dealt with. That's what I did for https:/=
/github.com/ceph/ceph/pull/5691 : updaging the corresponding issues, addi=
ng cross references to the pull request.

Samuel Just felt confident enough about the backport that it did not need=
 a rados run to verify it does the right thing. Since it's ultimately Sam=
's responsibility, that's also ok. The only thing we need to keep in mind=
 when analyzing the next rados run is that this backport did not pass yet=
=2E We don't have a way to mark commits that bypassed tests just yet, if =
you have ideas let us know :-)

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--57MiWgjVFCeCNwS52G07uIocTaXa5WmG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXgs5YACgkQ8dLMyEl6F20ahwCfe5MfdA1O0xIXW74RONOZUn3h
PKMAoIVWxVf+AQe7lMwE2drQRXNsH1qA
=lGJK
-----END PGP SIGNATURE-----

--57MiWgjVFCeCNwS52G07uIocTaXa5WmG3--
