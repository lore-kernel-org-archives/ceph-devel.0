From: Sage Weil <sage@newdream.net>
Subject: Re: How to know the status of the monitors?
Date: Tue, 13 Dec 2011 08:12:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112130811360.25425@cobra.newdream.net>
References: <8512670932FB654F81AF0FEF1BE6D49D9DD46F@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-312023773-1323792758=:25425"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42400 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab1LMQMl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2011 11:12:41 -0500
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D9DD46F@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com, Alex_KT_Lin@wistron.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-312023773-1323792758=:25425
Content-Type: TEXT/PLAIN; charset=BIG5
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Eric,

 ceph quorum_status

will tell you which monitors are part of the quorum.  It will block until=
=20
a quorum is reached.

 ceph mon_status

will give you the status of the monitor you happened to connect to.  You=20
can query a specific monitor with -m <ip>.

sage


On Tue, 13 Dec 2011, Eric_YH_Chen@wistron.com wrote:

> Hi, all:
>=20
>     Is there any command or API can retrieve the status of all monitors?
>=20
>     I use =A1=A5ceph mon stat=A1=A6 to get this information. However, the=
 mon.e is not available (server is shutdown).
>=20
>       2011-12-13 17:08:35.499022 mon <- [mon,stat]
> =A1@=A1@=A1@2011-12-13 17:08:35.499716 mon.1 -> 'e3: 5 mons at {a=3D172.1=
6.33.5:6789/0,b=3D172.16.33.6:6789/0,c=3D172.16.33.7:6789/0,d=3D172.16.33.7=
1:6789/0,e=3D172.16.33.72:6789/0}, election epoch 16, quorum 0,1,2,3' (0)
>    =20
>     Even I use =A1=A5ceph mon dump=A1=A6, I still cannot know if the moni=
tor is alive or not.
>=20
> =09=090: 172.16.33.5:6789/0 mon.a
> =09=091: 172.16.33.6:6789/0 mon.b
> =09=092: 172.16.33.7:6789/0 mon.c
> =09=093: 172.16.33.71:6789/0 mon.d
> =09=094: 172.16.33.72:6789/0 mon.e
>=20
>     Please give some help. Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-312023773-1323792758=:25425--
