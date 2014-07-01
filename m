From: Loic Dachary <loic@dachary.org>
Subject: teuthology erasure coded pools : warning
Date: Tue, 01 Jul 2014 09:05:35 +0200
Message-ID: <53B25DBF.9000205@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4rhiufjhuqRXJB6OwhENGIHBLgLqp891N"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33398 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751269AbaGAHFm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jul 2014 03:05:42 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id EE69E42B24
	for <ceph-devel@vger.kernel.org>; Tue,  1 Jul 2014 09:05:35 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4rhiufjhuqRXJB6OwhENGIHBLgLqp891N
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

TL;DR: if teuthology ec_pool workloads break, ping me or check https://gi=
thub.com/ceph/teuthology/pull/271 for errors

A new way of creating the erasure coded pools in teuthology was merged a =
few hours ago https://github.com/ceph/teuthology/pull/271
It has not yet been tested and should not introduce any change. But it ha=
s not been tested for real and there is room for error. There is a potent=
ial for breakage for every workload containing ec_pool: true in the yaml =
description.

The general idea of the change is to replace hardcoded parameters with er=
asure code profiles read from the yaml file, with a default profile that =
matches the former parameters defaults.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--4rhiufjhuqRXJB6OwhENGIHBLgLqp891N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOyXb8ACgkQ8dLMyEl6F201WACgwX+iq71XBcqeOP8iyaeWD57T
qjcAoJfdJtkxurtUJDMgATG67jiv/mK7
=7Gom
-----END PGP SIGNATURE-----

--4rhiufjhuqRXJB6OwhENGIHBLgLqp891N--
