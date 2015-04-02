From: Loic Dachary <loic@dachary.org>
Subject: Giant v0.87.2 integration branch ready for testing
Date: Thu, 02 Apr 2015 14:46:43 +0200
Message-ID: <551D3A33.5040004@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vvD8orAE6fbt2evmTqoJdQA1OmWGBRWEx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40756 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751391AbbDBMqs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Apr 2015 08:46:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vvD8orAE6fbt2evmTqoJdQA1OmWGBRWEx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

Joao backported https://github.com/ceph/ceph/pull/4258 and it was merged =
together with https://github.com/ceph/ceph/pull/4214 into the https://git=
hub.com/ceph/ceph/tree/giant-backports branch. It should be ready for tes=
ting after http://ceph.com/gitbuilder.cgi compiled it. I don't think we n=
eed to run rbd and rgw this time. The http://tracker.ceph.com/issues/1115=
3#teuthology-run-commit538d012a30361d7fb33ee19632103a1ff242dee3-giant-bac=
kports-branch-april-2015 entry has been updated with details.

The teuthology commands to launch the suites should be ready but it's cer=
tainly worth a review ;-)=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--vvD8orAE6fbt2evmTqoJdQA1OmWGBRWEx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUdOjMACgkQ8dLMyEl6F21EMACfQDJXx/m9ZjgH+MoZkYw8yZIi
564AnAjQpwyBphuIlQFGAb9ioPmQNh8C
=Y2HU
-----END PGP SIGNATURE-----

--vvD8orAE6fbt2evmTqoJdQA1OmWGBRWEx--
