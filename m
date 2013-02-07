From: Loic Dachary <loic@dachary.org>
Subject: chain_fsetxattr extra chunk removal
Date: Thu, 07 Feb 2013 21:59:16 +0100
Message-ID: <511415A4.5050203@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2ACEA1FF6DDF7B05BC8F6200"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:51855 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757486Ab3BGU7X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 15:59:23 -0500
Received: from [10.8.0.50] (unknown [10.8.0.50])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id CD6DC26394
	for <ceph-devel@vger.kernel.org>; Thu,  7 Feb 2013 21:59:20 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2ACEA1FF6DDF7B05BC8F6200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

While writing unit tests for chain_xattr.cc I tried to understand how to =
create the conditions to trigger this part of the chain_fsetxattr functio=
n:

  /* if we're exactly at a chunk size, remove the next one (if wasn't rem=
oved
     before) */
  if (ret >=3D 0 && chunk_size =3D=3D CHAIN_XATTR_MAX_BLOCK_LEN) {
    get_raw_xattr_name(name, i, raw_name, sizeof(raw_name));
    int r =3D sys_fremovexattr(fd, raw_name);
    if (r < 0 && r !=3D -ENODATA)
      ret =3D r;
  }

I suspect this cleans up extra empty attributes created as a side effect =
of a previous version of the function. Or I just don't understand the cas=
e it addresses.

I'd very much appreciate a hint :-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig2ACEA1FF6DDF7B05BC8F6200
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEUFaQACgkQ8dLMyEl6F20PEQCgqRo1Pj34jF4QfrhJQuh2sh9E
McoAoICerM80ny07XZtraiWniJy3JGBl
=M+ST
-----END PGP SIGNATURE-----

--------------enig2ACEA1FF6DDF7B05BC8F6200--
