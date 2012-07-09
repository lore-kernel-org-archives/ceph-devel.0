From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: oops in rbd module (con_work in libceph)
Date: Mon, 09 Jul 2012 19:04:42 +0200
Message-ID: <4FFB0F2A.6070601@univ-nantes.fr>
References: <4FF6A27B.7020808@univ-nantes.fr> <4FF705BA.4080501@univ-nantes.fr> <4FF77FE8.9040408@inktank.com> <4FFB0CBA.6090806@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls2-lmb.cpub.univ-nantes.fr ([193.52.103.111]:52238 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752480Ab2GIREr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 13:04:47 -0400
In-Reply-To: <4FFB0CBA.6090806@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Alex Elder <elder@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 09/07/2012 18:54, Yann Dupont a =E9crit :
>
> Ok. I've compiled the kernel this afternoon, and tested it without=20
> much success :
>
> Jul  9 18:17:23 label5.u14.univ-nantes.prive kernel: [ 284.116236]=20
> libceph: osd0 172.20.14.130:6801 socket closed
> Jul  9 18:17:43 label5.u14.univ-nantes.prive kernel: [ 304.101545]=20
> libceph: osd6 172.20.14.137:6800 socket closed
> Jul  9 18:17:53 label5.u14.univ-nantes.prive kernel: [ 314.095155]=20
> libceph: osd3 172.20.14.134:6800 socket closed
> Jul  9 18:18:38 label5.u14.univ-nantes.prive kernel: [ 359.075473]=20
> libceph: osd5 172.20.14.136:6800 socket closed
> Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [ 429.107334]=20
> libceph: osd6 172.20.14.137:6800 socket closed

just an interesting thing I just noticed in the logs :

osd-0.log
2012-07-09 18:17:23.763925 7ff9fc19e700  0 bad crc in data 3071411075 !=
=3D=20
exp 2231697357
2012-07-09 18:17:23.777607 7ff9fc19e700  0 -- 172.20.14.130:6801/5842 >=
>=20
172.20.14.132:0/1974511416 pipe(0x2236c80 sd=3D38 pgs=3D0 cs=3D0 l=3D0)=
=2Eaccept=20
peer addr is really 172.20.14.132:0/1974511416 (socket is=20
172.20.14.132:57972/0)

osd-3.log
2012-07-09 18:17:53.770111 7fe35461c700  0 bad crc in data 826922774 !=3D=
=20
exp 2498450653
2012-07-09 18:17:53.770972 7fe35461c700  0 -- 172.20.14.134:6800/4495 >=
>=20
172.20.14.132:0/1974511416
  pipe(0xa44ec80 sd=3D56 pgs=3D0 cs=3D0 l=3D0).accept peer addr is real=
ly=20
172.20.14.132:0/1974511416 (socket
  is 172.20.14.132:40726/0)

osd-5.log
2012-07-09 18:18:38.766417 7ff4a66cb700  0 bad crc in data 3949121728 !=
=3D=20
exp 2496058560
2012-07-09 18:18:38.773386 7ff4a66cb700  0 -- 172.20.14.136:6800/4876 >=
>=20
172.20.14.132:0/1974511416 pipe(0x20eeb780 sd=3D56 pgs=3D0 cs=3D0 l=3D0=
).accept=20
peer addr is really 172.20.14.132:0/1974511416 (socket is=20
172.20.14.132:57072/0)

osd-6.log
2012-07-09 18:17:43.765740 7fdf86b9d700  0 bad crc in data 2899452345 !=
=3D=20
exp 2656886014
2012-07-09 18:17:43.772599 7fdf86b9d700  0 -- 172.20.14.137:6800/5260 >=
>=20
172.20.14.132:0/1974511416
  pipe(0x1ec64780 sd=3D31 pgs=3D0 cs=3D0 l=3D0).accept peer addr is rea=
lly=20
172.20.14.132:0/1974511416 (socke
t is 172.20.14.132:48615/0)

2012-07-09 18:17:43.773170 7fdf8c718700  0 osd.6 347 pg[2.60( v=20
347'36181 (337'35180,347'36181] n=3D4
144 ec=3D1 les/c 6/6 5/5/5) [6,7] r=3D0 lpr=3D5 mlcod 347'36180 active+=
clean]=20
watch: ctx->obc=3D0x102db340
cookie=3D1 oi.version=3D36169 ctx->at_version=3D347'36182
2012-07-09 18:17:43.773209 7fdf8c718700  0 osd.6 347 pg[2.60( v=20
347'36181 (337'35180,347'36181] n=3D4144 ec=3D1 les/c 6/6 5/5/5) [6,7] =
r=3D0=20
lpr=3D5 mlcod 347'36180 active+clean] watch: oi.user_version=3D1559
2012-07-09 18:19:48.837952 7fdf86b9d700  0 bad crc in data 1231964953 !=
=3D=20
exp 2305533436
2012-07-09 18:19:48.838850 7fdf86b9d700  0 -- 172.20.14.137:6800/5260 >=
>=20
172.20.14.132:0/1974511416 pipe(0x1ec64c80 sd=3D31 pgs=3D0 cs=3D0 l=3D0=
).accept=20
peer addr is really 172.20.14.132:0/1974511416 (socket is=20
172.20.14.132:48618/0)
2012-07-09 18:19:48.839493 7fdf8c718700  0 osd.6 347 pg[2.60( v=20
347'36192 (337'35191,347'36192] n=3D4144 ec=3D1 les/c 6/6 5/5/5) [6,7] =
r=3D0=20
lpr=3D5 mlcod 347'36191 active+clean] watch: ctx->obc=3D0x102db340 cook=
ie=3D1=20
oi.version=3D36169 ctx->at_version=3D347'36193
2012-07-09 18:19:48.839530 7fdf8c718700  0 osd.6 347 pg[2.60( v=20
347'36192 (337'35191,347'36192] n=3D4144 ec=3D1 les/c 6/6 5/5/5) [6,7] =
r=3D0=20
lpr=3D5 mlcod 347'36191 active+clean] watch: oi.user_version=3D1559


Each time, at the exact date, a bad CRC (they are the only ones for thi=
s=20
day, so it seems related)

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
