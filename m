From: Loic Dachary <loic@dachary.org>
Subject: Re: PG Backend Proposal
Date: Mon, 05 Aug 2013 16:18:01 +0200
Message-ID: <51FFB419.3010903@dachary.org>
References: <51FA8FF7.7090004@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig058C31A1500FCB7E166AF66D"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:43059 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab3HEOSE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 10:18:04 -0400
In-Reply-To: <51FA8FF7.7090004@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig058C31A1500FCB7E166AF66D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

In case you don't get notified, I proposed a few changes to your erasure_=
coding document. Basically links to the tickets you created last friday.

https://github.com/ceph/ceph/pull/482

I also reworked the coding tasks of the blueprint

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Erasure_coded_storag=
e_backend_%28step_2%29

to also link to them.=20

It would be convenient if=20

https://github.com/ceph/ceph/blob/wip-erasure-coding-doc/doc/dev/osd_inte=
rnals/erasure_coding.rst

was in master instead of a branch to create permalinks that will survive =
the deletion of this branch.=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig058C31A1500FCB7E166AF66D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlH/tBkACgkQ8dLMyEl6F20rcQCdGpIcIbi+UR9AihqnmBQrD82H
FvcAoIpPIPx/Yi4CCThwYHJchfCWJqbj
=dNFx
-----END PGP SIGNATURE-----

--------------enig058C31A1500FCB7E166AF66D--
