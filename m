From: Loic Dachary <loic@dachary.org>
Subject: test/run-rbd-unit-tests.sh : pure virtual method called
Date: Mon, 03 Aug 2015 18:01:31 +0200
Message-ID: <55BF905B.3020008@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LG9OeKW3CVTwQ6BPhjsPxr2lwwPl8mFMB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60700 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752231AbbHCQBg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 12:01:36 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>, Josh Durgin <josh.durgin@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LG9OeKW3CVTwQ6BPhjsPxr2lwwPl8mFMB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

test/run-rbd-unit-tests.sh failed today on master on Ubuntu 14.04, when r=
un by the make check bot on an unrelated pull request (modifying do_autog=
en which is not used by the make check bot).

http://jenkins.ceph.dachary.org/job/ceph/LABELS=3Dubuntu-14.04&&x86_64/68=
34/console

[ RUN      ] TestInternal.MultipleResize
pure virtual method called
terminate called without an active exception

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre




--LG9OeKW3CVTwQ6BPhjsPxr2lwwPl8mFMB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW/kFsACgkQ8dLMyEl6F22o8ACcDnZMu/aL4eGiKMIOzOVHFrDr
EjwAoL0w0h16emnMAPQtB2NGW/pzInTl
=ciBx
-----END PGP SIGNATURE-----

--LG9OeKW3CVTwQ6BPhjsPxr2lwwPl8mFMB--
