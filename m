From: Loic Dachary <loic@dachary.org>
Subject: Buffer alignment
Date: Tue, 10 Dec 2013 09:32:52 +0100
Message-ID: <52A6D1B4.1010503@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bfWadtMQdfbLPwBBEnXUr3hLmv7ncI3nH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:35720 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522Ab3LJIcy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Dec 2013 03:32:54 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bfWadtMQdfbLPwBBEnXUr3hLmv7ncI3nH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

In Ceph, buffers can be aligned if required using buffer::create_page_ali=
gned

https://github.com/ceph/ceph/blob/master/src/common/buffer.cc#L519
https://github.com/ceph/ceph/blob/master/src/common/buffer.cc#L230

and although the Jerasure plugin has alignment requirements

https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodePluginJerasur=
e/ErasureCodeJerasure.cc#L79

it did not occur to me that aligning the buffers used to stored the encod=
ed=20

https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodePluginJerasur=
e/ErasureCodeJerasure.cc#L87

result would be needed. For decoding the caller is responsible for alloca=
ting the buffers. For encoding it also is, except for the padding.=20

Do you think the API should recommend something regarding alignment ?=20

https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodeInterface.h#L=
20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--bfWadtMQdfbLPwBBEnXUr3hLmv7ncI3nH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKm0bQACgkQ8dLMyEl6F214hQCfU1XBRjviUpiivGHkBHv76q2h
8TgAn1zugn81QCjF0Fob4kKXG0pXSq/C
=yby6
-----END PGP SIGNATURE-----

--bfWadtMQdfbLPwBBEnXUr3hLmv7ncI3nH--
