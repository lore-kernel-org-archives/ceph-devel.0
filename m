From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: XFS kernel errors bringing up OSD
Date: Wed, 13 Sep 2017 08:54:05 +1000
Message-ID: <CAF-wwdHVfa_dbc4miUC10aPjZTsWtEwYSuhX4K9NjjcBpjEDcw@mail.gmail.com>
References: <CAGbviv+yD27MR9YvF2Wn9uNOMHbb=BMky1GyxyNQoMcpbAwbFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:37712 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdILWyH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Sep 2017 18:54:07 -0400
Received: by mail-it0-f51.google.com with SMTP id o200so2622907itg.0
        for <ceph-devel@vger.kernel.org>; Tue, 12 Sep 2017 15:54:06 -0700 (PDT)
In-Reply-To: <CAGbviv+yD27MR9YvF2Wn9uNOMHbb=BMky1GyxyNQoMcpbAwbFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Reading this thread is illuminating, but stops short of pointing to
the actual fix.

https://www.spinics.net/lists/linux-xfs/msg07597.html

Regardless, this seems to be an XFS problem and it is at least implied
a fix has been posted upstream.

I guess (it is just a guess) you could try an xfs_repair on the
filesystem to see if that helps or try a newer kernel if that's a
possibility.

To get a definitive answer about what the exact fix was you'd probably
need to post to the linux-xfs mailing list and ask them. If you do
please update this thread with the results so others may benefit.


