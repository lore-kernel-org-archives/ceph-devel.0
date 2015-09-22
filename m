From: Sage Weil <sage@newdream.net>
Subject: Re: use crushtool to simulate pg distribution for a specific pool
Date: Tue, 22 Sep 2015 11:41:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509221138330.11876@cobra.newdream.net>
References: <SNT146-W7672C7B2604BA26E504E1D8C450@phx.gbl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1297168585-1442947284=:11876"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36584 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbbIVSlZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Sep 2015 14:41:25 -0400
In-Reply-To: <SNT146-W7672C7B2604BA26E504E1D8C450@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Z Zhang <zhangz.david@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1297168585-1442947284=:11876
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Zhang,

On Tue, 22 Sep 2015, Z Zhang wrote:
> Hi ceph-devel,
>=20
> We enhanced the crushtool to simulate real pg distribution for a=20
> specific pool. Recently we had encountered pg uneven issue again after=20
> expanding our cluster, although we had re-weighted the cluster to make=20
> pg evenly-distribution at the time we built up the cluster.=A0
>=20
> It could be painful to re-weighted osds after expanding cluster because=
=20
> in order to achieve pg evenly-distribution, we may need to re-weight=20
> couple of times and each time will trigger data movement.
>=20
> Now we could use this crushtool to simulate pg distribution against=20
> crush map, re-weight osds and test the crush map again and again until=20
> we satisfy with pg distribution. Then we could set back the final crush=
=20
> map and trigger data movement for one time.
>=20
> Please check this PR:=A0https://github.com/ceph/ceph/pull/6004=A0if you=
r=20
> guys are interested.=A0

This looks like it will work, but I'm not sure it's the right place to=20
put it.  The osdmaptool has a --test-map-pgs option that maps all PGs and=
=20
gives you the osd distribution and pg min/max per OSD.  The procedure is=20
then slightly different:

 ceph osd getmap -o om
 osdmaptool om --export-crush cm
 repeat:
  adjust crush map cm...
  osdmaptool om --import-crush cm --test-map-pgs
 ceph osd setcrushmap -i cm

...but it will keep the details of ceph pools out of crushtool (where the=
y=20
probably don't belong).

What do you think?
sage

--557981400-1297168585-1442947284=:11876--
