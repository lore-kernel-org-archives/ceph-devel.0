From: Loic Dachary <loic@dachary.org>
Subject: bloom filters
Date: Fri, 16 May 2014 22:28:10 -0400
Message-ID: <5376C93A.1050203@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bxkIVRqLKBh1Clc2cbxaLWCHns9bTqu30"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:39724 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042AbaEQC2N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 May 2014 22:28:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sahid Ferdjaoui <sahid.ferdjaoui@cloudwatt.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bxkIVRqLKBh1Clc2cbxaLWCHns9bTqu30
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sahid,

Here are the files implementing the bloom filter we discussed tonight

  https://github.com/ceph/ceph/blob/master/src/common/bloom_filter.hpp
  https://github.com/ceph/ceph/blob/master/src/common/bloom_filter.cc

and the associated unit tests

  https://github.com/ceph/ceph/blob/master/src/test/common/test_bloom_fil=
ter.cc

Improving code coverage would be nice way for you to learn the code base =
;-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--bxkIVRqLKBh1Clc2cbxaLWCHns9bTqu30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlN2yToACgkQ8dLMyEl6F23vjgCbBGuaKyoGV/c89PNMLNPRXIBP
Y6QAnjq48asK1bmxpnWOchF9zghD4GlW
=srHz
-----END PGP SIGNATURE-----

--bxkIVRqLKBh1Clc2cbxaLWCHns9bTqu30--
