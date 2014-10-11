From: Loic Dachary <loic@dachary.org>
Subject: RHEL7 source packages
Date: Sat, 11 Oct 2014 17:44:25 +0200
Message-ID: <54395059.6030507@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="d4MGw6Snn6dteoEEgK6G1kGEhL8ngI1Lh"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42658 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751818AbaJKPob (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Oct 2014 11:44:31 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 8F360420A2
	for <ceph-devel@vger.kernel.org>; Sat, 11 Oct 2014 17:44:25 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d4MGw6Snn6dteoEEgK6G1kGEhL8ngI1Lh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

I find this line in https://github.com/ceph/ceph/blob/giant/ceph.spec.in#=
L382

%if (0%{?rhel} || 0%{?rhel} < 7)

odd because it looks like exactly the same as

%if 0%{?rhel}

But it has been added a long time ago


--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--d4MGw6Snn6dteoEEgK6G1kGEhL8ngI1Lh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ5UFkACgkQ8dLMyEl6F22XYwCgocBDBzpQ1pZA2bMEJFxGk2JR
PZIAoJF03NCedOu8ZI8yS25pIHm8bLPg
=BKng
-----END PGP SIGNATURE-----

--d4MGw6Snn6dteoEEgK6G1kGEhL8ngI1Lh--
