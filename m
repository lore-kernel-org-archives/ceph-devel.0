From: Loic Dachary <loic@dachary.org>
Subject: GCC -msse2 portability question
Date: Sun, 23 Mar 2014 20:50:38 +0100
Message-ID: <532F3B0E.2050204@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NXOB8stbk6JOUhNQEEm5Lt80eaEkWVx0R"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:52100 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaCWTuk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Mar 2014 15:50:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent Guerby <laurent@guerby.net>, Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NXOB8stbk6JOUhNQEEm5Lt80eaEkWVx0R
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

In the context of optimizing erasure code functions implemented by Kevin =
Greenan (cc'ed) and James Plank at https://bitbucket.org/jimplank/gf-comp=
lete/ we ran accross a question you may have the answer to: can gcc -msse=
2 (or -msse* for that matter ) have a negative impact on the portability =
of the compiled binary code ?=20

In other words, if a code is compiled without -msse* and runs fine on all=
 intel processors it targets, could it be that adding -msse* to the compi=
lation of the same source code generate a binary that would fail on some =
processors ? This is assuming no sse specific functions were used in the =
source code.

In gf-complete, all sse specific instructions are carefully protected to =
not be run on a CPU that does not support them. The runtime detection is =
done by checking CPU id bits ( see https://bitbucket.org/jimplank/gf-comp=
lete/pull-request/7/probe-intel-sse-features-at-runtime/diff#Lsrc/gf_inte=
l.cT28 )

The corresponding thread is at:

https://bitbucket.org/jimplank/gf-complete/pull-request/4/defer-the-decis=
ion-to-use-a-given-sse/diff#comment-1479296

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--NXOB8stbk6JOUhNQEEm5Lt80eaEkWVx0R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMvOw4ACgkQ8dLMyEl6F23TJQCeJqMV2HjRK1djOT+7cFU3VprR
9fsAniveQEI1cpndW5XQBfZ7nnRgPeS0
=obA0
-----END PGP SIGNATURE-----

--NXOB8stbk6JOUhNQEEm5Lt80eaEkWVx0R--
