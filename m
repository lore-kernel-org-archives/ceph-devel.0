From: Loic Dachary <loic@dachary.org>
Subject: CephFS and the next firefly release
Date: Sat, 28 Feb 2015 15:18:51 +0100
Message-ID: <54F1CE4B.5020004@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CVas8n6VLMfjLfEKKQesTn45KEkla5w5M"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50558 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752383AbbB1OSx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Feb 2015 09:18:53 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CVas8n6VLMfjLfEKKQesTn45KEkla5w5M
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

The fs teuthology suite for the next firefly release as found in https://=
github.com/ceph/ceph/commits/firefly-backports came back with three failu=
res : http://tracker.ceph.com/issues/10641#fs. Do you think it is ready f=
or QE to start their own round of testing ?

Cheers

P.S. I'll include the fs suite as part of the pre-QE round of testing fro=
m now on, unless you think it is redundant or not useful.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre






--CVas8n6VLMfjLfEKKQesTn45KEkla5w5M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTxzksACgkQ8dLMyEl6F21TLQCgiO1owDfJTUz0ukij5P3sG5go
ZQIAn3wqQWGiwV7gUKBJZPtZlhCBLYpt
=tw2R
-----END PGP SIGNATURE-----

--CVas8n6VLMfjLfEKKQesTn45KEkla5w5M--
