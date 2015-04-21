From: Loic Dachary <loic@dachary.org>
Subject: should we prepare to release firefly v0.80.10 ?
Date: Tue, 21 Apr 2015 12:12:09 +0200
Message-ID: <55362279.5060105@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LURtCrlWdxPDohkfOscRMt3HhSBxuTkha"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49975 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751160AbbDUKMN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Apr 2015 06:12:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LURtCrlWdxPDohkfOscRMt3HhSBxuTkha
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

The firefly branch has a number of fixes ( http://tracker.ceph.com/issues=
/11090#Release-information ) and has been used for upgrade tests in the p=
ast few weeks. A few other issues have been backported since and are bein=
g tested in the integration branch ( http://tracker.ceph.com/issues/11090=
#teuthology-run-commitb91bbb434e6363a99a632cf3841f70f1f2549f79-integratio=
n-branch-april-2015 ).=20

Do you think these changes deserve a firefly v0.80.10 release ? Should we=
 ask each lead for their approval ? Or is it better to keep backporting w=
hat needs to be and wait a few weeks ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--LURtCrlWdxPDohkfOscRMt3HhSBxuTkha
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlU2InkACgkQ8dLMyEl6F23rKQCcCAyI2+ptikGH8PaUuCpd6bD0
TLcAn2Pd64a7IY7TwBwK1KGkVyWn2a6x
=LPqA
-----END PGP SIGNATURE-----

--LURtCrlWdxPDohkfOscRMt3HhSBxuTkha--
