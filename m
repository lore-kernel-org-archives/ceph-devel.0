From: =?koi8-r?B?4s/Sz8TJziD3zMHEyc3J0g==?= <d0uble@yandex-team.ru>
Subject: Re: protocol version mismatch
Date: Fri, 02 Mar 2012 13:56:02 +0400
Message-ID: <25281330682162@webcorp7.yandex-team.ru>
References: <CAJafhzSp7eHZ_nQBFAtGO3p02470munOPKswpR3BOtVb9K69-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from forward19.mail.yandex.net ([95.108.253.144]:39639 "EHLO
	forward19.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750Ab2CBKC3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 05:02:29 -0500
Received: from webcorp7.yandex-team.ru (webcorp7.yandex-team.ru [95.108.252.5])
	by forward19.mail.yandex.net (Yandex) with ESMTP id 1A0A811244CE
	for <ceph-devel@vger.kernel.org>; Fri,  2 Mar 2012 13:56:05 +0400 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webcorp7.yandex-team.ru (Yandex) with ESMTP id 0F75C50E08D7
	for <ceph-devel@vger.kernel.org>; Fri,  2 Mar 2012 13:56:03 +0400 (MSK)
In-Reply-To: <CAJafhzSp7eHZ_nQBFAtGO3p02470munOPKswpR3BOtVb9K69-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi.

I have the same problem. All OSD nodes complain on all other OSD nodes.=
 The problem appeared after update from 0.42 to 0.42.2.

02.03.2012, 13:19, "Christian Brunner" <christian@brunner-muc.de>:
> Hi,
>
> I've just updated our ceph-cluster from 0.39 to 0.42.2. Now I'm seein=
g
> a lot of messages like these in the OSD log:
>
> Mar =9A2 10:15:43 os00 osd.003[15096]: 7f0b9831c700 --
> 10.255.0.60:6821/15095 >> 10.255.0.61:6812/22474 pipe(0x2e74100 sd=3D=
47
> pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D 0
> Mar =9A2 10:15:44 os00 osd.000[14377]: 7fa07d660700 --
> 10.255.0.60:6802/14376 >> 10.255.0.61:6818/22919 pipe(0x2c92d00 sd=3D=
24
> pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D 0
> Mar =9A2 10:15:44 os00 osd.000[14377]: 7fa07d55f700 --
> 10.255.0.60:6802/14376 >> 10.255.0.61:6815/22697 pipe(0x32a9900 sd=3D=
32
> pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D 0
> Mar =9A2 10:15:44 os00 osd.002[14898]: 7f1e52ea6700 --
> 10.255.0.60:6817/14897 >> 10.255.0.63:6813/10357 pipe(0x3a82800 sd=3D=
32
> pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D 0
> Mar =9A2 10:15:44 os00 osd.002[14898]: 7f1e52fa7700 --
> 10.255.0.60:6817/14897 >> 10.255.0.63:6806/10448 pipe(0x3a81180 sd=3D=
30
> pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D 0
> Mar =9A2 10:15:44 os00 osd.002[14898]: 7f1e531a9700 --
> 10.255.0.60:6817/14897 >> 10.255.0.63:6807/10265 pipe(0x3a80280 sd=3D=
34
> pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D 0
> Mar =9A2 10:15:45 os00 osd.002[14898]: 7f1e542ba700 --
> 10.255.0.60:6817/14897 >> 10.255.0.61:6821/23156 pipe(0x413d000 sd=3D=
40
> pgs=3D0 cs=3D0 l=3D0).connect protocol version mismatch, my 9 !=3D 0
>
> 10.255.0.60 - 10.255.0.63 are our OSD hosts.
>
> Is there anything I can do about this? (Everything seems to be workin=
g...).
>
> Regards,
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =9Ahttp://vger.kernel.org/majordomo-info.html

--=20
http://staff.yandex-team.ru/d0uble
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
