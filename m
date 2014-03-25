From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 12:21:57 -0500
Message-ID: <5331BB35.7070107@ieee.org>
References: <1395736765.2823.29.camel@localhost>		 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>		 <53316D18.7040103@ieee.org>		 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>		 <53317BC2.9010700@ieee.org>		 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>	 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>	 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:37149 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbaCYRVj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 13:21:39 -0400
Received: by mail-vc0-f175.google.com with SMTP id lh14so947781vcb.34
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 10:21:39 -0700 (PDT)
In-Reply-To: <1395767705.9967.5.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 03/25/2014 12:15 PM, Olivier Bonvalet wrote:
> Le mardi 25 mars 2014 =C3=A0 08:31 -0500, Alex Elder a =C3=A9crit :
>> ...
>>>> So, a (partial) fix can be this patch ?
>>>>
>>>
>>>
>>> Yes, roughly.  I'd do the following instead.  It would be great
>>> to learn whether it eliminates the one form of assertion failure
>>> you were seeing.
>>>
>>> 					-Alex
>>>
>>
>>
>> Strike that, my last patch was dead wrong.  Sorry.  Try this:
>>
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -2128,11 +2128,11 @@ static void rbd_img_obj_callback(struct
>>  	rbd_assert(img_request->obj_request_count > 0);
>>  	rbd_assert(which !=3D BAD_WHICH);
>>  	rbd_assert(which < img_request->obj_request_count);
>> -	rbd_assert(which >=3D img_request->next_completion);
>>
>>  	spin_lock_irq(&img_request->completion_lock);
>> -	if (which !=3D img_request->next_completion)
>> +	if (which > img_request->next_completion)
>>  		goto out;
>> +	rbd_assert(which =3D=3D img_request->next_completion);
>>
>>  	for_each_obj_request_from(img_request, obj_request) {
>>  		rbd_assert(more);
>>
>>
>>
>=20
> Well, it just hang :

It's great to know you can reproduce this.

Let me put together another quick patch that might supply a bit
more information when it happens.  I'll send something shortly.

					-Alex

> Mar 25 17:58:36 rurkh kernel: [ 4135.913079] Assertion failure in rbd=
_img_obj_callback() at line 2135:
> Mar 25 17:58:36 rurkh kernel: [ 4135.913079]=20
> Mar 25 17:58:36 rurkh kernel: [ 4135.913079] 	rbd_assert(which =3D=3D=
 img_request->next_completion);
> Mar 25 17:58:36 rurkh kernel: [ 4135.913079]=20
> Mar 25 17:58:36 rurkh kernel: [ 4135.913252] ------------[ cut here ]=
------------
> Mar 25 17:58:36 rurkh kernel: [ 4135.913288] kernel BUG at drivers/bl=
ock/rbd.c:2135!
> Mar 25 17:58:36 rurkh kernel: [ 4135.913331] invalid opcode: 0000 [#1=
] SMP=20
> Mar 25 17:58:36 rurkh kernel: [ 4135.913373] Modules linked in: cbc r=
bd libceph xen_gntdev xt_physdev iptable_filter ip_tables x_tables xfs =
libcrc32c bridge loop iTCO_wdt iTCO_vendor_support gpio_ich serio_raw s=
b_edac edac_core i2c_i801 lpc_ich mfd_core evdev ioatdma shpchp ipmi_si=
 ipmi_msghandler wmi ac button dm_mod hid_generic usbhid hid sg sd_mod =
crc_t10dif crct10dif_common isci ahci libsas libahci megaraid_sas libat=
a scsi_transport_sas ehci_pci igb scsi_mod ehci_hcd ixgbe i2c_algo_bit =
i2c_core usbcore dca ptp usb_common pps_core mdio
> Mar 25 17:58:36 rurkh kernel: [ 4135.913821] CPU: 0 PID: 30629 Comm: =
kworker/0:1 Not tainted 3.13-dae-dom0 #20
> Mar 25 17:58:36 rurkh kernel: [ 4135.913863] Hardware name: Supermicr=
o X9DRW-7TPF+/X9DRW-7TPF+, BIOS 3.0 07/24/2013
> Mar 25 17:58:36 rurkh kernel: [ 4135.913931] Workqueue: ceph-msgr con=
_work [libceph]
> Mar 25 17:58:36 rurkh kernel: [ 4135.913970] task: ffff88027374b760 t=
i: ffff88024933c000 task.ti: ffff88024933c000
> Mar 25 17:58:36 rurkh kernel: [ 4135.914033] RIP: e030:[<ffffffffa030=
4b86>]  [<ffffffffa0304b86>] rbd_img_obj_callback+0x12f/0x3d0 [rbd]
> Mar 25 17:58:36 rurkh kernel: [ 4135.914104] RSP: e02b:ffff88024933dc=
e8  EFLAGS: 00010082
> Mar 25 17:58:36 rurkh kernel: [ 4135.914141] RAX: 0000000000000070 RB=
X: ffff88024d2dcc48 RCX: 0000000000000000
> Mar 25 17:58:36 rurkh kernel: [ 4135.914182] RDX: ffff88027fe0eb50 RS=
I: ffff88027fe0e1a8 RDI: ffff8802493300a8
> Mar 25 17:58:36 rurkh kernel: [ 4135.914223] RBP: ffff88024ccc3e20 R0=
8: 0000000000000000 R09: 0000000000000000
> Mar 25 17:58:36 rurkh kernel: [ 4135.914265] R10: 0000000000000000 R1=
1: 0000000000000098 R12: 0000000000000001
> Mar 25 17:58:36 rurkh kernel: [ 4135.914306] R13: 0000000000000000 R1=
4: ffff88027144b1d0 R15: 0000000000000000
> Mar 25 17:58:36 rurkh kernel: [ 4135.914351] FS:  00007f6ec996f700(00=
00) GS:ffff88027fe00000(0000) knlGS:0000000000000000
> Mar 25 17:58:36 rurkh kernel: [ 4135.914415] CS:  e033 DS: 0000 ES: 0=
000 CR0: 0000000080050033
> Mar 25 17:58:36 rurkh kernel: [ 4135.914453] CR2: 0000000001ff1b10 CR=
3: 00000002492b3000 CR4: 0000000000042660
> Mar 25 17:58:36 rurkh kernel: [ 4135.914495] Stack:
> Mar 25 17:58:36 rurkh kernel: [ 4135.914524]  ffff88024ccc3e5c ffff88=
024a48eb5d ffffffffffffffff ffff88024a48eb28
> Mar 25 17:58:36 rurkh kernel: [ 4135.914610]  ffff88027144b1c8 ffff88=
02656cc718 0000000000000000 ffff88027144b1d0
> Mar 25 17:58:36 rurkh kernel: [ 4135.914689]  0000000000000000 ffffff=
ffa02e3595 0000000000000015 ffff8802656cc770
> Mar 25 17:58:36 rurkh kernel: [ 4135.914768] Call Trace:
> Mar 25 17:58:36 rurkh kernel: [ 4135.914809]  [<ffffffffa02e3595>] ? =
dispatch+0x3e4/0x55e [libceph]
> Mar 25 17:58:36 rurkh kernel: [ 4135.914854]  [<ffffffffa02de0fc>] ? =
con_work+0xf6e/0x1a65 [libceph]
> Mar 25 17:58:36 rurkh kernel: [ 4135.914901]  [<ffffffff81005f00>] ? =
xen_timer_resume+0x4f/0x4f
> Mar 25 17:58:36 rurkh kernel: [ 4135.914944]  [<ffffffff81051f83>] ? =
mmdrop+0xd/0x1c
> Mar 25 17:58:36 rurkh kernel: [ 4135.914984]  [<ffffffff8105265e>] ? =
finish_task_switch+0x4d/0x83
> Mar 25 17:58:36 rurkh kernel: [ 4135.915029]  [<ffffffff810484d7>] ? =
process_one_work+0x15a/0x214
> Mar 25 17:58:36 rurkh kernel: [ 4135.915072]  [<ffffffff8104895b>] ? =
worker_thread+0x139/0x1de
> Mar 25 17:58:36 rurkh kernel: [ 4135.915113]  [<ffffffff81048822>] ? =
rescuer_thread+0x26e/0x26e
> Mar 25 17:58:36 rurkh kernel: [ 4135.915155]  [<ffffffff8104cff6>] ? =
kthread+0x9e/0xa6
> Mar 25 17:58:36 rurkh kernel: [ 4135.915195]  [<ffffffff8104cf58>] ? =
__kthread_parkme+0x55/0x55
> Mar 25 17:58:36 rurkh kernel: [ 4135.915238]  [<ffffffff8137260c>] ? =
ret_from_fork+0x7c/0xb0
> Mar 25 17:58:36 rurkh kernel: [ 4135.915279]  [<ffffffff8104cf58>] ? =
__kthread_parkme+0x55/0x55
> Mar 25 17:58:36 rurkh kernel: [ 4135.915319] Code: 41 b5 01 48 89 44 =
24 08 eb 3b 48 c7 c1 2e 7c 30 a0 ba 57 08 00 00 31 c0 48 c7 c6 80 89 30=
 a0 48 c7 c7 1f 71 30 a0 e8 bd 35 06 e1 <0f> 0b 41 8b 45 5c ff c8 39 43=
 40 41 0f 92 c5 48 8b 5b 30 41 ff=20
> Mar 25 17:58:36 rurkh kernel: [ 4135.915701] RIP  [<ffffffffa0304b86>=
] rbd_img_obj_callback+0x12f/0x3d0 [rbd]
> Mar 25 17:58:36 rurkh kernel: [ 4135.915749]  RSP <ffff88024933dce8>
> Mar 25 17:58:36 rurkh kernel: [ 4135.916087] ---[ end trace ff823e5e2=
d6cd4e9 ]--
>=20
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
