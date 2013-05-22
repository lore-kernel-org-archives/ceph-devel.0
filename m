From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: [ceph-users] scrub error: found clone without head
Date: Wed, 22 May 2013 21:18:23 +0200
Message-ID: <1369250303.22520.45.camel@localhost>
References: <5188F8D2.5040303@bspu.unibel.by>
	 <1369001190.9705.37.camel@localhost> <1369206051.19425.21.camel@localhost>
	 <519CBC66.9030607@bspu.unibel.by>
	 <CA+4uBUYKNnGfH2JnDBmyRy86RovFEOV=pbW2cdhQ2kV0spijXg@mail.gmail.com>
	 <1369247156.22520.42.camel@localhost>
	 <CA+4uBUaAseMNOumZdmRi=XMRifaqLF=JWWFEe9hT+LRduuQJpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:38137 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab3EVTS1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 May 2013 15:18:27 -0400
In-Reply-To: <CA+4uBUaAseMNOumZdmRi=XMRifaqLF=JWWFEe9hT+LRduuQJpQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Denis Kaganovich <mahatma@eu.by>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

0.61-11-g3b94f03 (0.61-1.1), but the bug occured with bobtail.


Le mercredi 22 mai 2013 =C3=A0 12:00 -0700, Samuel Just a =C3=A9crit :
> What version are you running?
> -Sam
>=20
> On Wed, May 22, 2013 at 11:25 AM, Olivier Bonvalet <ceph.list@daevel.=
fr> wrote:
> > Is it enough ?
> >
> > # tail -n500 -f /var/log/ceph/osd.28.log | grep -A5 -B5 'found clon=
e without head'
> > 2013-05-22 15:43:09.308352 7f707dd64700  0 log [INF] : 9.105 scrub =
ok
> > 2013-05-22 15:44:21.054893 7f707dd64700  0 log [INF] : 9.451 scrub =
ok
> > 2013-05-22 15:44:52.898784 7f707cd62700  0 log [INF] : 9.784 scrub =
ok
> > 2013-05-22 15:47:43.148515 7f707cd62700  0 log [INF] : 9.3c3 scrub =
ok
> > 2013-05-22 15:47:45.717085 7f707dd64700  0 log [INF] : 9.3d0 scrub =
ok
> > 2013-05-22 15:52:14.573815 7f707dd64700  0 log [ERR] : scrub 3.6b a=
de3c16b/rb.0.15c26.238e1f29.000000009221/12d7//3 found clone without he=
ad
> > 2013-05-22 15:55:07.230114 7f707d563700  0 log [ERR] : scrub 3.6b 2=
61cc0eb/rb.0.15c26.238e1f29.000000003671/12d7//3 found clone without he=
ad
> > 2013-05-22 15:56:56.456242 7f707d563700  0 log [ERR] : scrub 3.6b b=
10deaeb/rb.0.15c26.238e1f29.0000000086a2/12d7//3 found clone without he=
ad
> > 2013-05-22 15:57:51.667085 7f707dd64700  0 log [ERR] : 3.6b scrub 3=
 errors
