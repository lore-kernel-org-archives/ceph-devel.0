From: Loic Dachary <loic@dachary.org>
Subject: Erasure Code Alpha Testing
Date: Sat, 01 Mar 2014 14:01:05 +0100
Message-ID: <5311DA11.7020900@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1scpgx8lTvEpPTGNt14FhWrRX6fLgi46M"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:57617 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbaCANBJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Mar 2014 08:01:09 -0500
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 6473C26394
	for <ceph-devel@vger.kernel.org>; Sat,  1 Mar 2014 14:01:07 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1scpgx8lTvEpPTGNt14FhWrRX6fLgi46M
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

The code implementing Erasure Code in Ceph has been merged in Firefly[1] =
and is being tested. The unit tests are run at compile time with make che=
ck. The integration tests are run by teuthology [2], the Q&A tool dedicat=
ed to Ceph. A few workloads have been added for erasure code [3] and thei=
r success/failure can be observed daily from the pulpito [4] dashboard [5=
].=20

Seven organizations volunteered to alpha test erasure code a few months a=
go and were encouraged to run teuthology locally. Combined with manual te=
sting, teuthology is a convenient way to encode a use case and explain th=
e steps to reproduce a problem. I will make myself available to help inst=
all teuthlology. If you want to participate, feel free to send me an emai=
l or ping me on irc.oftc.net#ceph-devel nick loicd

There are many ways to contribute to stabilize erasure code before Firefl=
y is released:

* Run the rados [6] teuthlogy [2] Q&A suite [7] locally=20

* Try manually after compiling Firefly [1] from sources [8]

  rm -fr dev out ;  mkdir -p dev ; LC_ALL=3DC MON=3D1 OSD=3D10 bash -x ./=
vstart.sh -d -n -X -l mon osd
  ./ceph osd crush rule create-erasure ecruleset erasure-code-k=3D2 erasu=
re-code-m=3D1 erasure-code-ruleset-failure-domain=3Dosd
  ./ceph osd pool create ecpool 12 12 erasure crush_ruleset=3Decruleset e=
rasure-code-k=3D2 erasure-code-m=3D1

  the pool ecpool is erasure coded and ready to be used manually.

* Diagnose problems found by the daily teuthology runs from Intank [2]

* Proofread the Firefly code [1]

* Report bugs [9]

* Fix unassigned erasure code bugs from the queue [10] and send a pull re=
quest [11]

Cheers

[1] Firefly branch https://github.com/ceph/ceph/tree/firefly
[2] Teuthology Q&A tool https://github.com/ceph/teuthology/
[3] ec-* workloads https://github.com/ceph/ceph-qa-suite/tree/master/suit=
es/rados/thrash/workloads
[4] Pulpito, the Teuthology dashboard https://github.com/ceph/pulpito
[5] Firefly rados suite results http://pulpito.ceph.com/?branch=3Dfirefly=
&suite=3Drados
[6] Rados suite https://github.com/ceph/ceph-qa-suite/tree/master/suites/=
rados
[7] Teuthology Q&A suite https://github.com/ceph/ceph-qa-suite/
[8] Building from sources http://ceph.com/docs/master/install/build-ceph/=

[9] Bug tracker http://tracker.ceph.com/projects/ceph/issues/new
[10] "erasure code" or "ec" in the subject http://tracker.ceph.com/projec=
ts/ceph/issues?query_id=3D47
[11] Ceph pull requests https://github.com/ceph/ceph/pulls

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--1scpgx8lTvEpPTGNt14FhWrRX6fLgi46M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMR2hEACgkQ8dLMyEl6F22ShgCgtEQ9PRmnBJURSNYf8G5e26o3
P5QAnj1W0OuOEHDYpzEYskQIEGwqApdB
=63Im
-----END PGP SIGNATURE-----

--1scpgx8lTvEpPTGNt14FhWrRX6fLgi46M--
