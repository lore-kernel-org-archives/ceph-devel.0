From: Loic Dachary <loic@dachary.org>
Subject: FAILED assert(peer_missing.count(fromshard))
Date: Fri, 16 Jan 2015 17:39:09 +0100
Message-ID: <54B93EAD.2040200@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wWeUhGxe85ecNx1cRVwl0rbQpCk7WVL9W"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41924 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753039AbbAPQjM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 11:39:12 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wWeUhGxe85ecNx1cRVwl0rbQpCk7WVL9W
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

In the context of http://tracker.ceph.com/issues/10524 FAILED assert(peer=
_missing.count(fromshard)) I propose to add some information for when it =
happens:

https://github.com/ceph/ceph/pull/3389

If what happens really is that a bad peer ends up being added with in mis=
sing_loc.add_location, that will be a useful information. I tried a numbe=
r of scenarios and could not find the right conditions to reproduce the p=
roblem locally. Hopefully this additional information will show me where =
to go :-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--wWeUhGxe85ecNx1cRVwl0rbQpCk7WVL9W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS5Pq0ACgkQ8dLMyEl6F203AwCfTLBrI9qXxlBW27WT+79jWjnD
w/kAoJmRYmWk7QIJnEm+SM+2waXmu+ih
=Su3L
-----END PGP SIGNATURE-----

--wWeUhGxe85ecNx1cRVwl0rbQpCk7WVL9W--
