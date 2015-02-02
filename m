From: Loic Dachary <loic@dachary.org>
Subject: dumpling & giant backports update
Date: Tue, 03 Feb 2015 00:09:43 +0100
Message-ID: <54D003B7.3090509@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wqqVa2JO5X2t5vBw80g4VPH6pkmk5GjJe"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51542 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933622AbbBBXJp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Feb 2015 18:09:45 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wqqVa2JO5X2t5vBw80g4VPH6pkmk5GjJe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

There is one remaining issue in the dumpling backports (the details are h=
ere http://tracker.ceph.com/issues/10560).

The giant integration branch has been updated today with all the pending =
pull requests (rgw in particular) and the rbd, rados and rgw suites sched=
uled (the details are here http://tracker.ceph.com/issues/10501). I'll an=
alyze the result as soon as one of them finishes. The previous run was go=
od and I'm hopeful the additional backports won't create unexpected diffi=
culties.

Cheers

P.S. I moved the branches inventory to a wiki updatable via git to save t=
he tedious copy / paste. There are here now : http://workbench.dachary.or=
g/ceph/ceph-backports/wikis/pages

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--wqqVa2JO5X2t5vBw80g4VPH6pkmk5GjJe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTQA7cACgkQ8dLMyEl6F201GgCcD4fT74jtBZ140KMPNLnKBenx
CfcAniTGZGIi8gPvG0P7MX5uhAAI0MJf
=G28L
-----END PGP SIGNATURE-----

--wqqVa2JO5X2t5vBw80g4VPH6pkmk5GjJe--
