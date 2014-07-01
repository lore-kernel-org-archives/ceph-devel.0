From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology erasure coded pools : warning
Date: Tue, 01 Jul 2014 12:54:00 +0200
Message-ID: <53B29348.6050306@dachary.org>
References: <53B25DBF.9000205@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NetiQVkeCJk2A9ndCQVLEbpaHRxmEXhvw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33641 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756670AbaGAKyH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jul 2014 06:54:07 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 4E198420A6
	for <ceph-devel@vger.kernel.org>; Tue,  1 Jul 2014 12:54:00 +0200 (CEST)
In-Reply-To: <53B25DBF.9000205@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NetiQVkeCJk2A9ndCQVLEbpaHRxmEXhvw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

After some manual testing, it needs https://github.com/ceph/teuthology/pu=
ll/277 to run. If not applied existing ec_pool workloads will fail.

On 01/07/2014 09:05, Loic Dachary wrote:
> Hi,
>=20
> TL;DR: if teuthology ec_pool workloads break, ping me or check https://=
github.com/ceph/teuthology/pull/271 for errors
>=20
> A new way of creating the erasure coded pools in teuthology was merged =
a few hours ago https://github.com/ceph/teuthology/pull/271
> It has not yet been tested and should not introduce any change. But it =
has not been tested for real and there is room for error. There is a pote=
ntial for breakage for every workload containing ec_pool: true in the yam=
l description.
>=20
> The general idea of the change is to replace hardcoded parameters with =
erasure code profiles read from the yaml file, with a default profile tha=
t matches the former parameters defaults.
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--NetiQVkeCJk2A9ndCQVLEbpaHRxmEXhvw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOyk0gACgkQ8dLMyEl6F21mvQCfVx+MUzjH/o5YeSV12DI6h24m
6gkAoIGQUt056aS8O1nCjrhuv2dX8XN9
=wY87
-----END PGP SIGNATURE-----

--NetiQVkeCJk2A9ndCQVLEbpaHRxmEXhvw--
