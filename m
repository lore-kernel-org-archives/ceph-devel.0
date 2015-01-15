From: Loic Dachary <loic@dachary.org>
Subject: upcoming release giant v0.87.1 : leads feedback needed
Date: Thu, 15 Jan 2015 17:12:12 +0100
Message-ID: <54B7E6DC.8010905@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4xLF5XfOlBDFwkbesbdqIKP5BeMh7DFdA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41082 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754248AbbAOQMP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 11:12:15 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 0273842AF2
	for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 17:12:12 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4xLF5XfOlBDFwkbesbdqIKP5BeMh7DFdA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

The https://github.com/ceph/ceph/tree/giant-backports branch was tested w=
ith the rgw, rados and rbd suites. The results of each suite have been an=
alyzed and summarized in http://tracker.ceph.com/issues/10501. The next s=
teps are either:

a) Yehuda for rgw, Josh for rbd and Sam for rados all agree that the erro=
rs are unrelated to the backports
b) The https://github.com/ceph/ceph/tree/giant-backports branch is given =
to QE for final tests and merge into giant

OR

a) At least of the lead thinks more work is needed to stabilize the giant=
 branch
b) A new set of tests will be run and analyzed after adding/removing one =
or more backports to/from the https://github.com/ceph/ceph/tree/giant-bac=
kports branch

The description of http://tracker.ceph.com/issues/10501 shows a detailed =
list of all commits / issues that are in the giant backport branch. To ge=
t a global view of what the next giant point release will be, the descrip=
tion also includes the commits that have already been merged in the giant=
 branch. The list of pull requests that are candidate for inclusion in th=
e giant release but have not been included in the integration branch are =
also listed: maybe one of them could contribute to resolve a problem foun=
d during the tests. And finally all redmine issues that have been marked =
to be backported to giant but do not yet have a candidate pull request ar=
e listed: this is the backport backlog so to speak ;-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre




--4xLF5XfOlBDFwkbesbdqIKP5BeMh7DFdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS35twACgkQ8dLMyEl6F23zXwCfRwEaLRwEStfGr61gQKCuDX1h
fTsAoK75pL8hjDENHX1dxQwLdi7TBTkT
=VQVa
-----END PGP SIGNATURE-----

--4xLF5XfOlBDFwkbesbdqIKP5BeMh7DFdA--
