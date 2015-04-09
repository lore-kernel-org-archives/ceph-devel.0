From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Preparing Giant v0.87.2 release
Date: Thu, 09 Apr 2015 23:53:22 +0530
Message-ID: <87bnixrwit.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33654 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755724AbbDISZI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Apr 2015 14:25:08 -0400
Received: by pdbnk13 with SMTP id nk13so161476483pdb.0
        for <ceph-devel@vger.kernel.org>; Thu, 09 Apr 2015 11:25:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

Lo=C3=AFc and I have been working towards backporting issues towards the ne=
xt
giant release, we have been able to backport all the commits marked for
giant backports and successfully run the integration suites. The tasks
are tracked at http://tracker.ceph.com/issues/11153. Do you think, the
next giant release is ready to be published, in which case, we'll
proceed to ask the respective project leads to sign off the release and
start the QE process.

=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVJsOpAAoJEPnwZB8bZe1fuIQH/0We2fr4mR5wo19U5Ix1xeV6
/mRgrN3Hc5H5JK6HG7eXoECJhxz1ZZK+eSW/Cd2fuxRE69v96jZ88Vzp/b/iB5Dm
/uj0HpgmV4AFBvbzs3KqasrHpWliBoZnOPLkKLS95KuE/jsKjyKeqErZ9tqJQfna
pRNqhg41I25rDzvh5vhTNr6bjiot2AErk6/cYtnvQlsYSECJk2CwLqsBCXstlevU
Pr6P9PyIyEwwEJfppAZqvVh4usHhk2QEg630YwXoyhCJSRInKcf3UIzVq6sKVb5k
fJ/PlKI2xDWHvTNS4omn4QuGsvllN7Crl29WBpZcqS89En6pPs5YAccgpR8Ll9o=
=2mdk
-----END PGP SIGNATURE-----
--=-=-=--
