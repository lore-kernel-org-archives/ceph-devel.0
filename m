From: Loic Dachary <loic@dachary.org>
Subject: make check bot silent today
Date: Tue, 28 Apr 2015 00:36:32 +0200
Message-ID: <553EB9F0.9070700@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="v748ERpltp0mKFPpLadqNdWkoHCs1mhni"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53506 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965143AbbD0Wge (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 18:36:34 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id BC31042B23
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 00:36:32 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v748ERpltp0mKFPpLadqNdWkoHCs1mhni
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Although the make check bot worked on today's pull requests ( http://jenk=
ins.ceph.dachary.org/job/ceph/ ), it did not report results back to the c=
orresponding pull request. You can find the results by looking at individ=
ual builds (for instance http://jenkins.ceph.dachary.org/job/ceph/1828/ s=
hows it is about origin/pull/4472 which matches pull request https://gith=
ub.com/ceph/ceph/pull/4472). If you don't feel like digging in the jenkin=
s log, rebasing and force-pushing the pull request will trigger the bot.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--v748ERpltp0mKFPpLadqNdWkoHCs1mhni
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlU+ufAACgkQ8dLMyEl6F21XnwCgkEZ0qjh17jQvL2rS2Zp5LV/p
4y8Anjmb/ZOKW8uoM7/kkouHHH9xRr52
=zwyl
-----END PGP SIGNATURE-----

--v748ERpltp0mKFPpLadqNdWkoHCs1mhni--
