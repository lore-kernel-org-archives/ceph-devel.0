From: Olivier Bonvalet <mailinglist@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 23:17:19 +0100
Message-ID: <1395785839.2076.30.camel@localhost>
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
	 <1395783675.2076.26.camel@localhost>
	 <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>
	 <1395784476.2076.28.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:43294 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbaCYWWf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 18:22:35 -0400
In-Reply-To: <1395784476.2076.28.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>

Le mardi 25 mars 2014 =C3=A0 22:54 +0100, Olivier Bonvalet a =C3=A9crit=
 :
> Le mardi 25 mars 2014 =C3=A0 23:49 +0200, Ilya Dryomov a =C3=A9crit :
> > On Tue, Mar 25, 2014 at 11:41 PM, Olivier Bonvalet <ceph.list@daeve=
l.fr> wrote:
> > > mmm the cluster seems to be in a really bad state now : all hosts=
 are
> > > hanging. Is it possible that mounting images without the rbd_asse=
rt(0)
> > > broke some images ?
> > >
> >=20
> > I don't think so.  As far as I can tell all occurrences that you
> > reported tripped over one of the asserts.  It's probably just that =
for
> > some reason you are now hitting this bug much more frequently than =
once
> > a week.
> >=20
> > Thanks,
> >=20
> >                 Ilya
> > --
>=20
> Ok thanks, I'm =C2=ABreassured=C2=BB.
>=20
> At reboot VM are much more I/O loaded, because of cache flush. It's
> probably the reason why it now hang often.
>=20
> I have to wait a little between starting each VM.
>=20
> --

I now have this one very often (here 5 minutes after the host boot) :

