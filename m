From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Sat, 05 Apr 2014 03:16:19 +0200
Message-ID: <1396660579.2130.103.camel@localhost>
References: <1395736765.2823.29.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:60705 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbaDEBQZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Apr 2014 21:16:25 -0400
Received: from sal69-4-78-192-172-15.fbxo.proxad.net ([78.192.172.15] helo=[192.168.1.21])
	by licorne.daevel.fr with esmtpsa (SSL3.0:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <ceph.list@daevel.fr>)
	id 1WWFDZ-0004Kz-Is
	for ceph-devel@vger.kernel.org; Sat, 05 Apr 2014 03:16:21 +0200
In-Reply-To: <1395736765.2823.29.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Le mardi 25 mars 2014 =C3=A0 09:39 +0100, Olivier Bonvalet a =C3=A9crit=
 :
> Hi,
>=20
> what can/should I do to help fix that problem ?
>=20
> for now, RBD kernel client hang on :=20
>         Assertion failure in rbd_img_obj_callback() at line 2131:
>            rbd_assert(which >=3D img_request->next_completion);
>=20
> or on :
>         Assertion failure in rbd_img_obj_callback() at line 2127:
>             rbd_assert(img_request !=3D NULL);
>=20
>=20
> I have both case at least once per week, on latest 3.13.5 kernels.
>=20
> It seems that the problem occurs only on more loaded servers (I have =
4
> near same servers, and crash occurs on two of them. If I move the VM,
> crash follows...).
>=20
> Olivier
>=20
> --

Hi,

so. After some days without any problems, RBD crashed toonight :

