From: Loic Dachary <loic@dachary.org>
Subject: interpreting rados run failures with the teuthology OpenStack backend
Date: Sun, 26 Jul 2015 22:51:57 +0200
Message-ID: <55B5486D.7000901@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="L3tjdV6RPo11oACw5fvXiLQsIH4TC3JXi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:56556 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755216AbbGZUv7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Jul 2015 16:51:59 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kefu Chai <kchai@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L3tjdV6RPo11oACw5fvXiLQsIH4TC3JXi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[cc'ing ceph-devel in case someone else tries to run the rados suite on O=
penStack]

Hi Kefu,

Your rados run at http://149.202.175.39:8081/ubuntu-2015-07-26_14:28:51-r=
ados-wip-kefu-t3sting---basic-openstack/ has a number of failed / dead jo=
bs. Some of them are environmental failures, others happen because things=
 run on bare metal machines that run slower, have smaller disks and short=
er timeouts. A few of them I can't explain right now and maybe they are j=
ust bugs ;-)

There is an inventory of all the failures found in a rados run against ne=
xt today, also using OpenStack at http://tracker.ceph.com/issues/12471

* timeout after 4h : http://tracker.ceph.com/issues/12471#note-8
* mysterious rgw DNSError which never happens in sepia : http://tracker.c=
eph.com/issues/12471#note-4
* out of disk (OpenStack machines only have 40GB) : http://tracker.ceph.c=
om/issues/12471#note-14

For the record here are the sepia runs archives: http://pulpito.ceph.com/=
?suite=3Drados&branch=3Dnext

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--L3tjdV6RPo11oACw5fvXiLQsIH4TC3JXi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW1SG0ACgkQ8dLMyEl6F22JTQCfXNQbK1bozaQjWGDgONLcJi47
KcUAn1d4Y4tWNTzTEFKdo38Qqu6O36fo
=XGYx
-----END PGP SIGNATURE-----

--L3tjdV6RPo11oACw5fvXiLQsIH4TC3JXi--
