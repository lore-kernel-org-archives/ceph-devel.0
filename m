From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Hammer branch for v0.94.3 ready for QE
Date: Thu, 06 Aug 2015 08:30:30 +0530
Message-ID: <878u9pdstt.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33872 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbbHFDEv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Aug 2015 23:04:51 -0400
Received: by pawu10 with SMTP id u10so51083453paw.1
        for <ceph-devel@vger.kernel.org>; Wed, 05 Aug 2015 20:04:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain

Hi Yuri


--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain

The hammer branch for v0.94.3, as found at
https://github.com/ceph/ceph/commits/hammer,is approved by the leads
(Sam,Greg,Josh & Yehuda) and is ready for QE. The
backport itself is tracked at http://tracker.ceph.com/issues/11990,
which has a record of all the test runs so far &
the tip of the branch is at 88e7ee716fdd7bcf81845087021a677de5a50da8.

Regards
Abhishek

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVws3fAAoJEPnwZB8bZe1fNAYIAKkSS7AqMCXcpWzhB/HuiD92
ReBkfj86hRbEetoCItITM7cagM05QPnAHufeEu+sL0aWM/+EZSnQDFNv232LOXIN
A2b0oaBq/gxORqwLIVQ0iILl/tPjxpnTzBkJiQUOQdGRSoVTporQ/ZEkmnBL42cb
Dx/ulZJO49fPiHuEOcmoRZaa2qYgebbSVzhk4F/+xOrSGFIni/9/0wGiqxayvzR4
0Gkg7Zew7XKYTH7CpnFCrizgKFt0GHxlAp73MPNAFAz7UbPerN2cq2oGKtdzLoWh
+z8/qmpZUwblthGsakObvslhzQu5z2dURQui3DT9PuNahbRd1Ll0FHA6yn+GZzw=
=M5qA
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
