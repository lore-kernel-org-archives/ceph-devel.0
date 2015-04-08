From: Loic Dachary <loic@dachary.org>
Subject: Re: Call for jenkins slaves to improve multi operating system support
Date: Wed, 08 Apr 2015 15:32:30 +0200
Message-ID: <55252DEE.105@dachary.org>
References: <55250954.1010305@dachary.org> <A9F57F2ABA6BB2469F01E127557C6C9B112CC572@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HwaPiB5j2FvO8xbM6WqAe0hjw6fK0qSOT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43414 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753535AbbDHNcf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 09:32:35 -0400
In-Reply-To: <A9F57F2ABA6BB2469F01E127557C6C9B112CC572@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Duan, Jiangang" <jiangang.duan@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HwaPiB5j2FvO8xbM6WqAe0hjw6fK0qSOT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/04/2015 15:21, Duan, Jiangang wrote:
> Loric,
>=20
> do you mean we need give the servers to you or we just build the testin=
g inside our own server room to do all the testing?

Thanks for asking, I realize that was not clear.=20

The idea is not to donate hardware, because that would require manpower a=
nd extra costs to connect to the net.=20

What would be useful is a machine connected to the net and dedicated to r=
unning a jenkins slave. It receives a build from the jenkins master (http=
://jenkins.ceph.dachary.org/) via ssh (possibly with a tunnel if behind a=
 NAT), clone http://github.com/ceph/ceph, execute the run-make-check.sh s=
cript that is found at the root of the repository and reports failure / s=
uccess back to the jenkins master.

Does that make sense ?

>=20
> -jiangang
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ke=
rnel.org] On Behalf Of Loic Dachary
> Sent: Wednesday, April 08, 2015 6:56 PM
> To: Ceph Development
> Subject: Call for jenkins slaves to improve multi operating system supp=
ort
>=20
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
> [4] gitbuilder http://ceph.com/gitbuilder.cgi [5] https://ceph.com/git/=
?p=3Dceph.git;a=3Dblob;f=3Dsrc/test/Makefile.am;hb=3Dhammer#l91
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--HwaPiB5j2FvO8xbM6WqAe0hjw6fK0qSOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUlLe4ACgkQ8dLMyEl6F231VgCfftGGW+mhmtDf6hAlQ7ls+6mz
euoAnjvJ/vSZ6ZaZQcHzDWWnrJpK+fuz
=TvJ2
-----END PGP SIGNATURE-----

--HwaPiB5j2FvO8xbM6WqAe0hjw6fK0qSOT--
