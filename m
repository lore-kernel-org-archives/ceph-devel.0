From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure/gf-complete segmentation violation
Date: Wed, 02 Apr 2014 19:56:16 +0200
Message-ID: <533C4F40.8020207@dachary.org>
References: <533C4A67.3070906@dachary.org> <CA+AFVBg00yTzu-VGxSURDxv_UWOmZJEF+077txButeoSkoQuBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6iois3NVU2vDQAP0QnCBWk23sxl2wXhgD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34313 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932775AbaDBR4X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Apr 2014 13:56:23 -0400
In-Reply-To: <CA+AFVBg00yTzu-VGxSURDxv_UWOmZJEF+077txButeoSkoQuBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6iois3NVU2vDQAP0QnCBWk23sxl2wXhgD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 02/04/2014 19:44, Kevin Greenan wrote:
> Hey Loic,
>=20
> Are you ensuring that Jerasure (actually gf-complete) is getting memory=
 buffers aligned on 16-byte boundaries?  Without looking too deep, that i=
s the first thing I would check.
>=20

Yes

https://github.com/ceph/ceph/blob/master/src/erasure-code/jerasure/Erasur=
eCodeJerasure.cc#L32
https://github.com/ceph/ceph/blob/master/src/erasure-code/jerasure/Erasur=
eCodeJerasure.cc#L242
https://github.com/ceph/ceph/blob/master/src/erasure-code/jerasure/Erasur=
eCodeJerasure.cc#L65
https://github.com/ceph/ceph/blob/master/src/erasure-code/jerasure/Erasur=
eCodeJerasure.cc#L108

I'll re-read this logic tomorrow just to be sure.

Cheers

> I can have a deeper look later today or tomorrow.
>=20
> -kevin
>=20
>=20
> On Wed, Apr 2, 2014 at 10:35 AM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     Hi Kevin,
>=20
>     In the context of http://tracker.ceph.com/issues/7914 we're trying =
to figure out why jerasure dumps core. We don't know how to reproduce it =
yet (ran dozens of identical tests suites with no such crash in the past =
few days, which is to be expected for rare bugs because the test suite in=
troduces random errors / failures on purpose).
>=20
>     The full stack trace is at http://tracker.ceph.com/issues/7914#note=
-24 but the relevant part is here:
>=20
>     #0  0x00007f4756779b7b in raise (sig=3D<optimized out>) at ../nptl/=
sysdeps/unix/sysv/linux/pt-raise.c:42
>     #1  0x0000000000981b4e in reraise_fatal (signum=3D11) at global/sig=
nal_handler.cc:59
>     #2  handle_fatal_signal (signum=3D11) at global/signal_handler.cc:1=
05
>     #3  <signal handler called>
>     #4  0x0000000000000000 in ?? ()
>     #5  0x00007f47385ae6b1 in jerasure_matrix_dotprod (k=3D2, w=3D8, ma=
trix_row=3D0x31513a8, src_ids=3D0x0, dest_id=3D<optimized out>, data_ptrs=
=3D0x7f4741ec7a00, coding_ptrs=3D0x7f4741ec7a10,
>         size=3D2048) at erasure-code/jerasure/jerasure/src/jerasure.c:6=
07
>     #6  0x00007f47385ae7d6 in jerasure_matrix_encode (k=3D2, m=3D1, w=3D=
8, matrix=3D<optimized out>, data_ptrs=3D0x7f4741ec7a00, coding_ptrs=3D0x=
7f4741ec7a10, size=3D2048)
>         at erasure-code/jerasure/jerasure/src/jerasure.c:310
>     ...
>=20
>     Note that this jerasure/gf-complete combination has been compiled w=
ith SSE4.1, SSE4.2, PCLMUL, SSSE3, SSE3, SSE2, SSE flags activated. These=
 are jerasure v2 and gf-complete v1, only slightly modified as found in h=
ttps://github.com/ceph/jerasure/tree/v2-ceph and https://github.com/ceph/=
gf-complete/tree/v1-ceph (all commits there have a pending pull request u=
nder https://bitbucket.org/jimplank/gf-complete https://bitbucket.org/jim=
plank/jerasure, nothing you've not seen before).
>=20
>     #5 is https://github.com/ceph/jerasure/blob/v2-ceph/src/jerasure.c#=
L607
>=20
>     and then it dives into gf-complete and most probably destroyed part=
 of the stack when corrupting memory. I'll be chasing this tomorrow. If y=
ou have a brilliant idea on why that happens, I'll take it ;-)
>=20
>     Cheers
>=20
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--6iois3NVU2vDQAP0QnCBWk23sxl2wXhgD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM8T0IACgkQ8dLMyEl6F22mCACghHe+zJY6Yh6C2QcFOyb87mVf
CVQAoLhtc6TKP05ayFKQexL6LND8o0rq
=W/Ks
-----END PGP SIGNATURE-----

--6iois3NVU2vDQAP0QnCBWk23sxl2wXhgD--
