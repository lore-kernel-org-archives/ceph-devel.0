From: Loic Dachary <loic@dachary.org>
Subject: Re: test/run-rbd-unit-tests.sh : pure virtual method called
Date: Wed, 05 Aug 2015 21:55:27 +0200
Message-ID: <55C26A2F.4010707@dachary.org>
References: <55BF905B.3020008@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="seXhvBApusso3iTAQFfH02L0IV9LWkufS"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33917 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753065AbbHETzf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Aug 2015 15:55:35 -0400
In-Reply-To: <55BF905B.3020008@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>, Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--seXhvBApusso3iTAQFfH02L0IV9LWkufS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Here is another make check fail. They don't seem to be related. To the be=
st of my knowledge these are the only two rbd related failures in make ch=
eck during the past week.

http://jenkins.ceph.dachary.org/job/ceph/LABELS=3Dubuntu-14.04&&x86_64/68=
84/console

[ RUN      ] TestLibRBD.ObjectMapConsistentSnap
using new format!
test/librbd/test_librbd.cc:2790: Failure
Value of: passed
  Actual: false
Expected: true
[  FAILED  ] TestLibRBD.ObjectMapConsistentSnap (396 ms)

[----------] Global test environment tear-down
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 98 tests from 6 test cases ran. (10554 m=
s total)
[  PASSED  ] 97 tests.
[  FAILED  ] 1 test, listed below:
[  FAILED  ] TestLibRBD.ObjectMapConsistentSnap

On 03/08/2015 18:01, Loic Dachary wrote:
> Hi,
>=20
> test/run-rbd-unit-tests.sh failed today on master on Ubuntu 14.04, when=
 run by the make check bot on an unrelated pull request (modifying do_aut=
ogen which is not used by the make check bot).
>=20
> http://jenkins.ceph.dachary.org/job/ceph/LABELS=3Dubuntu-14.04&&x86_64/=
6834/console
>=20
> [ RUN      ] TestInternal.MultipleResize
> pure virtual method called
> terminate called without an active exception
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--seXhvBApusso3iTAQFfH02L0IV9LWkufS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXCai8ACgkQ8dLMyEl6F23o1QCgqR6s4k9+kcWt7W6//002XmZT
dw8AoLJhw5ikjQFSglvlae8NISdOjZa3
=kHfC
-----END PGP SIGNATURE-----

--seXhvBApusso3iTAQFfH02L0IV9LWkufS--
