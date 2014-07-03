From: Loic Dachary <loic@dachary.org>
Subject: Checking of Reed-Solomon Vandermonde parameter combinations
Date: Thu, 03 Jul 2014 12:22:00 +0200
Message-ID: <53B52EC8.5030708@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Taib204a63BJxlHUfgl8PmfcRKdmWLiNt"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36704 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758548AbaGCKWH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jul 2014 06:22:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Taib204a63BJxlHUfgl8PmfcRKdmWLiNt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

There are some combinations of K/M parameters for which Reed-Solomon Vand=
ermonde may not be able to recover from the loss of M chunks. Reed-Solomo=
n Cauchy does not suffer from this problem. (I'm paraphrasing a conversat=
ion we had in private, feel free to correct me if I'm wrong).

In the context of Ceph we are interested in a limited range of parameters=
 so I ran a test with:

https://github.com/ceph/ceph/blob/master/src/test/erasure-code/ceph_erasu=
re_code_benchmark.cc#L40

for k in $(seq 2 50) ; do for m in $(seq 1 $k) ; do echo -n "k=3D$k m=3D$=
m " ; ./ceph_erasure_code_benchmark      --plugin jerasure      --paramet=
er directory=3D.libs      --parameter technique=3Dreed_sol_van      --par=
ameter k=3D$k      --parameter m=3D$m --erasures $m      --iterations 1 -=
-workload decode ; done ; done

and it does not throw an error. It basically take a range of parameters K=
=3D2,M=3D2 up to K=3D50,M=3D50 and decode with M erasures for each of the=
m. Should some of them fail ?

Cheers
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--Taib204a63BJxlHUfgl8PmfcRKdmWLiNt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlO1LsgACgkQ8dLMyEl6F222UgCgj6NGyelm+ZS36CUyHu7uJyuk
CvwAn3956hvlmZWtnffimSre9qhqZXpk
=rVyy
-----END PGP SIGNATURE-----

--Taib204a63BJxlHUfgl8PmfcRKdmWLiNt--
