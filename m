From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Better anticipation for minor releases
Date: Fri, 2 Feb 2018 21:52:07 +0000
Message-ID: <robbat2-20180202T215042-235160906Z@orbis-terrarum.net>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
 <4173fd50ca3d6d4e4f691f116b425397@suse.com>
 <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com>
 <bfc90180-334b-519b-cf2c-db13b33abff2@suse.cz>
 <CALqRxCzxBuihz6FTtFq4oROmgstnh79uB8F-iosameNo4+7SOQ@mail.gmail.com>
 <robbat2-20180202T195241-795645967Z@orbis-terrarum.net>
 <b0e75bc4-e7da-db16-ddb3-bb70df281699@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w1d+AIiKduYp7JzL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:59620 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeBBVwJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:52:09 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 36E8C335C67
        for <ceph-devel@vger.kernel.org>; Fri,  2 Feb 2018 21:52:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <b0e75bc4-e7da-db16-ddb3-bb70df281699@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, Ken Dreyer <kdreyer@redhat.com>, Alfredo Deza <adeza@redhat.com>, Abhishek <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>


--w1d+AIiKduYp7JzL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2018 at 10:35:20PM +0100, Nathan Cutler wrote:
> > Thought:
> > - Tag or branch a candidate commit for going INTO the QE phase, say
> >    v12.2.3-rcX.
> > - Run QE on that tag.
> > - If QE passes entirely, create final tag at same commit as rc tag.
> That assumes it's possible the release tooling supports releasing=20
> something other than the tip of a branch (i.e. a SHA1 or tag), though,=20
> right?
If the public tooling doesn't, I'd volunteer a little time to fix it.
As a bonus, the rc tag is available to everybody ELSE for their testing
much earlier.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--w1d+AIiKduYp7JzL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlp03YZfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsRCiw/8CHOHTWM8PaACfPWT6qPHRQwIEUlfGe/PNAEaO00RwmnlSmL0IWu2SCzm
LYgb1eV9GLYdixwmzWGJV4Q8lbWSSMgRRwKuFRwJhzG5qI2Q6cmNiluob+aVJ70r
3EtsPM2RlOMOCkdAIuRD6hz1glDAnig/i051W7n883/nDEWxs6vnthtREw27Pj9A
EzIBJLnhmmevmRlgVQ8RJhlgsSUU0R4LSMtq8tafy+Vy0kXf4/32U5wSRmSc0p5M
2cBStBE44PXfP3E4Uo4fdNQLp322YOB06+I2Ln16xLNunywaL2Y9B5KI+6lTn7oL
hWgPLwaKMgOWhGht1Lszv9rO1cnoaoH3JAEvHBLy0eXA3e20woxIB6YCpOdckk6k
XvB/WxnAld8OTSGIsNXZGx+QnWpXJc8NoZ7FEFo4W2XKBjWdUFi3lrk31arX3HU1
MJEteI57k9dCHU0l690udMR0SGJQljRp1CtleeNkCYh77u3mFD4yMWQ9pFWdjJis
VTDWGkqYTF92ZUNMJtiT7pmJT4dHdq4hBxhB9KLpGet/mp7pHk3UpMr4bXzCcBBo
p6zUvMgpM83P6atQ9ZQF3W1mXMg7rHb3vm+uL8d0Lr8bFU3MXEHYNHHOlaQlqMPq
H3nmWzcBUWf3N1a8dfhrQg+bRngNcMkeCob8legBcEq9RKBw3Cs=
=b048
-----END PGP SIGNATURE-----

--w1d+AIiKduYp7JzL--
