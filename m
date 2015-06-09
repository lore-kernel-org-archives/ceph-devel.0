From: Loic Dachary <loic@dachary.org>
Subject: ceph make check behavior change on Ubuntu precise and CentOS 6.5
Date: Tue, 09 Jun 2015 14:54:48 +0200
Message-ID: <5576E218.8070701@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kpNV3OKHMjUKaWoPVIGqU7t2KWvd8ikG4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59012 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753783AbbFIMyv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 08:54:51 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id E146742B46
	for <ceph-devel@vger.kernel.org>; Tue,  9 Jun 2015 14:54:48 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kpNV3OKHMjUKaWoPVIGqU7t2KWvd8ikG4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

When a make check test fails and a recent (>=3D1.13) automake version is =
used, it shows something like

PASS: unittest_erasure_code_plugin
FAILED: unittest_erasure_code

which is not very informative. The actual stderr/stdout of the test can b=
e found in a file by the same name as the test with the .log suffix (i.e.=
 unittest_erasure_code.log). It is displayed by the make check bot[1] but=
 it's not a native feature of automake (or if it is I don't know about it=
 ;-).

This automake behavior (having .log files for each individual test) chang=
ed in version 1.13[2]. In the automake 1.11 version which is the default =
for Ubuntu precise 12.04 and CentOS 6.5, the output of the tests are disp=
layed on the stdout/stderr of make, as it has been for the past 25 years.=
=20

As of https://github.com/ceph/ceph/pull/4908 the parallel-test option wil=
l always be set, even on precise and CentOS 6.5, and the make check behav=
ior will be the same, regardless of the automake version: test outputs wi=
ll be to individual .log files. The motivation is to=20

  * reduce the size of the output of the gitbuilders,=20
  * make errors more consumable from the browser,=20
  * be able to run test in parallel (it currently runs 4 times faster whe=
n running with -j4).
  * avoid confusion because make check behaves differently depending on t=
he automake version.

Cheers

[1] loop to display the logs of failed tests http://workbench.dachary.org=
/ceph/ceph/blob/master/run-make-check.sh#L73
[2] automake 1.13 release notes http://lists.gnu.org/archive/html/automak=
e/2012-12/msg00038.html

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--kpNV3OKHMjUKaWoPVIGqU7t2KWvd8ikG4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlV24hgACgkQ8dLMyEl6F20mfACgnWMBENJSPvhw8u6CBMXRnYcN
LGMAn39k+Rb5+hy2U1f+6fJEE3ytC+DC
=An2j
-----END PGP SIGNATURE-----

--kpNV3OKHMjUKaWoPVIGqU7t2KWvd8ikG4--
