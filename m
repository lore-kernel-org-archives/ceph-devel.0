From: Gregory Farnum <greg@inktank.com>
Subject: Re: oops in rbd module (con_work in libceph)
Date: Tue, 10 Jul 2012 10:46:25 -0700
Message-ID: <CAPYLRzj0=hs5BYrG2veYMBUOaU1HmAJoBRPdwj1y3PuMUveb0w@mail.gmail.com>
References: <4FF6A27B.7020808@univ-nantes.fr>
	<4FF705BA.4080501@univ-nantes.fr>
	<4FF77FE8.9040408@inktank.com>
	<4FFB0CBA.6090806@univ-nantes.fr>
	<4FFB0F2A.6070601@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64735 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab2GJRq1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 13:46:27 -0400
Received: by lbbgm6 with SMTP id gm6so727457lbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 10:46:25 -0700 (PDT)
In-Reply-To: <4FFB0F2A.6070601@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Alex Elder <elder@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jul 9, 2012 at 10:04 AM, Yann Dupont <Yann.Dupont@univ-nantes.f=
r> wrote:
> Le 09/07/2012 18:54, Yann Dupont a =E9crit :
>
>>
>> Ok. I've compiled the kernel this afternoon, and tested it without m=
uch
>> success :
>>
>> Jul  9 18:17:23 label5.u14.univ-nantes.prive kernel: [ 284.116236]
>> libceph: osd0 172.20.14.130:6801 socket closed
>> Jul  9 18:17:43 label5.u14.univ-nantes.prive kernel: [ 304.101545]
>> libceph: osd6 172.20.14.137:6800 socket closed
>> Jul  9 18:17:53 label5.u14.univ-nantes.prive kernel: [ 314.095155]
>> libceph: osd3 172.20.14.134:6800 socket closed
>> Jul  9 18:18:38 label5.u14.univ-nantes.prive kernel: [ 359.075473]
>> libceph: osd5 172.20.14.136:6800 socket closed
>> Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [ 429.107334]
>> libceph: osd6 172.20.14.137:6800 socket closed
>
>
> just an interesting thing I just noticed in the logs :
>
> osd-0.log
> 2012-07-09 18:17:23.763925 7ff9fc19e700  0 bad crc in data 3071411075=
 !=3D exp
> 2231697357
> 2012-07-09 18:17:23.777607 7ff9fc19e700  0 -- 172.20.14.130:6801/5842=
 >>
> 172.20.14.132:0/1974511416 pipe(0x2236c80 sd=3D38 pgs=3D0 cs=3D0 l=3D=
0).accept peer
> addr is really 172.20.14.132:0/1974511416 (socket is 172.20.14.132:57=
972/0)
>
> osd-3.log
> 2012-07-09 18:17:53.770111 7fe35461c700  0 bad crc in data 826922774 =
!=3D exp
> 2498450653
> 2012-07-09 18:17:53.770972 7fe35461c700  0 -- 172.20.14.134:6800/4495=
 >>
> 172.20.14.132:0/1974511416
>  pipe(0xa44ec80 sd=3D56 pgs=3D0 cs=3D0 l=3D0).accept peer addr is rea=
lly
> 172.20.14.132:0/1974511416 (socket
>  is 172.20.14.132:40726/0)
>
> osd-5.log
> 2012-07-09 18:18:38.766417 7ff4a66cb700  0 bad crc in data 3949121728=
 !=3D exp
> 2496058560
> 2012-07-09 18:18:38.773386 7ff4a66cb700  0 -- 172.20.14.136:6800/4876=
 >>
> 172.20.14.132:0/1974511416 pipe(0x20eeb780 sd=3D56 pgs=3D0 cs=3D0 l=3D=
0).accept peer
> addr is really 172.20.14.132:0/1974511416 (socket is 172.20.14.132:57=
072/0)
>
> osd-6.log
> 2012-07-09 18:17:43.765740 7fdf86b9d700  0 bad crc in data 2899452345=
 !=3D exp
> 2656886014
> 2012-07-09 18:17:43.772599 7fdf86b9d700  0 -- 172.20.14.137:6800/5260=
 >>
> 172.20.14.132:0/1974511416
>  pipe(0x1ec64780 sd=3D31 pgs=3D0 cs=3D0 l=3D0).accept peer addr is re=
ally
> 172.20.14.132:0/1974511416 (socke
> t is 172.20.14.132:48615/0)
>
> 2012-07-09 18:17:43.773170 7fdf8c718700  0 osd.6 347 pg[2.60( v 347'3=
6181
> (337'35180,347'36181] n=3D4
> 144 ec=3D1 les/c 6/6 5/5/5) [6,7] r=3D0 lpr=3D5 mlcod 347'36180 activ=
e+clean]
> watch: ctx->obc=3D0x102db340
> cookie=3D1 oi.version=3D36169 ctx->at_version=3D347'36182
> 2012-07-09 18:17:43.773209 7fdf8c718700  0 osd.6 347 pg[2.60( v 347'3=
6181
> (337'35180,347'36181] n=3D4144 ec=3D1 les/c 6/6 5/5/5) [6,7] r=3D0 lp=
r=3D5 mlcod
> 347'36180 active+clean] watch: oi.user_version=3D1559
> 2012-07-09 18:19:48.837952 7fdf86b9d700  0 bad crc in data 1231964953=
 !=3D exp
> 2305533436
> 2012-07-09 18:19:48.838850 7fdf86b9d700  0 -- 172.20.14.137:6800/5260=
 >>
> 172.20.14.132:0/1974511416 pipe(0x1ec64c80 sd=3D31 pgs=3D0 cs=3D0 l=3D=
0).accept peer
> addr is really 172.20.14.132:0/1974511416 (socket is 172.20.14.132:48=
618/0)
> 2012-07-09 18:19:48.839493 7fdf8c718700  0 osd.6 347 pg[2.60( v 347'3=
6192
> (337'35191,347'36192] n=3D4144 ec=3D1 les/c 6/6 5/5/5) [6,7] r=3D0 lp=
r=3D5 mlcod
> 347'36191 active+clean] watch: ctx->obc=3D0x102db340 cookie=3D1 oi.ve=
rsion=3D36169
> ctx->at_version=3D347'36193
> 2012-07-09 18:19:48.839530 7fdf8c718700  0 osd.6 347 pg[2.60( v 347'3=
6192
> (337'35191,347'36192] n=3D4144 ec=3D1 les/c 6/6 5/5/5) [6,7] r=3D0 lp=
r=3D5 mlcod
> 347'36191 active+clean] watch: oi.user_version=3D1559
>
>
> Each time, at the exact date, a bad CRC (they are the only ones for t=
his
> day, so it seems related)

Yes; a bad CRC should cause the socket to close =97=A0that's intended
behavior (although you might want to look into why that's happening,
since it's not something we've seen locally at all). Not handling that
socket close is definitely a bug in the kernel that needs to get
tracked down, though.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
