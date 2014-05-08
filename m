From: Gregory Farnum <greg@inktank.com>
Subject: Re: CEPH - messenger rebind race
Date: Thu, 8 May 2014 07:16:30 -0700
Message-ID: <CAPYLRzio=KH4XSMcs3PYjnvJ47asoFd9JqrSGSYR_OAZn2z-wA@mail.gmail.com>
References: <1399452455.72957.YahooMailNeo@web140901.mail.bf1.yahoo.com>
	<alpine.DEB.2.00.1405071725210.24873@cobra.newdream.net>
	<CAPYLRzgZ7ssZHJkV-FMbgmsiq8K2QGmqGzv-vySOXggBdx3-uA@mail.gmail.com>
	<292059AA-68AF-4406-A7E2-F71D7428D2F7@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:63171 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbaEHOQb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 May 2014 10:16:31 -0400
Received: by mail-qg0-f49.google.com with SMTP id a108so2799106qge.22
        for <ceph-devel@vger.kernel.org>; Thu, 08 May 2014 07:16:30 -0700 (PDT)
In-Reply-To: <292059AA-68AF-4406-A7E2-F71D7428D2F7@yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang <yguang11@yahoo.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, May 8, 2014 at 12:12 AM, Guang <yguang11@yahoo.com> wrote:
> Thanks Sage and Greg!
>
> I just capture a crash from which I get the logs from both side (sadl=
y we
> still use debug_ms=3D0 as increasing the debug_ms level dramatically =
consume
> more disk spaces), from the log, I think I get some more clues how th=
is
> failure happened.
>
> Let us say we have two messengers C and S, at C side, it did a rebind=
 and
