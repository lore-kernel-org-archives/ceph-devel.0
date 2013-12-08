From: Loic Dachary <loic@dachary.org>
Subject: Forced push to master
Date: Mon, 09 Dec 2013 00:00:07 +0100
Message-ID: <52A4F9F7.8010007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hWt2P5tA8Dxu1MJdSo52KfXPgSKOJgOnA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34248 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760026Ab3LHXAK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Dec 2013 18:00:10 -0500
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 4B5BE26395
	for <ceph-devel@vger.kernel.org>; Mon,  9 Dec 2013 00:00:08 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hWt2P5tA8Dxu1MJdSo52KfXPgSKOJgOnA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I accidentally forced push to ceph master at 11pm CEST 8 december 2013 th=
e following:

https://github.com/ceph/ceph/commit/17e0a7b2942899e3f4307bf3e9c41bcb43046=
19d
https://github.com/ceph/ceph/commit/d5e44cf8b233e517d8f7f26cd556ad0ac1571=
4c1
https://github.com/ceph/ceph/commit/71f820503a96cafa9e99cca047c3183c37540=
8a8
https://github.com/ceph/ceph/commit/eefeb0e0ad54fe0179cbf71335a45ea17c0fa=
23b
https://github.com/ceph/ceph/commit/8253ff1e0b3b3a1680293c75f015a5cf5f5e3=
4c6

and may have discarded commits done after:

https://github.com/ceph/ceph/commit/94da2153d1e131205c0e5e32601d0b6a9f6a3=
cfd

which is a merge dated

Date:   Sat Dec 7 20:59:22 2013 -0800

I apologize for the inconvenience and trying to figure out more.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--hWt2P5tA8Dxu1MJdSo52KfXPgSKOJgOnA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKk+fgACgkQ8dLMyEl6F20QJACgjUKrWyvI9pDdKvhiZw/U2+qT
e1UAnj7fcBHDq1UpzEIGu0PC+FowNN2X
=SPAu
-----END PGP SIGNATURE-----

--hWt2P5tA8Dxu1MJdSo52KfXPgSKOJgOnA--
