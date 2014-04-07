From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure/gf-complete segmentation violation
Date: Mon, 07 Apr 2014 20:29:39 +0200
Message-ID: <5342EE93.6050902@dachary.org>
References: <533C4A67.3070906@dachary.org>	<CA+AFVBg00yTzu-VGxSURDxv_UWOmZJEF+077txButeoSkoQuBg@mail.gmail.com>	<533C4F40.8020207@dachary.org>	<alpine.DEB.2.00.1404021101250.2734@cobra.newdream.net>	<CA+AFVBgVXsTLJuGh-FrJMx3ee11Ztf=g+B9gnHybg9EXwunfnw@mail.gmail.com>	<5341289B.4080701@dachary.org>	<D590780E-5F28-4ADA-B9F5-E2E14C9C0D27@gmail.com>	<5341A5C3.8090802@dachary.org> <CA+AFVBjomjD_oReuEcrkpR-y5CSLw7cCjOEa3T+XHHGieT+=Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DxKlRKP3USGv63XAN5C14JGLWN9HujS04"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:42983 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642AbaDGS3t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Apr 2014 14:29:49 -0400
In-Reply-To: <CA+AFVBjomjD_oReuEcrkpR-y5CSLw7cCjOEa3T+XHHGieT+=Hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DxKlRKP3USGv63XAN5C14JGLWN9HujS04
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[re-adding the list for the record]

On 07/04/2014 19:53, Kevin Greenan wrote:> Hey Loic,
>=20
> BTW, you can get an illegal instruction fault if you are calling an int=
rinsic that is not supported on a particular platform.  Is the code being=
 compiled on a platform that is different than the machines in your test =
harness?
>=20

The plugin is compiled with three kinds of flags:

https://github.com/ceph/ceph/blob/firefly/src/erasure-code/jerasure/Makef=
ile.am#L50

at runtime the appropriate binary is loaded depending on the CPU features=


https://github.com/ceph/ceph/blob/firefly/src/erasure-code/jerasure/Erasu=
reCodePluginSelectJerasure.cc#L42

and the logs confirm that jerasure_sse4 is used in this particular case. =
All tests were run on machines tested to have the required CPU features i=
n

https://github.com/ceph/ceph/blob/firefly/src/arch/intel.c#L10

Do you see something missing ?

Cheers

