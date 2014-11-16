From: Loic Dachary <loic@dachary.org>
Subject: Bad python code : any advice ?
Date: Sun, 16 Nov 2014 21:15:09 +0100
Message-ID: <546905CD.6060104@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pG5fjbQOOkwCg0wb1XXm9CDeRQd2MKPOd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37833 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750837AbaKPUPM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Nov 2014 15:15:12 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Stinner <victor.stinner@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pG5fjbQOOkwCg0wb1XXm9CDeRQd2MKPOd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Victor,

This week-end I wrote what I suspect to be bad python code

https://github.com/dachary/teuthology/compare/wip-container#diff-24f45fc6=
782fb342bf422033c01e1b06R37

and I would very much like your opinion. What I really want is a FIFO of =
shell commands. When the caller submits a new command, it returns immedia=
tely if wait=3DFalse or waits for it to complete if wait=3DTrue. In case =
wait=3DFalse, the caller can call command.wait() later on to pause until =
the command is complete. It's a very simple pattern and I feel my impleme=
ntation is contorted.

What do you think ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--pG5fjbQOOkwCg0wb1XXm9CDeRQd2MKPOd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRpBc4ACgkQ8dLMyEl6F23k0ACeLjo1rHiKR6TDNV9baNwMgP9I
9O0AoJgWA3ri5dHGc1c8yDAfIi2u7yiZ
=cfGS
-----END PGP SIGNATURE-----

--pG5fjbQOOkwCg0wb1XXm9CDeRQd2MKPOd--
