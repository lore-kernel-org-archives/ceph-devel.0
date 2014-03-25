From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 22:41:15 +0100
Message-ID: <1395783675.2076.26.camel@localhost>
References: <1395736765.2823.29.camel@localhost>
	 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
	 <53316D18.7040103@ieee.org>
	 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
	 <53317BC2.9010700@ieee.org>
	 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
	 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>
	 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>
	 <5331C05D.1060008@ieee.org> <1395773582.2076.10.camel@localhost>
	 <5331D2E8.6060002@ieee.org>
	 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>
	 <1395778894.2076.12.camel@localhost> <1395780835.2076.15.camel@localhost>
	 <1395781847.2076.21.camel@localhost>
	 <CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>
	 <1395782577.2076.23.camel@localhost>
	 <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:42624 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbaCYVlS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 17:41:18 -0400
In-Reply-To: <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>

Le mardi 25 mars 2014 =C3=A0 23:25 +0200, Ilya Dryomov a =C3=A9crit :
> On Tue, Mar 25, 2014 at 11:22 PM, Olivier Bonvalet <ceph.list@daevel.=
fr> wrote:
> > Le mardi 25 mars 2014 =C3=A0 23:20 +0200, Ilya Dryomov a =C3=A9crit=
 :
> >> On Tue, Mar 25, 2014 at 11:10 PM, Olivier Bonvalet <ceph.list@daev=
el.fr> wrote:
> >> > The third (now with rbd_assort(0)) :
> >> >
> >> > Mar 25 22:08:12 alg kernel: [  598.301895] rbd_img_obj_callback:=
 bad image object request information:
> >> > Mar 25 22:08:12 alg kernel: [  598.301900] obj_request ffff88022=
409e1b8
> >> > Mar 25 22:08:12 alg kernel: [  598.301901]     ->object_name <(n=
ull)>
> >> > Mar 25 22:08:12 alg kernel: [  598.301902]     ->offset 0
> >> > Mar 25 22:08:12 alg kernel: [  598.301903]     ->length 8192
> >> > Mar 25 22:08:12 alg kernel: [  598.301904]     ->type 0x1
> >> > Mar 25 22:08:12 alg kernel: [  598.301905]     ->flags 0x3
> >> > Mar 25 22:08:12 alg kernel: [  598.301906]     ->which 429496729=
5
> >> > Mar 25 22:08:12 alg kernel: [  598.301906]     ->xferred 8192
> >> > Mar 25 22:08:12 alg kernel: [  598.301907]     ->result 0
> >> > Mar 25 22:08:12 alg kernel: [  598.301908] img_request ffff88023=
03bff10
> >> > Mar 25 22:08:12 alg kernel: [  598.301909]     ->snap 0xffff8802=
2711f500
> >> > Mar 25 22:08:12 alg kernel: [  598.301910]     ->offset 44920791=
04
> >> > Mar 25 22:08:12 alg kernel: [  598.301911]     ->length 28672
> >> > Mar 25 22:08:12 alg kernel: [  598.301912]     ->flags 0x1
> >> > Mar 25 22:08:12 alg kernel: [  598.301913]     ->obj_request_cou=
nt 0
> >> > Mar 25 22:08:12 alg kernel: [  598.301913]     ->next_completion=
 2
> >> > Mar 25 22:08:12 alg kernel: [  598.301914]     ->xferred 28672
> >> > Mar 25 22:08:12 alg kernel: [  598.301915]     ->result 0
> >> > Mar 25 22:08:12 alg kernel: [  598.301916]
> >> > Mar 25 22:08:12 alg kernel: [  598.301916] Assertion failure in =
rbd_img_obj_callback() at line 2159:
> >> > Mar 25 22:08:12 alg kernel: [  598.301916]
> >> > Mar 25 22:08:12 alg kernel: [  598.301916]      rbd_assert(0);
> >> > Mar 25 22:08:12 alg kernel: [  598.301916]
> >> > Mar 25 22:08:12 alg kernel: [  598.302093] ------------[ cut her=
e ]------------
> >>
> >> Hmm...  Can you attach your drivers/block/rbd.c as of this third
> >> occurence?
> >>
> >> Thanks,
> >>
> >>                 Ilya
> >>
> >
> > Of course.
>=20
> Sorry, I asked for the drivers/block/rbd.c C source file.
>=20
> Thanks,
>=20
>                 Ilya
>=20

mmm the cluster seems to be in a really bad state now : all hosts are
hanging. Is it possible that mounting images without the rbd_assert(0)
broke some images ?


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
