From: Sage Weil <sage@newdream.net>
Subject: Re: [WRN] map e### wrongly marked me down or wrong addr
Date: Mon, 27 Feb 2012 09:03:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202270901350.12283@cobra.newdream.net>
References: <2230716.Iq9SpLVmvc@mranderson>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1624554864-1330362191=:12283"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35193 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab2B0RDw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2012 12:03:52 -0500
In-Reply-To: <2230716.Iq9SpLVmvc@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org, wido@widodh.nl

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1624554864-1330362191=:12283
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 27 Feb 2012, Sz=E9kelyi Szabolcs wrote:
> Hello,
>=20
> whenever I restart osd.0 I see a pair of messages like
>=20
> 2012-02-27 17:26:00.132666 mon.0 <osd_1_ip>:6789/0 106 : [INF] osd.0=20
> <osd_0_ip>:6801/29931 failed (by osd.1 <osd_1_ip>:6806/20125)
> 2012-02-27 17:26:21.074926 osd.0 <osd_0_ip>:6801/29931 1 : [WRN] map e370=
=20
> wrongly marked me down or wrong addr
>=20
> a couple of times. The situation stabilizes in a normal state after about=
 two=20
> minutes.
>=20
> Should I worry about this? Maybe the first message is about the just kill=
ed=20
> OSD, and the second comes from the new incarnation, and this is completel=
y=20
> normal? This is Ceph 0.41.

It's not normal.  Wido was seeing something similar, I think.  I suspect=20
the problem is that during startup ceph-osd just busy, but the heartbeat=20
code is such that it's not supposed to miss them. =20

Can you reproduce this with 'debug ms =3D 1'?

sage

--557981400-1624554864-1330362191=:12283--
