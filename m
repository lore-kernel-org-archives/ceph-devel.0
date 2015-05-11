From: Loic Dachary <loic@dachary.org>
Subject: Re: autodetecting init system.
Date: Mon, 11 May 2015 23:45:19 +0200
Message-ID: <555122EF.4090105@dachary.org>
References: <5550D903.8000802@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xQeDEJLe3JKEW5Ba1ptrrseMbrTgN1a1m"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33234 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752115AbbEKVpW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 17:45:22 -0400
In-Reply-To: <5550D903.8000802@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xQeDEJLe3JKEW5Ba1ptrrseMbrTgN1a1m
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Owen,

It would help to provide one or two use cases where (C) solves a problem =
that (B) (that is the current ceph-detect-init approach) does not solve. =
I sense there is something better in (C) but I can't think of a use case =
just now (maybe because I've been thinking about erasure code all day :-)=
=2E=20

Cheers

On 11/05/2015 18:29, Owen Synge wrote:
> Dear all,
>=20
> Many init systems are used in linux now. Some ceph code needs to know
> the init system. (I must admit I have not looked into Solaris, MacOS an=
d
> BSD and probably should have)
>=20
> It would be nice to have one function that detects the init system
>=20
> Since the init system can be specified in ceph and ceph-deploy
> explicitly it seems to be its reasonable to fail clearly to detect init=

> system.
>=20
> I see 4 ways I can see to detect init system.
>=20
> (A) Check pid 1.
> (B) Use a database of OS to init mapping / compile time.
> (C) look for init manipulation tools and infure the init system from to=
ols.
>=20
> Comments:
> ~~~~~~~~
>=20
> (A1) systmd can be detected easily with.
>=20
>  grep -qs systemd /proc/1/comm
>=20
> (A2) With init scripts such as its hard to know what the init system.
>=20
> (B1) For operating systems like RHEL, SLE, CENTOS, Fedora and scientifi=
c
> linux this works well.
>=20
> (B2) FOr operating systems like newer debian and ubuntu releases more
> than one init system can be installed and used on the OS, so making a
> database / doing it at compile time are not practical on all OS's
>=20
> (C1) This is fairly reliable.
>=20
> (C2) sysV tools have compatibility scripts / programs on other platform=
s
> so if you use a points system for each init system helper script you ca=
n
> infure systemd over sysV if sytemctrl exists for example.
>=20
> So to summarise this:
> ~~~~~~~~~~~~~~~~~~~~
>=20
> (1) No one system is perfect in all cases.
> (2) Combined these systesm can provide reliable init system detection.
>=20
> My proposed approach.
> ~~~~~~~~~~~~~~~~~~~~
>=20
> (I) Use all three approaches where each approach can provide and answer=
,
> or fail to provide an answer.
>=20
> (II) Should any approaches disagree -> fail to detect init system.
>=20
> (III) Should all approaches agree -> then return init system.
>=20
> (III) Should no approaches provide an init system -> fail to return ini=
t
> system.
>=20
> Comments
> ~~~~~~~~
>=20
> This multi layered and comparing way of doing init systems may seem
> complete overkill, or maybe its useful.
>=20
> What do you guys think?
>=20
> Best regards
>=20
> Owen
>=20
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--xQeDEJLe3JKEW5Ba1ptrrseMbrTgN1a1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVRIu8ACgkQ8dLMyEl6F21IwwCeNMIIUe+mH1QX0eqfgzXWGC35
JVAAnAngabPd/KtHWSoQ4H0TMhn2t1Xp
=nWOs
-----END PGP SIGNATURE-----

--xQeDEJLe3JKEW5Ba1ptrrseMbrTgN1a1m--
