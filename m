From: Loic Dachary <loic@dachary.org>
Subject: rados suite for firefly v0.80.10 is running
Date: Wed, 13 May 2015 00:55:16 +0200
Message-ID: <555284D4.7090006@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="s8mcU6p0eWe5cDbiALd0AeRndCuPCMnPL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34050 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754012AbbELWzV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 18:55:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s8mcU6p0eWe5cDbiALd0AeRndCuPCMnPL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The necessary backport to ceph-qa-suite https://github.com/ceph/ceph-qa-s=
uite/pull/435 turned out to be simple enough, which is good. I failed in =
various interesting ways before figuring it out ;-) Now that it's merged,=
 the firefly backport of http://tracker.ceph.com/issues/11429 that Xinxin=
 prepared at https://github.com/ceph/ceph/pull/4556 should pass ( it did =
at least once at http://pulpito.ceph.com/loic-2015-05-13_00:01:26-rados-f=
irefly-backports---basic-multi/ ).=20

The rados suite was scheduled as explained at http://tracker.ceph.com/iss=
ues/11090#rados with normal priority. Since a lot of hammer related tests=
 are running at the moment I guess it will take a few days to complete.=20

Hopefully there won't be any other blockers for v0.80.10 :-)

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--s8mcU6p0eWe5cDbiALd0AeRndCuPCMnPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVShNQACgkQ8dLMyEl6F21IiQCfQxA8kIkr4kPCeq1JLtdm0Kj/
tdEAn3HDG0swBDuAhYqMRPn1nauFFMsJ
=L//Z
-----END PGP SIGNATURE-----

--s8mcU6p0eWe5cDbiALd0AeRndCuPCMnPL--
