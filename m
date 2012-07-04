From: Gregory Farnum <greg@inktank.com>
Subject: Re: monitor not starting
Date: Wed, 4 Jul 2012 12:05:09 -0700
Message-ID: <9A431747660F45EB8122D5A66F0DEF1A@inktank.com>
References: <4FF42CD7.1060000@smart-weblications.de>
 <D2569975C9B14D6B974C162C58FA7401@inktank.com>
 <4FF47717.1030401@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34413 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab2GDTFH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 15:05:07 -0400
Received: by pbbrp8 with SMTP id rp8so11444418pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jul 2012 12:05:06 -0700 (PDT)
In-Reply-To: <4FF47717.1030401@smart-weblications.de>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: ceph-devel@vger.kernel.org

On Wednesday, July 4, 2012 at 10:02 AM, Smart Weblications GmbH - Flori=
an Wiessner wrote:
> Am 04.07.2012 18:25, schrieb Gregory Farnum:
> > =20
> > =20
> > On Wednesday, July 4, 2012 at 4:45 AM, Smart Weblications GmbH - Fl=
orian Wiessner wrote:
> > =20
> > > Hi List,
> > > =20
> > > =20
> > > i today upgraded from 0.43 to 0.48 and now i have one monitor whi=
ch does not
> > > want to start up anymore:
> > > =20
> > > ceph version 0.48argonaut-125-g4e774fb
> > > (commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
> > > 1: /usr/bin/ceph-mon() [0x52f9c9]
> > > 2: (()+0xeff0) [0x7fb08dd11ff0]
> > > 3: (gsignal()+0x35) [0x7fb08c4f41b5]
> > > 4: (abort()+0x180) [0x7fb08c4f6fc0]
> > > 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fb08cd88d=
c5]
> > > 6: (()+0xcb166) [0x7fb08cd87166]
> > > 7: (()+0xcb193) [0x7fb08cd87193]
> > > 8: (()+0xcb28e) [0x7fb08cd8728e]
> > > 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char =
const*)+0x940)
> > > [0x55b310]
> > > 10: /usr/bin/ceph-mon() [0x497317]
> > > 11: (Monitor::init()+0xc5a) [0x4857fa]
> > > 12: (main()+0x2789) [0x46ac79]
> > > 13: (__libc_start_main()+0xfd) [0x7fb08c4e0c8d]
> > > 14: /usr/bin/ceph-mon() [0x468309]
> > > NOTE: a copy of the executable, or `objdump -rdS <executable>` is=
 needed to
> > > interpret this.
> > > =20
> > > --- end dump of recent events ---
> > > =20
> > > =20
> > > How can i find out why it does not startup anymore? osd and mds i=
s running fine..
> > Is that all the output you get? There should be a line somewhere wh=
ich says what the assert is, and what line number it's on. :)
> =20
> =20
> =20
> =20
> Is this what you are looking for:
> 2012-07-04 11:20:24.448430 7f423d943780 1 mon.3@-1(probing) e1 init f=
sid
> 4553d0f6-1b31-4ba5-9d97-edae55bcaab4
> 2012-07-04 11:20:24.448994 7f423d943780 -1 mon/Paxos.cc (http://Paxos=
=2Ecc): In function 'bool
> Paxos::is_consistent()' thread 7f423d943780 time 2012-07-04 11:20:24.=
448637
> mon/Paxos.cc (http://Paxos.cc): 1031: FAILED assert(consistent || (sl=
urping =3D=3D 1))

Yep, that line. This means the monitor's on-disk state is inconsistent,=
 but I can think of a number of scenarios which could have caused this,=
 depending on how you upgraded your cluster (older monitors didn't mark=
 on-disk whenever they deliberately went inconsistent on a catchup, whi=
ch I bet is what happened here).
 =20
> ceph version 0.48argonaut-125-g4e774fb
> (commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
> 1: /usr/bin/ceph-mon() [0x497317]
> 2: (Monitor::init()+0xc5a) [0x4857fa]
> 3: (main()+0x2789) [0x46ac79]
> 4: (__libc_start_main()+0xfd) [0x7f423bcfbc8d]
> 5: /usr/bin/ceph-mon() [0x468309]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is nee=
ded to
> interpret this.
> =20
> --- begin dump of recent events ---
> -3> 2012-07-04 11:20:24.447613 7f423d943780 1 store(/data/ceph/mon) m=
ount
> -2> 2012-07-04 11:20:24.447722 7f423d943780 0 ceph version
> 0.48argonaut-125-g4e774fb (commit:4e774fbcb38fd6883232b72352512a5f8e4=
a66e8),
> process ceph-mon, pid 7436
> -1> 2012-07-04 11:20:24.448430 7f423d943780 1 mon.3@-1(probing) e1 in=
it
> fsid 4553d0f6-1b31-4ba5-9d97-edae55bcaab4
> 0> 2012-07-04 11:20:24.448994 7f423d943780 -1 mon/Paxos.cc (http://Pa=
xos.cc): In function
> 'bool Paxos::is_consistent()' thread 7f423d943780 time 2012-07-04 11:=
20:24.448637
> mon/Paxos.cc (http://Paxos.cc): 1031: FAILED assert(consistent || (sl=
urping =3D=3D 1))
> =20
> ceph version 0.48argonaut-125-g4e774fb
> (commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
> 1: /usr/bin/ceph-mon() [0x497317]
> 2: (Monitor::init()+0xc5a) [0x4857fa]
> 3: (main()+0x2789) [0x46ac79]
> 4: (__libc_start_main()+0xfd) [0x7f423bcfbc8d]
> 5: /usr/bin/ceph-mon() [0x468309]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is nee=
ded to
> interpret this.
> =20
> --- end dump of recent events ---
> 2012-07-04 11:20:24.449567 7f423d943780 -1 *** Caught signal (Aborted=
) **
> in thread 7f423d943780
> =20
> =20
> > =20
> > And while you're at it, is the rest of the cluster in fact working?=
 I don't think 0.43 to 0.48 is an upgrade path we tested.
> =20
> Anyway, i removed the mon and did a ceph-mon --mkfs with the 3 mons t=
hat were
> still working after the upgrade and got it up and running again.
> =20
> Yes, the cluster is still working after the upgrade. Also upgraded to=
 linux
> 3.4.4 - it feels like the ceph-fuse and kernel ceph client is a littl=
e less
> robust than in 0.43...
> =20
> when i start copying from /ceph to other mp, then it seems that for t=
he copy
> operation or in general for any operation, /ceph is unusable to other=
 processes
> which then makes the client behave very sluggish... :(

Well, it shouldn't have gotten less stable since we haven't made any bi=
g changes there=E2=80=A6but you aren't the only one reporting that thin=
gs seem to be a little bit slower. We're going to have to look at that =
once people are back in the office after Independence Day.
 =20
> =20
> i can send you the contents of the monitor directory where it did not=
 work after
> the upgrade if you want me to..

No, that won't be necessary. Thanks though! =20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
