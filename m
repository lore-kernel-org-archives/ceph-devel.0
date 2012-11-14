From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: Small feature request for v0.55 release
Date: Wed, 14 Nov 2012 16:40:40 -0700
Message-ID: <2C7727ED-B154-4C3F-871C-58E47ED907D6@tchpc.tcd.ie>
References: <CAPud5_4pT3OPeVC=e2cFwpdiYXsx96TuAfYiCDJbWJek+hw_Xg@mail.gmail.com>  <sfid-H20121114-231457-+037.12-1@marduk.tchpc.tcd.ie> <alpine.DEB.2.00.1211141513040.26823@cobra.newdream.net>  (sfid-H20121114-231457-+037.12-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:36533 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933195Ab2KNXkr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 18:40:47 -0500
In-Reply-To: <alpine.DEB.2.00.1211141513040.26823@cobra.newdream.net>  (sfid-H20121114-231457-+037.12-1@marduk.tchpc.tcd.ie)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Nick Bartos <nick@pistoncloud.com>, ceph-devel@vger.kernel.org


On 14 Nov 2012, at 16:14, Sage Weil wrote:

>=20
> Appending the codename to the version string is something we did with=
=20
> argonaut (0.48argonaut) just to make it obvious to users which stable=
=20
> version they are on.
>=20
> How do people feel about that?  Is it worthwhile?  Useless?  Ugly?
>=20
> We can certainly skip it for 0.55 bobtail=85

Just throwing in some thoughts, but how about a scheme like ${name}-sta=
ble-${version}.tar.bz2 and have the corresponding directory structure i=
nside and just ditch code names in the tar ball filename? It doesn't lo=
ok as nice with out a codename, but it makes it absolutely clear to new=
 users that it is a stable release.

Jimmy

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
