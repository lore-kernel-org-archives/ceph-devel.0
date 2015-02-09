From: Loic Dachary <loic@dachary.org>
Subject: Ceph bindings for go & docker
Date: Mon, 09 Feb 2015 18:15:02 +0100
Message-ID: <54D8EB16.1090801@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DkRJAvidutV3IQ9qmIeBnxgi4MwgSXMru"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41222 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932308AbbBIRPF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 12:15:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Vincent Batts <vbatts@redhat.com>, Johan Euphrosine <proppy@google.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DkRJAvidutV3IQ9qmIeBnxgi4MwgSXMru
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I discovered https://github.com/noahdesu/go-ceph today :-) It would be us=
eful in the context of a Ceph volume driver for docker ( see https://gith=
ub.com/docker/docker/issues/10661 & https://github.com/docker/docker/pull=
/8484 ).=20

Are you a docker user by any chance ?

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--DkRJAvidutV3IQ9qmIeBnxgi4MwgSXMru
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTY6xYACgkQ8dLMyEl6F23Y2gCgosv0xLwcQeLckM9fg4g4O/Ti
hqIAoJ5Re1B3/2aaqfexEmeheLFvJf9a
=4CgS
-----END PGP SIGNATURE-----

--DkRJAvidutV3IQ9qmIeBnxgi4MwgSXMru--
