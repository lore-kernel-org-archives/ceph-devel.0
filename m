From: Loic Dachary <loic@dachary.org>
Subject: rados and the next dumpling release
Date: Thu, 05 Feb 2015 23:36:48 +0100
Message-ID: <54D3F080.1070808@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LEGAI6sILVrtA7bPI1FGgcF7GI0FjOn7v"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39500 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751079AbbBEWgv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Feb 2015 17:36:51 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LEGAI6sILVrtA7bPI1FGgcF7GI0FjOn7v
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

The rados teuthology suite for the next dumpling release as found in http=
s://github.com/ceph/ceph/commits/dumpling-backports came back green http:=
//pulpito.ceph.com/loic-2015-02-03_14:41:24-rados-dumpling-backports---ba=
sic-multi/. Do you think it is ready for QE to start their own round of t=
esting ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--LEGAI6sILVrtA7bPI1FGgcF7GI0FjOn7v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTT8IAACgkQ8dLMyEl6F214aQCffvap8B/i3sE5ymeKlGqYOXG0
158AnRDNcGlc6hno/qzDAlhinh4XXPiA
=nT9O
-----END PGP SIGNATURE-----

--LEGAI6sILVrtA7bPI1FGgcF7GI0FjOn7v--
