From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 22:10:47 +0100
Message-ID: <1395781847.2076.21.camel@localhost>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:42090 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbaCYVKu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 17:10:50 -0400
In-Reply-To: <1395780835.2076.15.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>

Le mardi 25 mars 2014 =C3=A0 21:53 +0100, Olivier Bonvalet a =C3=A9crit=
 :
> Le mardi 25 mars 2014 =C3=A0 21:21 +0100, Olivier Bonvalet a =C3=A9cr=
it :
> > Le mardi 25 mars 2014 =C3=A0 22:18 +0200, Ilya Dryomov a =C3=A9crit=
 :
> > > On Tue, Mar 25, 2014 at 9:03 PM, Alex Elder <elder@ieee.org> wrot=
e:
> > > > On 03/25/2014 01:53 PM, Olivier Bonvalet wrote:
> > > >> Le mardi 25 mars 2014 =C3=A0 12:43 -0500, Alex Elder a =C3=A9c=
rit :
> > > >>> Please try applying this, on top of the previous patch.
> > > >>> If you can then reproduce the problem we'll have a bunch
> > > >>> of new information about the particular request that's
> > > >>> leading to the failure.  That might tell us what more we
> > > >>> can do to find the root cause.  Thank you.
> > > >>>
> > > >>>                                      -Alex
> > > >>>
> > > >>> PS  I hope my mailer doesn't botch the long lines.  It might.
> > > >>>
> > > >>
> > > >> Here the execution will continue, no more kernel panic after t=
his
> > > >> debugging display. Is it wanted ?
> > > >
> > > >
> > > > I guess it should panic.  I'm glad you mentioned this.
> > >=20
> > > Just in case, if you haven't done it already: stick rbd_assert(0)=
;
> > > after the last printk in that if statement, so it looks like this=
:
> > >=20
> > > if (which !=3D img_request->next_completion) {
> > >         printk("%s: bad image object request information:\n", __f=
unc__);
> > >         printk("obj_request %p\n", obj_request);
> > >         printk("    ->object_name <%s>\n", obj_request->object_na=
me);
> > >         ...
> > >=20
> > >         printk("img_request %p\n", img_request);
> > >         printk("    ->snap 0x%016llx\n", img_request->snap_id);
> > >         ...
> > >         printk("    ->result %d\n", img_request->result);
> > >=20
> > >         rbd_assert(0);
> > > }
> > >=20
> > > Thanks,
> > >=20
> > >                 Ilya
> > >=20
> >=20
> > Without the rbd_assert(0), I add this hang :
> >=20
> >=20
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255933] rbd_img_obj_callba=
ck: bad image object request information:
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255938] obj_request ffff88=
025a2b3c48
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255940]     ->object_name =
<rb.0.1536881.238e1f29.000000000439>
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255941]     ->offset 0
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255943]     ->length 28672
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255944]     ->type 0x1
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255945]     ->flags 0x3
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255946]     ->which 1
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255948]     ->xferred 2867=
2
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255949]     ->result 0
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255950] img_request ffff88=
02536c4a60
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255952]     ->snap 0xffff8=
80257f85ec0
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255953]     ->offset 45340=
26240
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255954]     ->length 45056
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255955]     ->flags 0x1
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255957]     ->obj_request_=
count 1
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255958]     ->next_complet=
ion 2
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255959]     ->xferred 4505=
6
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255960]     ->result 0
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255962]=20
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255962] Assertion failure =
in rbd_img_obj_callback() at line 2162:
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255962]=20
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255962] 	rbd_assert(which =
< img_request->obj_request_count);
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255962]=20
> > Mar 25 21:17:58 murmillia kernel: [ 2205.256141] ------------[ cut =
here ]------------
> > Mar 25 21:17:58 murmillia kernel: [ 2205.256178] kernel BUG at driv=
ers/block/rbd.c:2162!
> >=20
> >=20
> > --
>=20
> An other one :
>=20
> Mar 25 21:52:50 alg kernel: [ 1781.377690] rbd_img_obj_callback: bad =
image object request information:
> Mar 25 21:52:50 alg kernel: [ 1781.377696] obj_request ffff88021dda2a=
e8
> Mar 25 21:52:50 alg kernel: [ 1781.377698]     ->object_name <(null)>
> Mar 25 21:52:50 alg kernel: [ 1781.377699]     ->offset 0
> Mar 25 21:52:50 alg kernel: [ 1781.377701]     ->length 12288
> Mar 25 21:52:50 alg kernel: [ 1781.377702]     ->type 0x1
> Mar 25 21:52:50 alg kernel: [ 1781.377703]     ->flags 0x3
> Mar 25 21:52:50 alg kernel: [ 1781.377704]     ->which 4294967295
> Mar 25 21:52:50 alg kernel: [ 1781.377705]     ->xferred 12288
> Mar 25 21:52:50 alg kernel: [ 1781.377706]     ->result 0
> Mar 25 21:52:50 alg kernel: [ 1781.377707] img_request ffff880223f396=
a0
> Mar 25 21:52:50 alg kernel: [ 1781.377709]     ->snap 0xffff880231dd8=
cc0
> Mar 25 21:52:50 alg kernel: [ 1781.377710]     ->offset 1119846400
> Mar 25 21:52:50 alg kernel: [ 1781.377711]     ->length 45056
> Mar 25 21:52:50 alg kernel: [ 1781.377712]     ->flags 0x1
> Mar 25 21:52:50 alg kernel: [ 1781.377713]     ->obj_request_count 0
> Mar 25 21:52:50 alg kernel: [ 1781.377713]     ->next_completion 2
> Mar 25 21:52:50 alg kernel: [ 1781.377714]     ->xferred 45056
> Mar 25 21:52:50 alg kernel: [ 1781.377715]     ->result 0
> Mar 25 21:52:50 alg kernel: [ 1781.377717]=20
> Mar 25 21:52:50 alg kernel: [ 1781.377717] Assertion failure in rbd_i=
mg_obj_callback() at line 2162:
> Mar 25 21:52:50 alg kernel: [ 1781.377717]=20
> Mar 25 21:52:50 alg kernel: [ 1781.377717] 	rbd_assert(which < img_re=
quest->obj_request_count);
> Mar 25 21:52:50 alg kernel: [ 1781.377717]=20
> Mar 25 21:52:50 alg kernel: [ 1781.377859] ------------[ cut here ]--=
----------
>=20
>=20
> --

