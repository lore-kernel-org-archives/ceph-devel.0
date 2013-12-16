From: Loic Dachary <loic@dachary.org>
Subject: Re: Intel Erasure Code library
Date: Mon, 16 Dec 2013 14:15:41 +0100
Message-ID: <52AEFCFD.9030308@dachary.org>
References: <52AECE62.9030102@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE6ABD29@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4vhPLaHfdlEDDBtS7edJCU4U0KasxVNCC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41592 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702Ab3LPNPo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 08:15:44 -0500
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE6ABD29@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4vhPLaHfdlEDDBtS7edJCU4U0KasxVNCC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 16/12/2013 14:10, Andreas Joachim Peters wrote:
> Hi Loic,=20
> this looks excellent on new INTEL hardware .... certainly ;-)

:-) For sure.

> I was just running some benchmarks on different platforms. It should be=
 extremely simple to make a plugin ... the API is simple ...
>=20
> I configured (10+4):

I'd like to try the same command you did. Could you include the command y=
ou ran ? And if you have modified the source the corresponding patch ?=20


>=20
> 1)
> model name	: Intel(R) Xeon(R) CPU E5-2650 0 @ 2.00GHz
> stepping	: 7
> cpu MHz		: 2001.000
> cache size	: 20480 KB
>=20
> (cold cache)
> erasure_code_encode_cold: runtime =3D     684410 usecs, bandwidth 3199 =
MB in 0.6844 sec =3D 4902.61 MB/s
> erasure_code_decode_cold: runtime =3D     340002 usecs, bandwidth 2239 =
MB in 0.3400 sec =3D 6908.12 MB/s (recover 3)
> erasure_code_decode_cold: runtime =3D     176811 usecs, bandwidth 1599 =
MB in 0.1768 sec =3D 9488.64 MB/s (recover 1)
>=20
> (warm cache)
> erasure_code_encode_warm: runtime =3D    1744615 usecs, bandwidth 9985 =
MB in 1.7446 sec =3D 6001.55 MB/s
> erasure_code_decode_warm: runtime =3D     860179 usecs, bandwidth 6989 =
MB in 0.8602 sec =3D 8520.65 MB/s (recover 3)
>=20
>=20
> 2)
> model name      : AMD Opteron(TM) Processor 6276                =20
> stepping        : 2
> cpu MHz         : 2300.000
> cache size      : 2048 KB
>=20
> (cold cache)
> erasure_code_encode_cold: runtime =3D    1769806 usecs, bandwidth 3199 =
MB in 1.7698 sec =3D 1895.91 MB/s
> erasure_code_decode_cold: runtime =3D    1135461 usecs, bandwidth 2239 =
MB in 1.1355 sec =3D 2068.56 MB/s (recover 3)
> erasure_code_decode_cold: runtime =3D     553315 usecs, bandwidth 1599 =
MB in 0.5533 sec =3D 3032.08 MB/s (recover 1)
>=20
> (warm cache)
> erasure_code_encode_warm: runtime =3D    2158180 usecs, bandwidth 9985 =
MB in 2.1582 sec =3D 4851.50 MB/s
> erasure_code_decode_warm: runtime =3D    1133059 usecs, bandwidth 6989 =
MB in 1.1331 sec =3D 6468.58 MB/s (recover 3)
>=20
>=20
> 3) [running in a virtual machine!!!]
>=20
> model name	: Intel Core i7 9xx (Nehalem Class Core i7)
> stepping	: 3
> cpu MHz		: 2266.746
> cache size	: 4096 KB
>=20
> (cold cache)
> erasure_code_encode_cold: runtime =3D    1125543 usecs, bandwidth 3199 =
MB in 1.1255 sec =3D 2981.13 MB/s
> erasure_code_decode_cold: runtime =3D     554727 usecs, bandwidth 2239 =
MB in 0.5547 sec =3D 4234.11 MB/s (recover 3)
> erasure_code_decode_cold: runtime =3D     324933 usecs, bandwidth 1599 =
MB in 0.3249 sec =3D 5163.21 MB/s (recover 1)
>=20
> (warm cache)
> erasure_code_encode_warm: runtime =3D    2636439 usecs, bandwidth 9985 =
MB in 2.6364 sec =3D 3971.42 MB/s
> erasure_code_decode_warm: runtime =3D    1263597 usecs, bandwidth 6989 =
MB in 1.2636 sec =3D 5800.33 MB/s (recover 3)
>=20
> 4)
> model name      : Intel(R) Xeon(R) CPU           L5520  @ 2.27GHz
> stepping        : 5
> cpu MHz         : 1600.000
> cache size      : 8192 KB
>=20
> (cold cache)
> erasure_code_encode_cold: runtime =3D    1166904 usecs, bandwidth 3199 =
MB in 1.1669 sec =3D 2875.47 MB/s
> erasure_code_decode_cold: runtime =3D     345337 usecs, bandwidth 1599 =
MB in 0.3453 sec =3D 4858.14 MB/s (recover 1)
> erasure_code_decode_cold: runtime =3D     575194 usecs, bandwidth 2239 =
MB in 0.5752 sec =3D 4083.45 MB/s (recover 3)
>=20
> (warm cache)
> erasure_code_encode_warm: runtime =3D    2686134 usecs, bandwidth 9985 =
MB in 2.6861 sec =3D 3897.94 MB/s
> erasure_code_decode_warm: runtime =3D     777904 usecs, bandwidth 4992 =
MB in 0.7779 sec =3D 6729.88 MB/s (recover 1)
> erasure_code_decode_warm: runtime =3D    1278117 usecs, bandwidth 6989 =
MB in 1.2781 sec =3D 5734.44 MB/s (recover 3)
>=20
> 5)
> model name	: Intel(R) Xeon(R) CPU           L5520  @ 2.27GHz
> stepping	: 5
> cpu MHz		: 1600.000
> cache size	: 8192 KB
>=20
> (cold cache)
> erasure_code_encode_cold: runtime =3D     956274 usecs, bandwidth 3199 =
MB in 0.9563 sec =3D 3508.82 MB/s
> erasure_code_decode_cold: runtime =3D     264835 usecs, bandwidth 1599 =
MB in 0.2648 sec =3D 6334.87 MB/s (recover 1)
> erasure_code_decode_cold: runtime =3D     463120 usecs, bandwidth 2239 =
MB in 0.4631 sec =3D 5071.63 MB/s (recover 3)
>=20
>=20
> (warm cache)
> erasure_code_encode_warm: runtime =3D    2601232 usecs, bandwidth 9985 =
MB in 2.6012 sec =3D 4025.17 MB/s
> erasure_code_decode_warm: runtime =3D     683921 usecs, bandwidth 4992 =
MB in 0.6839 sec =3D 7654.69 MB/s (recover 1)
> erasure_code_decode_warm: runtime =3D    1258408 usecs, bandwidth 6989 =
MB in 1.2584 sec =3D 5824.25 MB/s (recover 3)
>=20
> ___________________________________
> From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.or=
g] on behalf of Loic Dachary [loic@dachary.org]
> Sent: 16 December 2013 10:56
> To: Ceph Development
> Subject: Intel Erasure Code library
>=20
> Hi,
>=20
> A new Erasure Code library has been released as Free Software
>=20
> https://01.org/storage-acceleration-library/downloads/2013/isa-l-open-s=
ource-release
>=20
> It is quite tempting to write a Ceph erasure code plugin for it and see=
 how it performs :-)
>=20
> Cheers
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--4vhPLaHfdlEDDBtS7edJCU4U0KasxVNCC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKu/P4ACgkQ8dLMyEl6F233ywCgjf/vgzy+yeQMUJI88dmBXTX+
DkAAnjFkbj+COHPtVCwawctEsyKJexJI
=fP7z
-----END PGP SIGNATURE-----

--4vhPLaHfdlEDDBtS7edJCU4U0KasxVNCC--