> cleared everything.
> The logs at C side are:
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94
>  -6> 2014-05-07 12:29:35.362448 7fcc26e8c700  2 --
> 10.193.207.191:6918/24089488 >> 10.193.207.182:6982/57027253 pipe(0x1=
9cfec80
> sd=3D139 :48953 s=3D1 pgs=3D0 cs=3D0 l=3D0 c=3D0x13d62c
>  60). got newly_acked_seq 59 vs out_seq 0
>      -5> 2014-05-07 12:29:35.362487 7fcc26e8c700  2 --
> 10.193.207.191:6918/24089488 >> 10.193.207.182:6982/57027253 pipe(0x1=
9cfec80
> sd=3D139 :48953 s=3D1 pgs=3D0 cs=3D0 l=3D0 c=3D0x13d62c
>  60). discarding previously sent 0 osd_map(36192..36196 src has
> 35392..36196) v3
>      -4> 2014-05-07 12:29:35.362504 7fcc26e8c700  2 --
> 10.193.207.191:6918/24089488 >> 10.193.207.182:6982/57027253 pipe(0x1=
9cfec80
> sd=3D139 :48953 s=3D1 pgs=3D0 cs=3D0 l=3D0 c=3D0x13d62c
>  60). discarding previously sent 0 pg_notify(4.4d21(21) epoch 36196) =
v4
>      -3> 2014-05-07 12:29:35.362530 7fcc26e8c700  2 --
> 10.193.207.191:6918/24089488 >> 10.193.207.182:6982/57027253 pipe(0x1=
9cfec80
> sd=3D139 :48953 s=3D1 pgs=3D0 cs=3D0 l=3D0 c=3D0x13d62c
>  60). discarding previously sent 0 pg_notify(3.4d22(21) epoch 36196) =
v4
>      -2> 2014-05-07 12:29:35.362561 7fcc26e8c700  2 --
> 10.193.207.191:6918/24089488 >> 10.193.207.182:6982/57027253 pipe(0x1=
9cfec80
> sd=3D139 :48953 s=3D1 pgs=3D0 cs=3D0 l=3D0 c=3D0x13d62c
>  60). discarding previously sent 0 pg_query(4.3279 epoch 36196) v2
>      -1> 2014-05-07 12:29:35.362571 7fcc26e8c700  2 --
> 10.193.207.191:6918/24089488 >> 10.193.207.182:6982/57027253 pipe(0x1=
9cfec80
> sd=3D139 :48953 s=3D1 pgs=3D0 cs=3D0 l=3D0 c=3D0x13d62c
>  60). discarding previously sent 0 pg_query(3.327a epoch 36196) v2
>       0> 2014-05-07 12:29:35.363457 7fcc26e8c700 -1 msg/Pipe.cc: In f=
unction
> 'int Pipe::connect()' thread 7fcc26e8c700 time 2014-05-07 12:29:35.36=
2587
>  msg/Pipe.cc: 1045: FAILED assert(m)
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94
> The logs at S side are:
> =E2=80=94=E2=80=94=E2=80=94
> 2014-05-07 12:29:09.820735 7eff50794700  0 -- 10.193.207.182:6982/570=
27253
>>> 10.193.207.191:6918/24089488 pipe(0x170bf680 sd=3D63 :57524 s=3D2 p=
gs=3D24805
> cs=3D1 l=3D0 c=3D0x1691b340).fault with nothing to send, going to sta=
ndby
> 2014-05-07 12:29:35.361030 7eff40042700 10 osd.363 36196  new session
> 0x17d33500 con=3D0x17fdf080 addr=3D10.193.207.191:6918/24089488
> 2014-05-07 12:29:35.361068 7eff40042700  0 -- 10.193.207.182:6982/570=
27253
>>> 10.193.207.191:6918/24089488 pipe(0xfe07400 sd=3D343 :6982 s=3D0 pg=
s=3D0 cs=3D0
> l=3D0 c=3D0x17fdf080).accept
>  connect_seq 0 vs existing 1 state standby
> 2014-05-07 12:29:35.361078 7eff40042700  0 -- 10.193.207.182:6982/570=
27253
>>> 10.193.207.191:6918/24089488 pipe(0xfe07400 sd=3D343 :6982 s=3D0 pg=
s=3D0 cs=3D0
> l=3D0 c=3D0x17fdf080).accept
>  peer reset, then tried to connect to us, replacing
> =E2=80=94=E2=80=94=E2=80=94
> And it looks like the below round trips happened between the two side=
s.
>  1. C tried to establish a new connection (when it gets some message =
to
> send) with S with cs=3D0 (and a new larger pgs)
>  2. At S side, there was an existing connection with C (cs=3D1, pgs=3D=
24805,
> in_seq>59).
>  3. This is what happened at S side:
>       3.1 lookup pipe and find an existing one -
> https://github.com/ceph/ceph/blob/master/src/msg/Pipe.cc#L445
>       3.2 the execution flow comes to replacing the existing pipe -
> https://github.com/ceph/ceph/blob/master/src/msg/Pipe.cc#L473
>       3.3 as this is a lossy connection, the original pipe would be c=
leared.
>       3.4 then it comes to the open section
> (https://github.com/ceph/ceph/blob/master/src/msg/Pipe.cc#L649) and e=
cho
> back a reply with tag CEPH_MSGR_TAG_SEQ along with the seq from origi=
nal
> pipe
> 4. At C side
> 4.1 as this is a brand new pipe so that out_seq is zero, however, the=
 above
> message comes with along a original newly_ack_seq, this bring the ass=
ertion
> failure we observed.
>
> If this makes sense, at step 3.4, we properly should not echo origina=
l seq
> if this is a branch new connection attempt (cs =3D 0).
>
> Does this look like reasonable?

Ah! Yes, you're exactly right. This error makes sense; too =E2=80=94 th=
e
CEPH_MSGR_TAG_SEQ is much newer than the rest of the reconnect logic.

On Thu, May 8, 2014 at 4:58 AM, Guang <yguang11@yahoo.com> wrote:
> I think the next question is, why C failed to find a PIPE (locally) f=
or S
> but there is actually one PIPE existing at S side (with C), is it pos=
sible
> that C unregister the pipe but S has not been aware yet?

Exactly. In the other logs I've seen, C has done a mark_down_all()
(which kills every single pipe) while doing a rebind(); generally this
is as a consequence of getting an OSDMap which says it's down. If S
has not yet seen this map, it won't have nuked the Connection on its
side.

Would you like to prepare a patch, or should I? :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