Mar 25 23:14:45 rurkh kernel: [  330.054196] rbd_img_obj_callback: bad =
image object request information:
Mar 25 23:14:45 rurkh kernel: [  330.054205] obj_request ffff88025f3df0=
58
Mar 25 23:14:45 rurkh kernel: [  330.054209]     ->object_name <(null)>
Mar 25 23:14:45 rurkh kernel: [  330.054211]     ->offset 0
Mar 25 23:14:45 rurkh kernel: [  330.054213]     ->length 4096
Mar 25 23:14:45 rurkh kernel: [  330.054216]     ->type 0x1
Mar 25 23:14:45 rurkh kernel: [  330.054218]     ->flags 0x3
Mar 25 23:14:45 rurkh kernel: [  330.054220]     ->which 4294967295
Mar 25 23:14:45 rurkh kernel: [  330.054222]     ->xferred 4096
Mar 25 23:14:45 rurkh kernel: [  330.054224]     ->result 0
Mar 25 23:14:45 rurkh kernel: [  330.054227] img_request ffff8802731f84=
48
Mar 25 23:14:45 rurkh kernel: [  330.054229]     ->snap 0xfffffffffffff=
ffe
Mar 25 23:14:45 rurkh kernel: [  330.054231]     ->offset 2508181504
Mar 25 23:14:45 rurkh kernel: [  330.054233]     ->length 16384
Mar 25 23:14:45 rurkh kernel: [  330.054235]     ->flags 0x0
Mar 25 23:14:45 rurkh kernel: [  330.054237]     ->obj_request_count 0
Mar 25 23:14:45 rurkh kernel: [  330.054239]     ->next_completion 2
Mar 25 23:14:45 rurkh kernel: [  330.054241]     ->xferred 16384
Mar 25 23:14:45 rurkh kernel: [  330.054243]     ->result 0
Mar 25 23:14:45 rurkh kernel: [  330.054247]=20
Mar 25 23:14:45 rurkh kernel: [  330.054247] Assertion failure in rbd_i=
mg_obj_callback() at line 2159:
Mar 25 23:14:45 rurkh kernel: [  330.054247]=20
Mar 25 23:14:45 rurkh kernel: [  330.054247] 	rbd_assert(0);
Mar 25 23:14:45 rurkh kernel: [  330.054247]=20
Mar 25 23:14:45 rurkh kernel: [  330.054495] ------------[ cut here ]--=
----------
Mar 25 23:14:45 rurkh kernel: [  330.054585] kernel BUG at drivers/bloc=
k/rbd.c:2159!
Mar 25 23:14:45 rurkh kernel: [  330.054676] invalid opcode: 0000 [#1] =
SMP=20
Mar 25 23:14:45 rurkh kernel: [  330.054874] Modules linked in: cbc rbd=
 libceph xen_gntdev xt_physdev iptable_filter ip_tables x_tables xfs li=
bcrc32c bridge loop iTCO_wdt gpio_ich iTCO_vendor_support serio_raw sb_=
edac edac_core evdev i2c_i801 lpc_ich mfd_core ioatdma shpchp wmi ipmi_=
si ipmi_msghandler ac button dm_mod hid_generic usbhid hid sg sd_mod cr=
c_t10dif crct10dif_common megaraid_sas isci ahci libsas libahci libata =
scsi_transport_sas ehci_pci ehci_hcd scsi_mod usbcore igb usb_common i2=
c_algo_bit ixgbe i2c_core dca ptp pps_core mdio
Mar 25 23:14:45 rurkh kernel: [  330.058433] CPU: 2 PID: 6365 Comm: kwo=
rker/2:3 Not tainted 3.13-dae-dom0 #22
Mar 25 23:14:45 rurkh kernel: [  330.058528] Hardware name: Supermicro =
X9DRW-7TPF+/X9DRW-7TPF+, BIOS 3.0 07/24/2013
Mar 25 23:14:45 rurkh kernel: [  330.058659] Workqueue: ceph-msgr con_w=
ork [libceph]
Mar 25 23:14:45 rurkh kernel: [  330.058805] task: ffff88026da5b820 ti:=
 ffff88025dfe2000 task.ti: ffff88025dfe2000
Mar 25 23:14:45 rurkh kernel: [  330.058922] RIP: e030:[<ffffffffa0309c=
d9>]  [<ffffffffa0309cd9>] rbd_img_obj_callback+0x282/0x523 [rbd]
Mar 25 23:14:45 rurkh kernel: [  330.059107] RSP: e02b:ffff88025dfe3ce8=
  EFLAGS: 00010082
Mar 25 23:14:45 rurkh kernel: [  330.059199] RAX: 000000000000004c RBX:=
 ffff88025f3df058 RCX: 0000000000000007
Mar 25 23:14:45 rurkh kernel: [  330.059300] RDX: 0000000000000006 RSI:=
 0000000000000000 RDI: ffff88025dfe00a8
Mar 25 23:14:45 rurkh kernel: [  330.059397] RBP: ffff8802731f8448 R08:=
 0000000000000000 R09: 0000000000000000
Mar 25 23:14:45 rurkh kernel: [  330.059491] R10: 0000000000000000 R11:=
 ffff88025f712d66 R12: 0000000000000001
Mar 25 23:14:45 rurkh kernel: [  330.059587] R13: 0000000000000000 R14:=
 ffff88025f712ad0 R15: 0000000000000000
Mar 25 23:14:45 rurkh kernel: [  330.059689] FS:  00007f2fd8882700(0000=
) GS:ffff88027fe40000(0000) knlGS:0000000000000000
Mar 25 23:14:45 rurkh kernel: [  330.059807] CS:  e033 DS: 0000 ES: 000=
0 CR0: 0000000080050033
Mar 25 23:14:45 rurkh kernel: [  330.059899] CR2: 00007f7a1e28f000 CR3:=
 000000000160c000 CR4: 0000000000042660
Mar 25 23:14:45 rurkh kernel: [  330.059997] Stack:
Mar 25 23:14:45 rurkh kernel: [  330.060086]  ffff8802731f8484 ffff8802=
730f2c45 ffffffffffffffff ffff8802730f2c10
Mar 25 23:14:45 rurkh kernel: [  330.060339]  ffff88025f712ac8 ffff8802=
703b4718 0000000000000000 ffff88025f712ad0
Mar 25 23:14:45 rurkh kernel: [  330.060573]  0000000000000000 ffffffff=
a02f5595 0000000000000015 ffff8802703b4770
Mar 25 23:14:45 rurkh kernel: [  330.060811] Call Trace:
Mar 25 23:14:45 rurkh kernel: [  330.060878]  [<ffffffffa02f5595>] ? di=
spatch+0x3e4/0x55e [libceph]
Mar 25 23:14:45 rurkh kernel: [  330.060954]  [<ffffffffa02f00fc>] ? co=
n_work+0xf6e/0x1a65 [libceph]
Mar 25 23:14:45 rurkh kernel: [  330.061029]  [<ffffffff81051f83>] ? mm=
drop+0xd/0x1c
Mar 25 23:14:45 rurkh kernel: [  330.061098]  [<ffffffff8105265e>] ? fi=
nish_task_switch+0x4d/0x83
Mar 25 23:14:45 rurkh kernel: [  330.061171]  [<ffffffff810484d7>] ? pr=
ocess_one_work+0x15a/0x214
Mar 25 23:14:45 rurkh kernel: [  330.061243]  [<ffffffff8104895b>] ? wo=
rker_thread+0x139/0x1de
Mar 25 23:14:45 rurkh kernel: [  330.061313]  [<ffffffff81048822>] ? re=
scuer_thread+0x26e/0x26e
Mar 25 23:14:45 rurkh kernel: [  330.061385]  [<ffffffff8104cff6>] ? kt=
hread+0x9e/0xa6
Mar 25 23:14:45 rurkh kernel: [  330.061454]  [<ffffffff8104cf58>] ? __=
kthread_parkme+0x55/0x55
Mar 25 23:14:45 rurkh kernel: [  330.061530]  [<ffffffff8137260c>] ? re=
t_from_fork+0x7c/0xb0
Mar 25 23:14:45 rurkh kernel: [  330.061606]  [<ffffffff8104cf58>] ? __=
kthread_parkme+0x55/0x55
Mar 25 23:14:45 rurkh kernel: [  330.061677] Code: cc 30 a0 31 c0 e8 8b=
 e4 05 e1 48 c7 c1 5c cd 30 a0 31 c0 ba 6f 08 00 00 48 c7 c6 80 da 30 a=
0 48 c7 c7 1f c1 30 a0 e8 6a e4 05 e1 <0f> 0b 41 8b 45 5c ff c8 39 43 4=
0 41 0f 92 c5 48 8b 5b 30 41 ff=20
Mar 25 23:14:45 rurkh kernel: [  330.064345] RIP  [<ffffffffa0309cd9>] =
rbd_img_obj_callback+0x282/0x523 [rbd]
Mar 25 23:14:45 rurkh kernel: [  330.064481]  RSP <ffff88025dfe3ce8>
Mar 25 23:14:45 rurkh kernel: [  330.064562] ---[ end trace 74103a003e0=
d553e ]---


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
