From: Loic Dachary <loic@dachary.org>
Subject: rados and the next firefly release
Date: Sat, 28 Feb 2015 16:42:53 +0100
Message-ID: <54F1E1FD.7060206@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qsIVcCNsIaa50VEaTxr3L0vm9RJ2TcEmw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50590 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751464AbbB1Pm4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Feb 2015 10:42:56 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qsIVcCNsIaa50VEaTxr3L0vm9RJ2TcEmw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

The rados teuthology suite for the next firefly release as found in https=
://github.com/ceph/ceph/commits/firefly-backports came back with one fail=
ure (unreadable crash from ceph-osd http://tracker.ceph.com/issues/10485)=
=2E The details of the run is at http://tracker.ceph.com/issues/10641#rad=
os (note that one run was solely to repeat the jobs that failed because o=
f environmental problems). Do you think it is ready for QE to start their=
 own round of testing ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre








--qsIVcCNsIaa50VEaTxr3L0vm9RJ2TcEmw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTx4f0ACgkQ8dLMyEl6F22/XwCfYW80WiN059eI/JqnWrqikrqB
XYoAnRse0dRcqpIDkRv8RlPTuVzQiEHw
=QUGE
-----END PGP SIGNATURE-----

--qsIVcCNsIaa50VEaTxr3L0vm9RJ2TcEmw--
