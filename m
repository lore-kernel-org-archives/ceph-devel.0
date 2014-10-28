From: Sage Weil <sage@newdream.net>
Subject: RE: Cache pool bug?
Date: Mon, 27 Oct 2014 21:02:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410272100310.7897@cobra.newdream.net>
References: <CANE=7sUW0e-vp8LROZFA+5BGNoENA4MLthsnPUKb1ks=hnoyEA@mail.gmail.com> <BLU169-W9B3F7EAC2250B1425B560DA9E0@phx.gbl> <06E7D85B3BA36C4DB207FEDE871C5348950BD2@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1410270902320.13498@cobra.newdream.net>
 <CANE=7sVJLeCBkSzNM9cC0k0YOCgapBdMVeYP=GqncTKtup5eKw@mail.gmail.com> <06E7D85B3BA36C4DB207FEDE871C5348950D90@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-43266539-1414468934=:7897"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51506 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbaJ1ECP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 00:02:15 -0400
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C5348950D90@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: =?GB2312?B?s9jQxdTz?= <xmdxcxz@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "wonzhq@hotmail.com" <wonzhq@hotmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-43266539-1414468934=:7897
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yep.  The pull request looks is correct too, but needs to be squashed int=
o=20
a single commit with a Signed-off-by: line and description.

Zhiqiang, I think the reversed logic you just fixed in agent_maybe_evict(=
)=20
was partly because this function is filling in atime (which sounds like a=
=20
timestamp) with an *age* (now - p->first).  I think we should change

> =C2=A0 =C2=A0 =C2=A0 if (*atime < 0)
> 	*atime =3D now - p->first;

to be=20

 *atime =3D p->first

and/or adjust the caller accordingly...?

sage
--557981400-43266539-1414468934=:7897--
