From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure/gf-complete segmentation violation
Date: Thu, 03 Apr 2014 00:57:42 +0200
Message-ID: <533C95E6.1090408@dachary.org>
References: <533C4A67.3070906@dachary.org> <533C4E0D.3050604@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EqwDpGxqvTxH2XwcqrtolVNX9XMkRALhs"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34507 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933423AbaDBW5w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Apr 2014 18:57:52 -0400
In-Reply-To: <533C4E0D.3050604@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EqwDpGxqvTxH2XwcqrtolVNX9XMkRALhs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Here is the stack trace on a successfull run, borrowed from the unit test=
s, to confirm the code path : http://tracker.ceph.com/issues/7914#note-27=


On 02/04/2014 19:51, Loic Dachary wrote:
> Given the parameters to jerasure_matrix_dotprod the code path should be=
:
>=20
>    https://github.com/ceph/jerasure/blob/v2-ceph/src/galois.c#L338 (bec=
ause nbytes =3D=3D 2048)
>    https://github.com/ceph/jerasure/blob/v2-ceph/src/galois.c#L332=20
>    https://github.com/ceph/gf-complete/blob/v1-ceph/src/gf_w32.c#L569 (=
because INTEL_SSE4_PCLMUL has been used at compile time and the CPUID det=
ected at runtime has the required features as selected in https://github.=
com/ceph/ceph/blob/master/src/erasure-code/jerasure/ErasureCodePluginSele=
ctJerasure.cc#L49 )
>   =20
> what should happen after that ? h->prim_poly will select something but =
what exactly... Could it be that the lack of stack means https://github.c=
om/ceph/jerasure/blob/v2-ceph/src/galois.c#L332 references a NULL or inva=
lid gfp_array[32] ? Or could it be that src/dest pointers are pointing to=
 invalid memory ?
>=20
> Bugs that can't be reproduced are the best ;-)
>   =20
> On 02/04/2014 19:35, Loic Dachary wrote:> Hi Kevin,
>>
>> In the context of http://tracker.ceph.com/issues/7914 we're trying to =
figure out why jerasure dumps core. We don't know how to reproduce it yet=
 (ran dozens of identical tests suites with no such crash in the past few=
 days, which is to be expected for rare bugs because the test suite intro=
duces random errors / failures on purpose).=20
>>
>> The full stack trace is at http://tracker.ceph.com/issues/7914#note-24=
 but the relevant part is here:
>>
>> #0  0x00007f4756779b7b in raise (sig=3D<optimized out>) at ../nptl/sys=
deps/unix/sysv/linux/pt-raise.c:42
>> #1  0x0000000000981b4e in reraise_fatal (signum=3D11) at global/signal=
_handler.cc:59
>> #2  handle_fatal_signal (signum=3D11) at global/signal_handler.cc:105
>> #3  <signal handler called>
>> #4  0x0000000000000000 in ?? ()
>> #5  0x00007f47385ae6b1 in jerasure_matrix_dotprod (k=3D2, w=3D8, matri=
x_row=3D0x31513a8, src_ids=3D0x0, dest_id=3D<optimized out>, data_ptrs=3D=
0x7f4741ec7a00, coding_ptrs=3D0x7f4741ec7a10,=20
>>     size=3D2048) at erasure-code/jerasure/jerasure/src/jerasure.c:607
>> #6  0x00007f47385ae7d6 in jerasure_matrix_encode (k=3D2, m=3D1, w=3D8,=
 matrix=3D<optimized out>, data_ptrs=3D0x7f4741ec7a00, coding_ptrs=3D0x7f=
4741ec7a10, size=3D2048)
>>     at erasure-code/jerasure/jerasure/src/jerasure.c:310
>> ...
>>
>> Note that this jerasure/gf-complete combination has been compiled with=
 SSE4.1, SSE4.2, PCLMUL, SSSE3, SSE3, SSE2, SSE flags activated. These ar=
e jerasure v2 and gf-complete v1, only slightly modified as found in http=
s://github.com/ceph/jerasure/tree/v2-ceph and https://github.com/ceph/gf-=
complete/tree/v1-ceph (all commits there have a pending pull request unde=
r https://bitbucket.org/jimplank/gf-complete https://bitbucket.org/jimpla=
nk/jerasure, nothing you've not seen before).=20
>>
>> #5 is https://github.com/ceph/jerasure/blob/v2-ceph/src/jerasure.c#L60=
7
>>
>> and then it dives into gf-complete and most probably destroyed part of=
 the stack when corrupting memory. I'll be chasing this tomorrow. If you =
have a brilliant idea on why that happens, I'll take it ;-)=20
>>
>> Cheers
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--EqwDpGxqvTxH2XwcqrtolVNX9XMkRALhs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM8leoACgkQ8dLMyEl6F201hgCgsOH2HT7neLQS69JUgkF2UTHR
C3QAoIkKObg9tyGkXglcXOy8OrRm8aCO
=gqWi
-----END PGP SIGNATURE-----

--EqwDpGxqvTxH2XwcqrtolVNX9XMkRALhs--
