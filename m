From: Loic Dachary <loic@dachary.org>
Subject: ObjectContext & PGRegistry API
Date: Mon, 22 Jul 2013 22:33:03 +0200
Message-ID: <51ED96FF.4030606@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4F02EC9BB776E587F04F9968"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:60162 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab3GVUdH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jul 2013 16:33:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F02EC9BB776E587F04F9968
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

Here is the proposed ObjectContext & PGRegistry API:

https://github.com/dachary/ceph/blob/wip-5487/src/osd/PGRegistry.h

which is part of the following commit

https://github.com/dachary/ceph/commit/60958095585a1f8392d8a967767f762008=
9d547d

It's a first draft and I asume your comments will require significant
work on my part. I'd rather do it as soon as possible, while my short
term memory is still fresh ;-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig4F02EC9BB776E587F04F9968
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHtlv8ACgkQ8dLMyEl6F22dFQCfYouVvNfi83RlqvS0Twhx6YQl
nJYAnj260aUXPX0xqVi8ppcGm2FB5N5M
=kNPN
-----END PGP SIGNATURE-----

--------------enig4F02EC9BB776E587F04F9968--
