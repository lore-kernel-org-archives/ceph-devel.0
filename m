From: Loic Dachary <loic@dachary.org>
Subject: Re: rados_dll: A Windows port of librados
Date: Thu, 19 Mar 2015 08:41:25 +0100
Message-ID: <550A7DA5.9010802@dachary.org>
References: <CAHJ4zomaFxzJMBo+v50DUX=bycyagzWOfckoXPFcm1THFK8DQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="moe69AhqQWond7kHUwnE0Vgi884d6XvLq"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60744 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750837AbbCSHl1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 03:41:27 -0400
In-Reply-To: <CAHJ4zomaFxzJMBo+v50DUX=bycyagzWOfckoXPFcm1THFK8DQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alistair Israel <aisrael@gmail.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--moe69AhqQWond7kHUwnE0Vgi884d6XvLq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 19/03/2015 06:35, Alistair Israel wrote:
> Hi, ceph.
>=20
> We are pleased to announce our first milestone in bringing Ceph to the
> Windows platform, by porting librados into rados.dll.
>=20
> https://github.com/AcalephStorage/rados_dll
>=20
> Many thanks to dketor@gmail.com and the ceph-dokan project for
> providing the springboard and early consultation with which we were
> able to embark upon this course (we've also forked ceph-dokan and are
> looking to be active contributors to that project).
>=20
> ### Overview
>=20
>   * rados_dll is built using mingw, like ceph-dokan
>   * Currently, it builds rados.dll, used by rados_client.exe
>   * rados.dll provides the librados C API (linking C++ using .DLLs is
> problematic)
>   * rados_client.exe follows example code here
> (http://ceph.com/docs/master/rados/api/librados-intro/) to drive
> rados.dll, connect to a Ceph cluster and perform I/O
>   * LGLP v2.1
>=20
> ### Details
>=20
> Currently, rados_dll is built, similar to ceph-dokan, from source
> files copied over from ceph/src and with _WIN32 specific
> modifications. It is built using gcc, and uses winsock.
>=20
> ### Next steps
>=20
> We've had to disable cephx authentication for now, obviously we need
> to get this ported and working properly.
>=20
> Currently, the build environment has to be carefully prepared by hand.
> We're looking to add scripts to help ease and automate that process.
>=20
> We're looking to streamline merging of changes from 'upstream' ceph.
> First, we intend to remove unmodified source files from the src/
> directory and use upstream ceph/src directly.
>=20
> Next, we're looking to use tools (e.g. diff/patch, sed) to the apply
> _WIN32 specific modifications in an automated manner whenever possible
> to generate _WIN32 sources.
>=20
> We hope to gain enough traction and credibility to contribute _WIN32
> specific sections (with appropriate guards) to ceph core code.
> Eventually, hopefully, we might be able to build rados.dll (along with
> other Ceph components that can be ported to Windows) directly from a
> single set of source files.
>=20
> Finally, our Makefile is hand-written (as with ceph-dokan), and we
> welcome any help to be able to standardise on using the autotools
> toolchain to automate that as well (or integrate with upstream).

Wouldn't it be easier to use cygwin and build on either automake / autoto=
ols. Maybe CMake is a possible solution as well ? I confess that I've not=
 used cygwin in a long time ;-)

Cheers

>=20
> ### Roadmap
>=20
> We're looking at tackling RBD soon, and provide a native, Windows
> system-level block device backed by Ceph. ;)
>=20
> We welcome any and all comments, suggestions, and support.
>=20
> ### Who we are
>=20
> Acaleph is a small startup headquartered in Singapore, but operating mo=
stly from
> the Philippines, and we provide Ceph deployment, integration, support
> and other services.
>=20
> Julio Telan is a graduating student from De La Salle University
> spending his internship at Acaleph, mentored by yours truly.
>=20
> Cheers!
>=20
> Alistair A. Israel, alistair@acale.ph
> Julio Telan, julio_telan@dlsu.edu.ph
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--moe69AhqQWond7kHUwnE0Vgi884d6XvLq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUKfaUACgkQ8dLMyEl6F20seQCcDw8k75OEMSpfqCRgWCWD3bRt
LIkAn1taahMNPJDPgn57ECV5mNcc6PyO
=SqoJ
-----END PGP SIGNATURE-----

--moe69AhqQWond7kHUwnE0Vgi884d6XvLq--
