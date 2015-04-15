From: Loic Dachary <loic@dachary.org>
Subject: radosgw and the next giant release v0.87.2
Date: Wed, 15 Apr 2015 11:43:12 +0200
Message-ID: <552E32B0.6040101@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4T6rF9mNI2Vq0usqQCvkLUJRHeVG0QAe8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46996 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751596AbbDOJnP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 05:43:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4T6rF9mNI2Vq0usqQCvkLUJRHeVG0QAe8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

The next giant release as found at https://github.com/ceph/ceph/tree/gian=
t passed the rgw suite (http://tracker.ceph.com/issues/11153#rgw). One ru=
n had a transient failure (http://tracker.ceph.com/issues/11259) that did=
 not repeat. You will also find traces of failed run because of http://tr=
acker.ceph.com/issues/11180 but that was resolved by backporting https://=
github.com/ceph/ceph-qa-suite/pull/375.=20

Do you think it is ready for QE to start their own round of testing ?

Note that it will be the last giant release.=20

Cheers

P.S. http://tracker.ceph.com/issues/11153#Release-information has direct =
links to the pull requests merged into giant since v0.87.1 in case you ne=
ed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre










--4T6rF9mNI2Vq0usqQCvkLUJRHeVG0QAe8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUuMrAACgkQ8dLMyEl6F20yqgCghtyjCbHpNWNHTM3NM7I3/KEo
sQMAoIAUUD8dD9aq3afkkFQVfIsnoguF
=zCP8
-----END PGP SIGNATURE-----

--4T6rF9mNI2Vq0usqQCvkLUJRHeVG0QAe8--
