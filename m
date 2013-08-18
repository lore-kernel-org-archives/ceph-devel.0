From: Loic Dachary <loic@dachary.org>
Subject: Review request : Erasure Code plugin loader implementation
Date: Sun, 18 Aug 2013 18:19:53 +0200
Message-ID: <5210F429.2020805@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE4C76E7D3FD7B6B847A5F3F9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:53958 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986Ab3HRQT4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Aug 2013 12:19:56 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 13D6826394
	for <ceph-devel@vger.kernel.org>; Sun, 18 Aug 2013 18:19:54 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE4C76E7D3FD7B6B847A5F3F9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

I've implemented a draft of the Erasure Code plugin loader in the context=
 of http://tracker.ceph.com/issues/5878. It has a trivial unit test and a=
n example plugin. It would be great if someone could do a quick review. T=
he general idea is that the erasure code pool calls something like:

ErasureCodePlugin::factory(&erasure_code, "example", parameters)

as shown at

https://github.com/ceph/ceph/blob/5a2b1d66ae17b78addc14fee68c73985412f3c8=
c/src/test/osd/TestErasureCode.cc#L28

to get an object implementing the interface

https://github.com/ceph/ceph/blob/5a2b1d66ae17b78addc14fee68c73985412f3c8=
c/src/osd/ErasureCodeInterface.h

which matches the proposal described at

https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/erasu=
re-code.rst#erasure-code-library-abstract-api

The draft is at

https://github.com/ceph/ceph/commit/5a2b1d66ae17b78addc14fee68c73985412f3=
c8c

Thanks in advance :-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigE4C76E7D3FD7B6B847A5F3F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIQ9CkACgkQ8dLMyEl6F23OcgCfXGSx1D5AT9Rq+1H9axkwn0y2
cR8AmwaOUbTrJmu97fZDdIBNeeM/QkgU
=qAdy
-----END PGP SIGNATURE-----

--------------enigE4C76E7D3FD7B6B847A5F3F9--
