From: Loic Dachary <loic@dachary.org>
Subject: Running a teuthology workload depending on the distribution
Date: Sun, 31 Aug 2014 12:33:50 +0200
Message-ID: <5402FA0E.809@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OCQhC0qlMV9fjGFPNIHqKsbccbFUPAEaK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41428 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751046AbaHaKd5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 Aug 2014 06:33:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack.cerza@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OCQhC0qlMV9fjGFPNIHqKsbccbFUPAEaK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Zack,

The isa erasure code plugin is only built on some architectures. The work=
load described at

https://github.com/ceph/ceph-qa-suite/blob/master/erasure-code/ec-rados-p=
lugin%3Disa-k%3D2-m%3D1.yaml

can therefore only be run on those architectures. How would you recommend=
 that it is integrated in the upgrade suites ? Adding it to

https://github.com/ceph/ceph-qa-suite/tree/master/suites/upgrade/firefly-=
x/stress-split/9-workload

for instance, at the same level as

https://github.com/ceph/ceph-qa-suite/blob/master/suites/upgrade/firefly-=
x/stress-split/9-workload/ec-rados-plugin%3Djerasure-k%3D3-m%3D1.yaml

will not work because it will fail when running on precise (for instance)=
=2E

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--OCQhC0qlMV9fjGFPNIHqKsbccbFUPAEaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQC+g4ACgkQ8dLMyEl6F224RgCfdH4oxCucO3JbvUzDz9cAdsD8
L0IAn3RoQOFwC93H77IuVnxeHuV4QMBp
=7wt6
-----END PGP SIGNATURE-----

--OCQhC0qlMV9fjGFPNIHqKsbccbFUPAEaK--
