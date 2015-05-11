From: Loic Dachary <loic@dachary.org>
Subject: rgw and the next hammer release v0.94.2
Date: Mon, 11 May 2015 14:30:27 +0200
Message-ID: <5550A0E3.8000006@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="n579jiA0k1kdNIFVf4l7udbuR0uPEO6B6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:32914 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbbEKMa3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 08:30:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n579jiA0k1kdNIFVf4l7udbuR0uPEO6B6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

The next hammer release as found at https://github.com/ceph/ceph/tree/ham=
mer passed the rgw suite (http://tracker.ceph.com/issues/11492#rgw). Note=
 that the hammer branch does not yet include https://github.com/ceph/ceph=
/pull/4568 (it was included in the tests though). If https://github.com/c=
eph/ceph/pull/4568 is merged before QE starts their round of testing, it =
will be in v0.94.2. If it is not merged, it will have to wait until v0.94=
=2E3 is published. Either way is fine.

Do you think the hammer branch is ready for QE to start their own round o=
f testing ?

Cheers

P.S. http://tracker.ceph.com/issues/11492#Release-information has direct =
links to the pull requests merged into hammer since v0.94.1 in case you n=
eed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre














--n579jiA0k1kdNIFVf4l7udbuR0uPEO6B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVQoOMACgkQ8dLMyEl6F20v9QCbBinuihV0be7EOxGQuTBUql11
5JEAoMaYKsuMqo1WEiL2pcKYx4Mjwv8D
=0TwL
-----END PGP SIGNATURE-----

--n579jiA0k1kdNIFVf4l7udbuR0uPEO6B6--
