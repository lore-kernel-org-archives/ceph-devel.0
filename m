From: Loic Dachary <loic@dachary.org>
Subject: rgw and the next firefly release
Date: Sat, 28 Feb 2015 11:44:07 +0100
Message-ID: <54F19BF7.6030808@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WkhvwhdUbRHl5bKlfnxBxx2XtBdgt2V7V"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50483 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750835AbbB1KoN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Feb 2015 05:44:13 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WkhvwhdUbRHl5bKlfnxBxx2XtBdgt2V7V
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

The rados teuthology suite for the next firefly release as found in https=
://github.com/ceph/ceph/commits/firefly-backports came back green http://=
pulpito.ceph.com/loic-2015-02-27_18:04:18-rgw-firefly-backports---basic-m=
ulti/. Do you think it is ready for QE to start their own round of testin=
g ?

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre




--WkhvwhdUbRHl5bKlfnxBxx2XtBdgt2V7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTxm/cACgkQ8dLMyEl6F215xACdGe44lfEMSdTR/Lty63WMapnv
684AoKRZeVPMDRBuZCa44ltCYj+WzSSi
=z4vI
-----END PGP SIGNATURE-----

--WkhvwhdUbRHl5bKlfnxBxx2XtBdgt2V7V--
