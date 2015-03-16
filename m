From: Loic Dachary <loic@dachary.org>
Subject: Firefly v0.80.10 backports (rgw)
Date: Mon, 16 Mar 2015 22:28:09 +0100
Message-ID: <55074AE9.8080008@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fIeI1vFsogSChgCOsqK0o63wwLPeXwLNk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59079 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932550AbbCPV2M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Mar 2015 17:28:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fIeI1vFsogSChgCOsqK0o63wwLPeXwLNk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

A few issues related to rgw were backported to firefly[1]. They passed th=
e rgw suite[2]. Could you please take a look ?

Cheers

[1] https://github.com/ceph/ceph/pulls?q=3Dis%3Aopen+is%3Apr+milestone%3A=
firefly+sort%3Aupdated-desc+label%3Argw
[2] http://tracker.ceph.com/issues/11090#rgw

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre




--fIeI1vFsogSChgCOsqK0o63wwLPeXwLNk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUHSukACgkQ8dLMyEl6F21fiACfWw558HYBsy6F1/jz7cS2zQUZ
PHkAoLhsvcsHaHzX/0mufqmNqZf28wyq
=lKaF
-----END PGP SIGNATURE-----

--fIeI1vFsogSChgCOsqK0o63wwLPeXwLNk--
