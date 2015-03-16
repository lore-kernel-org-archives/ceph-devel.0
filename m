From: Loic Dachary <loic@dachary.org>
Subject: Firefly v0.80.10 backports (rados)
Date: Mon, 16 Mar 2015 14:52:59 +0100
Message-ID: <5506E03B.8090808@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="iLnHpAHfa3gbsWqMAErvFpOppRClhwMLm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58752 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753655AbbCPNxB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Mar 2015 09:53:01 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iLnHpAHfa3gbsWqMAErvFpOppRClhwMLm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I backported 23 issues [1] related to rados/core. They passed the rados s=
uite on xfs [2] (btrfs and ext4 were excluded to reduce the number of tes=
ts). Could you please take a look ? Although they did not disrupt the sui=
te, it is entirely possible that some of them are wrong because I do not =
fully understand the context.

Cheers

[1] https://github.com/ceph/ceph/pulls?q=3Dis%3Aopen+is%3Apr+milestone%3A=
firefly+sort%3Aupdated-desc+label%3Acore+author%3Adachary
[2] http://tracker.ceph.com/issues/11090#rados

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--iLnHpAHfa3gbsWqMAErvFpOppRClhwMLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUG4DsACgkQ8dLMyEl6F22GvwCeLMBeCNlhIkfrnf0xCPKBf3YG
UoMAn3UZ6wgm6jyEzBlLU+6lBz0sbnTT
=yILF
-----END PGP SIGNATURE-----

--iLnHpAHfa3gbsWqMAErvFpOppRClhwMLm--
