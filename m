From: Loic Dachary <loic@dachary.org>
Subject: Paxos vs Raft
Date: Sat, 14 Sep 2013 08:39:25 +0200
Message-ID: <5234049D.1080800@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig94E2F5EAA00C0C6FBB029729"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34515 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab3INGj2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Sep 2013 02:39:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: lamport@microsoft.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig94E2F5EAA00C0C6FBB029729
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Ceph ( http://ceph.com/ ) relies on a custom implementation of Paxos to p=
rovide exabyte scale distributed storage. Like most people recently expos=
ed to Paxos, I struggle to understand it ... but will keep studying until=
 I get it :-) When a friend mentionned Raft (  http://en.wikipedia.org/wi=
ki/Raft_%28computer_science%29 ), it looked like an easy way out. But it'=
s very recent and I would very much appreciate your opinion. Do you think=
 it is a viable alternative to Paxos ?=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig94E2F5EAA00C0C6FBB029729
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlI0BJ0ACgkQ8dLMyEl6F2045gCfXdo1ETRqHZDpqGuTgdmId4vp
MTEAnRHKJTWJQrjhE81GAw0+kcQ6GRzo
=Oc1+
-----END PGP SIGNATURE-----

--------------enig94E2F5EAA00C0C6FBB029729--
