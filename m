From: Loic Dachary <loic@dachary.org>
Subject: Separating Peering from PG
Date: Fri, 21 Jun 2013 15:37:19 +0200
Message-ID: <51C4570F.70206@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFA9B903C85757B4563801A54"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:41962 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161061Ab3FUNhV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jun 2013 09:37:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA9B903C85757B4563801A54
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

In order to move the PG peering code out of PG.{cc,h} (which is the next =
step in refactoring PGs as suggested by Sam http://pad.ceph.com/p/Erasure=
_encoding_as_a_storage_backend ) I think it would be sensible to:

* Move PG::RecoveryStats in PGRecoveryStat.{cc,h}
* Create PGInterface : an abstract base class for PG enumerating all PG m=
ethods used by PGRecoveryStats
* Move Peering states / methods out of PGRecoveryStat.{cc,h} and into PGP=
eering.{cc,h}=20
* Write tests for PGPeering.{cc,h}, using a fixture derived from PGInterf=
ace

Because this approach not only moves the peering out of PG.{cc,h} but als=
o the rest of the state logic, I would like to know if this seems sensibl=
e to you. Also, introducing an abstract base class to help isolate the PG=
 interface and facilitate writing fixtures has not been discussed yet.=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigFA9B903C85757B4563801A54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHEVw8ACgkQ8dLMyEl6F22SYQCfZF+QgtWRMT8vMK1qDQT8sSDm
NwwAn0pVd4AhSkIIr5LJj5TcNe3k0owC
=jat3
-----END PGP SIGNATURE-----

--------------enigFA9B903C85757B4563801A54--
