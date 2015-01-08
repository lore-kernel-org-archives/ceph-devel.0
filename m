From: Loic Dachary <loic@dachary.org>
Subject: Re: Testing the next giant release
Date: Thu, 08 Jan 2015 10:39:50 +0100
Message-ID: <54AE5066.2000102@dachary.org>
References: <54AD3C8B.4030705@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lqGeOltbMbBqXnQItPuh52aAOiOAUUV1T"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35291 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752640AbbAHJjx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jan 2015 04:39:53 -0500
In-Reply-To: <54AD3C8B.4030705@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tamil Muthamizhan <tmuthamizhan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lqGeOltbMbBqXnQItPuh52aAOiOAUUV1T
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The giant-backports branch has been built by gitbuilders tonight

http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-trusty-amd64-basic/#=
origin/giant-backports
etc.

and I scheduled a rbd suite with

=2E/virtualenv/bin/teuthology-suite --teuthology-branch giant --suite rbd=
 --suite-branch giant --machine-type vps --distro ubuntu --email loic@dac=
hary.org --owner loic@dachary.org  --ceph giant-backports

which shows at

http://pulpito.ceph.com/loic-2015-01-08_10:36:47-rbd-giant-backports-test=
ing-basic-vps/

To be continued !

On 07/01/2015 15:02, Loic Dachary wrote:
> Hi Tamil,
>=20
> I've merged / integrated the giant backports found at
>=20
> https://github.com/ceph/ceph/pull/3186
> https://github.com/ceph/ceph/pull/3178
> https://github.com/ceph/ceph/pull/2954
> https://github.com/ceph/ceph/pull/3191
> https://github.com/ceph/ceph/pull/3168
> https://github.com/ceph/ceph/pull/3289
>=20
> into=20
>=20
> http://workbench.dachary.org/ceph/ceph/commit/0ea20e6c51208d6710f469454=
ab3f964bfa7c9d2
>=20
> and successfully ran make check on it
>=20
> http://workbench.dachary.org:8080/projects/10?ref=3Dgiant-backports
>=20
> If I'm not mistaken the next step would be to run teuthology. If I'm to=
 do it, would you be so kind as to let me know which suites are most rele=
vant ? If someone else will take care of it, should I push the integratio=
n branch somewhere ?
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--lqGeOltbMbBqXnQItPuh52aAOiOAUUV1T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSuUGYACgkQ8dLMyEl6F22TOgCgjbwOCsmcOxujpUT6T5Pe5pIT
QfQAn3rPNJPJCZPMPrr8n2cuUK1oDdM4
=er4z
-----END PGP SIGNATURE-----

--lqGeOltbMbBqXnQItPuh52aAOiOAUUV1T--
