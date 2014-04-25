From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Fri, 25 Apr 2014 13:37:06 +0200
Message-ID: <1398425826.2927.21.camel@localhost>
References: <1395736765.2823.29.camel@localhost>
	 <1396660579.2130.103.camel@localhost> <533F62EE.2060701@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:33691 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbaDYLhR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Apr 2014 07:37:17 -0400
In-Reply-To: <533F62EE.2060701@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: ceph-devel@vger.kernel.org

Le vendredi 04 avril 2014 =C3=A0 20:57 -0500, Alex Elder a =C3=A9crit :
> On 04/04/2014 08:16 PM, Olivier Bonvalet wrote:
> > Le mardi 25 mars 2014 =C3=A0 09:39 +0100, Olivier Bonvalet a =C3=A9=
crit :
> >> Hi,
> >>
> >> what can/should I do to help fix that problem ?
> >>
> >> for now, RBD kernel client hang on :=20
> >>         Assertion failure in rbd_img_obj_callback() at line 2131:
> >>            rbd_assert(which >=3D img_request->next_completion);
> >>
> >> or on :
> >>         Assertion failure in rbd_img_obj_callback() at line 2127:
> >>             rbd_assert(img_request !=3D NULL);
> >>
> >>
> >> I have both case at least once per week, on latest 3.13.5 kernels.
> >>
> >> It seems that the problem occurs only on more loaded servers (I ha=
ve 4
> >> near same servers, and crash occurs on two of them. If I move the =
VM,
> >> crash follows...).
> >>
> >> Olivier
> >>
> >> --
> >=20
> > Hi,
> >=20
> > so. After some days without any problems, RBD crashed toonight :
>=20
> Unfortunately this could be a symptom of the same sort of race.
> When a object request is removed from its image request's list
> the request count gets decremented.  To be honest, all of these
> assertions in rbd_img_obj_callback() are probably unsafe, at
> least until I get the patch that does proper reference counting
> implemented:
>=20
>         rbd_assert(img_request !=3D NULL);
>         rbd_assert(img_request->obj_request_count > 0);
>         rbd_assert(which !=3D BAD_WHICH);
>         rbd_assert(which < img_request->obj_request_count);
>=20
> Until then I think you can avoid this by commenting out those
> assertions.  I'm afraid there will remain a (smaller) window
> of opportunity for a problem to occur, but I believe commenting
> those out will help for now.
>=20
> I'm very sorry you're hitting these.  I'll see if I can get
> a comprehensive fix this weekend.
>=20
> 					-Alex
>=20

Hi,

I suppose that I should add :
    if (img_request =3D=3D NULL) goto out;

Right ?

When commenting the asserts I obtain a NULL pointer dereference :

Apr 25 13:03:15 murmillia kernel: [124049.097927] BUG: unable to handle=
 kernel NULL pointer dereference at 000000000000003c
