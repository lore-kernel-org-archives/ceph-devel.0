From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: [ceph-users] scrub error: found clone without head
Date: Fri, 24 May 2013 00:27:53 +0200
Message-ID: <1369348073.3440.3.camel@localhost>
References: <5188F8D2.5040303@bspu.unibel.by>
	 <1369001190.9705.37.camel@localhost> <1369206051.19425.21.camel@localhost>
	 <519CBC66.9030607@bspu.unibel.by>
	 <CA+4uBUYKNnGfH2JnDBmyRy86RovFEOV=pbW2cdhQ2kV0spijXg@mail.gmail.com>
	 <1369247156.22520.42.camel@localhost>
	 <CA+4uBUaAseMNOumZdmRi=XMRifaqLF=JWWFEe9hT+LRduuQJpQ@mail.gmail.com>
	 <1369250303.22520.45.camel@localhost>
	 <CA+4uBUZcsi5eK31p8t+-7jZaERu40O1LSRW6wJOkfho_FwYXkg@mail.gmail.com>
	 <1369310447.19425.43.camel@localhost>
	 <CA+4uBUYPFWBgYqqS7qN1eoQ5ies1S5_R=CCUZoeFPY3Fe+=_mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:35068 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759758Ab3EWW16 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 18:27:58 -0400
In-Reply-To: <CA+4uBUYPFWBgYqqS7qN1eoQ5ies1S5_R=CCUZoeFPY3Fe+=_mA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Denis Kaganovich <mahatma@eu.by>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

No :=20
pg 3.7c is active+clean+inconsistent, acting [24,13,39]
pg 3.6b is active+clean+inconsistent, acting [28,23,5]
pg 3.d is active+clean+inconsistent, acting [29,4,11]
pg 3.1 is active+clean+inconsistent, acting [28,19,5]

But I suppose that all PG *was* having the osd.25 as primary (on the
same host), which is (disabled) buggy OSD.

Question : "12d7" in object path is the snapshot id, right ? If it's th=
e
case, I haven't got any snapshot with this id for the
rb.0.15c26.238e1f29 image.

So, which files should I remove ?

Thanks for your help.


Le jeudi 23 mai 2013 =C3=A0 15:17 -0700, Samuel Just a =C3=A9crit :
> Do all of the affected PGs share osd.28 as the primary?  I think the
> only recovery is probably to manually remove the orphaned clones.
> -Sam
>=20
> On Thu, May 23, 2013 at 5:00 AM, Olivier Bonvalet <ceph.list@daevel.f=
r> wrote:
> > Not yet. I keep it for now.
> >
> > Le mercredi 22 mai 2013 =C3=A0 15:50 -0700, Samuel Just a =C3=A9cri=
t :
> >> rb.0.15c26.238e1f29
> >>
> >> Has that rbd volume been removed?
> >> -Sam
> >>
> >> On Wed, May 22, 2013 at 12:18 PM, Olivier Bonvalet <ceph.list@daev=
el.fr> wrote:
> >> > 0.61-11-g3b94f03 (0.61-1.1), but the bug occured with bobtail.
> >> >
> >> >
> >> > Le mercredi 22 mai 2013 =C3=A0 12:00 -0700, Samuel Just a =C3=A9=
crit :
> >> >> What version are you running?
> >> >> -Sam
> >> >>
> >> >> On Wed, May 22, 2013 at 11:25 AM, Olivier Bonvalet <ceph.list@d=
aevel.fr> wrote:
> >> >> > Is it enough ?
> >> >> >
> >> >> > # tail -n500 -f /var/log/ceph/osd.28.log | grep -A5 -B5 'foun=
d clone without head'
> >> >> > 2013-05-22 15:43:09.308352 7f707dd64700  0 log [INF] : 9.105 =
scrub ok
> >> >> > 2013-05-22 15:44:21.054893 7f707dd64700  0 log [INF] : 9.451 =
scrub ok
> >> >> > 2013-05-22 15:44:52.898784 7f707cd62700  0 log [INF] : 9.784 =
scrub ok
> >> >> > 2013-05-22 15:47:43.148515 7f707cd62700  0 log [INF] : 9.3c3 =
scrub ok
> >> >> > 2013-05-22 15:47:45.717085 7f707dd64700  0 log [INF] : 9.3d0 =
scrub ok
> >> >> > 2013-05-22 15:52:14.573815 7f707dd64700  0 log [ERR] : scrub =
3.6b ade3c16b/rb.0.15c26.238e1f29.000000009221/12d7//3 found clone with=
out head
> >> >> > 2013-05-22 15:55:07.230114 7f707d563700  0 log [ERR] : scrub =
3.6b 261cc0eb/rb.0.15c26.238e1f29.000000003671/12d7//3 found clone with=
out head
> >> >> > 2013-05-22 15:56:56.456242 7f707d563700  0 log [ERR] : scrub =
3.6b b10deaeb/rb.0.15c26.238e1f29.0000000086a2/12d7//3 found clone with=
out head
> >> >> > 2013-05-22 15:57:51.667085 7f707dd64700  0 log [ERR] : 3.6b s=
crub 3 errors
> >> >> > 2013-05-22 15:57:55.241224 7f707dd64700  0 log [INF] : 9.450 =
scrub ok
> >> >> > 2013-05-22 15:57:59.800383 7f707cd62700  0 log [INF] : 9.465 =
scrub ok
> >> >> > 2013-05-22 15:59:55.024065 7f707661a700  0 -- 192.168.42.3:68=
03/12142 >> 192.168.42.5:6828/31490 pipe(0x2a689000 sd=3D108 :6803 s=3D=
2 pgs=3D200652 cs=3D73 l=3D0).fault with nothing to send, going to stan=
dby
> >> >> > 2013-05-22 16:01:45.542579 7f7022770700  0 -- 192.168.42.3:68=
03/12142 >> 192.168.42.5:6828/31490 pipe(0x2a689280 sd=3D99 :6803 s=3D0=
 pgs=3D0 cs=3D0 l=3D0).accept connect_seq 74 vs existing 73 state stand=
