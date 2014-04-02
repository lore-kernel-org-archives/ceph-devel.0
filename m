From: Loic Dachary <loic@dachary.org>
Subject: jerasure/gf-complete segmentation violation
Date: Wed, 02 Apr 2014 19:35:35 +0200
Message-ID: <533C4A67.3070906@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uwcT5lqwRge2wutBiwDd4nOgWBpfslacf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34285 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527AbaDBRfo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Apr 2014 13:35:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uwcT5lqwRge2wutBiwDd4nOgWBpfslacf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

In the context of http://tracker.ceph.com/issues/7914 we're trying to fig=
ure out why jerasure dumps core. We don't know how to reproduce it yet (r=
an dozens of identical tests suites with no such crash in the past few da=
ys, which is to be expected for rare bugs because the test suite introduc=
es random errors / failures on purpose).=20

The full stack trace is at http://tracker.ceph.com/issues/7914#note-24 bu=
t the relevant part is here:

#0  0x00007f4756779b7b in raise (sig=3D<optimized out>) at ../nptl/sysdep=
s/unix/sysv/linux/pt-raise.c:42
#1  0x0000000000981b4e in reraise_fatal (signum=3D11) at global/signal_ha=
ndler.cc:59
#2  handle_fatal_signal (signum=3D11) at global/signal_handler.cc:105
#3  <signal handler called>
#4  0x0000000000000000 in ?? ()
#5  0x00007f47385ae6b1 in jerasure_matrix_dotprod (k=3D2, w=3D8, matrix_r=
ow=3D0x31513a8, src_ids=3D0x0, dest_id=3D<optimized out>, data_ptrs=3D0x7=
f4741ec7a00, coding_ptrs=3D0x7f4741ec7a10,=20
    size=3D2048) at erasure-code/jerasure/jerasure/src/jerasure.c:607
#6  0x00007f47385ae7d6 in jerasure_matrix_encode (k=3D2, m=3D1, w=3D8, ma=
trix=3D<optimized out>, data_ptrs=3D0x7f4741ec7a00, coding_ptrs=3D0x7f474=
1ec7a10, size=3D2048)
    at erasure-code/jerasure/jerasure/src/jerasure.c:310
=2E..

Note that this jerasure/gf-complete combination has been compiled with SS=
E4.1, SSE4.2, PCLMUL, SSSE3, SSE3, SSE2, SSE flags activated. These are j=
erasure v2 and gf-complete v1, only slightly modified as found in https:/=
/github.com/ceph/jerasure/tree/v2-ceph and https://github.com/ceph/gf-com=
plete/tree/v1-ceph (all commits there have a pending pull request under h=
ttps://bitbucket.org/jimplank/gf-complete https://bitbucket.org/jimplank/=
jerasure, nothing you've not seen before).=20

#5 is https://github.com/ceph/jerasure/blob/v2-ceph/src/jerasure.c#L607

and then it dives into gf-complete and most probably destroyed part of th=
e stack when corrupting memory. I'll be chasing this tomorrow. If you hav=
e a brilliant idea on why that happens, I'll take it ;-)=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--uwcT5lqwRge2wutBiwDd4nOgWBpfslacf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM8SmsACgkQ8dLMyEl6F23+2wCgs4Bt0TmIITCnqmu/uRjhzZL3
D6IAn2UIY/dd6XXlMNxF2WSqsO5Ok6gp
=5L4Y
-----END PGP SIGNATURE-----

--uwcT5lqwRge2wutBiwDd4nOgWBpfslacf--
