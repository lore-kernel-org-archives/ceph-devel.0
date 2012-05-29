From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 15:01:35 +0200 (CEST)
Message-ID: <aa40ea07-d700-4d9f-8ee3-9e514585b127@mailpro>
References: <4FC4874A.8050701@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:49985 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab2E2NB6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 09:01:58 -0400
In-Reply-To: <4FC4874A.8050701@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

fio benchmark will give you raw device performance bypassing filesystem=
=2E

So maybe the problem is in xfs or linux vfs layer.

I think you need to bench the filesystem to compare performance


----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org, "Mark Nelson" <mark.nelson@inktank.com>=
=20
Envoy=C3=A9: Mardi 29 Mai 2012 10:22:34=20
Objet: Re: poor OSD performance using kernel 3.4=20

Am 29.05.2012 05:54, schrieb Alexandre DERUMIER:=20
>>> This happens with ext4 or btrfs too.=20
>=20
> maybe this is related to io scheduler ?=20
> did you have compared cfq,deadline,noop scheduler ?=20

This is something i consider for performance tuning later on, when=20
everything is running smooth. Right now i'm using CFQ with the tuned IB=
M=20
settings (which proxmox uses too).=20


Here are some outputs of basic fio Tests running on 3.4 and 3.0.=20

3.4: http://pastebin.com/raw.php?i=3D6GEKsCYH=20
3.0: http://pastebin.com/raw.php?i=3DFU4AtUck=20

strangely 3.4 is faster but this corresponds to the fact that the norma=
l=20
Disk I/O is working fine with 3.4 It's just ceph which isn't working fi=
ne.=20

> also what's is your sas/sata controller ?=20
Intel onboard SATA controller in this testsetup.=20

Stefan=20



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
