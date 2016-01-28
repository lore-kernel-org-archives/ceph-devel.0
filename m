From: Wido den Hollander <wido@42on.com>
Subject: Re: HEALTH_ERR when (re)starting ceph-osd's
Date: Thu, 28 Jan 2016 13:37:39 +0100
Message-ID: <56AA0B93.8050105@42on.com>
References: <0ec5364ea10c41a687edca2bfe7818e6@R01UKEXCASM115.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:41988 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935526AbcA1Mhf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jan 2016 07:37:35 -0500
In-Reply-To: <0ec5364ea10c41a687edca2bfe7818e6@R01UKEXCASM115.r01.fujitsu.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 28-01-16 11:48, Piotr.Dalek@ts.fujitsu.com wrote:
> Hello,
>=20
> I haven't noticed it before, but since merging https://github.com/cep=
h/ceph/pull/7253 I see that, when restarting daemons on healthy ceph cl=
uster, it goes to HEALTH_ERR state with "$(random_number) pgs are stuck=
 inactive for more than 300 seconds".=20
> I looked at the commit and it turns out it will be always occurring o=
n restart/boot, as booting pgs are inactive "by default" (since mons ne=
ver received any sign of life from them) - not because they're actually=
 stuck inactive.

Well, in that case, isn't the PR correct? But I see what you mean.

> One solution to this would be to mark pg_stat.last_* fields to the po=
int where it were first seen, so they will become stuck (mon_pg_stuck_t=
hreshold) seconds after first registering, and not right away.

That sounds like a good solution, you might want to take a look at:
http://tracker.ceph.com/issues/14028

> Another, less invasive one, is to just let user disable this warning.
>=20

As you can see in the discussion on Github, we decided to set
'mon_pg_min_inactive' to 1 by default.

You can disable these warnings by either setting it to zero or to maybe
something like 10.

This is just there that people are informed when multiple PGs are inact=
ive.

Being in WARN state, but still not performing I/O is a bad thing. WARN
should be where you take a look, but aren't worried.

If I/O stops ERR is a good thing to go in to.

Wido

> What do you think?
>=20
> With best regards / Pozdrawiam
> Piotr Da=C5=82ek
>=20
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
