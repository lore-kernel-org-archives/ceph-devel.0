From: Sage Weil <sage@newdream.net>
Subject: Re: Filestore throttling
Date: Wed, 22 Oct 2014 21:06:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410222104080.10837@cobra.newdream.net>
References: <BLU175-W34FC39734E69C620D262DEDF920@phx.gbl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-914531250-1414037181=:10837"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43320 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbaJWEGW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 00:06:22 -0400
In-Reply-To: <BLU175-W34FC39734E69C620D262DEDF920@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-914531250-1414037181=:10837
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Oct 2014, GuangYang wrote:
> Hello Cephers,
> During our testing, I found that the filestore throttling became a limi=
ting factor for performance, the four settings (with default value) are:
> =A0filestore queue max ops =3D 50
> =A0filestore queue max bytes =3D 100 << 20
> =A0filestore queue committing max ops =3D 500
> =A0filestore queue committing max bytes =3D=A0100 << 20
>=20
> My understanding is, if we lift the threshold, the response for op (end=
 to end) could be improved a lot during high load, and that is one reason=
 to have journal. The downside is that if there is a read following a suc=
cessful write, the read might stuck longer as the object is not flushed.
>=20
> Is my understanding correct here?
>=20
> If that is the tradeoff and read after write is not a concern in our us=
e case, can I lift the parameters to below values?
> =A0filestore queue max ops =3D 500
> =A0filestore queue max bytes =3D 200 << 20
> =A0filestore queue committing max ops =3D 500
> =A0filestore queue committing max bytes =3D=A0200 << 20
>
> It turns out very helpful during PG peering stage (e.g. OSD down and up=
).

That looks reasonable to me.

For peering, I think there isn't really any reason to block sooner rather=
=20
than later.  I wonder if we should try to mark those transactions such=20
that they don't run up against the usual limits...

Is this firefly or something later?  Sometime after firefly Sam made some=
=20
changes so that the OSD is more careful about waiting for PG metadata to=20
be persisted before sharing state.  I wonder if you will still see the=20
same improvement now...

sage
--557981400-914531250-1414037181=:10837--
