From: Loic Dachary <loic@dachary.org>
Subject: preparing the release notes for the next giant v0.87.2
Date: Mon, 23 Mar 2015 02:03:08 +0100
Message-ID: <550F664C.6060202@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="95C9vkwFwa07lFOT0O1AuFx7hIDuctOcD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34659 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751967AbbCWBDL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Mar 2015 21:03:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--95C9vkwFwa07lFOT0O1AuFx7hIDuctOcD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

Abhishek and I are working on the next (and last) giant release (v0.87.2)=
 and it occured to me that we could help with the release notes. Do you h=
ave some kind of script to match the issue numbers with the commits ? The=
 other item we could work on are the user visible changes, for instance b=
y making a pull request to the release notes with something like

  "issue title here" (#number)

  User visible change that people would be happy to read about
  in a non developper language.

What do you think ?=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--95C9vkwFwa07lFOT0O1AuFx7hIDuctOcD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUPZkwACgkQ8dLMyEl6F23wPACgo/aNJ1ma1PYiaDthCMg8h7dI
bNsAoIauk4LQgUn3O9K+aBzYQkFEf+jh
=q0Ix
-----END PGP SIGNATURE-----

--95C9vkwFwa07lFOT0O1AuFx7hIDuctOcD--
