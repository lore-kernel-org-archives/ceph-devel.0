From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: rgw and the next jewel release v10.2.4
Date: Thu, 27 Oct 2016 21:10:37 +0000
Message-ID: <robbat2-20161027T210703-533951955Z@orbis-terrarum.net>
References: <5811C853.1070706@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hNG1vEeyG8BCaHbQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:35622 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934631AbcJ0VKi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 27 Oct 2016 17:10:38 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 6806334164A
        for <ceph-devel@vger.kernel.org>; Thu, 27 Oct 2016 21:10:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5811C853.1070706@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Yehuda Sadeh <yehuda@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>


--hNG1vEeyG8BCaHbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2016 at 11:26:43AM +0200, Loic Dachary wrote:
> Hi Yehuda,
>=20
> The next jewel release as found at
> https://github.com/ceph/ceph/tree/jewel passed the rgw suite
> (http://tracker.ceph.com/issues/17487#note-18). Do you think the jewel
> branch is ready for QE to start their own round of testing ?
Can you please bring in the StaticSites fix in
https://github.com/ceph/ceph/pull/11280

This issue has been dragging since late August now :-(.
(it got reverted last time because it exposed a test suite bug)

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--hNG1vEeyG8BCaHbQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQJ8BAEBCgBmBQJYEm1MXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCREVCQjZBNTJGMTU2RkRGMzE2OEQ5MTEx
OTM5NUYyM0M1ODgyNkM0AAoJEBk5XyPFiCbEJC0P/0pSxzyiBfzXYwZlFteR95rU
jk+thzarJd+Ijx2S2seOvovW2+mUw1x6D+SEzRk4StFRSYkgBKC+WvvsHmTznbVW
NjiQYS2dKgJdIDUBaKvRTOS+EE3vP9OLvdTp5yIvdCaM1vzdj8eBuFkA686k6XjG
rOPTW41Ag+O1m1Rf/t581moEvE/+NNuw7/RzFIMAPMygfhLY87GjMmuqEX0Akhn2
thzZbi4bNGJvB8l/gC1L8+x6vBbK+BQquQ2dtV1hqlk81yH7av1Nu5YKehdWBpbg
CAMX2V8xWwDzMKEGl4/ppGKHrP0jFP0r2U31u3DhZ3GuLZ5HY4Ys/p3rD9dOK7yq
ppuJbcE51rcF5k4rfNnPi3s0ACvqYOMr4bojMtpwmNYvsOu+5rh0SQqNRFRL47Np
Mjw4HWWKOfY4Q67aYLfgGp1sNGCjSnYA5B6jcMQ9jBOUp0qu2ncL7hsNL0FnHGK+
afxpmPQWiFVNjwsLkqHAGVgfkPHY+JKmYoc459upSg/9Vz3JG4haKsLgd/CKJ5GA
lCPFYyEclYIKzjpw3nQMYdl9fE4sicd3z89EiNOUuCyaW9b1EUg/uFq327ylr9fn
KiFR2ecMlCUfNtbQgNEEDKHLTCnfJnWew++rQFksk3HrKFQffE8Rjr4tEioJUftb
eR17ZavjadTumFNfwYa5
=ESEK
-----END PGP SIGNATURE-----

--hNG1vEeyG8BCaHbQ--
