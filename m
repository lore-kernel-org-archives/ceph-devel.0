From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure/gf-complete segmentation violation
Date: Sun, 06 Apr 2014 12:12:43 +0200
Message-ID: <5341289B.4080701@dachary.org>
References: <533C4A67.3070906@dachary.org>	<CA+AFVBg00yTzu-VGxSURDxv_UWOmZJEF+077txButeoSkoQuBg@mail.gmail.com>	<533C4F40.8020207@dachary.org>	<alpine.DEB.2.00.1404021101250.2734@cobra.newdream.net> <CA+AFVBgVXsTLJuGh-FrJMx3ee11Ztf=g+B9gnHybg9EXwunfnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rs2QJpCgafSGOMjd0wHRqTF0TH6wj4Qr9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:37545 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbaDFKM5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Apr 2014 06:12:57 -0400
In-Reply-To: <CA+AFVBgVXsTLJuGh-FrJMx3ee11Ztf=g+B9gnHybg9EXwunfnw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rs2QJpCgafSGOMjd0wHRqTF0TH6wj4Qr9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

An illegal instruction this time http://tracker.ceph.com/issues/7914#note=
-31 . Since the workload is slightly different, I'm trying to run it 30 t=
imes and see if that triggers the problem.=20

Cheers

On 02/04/2014 20:15, Kevin Greenan wrote:
> OK, it looks like this happens when the GF backend is first initialized=
 (unless, like Loic pointed out, something is corrupted).
>=20
> Is this consistently happening for carry-free multiply and w=3D32 (i.e.=
 gf_w32_cfm_init)?
>=20
> Can you send me a core + binary, so I can dig in gdb?
>=20
> -kevin
>=20
>=20
> On Wed, Apr 2, 2014 at 11:01 AM, Sage Weil <sage@inktank.com <mailto:sa=
ge@inktank.com>> wrote:
>=20
>     On Wed, 2 Apr 2014, Loic Dachary wrote:
>     >
>     >
>     > On 02/04/2014 19:44, Kevin Greenan wrote:
>     > > Hey Loic,
>     > >
>     > > Are you ensuring that Jerasure (actually gf-complete) is gettin=
g memory buffers aligned on 16-byte boundaries?  Without looking too deep=
, that is the first thing I would check.
>     > >
>     >
>     > Yes
>     >
>     > https://github.com/ceph/ceph/blob/master/src/erasure-code/jerasur=
e/ErasureCodeJerasure.cc#L32
>     > https://github.com/ceph/ceph/blob/master/src/erasure-code/jerasur=
e/ErasureCodeJerasure.cc#L242
>     > https://github.com/ceph/ceph/blob/master/src/erasure-code/jerasur=
e/ErasureCodeJerasure.cc#L65
>     > https://github.com/ceph/ceph/blob/master/src/erasure-code/jerasur=
e/ErasureCodeJerasure.cc#L108
>     >
>=20
>     In this case they are 2K aligned:
>=20
>     (gdb) p data_ptrs[0]
>     $1 =3D 0x3e46000 "I'm the", ' ' <repeats 16 times>, "3th object!"
>     (gdb) p data_ptrs[1]
>     $2 =3D 0x3e46800 'z' <repeats 200 times>...
>     (gdb) p coding_ptrs[0]
>     $3 =3D 0x338e000 "I'm the", ' ' <repeats 16 times>, "3th object!"
>=20
>     sage
>=20
>     > I'll re-read this logic tomorrow just to be sure.
>     >
>     > Cheers
>     >
>     > > I can have a deeper look later today or tomorrow.
>     > >
>     > > -kevin
>     > >
>     > >
>     > > On Wed, Apr 2, 2014 at 10:35 AM, Loic Dachary <loic@dachary.org=
 <mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachary.=
org>>> wrote:
>     > >
>     > >     Hi Kevin,
>     > >
>     > >     In the context of http://tracker.ceph.com/issues/7914 we're=
 trying to figure out why jerasure dumps core. We don't know how to repro=
duce it yet (ran dozens of identical tests suites with no such crash in t=
he past few days, which is to be expected for rare bugs because the test =
suite introduces random errors / failures on purpose).
>     > >
>     > >     The full stack trace is at http://tracker.ceph.com/issues/7=
914#note-24 but the relevant part is here:
>     > >
>     > >     #0  0x00007f4756779b7b in raise (sig=3D<optimized out>) at =
=2E./nptl/sysdeps/unix/sysv/linux/pt-raise.c:42
>     > >     #1  0x0000000000981b4e in reraise_fatal (signum=3D11) at gl=
obal/signal_handler.cc:59
>     > >     #2  handle_fatal_signal (signum=3D11) at global/signal_hand=
ler.cc:105
>     > >     #3  <signal handler called>
>     > >     #4  0x0000000000000000 in ?? ()
>     > >     #5  0x00007f47385ae6b1 in jerasure_matrix_dotprod (k=3D2, w=
=3D8, matrix_row=3D0x31513a8, src_ids=3D0x0, dest_id=3D<optimized out>, d=
ata_ptrs=3D0x7f4741ec7a00, coding_ptrs=3D0x7f4741ec7a10,
>     > >         size=3D2048) at erasure-code/jerasure/jerasure/src/jera=
sure.c:607
>     > >     #6  0x00007f47385ae7d6 in jerasure_matrix_encode (k=3D2, m=3D=
1, w=3D8, matrix=3D<optimized out>, data_ptrs=3D0x7f4741ec7a00, coding_pt=
rs=3D0x7f4741ec7a10, size=3D2048)
>     > >         at erasure-code/jerasure/jerasure/src/jerasure.c:310
>     > >     ...
>     > >
>     > >     Note that this jerasure/gf-complete combination has been co=
mpiled with SSE4.1, SSE4.2, PCLMUL, SSSE3, SSE3, SSE2, SSE flags activate=
d. These are jerasure v2 and gf-complete v1, only slightly modified as fo=
und in https://github.com/ceph/jerasure/tree/v2-ceph and https://github.c=
om/ceph/gf-complete/tree/v1-ceph (all commits there have a pending pull r=
equest under https://bitbucket.org/jimplank/gf-complete https://bitbucket=
=2Eorg/jimplank/jerasure, nothing you've not seen before).
>     > >
>     > >     #5 is https://github.com/ceph/jerasure/blob/v2-ceph/src/jer=
asure.c#L607
>     > >
>     > >     and then it dives into gf-complete and most probably destro=
yed part of the stack when corrupting memory. I'll be chasing this tomorr=
ow. If you have a brilliant idea on why that happens, I'll take it ;-)
>     > >
>     > >     Cheers
>     > >
>     > >     --
>     > >     Lo=EFc Dachary, Artisan Logiciel Libre
>     > >
>     > >
>     >
>     > --
>     > Lo=EFc Dachary, Artisan Logiciel Libre
>     >
>     >=20
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--rs2QJpCgafSGOMjd0wHRqTF0TH6wj4Qr9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNBKKQACgkQ8dLMyEl6F21VrQCgq2ihVPPYlqkfxa8wEZJmqRhD
J+0An0pF61KdAnJhNKPSKtF9mVQERu/u
=I9X8
-----END PGP SIGNATURE-----

--rs2QJpCgafSGOMjd0wHRqTF0TH6wj4Qr9--
