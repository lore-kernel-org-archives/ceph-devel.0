From: Loic Dachary <loic@dachary.org>
Subject: bug triage: display the author
Date: Tue, 08 Sep 2015 15:35:33 +0200
Message-ID: <55EEE425.8050103@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fICitLqdhStS8ptfLOx9cicfDaOKJmnff"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51681 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754553AbbIHNfh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 09:35:37 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id D981042092
	for <ceph-devel@vger.kernel.org>; Tue,  8 Sep 2015 15:35:33 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fICitLqdhStS8ptfLOx9cicfDaOKJmnff
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I modified the bug triage tracker request ( http://tracker.ceph.com/issue=
s?query_id=3D40 ) to no longer display the status and the tracker (since =
they are always New and Bug) and display the Author of the issue instead.=
 I find that it helps to know who filed an issue during triage. But I don=
't feel strongly about it and if someone thinks it's too much noise, plea=
se revert :-)

Cheers
=20
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--fICitLqdhStS8ptfLOx9cicfDaOKJmnff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXu5CUACgkQ8dLMyEl6F23kiACcDNu80xn67Bk64JNW1/if0Mwn
MsYAnRVwV/kANKXZkSDAO1Cu9yoOTpWG
=NImJ
-----END PGP SIGNATURE-----

--fICitLqdhStS8ptfLOx9cicfDaOKJmnff--
