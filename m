From: Loic Dachary <loic@dachary.org>
Subject: Tools and archive to check for non regression of erasure coded content
Date: Sat, 13 Sep 2014 13:50:33 +0200
Message-ID: <54142F89.4060804@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JrK17XaUUcdGcm0bulvixFdJ1Vlrd3QXo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51343 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751652AbaIMLuo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Sep 2014 07:50:44 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id DC1F042B18
	for <ceph-devel@vger.kernel.org>; Sat, 13 Sep 2014 13:50:33 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JrK17XaUUcdGcm0bulvixFdJ1Vlrd3QXo
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

An erasure coded object stored in Firefly when it was first introduced mu=
st be decoded by all versions after Firefly. The encoding is done by eras=
ure code plugins[1] and they evolve over time[2]. There needs to be a too=
l to check that all content encoded by a given version of the plugin can =
also be encoded by all subsequent versions of the same plugin.

The general idea is to archive objects created with a given Ceph version =
and check them will all subsequent versions, via a teuthology workunit ru=
n on all supported distributions and architectures.

The ceph_erasure_code_non_regression command[3] creates an object and sto=
re it on disk or read an object from disk and checks that it can be read.=
 It is used to create objects for all relevant variations of parameters o=
f a given erasure code plugin. For instance:

ceph_erasure_code_non_regression --stripe-width 4651 --parameter packetsi=
ze=3D32 --plugin jerasure --parameter technique=3Dblaum_roth --parameter =
k=3D6 --parameter m=3D2 --create --base ../../ceph-erasure-code-corpus/v0=
=2E85-764-gf3a1532
ceph_erasure_code_non_regression --stripe-width 4651 --parameter packetsi=
ze=3D32 --plugin jerasure --parameter technique=3Dliber8tion --parameter =
k=3D6 --parameter m=3D2 --create --base ../../ceph-erasure-code-corpus/v0=
=2E85-764-gf3a1532
etc.

The script[4] and the objects are archived in a repository [5] that can b=
e checked by later Ceph versions. The same script is used for checking an=
d creating the objects so that there is no risk of confusion. These scrip=
ts are stored per version because a given script is developed for a given=
 version of the plugins.=20

The encode-decode-non-regression.sh[6] workunit uses these scripts when r=
un from teuthology[7] and will run all of them, up to and including the c=
urrently running ceph version. This ultimately ensures that all archived =
objects can be read on all supported distributions and architectures.

See also http://tracker.ceph.com/issues/9420 which is the ticket associat=
ed to this work.

Although this all sound sensible to me right now, I would be very interes=
ted to hear about ideas to make this easier or better :-)

Cheers

[1] firefly erasure code plugins https://github.com/ceph/ceph/tree/firefl=
y/src/erasure-code
[2] giant erasure code plugins https://github.com/ceph/ceph/tree/v0.85/sr=
c/erasure-code
[3] ceph_erasure_code_non_regression https://github.com/dachary/ceph/comm=
it/497a82b2b3113dae724a43d8d4c7e430acf44120
[4] non-regression.sh https://github.com/dachary/ceph-erasure-code-corpus=
/blob/master/v0.80.5-226-g71d2562/non-regression.sh
[5] ceph-erasure-code-corpus https://github.com/dachary/ceph-erasure-code=
-corpus
[6] encode-decode-non-regression.sh https://github.com/dachary/ceph/commi=
t/4f7a9f83fb1f037662861e8782c9b90566dcaa31
[7] non regression workload https://github.com/ceph/ceph-qa-suite/pull/13=
6
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--JrK17XaUUcdGcm0bulvixFdJ1Vlrd3QXo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQUL4kACgkQ8dLMyEl6F20LrQCcDur7XmfMAIpB/UVXq/vua2Db
HBIAn3JUu7M5+nqT4GAkBeagZ+ZVOfRK
=wjel
-----END PGP SIGNATURE-----

--JrK17XaUUcdGcm0bulvixFdJ1Vlrd3QXo--
