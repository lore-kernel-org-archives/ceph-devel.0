From: Laurent Barbe <laurent@ksperis.com>
Subject: Re: [ceph-users] kernel BUG at net/ceph/osd_client.c:2103
Date: Thu, 22 Aug 2013 02:07:05 +0200
Message-ID: <B6B21682-A9E4-46D6-8140-42E2845A3742@ksperis.com>
References: <1375664836.16182.7.camel@localhost> <1375664968.16182.8.camel@localhost> <alpine.DEB.2.00.1308042055490.5645@cobra.newdream.net> <1375680170.16182.9.camel@localhost> <5203C520.9080907@ksperis.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:40355 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab3HVAHJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 20:07:09 -0400
Received: by mail-wg0-f51.google.com with SMTP id a12so973228wgh.6
        for <ceph-devel@vger.kernel.org>; Wed, 21 Aug 2013 17:07:07 -0700 (PDT)
In-Reply-To: <5203C520.9080907@ksperis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

It seems that the problem is always present in kernel client 3.10.7 / c=
eph 0.61.8 (sometimes)
I make a clone from last snapshot, and it works again :)

Cheers,

Laurent Barbe


Le 8 ao=FBt 2013 =E0 18:19, Laurent Barbe <laurent@ksperis.com> a =E9cr=
it :

> Hello,
>=20
> I don't know if it's useful, but I can also reproduce this bug with :
> rbd kernel 3.10.4
> ceph osd 0.61.4
> image format 2
>=20
> rbd formatted in xfs, after some snapshots, and mount/umount test (no=
 write on the file system), xfs mount make segfault and kernel have sam=
e log.
>=20
> Cheers,
>=20
> Laurent Barbe
>=20
>=20
> Le 05/08/2013 07:22, Olivier Bonvalet a =E9crit :
>> Yes of course, thanks !
>>=20
>> Le dimanche 04 ao=FBt 2013 =E0 20:59 -0700, Sage Weil a =E9crit :
>>> Hi Olivier,
>>>=20
>>> This looks like http://tracker.ceph.com/issues/5760.  We should be =
able to
>>> look at this more closely this week.  In the meantime, you might wa=
nt to
>>> go back to 3.9.x.  If we have a patch that addresses the bug, would=
 you be
>>> able to test it?
>>>=20
>>> Thanks!
>>> sage
>>>=20
>>>=20
>>> On Mon, 5 Aug 2013, Olivier Bonvalet wrote:
>>>> Sorry, the "dev" list is probably a better place for that one.
>>>>=20
>>>> Le lundi 05 ao?t 2013 ? 03:07 +0200, Olivier Bonvalet a ?crit :
>>>>> Hi,
>>>>>=20
>>>>> I've just upgraded a Xen Dom0 (Debian Wheezy with Xen 4.2.2) from=
 Linux
