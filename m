From: Loic Dachary <loic@dachary.org>
Subject: Re: make check bot paused
Date: Sat, 06 Jun 2015 01:32:10 +0200
Message-ID: <5572317A.1000302@dachary.org>
References: <556E40C9.90900@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="p61lARdl0OhVmB8F3Bm6s73JNSD3FdQK0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57178 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751909AbbFEXcQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jun 2015 19:32:16 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id B8A9E42B2C
	for <ceph-devel@vger.kernel.org>; Sat,  6 Jun 2015 01:32:10 +0200 (CEST)
In-Reply-To: <556E40C9.90900@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p61lARdl0OhVmB8F3Bm6s73JNSD3FdQK0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The make check bot is back.

Cheers

On 03/06/2015 01:48, Loic Dachary wrote:
> Hi,
>=20
> The bot that reports unit tests and functional tests results from run-m=
ake-check.sh[1] on pull requests[2] will be paused tomorrow and resume in=
 a few days. The same verification can be done from sources by running th=
e script with:
>=20
>    git clone http://github.com/ceph/ceph
>    cd ceph
>    bash run-make-check.sh
>=20
> Feel free to ping me if you experience problems. The most common cause =
of trouble is low ulimits[3] which can lead to mysterious errors and proc=
ess left overs. The minimum configuration is:
>=20
>   4 cores
>   16GB RAM
>   30GB disk
>=20
> Cheers
>=20
> [1] run-make-check.sh http://workbench.dachary.org/ceph/ceph/blob/maste=
r/run-make-check.sh
> [2] see https://github.com/ceph/ceph/pull/4833#issuecomment-108114267 f=
or instance
> [3] ulimit verifications before make check http://workbench.dachary.org=
/ceph/ceph/blob/master/Makefile.am#L44
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--p61lARdl0OhVmB8F3Bm6s73JNSD3FdQK0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVyMXoACgkQ8dLMyEl6F20StwCgouhG0/mZj0O0daHYSSXgW1Ty
Hk8An2F3Lxp8QxW7vFAF6+52OGyiO4bo
=orIR
-----END PGP SIGNATURE-----

--p61lARdl0OhVmB8F3Bm6s73JNSD3FdQK0--
