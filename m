From: Loic Dachary <loic@dachary.org>
Subject: timeout 120 teuthology-killl is highly recommended
Date: Tue, 21 Jul 2015 18:13:04 +0200
Message-ID: <55AE6F90.3070503@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3IBI4od2C8DEUeWxUqRKWI73ClDugvsWV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53771 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933056AbbGUQNH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 12:13:07 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 91E5A42B46
	for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 18:13:04 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3IBI4od2C8DEUeWxUqRKWI73ClDugvsWV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Today I did something wrong and that blocked the lab for a good half hour=
=2E=20

a) I ran two teuthology-kill simultaneously and that makes them deadlock =
each other
b) I let them run unattended only to come back to the terminal 30 minutes=
 later and see them stuck.

Sure, two teuthology-kill simultaneously should not deadlock and that nee=
ds to be fixed. But the easy workaround to avoid that trouble is to just =
not let it run forever. Even for ~200 jobs it takes at most a minute or t=
wo. And if it takes longer it probably means another teuthology-kill comp=
etes and it should be interrupted and restarted later. From now on I'll d=
o

timeout 120 teuthology-kill .... || echo FAIL!

as a generic safeguard.

Apologies for the troubles.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--3IBI4od2C8DEUeWxUqRKWI73ClDugvsWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWub5AACgkQ8dLMyEl6F22qHQCdGkQo7e/Nzgfomwb7csyOip2l
z0IAoLM2Ta0TzzvTjvP1m9mtUqho1jee
=P/Je
-----END PGP SIGNATURE-----

--3IBI4od2C8DEUeWxUqRKWI73ClDugvsWV--
