From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: "rbd rm image" slow with big images ?
Date: Fri, 01 Jun 2012 06:38:10 +0200 (CEST)
Message-ID: <bbd69ec3-c889-402a-8c7d-a16487874b62@mailpro>
References: <Pine.LNX.4.64.1205311118150.28422@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:52666 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab2FAEic convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 00:38:32 -0400
In-Reply-To: <Pine.LNX.4.64.1205311118150.28422@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org


>>That said, the current implementation is also stupid: it's doing a si=
ngle=20
>>io at a time. #2256 (next sprint) will parallelize this to make it go=
=20
>>much faster (probably an order of magnitude?).=20

Ah, ok, this is why is see low ios/network during delete.

Thanks Sage and Wido for the explains, that's very clear!



----- Mail original -----=20

De: "Sage Weil" <sage@inktank.com>=20
=C3=80: "Wido den Hollander" <wido@widodh.nl>=20
Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, ceph-devel@vger.kernel.=
org=20
Envoy=C3=A9: Jeudi 31 Mai 2012 20:19:44=20
Objet: Re: "rbd rm image" slow with big images ?=20

On Thu, 31 May 2012, Wido den Hollander wrote:=20
> Hi,=20
> > Is it the normal behaviour ? Maybe some xfs tuning could help ?=20
>=20
> It's in the nature of RBD.=20

Yes.=20

That said, the current implementation is also stupid: it's doing a sing=
le=20
io at a time. #2256 (next sprint) will parallelize this to make it go=20
much faster (probably an order of magnitude?).=20

sage=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
