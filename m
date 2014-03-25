From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 17:46:55 -0500
Message-ID: <5332075F.8080105@ieee.org>
References: <1395736765.2823.29.camel@localhost>	 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>	 <53317BC2.9010700@ieee.org>	 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>	 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>	 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>	 <5331C05D.1060008@ieee.org> <1395773582.2076.10.camel@localhost>	 <5331D2E8.6060002@ieee.org>	 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>	 <1395778894.2076.12.camel@localhost> <1395780835.2076.15.camel@localhost>	 <1395781847.2076.21.camel@localhost>	 <CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>	 <1395782577.2076.23.camel@localhost>	 <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.co
 m>	 <1395783675.2076.26.camel@localhost>	 <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>	 <1395784476.2076.28.camel@localhost> <1395785839.2076.30.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:48880 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704AbaCYWqh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 18:46:37 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so3118812qgd.9
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 15:46:37 -0700 (PDT)
In-Reply-To: <1395785839.2076.30.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <mailinglist@daevel.fr>, Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 03/25/2014 05:17 PM, Olivier Bonvalet wrote:
> Le mardi 25 mars 2014 =C3=A0 22:54 +0100, Olivier Bonvalet a =C3=A9cr=
it :
>> Le mardi 25 mars 2014 =C3=A0 23:49 +0200, Ilya Dryomov a =C3=A9crit =
:
>>> On Tue, Mar 25, 2014 at 11:41 PM, Olivier Bonvalet <ceph.list@daeve=
l.fr> wrote:
>>>> mmm the cluster seems to be in a really bad state now : all hosts =
are
>>>> hanging. Is it possible that mounting images without the rbd_asser=
t(0)
>>>> broke some images ?
>>>>
>>>
>>> I don't think so.  As far as I can tell all occurrences that you
>>> reported tripped over one of the asserts.  It's probably just that =
for
>>> some reason you are now hitting this bug much more frequently than =
once
>>> a week.
>>>
>>> Thanks,
>>>
>>>                 Ilya
>>> --
>>
>> Ok thanks, I'm =C2=ABreassured=C2=BB.
>>
>> At reboot VM are much more I/O loaded, because of cache flush. It's
>> probably the reason why it now hang often.
>>
>> I have to wait a little between starting each VM.
>>
>> --
>=20
> I now have this one very often (here 5 minutes after the host boot) :

I am fairly sure this indicates a use-after-free scenario,
likely caused by something getting deleted before every
user was done with it.

I believe Ilya is done for the night; I'm going to spend some
time looking at this to try to determine the cause.  If you
are willing I'd love to have you try whatever fix I come up
with.  I'd rather find a fix than just collect more information,
but I may need to get more, we'll see.

Thank you for all your reports, they help a lot.

					-Alex

