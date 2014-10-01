From: Loic Dachary <loic@dachary.org>
Subject: New Ceph submodule : ceph-erasure-code-corpus
Date: Wed, 01 Oct 2014 22:06:22 +0200
Message-ID: <542C5EBE.3010609@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RNlvmr0mCWivGjKapuUhAaT2BhPVkAD9g"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36094 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751005AbaJAUG2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Oct 2014 16:06:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sandon Van Ness <sandon@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RNlvmr0mCWivGjKapuUhAaT2BhPVkAD9g
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sandon,

A new submodule is going to be added to the ceph repository

   https://github.com/ceph/ceph-erasure-code-corpus

as can be seen in the corresponding pull request

   https://github.com/ceph/ceph/pull/2480/files

This is the one I told you about: it will grow by ~100MB (raw, much less =
compressed) for every Ceph release. For the gitbuilders to run properly, =
an update has been made to cleanup the leftovers to get a clean clone

   https://github.com/ceph/autobuild-ceph/pull/18/files

Unless I forgot something, the last step is that a mirror is added so the=
 gitbuilders do not need to get the repository from the net every time. I=
s that correct ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--RNlvmr0mCWivGjKapuUhAaT2BhPVkAD9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQsXr4ACgkQ8dLMyEl6F20YKQCfQyfA5STYa9chdmFPP6hogiFY
jtIAn24XL0rruu3xmBq++ywpm4WS6ujO
=nmXA
-----END PGP SIGNATURE-----

--RNlvmr0mCWivGjKapuUhAaT2BhPVkAD9g--
