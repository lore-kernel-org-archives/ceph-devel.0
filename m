From: Eric Eastman <eric.eastman@keepertech.com>
Subject: Re: Issue with Ceph File System and LIO
Date: Fri, 18 Dec 2015 08:53:22 -0700
Message-ID: <CA+9C14Ye392XcmrkuRqpig1v4kgczZFfwESyXzFMP6tpzF14hA@mail.gmail.com>
References: <CA+9C14a0E9bc+GL-QiAxPD_B9_PRhEE4PRG2jAa9REWkdNQFiA@mail.gmail.com>
	<CAAM7YAk=U7NqEujuMXAyem00NDJfx-TOYGgJez76f48HS6nt2A@mail.gmail.com>
	<CA+9C14ZOZQcWSGL8ukDeVQAtoTEDRNOLq=CB1ZusiMsx6-seMw@mail.gmail.com>
	<CAAM7YAnktfNvd-EXU+1Eok4kUafWwnvj+CCGocF7ffTcAt-dsA@mail.gmail.com>
	<CA+9C14bbtBjgOD0hpSfapRrsx+Eg_dYyFfV+uXvgB5X7eRidDg@mail.gmail.com>
	<CA+9C14bMs1u80P3g1D4QsDHHzLy5YUvB+KWmcrKa0o5aX9W38g@mail.gmail.com>
	<CAAM7YAm2r+LVPMpE_GbWCJmE-bdi-uXHyzqAR1JgPMXCSx55pQ@mail.gmail.com>
	<CA+9C14bVgWKMxxOe04qiLW6U+baA_TGbFt9RNjY+wPNMiW_R3w@mail.gmail.com>
	<CAAM7YAkTA9skmSxyEPVnEWAyykg4hsoLwxxjFp2nJgMbJAC8VQ@mail.gmail.com>
	<00b601d13954$5d4a94e0$17dfbea0$@samsung.com>
	<CA+9C14aAAVaaLtjDCjLkc9TSmU=aMh-2iq0xKOb-KEcc9vcuMQ@mail.gmail.com>
	<CAAM7YAky6409uw-hyDOJFE+3ftm46cDXpWG7RHznbZtQXcneCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35306 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbbLRPxX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Dec 2015 10:53:23 -0500
Received: by mail-yk0-f173.google.com with SMTP id v6so62024844ykc.2
        for <ceph-devel@vger.kernel.org>; Fri, 18 Dec 2015 07:53:23 -0800 (PST)
In-Reply-To: <CAAM7YAky6409uw-hyDOJFE+3ftm46cDXpWG7RHznbZtQXcneCw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Chao Yu <chao2.yu@samsung.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Dec 18, 2015 at 12:18 AM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Fri, Dec 18, 2015 at 2:23 PM, Eric Eastman
> <eric.eastman@keepertech.com> wrote:
>>> Hi Yan Zheng, Eric Eastman
>>>
>>> Similar bug was reported in f2fs, btrfs, it does affect 4.4-rc4, the fixing
>>> patch was merged into 4.4-rc5, dfd01f026058 ("sched/wait: Fix the signal
>>> handling fix").
>>>
>>> Related report & discussion was here:
>>> https://lkml.org/lkml/2015/12/12/149
>>>
>>> I'm not sure the current reported issue of ceph was related to that though,
>>> but at least try testing with an upgraded or patched kernel could verify it.
>>> :)
>>>
>>> Thanks,
>>>
>>>> -----Original Message-----
>>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of
>>>> Yan, Zheng
>>>> Sent: Friday, December 18, 2015 12:05 PM
>>>> To: Eric Eastman
>>>>
>>>> The page gets unlocked mystically. I still don't find any clue. Could
>>>> you please try the new patch (not incremental patch). Besides, please
>>>> enable CONFIG_DEBUG_VM when compiling the kernel.
>>>>
>>>> Thanks you very much
>>>> Yan, Zheng
>>>
>> I have just installed the cephfs_new.patch and have set
>> CONFIG_DEBUG_VM=y on a new 4.4rc4 kernel and restarted the ESXi iSCSI
>> test to my Ceph File System gateway.  I plan to let it run overnight
>> and report the status tomorrow.
>>
>> Let me know if I should move on to 4.4rc5 with or without patches and
>> with or without  CONFIG_DEBUG_VM=y
>>
>
> please try rc5 kernel without patches and DEBUG_VM=y
>
> Regards
> Yan, Zheng
>

