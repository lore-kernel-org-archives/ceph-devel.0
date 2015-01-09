From: Loic Dachary <loic@dachary.org>
Subject: Re: Testing the next giant release
Date: Fri, 09 Jan 2015 12:06:00 +0100
Message-ID: <54AFB618.7010007@dachary.org>
References: <54AD3C8B.4030705@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RPlXtrvb8u25liWepRraWIkCadGA9HiHO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35894 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756533AbbAILGD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jan 2015 06:06:03 -0500
In-Reply-To: <54AD3C8B.4030705@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tamil Muthamizhan <tamil.muthamizhan@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RPlXtrvb8u25liWepRraWIkCadGA9HiHO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

The rgw suite was scheduled (same as rbd only changed to rgw):

=2E/virtualenv/bin/teuthology-suite --teuthology-branch giant --suite rgw=
 --suite-branch giant --machine-type vps --distro ubuntu --email loic@dac=
hary.org --owner loic@dachary.org  --ceph giant-backports

it is at

http://pulpito.ceph.com/loic-2015-01-09_11:38:03-rgw-giant-backports-test=
ing-basic-vps/

Cheers

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


--RPlXtrvb8u25liWepRraWIkCadGA9HiHO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSvthgACgkQ8dLMyEl6F203sACggtoe5WsPzsTcA/VWr6e+rDDR
HiYAnjmPLYD/L0zgtGggumCEEK/pkDcj
=VBSX
-----END PGP SIGNATURE-----

--RPlXtrvb8u25liWepRraWIkCadGA9HiHO--
