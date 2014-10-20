From: Sage Weil <sage@newdream.net>
Subject: Re: weight VS crush weight when doing osd reweight
Date: Mon, 20 Oct 2014 08:03:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410200756130.10837@cobra.newdream.net>
References: <D06AAD30.3328%leidong@yahoo-inc.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-113147542-1413817423=:10837"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50782 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbaJTPDn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Oct 2014 11:03:43 -0400
In-Reply-To: <D06AAD30.3328%leidong@yahoo-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lei Dong <leidong@yahoo-inc.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-113147542-1413817423=:10837
Content-Type: TEXT/PLAIN; charset=Windows-1252
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Oct 2014, Lei Dong wrote:
> Hi sage:
>=20
> As you said at=A0https://github.com/ceph/ceph/pull/2199, adjusting weig=
ht or
> crush weight should be both effective at any case. We?ve encounter a si=
tuation
> in which it seems adjusting weight is far less effective than adjusting
> crush weight.=A0
>=20
> We use 6 racks with host number {9, 5, 9, 4, 9, 4} and 11 osds at each =
host.
> We created a crush rule for ec pool to survive rack failure:
>=20
> ruleset ecrule {
> =A0 =A0 =A0 =A0 ?
> =A0 =A0 =A0 =A0 min_size 11
> =A0 =A0 =A0 =A0 max_size 11
> =A0 =A0 =A0 =A0 step set_chooseleaf_tries 50
> step take default
> step choose firstn 4 type rack // we want the distribution to be {3, 3,=
 3,
> 2} for k=3D8 m=3D3
> step chooseleaf indep 3 type host
> =A0=A0=A0=A0=A0=A0step emit
> }
>=20
> After creation of the pool, we run osd reweight-by-pg many times, the b=
est
> result it can reach is=A0
> Average PGs/OSD (expected): 225.28
> Max PGs/OSD: 307
> Min PGs/OSD: 164 =A0
>=20
> Then we run our own tool to reweight(same strategy with reweight-by-pg,=
 just
> adjust crush weight instead of weight), =A0the best result is:
> Average PGs/OSD (expected): 225.28
> Max PGs/OSD: 241
> Min PGs/OSD: 207
> Which is much better than the previous one.
>=20
> According to my understanding, due to uneven host numbers across rack,
> =A0for=A0?step choose firstn 4 type rack?:
>  1. If we adjust osd weight, =A0this step is almost unaffected and
>     will=A0dispatch almost even pg number for each rack. Thus the host =
in the
>     rack which have less host will take more pgs, no matter how we adju=
st
>     weight.=A0
>  2. If we adjust osd crush weight, this step is affected and will try t=
o
>     dispatch more pg to the rack=A0which has higher crush weight value,=
 thus
>     the result can be even.
> Am I right about this?

I think so, yes.  I am a bit surprised that this is a problem, though.  W=
e=20
will still be distributing PGs based on the relative CRUSH weights, and I=
=20
would not expect that the expected variation will lead to very much skew=20
between racks.

It may be that CRUSH is, at baseline, having trouble respecting your=20
weights.  You might try creating a single straw bucket with 6 OSDs and=20
those weights (9, 5, 9, 4, 9, 4) and see if it is able to achieve a=20
correct distribution.  When there is a lot of variation in weights and th=
e=20
total number of items are small it can be hard for it to get to the right=
=20
result.  (We were just looking into a similar problem on another cluster=20
on Friday.)

For a more typical chooseleaf the osd weight will have the intended=20
behavior, but when the initial step is a regular choose only the CRUSH=20
weights affect the decision.  My guess is that your process of skewing th=
e=20
CRUSH weights pretty dramatically which is able to compensate for the=20
difficulty/improbability of randomly choosing racks with the right=20
frequency...

sage

> We then do a further test with 6 racks and 9 hosts in each rack. In thi=
s
> situation, adjusting weight or adjusting crush weight has almost the sa=
me
> effect.
>
> So, weight and crush weight do impact the result of CRUSH in a differen=
t
> way?=A0
--557981400-113147542-1413817423=:10837--
