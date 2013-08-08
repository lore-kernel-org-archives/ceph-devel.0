From: Laurent Barbe <laurent@ksperis.com>
Subject: Re: [ceph-users] kernel BUG at net/ceph/osd_client.c:2103
Date: Thu, 08 Aug 2013 18:19:44 +0200
Message-ID: <5203C520.9080907@ksperis.com>
References: <1375664836.16182.7.camel@localhost> <1375664968.16182.8.camel@localhost> <alpine.DEB.2.00.1308042055490.5645@cobra.newdream.net> <1375680170.16182.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35281 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab3HHQTt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Aug 2013 12:19:49 -0400
Received: by mail-wi0-f178.google.com with SMTP id j17so771229wiw.17
        for <ceph-devel@vger.kernel.org>; Thu, 08 Aug 2013 09:19:48 -0700 (PDT)
In-Reply-To: <1375680170.16182.9.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: ceph-users@lists.ceph.com

Hello,

I don't know if it's useful, but I can also reproduce this bug with :
rbd kernel 3.10.4
ceph osd 0.61.4
image format 2

rbd formatted in xfs, after some snapshots, and mount/umount test (no=20
write on the file system), xfs mount make segfault and kernel have same=
 log.

Cheers,

Laurent Barbe


Le 05/08/2013 07:22, Olivier Bonvalet a =C3=A9crit :
> Yes of course, thanks !
>
> Le dimanche 04 ao=C3=BBt 2013 =C3=A0 20:59 -0700, Sage Weil a =C3=A9c=
rit :
>> Hi Olivier,
>>
>> This looks like http://tracker.ceph.com/issues/5760.  We should be a=
ble to
>> look at this more closely this week.  In the meantime, you might wan=
t to
>> go back to 3.9.x.  If we have a patch that addresses the bug, would =
you be
>> able to test it?
>>
>> Thanks!
>> sage
>>
>>
>> On Mon, 5 Aug 2013, Olivier Bonvalet wrote:
>>> Sorry, the "dev" list is probably a better place for that one.
>>>
>>> Le lundi 05 ao?t 2013 ? 03:07 +0200, Olivier Bonvalet a ?crit :
>>>> Hi,
>>>>
>>>> I've just upgraded a Xen Dom0 (Debian Wheezy with Xen 4.2.2) from =
Linux
>>>> 3.9.11 to Linux 3.10.5, and now I have kernel panic after launchin=
g some
>>>> VM which use RBD kernel client.
>>>>
>>>>
>>>> In kernel logs, I have :
>>>>
>>>> Aug  5 02:51:22 murmillia kernel: [  289.205652] kernel BUG at net=
/ceph/osd_client.c:2103!
>>>> Aug  5 02:51:22 murmillia kernel: [  289.205725] invalid opcode: 0=
000 [#1] SMP
>>>> Aug  5 02:51:22 murmillia kernel: [  289.205908] Modules linked in=
: cbc rbd libceph libcrc32c xen_gntdev ip6table_mangle ip6t_REJECT ip6t=
able_filter ip6_tables xt_DSCP iptable_mangle xt_LOG xt_physdev ipt_REJ=
ECT xt_tcpudp iptable_filter ip_tables x_tables bridge loop coretemp gh=
ash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_=
helper cryptd iTCO_wdt iTCO_vendor_support gpio_ich microcode serio_raw=
 sb_edac edac_core evdev lpc_ich i2c_i801 mfd_core wmi ac ioatdma shpch=
p button dm_mod hid_generic usbhid hid sg sd_mod crc_t10dif crc32c_inte=
l isci megaraid_sas libsas ahci libahci ehci_pci ehci_hcd libata scsi_t=
ransport_sas igb scsi_mod i2c_algo_bit ixgbe usbcore i2c_core dca usb_c=
ommon ptp pps_core mdio
>>>> Aug  5 02:51:22 murmillia kernel: [  289.210499] CPU: 2 PID: 5326 =
Comm: blkback.3.xvda Not tainted 3.10-dae-dom0 #1
>>>> Aug  5 02:51:22 murmillia kernel: [  289.210617] Hardware name: Su=
permicro X9DRW-7TPF+/X9DRW-7TPF+, BIOS 2.0a 03/11/2013
>>>> Aug  5 02:51:22 murmillia kernel: [  289.210738] task: ffff880037d=
01040 ti: ffff88003803a000 task.ti: ffff88003803a000
>>>> Aug  5 02:51:22 murmillia kernel: [  289.210858] RIP: e030:[<fffff=
fffa02d21d0>]  [<ffffffffa02d21d0>] ceph_osdc_build_request+0x2bb/0x3c6=
 [libceph]
>>>> Aug  5 02:51:22 murmillia kernel: [  289.211062] RSP: e02b:ffff880=
03803b9f8  EFLAGS: 00010212
>>>> Aug  5 02:51:22 murmillia kernel: [  289.211154] RAX: ffff880033a1=
81c0 RBX: ffff880033a182ec RCX: 0000000000000000
>>>> Aug  5 02:51:22 murmillia kernel: [  289.211251] RDX: ffff880033a1=
82af RSI: 0000000000008050 RDI: ffff880030d34888
>>>> Aug  5 02:51:22 murmillia kernel: [  289.211347] RBP: 000000000000=
2000 R08: ffff88003803ba58 R09: 0000000000000000
>>>> Aug  5 02:51:22 murmillia kernel: [  289.211444] R10: 000000000000=
0000 R11: 0000000000000000 R12: ffff880033ba3500
>>>> Aug  5 02:51:22 murmillia kernel: [  289.211541] R13: 000000000000=
0001 R14: ffff88003847aa78 R15: ffff88003847ab58
>>>> Aug  5 02:51:22 murmillia kernel: [  289.211644] FS:  00007f775da8=
c700(0000) GS:ffff88003f840000(0000) knlGS:0000000000000000
>>>> Aug  5 02:51:22 murmillia kernel: [  289.211765] CS:  e033 DS: 000=
0 ES: 0000 CR0: 0000000080050033
>>>> Aug  5 02:51:22 murmillia kernel: [  289.211858] CR2: 00007fa21ee2=
c000 CR3: 000000002be14000 CR4: 0000000000042660
>>>> Aug  5 02:51:22 murmillia kernel: [  289.211956] DR0: 000000000000=
0000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> Aug  5 02:51:22 murmillia kernel: [  289.212052] DR3: 000000000000=
0000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
>>>> Aug  5 02:51:22 murmillia kernel: [  289.212148] Stack:
>>>> Aug  5 02:51:22 murmillia kernel: [  289.212232]  0000000000002000=
 000000243847aa78 0000000000000000 ffff880039949b40
>>>> Aug  5 02:51:22 murmillia kernel: [  289.212577]  0000000000002201=
 ffff880033811d98 ffff88003803ba80 ffff88003847aa78
>>>> Aug  5 02:51:22 murmillia kernel: [  289.212921]  ffff880030f24380=
 ffff880002a38400 0000000000002000 ffffffffa029584c
>>>> Aug  5 02:51:22 murmillia kernel: [  289.213264] Call Trace:
>>>> Aug  5 02:51:22 murmillia kernel: [  289.213358]  [<ffffffffa02958=
4c>] ? rbd_osd_req_format_write+0x71/0x7c [rbd]
>>>> Aug  5 02:51:22 murmillia kernel: [  289.213459]  [<ffffffffa0296f=
05>] ? rbd_img_request_fill+0x695/0x736 [rbd]
>>>> Aug  5 02:51:22 murmillia kernel: [  289.213562]  [<ffffffff810c96=
a7>] ? arch_local_irq_restore+0x7/0x8
>>>> Aug  5 02:51:22 murmillia kernel: [  289.213667]  [<ffffffff81357f=
f8>] ? down_read+0x9/0x19
>>>> Aug  5 02:51:22 murmillia kernel: [  289.213763]  [<ffffffffa02982=
8a>] ? rbd_request_fn+0x191/0x22e [rbd]
>>>> Aug  5 02:51:22 murmillia kernel: [  289.213864]  [<ffffffff8117ac=
9e>] ? __blk_run_queue_uncond+0x1e/0x26
>>>> Aug  5 02:51:22 murmillia kernel: [  289.213962]  [<ffffffff8117b7=
aa>] ? blk_flush_plug_list+0x1c1/0x1e4
>>>> Aug  5 02:51:22 murmillia kernel: [  289.214059]  [<ffffffff8117ba=
ad>] ? blk_finish_plug+0xb/0x2a
>>>> Aug  5 02:51:22 murmillia kernel: [  289.214157]  [<ffffffff81255c=
36>] ? dispatch_rw_block_io+0x33e/0x3f0
>>>> Aug  5 02:51:22 murmillia kernel: [  289.214259]  [<ffffffff81054f=
4b>] ? find_busiest_group+0x28/0x1d4
>>>> Aug  5 02:51:22 murmillia kernel: [  289.214357]  [<ffffffff810551=
b0>] ? load_balance+0xb9/0x5e1
>>>> Aug  5 02:51:22 murmillia kernel: [  289.214454]  [<ffffffff810012=
2a>] ? xen_hypercall_xen_version+0xa/0x20
>>>> Aug  5 02:51:22 murmillia kernel: [  289.214552]  [<ffffffff81255f=
40>] ? __do_block_io_op+0x258/0x390
>>>> Aug  5 02:51:22 murmillia kernel: [  289.214649]  [<ffffffff810026=
fa>] ? xen_end_context_switch+0xa/0x14
>>>> Aug  5 02:51:22 murmillia kernel: [  289.214747]  [<ffffffff810071=
8a>] ? __switch_to+0x13e/0x3c0
>>>> Aug  5 02:51:22 murmillia kernel: [  289.214843]  [<ffffffff812564=
21>] ? xen_blkif_schedule+0x30d/0x418
>>>> Aug  5 02:51:22 murmillia kernel: [  289.214947]  [<ffffffff810487=
1e>] ? finish_wait+0x60/0x60
>>>> Aug  5 02:51:22 murmillia kernel: [  289.215042]  [<ffffffff812561=
14>] ? xen_blkif_be_int+0x25/0x25
>>>> Aug  5 02:51:22 murmillia kernel: [  289.215138]  [<ffffffff81047e=
7c>] ? kthread+0x7d/0x85
>>>> Aug  5 02:51:22 murmillia kernel: [  289.215232]  [<ffffffff81047d=
ff>] ? __kthread_parkme+0x59/0x59
>>>> Aug  5 02:51:22 murmillia kernel: [  289.215332]  [<ffffffff8135e1=
bc>] ? ret_from_fork+0x7c/0xb0
>>>> Aug  5 02:51:22 murmillia kernel: [  289.215427]  [<ffffffff81047d=
ff>] ? __kthread_parkme+0x59/0x59
>>>> Aug  5 02:51:22 murmillia kernel: [  289.215521] Code: c0 00 00 00=
 8b 4c 24 10 66 89 48 22 49 8b 86 c0 00 00 00 8b 14 24 89 50 1e 49 8b 4=
4 24 48 48 89 c2 49 03 54 24 50 48 39 d3 76 02 <0f> 0b 48 29 c3 49 89 5=
c 24 50 41 89 5c 24 16 48 83 c4 28 5b 5d
>>>> Aug  5 02:51:22 murmillia kernel: [  289.219309] RIP  [<ffffffffa0=
2d21d0>] ceph_osdc_build_request+0x2bb/0x3c6 [libceph]
>>>> Aug  5 02:51:22 murmillia kernel: [  289.219492]  RSP <ffff8800380=
3b9f8>
>>>> Aug  5 02:51:22 murmillia kernel: [  289.219631] ---[ end trace 31=
54df728731ac05 ]---
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
