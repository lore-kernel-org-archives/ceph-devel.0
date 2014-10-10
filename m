From: Loic Dachary <loic@dachary.org>
Subject: ISA plugin tests
Date: Fri, 10 Oct 2014 22:07:58 +0200
Message-ID: <54383C9E.6050801@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sguo4uI0E6F1bppc0Bt8Vr7mW8bGCTqqa"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42220 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751797AbaJJUIJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 16:08:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sguo4uI0E6F1bppc0Bt8Vr7mW8bGCTqqa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

Not every mail is about problems ;-) I'm happy to report that the ISA plu=
gin you wrote passes the rados suite

http://pulpito.ceph.com/loic-2014-10-10_08:45:20-rados:thrash-erasure-cod=
e-isa-master-testing-basic-vps/

The rhel failures should be ignored, they are unrelated. And the only ubu=
ntu failure is about http://tracker.ceph.com/issues/9443

I'll have a glass of wine to celebrate !

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--sguo4uI0E6F1bppc0Bt8Vr7mW8bGCTqqa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEUEARECAAYFAlQ4PJ4ACgkQ8dLMyEl6F23xvgCYz4YjlU5bNAvv8HTeYG0dmFrj
rQCfXxqUbfxBXpWMBLHK/YvDcJ73aAU=
=T/wz
-----END PGP SIGNATURE-----

--sguo4uI0E6F1bppc0Bt8Vr7mW8bGCTqqa--
