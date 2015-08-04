From: Loic Dachary <loic@dachary.org>
Subject: Re: rados and the next hammer release v0.94.3
Date: Tue, 04 Aug 2015 12:23:38 +0200
Message-ID: <55C092AA.9050402@dachary.org>
References: <55BF8BD7.7020003@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="gX2q0wsDteG7bb2j7lKretAiut5qBSQNS"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:32887 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754809AbbHDKXn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 06:23:43 -0400
In-Reply-To: <55BF8BD7.7020003@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gX2q0wsDteG7bb2j7lKretAiut5qBSQNS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

The backport for http://tracker.ceph.com/issues/12465 has been merged (ht=
tps://github.com/ceph/ceph/pull/5405). Since http://tracker.ceph.com/issu=
es/12410 and http://tracker.ceph.com/issues/12536 are not ready, they wil=
l wait for v0.94.4.

The next hammer release as found at https://github.com/ceph/ceph/tree/ham=
mer passed the rados suite. Do you think it is ready for QE to start thei=
r own round of testing ?

Cheers

On 03/08/2015 17:42, Loic Dachary wrote:> Hi Sam,
>=20
> We need http://tracker.ceph.com/issues/12465 in hammer v0.94.3. Is ther=
e anything else we want before publishing this release ? Should we wait f=
or http://tracker.ceph.com/issues/12410 maybe ? And http://tracker.ceph.c=
om/issues/12536 ?
>=20
> The next hammer release as found at https://github.com/ceph/ceph/tree/h=
ammer passed the rados suite. Provided it also contains the fixes for the=
 above three issues, do you think it is ready for QE to start their own r=
ound of testing ?
>=20
> Cheers
>=20
> P.S. http://tracker.ceph.com/issues/11990#Release-information has direc=
t links to the pull requests merged into hammer since v0.94.2 in case you=
 need more context about one of them.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--gX2q0wsDteG7bb2j7lKretAiut5qBSQNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXAkqoACgkQ8dLMyEl6F23MlgCfdqlozArPlVaUckfzs/tqCkj8
jdIAoL58N6i5ozOiiQdonG/Wrk1Ni404
=fdxA
-----END PGP SIGNATURE-----

--gX2q0wsDteG7bb2j7lKretAiut5qBSQNS--
