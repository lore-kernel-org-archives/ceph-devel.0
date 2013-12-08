From: Loic Dachary <loic@dachary.org>
Subject: Re: Forced push to master
Date: Mon, 09 Dec 2013 00:12:02 +0100
Message-ID: <52A4FCC2.20902@dachary.org>
References: <52A4F9F7.8010007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cQVfkATGM3Bo6ij9quUN33auROS3EGQt2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34253 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510Ab3LHXME (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Dec 2013 18:12:04 -0500
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id CE7A526394
	for <ceph-devel@vger.kernel.org>; Mon,  9 Dec 2013 00:12:02 +0100 (CET)
In-Reply-To: <52A4F9F7.8010007@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cQVfkATGM3Bo6ij9quUN33auROS3EGQt2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 09/12/2013 00:00, Loic Dachary wrote:
> Hi,
>=20
> I accidentally forced push to ceph master at 11pm CEST 8 december 2013 =
the following:
>=20
> https://github.com/ceph/ceph/commit/17e0a7b2942899e3f4307bf3e9c41bcb430=
4619d
> https://github.com/ceph/ceph/commit/d5e44cf8b233e517d8f7f26cd556ad0ac15=
714c1
> https://github.com/ceph/ceph/commit/71f820503a96cafa9e99cca047c3183c375=
408a8
> https://github.com/ceph/ceph/commit/eefeb0e0ad54fe0179cbf71335a45ea17c0=
fa23b
> https://github.com/ceph/ceph/commit/8253ff1e0b3b3a1680293c75f015a5cf5f5=
e34c6
>=20
> and may have discarded commits done after:
>=20
> https://github.com/ceph/ceph/commit/94da2153d1e131205c0e5e32601d0b6a9f6=
a3cfd
>=20
> which is a merge dated
>=20
> Date:   Sat Dec 7 20:59:22 2013 -0800
>=20
> I apologize for the inconvenience and trying to figure out more.

http://gitbuilder.sepia.ceph.com/gitbuilder-quantal-amd64/#origin/master

shows:

BUILDING 	17e0a7b 	loic 	build log osd/OSDMap: add feature bit for TUNABL=
ES3 (=3D=3D CRUSH_V2)
	(Pending) 	d5e44cf 	loic 	mon/OSDMonitor: allow setting 'firefly' tunabl=
es
	...3... 	=09
Warn 	94da215 	sage 	Warnings(1) Merge pull request #869 from ceph/wip-cr=
ush=20

since gitbuilder reacts to every commit to master and that it did not pic=
k anything between 94da215 and the forced push, it is somewhat reassuring=
 that no commit were lost. But I'm trying to find a way to be sure.

>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--cQVfkATGM3Bo6ij9quUN33auROS3EGQt2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKk/MIACgkQ8dLMyEl6F20idwCgsp0TTtJphTFfnl/sXnLdPUWy
ge4AoJR1dM0DUNiGbspoep6+/0xsT5xa
=4R0C
-----END PGP SIGNATURE-----

--cQVfkATGM3Bo6ij9quUN33auROS3EGQt2--