With the 4.4rc4 kernel and the cephfs_new.patch and CONFIG_DEBUG_VM=y
I hit a BUG in mm/filemap.c. I will start a test with the 4.4rc5
kernel and get back to the list.  I put the whole dmesg -T output
showing this BUG and some Ceph Warnings in the tracker ticket #14086

Fri Dec 18 01:14:39 2015] kernel BUG at mm/filemap.c:812!
[Fri Dec 18 01:14:39 2015] invalid opcode: 0000 [#1] SMP
[Fri Dec 18 01:14:39 2015] Modules linked in: iscsi_target_mod
vhost_scsi tcm_qla2xxx ib_srpt tcm_fc tcm_usb_gadget tcm_loop
target_core_file target_core_iblock target_core_pscsi target_core_user
target_core_mod ipmi_devintf vhost qla2xxx ib_cm ib_sa ib_mad ib_core
ib_addr libfc scsi_transport_fc libcomposite udc_core uio configfs ttm
drm_kms_helper coretemp drm kvm ipmi_ssif gpio_ich ceph i2c_algo_bit
fb_sys_fops syscopyarea input_leds sysfillrect sysimgblt irqbypass
shpchp hpilo serio_raw acpi_power_meter ipmi_si lpc_ich i7core_edac
ipmi_msghandler edac_core 8250_fintek libceph mac_hid libcrc32c
fscache bonding lp parport mlx4_en vxlan ip6_udp_tunnel udp_tunnel ptp
pps_core hid_generic usbhid hid mlx4_core psmouse hpsa bnx2 fjes
scsi_transport_sas [last unloaded: target_core_mod]
[Fri Dec 18 01:14:39 2015] CPU: 0 PID: 2147 Comm: iscsi_trx Tainted: G
       W I     4.4.0-rc4-ede3-DEBUG_VM #1
[Fri Dec 18 01:14:39 2015] Hardware name: HP ProLiant DL360 G6, BIOS
P64 01/22/2015
[Fri Dec 18 01:14:39 2015] task: ffff880c02077080 ti: ffff880bfce5c000
task.ti: ffff880bfce5c000
[Fri Dec 18 01:14:39 2015] RIP: 0010:[<ffffffff8117d041>]
[<ffffffff8117d041>] unlock_page+0x81/0x90
[Fri Dec 18 01:14:39 2015] RSP: 0018:ffff880bfce5f9b8  EFLAGS: 00010282
[Fri Dec 18 01:14:39 2015] RAX: 0000000000000021 RBX: ffffea0015d36ac0
RCX: 0000000000000000
[Fri Dec 18 01:14:40 2015] RDX: 0000000000000021 RSI: ffff880607a0dc78
RDI: ffff880607a0dc78
[Fri Dec 18 01:14:40 2015] RBP: ffff880bfce5f9b8 R08: 0000000000000000
R09: 000000000000041e
[Fri Dec 18 01:14:40 2015] R10: 0000000000000246 R11: 000000000000041e
R12: 0000000000000000
[Fri Dec 18 01:14:40 2015] R13: 0000000000001000 R14: ffff8800dad39f88
R15: 0000000000001000
[Fri Dec 18 01:14:40 2015] FS:  0000000000000000(0000)
GS:ffff880607a00000(0000) knlGS:0000000000000000
[Fri Dec 18 01:14:40 2015] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[Fri Dec 18 01:14:40 2015] CR2: 00000000008e6f90 CR3: 0000000001c0a000
CR4: 00000000000006f0
[Fri Dec 18 01:14:40 2015] Stack:
[Fri Dec 18 01:14:40 2015]  ffff880bfce5fa00 ffffffffc02d4ac6
ffff880bfce5fa00 ffffffff813c5456
[Fri Dec 18 01:14:40 2015]  0000000000001000 000000081e838000
ffff880bfce5fc80 0000000000000000
[Fri Dec 18 01:14:40 2015]  ffff8800dad3a0f0 ffff880bfce5fa88
ffffffff8117cb95 ffff88002cd5ec80
[Fri Dec 18 01:14:40 2015] Call Trace:
[Fri Dec 18 01:14:40 2015]  [<ffffffffc02d4ac6>]
ceph_write_end+0x66/0x180 [ceph]
[Fri Dec 18 01:14:40 2015]  [<ffffffff813c5456>] ?
iov_iter_copy_from_user_atomic+0x156/0x220
[Fri Dec 18 01:14:40 2015]  [<ffffffff8117cb95>]
generic_perform_write+0x105/0x1a0
[Fri Dec 18 01:14:40 2015]  [<ffffffffc02cff9c>]
ceph_write_iter+0xf5c/0x1010 [ceph]
[Fri Dec 18 01:14:40 2015]  [<ffffffff817c8af6>] ? __schedule+0x386/0x9c0
[Fri Dec 18 01:14:40 2015]  [<ffffffff817c9165>] ? schedule+0x35/0x80
[Fri Dec 18 01:14:40 2015]  [<ffffffff813c0003>] ?
insn_get_immediate.part.8+0x293/0x300
[Fri Dec 18 01:14:40 2015]  [<ffffffff816bbeb2>] ?
skb_copy_datagram_iter+0x122/0x250
[Fri Dec 18 01:14:40 2015]  [<ffffffff811fbe23>] vfs_iter_write+0x63/0xa0
[Fri Dec 18 01:14:40 2015]  [<ffffffffc0252f29>]
fd_do_rw.isra.5+0xc9/0x1b0 [target_core_file]
[Fri Dec 18 01:14:40 2015]  [<ffffffffc02530d5>]
fd_execute_rw+0xc5/0x2a0 [target_core_file]
[Fri Dec 18 01:14:40 2015]  [<ffffffffc0352e72>]
sbc_execute_rw+0x22/0x30 [target_core_mod]
[Fri Dec 18 01:14:40 2015]  [<ffffffffc03519cf>]
__target_execute_cmd+0x1f/0x70 [target_core_mod]
[Fri Dec 18 01:14:40 2015]  [<ffffffffc0352525>]
target_execute_cmd+0x195/0x2a0 [target_core_mod]
[Fri Dec 18 01:14:40 2015]  [<ffffffffc05bf78a>]
iscsit_execute_cmd+0x20a/0x270 [iscsi_target_mod]
[Fri Dec 18 01:14:40 2015]  [<ffffffffc05c88da>]
iscsit_sequence_cmd+0xda/0x190 [iscsi_target_mod]
[Fri Dec 18 01:14:40 2015]  [<ffffffffc05cec4d>]
iscsi_target_rx_thread+0x51d/0xe30 [iscsi_target_mod]
[Fri Dec 18 01:14:40 2015]  [<ffffffff8101463d>] ? __switch_to+0x1cd/0x570
[Fri Dec 18 01:14:40 2015]  [<ffffffffc05ce730>] ?
iscsi_target_tx_thread+0x1c0/0x1c0 [iscsi_target_mod]
[Fri Dec 18 01:14:40 2015]  [<ffffffff81097859>] kthread+0xc9/0xe0
[Fri Dec 18 01:14:40 2015]  [<ffffffff81097790>] ?
kthread_create_on_node+0x180/0x180
[Fri Dec 18 01:14:40 2015]  [<ffffffff817cd0cf>] ret_from_fork+0x3f/0x70
[Fri Dec 18 01:14:40 2015]  [<ffffffff81097790>] ?
kthread_create_on_node+0x180/0x180
[Fri Dec 18 01:14:40 2015] Code: b8 00 00 00 48 8b 80 a8 00 00 00 48
d3 ea 48 8d 14 52 48 8d 3c d0 31 d2 e8 2d cb f3 ff 5d c3 48 c7 c6 a0
12 ad 81 e8 3f c5 02 00 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00
66 66 66 66 90 55
[Fri Dec 18 01:14:40 2015] RIP  [<ffffffff8117d041>] unlock_page+0x81/0x90
[Fri Dec 18 01:14:40 2015]  RSP <ffff880bfce5f9b8>
[Fri Dec 18 01:14:40 2015] ---[ end trace d2dd732cc24afbf8 ]---

Regards,
Eric Eastman
