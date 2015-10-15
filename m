From: Loic Dachary <loic@dachary.org>
Subject: Re: make check bot delays
Date: Thu, 15 Oct 2015 11:08:47 +0200
Message-ID: <561F6D1F.30603@dachary.org>
References: <561ED1D6.7060905@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SvXRJ2UO7lBwLn8KJbdaWvnuMpU8cl74M"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43693 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751050AbbJOJIt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 05:08:49 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id F0C3942B5A
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2015 11:08:47 +0200 (CEST)
In-Reply-To: <561ED1D6.7060905@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SvXRJ2UO7lBwLn8KJbdaWvnuMpU8cl74M
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

TL;DR: the make check bot is fixed (no more delays) but only keeps the la=
st 30 runs

It looks like the cause of the jenkins delays was the number of run kept =
in the archives (set to 300). Lowering it down to 30 have jenkins back to=
 running with no delay between jobs (as opposed to using 100% of one core=
 during 10 minutes between two jobs, apparently to do things on the archi=
ved runs).

What I can't really explain is that it also kept 300 jobs two month ago a=
nd that was no issue. What changed in between... I have no clue.

The bot is catching up.

Cheers

On 15/10/2015 00:06, Loic Dachary wrote:
> Hi,
>=20
> TL;DR: the jenkins instance running make check bot hangs daily, looking=
 for a solution
>=20
> In the past two weeks the make check bot has experienced troubles for w=
hich I've been unable to find a cause. The same jenkins instance running =
it for the past nine month now freezes at random times. Nothing in the lo=
gs, no error message: either the page or the slave are just doing nothing=
 no matter what. The only reliable solution seems to be a restart of jenk=
ins (killing the process since even restart blocks).=20
>=20
> Maybe it's time for the make check bot to run via teuthology instead of=
 jenkins.
>=20
> Thanks for your patience
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--SvXRJ2UO7lBwLn8KJbdaWvnuMpU8cl74M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYfbR8ACgkQ8dLMyEl6F21A+wCfWwePcTgEysf65eSW46P7G0kR
/PoAnA5WZhllRQh7vtjYShCAitclVW8W
=K1qj
-----END PGP SIGNATURE-----

--SvXRJ2UO7lBwLn8KJbdaWvnuMpU8cl74M--
