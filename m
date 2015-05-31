From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Hammer v0.94.2 ready for release
Date: Sun, 31 May 2015 20:44:39 +0530
Message-ID: <87iob8dbj4.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33620 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758662AbbEaPRU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 May 2015 11:17:20 -0400
Received: by padj3 with SMTP id j3so26102925pad.0
        for <ceph-devel@vger.kernel.org>; Sun, 31 May 2015 08:17:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>, Alfredo Deza <adeza@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yuri Weinstein <yweinste@redhat.com>

--=-=-=
Content-Type: text/plain

Hi

Hammer v0.94.2 has passed the QE validations[1], and is ready to be
published. A draft of the release notes is available at the git master
[2]. The entire summary of activities have been captured at the tracker
at http://tracker.ceph.com/issues/11492

[1]: http://tracker.ceph.com/issues/11492#QE-Validation
[2]: https://github.com/ceph/ceph/blob/master/doc/release-notes.rst#0942-hammer-draft

--
Regards
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVayVpAAoJEPnwZB8bZe1fGz0H/AhgTZurqGYeAlz++QzURAFZ
Verdsqb5lOsZGOx6GqNhfXAung15Pgszy0JYM5FN3GoO5tAuSQJuHhtsZnr9nr9M
HAmwI6v7mBKM8CoLtXT27ICDHpw3C6v9SnZionAyOAniERKJfMAaFZBsaka+gSK9
+pNuHF6QU/+Z+HSzNM5dwbO3h3S3S7lGWDfJZe0yAH3zEvYk2Rlm0wKKHr5XqMQz
nd4ARFE4Cfq3iyG/KftJjIQ3DMZLsKCUHvpehUJZeDfEWvaajhqSQSb6L7spiO/g
YHv2G+4psvTh3w4bqNG/MXINQv2n83+Nfw6kvAPD24P3IpyuOsHkqc9q3Tp3EMk=
=/FIg
-----END PGP SIGNATURE-----
--=-=-=--
