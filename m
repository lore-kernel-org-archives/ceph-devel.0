From: Loic Dachary <loic@dachary.org>
Subject: bug with cache/tiering and snapshot reads
Date: Wed, 09 Sep 2015 01:18:23 +0200
Message-ID: <55EF6CBF.4090703@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Jl2iQkwmBc2Or1qpRxl5h0v9rcSEMFGPO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52036 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752264AbbIHXS1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 19:18:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jl2iQkwmBc2Or1qpRxl5h0v9rcSEMFGPO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Does "bug with cache/tiering and snapshot reads" http://tracker.ceph.com/=
issues/12748 sound familiar to you ? Although it looks like a tiering pro=
blem, it involves rbd and maybe it rings a bell ? If not, don't worry abo=
ut it and I'll dig further: I can repeat it every time using the script f=
rom the description. I kind of remember something similar but it involved=
 erasure coded pools and is probably different.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Jl2iQkwmBc2Or1qpRxl5h0v9rcSEMFGPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXvbL8ACgkQ8dLMyEl6F22fNwCgxsFScXutMkP68C7pO+oJ65wy
bJQAoK9WT8aWhvKAVKcvd3E1HmBjmvCT
=pKV0
-----END PGP SIGNATURE-----

--Jl2iQkwmBc2Or1qpRxl5h0v9rcSEMFGPO--
