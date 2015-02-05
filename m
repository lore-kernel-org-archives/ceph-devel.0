From: Loic Dachary <loic@dachary.org>
Subject: rgw and the next dumpling release
Date: Thu, 05 Feb 2015 23:38:29 +0100
Message-ID: <54D3F0E5.8060906@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JrkPhK4esWNtxCDrScI9letMdckwAv4HC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39503 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751942AbbBEWib (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Feb 2015 17:38:31 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JrkPhK4esWNtxCDrScI9letMdckwAv4HC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

The rados teuthology suite for the next dumpling release as found in http=
s://github.com/ceph/ceph/commits/dumpling-backports came back green http:=
//pulpito.ceph.com/loic-2015-02-03_14:46:09-rgw-dumpling-backports---basi=
c-multi/. Do you think it is ready for QE to start their own round of tes=
ting ?

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--JrkPhK4esWNtxCDrScI9letMdckwAv4HC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTT8OUACgkQ8dLMyEl6F20WAACghJuQlYK9b0NCZF8mLCRD/fE/
b1QAn251+cU3sGR2iLL/314WWj+6+LKZ
=qN1L
-----END PGP SIGNATURE-----

--JrkPhK4esWNtxCDrScI9letMdckwAv4HC--
