From: Loic Dachary <loic@dachary.org>
Subject: Erasure Code Plugins : PLUGINS_V3 feature
Date: Wed, 29 Jul 2015 11:16:43 +0200
Message-ID: <55B899FB.4080007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Tu6wCJ0mp9QoquWL6StC0TPh7rknHsNBO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58106 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750800AbbG2JQx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 05:16:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tu6wCJ0mp9QoquWL6StC0TPh7rknHsNBO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

The SHEC plugin[0] has been running in the rados runs[1] in the past few =
months. It also has a matching corpus verification which runs on every ma=
ke check[2] as well as its optimized variants. I believe the flag "experi=
mental" can now be removed.=20

In order to do so, we need to use a PLUGINS_V3 feature, in the same way w=
e did back in Giant when the ISA and LRC plugins were introduced[3]. This=
 won't be necessary in the future, when there is a generic plugin mechani=
sm, but right now that's what we need. It would be a commit very similar =
to the one implementing PLUGINS_V2[4].

Is this agreeable to you ? Or would you rather see another way to resolve=
 this ?

Cheers

[0] https://github.com/ceph/ceph/tree/master/src/erasure-code/shec
[1] https://github.com/ceph/ceph-qa-suite/tree/master/suites/rados/thrash=
-erasure-code-shec
[2] https://github.com/ceph/ceph-erasure-code-corpus/blob/master/v0.92-98=
8/non-regression.sh#L52
[3] http://tracker.ceph.com/issues/9343
[4] https://github.com/ceph/ceph/commit/9687150ceac9cc7e506bc227f430d4207=
a6d7489

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Tu6wCJ0mp9QoquWL6StC0TPh7rknHsNBO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW4mfsACgkQ8dLMyEl6F20uVwCeI2dBnZWdLbETHy1/Yzxl53/E
qp4An3H0ypNDZ/zYeB+3CMo+4uFE5F8E
=4khu
-----END PGP SIGNATURE-----

--Tu6wCJ0mp9QoquWL6StC0TPh7rknHsNBO--