> -kevin
>=20
>=20
> On Sun, Apr 6, 2014 at 12:06 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>=20
>=20
>     On 06/04/2014 18:28, Kevin Greenan wrote:
>     > Hey Loic,
>     >
>     > Did this stuff start happening after a specific commit (or commit=
s)?  I see this bug was opened 6 days ago and some changes to your fork a=
s of 7 days ago...
>     >
>     > Or is this the first time you have run these tests with the new J=
erasure backend?
>=20
>     It's the first time we run tests with gf-complete / jerasure optimi=
zed (i.e. all flags from https://github.com/ceph/ceph/blob/master/m4/ax_i=
ntel.m4 are set because the compiler knows how and it's targeting x86_64)=
=2E Before that and during three or four weeks we ran jerasure / gf-compl=
ete without any optimization. Before that we ran the previous jerasure ve=
rsion without gf-complete.
>=20
>     Cheers
>=20
>     >
>     > Thanks,
>     > -kevin
>     >
>     >
>     > On Apr 6, 2014, at 3:12 AM, Loic Dachary wrote:
>     >
>     >> Hi,
>     >>
>     >> An illegal instruction this time http://tracker.ceph.com/issues/=
7914#note-31 . Since the workload is slightly different, I'm trying to ru=
n it 30 times and see if that triggers the problem.
>     >>
>     >> Cheers
>     >>
>     >> On 02/04/2014 20:15, Kevin Greenan wrote:
>     >>> OK, it looks like this happens when the GF backend is first ini=
tialized (unless, like Loic pointed out, something is corrupted).
>     >>>
>     >>> Is this consistently happening for carry-free multiply and w=3D=
32 (i.e. gf_w32_cfm_init)?
>     >>>
>     >>> Can you send me a core + binary, so I can dig in gdb?
>     >>>
>     >>> -kevin
>     >>>
>     >>>
>     >>> On Wed, Apr 2, 2014 at 11:01 AM, Sage Weil <sage@inktank.com <m=
ailto:sage@inktank.com> <mailto:sage@inktank.com <mailto:sage@inktank.com=
>>> wrote:
>     >>>
>     >>>    On Wed, 2 Apr 2014, Loic Dachary wrote:
>     >>>>
>     >>>>
>     >>>> On 02/04/2014 19:44, Kevin Greenan wrote:
>     >>>>> Hey Loic,
>     >>>>>
>     >>>>> Are you ensuring that Jerasure (actually gf-complete) is gett=
ing memory buffers aligned on 16-byte boundaries?  Without looking too de=
ep, that is the first thing I would check.
>     >>>>>
>     >>>>
>     >>>> Yes
>     >>>>
>     >>>> https://github.com/ceph/ceph/blob/master/src/erasure-code/jera=
sure/ErasureCodeJerasure.cc#L32
>     >>>> https://github.com/ceph/ceph/blob/master/src/erasure-code/jera=
sure/ErasureCodeJerasure.cc#L242
>     >>>> https://github.com/ceph/ceph/blob/master/src/erasure-code/jera=
sure/ErasureCodeJerasure.cc#L65
>     >>>> https://github.com/ceph/ceph/blob/master/src/erasure-code/jera=
sure/ErasureCodeJerasure.cc#L108
>     >>>>
>     >>>
>     >>>    In this case they are 2K aligned:
>     >>>
>     >>>    (gdb) p data_ptrs[0]
>     >>>    $1 =3D 0x3e46000 "I'm the", ' ' <repeats 16 times>, "3th obj=
ect!"
>     >>>    (gdb) p data_ptrs[1]
>     >>>    $2 =3D 0x3e46800 'z' <repeats 200 times>...
>     >>>    (gdb) p coding_ptrs[0]
>     >>>    $3 =3D 0x338e000 "I'm the", ' ' <repeats 16 times>, "3th obj=
ect!"
>     >>>
>     >>>    sage
>     >>>
>     >>>> I'll re-read this logic tomorrow just to be sure.
>     >>>>
>     >>>> Cheers
>     >>>>
>     >>>>> I can have a deeper look later today or tomorrow.
>     >>>>>
>     >>>>> -kevin
>     >>>>>
>     >>>>>
>     >>>>> On Wed, Apr 2, 2014 at 10:35 AM, Loic Dachary <loic@dachary.o=
rg <mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachar=
y.org>> <mailto:loic@dachary.org <mailto:loic@dachary.org> <mailto:loic@d=
achary.org <mailto:loic@dachary.org>>>> wrote:
>     >>>>>
>     >>>>>    Hi Kevin,
>     >>>>>
>     >>>>>    In the context of http://tracker.ceph.com/issues/7914 we'r=
e trying to figure out why jerasure dumps core. We don't know how to repr=
oduce it yet (ran dozens of identical tests suites with no such crash in =
the past few days, which is to be expected for rare bugs because the test=
 suite introduces random errors / failures on purpose).
>     >>>>>
>     >>>>>    The full stack trace is at http://tracker.ceph.com/issues/=
7914#note-24 but the relevant part is here:
>     >>>>>
>     >>>>>    #0  0x00007f4756779b7b in raise (sig=3D<optimized out>) at=
 ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:42
>     >>>>>    #1  0x0000000000981b4e in reraise_fatal (signum=3D11) at g=
lobal/signal_handler.cc:59
>     >>>>>    #2  handle_fatal_signal (signum=3D11) at global/signal_han=
dler.cc:105
>     >>>>>    #3  <signal handler called>
>     >>>>>    #4  0x0000000000000000 in ?? ()
>     >>>>>    #5  0x00007f47385ae6b1 in jerasure_matrix_dotprod (k=3D2, =
w=3D8, matrix_row=3D0x31513a8, src_ids=3D0x0, dest_id=3D<optimized out>, =
data_ptrs=3D0x7f4741ec7a00, coding_ptrs=3D0x7f4741ec7a10,
>     >>>>>        size=3D2048) at erasure-code/jerasure/jerasure/src/jer=
asure.c:607
>     >>>>>    #6  0x00007f47385ae7d6 in jerasure_matrix_encode (k=3D2, m=
=3D1, w=3D8, matrix=3D<optimized out>, data_ptrs=3D0x7f4741ec7a00, coding=
_ptrs=3D0x7f4741ec7a10, size=3D2048)
>     >>>>>        at erasure-code/jerasure/jerasure/src/jerasure.c:310
>     >>>>>    ...
>     >>>>>
>     >>>>>    Note that this jerasure/gf-complete combination has been c=
ompiled with SSE4.1, SSE4.2, PCLMUL, SSSE3, SSE3, SSE2, SSE flags activat=
ed. These are jerasure v2 and gf-complete v1, only slightly modified as f=
ound in https://github.com/ceph/jerasure/tree/v2-ceph and https://github.=
com/ceph/gf-complete/tree/v1-ceph (all commits there have a pending pull =
request under https://bitbucket.org/jimplank/gf-complete https://bitbucke=
t.org/jimplank/jerasure, nothing you've not seen before).
>     >>>>>
>     >>>>>    #5 is https://github.com/ceph/jerasure/blob/v2-ceph/src/je=
rasure.c#L607
>     >>>>>
>     >>>>>    and then it dives into gf-complete and most probably destr=
oyed part of the stack when corrupting memory. I'll be chasing this tomor=
row. If you have a brilliant idea on why that happens, I'll take it ;-)
>     >>>>>
>     >>>>>    Cheers
>     >>>>>
>     >>>>>    --
>     >>>>>    Lo=EFc Dachary, Artisan Logiciel Libre
>     >>>>>
>     >>>>>
>     >>>>
>     >>>> --
>     >>>> Lo=EFc Dachary, Artisan Logiciel Libre
>     >>>>
>     >>>>
>     >>>
>     >>>
>     >>
>     >> --
>     >> Lo=EFc Dachary, Artisan Logiciel Libre
>     >>
>     >
>=20
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--DxKlRKP3USGv63XAN5C14JGLWN9HujS04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNC7pYACgkQ8dLMyEl6F21GlACfeH8cyTsaPUguEs5CWusKnNEn
uWsAnjgjo0IZUX5ywKsrtV/g1wlgsjai
=ERR0
-----END PGP SIGNATURE-----

--DxKlRKP3USGv63XAN5C14JGLWN9HujS04--
