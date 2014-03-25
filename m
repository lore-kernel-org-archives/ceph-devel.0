From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 18:15:05 +0100
Message-ID: <1395767705.9967.5.camel@localhost>
References: <1395736765.2823.29.camel@localhost>
		 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
		 <53316D18.7040103@ieee.org>
		 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
		 <53317BC2.9010700@ieee.org>
		 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
	 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>
	 <5331853D.40408@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:38290 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbaCYRPM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 13:15:12 -0400
In-Reply-To: <5331853D.40408@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

Le mardi 25 mars 2014 =C3=A0 08:31 -0500, Alex Elder a =C3=A9crit :
> ...
> >> So, a (partial) fix can be this patch ?
> >>
> >=20
> >=20
> > Yes, roughly.  I'd do the following instead.  It would be great
> > to learn whether it eliminates the one form of assertion failure
> > you were seeing.
> >=20
> > 					-Alex
> >
>=20
>=20
> Strike that, my last patch was dead wrong.  Sorry.  Try this:
>=20
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2128,11 +2128,11 @@ static void rbd_img_obj_callback(struct
>  	rbd_assert(img_request->obj_request_count > 0);
>  	rbd_assert(which !=3D BAD_WHICH);
>  	rbd_assert(which < img_request->obj_request_count);
> -	rbd_assert(which >=3D img_request->next_completion);
>=20
>  	spin_lock_irq(&img_request->completion_lock);
> -	if (which !=3D img_request->next_completion)
> +	if (which > img_request->next_completion)
>  		goto out;
> +	rbd_assert(which =3D=3D img_request->next_completion);
>=20
>  	for_each_obj_request_from(img_request, obj_request) {
>  		rbd_assert(more);
>=20
>=20
>=20

Well, it just hang :

Mar 25 17:58:36 rurkh kernel: [ 4135.913079] Assertion failure in rbd_i=
mg_obj_callback() at line 2135:
Mar 25 17:58:36 rurkh kernel: [ 4135.913079]=20
Mar 25 17:58:36 rurkh kernel: [ 4135.913079] 	rbd_assert(which =3D=3D i=
mg_request->next_completion);
Mar 25 17:58:36 rurkh kernel: [ 4135.913079]=20
Mar 25 17:58:36 rurkh kernel: [ 4135.913252] ------------[ cut here ]--=
----------
Mar 25 17:58:36 rurkh kernel: [ 4135.913288] kernel BUG at drivers/bloc=
k/rbd.c:2135!
Mar 25 17:58:36 rurkh kernel: [ 4135.913331] invalid opcode: 0000 [#1] =
SMP=20
Mar 25 17:58:36 rurkh kernel: [ 4135.913373] Modules linked in: cbc rbd=
 libceph xen_gntdev xt_physdev iptable_filter ip_tables x_tables xfs li=
bcrc32c bridge loop iTCO_wdt iTCO_vendor_support gpio_ich serio_raw sb_=
edac edac_core i2c_i801 lpc_ich mfd_core evdev ioatdma shpchp ipmi_si i=
pmi_msghandler wmi ac button dm_mod hid_generic usbhid hid sg sd_mod cr=
c_t10dif crct10dif_common isci ahci libsas libahci megaraid_sas libata =
scsi_transport_sas ehci_pci igb scsi_mod ehci_hcd ixgbe i2c_algo_bit i2=
c_core usbcore dca ptp usb_common pps_core mdio
Mar 25 17:58:36 rurkh kernel: [ 4135.913821] CPU: 0 PID: 30629 Comm: kw=
orker/0:1 Not tainted 3.13-dae-dom0 #20
Mar 25 17:58:36 rurkh kernel: [ 4135.913863] Hardware name: Supermicro =
X9DRW-7TPF+/X9DRW-7TPF+, BIOS 3.0 07/24/2013
Mar 25 17:58:36 rurkh kernel: [ 4135.913931] Workqueue: ceph-msgr con_w=
ork [libceph]
Mar 25 17:58:36 rurkh kernel: [ 4135.913970] task: ffff88027374b760 ti:=
 ffff88024933c000 task.ti: ffff88024933c000
Mar 25 17:58:36 rurkh kernel: [ 4135.914033] RIP: e030:[<ffffffffa0304b=
86>]  [<ffffffffa0304b86>] rbd_img_obj_callback+0x12f/0x3d0 [rbd]
Mar 25 17:58:36 rurkh kernel: [ 4135.914104] RSP: e02b:ffff88024933dce8=
  EFLAGS: 00010082
Mar 25 17:58:36 rurkh kernel: [ 4135.914141] RAX: 0000000000000070 RBX:=
 ffff88024d2dcc48 RCX: 0000000000000000
Mar 25 17:58:36 rurkh kernel: [ 4135.914182] RDX: ffff88027fe0eb50 RSI:=
 ffff88027fe0e1a8 RDI: ffff8802493300a8
Mar 25 17:58:36 rurkh kernel: [ 4135.914223] RBP: ffff88024ccc3e20 R08:=
 0000000000000000 R09: 0000000000000000
Mar 25 17:58:36 rurkh kernel: [ 4135.914265] R10: 0000000000000000 R11:=
 0000000000000098 R12: 0000000000000001
Mar 25 17:58:36 rurkh kernel: [ 4135.914306] R13: 0000000000000000 R14:=
 ffff88027144b1d0 R15: 0000000000000000
Mar 25 17:58:36 rurkh kernel: [ 4135.914351] FS:  00007f6ec996f700(0000=
) GS:ffff88027fe00000(0000) knlGS:0000000000000000
Mar 25 17:58:36 rurkh kernel: [ 4135.914415] CS:  e033 DS: 0000 ES: 000=
0 CR0: 0000000080050033
Mar 25 17:58:36 rurkh kernel: [ 4135.914453] CR2: 0000000001ff1b10 CR3:=
 00000002492b3000 CR4: 0000000000042660
Mar 25 17:58:36 rurkh kernel: [ 4135.914495] Stack:
Mar 25 17:58:36 rurkh kernel: [ 4135.914524]  ffff88024ccc3e5c ffff8802=
4a48eb5d ffffffffffffffff ffff88024a48eb28
Mar 25 17:58:36 rurkh kernel: [ 4135.914610]  ffff88027144b1c8 ffff8802=
656cc718 0000000000000000 ffff88027144b1d0
Mar 25 17:58:36 rurkh kernel: [ 4135.914689]  0000000000000000 ffffffff=
a02e3595 0000000000000015 ffff8802656cc770
Mar 25 17:58:36 rurkh kernel: [ 4135.914768] Call Trace:
Mar 25 17:58:36 rurkh kernel: [ 4135.914809]  [<ffffffffa02e3595>] ? di=
spatch+0x3e4/0x55e [libceph]
Mar 25 17:58:36 rurkh kernel: [ 4135.914854]  [<ffffffffa02de0fc>] ? co=
n_work+0xf6e/0x1a65 [libceph]
Mar 25 17:58:36 rurkh kernel: [ 4135.914901]  [<ffffffff81005f00>] ? xe=
n_timer_resume+0x4f/0x4f
Mar 25 17:58:36 rurkh kernel: [ 4135.914944]  [<ffffffff81051f83>] ? mm=
drop+0xd/0x1c
Mar 25 17:58:36 rurkh kernel: [ 4135.914984]  [<ffffffff8105265e>] ? fi=
nish_task_switch+0x4d/0x83
Mar 25 17:58:36 rurkh kernel: [ 4135.915029]  [<ffffffff810484d7>] ? pr=
ocess_one_work+0x15a/0x214
Mar 25 17:58:36 rurkh kernel: [ 4135.915072]  [<ffffffff8104895b>] ? wo=
rker_thread+0x139/0x1de
Mar 25 17:58:36 rurkh kernel: [ 4135.915113]  [<ffffffff81048822>] ? re=
scuer_thread+0x26e/0x26e
Mar 25 17:58:36 rurkh kernel: [ 4135.915155]  [<ffffffff8104cff6>] ? kt=
hread+0x9e/0xa6
Mar 25 17:58:36 rurkh kernel: [ 4135.915195]  [<ffffffff8104cf58>] ? __=
kthread_parkme+0x55/0x55
Mar 25 17:58:36 rurkh kernel: [ 4135.915238]  [<ffffffff8137260c>] ? re=
t_from_fork+0x7c/0xb0
Mar 25 17:58:36 rurkh kernel: [ 4135.915279]  [<ffffffff8104cf58>] ? __=
kthread_parkme+0x55/0x55
Mar 25 17:58:36 rurkh kernel: [ 4135.915319] Code: 41 b5 01 48 89 44 24=
 08 eb 3b 48 c7 c1 2e 7c 30 a0 ba 57 08 00 00 31 c0 48 c7 c6 80 89 30 a=
0 48 c7 c7 1f 71 30 a0 e8 bd 35 06 e1 <0f> 0b 41 8b 45 5c ff c8 39 43 4=
0 41 0f 92 c5 48 8b 5b 30 41 ff=20
Mar 25 17:58:36 rurkh kernel: [ 4135.915701] RIP  [<ffffffffa0304b86>] =
rbd_img_obj_callback+0x12f/0x3d0 [rbd]
Mar 25 17:58:36 rurkh kernel: [ 4135.915749]  RSP <ffff88024933dce8>
Mar 25 17:58:36 rurkh kernel: [ 4135.916087] ---[ end trace ff823e5e2d6=
cd4e9 ]--




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
