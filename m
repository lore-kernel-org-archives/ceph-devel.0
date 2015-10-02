From: Loic Dachary <loic@dachary.org>
Subject: rbd and the next hammer release v0.94.4
Date: Fri, 02 Oct 2015 22:33:00 +0200
Message-ID: <560EE9FC.2000402@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="iOJVFphFsefHaXLLUDeKRR6Ru1pLCSeat"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36663 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750944AbbJBUdD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Oct 2015 16:33:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iOJVFphFsefHaXLLUDeKRR6Ru1pLCSeat
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Josh,

The next hammer release as found at https://github.com/ceph/ceph/tree/ham=
mer passed the rbd suite (http://tracker.ceph.com/issues/12701#note-61). =
Do you think the hammer branch is ready for QE to start their own round o=
f testing ?

Cheers

P.S. http://tracker.ceph.com/issues/12701#Release-information has direct =
links to the pull requests merged into hammer since v0.94.3 in case you n=
eed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre




















--iOJVFphFsefHaXLLUDeKRR6Ru1pLCSeat
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYO6fwACgkQ8dLMyEl6F20DKwCgkt9IZebUhoIq3jdxrKEd8AFp
K3sAn1CzR6bjfSZrcEOGOjMjGvldyV4n
=vM8+
-----END PGP SIGNATURE-----

--iOJVFphFsefHaXLLUDeKRR6Ru1pLCSeat--