Apr 25 13:03:15 murmillia kernel: [124049.098008] IP: [<ffffffff8105d92=
2>] do_raw_spin_lock+0x5/0x22
Apr 25 13:03:15 murmillia kernel: [124049.098056] PGD 0=20
Apr 25 13:03:15 murmillia kernel: [124049.098091] Oops: 0002 [#1] SMP=20
Apr 25 13:03:15 murmillia kernel: [124049.098133] Modules linked in: cb=
c rbd libceph xen_gntdev ip6table_mangle ip6t_REJECT ip6table_filter ip=
6_tables xt_DSCP iptable_mangle xt_LOG xt_physdev ipt_REJECT xt_tcpudp =
iptable_filter ip_tables x_tables xfs libcrc32c bridge loop iTCO_wdt gp=
io_ich iTCO_vendor_support serio_raw sb_edac edac_core i2c_i801 evdev l=
pc_ich mfd_core ioatdma shpchp ipmi_si ipmi_msghandler wmi ac button dm=
_mod hid_generic usbhid hid sg sd_mod crc_t10dif crct10dif_common megar=
aid_sas ahci libahci isci ehci_pci ehci_hcd libsas usbcore libata igb i=
xgbe scsi_transport_sas i2c_algo_bit i2c_core usb_common scsi_mod dca p=
tp pps_core mdio
Apr 25 13:03:15 murmillia kernel: [124049.098695] CPU: 0 PID: 31669 Com=
m: kworker/0:0 Not tainted 3.13-dae-dom0 #1
Apr 25 13:03:15 murmillia kernel: [124049.098739] Hardware name: Superm=
icro X9DRW-7TPF+/X9DRW-7TPF+, BIOS 2.0a 03/11/2013
Apr 25 13:03:15 murmillia kernel: [124049.098809] Workqueue: ceph-msgr =
con_work [libceph]
Apr 25 13:03:15 murmillia kernel: [124049.098851] task: ffff8802458b38a=
0 ti: ffff88023cfcc000 task.ti: ffff88023cfcc000
Apr 25 13:03:15 murmillia kernel: [124049.098916] RIP: e030:[<ffffffff8=
105d922>]  [<ffffffff8105d922>] do_raw_spin_lock+0x5/0x22
Apr 25 13:03:15 murmillia kernel: [124049.098987] RSP: e02b:ffff88023cf=
cdce0  EFLAGS: 00010002
Apr 25 13:03:15 murmillia kernel: [124049.099026] RAX: 0000000000010000=
 RBX: ffff88025749a3c8 RCX: 0000000000002201
Apr 25 13:03:15 murmillia kernel: [124049.099091] RDX: 000000000000003c=
 RSI: ffff88025749a3e0 RDI: 000000000000003c
Apr 25 13:03:15 murmillia kernel: [124049.099154] RBP: 0000000000000000=
 R08: 0000000000000001 R09: 0000000000000001
Apr 25 13:03:15 murmillia kernel: [124049.099218] R10: ffff88024749d07d=
 R11: ffff8802476929f8 R12: ffff880269f6b701
Apr 25 13:03:15 murmillia kernel: [124049.099281] R13: 00000000ffffffff=
 R14: ffff8802476927c0 R15: 0000000000000000
Apr 25 13:03:15 murmillia kernel: [124049.099349] FS:  00007f01384088e0=
(0000) GS:ffff88027fc00000(0000) knlGS:0000000000000000
Apr 25 13:03:15 murmillia kernel: [124049.099415] CS:  e033 DS: 0000 ES=
: 0000 CR0: 0000000080050033
Apr 25 13:03:15 murmillia kernel: [124049.099455] CR2: 000000000000003c=
 CR3: 0000000243dec000 CR4: 0000000000042660
Apr 25 13:03:15 murmillia kernel: [124049.099519] Stack:
Apr 25 13:03:15 murmillia kernel: [124049.099549]  ffffffffa032caad 000=
000000000003c ffff8802476929f8 0000000000002201
Apr 25 13:03:15 murmillia kernel: [124049.099629]  ffff8802411ea218 fff=
f8802476927b8 ffff880269f6b718 0000000000000000
Apr 25 13:03:15 murmillia kernel: [124049.099708]  ffff8802476927c0 000=
0000000000000 ffffffffa030b69b 0000000000000025
Apr 25 13:03:15 murmillia kernel: [124049.099786] Call Trace:
Apr 25 13:03:15 murmillia kernel: [124049.099823]  [<ffffffffa032caad>]=
 ? rbd_img_obj_callback+0x56/0x308 [rbd]
Apr 25 13:03:15 murmillia kernel: [124049.099871]  [<ffffffffa030b69b>]=
 ? dispatch+0x3e4/0x55e [libceph]
Apr 25 13:03:15 murmillia kernel: [124049.099915]  [<ffffffffa03060fc>]=
 ? con_work+0xf6e/0x1a65 [libceph]
Apr 25 13:03:15 murmillia kernel: [124049.099959]  [<ffffffff8100122a>]=
 ? xen_hypercall_xen_version+0xa/0x20
Apr 25 13:03:15 murmillia kernel: [124049.100004]  [<ffffffff81005959>]=
 ? xen_force_evtchn_callback+0x9/0xa
Apr 25 13:03:15 murmillia kernel: [124049.100048]  [<ffffffff810484e8>]=
 ? process_one_work+0x15a/0x214
Apr 25 13:03:15 murmillia kernel: [124049.100100]  [<ffffffff8104896c>]=
 ? worker_thread+0x139/0x1de
Apr 25 13:03:15 murmillia kernel: [124049.100141]  [<ffffffff81048833>]=
 ? rescuer_thread+0x26e/0x26e
Apr 25 13:03:15 murmillia kernel: [124049.100183]  [<ffffffff8104d007>]=
 ? kthread+0x9e/0xa6
Apr 25 13:03:15 murmillia kernel: [124049.100223]  [<ffffffff8104cf69>]=
 ? __kthread_parkme+0x55/0x55
Apr 25 13:03:15 murmillia kernel: [124049.100268]  [<ffffffff81372a0c>]=
 ? ret_from_fork+0x7c/0xb0
Apr 25 13:03:15 murmillia kernel: [124049.100309]  [<ffffffff8104cf69>]=
 ? __kthread_parkme+0x55/0x55
Apr 25 13:03:15 murmillia kernel: [124049.100349] Code: d0 f0 0f b1 0f =
39 d0 0f 94 c0 0f b6 c0 c3 31 c0 48 81 ff e8 db 36 81 72 0c 31 c0 48 81=
 ff af df 36 81 0f 92 c0 c3 b8 00 00 01 00 <f0> 0f c1 07 89 c2 c1 ea 10=
 66 39 c2 89 d1 74 0c 66 8b 07 66 39=20
Apr 25 13:03:15 murmillia kernel: [124049.100727] RIP  [<ffffffff8105d9=
22>] do_raw_spin_lock+0x5/0x22
Apr 25 13:03:15 murmillia kernel: [124049.100773]  RSP <ffff88023cfcdce=
0>
Apr 25 13:03:15 murmillia kernel: [124049.100807] CR2: 000000000000003c
Apr 25 13:03:15 murmillia kernel: [124049.101120] ---[ end trace 7f81ac=
e5e0aed716 ]---




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
