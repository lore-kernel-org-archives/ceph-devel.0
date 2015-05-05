From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Preparing hammer v0.94.2 release
Date: Tue, 05 May 2015 16:46:16 +0530
Message-ID: <87383bmfzz.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36406 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878AbbEELSS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 07:18:18 -0400
Received: by pabsx10 with SMTP id sx10so189931421pab.3
        for <ceph-devel@vger.kernel.org>; Tue, 05 May 2015 04:18:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage

Lo=C3=AFc and I have been working towards backporting issues for the next
hammer release, and we have been able to backport the commits marked for
hammer backports and successfully run the integration suites. The tasks
are tracked at http://tracker.ceph.com/issues/11492. Do you think, the
next hammer release is ready to be published, in which case, we'll
proceed to ask the respective project leads to sign off the release and
begin the QE process.

Cheers
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVSKaKAAoJEPnwZB8bZe1fR+0H/jgafV4WpTdNQ/btx7DRUS0+
toPoLcRUo+pD1rwe5BMEDVHDiJiYn2h/ONtQM7dFFY9iuJhtZDCwRpzA3QmE2fU/
ynBKh2EPz+OP5v2eExrvoao0v3TCgMjX3XW5EP4fJdQzjMFiGKrc78LCmhNmuNRE
dh4VXMgFi6O7heoiuOCbhgfGc22lKFmLKLEkJ6U4ED/gzB9touh4GhylQXNjfGPe
Le3pb55HL5MTY/VKekBIcXzdS6BU9VTxE7sB83iQ0dP3G0dIbNhstlnUJOincC1A
1wdlO2D199BrnS2/ssYZZwZVfb23VaQRa3zZuGB8OB9zXdvA1gUgR2HPBbVO99s=
=bu8a
-----END PGP SIGNATURE-----
--=-=-=--
