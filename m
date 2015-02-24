From: Loic Dachary <loic@dachary.org>
Subject: dumpling branch for v0.67.12 is ready for release
Date: Tue, 24 Feb 2015 18:10:06 +0100
Message-ID: <54ECB06E.9020507@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="e2FH7IJC87xwp74gmrQVOcxmfpJbjHXPK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48251 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752336AbbBXRKM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 12:10:12 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 912924210B
	for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2015 18:10:06 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e2FH7IJC87xwp74gmrQVOcxmfpJbjHXPK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

QE approved https://github.com/ceph/ceph/commit/77dfbbaccfb5074899d02314a=
26cb9ac46a69106 for release in the https://github.com/ceph/ceph/commits/d=
umpling branch. The release notes should now be written based on the cont=
ent of the issues and pull requests mentioned here http://workbench.dacha=
ry.org/ceph/ceph-backports/wikis/dumpling#already-merged

The release notes can now be written. In the future I'll ask about the re=
lease notes earlier: the last tests do not change anything significant an=
d take days if not week. They can conveniently be done while the release =
notes are written[1] instead of making them a blocker at the very end.=20

Cheers

[1] Cutting a new stable release http://ceph.com/docs/master/dev/developm=
ent-workflow/#cutting-a-new-stable-release

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre



--e2FH7IJC87xwp74gmrQVOcxmfpJbjHXPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTssG4ACgkQ8dLMyEl6F22aNACgic+ChhTMZWWmnyUkFglhQjvU
CBgAnjE5avvvVoNBtjAGrhx0AS15WWDZ
=yer3
-----END PGP SIGNATURE-----

--e2FH7IJC87xwp74gmrQVOcxmfpJbjHXPK--