by
> >> >> > --
> >> >> > 2013-05-22 16:29:49.544310 7f707dd64700  0 log [INF] : 9.4eb =
scrub ok
> >> >> > 2013-05-22 16:29:53.190233 7f707dd64700  0 log [INF] : 9.4f4 =
scrub ok
> >> >> > 2013-05-22 16:29:59.478736 7f707dd64700  0 log [INF] : 8.6bb =
scrub ok
> >> >> > 2013-05-22 16:35:12.240246 7f7022770700  0 -- 192.168.42.3:68=
03/12142 >> 192.168.42.5:6828/31490 pipe(0x2a689280 sd=3D99 :6803 s=3D2=
 pgs=3D200667 cs=3D75 l=3D0).fault with nothing to send, going to stand=
by
> >> >> > 2013-05-22 16:35:19.519019 7f707d563700  0 log [INF] : 8.700 =
scrub ok
> >> >> > 2013-05-22 16:39:15.422532 7f707dd64700  0 log [ERR] : scrub =
3.1 b1869301/rb.0.15c26.238e1f29.000000000836/12d7//3 found clone witho=
ut head
> >> >> > 2013-05-22 16:40:04.995256 7f707cd62700  0 log [ERR] : scrub =
3.1 bccad701/rb.0.15c26.238e1f29.000000009a00/12d7//3 found clone witho=
ut head
> >> >> > 2013-05-22 16:41:07.008717 7f707d563700  0 log [ERR] : scrub =
3.1 8a9bec01/rb.0.15c26.238e1f29.000000009820/12d7//3 found clone witho=
ut head
> >> >> > 2013-05-22 16:41:42.460280 7f707c561700  0 log [ERR] : 3.1 sc=
rub 3 errors
> >> >> > 2013-05-22 16:46:12.385678 7f7077735700  0 -- 192.168.42.3:68=
03/12142 >> 192.168.42.5:6828/31490 pipe(0x2a689c80 sd=3D137 :6803 s=3D=
0 pgs=3D0 cs=3D0 l=3D0).accept connect_seq 76 vs existing 75 state stan=
dby
> >> >> > 2013-05-22 16:58:36.079010 7f707661a700  0 -- 192.168.42.3:68=
03/12142 >> 192.168.42.3:6801/11745 pipe(0x2a689a00 sd=3D44 :6803 s=3D0=
 pgs=3D0 cs=3D0 l=3D0).accept connect_seq 40 vs existing 39 state stand=
by
> >> >> > 2013-05-22 16:58:36.798038 7f707d563700  0 log [INF] : 9.50c =
scrub ok
> >> >> > 2013-05-22 16:58:40.104159 7f707c561700  0 log [INF] : 9.526 =
scrub ok
> >> >> >
> >> >> >
> >> >> > Note : I have 8 scrub errors like that, on 4 impacted PG, and=
 all impacted objects are about the same RBD image (rb.0.15c26.238e1f29=
).
> >> >> >
> >> >> >
> >> >> >
> >> >> > Le mercredi 22 mai 2013 =C3=A0 11:01 -0700, Samuel Just a =C3=
=A9crit :
> >> >> >> Can you post your ceph.log with the period including all of =
these errors?
> >> >> >> -Sam
> >> >> >>
> >> >> >> On Wed, May 22, 2013 at 5:39 AM, Dzianis Kahanovich
> >> >> >> <mahatma@bspu.unibel.by> wrote:
> >> >> >> > Olivier Bonvalet =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> >> >> >>
> >> >> >> >> Le lundi 20 mai 2013 =C3=A0 00:06 +0200, Olivier Bonvalet=
 a =C3=A9crit :
> >> >> >> >>> Le mardi 07 mai 2013 =C3=A0 15:51 +0300, Dzianis Kahanov=
ich a =C3=A9crit :
> >> >> >> >>>> I have 4 scrub errors (3 PGs - "found clone without hea=
d"), on one OSD. Not
> >> >> >> >>>> repairing. How to repair it exclude re-creating of OSD?
> >> >> >> >>>>
> >> >> >> >>>> Now it "easy" to clean+create OSD, but in theory - in c=
ase there are multiple
> >> >> >> >>>> OSDs - it may cause data lost.
> >> >> >> >>>
> >> >> >> >>> I have same problem : 8 objects (4 PG) with error "found=
 clone without
> >> >> >> >>> head". How can I fix that ?
> >> >> >> >> since "pg repair" doesn't handle that kind of errors, is =
there a way to
> >> >> >> >> manually fix that ? (it's a production cluster)
> >> >> >> >
> >> >> >> > Trying to fix manually I cause assertions in trimming proc=
ess (died OSD). And
> >> >> >> > many others troubles. So, if you want to keep cluster runn=
ing, wait for
> >> >> >> > developers answer. IMHO.
> >> >> >> >
> >> >> >> > About manual repair attempt: see issue #4937. Also similar=
 results - in subject
> >> >> >> > "Inconsistent PG's, repair ineffective".
> >> >> >> >
> >> >> >> > --
> >> >> >> > WBR, Dzianis Kahanovich AKA Denis Kaganovich, http://mahat=
ma.bspu.unibel.by/
> >> >> >> > _______________________________________________
> >> >> >> > ceph-users mailing list
> >> >> >> > ceph-users@lists.ceph.com
> >> >> >> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >> >> >>
> >> >> >
> >> >> >
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
> >> >>
> >> >
> >> >
> >>
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
