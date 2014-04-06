From: Loic Dachary <loic@dachary.org>
Subject: Deterministic thrashing
Date: Sun, 06 Apr 2014 12:29:34 +0200
Message-ID: <53412C8E.2070504@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9rLeOj4Qnb0mhG63h7UH9E9kXr7ijXVI9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:37551 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbaDFK3o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Apr 2014 06:29:44 -0400
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 065E726394
	for <ceph-devel@vger.kernel.org>; Sun,  6 Apr 2014 12:29:37 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9rLeOj4Qnb0mhG63h7UH9E9kXr7ijXVI9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

It would be nice to have a way to replay the random events injected by st=
anzas such as

- thrashosds:
    chance_pgnum_grow: 2
    chance_pgpnum_fix: 1

When a teuthology workload (such as tracker.ceph.com/issues/7914#note-34)=
 crashes once a week and the error is not obvious, it would increase the =
probability to reproduce the crash. Instead of the "trashosds" we could h=
ave something like "recorded-trashosds: trashosd.events" and instead of b=
eing random they would happen more deterministically (same number of even=
ts and same number of seconds between events ?).=20

I realize this is non trivial to implement but maybe someone already thou=
ght about that and has a better idea ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--9rLeOj4Qnb0mhG63h7UH9E9kXr7ijXVI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNBLJEACgkQ8dLMyEl6F22gDwCgpD7j87DnVSThSekaVBZgd/+6
ynkAoKzJ+VUM6JSrlnzbqbea1NFmWQf7
=bgLZ
-----END PGP SIGNATURE-----

--9rLeOj4Qnb0mhG63h7UH9E9kXr7ijXVI9--
