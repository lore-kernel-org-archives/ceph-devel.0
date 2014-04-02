From: Sage Weil <sage@inktank.com>
Subject: Re: jerasure/gf-complete segmentation violation
Date: Wed, 2 Apr 2014 11:01:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1404021101250.2734@cobra.newdream.net>
References: <533C4A67.3070906@dachary.org> <CA+AFVBg00yTzu-VGxSURDxv_UWOmZJEF+077txButeoSkoQuBg@mail.gmail.com> <533C4F40.8020207@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-992613608-1396461715=:2734"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33895 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332AbaDBSB4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Apr 2014 14:01:56 -0400
In-Reply-To: <533C4F40.8020207@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Kevin Greenan <kmgreen2@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-992613608-1396461715=:2734
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Apr 2014, Loic Dachary wrote:
>=20
>=20
> On 02/04/2014 19:44, Kevin Greenan wrote:
> > Hey Loic,
> >=20
> > Are you ensuring that Jerasure (actually gf-complete) is getting memo=
ry buffers aligned on 16-byte boundaries?  Without looking too deep, that=
 is the first thing I would check.
> >=20
>=20
> Yes
>=20
> https://github.com/ceph/ceph/blob/master/src/erasure-code/jerasure/Eras=
ureCodeJerasure.cc#L32
> https://github.com/ceph/ceph/blob/master/src/erasure-code/jerasure/Eras=
ureCodeJerasure.cc#L242
> https://github.com/ceph/ceph/blob/master/src/erasure-code/jerasure/Eras=
ureCodeJerasure.cc#L65
> https://github.com/ceph/ceph/blob/master/src/erasure-code/jerasure/Eras=
ureCodeJerasure.cc#L108
>=20

In this case they are 2K aligned:

(gdb) p data_ptrs[0]
$1 =3D 0x3e46000 "I'm the", ' ' <repeats 16 times>, "3th object!"
(gdb) p data_ptrs[1]
$2 =3D 0x3e46800 'z' <repeats 200 times>...
(gdb) p coding_ptrs[0]
$3 =3D 0x338e000 "I'm the", ' ' <repeats 16 times>, "3th object!"

sage

> I'll re-read this logic tomorrow just to be sure.
>=20
> Cheers
>=20
> > I can have a deeper look later today or tomorrow.
> >=20
> > -kevin
> >=20
> >=20
> > On Wed, Apr 2, 2014 at 10:35 AM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org>> wrote:
> >=20
> >     Hi Kevin,
> >=20
> >     In the context of http://tracker.ceph.com/issues/7914 we're tryin=
g to figure out why jerasure dumps core. We don't know how to reproduce i=
t yet (ran dozens of identical tests suites with no such crash in the pas=
t few days, which is to be expected for rare bugs because the test suite =
introduces random errors / failures on purpose).
> >=20
> >     The full stack trace is at http://tracker.ceph.com/issues/7914#no=
te-24 but the relevant part is here:
> >=20
> >     #0  0x00007f4756779b7b in raise (sig=3D<optimized out>) at ../npt=
l/sysdeps/unix/sysv/linux/pt-raise.c:42
> >     #1  0x0000000000981b4e in reraise_fatal (signum=3D11) at global/s=
ignal_handler.cc:59
> >     #2  handle_fatal_signal (signum=3D11) at global/signal_handler.cc=
:105
> >     #3  <signal handler called>
> >     #4  0x0000000000000000 in ?? ()
> >     #5  0x00007f47385ae6b1 in jerasure_matrix_dotprod (k=3D2, w=3D8, =
matrix_row=3D0x31513a8, src_ids=3D0x0, dest_id=3D<optimized out>, data_pt=
rs=3D0x7f4741ec7a00, coding_ptrs=3D0x7f4741ec7a10,
> >         size=3D2048) at erasure-code/jerasure/jerasure/src/jerasure.c=
:607
> >     #6  0x00007f47385ae7d6 in jerasure_matrix_encode (k=3D2, m=3D1, w=
=3D8, matrix=3D<optimized out>, data_ptrs=3D0x7f4741ec7a00, coding_ptrs=3D=
0x7f4741ec7a10, size=3D2048)
> >         at erasure-code/jerasure/jerasure/src/jerasure.c:310
> >     ...
> >=20
> >     Note that this jerasure/gf-complete combination has been compiled=
 with SSE4.1, SSE4.2, PCLMUL, SSSE3, SSE3, SSE2, SSE flags activated. The=
se are jerasure v2 and gf-complete v1, only slightly modified as found in=
 https://github.com/ceph/jerasure/tree/v2-ceph and https://github.com/cep=
h/gf-complete/tree/v1-ceph (all commits there have a pending pull request=
 under https://bitbucket.org/jimplank/gf-complete https://bitbucket.org/j=
implank/jerasure, nothing you've not seen before).
> >=20
> >     #5 is https://github.com/ceph/jerasure/blob/v2-ceph/src/jerasure.=
c#L607
> >=20
> >     and then it dives into gf-complete and most probably destroyed pa=
rt of the stack when corrupting memory. I'll be chasing this tomorrow. If=
 you have a brilliant idea on why that happens, I'll take it ;-)
> >=20
> >     Cheers
> >=20
> >     --
> >     Lo=EFc Dachary, Artisan Logiciel Libre
> >=20
> >=20
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20
--557981400-992613608-1396461715=:2734--
