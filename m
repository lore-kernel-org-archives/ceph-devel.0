From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 21:29:18 +0100
Message-ID: <1395779358.2076.14.camel@localhost>
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
	 <1395778894.2076.12.camel@localhost> <5331E608.40206@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:41373 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbaCYU3V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 16:29:21 -0400
In-Reply-To: <5331E608.40206@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

Le mardi 25 mars 2014 =C3=A0 15:24 -0500, Alex Elder a =C3=A9crit :
> On 03/25/2014 03:21 PM, Olivier Bonvalet wrote:
> > Le mardi 25 mars 2014 =C3=A0 22:18 +0200, Ilya Dryomov a =C3=A9crit=
 :
> >> On Tue, Mar 25, 2014 at 9:03 PM, Alex Elder <elder@ieee.org> wrote=
:
> >>> On 03/25/2014 01:53 PM, Olivier Bonvalet wrote:
> >>>> Le mardi 25 mars 2014 =C3=A0 12:43 -0500, Alex Elder a =C3=A9cri=
t :
> >>>>> Please try applying this, on top of the previous patch.
> >>>>> If you can then reproduce the problem we'll have a bunch
> >>>>> of new information about the particular request that's
> >>>>> leading to the failure.  That might tell us what more we
> >>>>> can do to find the root cause.  Thank you.
> >>>>>
> >>>>>                                      -Alex
> >>>>>
> >>>>> PS  I hope my mailer doesn't botch the long lines.  It might.
> >>>>>
> >>>>
> >>>> Here the execution will continue, no more kernel panic after thi=
s
> >>>> debugging display. Is it wanted ?
> >>>
> >>>
> >>> I guess it should panic.  I'm glad you mentioned this.
> >>
> >> Just in case, if you haven't done it already: stick rbd_assert(0);
> >> after the last printk in that if statement, so it looks like this:
> >>
> >> if (which !=3D img_request->next_completion) {
> >>         printk("%s: bad image object request information:\n", __fu=
nc__);
> >>         printk("obj_request %p\n", obj_request);
> >>         printk("    ->object_name <%s>\n", obj_request->object_nam=
e);
> >>         ...
> >>
> >>         printk("img_request %p\n", img_request);
> >>         printk("    ->snap 0x%016llx\n", img_request->snap_id);
> >>         ...
> >>         printk("    ->result %d\n", img_request->result);
> >>
> >>         rbd_assert(0);
> >> }
> >>
> >> Thanks,
> >>
> >>                 Ilya
> >>
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
> 		BIO request
>=20
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255945]     ->flags 0x3
> 	IMG_DATA, KNOWN
>=20
> > Mar 25 21:17:58 murmillia kernel: [ 2205.255946]     ->which 1
> 	Second object in the request
>=20
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
> 	!!! There is only one request... (?)
>=20
> So obj_request_count might be getting computed incorrectly.
>=20
> 					-Alex
>=20
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
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


Here I was migrating (xen live migrate) ~20 VM from one host to
"murmillia", just after booting "murmillia" on the new kernel.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
