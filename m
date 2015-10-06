From: Loic Dachary <loic@dachary.org>
Subject: CephFS and the next hammer release v0.94.4
Date: Tue, 06 Oct 2015 17:16:26 +0200
Message-ID: <5613E5CA.2060903@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rvHPQeRNGJbjlQpbgpN6RMmsFOdOXAhFk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38197 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751727AbbJFPQe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Oct 2015 11:16:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rvHPQeRNGJbjlQpbgpN6RMmsFOdOXAhFk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

The next hammer release as found at https://github.com/ceph/ceph/tree/ham=
mer passed the fs suite (http://tracker.ceph.com/issues/12701#note-66). D=
o you think the hammer branch is ready for QE to start their own round of=
 testing ?

Cheers

P.S. http://tracker.ceph.com/issues/12701#Release-information has direct =
links to the pull requests merged into hammer since v0.94.3 in case you n=
eed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre





















--rvHPQeRNGJbjlQpbgpN6RMmsFOdOXAhFk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYT5coACgkQ8dLMyEl6F23WvQCfd9A/or9T1G5I9HNs2J8hP0qg
hhsAnjr+Gyf5rtFxAJlxQhlzyHCsqIV0
=pCpo
-----END PGP SIGNATURE-----

--rvHPQeRNGJbjlQpbgpN6RMmsFOdOXAhFk--
