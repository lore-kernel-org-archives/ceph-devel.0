From: Loic Dachary <loic@dachary.org>
Subject: preparing firefly v0.80.11
Date: Wed, 08 Jul 2015 19:49:35 +0200
Message-ID: <559D62AF.6090107@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Iu6f2rovc8TT3AsoAiBCbpCgIDROfhw3B"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46832 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758785AbbGHRth (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jul 2015 13:49:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Iu6f2rovc8TT3AsoAiBCbpCgIDROfhw3B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

You were right : there has been a few issues merging all pull requests in=
to the firefly integration branch. But not that much : four pull requests=
 were set aside because they conflict with each other and mark as DNM.=20

I've pushed the rest in the firefly-backports integration branch and upda=
ted http://tracker.ceph.com/issues/11644#teuthology-run-commit4f3faaa1faf=
5f3b7fe8c7c9050eeed808d0e787c-firefly-backports-july-2015 accordingly.

Let me know if you need anything from me to move forward. I suppose the n=
ext step will be to schedule a teuthology run, right ?

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Iu6f2rovc8TT3AsoAiBCbpCgIDROfhw3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWdYq8ACgkQ8dLMyEl6F20+0QCgs1ltcnvdsM3P5W2qn7Eo3JwO
f9oAnRsuFp6v8KUTe4UVJi/Rl2G2f1Yz
=MCK7
-----END PGP SIGNATURE-----

--Iu6f2rovc8TT3AsoAiBCbpCgIDROfhw3B--