>>>>> 3.9.11 to Linux 3.10.5, and now I have kernel panic after launchi=
ng some
>>>>> VM which use RBD kernel client.
>>>>>=20
>>>>>=20
>>>>> In kernel logs, I have :
>>>>>=20
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.205652] kernel BUG at ne=
t/ceph/osd_client.c:2103!
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.205725] invalid opcode: =
0000 [#1] SMP
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.205908] Modules linked i=
n: cbc rbd libceph libcrc32c xen_gntdev ip6table_mangle ip6t_REJECT ip6=
table_filter ip6_tables xt_DSCP iptable_mangle xt_LOG xt_physdev ipt_RE=
JECT xt_tcpudp iptable_filter ip_tables x_tables bridge loop coretemp g=
hash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk=
_helper cryptd iTCO_wdt iTCO_vendor_support gpio_ich microcode serio_ra=
w sb_edac edac_core evdev lpc_ich i2c_i801 mfd_core wmi ac ioatdma shpc=
hp button dm_mod hid_generic usbhid hid sg sd_mod crc_t10dif crc32c_int=
el isci megaraid_sas libsas ahci libahci ehci_pci ehci_hcd libata scsi_=
transport_sas igb scsi_mod i2c_algo_bit ixgbe usbcore i2c_core dca usb_=
common ptp pps_core mdio
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.210499] CPU: 2 PID: 5326=
 Comm: blkback.3.xvda Not tainted 3.10-dae-dom0 #1
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.210617] Hardware name: S=
upermicro X9DRW-7TPF+/X9DRW-7TPF+, BIOS 2.0a 03/11/2013
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.210738] task: ffff880037=
d01040 ti: ffff88003803a000 task.ti: ffff88003803a000
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.210858] RIP: e030:[<ffff=
ffffa02d21d0>]  [<ffffffffa02d21d0>] ceph_osdc_build_request+0x2bb/0x3c=
6 [libceph]
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.211062] RSP: e02b:ffff88=
003803b9f8  EFLAGS: 00010212
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.211154] RAX: ffff880033a=
181c0 RBX: ffff880033a182ec RCX: 0000000000000000
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.211251] RDX: ffff880033a=
182af RSI: 0000000000008050 RDI: ffff880030d34888
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.211347] RBP: 00000000000=
02000 R08: ffff88003803ba58 R09: 0000000000000000
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.211444] R10: 00000000000=
00000 R11: 0000000000000000 R12: ffff880033ba3500
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.211541] R13: 00000000000=
00001 R14: ffff88003847aa78 R15: ffff88003847ab58
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.211644] FS:  00007f775da=
8c700(0000) GS:ffff88003f840000(0000) knlGS:0000000000000000
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.211765] CS:  e033 DS: 00=
00 ES: 0000 CR0: 0000000080050033
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.211858] CR2: 00007fa21ee=
2c000 CR3: 000000002be14000 CR4: 0000000000042660
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.211956] DR0: 00000000000=
00000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.212052] DR3: 00000000000=
00000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.212148] Stack:
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.212232]  000000000000200=
0 000000243847aa78 0000000000000000 ffff880039949b40
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.212577]  000000000000220=
1 ffff880033811d98 ffff88003803ba80 ffff88003847aa78
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.212921]  ffff880030f2438=
0 ffff880002a38400 0000000000002000 ffffffffa029584c
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.213264] Call Trace:
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.213358]  [<ffffffffa0295=
84c>] ? rbd_osd_req_format_write+0x71/0x7c [rbd]
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.213459]  [<ffffffffa0296=
f05>] ? rbd_img_request_fill+0x695/0x736 [rbd]
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.213562]  [<ffffffff810c9=
6a7>] ? arch_local_irq_restore+0x7/0x8
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.213667]  [<ffffffff81357=
ff8>] ? down_read+0x9/0x19
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.213763]  [<ffffffffa0298=
28a>] ? rbd_request_fn+0x191/0x22e [rbd]
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.213864]  [<ffffffff8117a=
c9e>] ? __blk_run_queue_uncond+0x1e/0x26
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.213962]  [<ffffffff8117b=
7aa>] ? blk_flush_plug_list+0x1c1/0x1e4
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.214059]  [<ffffffff8117b=
aad>] ? blk_finish_plug+0xb/0x2a
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.214157]  [<ffffffff81255=
c36>] ? dispatch_rw_block_io+0x33e/0x3f0
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.214259]  [<ffffffff81054=
f4b>] ? find_busiest_group+0x28/0x1d4
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.214357]  [<ffffffff81055=
1b0>] ? load_balance+0xb9/0x5e1
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.214454]  [<ffffffff81001=
22a>] ? xen_hypercall_xen_version+0xa/0x20
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.214552]  [<ffffffff81255=
f40>] ? __do_block_io_op+0x258/0x390
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.214649]  [<ffffffff81002=
6fa>] ? xen_end_context_switch+0xa/0x14
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.214747]  [<ffffffff81007=
18a>] ? __switch_to+0x13e/0x3c0
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.214843]  [<ffffffff81256=
421>] ? xen_blkif_schedule+0x30d/0x418
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.214947]  [<ffffffff81048=
71e>] ? finish_wait+0x60/0x60
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.215042]  [<ffffffff81256=
114>] ? xen_blkif_be_int+0x25/0x25
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.215138]  [<ffffffff81047=
e7c>] ? kthread+0x7d/0x85
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.215232]  [<ffffffff81047=
dff>] ? __kthread_parkme+0x59/0x59
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.215332]  [<ffffffff8135e=
1bc>] ? ret_from_fork+0x7c/0xb0
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.215427]  [<ffffffff81047=
dff>] ? __kthread_parkme+0x59/0x59
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.215521] Code: c0 00 00 0=
0 8b 4c 24 10 66 89 48 22 49 8b 86 c0 00 00 00 8b 14 24 89 50 1e 49 8b =
44 24 48 48 89 c2 49 03 54 24 50 48 39 d3 76 02 <0f> 0b 48 29 c3 49 89 =
5c 24 50 41 89 5c 24 16 48 83 c4 28 5b 5d
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.219309] RIP  [<ffffffffa=
02d21d0>] ceph_osdc_build_request+0x2bb/0x3c6 [libceph]
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.219492]  RSP <ffff880038=
03b9f8>
>>>>> Aug  5 02:51:22 murmillia kernel: [  289.219631] ---[ end trace 3=
154df728731ac05 ]---
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> _______________________________________________
>>>>> ceph-users mailing list
>>>>> ceph-users@lists.ceph.com
>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>=20
>>>>=20
>>>>=20
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>=20
>>>>=20
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>=20
>>=20
>>=20
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
