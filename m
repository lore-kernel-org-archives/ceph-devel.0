From: Loic Dachary <loic@dachary.org>
Subject: Ceph & ZeroVM
Date: Thu, 07 Nov 2013 19:33:37 +0800
Message-ID: <527B7A91.3080408@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="25C1HEXUhxlna4vi3D63H1nPlKcxQUmOq"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:58816 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab3KGPHw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 10:07:52 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sergei@litestack.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--25C1HEXUhxlna4vi3D63H1nPlKcxQUmOq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

HI Sergei,

I'm thinking ZeroVM could be run by a rados class. Let say there is a Zer=
oVM aware class on each host running OSDs, the user could run it and prov=
ide a "channel" to access the object. The channel would use the rados cla=
ss API, if at all possible.

Cheers

P.S. quickly written in the bus to not forget about it before getting dru=
nk in Hong Kong ;-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre



--25C1HEXUhxlna4vi3D63H1nPlKcxQUmOq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJ7epEACgkQ8dLMyEl6F22yJQCfXDXHulFCo2aLSYbFwypW9Bhp
R20AnA+Wyc+HqPI8SmeYlbZD2zd4o7oA
=7CJP
-----END PGP SIGNATURE-----

--25C1HEXUhxlna4vi3D63H1nPlKcxQUmOq--
