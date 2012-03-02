From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: protocol version mismatch
Date: Fri, 2 Mar 2012 08:06:21 -0800
Message-ID: <90660E33C43F48A7ACCC8E5E1ADD6AB5@dreamhost.com>
References: <CAJafhzSp7eHZ_nQBFAtGO3p02470munOPKswpR3BOtVb9K69-w@mail.gmail.com>
 <25281330682162@webcorp7.yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64214 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab2CBQGY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 11:06:24 -0500
Received: by pbcun15 with SMTP id un15so251332pbc.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Mar 2012 08:06:24 -0800 (PST)
In-Reply-To: <25281330682162@webcorp7.yandex-team.ru>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?=D0=91=D0=BE=D1=80=D0=BE=D0=B4=D0=B8=D0=BD_=D0=92=D0=BB=D0=B0=D0=B4=D0=B8=D0=BC=D0=B8=D1=80?= <d0uble@yandex-team.ru>, Christian Brunner <christian@brunner-muc.de>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

This is a known issue that was introduced recently and will be fixed in=
 the next point release. If you want it now you can pull down the "next=
" branch or apply commit:244b70296622906f01cfa3d48c931aa08e663a75 to yo=
ur source. :)
-Greg


On Friday, March 2, 2012 at 1:56 AM, =D0=91=D0=BE=D1=80=D0=BE=D0=B4=D0=B8=
=D0=BD =D0=92=D0=BB=D0=B0=D0=B4=D0=B8=D0=BC=D0=B8=D1=80 wrote:

> Hi.
> =20
> I have the same problem. All OSD nodes complain on all other OSD node=
s. The problem appeared after update from 0.42 to 0.42.2.
> =20
> 02.03.2012, 13:19, "Christian Brunner" <christian@brunner-muc.de (mai=
lto:christian@brunner-muc.de)>:
> > Hi,
> > =20
> > I've just updated our ceph-cluster from 0.39 to 0.42.2. Now I'm see=
ing
> > a lot of messages like these in the OSD log:
> > =20
> > Mar 2 10:15:43 os00 osd.003[15096]: 7f0b9831c700 --
> > 10.255.0.60:6821/15095 >> 10.255.0.61:6812/22474 pipe(0x2e74100 sd=3D=
47
> > pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D =
0
> > Mar 2 10:15:44 os00 osd.000[14377]: 7fa07d660700 --
> > 10.255.0.60:6802/14376 >> 10.255.0.61:6818/22919 pipe(0x2c92d00 sd=3D=
24
> > pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D =
0
> > Mar 2 10:15:44 os00 osd.000[14377]: 7fa07d55f700 --
> > 10.255.0.60:6802/14376 >> 10.255.0.61:6815/22697 pipe(0x32a9900 sd=3D=
32
> > pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D =
0
> > Mar 2 10:15:44 os00 osd.002[14898]: 7f1e52ea6700 --
> > 10.255.0.60:6817/14897 >> 10.255.0.63:6813/10357 pipe(0x3a82800 sd=3D=
32
> > pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D =
0
> > Mar 2 10:15:44 os00 osd.002[14898]: 7f1e52fa7700 --
> > 10.255.0.60:6817/14897 >> 10.255.0.63:6806/10448 pipe(0x3a81180 sd=3D=
30
> > pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D =
0
> > Mar 2 10:15:44 os00 osd.002[14898]: 7f1e531a9700 --
> > 10.255.0.60:6817/14897 >> 10.255.0.63:6807/10265 pipe(0x3a80280 sd=3D=
34
> > pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D =
0
> > Mar 2 10:15:45 os00 osd.002[14898]: 7f1e542ba700 --
> > 10.255.0.60:6817/14897 >> 10.255.0.61:6821/23156 pipe(0x413d000 sd=3D=
40
> > pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D =
0
> > =20
> > 10.255.0.60 - 10.255.0.63 are our OSD hosts.
> > =20
> > Is there anything I can do about this? (Everything seems to be work=
ing...).
> > =20
> > Regards,
> > Christian
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org (mailto:majordom=
o@vger.kernel.org)
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> =20
> =20
> =20
> -- =20
> http://staff.yandex-team.ru/d0uble
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