> > 2013-05-22 15:57:55.241224 7f707dd64700  0 log [INF] : 9.450 scrub =
ok
> > 2013-05-22 15:57:59.800383 7f707cd62700  0 log [INF] : 9.465 scrub =
ok
> > 2013-05-22 15:59:55.024065 7f707661a700  0 -- 192.168.42.3:6803/121=
42 >> 192.168.42.5:6828/31490 pipe(0x2a689000 sd=3D108 :6803 s=3D2 pgs=3D=
200652 cs=3D73 l=3D0).fault with nothing to send, going to standby
> > 2013-05-22 16:01:45.542579 7f7022770700  0 -- 192.168.42.3:6803/121=
42 >> 192.168.42.5:6828/31490 pipe(0x2a689280 sd=3D99 :6803 s=3D0 pgs=3D=
0 cs=3D0 l=3D0).accept connect_seq 74 vs existing 73 state standby
> > --
> > 2013-05-22 16:29:49.544310 7f707dd64700  0 log [INF] : 9.4eb scrub =
ok
> > 2013-05-22 16:29:53.190233 7f707dd64700  0 log [INF] : 9.4f4 scrub =
ok
> > 2013-05-22 16:29:59.478736 7f707dd64700  0 log [INF] : 8.6bb scrub =
ok
> > 2013-05-22 16:35:12.240246 7f7022770700  0 -- 192.168.42.3:6803/121=
42 >> 192.168.42.5:6828/31490 pipe(0x2a689280 sd=3D99 :6803 s=3D2 pgs=3D=
200667 cs=3D75 l=3D0).fault with nothing to send, going to standby
> > 2013-05-22 16:35:19.519019 7f707d563700  0 log [INF] : 8.700 scrub =
ok
> > 2013-05-22 16:39:15.422532 7f707dd64700  0 log [ERR] : scrub 3.1 b1=
869301/rb.0.15c26.238e1f29.000000000836/12d7//3 found clone without hea=
d
> > 2013-05-22 16:40:04.995256 7f707cd62700  0 log [ERR] : scrub 3.1 bc=
cad701/rb.0.15c26.238e1f29.000000009a00/12d7//3 found clone without hea=
d
> > 2013-05-22 16:41:07.008717 7f707d563700  0 log [ERR] : scrub 3.1 8a=
9bec01/rb.0.15c26.238e1f29.000000009820/12d7//3 found clone without hea=
d
> > 2013-05-22 16:41:42.460280 7f707c561700  0 log [ERR] : 3.1 scrub 3 =
errors
> > 2013-05-22 16:46:12.385678 7f7077735700  0 -- 192.168.42.3:6803/121=
42 >> 192.168.42.5:6828/31490 pipe(0x2a689c80 sd=3D137 :6803 s=3D0 pgs=3D=
0 cs=3D0 l=3D0).accept connect_seq 76 vs existing 75 state standby
> > 2013-05-22 16:58:36.079010 7f707661a700  0 -- 192.168.42.3:6803/121=
42 >> 192.168.42.3:6801/11745 pipe(0x2a689a00 sd=3D44 :6803 s=3D0 pgs=3D=
0 cs=3D0 l=3D0).accept connect_seq 40 vs existing 39 state standby
> > 2013-05-22 16:58:36.798038 7f707d563700  0 log [INF] : 9.50c scrub =
ok
> > 2013-05-22 16:58:40.104159 7f707c561700  0 log [INF] : 9.526 scrub =
ok
> >
> >
> > Note : I have 8 scrub errors like that, on 4 impacted PG, and all i=
mpacted objects are about the same RBD image (rb.0.15c26.238e1f29).
> >
> >
> >
> > Le mercredi 22 mai 2013 =C3=A0 11:01 -0700, Samuel Just a =C3=A9cri=
t :
> >> Can you post your ceph.log with the period including all of these =
errors?
> >> -Sam
> >>
> >> On Wed, May 22, 2013 at 5:39 AM, Dzianis Kahanovich
> >> <mahatma@bspu.unibel.by> wrote:
> >> > Olivier Bonvalet =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> >>
> >> >> Le lundi 20 mai 2013 =C3=A0 00:06 +0200, Olivier Bonvalet a =C3=
=A9crit :
> >> >>> Le mardi 07 mai 2013 =C3=A0 15:51 +0300, Dzianis Kahanovich a =
=C3=A9crit :
> >> >>>> I have 4 scrub errors (3 PGs - "found clone without head"), o=
n one OSD. Not
> >> >>>> repairing. How to repair it exclude re-creating of OSD?
> >> >>>>
> >> >>>> Now it "easy" to clean+create OSD, but in theory - in case th=
ere are multiple
> >> >>>> OSDs - it may cause data lost.
> >> >>>
> >> >>> I have same problem : 8 objects (4 PG) with error "found clone=
 without
> >> >>> head". How can I fix that ?
> >> >> since "pg repair" doesn't handle that kind of errors, is there =
a way to
> >> >> manually fix that ? (it's a production cluster)
> >> >
> >> > Trying to fix manually I cause assertions in trimming process (d=
ied OSD). And
> >> > many others troubles. So, if you want to keep cluster running, w=
ait for
> >> > developers answer. IMHO.
> >> >
> >> > About manual repair attempt: see issue #4937. Also similar resul=
ts - in subject
> >> > "Inconsistent PG's, repair ineffective".
> >> >
> >> > --
> >> > WBR, Dzianis Kahanovich AKA Denis Kaganovich, http://mahatma.bsp=
u.unibel.by/
> >> > _______________________________________________
> >> > ceph-users mailing list
> >> > ceph-users@lists.ceph.com
> >> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
