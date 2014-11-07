From: Loic Dachary <loic@dachary.org>
Subject: erasure code software and papers and swift
Date: Fri, 07 Nov 2014 04:08:41 +0100
Message-ID: <545C37B9.9000505@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qqb6VqM93DX1jQFToB48XwaOBUssWlEmj"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60754 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751142AbaKGDIu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Nov 2014 22:08:50 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Kevin Greenan <kmgreen2@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qqb6VqM93DX1jQFToB48XwaOBUssWlEmj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

For the record, here are a few erasure code related links (thanks Kevin :=
-),=20

   https://bitbucket.org/tsg-/liberasurecode/
   liberasurecode is an Erasure Code API library written in C with plugga=
ble Erasure Code backends.

the first commit is dated back april 2014 but its content suggests develo=
pment happened elsewhere before that.=20

It is the equivalent of a standalone=20

    https://github.com/ceph/ceph/tree/master/src/erasure-code

Only with dynamically loaded jerasure/isa instead of an embedded copy. Th=
e idea of an external general purpose erasure code library is appealing. =
It would lower the maintenance effort, among other things. It's nice to s=
ee that Ceph is listed as a contributor in the readme. There is no commit=
 to date in the liberasurecode library itself but that can be fixed ;-)

liberasurecode is already used as a dependency of https://bitbucket.org/k=
mgreen2/pyeclib , the library swift depends on for erasure coded storage =
policies.

And some interesting papers:

    Simple Regenerating Codes: http://arxiv.org/pdf/1109.0264v1.pdf

    LT Codes: http://en.wikipedia.org/wiki/Luby_transform_code

    Rateless codes and downloads: http://www.iptps.org/papers-2003/ratele=
ss_codes.pdf

Yesterday I attended Paul Luse presentation of the erasure code implement=
ation in swift and it was enlightening. Very much like Samuel Just did in=
 Ceph when he introduced the Placement Groups backends, Paul worked on Sw=
ift Storage Policies to make room for erasure coded "rings" (pools in the=
 swift parlance, if I'm not mistaken).

http://docs-draft.openstack.org/90/125190/8/gate/gate-swift-specs-docs/2d=
2cf67/doc/build/html/specs/swift/erasure_coding.html

It looks like erasure code will be available in swift soon and the hard p=
art of the work is complete.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--qqb6VqM93DX1jQFToB48XwaOBUssWlEmj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRcN7kACgkQ8dLMyEl6F23SewCfZ8jy/UAHIjRWdzo/eV9ebzbH
B50An2HeCI0b31M9x+vx9788F1FaYPHv
=JJ+5
-----END PGP SIGNATURE-----

--qqb6VqM93DX1jQFToB48XwaOBUssWlEmj--
