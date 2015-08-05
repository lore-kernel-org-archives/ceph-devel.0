From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure Code Plugins : PLUGINS_V3 feature
Date: Wed, 05 Aug 2015 10:21:29 +0200
Message-ID: <55C1C789.3050401@dachary.org>
References: <55B899FB.4080007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VSpWU4sHjWRCPbVESvcJCFM6Q4EPuvRDi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33551 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750742AbbHEIVd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Aug 2015 04:21:33 -0400
In-Reply-To: <55B899FB.4080007@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VSpWU4sHjWRCPbVESvcJCFM6Q4EPuvRDi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

How does this proposal sound ? It would be great if that was done before =
the feature freeze.

Cheers

On 29/07/2015 11:16, Loic Dachary wrote:
> Hi Sam,
>=20
> The SHEC plugin[0] has been running in the rados runs[1] in the past fe=
w months. It also has a matching corpus verification which runs on every =
make check[2] as well as its optimized variants. I believe the flag "expe=
rimental" can now be removed.=20
>=20
> In order to do so, we need to use a PLUGINS_V3 feature, in the same way=
 we did back in Giant when the ISA and LRC plugins were introduced[3]. Th=
is won't be necessary in the future, when there is a generic plugin mecha=
nism, but right now that's what we need. It would be a commit very simila=
r to the one implementing PLUGINS_V2[4].
>=20
> Is this agreeable to you ? Or would you rather see another way to resol=
ve this ?
>=20
> Cheers
>=20
> [0] https://github.com/ceph/ceph/tree/master/src/erasure-code/shec
> [1] https://github.com/ceph/ceph-qa-suite/tree/master/suites/rados/thra=
sh-erasure-code-shec
> [2] https://github.com/ceph/ceph-erasure-code-corpus/blob/master/v0.92-=
988/non-regression.sh#L52
> [3] http://tracker.ceph.com/issues/9343
> [4] https://github.com/ceph/ceph/commit/9687150ceac9cc7e506bc227f430d42=
07a6d7489
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--VSpWU4sHjWRCPbVESvcJCFM6Q4EPuvRDi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXBx4oACgkQ8dLMyEl6F21OEQCfRctYCp3DoiF0THUeGJpmGBnp
lnkAoMBpBDo7BBmCMRBiYTKmjrtYDWPz
=ZaOk
-----END PGP SIGNATURE-----

--VSpWU4sHjWRCPbVESvcJCFM6Q4EPuvRDi--