The third (now with rbd_assort(0)) :

Mar 25 22:08:12 alg kernel: [  598.301895] rbd_img_obj_callback: bad im=
age object request information:
Mar 25 22:08:12 alg kernel: [  598.301900] obj_request ffff88022409e1b8
Mar 25 22:08:12 alg kernel: [  598.301901]     ->object_name <(null)>
Mar 25 22:08:12 alg kernel: [  598.301902]     ->offset 0
Mar 25 22:08:12 alg kernel: [  598.301903]     ->length 8192
Mar 25 22:08:12 alg kernel: [  598.301904]     ->type 0x1
Mar 25 22:08:12 alg kernel: [  598.301905]     ->flags 0x3
Mar 25 22:08:12 alg kernel: [  598.301906]     ->which 4294967295
Mar 25 22:08:12 alg kernel: [  598.301906]     ->xferred 8192
Mar 25 22:08:12 alg kernel: [  598.301907]     ->result 0
Mar 25 22:08:12 alg kernel: [  598.301908] img_request ffff8802303bff10
Mar 25 22:08:12 alg kernel: [  598.301909]     ->snap 0xffff88022711f50=
0
Mar 25 22:08:12 alg kernel: [  598.301910]     ->offset 4492079104
Mar 25 22:08:12 alg kernel: [  598.301911]     ->length 28672
Mar 25 22:08:12 alg kernel: [  598.301912]     ->flags 0x1
Mar 25 22:08:12 alg kernel: [  598.301913]     ->obj_request_count 0
Mar 25 22:08:12 alg kernel: [  598.301913]     ->next_completion 2
Mar 25 22:08:12 alg kernel: [  598.301914]     ->xferred 28672
Mar 25 22:08:12 alg kernel: [  598.301915]     ->result 0
Mar 25 22:08:12 alg kernel: [  598.301916]=20
Mar 25 22:08:12 alg kernel: [  598.301916] Assertion failure in rbd_img=
_obj_callback() at line 2159:
Mar 25 22:08:12 alg kernel: [  598.301916]=20
Mar 25 22:08:12 alg kernel: [  598.301916] 	rbd_assert(0);
Mar 25 22:08:12 alg kernel: [  598.301916]=20
Mar 25 22:08:12 alg kernel: [  598.302093] ------------[ cut here ]----=
--------




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
