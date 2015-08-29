From: Loic Dachary <loic@dachary.org>
Subject: Bootstraping Infernalis backports
Date: Sat, 29 Aug 2015 19:47:20 +0200
Message-ID: <55E1F028.9050700@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EnintDSIKSUoH30od8lfkGWCbTxg0D4ld"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45970 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752714AbbH2RrW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Aug 2015 13:47:22 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 84A7842B2B
	for <ceph-devel@vger.kernel.org>; Sat, 29 Aug 2015 19:47:20 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EnintDSIKSUoH30od8lfkGWCbTxg0D4ld
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Since the infernalis branch has been created, it is time to bootstrap bac=
kports. I followed the steps documented at hhttp://tracker.ceph.com/proje=
cts/ceph-releases/wiki/HOWTO_start_backporting_a_stable_release#Add-a-new=
-release-in-redmine and here is what's new:

* infernalis added to the custom field "release" (and move dumpling / emp=
eror to the end because they are used less often)
* Custom search=20
  * Backport: infernalis http://tracker.ceph.com/projects/ceph/issues?que=
ry_id=3D82
  * Backport: infernalis (pending) http://tracker.ceph.com/projects/ceph/=
issues?query_id=3D83
* Infernalis release (shared with subprojects) http://tracker.ceph.com/rb=
/release/10
* HOWTO updated with the links above http://tracker.ceph.com/projects/cep=
h-releases/wiki/HOWTO#Overview-of-the-backports-in-progress

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--EnintDSIKSUoH30od8lfkGWCbTxg0D4ld
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXh8CgACgkQ8dLMyEl6F20wxQCePzGpqYKjaSTkl85yp/mMmPdI
HnkAn2+RL+Lxjpr3jZbONXQrneFSZtK/
=xKza
-----END PGP SIGNATURE-----

--EnintDSIKSUoH30od8lfkGWCbTxg0D4ld--
