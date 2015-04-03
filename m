From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: Giant v0.87.2 integration branch ready for testing
Date: Fri, 03 Apr 2015 11:28:10 +0530
Message-ID: <87ioddzrbh.fsf@gmail.com>
References: <551D3A33.5040004@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34895 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbbDCF7a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Apr 2015 01:59:30 -0400
Received: by patj18 with SMTP id j18so106591708pat.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Apr 2015 22:59:30 -0700 (PDT)
In-reply-to: <551D3A33.5040004@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Loic Dachary writes:

> Hi Abhishek,
>
> Joao backported https://github.com/ceph/ceph/pull/4258 and it was merged =
together with https://github.com/ceph/ceph/pull/4214 into the https://githu=
b.com/ceph/ceph/tree/giant-backports branch. It should be ready for testing=
 after http://ceph.com/gitbuilder.cgi compiled it. I don't think we need to=
 run rbd and rgw this time. The http://tracker.ceph.com/issues/11153#teutho=
logy-run-commit538d012a30361d7fb33ee19632103a1ff242dee3-giant-backports-bra=
nch-april-2015 entry has been updated with details.
>
> The teuthology commands to launch the suites should be ready but it's cer=
tainly worth a review ;-)=20

I've started the teuthology suites for both rados & fs, updated in the
tracker[1][2]. Once these suites come out green I expect we're ready for=20
the next phase.

[1] http://tracker.ceph.com/issues/11153#rados
[2] http://tracker.ceph.com/issues/11153#fs

Cheers
=2D-
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVHiv7AAoJEPnwZB8bZe1fHGIIAKsrH4T4EriECGRMNsPWE/RO
+CnVpnFHwBMIvqWUIDJSz15NjIipJBaq8iVCUkC/ETcjFyGMs2x3241QoNaraQUi
S+b9jPi30XwkIdS5bnOoLWqtl2c9X2FLGoU6ElHdOmf05vOIaxaTLuI7mYmBbEN6
z4HoX/zhQhi+l1ewGW/5si1LDUKwuf87us9zKUlbOhcczf9nsNJOV3tyeiO4ZAmv
gy52rU84KgMhjNtaeeR/qcg35CJI5tOkDmqaiw2GOKs8dcq3abMnNqDSyzxdy+Yz
NvTZucLMOTI/DMoBLhzgz1urEilXUl30+JoKnOZlS0BBwsNUakUsJ4zazqxTWyw=
=UzCf
-----END PGP SIGNATURE-----
--=-=-=--