On Tue, Sep 12, 2017 at 11:25 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> Ceph 10.2.7
> Kernel 4.12.10
>
> We are seeing frequent kernel errors that cause the XFS based OSD
> processes to crash and restart.  Has anyone seen or reported something
> like this before?  Maybe due to bad or failing disks, but its hard to
> tell.
>
>
>
> [Tue Sep 12 09:18:32 2017] BUG: unable to handle kernel NULL pointer
> dereference at 0000000000000090
> [Tue Sep 12 09:18:32 2017] IP: xfs_da3_node_read+0x2e/0xb0 [xfs]
> [Tue Sep 12 09:18:32 2017] PGD 0
> [Tue Sep 12 09:18:32 2017] P4D 0
>
> [Tue Sep 12 09:18:32 2017] Oops: 0000 [#23] SMP
> [Tue Sep 12 09:18:32 2017] Modules linked in: binfmt_misc xfs
> libcrc32c dm_crypt intel_rapl x86_pkg_temp_thermal ipmi_ssif
> intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul
> crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64
> input_leds crypto_simd glue_helper cryptd shpchp intel_cstate
> intel_rapl_perf lpc_ich mei_me mei mac_hid ipmi_si ipmi_devintf
> ipmi_msghandler acpi_power_meter acpi_pad 8021q garp mrp stp llc
> bonding autofs4 btrfs xor raid6_pq ses enclosure mlx4_en hid_generic
> ttm usbhid hid drm_kms_helper syscopyarea igb sysfillrect e1000e dca
> sysimgblt fb_sys_fops mlx4_core mpt3sas ptp ahci devlink drm
> raid_class pps_core libahci scsi_transport_sas i2c_algo_bit
> [Tue Sep 12 09:18:32 2017] CPU: 8 PID: 40382 Comm: tp_fstore_op
> Tainted: G      D         4.12.10-041210-generic #201708300614
> [Tue Sep 12 09:18:32 2017] Hardware name: AIC SB303-LB/LIBRA, BIOS
> LIBKV070 08/03/2016
> [Tue Sep 12 09:18:32 2017] task: ffff8f03b4220000 task.stack: ffff9a6a75ff0000
> [Tue Sep 12 09:18:32 2017] RIP: 0010:xfs_da3_node_read+0x2e/0xb0 [xfs]
> [Tue Sep 12 09:18:32 2017] RSP: 0018:ffff9a6a75ff3d30 EFLAGS: 00010282
> [Tue Sep 12 09:18:32 2017] RAX: 0000000000000000 RBX: ffff8f08b8ce9d98
> RCX: 0000000000000001
> [Tue Sep 12 09:18:32 2017] RDX: ffffffffc0a37700 RSI: 0000000000000000
> RDI: ffff9a6a75ff3cd8
> [Tue Sep 12 09:18:32 2017] RBP: ffff9a6a75ff3d48 R08: 00000000ffffffff
> R09: 0000000000000001
> [Tue Sep 12 09:18:32 2017] R10: 0000000000000001 R11: 0000000000000001
> R12: ffff9a6a75ff3d78
> [Tue Sep 12 09:18:32 2017] R13: 0000000000000005 R14: 00000000894e93b5
> R15: ffff8f1536502010
> [Tue Sep 12 09:18:32 2017] FS:  00007f82c9b70700(0000)
> GS:ffff8f26ffc00000(0000) knlGS:0000000000000000
> [Tue Sep 12 09:18:32 2017] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Tue Sep 12 09:18:32 2017] CR2: 0000000000000090 CR3: 00000017cf710000
> CR4: 00000000001406e0
> [Tue Sep 12 09:18:32 2017] Call Trace:
> [Tue Sep 12 09:18:32 2017]  xfs_attr3_node_inactive+0xd0/0x230 [xfs]
> [Tue Sep 12 09:18:32 2017]  xfs_attr_inactive+0x267/0x280 [xfs]
> [Tue Sep 12 09:18:32 2017]  xfs_inactive+0xe2/0x110 [xfs]
> [Tue Sep 12 09:18:32 2017]  xfs_fs_destroy_inode+0x9f/0x200 [xfs]
> [Tue Sep 12 09:18:32 2017]  destroy_inode+0x3b/0x60
> [Tue Sep 12 09:18:32 2017]  evict+0x136/0x1a0
> [Tue Sep 12 09:18:32 2017]  iput+0x14c/0x220
> [Tue Sep 12 09:18:32 2017]  do_unlinkat+0x1a7/0x310
> [Tue Sep 12 09:18:32 2017]  SyS_unlink+0x16/0x20
> [Tue Sep 12 09:18:32 2017]  entry_SYSCALL_64_fastpath+0x1e/0xa9
> [Tue Sep 12 09:18:32 2017] RIP: 0033:0x7f82d7753ea7
> [Tue Sep 12 09:18:32 2017] RSP: 002b:00007f82c9b6d2e8 EFLAGS: 00000246
> ORIG_RAX: 0000000000000057
> [Tue Sep 12 09:18:32 2017] RAX: ffffffffffffffda RBX: 00005606b600e000
> RCX: 00007f82d7753ea7
> [Tue Sep 12 09:18:32 2017] RDX: 00007f82c9b6d2a0 RSI: 0000000000000000
> RDI: 00005606bfd32a80
> [Tue Sep 12 09:18:32 2017] RBP: 000056033335ab20 R08: 0000000000450000
> R09: 0000000000000001
> [Tue Sep 12 09:18:32 2017] R10: 0000000000000000 R11: 0000000000000246
> R12: 00007f82da606c60
> [Tue Sep 12 09:18:32 2017] R13: 00005606812ebd60 R14: 00000000040ffda5
> R15: 00005606dfb64a60
> [Tue Sep 12 09:18:32 2017] Code: 00 00 55 48 89 e5 41 54 53 4d 89 c4
> 48 89 fb 48 83 ec 08 68 00 77 a3 c0 e8 e0 fe ff ff 85 c0 5a 75 46 48
> 85 db 74 41 49 8b 34 24 <48> 8b 96 90 00 00 00 0f b7 52 08 66 c1 c2 08
> 66 81 fa be 3e 74
> [Tue Sep 12 09:18:32 2017] RIP: xfs_da3_node_read+0x2e/0xb0 [xfs] RSP:
> ffff9a6a75ff3d30
> [Tue Sep 12 09:18:32 2017] CR2: 0000000000000090
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
