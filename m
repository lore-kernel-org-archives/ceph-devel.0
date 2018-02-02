From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Better anticipation for minor releases
Date: Fri, 2 Feb 2018 19:55:54 +0000
Message-ID: <robbat2-20180202T195241-795645967Z@orbis-terrarum.net>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
 <4173fd50ca3d6d4e4f691f116b425397@suse.com>
 <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com>
 <bfc90180-334b-519b-cf2c-db13b33abff2@suse.cz>
 <CALqRxCzxBuihz6FTtFq4oROmgstnh79uB8F-iosameNo4+7SOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PETIzWh8d1Msfd+P"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:50558 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754142AbeBBTz5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:55:57 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 43B17335C67
        for <ceph-devel@vger.kernel.org>; Fri,  2 Feb 2018 19:55:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALqRxCzxBuihz6FTtFq4oROmgstnh79uB8F-iosameNo4+7SOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Alfredo Deza <adeza@redhat.com>, Abhishek <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>


--PETIzWh8d1Msfd+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2018 at 10:15:14AM -0700, Ken Dreyer wrote:
> This is just my opinion: we should have a quick "bump commit + tag"
> Jenkins job that pushes the Git tag live as soon as possible. In
> particular we should not wait for packages to be build + signed +
> published on download.ceph.com before pushing the bump commit + tag
> live.
>=20
> Bumping and tagging in Git should take a minute or two, whereas
> building, signing, and rsync'ing all the packages for that tag takes
> hours. I think this time-intensive process causes the Git history to
> diverge for too long.
Thought:
- Tag or branch a candidate commit for going INTO the QE phase, say
  v12.2.3-rcX.
- Run QE on that tag.
- If QE passes entirely, create final tag at same commit as rc tag.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--PETIzWh8d1Msfd+P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlp0wklfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsTSWg/+ONG11+I8hSpCUt3mF0m7485JBwY/P4+OfoFaEPNDtjPIr+JtgMmAGN79
zW9b/dw9Q5Us8tYvsFkAELAIbDE2xRt6erASykiqXeGMMTEAjbhAz3u2Xxxv1Q88
Gaa5QJPXD/LTW9RGs1dZcrcngEcU4nCKjVtqGF/jbgrvJ+OZWIl8eNq6DCRLDRlP
q3IAad1kZ72T92Ouca0Rdd2r77ZSjM8FOFS/GOqveDuuU0j9Zdc1qPeG4zKC4C9Q
XluZeGuF3HJAC0u+2w8FP32EATmjGwjSbsgZAhA0JaOuqPBDnLgw1VDGXDHd9Pv7
NNxV7tqx/bTCZjLkizvgqiGUX6fauIQ5BOcr0IXd1rMCXtt0YnM1a2DKpig8J4z0
2cX2d5e2h8Vh0GEqZ6hC+QC8kxasv10dFr9yHhYPNQHSqNh4CaJSRER89SVnHJ5W
aKcoAt86RXsvR6V/2+4HzevP5UBbIUJNk6FoGDrkMMMlQ2yT0h0xwTUiJ1G46dnJ
RuJlOVcUHk3Jlcw/1kXjiqrWD8qFW8Ymc0t+HKWD2k+m8hzw0ILuT7dvIomg28p4
+uQy18s0en5E17NdEPZ4DtwWU+cHqfj+3kvilCB3vpNnM9rqcFeqRhP6Ixdgp7fQ
Soe/zi+YddR/+KSw70a69rSUXyG8ClNgUwJXynKYFWhfAW3xtac=
=odrS
-----END PGP SIGNATURE-----

--PETIzWh8d1Msfd+P--
