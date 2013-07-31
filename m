From: Loic Dachary <loic@dachary.org>
Subject: blueprint : erasure code
Date: Wed, 31 Jul 2013 02:00:32 +0200
Message-ID: <51F853A0.6060906@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig03009414DF4DE854991FBD72"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:42361 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106Ab3GaAAe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 20:00:34 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id D069826396
	for <ceph-devel@vger.kernel.org>; Wed, 31 Jul 2013 02:00:32 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03009414DF4DE854991FBD72
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I submitted a blueprint about the current status of the erasure coded poo=
l implementation. As of now there still is a lot of work to be done to re=
factor PG and ReplicatedPG but Samuel Just found the right way to do it, =
not too long ago. In a nutshell a PGBackend base class from which Replica=
tedPG would derive instead of PG (this is explained in more details in th=
e blueprint). The recovery state machine won't have to be factored out ( =
which is a good news because it gave me a hard time ;).

Although most tasks require an intimate knowledge of the OSD internals, t=
he implementation of the erasure code plugin system is relatively indepen=
dent and is an area where anyone willing to join the effort could quickly=
 do a lot of good.

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Erasure_coded_storag=
e_backend_%28step_2%29

The blueprints preparing the way to automatic tiering such as object redi=
rection complement the erasure code blueprint. A versatile and efficient =
( but disk consuming ) replicated pool where objects could be transparent=
ly demoted to a write once and slower ( but using less disk ) erasure cod=
ed pool would offer the best of both worlds.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig03009414DF4DE854991FBD72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlH4U6AACgkQ8dLMyEl6F22bLwCeK1f43z9S+DoclfHzNzMcIAef
KMYAmgISDNsC2E+WwVzz6+UmrVzbUqJr
=LN3R
-----END PGP SIGNATURE-----

--------------enig03009414DF4DE854991FBD72--
