From: Loic Dachary <loic@dachary.org>
Subject: Re: Call for jenkins slaves to improve multi operating system support
Date: Sat, 18 Apr 2015 23:13:39 +0200
Message-ID: <5532C903.1090508@dachary.org>
References: <55250954.1010305@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="72EAlHKrdrX0tFRgUKcL1KGrGQVegG0w5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48813 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750909AbbDRVNu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Apr 2015 17:13:50 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id ED75742093
	for <ceph-devel@vger.kernel.org>; Sat, 18 Apr 2015 23:13:39 +0200 (CEST)
In-Reply-To: <55250954.1010305@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--72EAlHKrdrX0tFRgUKcL1KGrGQVegG0w5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks to people who proposed to host jenkins slave: two new slaves shoul=
d be added next week :-) The conversations we had have been summarized in=
 a short document that will hopefully clarify how the slaves are put to w=
ork:

http://ceph-workbench.readthedocs.org/en/latest/user/jenkins.html

Cheers

On 08/04/2015 12:56, Loic Dachary wrote:
> Hi Ceph,
>=20
> When a contribution is proposed to Ceph [1], a bot compiles and run tes=
ts with it to provide feedback to the developer [2]. When something goes =
wrong the failure can be repeated on the developer machine [3] for debug.=
 This also helps the reviewer who knows the code compiles and does not br=
eak anything that would be detected by "make check".
>=20
> The bot runs on CentOS 7 and Ubuntu 14.04 only, and problems related to=
 older operating systems (headers, compiler version, etc.) may be detecte=
d later, when building packages [4] and after the pull request has been m=
erged in master. This is rare but requires extra attention from the revie=
wer and needs to be dealt with urgently when it happens.
>=20
> If you can spare a machine to help expand the operating systems on whic=
h tests can run, it would be a great help. The minimum hardware configura=
tion to run a slave is:
>=20
> *  x86_64 architecture for CentOS 6, Fedora 21, OpenSUSE 13.2, Debian G=
NU/Linux Jessie, Ubuntu 14.02
>=20
>   32 GB RAM
>   200 GB SSD
>   8 core > 2.5Ghz
>=20
> *  i386 architecture for CentOS 7, CentOS 6, Fedora 21, Debian GNU/Linu=
x Jessie, Ubuntu 14.04, Ubuntu 14.02
>=20
>   4 GB RAM
>   200 GB disk
>   2 core
>=20
> *  armv7, armv8 architecture for Ubuntu 14.04
>=20
>   4 GB RAM
>   200 GB disk
>   2 core=20
>=20
> Note that since the make check bot can run in a docker container, x86_6=
4 machines can be used to run any of the operating systems for which a do=
cker file has been prepared [5].
>=20
> Cheers
>=20
> [1] pull requests https://github.com/ceph/ceph/pulls
> [2] make check bot feedback https://github.com/ceph/ceph/pull/4296#issu=
ecomment-90812064
> [3] run-make-check.sh https://github.com/ceph/ceph/blob/master/run-make=
-check.sh#L44
> [4] gitbuilder http://ceph.com/gitbuilder.cgi
> [5] https://ceph.com/git/?p=3Dceph.git;a=3Dblob;f=3Dsrc/test/Makefile.a=
m;hb=3Dhammer#l91
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--72EAlHKrdrX0tFRgUKcL1KGrGQVegG0w5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUyyQMACgkQ8dLMyEl6F23gVQCggnLWkagn3JAuNQZRFhdDH/sa
Se4AnAh2mjW58OgjbgC98gwy78j/P4Xs
=opmW
-----END PGP SIGNATURE-----

--72EAlHKrdrX0tFRgUKcL1KGrGQVegG0w5--
