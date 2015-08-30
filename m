From: Loic Dachary <loic@dachary.org>
Subject: [Backports] updating the release field
Date: Sun, 30 Aug 2015 14:02:49 +0200
Message-ID: <55E2F0E9.5080204@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6dXsN1Sm9FxW4M5VFeQFKnacU85xcnmD7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46196 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753324AbbH3MCy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Aug 2015 08:02:54 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6dXsN1Sm9FxW4M5VFeQFKnacU85xcnmD7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I created a custom search to find the resolved backports that are missing=
 a release field value. It found a few and they are now updated. I've add=
ed it to our recurring duties at:

http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO#Recurring-dutie=
s-expected-from-backporters

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--6dXsN1Sm9FxW4M5VFeQFKnacU85xcnmD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXi8OkACgkQ8dLMyEl6F23PFACeNiS3Tp7FhczdtxbmOKVvF7yT
ozEAoJYO+iSkhLFVrciDesZNayGqerFI
=o4Q8
-----END PGP SIGNATURE-----

--6dXsN1Sm9FxW4M5VFeQFKnacU85xcnmD7--