>=20
> Mar 25 23:14:45 rurkh kernel: [  330.054196] rbd_img_obj_callback: ba=
d image object request information:
> Mar 25 23:14:45 rurkh kernel: [  330.054205] obj_request ffff88025f3d=
f058
> Mar 25 23:14:45 rurkh kernel: [  330.054209]     ->object_name <(null=
)>
> Mar 25 23:14:45 rurkh kernel: [  330.054211]     ->offset 0
> Mar 25 23:14:45 rurkh kernel: [  330.054213]     ->length 4096
> Mar 25 23:14:45 rurkh kernel: [  330.054216]     ->type 0x1
> Mar 25 23:14:45 rurkh kernel: [  330.054218]     ->flags 0x3
> Mar 25 23:14:45 rurkh kernel: [  330.054220]     ->which 4294967295
> Mar 25 23:14:45 rurkh kernel: [  330.054222]     ->xferred 4096
> Mar 25 23:14:45 rurkh kernel: [  330.054224]     ->result 0
> Mar 25 23:14:45 rurkh kernel: [  330.054227] img_request ffff8802731f=
8448
> Mar 25 23:14:45 rurkh kernel: [  330.054229]     ->snap 0xfffffffffff=
ffffe
> Mar 25 23:14:45 rurkh kernel: [  330.054231]     ->offset 2508181504
> Mar 25 23:14:45 rurkh kernel: [  330.054233]     ->length 16384
> Mar 25 23:14:45 rurkh kernel: [  330.054235]     ->flags 0x0
> Mar 25 23:14:45 rurkh kernel: [  330.054237]     ->obj_request_count =
0
> Mar 25 23:14:45 rurkh kernel: [  330.054239]     ->next_completion 2
> Mar 25 23:14:45 rurkh kernel: [  330.054241]     ->xferred 16384
> Mar 25 23:14:45 rurkh kernel: [  330.054243]     ->result 0
> Mar 25 23:14:45 rurkh kernel: [  330.054247]=20
> Mar 25 23:14:45 rurkh kernel: [  330.054247] Assertion failure in rbd=
_img_obj_callback() at line 2159:
> Mar 25 23:14:45 rurkh kernel: [  330.054247]=20
> Mar 25 23:14:45 rurkh kernel: [  330.054247] 	rbd_assert(0);
> Mar 25 23:14:45 rurkh kernel: [  330.054247]=20
> Mar 25 23:14:45 rurkh kernel: [  330.054495] ------------[ cut here ]=
------------
> Mar 25 23:14:45 rurkh kernel: [  330.054585] kernel BUG at drivers/bl=
ock/rbd.c:2159!
> Mar 25 23:14:45 rurkh kernel: [  330.054676] invalid opcode: 0000 [#1=
] SMP=20
> Mar 25 23:14:45 rurkh kernel: [  330.054874] Modules linked in: cbc r=
bd libceph xen_gntdev xt_physdev iptable_filter ip_tables x_tables xfs =
libcrc32c bridge loop iTCO_wdt gpio_ich iTCO_vendor_support serio_raw s=
b_edac edac_core evdev i2c_i801 lpc_ich mfd_core ioatdma shpchp wmi ipm=
i_si ipmi_msghandler ac button dm_mod hid_generic usbhid hid sg sd_mod =
crc_t10dif crct10dif_common megaraid_sas isci ahci libsas libahci libat=
a scsi_transport_sas ehci_pci ehci_hcd scsi_mod usbcore igb usb_common =
i2c_algo_bit ixgbe i2c_core dca ptp pps_core mdio
> Mar 25 23:14:45 rurkh kernel: [  330.058433] CPU: 2 PID: 6365 Comm: k=
worker/2:3 Not tainted 3.13-dae-dom0 #22
> Mar 25 23:14:45 rurkh kernel: [  330.058528] Hardware name: Supermicr=
o X9DRW-7TPF+/X9DRW-7TPF+, BIOS 3.0 07/24/2013
> Mar 25 23:14:45 rurkh kernel: [  330.058659] Workqueue: ceph-msgr con=
_work [libceph]
> Mar 25 23:14:45 rurkh kernel: [  330.058805] task: ffff88026da5b820 t=
i: ffff88025dfe2000 task.ti: ffff88025dfe2000
> Mar 25 23:14:45 rurkh kernel: [  330.058922] RIP: e030:[<ffffffffa030=
9cd9>]  [<ffffffffa0309cd9>] rbd_img_obj_callback+0x282/0x523 [rbd]
> Mar 25 23:14:45 rurkh kernel: [  330.059107] RSP: e02b:ffff88025dfe3c=
e8  EFLAGS: 00010082
> Mar 25 23:14:45 rurkh kernel: [  330.059199] RAX: 000000000000004c RB=
X: ffff88025f3df058 RCX: 0000000000000007
> Mar 25 23:14:45 rurkh kernel: [  330.059300] RDX: 0000000000000006 RS=
I: 0000000000000000 RDI: ffff88025dfe00a8
> Mar 25 23:14:45 rurkh kernel: [  330.059397] RBP: ffff8802731f8448 R0=
8: 0000000000000000 R09: 0000000000000000
> Mar 25 23:14:45 rurkh kernel: [  330.059491] R10: 0000000000000000 R1=
1: ffff88025f712d66 R12: 0000000000000001
> Mar 25 23:14:45 rurkh kernel: [  330.059587] R13: 0000000000000000 R1=
4: ffff88025f712ad0 R15: 0000000000000000
> Mar 25 23:14:45 rurkh kernel: [  330.059689] FS:  00007f2fd8882700(00=
00) GS:ffff88027fe40000(0000) knlGS:0000000000000000
> Mar 25 23:14:45 rurkh kernel: [  330.059807] CS:  e033 DS: 0000 ES: 0=
000 CR0: 0000000080050033
> Mar 25 23:14:45 rurkh kernel: [  330.059899] CR2: 00007f7a1e28f000 CR=
3: 000000000160c000 CR4: 0000000000042660
> Mar 25 23:14:45 rurkh kernel: [  330.059997] Stack:
> Mar 25 23:14:45 rurkh kernel: [  330.060086]  ffff8802731f8484 ffff88=
02730f2c45 ffffffffffffffff ffff8802730f2c10
> Mar 25 23:14:45 rurkh kernel: [  330.060339]  ffff88025f712ac8 ffff88=
02703b4718 0000000000000000 ffff88025f712ad0
> Mar 25 23:14:45 rurkh kernel: [  330.060573]  0000000000000000 ffffff=
ffa02f5595 0000000000000015 ffff8802703b4770
> Mar 25 23:14:45 rurkh kernel: [  330.060811] Call Trace:
> Mar 25 23:14:45 rurkh kernel: [  330.060878]  [<ffffffffa02f5595>] ? =
dispatch+0x3e4/0x55e [libceph]
> Mar 25 23:14:45 rurkh kernel: [  330.060954]  [<ffffffffa02f00fc>] ? =
con_work+0xf6e/0x1a65 [libceph]
> Mar 25 23:14:45 rurkh kernel: [  330.061029]  [<ffffffff81051f83>] ? =
mmdrop+0xd/0x1c
> Mar 25 23:14:45 rurkh kernel: [  330.061098]  [<ffffffff8105265e>] ? =
finish_task_switch+0x4d/0x83
> Mar 25 23:14:45 rurkh kernel: [  330.061171]  [<ffffffff810484d7>] ? =
process_one_work+0x15a/0x214
> Mar 25 23:14:45 rurkh kernel: [  330.061243]  [<ffffffff8104895b>] ? =
worker_thread+0x139/0x1de
> Mar 25 23:14:45 rurkh kernel: [  330.061313]  [<ffffffff81048822>] ? =
rescuer_thread+0x26e/0x26e
> Mar 25 23:14:45 rurkh kernel: [  330.061385]  [<ffffffff8104cff6>] ? =
kthread+0x9e/0xa6
> Mar 25 23:14:45 rurkh kernel: [  330.061454]  [<ffffffff8104cf58>] ? =
__kthread_parkme+0x55/0x55
> Mar 25 23:14:45 rurkh kernel: [  330.061530]  [<ffffffff8137260c>] ? =
ret_from_fork+0x7c/0xb0
> Mar 25 23:14:45 rurkh kernel: [  330.061606]  [<ffffffff8104cf58>] ? =
__kthread_parkme+0x55/0x55
> Mar 25 23:14:45 rurkh kernel: [  330.061677] Code: cc 30 a0 31 c0 e8 =
8b e4 05 e1 48 c7 c1 5c cd 30 a0 31 c0 ba 6f 08 00 00 48 c7 c6 80 da 30=
 a0 48 c7 c7 1f c1 30 a0 e8 6a e4 05 e1 <0f> 0b 41 8b 45 5c ff c8 39 43=
 40 41 0f 92 c5 48 8b 5b 30 41 ff=20
> Mar 25 23:14:45 rurkh kernel: [  330.064345] RIP  [<ffffffffa0309cd9>=
] rbd_img_obj_callback+0x282/0x523 [rbd]
> Mar 25 23:14:45 rurkh kernel: [  330.064481]  RSP <ffff88025dfe3ce8>
> Mar 25 23:14:45 rurkh kernel: [  330.064562] ---[ end trace 74103a003=
e0d553e ]---
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
