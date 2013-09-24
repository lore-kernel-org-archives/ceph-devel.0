From: =?UTF-8?Q?S=C3=A9bastien_Han?= <sebastien.han@enovance.com>
Subject: =?UTF-8?Q?Re=3A_=22ceph_osd_map=22_pointer_to_the_code?=
Date: Tue, 24 Sep 2013 15:50:21 +0200
Message-ID: <etPan.5241989d.38437fdb.f19a@leseb-mba.local>
References: <etPan.52418730.7a6d8d3c.f19a@leseb-mba.local>
 <52418EA6.3070503@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:14594 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab3IXNuO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 09:50:14 -0400
In-Reply-To: <52418EA6.3070503@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: "=?UTF-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

Thanks Joao.

=E2=80=93=E2=80=93=E2=80=93=E2=80=93
S=C3=A9bastien Han
Cloud Engineer

"Always give 100%. Unless you're giving blood.=E2=80=9D

Phone:=C2=A0+33 (0)1 49 70 99 72
Mail:=C2=A0sebastien.han@enovance.com
Address :=C2=A010, rue de la Victoire - 75009 Paris
Web :=C2=A0www.enovance.com=C2=A0-=C2=A0Twitter :=C2=A0@enovance

On September 24, 2013 at 3:07:52 PM, Joao Eduardo Luis (joao.luis@inkta=
nk.com) wrote:

On 09/24/2013 01:36 PM, S=C3=A9bastien Han wrote: =20
> Hi guys, =20
> =20
> Does anyone can point me to the piece of code called during the =E2=80=
=9Cceph osd map =E2=80=98pool=E2=80=99 =E2=80=98object=E2=80=99=E2=80=9D=
 command please? =20
> Thanks! =20

$ git grep -n 'osd map' src/mon =20
src/mon/MonCommands.h:338:COMMAND("osd map " \ =20
src/mon/OSDMonitor.cc:2093: } else if (prefix =3D=3D "osd map") { =20

You'll want the second hit, on src/mon/OSDMonitor.cc =20

-Joao =20



-- =20
Joao Eduardo Luis =20
Software Engineer | http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
