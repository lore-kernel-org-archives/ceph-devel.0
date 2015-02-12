From: Loic Dachary <loic@dachary.org>
Subject: documenting the shec erasure code plugin
Date: Thu, 12 Feb 2015 16:09:48 +0100
Message-ID: <54DCC23C.7030102@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fR4HAINr3OVadNr3vLKBsbbN07de8N0xA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43178 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755302AbbBLPJu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 10:09:50 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fR4HAINr3OVadNr3vLKBsbbN07de8N0xA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Would you have time to document the shec erasure code plugin ? A page sim=
ilar to http://docs.ceph.com/docs/master/rados/operations/erasure-code-is=
a/ for the shec erasure code plugin should be linked to http://docs.ceph.=
com/docs/master/rados/operations/erasure-code/. The documentation is in t=
he ceph sources ( see https://github.com/ceph/ceph/tree/master/doc/rados/=
operations ).

http://tracker.ceph.com/issues/10860=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--fR4HAINr3OVadNr3vLKBsbbN07de8N0xA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTcwjwACgkQ8dLMyEl6F21+TwCglCpE3uqDZuEi6L8j9kf3NYMT
2IgAoIA5/zuh2IXX2S1mIxKU6zZv4A4E
=CEsN
-----END PGP SIGNATURE-----

--fR4HAINr3OVadNr3vLKBsbbN07de8N0xA--