Apr  5 02:52:24 rurkh kernel: [799426.461742]=20
Apr  5 02:52:24 rurkh kernel: [799426.461742] Assertion failure in rbd_=
img_obj_callback() at line 2128:
Apr  5 02:52:24 rurkh kernel: [799426.461742]=20
Apr  5 02:52:24 rurkh kernel: [799426.461742]   rbd_assert(img_request-=
>obj_request_count > 0);
Apr  5 02:52:24 rurkh kernel: [799426.461742]=20
Apr  5 02:52:24 rurkh kernel: [799426.461958] ------------[ cut here ]-=
-----------
Apr  5 02:52:24 rurkh kernel: [799426.461997] kernel BUG at drivers/blo=
ck/rbd.c:2128!
Apr  5 02:52:24 rurkh kernel: [799426.462036] invalid opcode: 0000 [#1]=
 SMP=20
Apr  5 02:52:24 rurkh kernel: [799426.462080] Modules linked in: cbc rb=
d libceph xen_gntdev xt_physdev iptable_filter ip_tables x_tables xfs
 libcrc32c bridge loop iTCO_wdt gpio_ich iTCO_vendor_support serio_raw =
sb_edac edac_core evdev i2c_i801 lpc_ich mfd_core ioatdma shpchp ipmi
_si ipmi_msghandler wmi ac button dm_mod hid_generic usbhid hid sg sd_m=
od crc_t10dif crct10dif_common isci ahci ehci_pci libsas libahci mega
raid_sas ehci_hcd libata scsi_transport_sas igb usbcore scsi_mod i2c_al=
go_bit ixgbe i2c_core usb_common dca ptp pps_core mdio
Apr  5 02:52:24 rurkh kernel: [799426.462579] CPU: 0 PID: 15975 Comm: k=
worker/0:0 Not tainted 3.13-dae-dom0 #24
Apr  5 02:52:24 rurkh kernel: [799426.462644] Hardware name: Supermicro=
 X9DRW-7TPF+/X9DRW-7TPF+, BIOS 3.0 07/24/2013
Apr  5 02:52:24 rurkh kernel: [799426.462717] Workqueue: ceph-msgr con_=
work [libceph]
Apr  5 02:52:24 rurkh kernel: [799426.462759] task: ffff88024cd9a8a0 ti=
: ffff88021a4e4000 task.ti: ffff88021a4e4000
Apr  5 02:52:24 rurkh kernel: [799426.462825] RIP: e030:[<ffffffffa0305=
ae8>]  [<ffffffffa0305ae8>] rbd_img_obj_callback+0x91/0x3a2 [rbd]
Apr  5 02:52:24 rurkh kernel: [799426.462901] RSP: e02b:ffff88021a4e5ce=
8  EFLAGS: 00010282
Apr  5 02:52:24 rurkh kernel: [799426.462940] RAX: 000000000000006d RBX=
: ffff88023f8f6ec8 RCX: 0000000000000000
Apr  5 02:52:24 rurkh kernel: [799426.463005] RDX: ffff88027fe0eb50 RSI=
: ffff88027fe0e1a8 RDI: ffff88021a4e02a8
Apr  5 02:52:24 rurkh kernel: [799426.463069] RBP: ffff88021c90a718 R08=
: 0000000000000000 R09: 0000000000000000
Apr  5 02:52:24 rurkh kernel: [799426.463134] R10: 0000000000000000 R11=
: 000000000000084e R12: 0000000000000001
Apr  5 02:52:24 rurkh kernel: [799426.463197] R13: 0000000000000000 R14=
: ffff88025584a130 R15: 0000000000000000
Apr  5 02:52:24 rurkh kernel: [799426.481060] FS:  00007f1c6138f720(000=
0) GS:ffff88027fe00000(0000) knlGS:0000000000000000
Apr  5 02:52:24 rurkh kernel: [799426.481130] CS:  e033 DS: 0000 ES: 00=
00 CR0: 0000000080050033
Apr  5 02:52:24 rurkh kernel: [799426.481170] CR2: 00007f1c6139f000 CR3=
: 000000023825c000 CR4: 0000000000042660
Apr  5 02:52:24 rurkh kernel: [799426.481235] Stack:
Apr  5 02:52:24 rurkh kernel: [799426.481266]  000000000000000d ffff880=
254da107d ffffffffffffffff ffff880254da1048
Apr  5 02:52:24 rurkh kernel: [799426.481349]  ffff88025584a128 ffff880=
26dc59718 0000000000000000 ffff88025584a130
Apr  5 02:52:24 rurkh kernel: [799426.481429]  0000000000000000 fffffff=
fa02e4595 0000000000000015 ffff88026dc59770
Apr  5 02:52:24 rurkh kernel: [799426.481510] Call Trace:
Apr  5 02:52:24 rurkh kernel: [799426.481554]  [<ffffffffa02e4595>] ? d=
ispatch+0x3e4/0x55e [libceph]
Apr  5 02:52:24 rurkh kernel: [799426.481600]  [<ffffffffa02df0fc>] ? c=
on_work+0xf6e/0x1a65 [libceph]
Apr  5 02:52:24 rurkh kernel: [799426.481646]  [<ffffffff81051f83>] ? m=
mdrop+0xd/0x1c
Apr  5 02:52:24 rurkh kernel: [799426.481687]  [<ffffffff8105265e>] ? f=
inish_task_switch+0x4d/0x83
Apr  5 02:52:24 rurkh kernel: [799426.481732]  [<ffffffff810484d7>] ? p=
rocess_one_work+0x15a/0x214
Apr  5 02:52:24 rurkh kernel: [799426.481775]  [<ffffffff8104895b>] ? w=
orker_thread+0x139/0x1de
Apr  5 02:52:24 rurkh kernel: [799426.481817]  [<ffffffff81048822>] ? r=
escuer_thread+0x26e/0x26e
Apr  5 02:52:24 rurkh kernel: [799426.481859]  [<ffffffff8104cff6>] ? k=
thread+0x9e/0xa6
Apr  5 02:52:24 rurkh kernel: [799426.481900]  [<ffffffff8104cf58>] ? _=
_kthread_parkme+0x55/0x55
Apr  5 02:52:24 rurkh kernel: [799426.481944]  [<ffffffff8137260c>] ? r=
et_from_fork+0x7c/0xb0
Apr  5 02:52:24 rurkh kernel: [799426.481985]  [<ffffffff8104cf58>] ? _=
_kthread_parkme+0x55/0x55
Apr  5 02:52:24 rurkh kernel: [799426.482025] Code: 26 06 e1 0f 0b 8b 4=
5 5c 85 c0 75 21 48 c7 c1 66 88 30 a0 ba 50 08 00 00 48 c7 c6 50 99 30 =
a0 48 c7 c7 1f 81 30 a0 e8 5b 26 06 e1 <0f> 0b 41 83 fc ff 75 23 48 c7 =
c1 f4 8b 30 a0 ba 51 08 00 00 31=20
Apr  5 02:52:24 rurkh kernel: [799426.482413] RIP  [<ffffffffa0305ae8>]=
 rbd_img_obj_callback+0x91/0x3a2 [rbd]
Apr  5 02:52:24 rurkh kernel: [799426.482462]  RSP <ffff88021a4e5ce8>
Apr  5 02:52:24 rurkh kernel: [799426.483907] ---[ end trace 4aea8b8c10=
7c24be ]---


At this time there was a lot of IO, because of backups in VM.
(but no RBD snapshot create or remove)


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
