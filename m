From: Jonathan Dieter <jdieter@lesbg.com>
Subject: POSIX ACL support?
Date: Mon, 05 Jul 2010 20:35:13 +0300
Message-ID: <1278351313.2552.26.camel@jdlaptop.lesbg.loc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-I9zKB7xecI8MMyI+Krga"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56555 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab0GERnZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jul 2010 13:43:25 -0400
Received: by ewy23 with SMTP id 23so1657935ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jul 2010 10:43:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--=-I9zKB7xecI8MMyI+Krga
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is there POSIX ACL support in ceph?  If not, what needs to be done to
get it added?  I've set up a test system using Fedora 13 + a Rawhide
2.6.34.1-rc1 kernel, and copying files is working fine, but setting ACLs
gives me an "Operation not supported" error message.

Jonathan

--=-I9zKB7xecI8MMyI+Krga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkwyF9EACgkQH3CnpFdSY1z/TwCeN4H6l53BMK2qqS0BZaEJG/ik
f8sAoMLkcQ0wl2zvh9+V6IuGJ08nDFJK
=Fz5N
-----END PGP SIGNATURE-----

--=-I9zKB7xecI8MMyI+Krga--

