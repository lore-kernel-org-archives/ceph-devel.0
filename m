From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: ceph-disk triggers XFS kernel bug?
Date: Fri, 1 Sep 2017 11:02:56 -0400
Message-ID: <CAGbviv+P9573YaCKhULn3bE-Txz7-wDHoTuvft2vEZGn1xyQ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34083 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdIAPC5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Sep 2017 11:02:57 -0400
Received: by mail-io0-f177.google.com with SMTP id i200so3043572ioa.1
        for <ceph-devel@vger.kernel.org>; Fri, 01 Sep 2017 08:02:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Ceph 10.2.7
Ubuntu 16.04.2
Kernel 4.4.031

ceph-disk activate is failing to activate our OSDs on a server with 16
disks. Journals and Data are colocated on same disks.  The kernel log
is showing the following errors, does this look like a known bug?
Would a newer kernel possibly help?

[Fri Sep  1 06:02:17 2017] BUG: unable to handle kernel NULL pointer
dereference at 00000000000000a0
[Fri Sep  1 06:02:17 2017] IP: [<ffffffffc061a5a0>]
xfs_da3_node_read+0x30/0xb0 [xfs]
[Fri Sep  1 06:02:17 2017] PGD 0
[Fri Sep  1 06:02:17 2017] Oops: 0000 [#3] SMP
[Fri Sep  1 06:02:17 2017] Modules linked in: xfs libcrc32c drbg
ansi_cprng dm_crypt binfmt_misc ipmi_devintf intel_rapl
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
crct10dif_pclmul crc32_pclmul aesni_intel aes_x86_64 lrw ipmi_ssif
sb_edac gf128mul edac_core glue_helper ablk_helper mei_me lpc_ich
input_leds cryptd mei shpchp 8250_fintek ipmi_si ipmi_msghandler
acpi_power_meter acpi_pad mac_hid 8021q garp mrp stp llc bonding
autofs4 btrfs xor raid6_pq ses enclosure mlx4_en vxlan ip6_udp_tunnel
udp_tunnel ttm drm_kms_helper syscopyarea igb sysfillrect sysimgblt
hid_generic e1000e fb_sys_fops dca usbhid mpt3sas ahci ptp mlx4_core
drm hid raid_class libahci pps_core scsi_transport_sas i2c_algo_bit
fjes
[Fri Sep  1 06:02:17 2017] CPU: 1 PID: 13217 Comm: tp_fstore_op
Tainted: G      D         4.4.0-31-generic #50-Ubuntu
[Fri Sep  1 06:02:17 2017] Hardware name: AIC SB303-LB/LIBRA, BIOS
LIBKV070 08/03/2016
[Fri Sep  1 06:02:17 2017] task: ffff882f57940dc0 ti: ffff882ee9af0000
task.ti: ffff882ee9af0000
[Fri Sep  1 06:02:17 2017] RIP: 0010:[<ffffffffc061a5a0>]
[<ffffffffc061a5a0>] xfs_da3_node_read+0x30/0xb0 [xfs]
[Fri Sep  1 06:02:17 2017] RSP: 0018:ffff882ee9af3d00  EFLAGS: 00010282
[Fri Sep  1 06:02:17 2017] RAX: 0000000000000000 RBX: ffff880860d62740
RCX: 0000000000000001
[Fri Sep  1 06:02:17 2017] RDX: 0000000000000000 RSI: 0000000000000000
RDI: ffff882ee9af3cb0
[Fri Sep  1 06:02:17 2017] RBP: ffff882ee9af3d20 R08: 0000000000000001
R09: fffffffffffffffe
[Fri Sep  1 06:02:17 2017] R10: ffff8807c374e1d0 R11: 0000000000000001
R12: ffff882ee9af3d50
[Fri Sep  1 06:02:17 2017] R13: ffff881ad14d9dc0 R14: 0000000000000009
R15: 000000003bb6d4fa
[Fri Sep  1 06:02:17 2017] FS:  00007f178d54b700(0000)
GS:ffff881820040000(0000) knlGS:0000000000000000
[Fri Sep  1 06:02:17 2017] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Fri Sep  1 06:02:17 2017] CR2: 00000000000000a0 CR3: 0000002f54061000
CR4: 00000000001406e0
[Fri Sep  1 06:02:17 2017] Stack:
[Fri Sep  1 06:02:17 2017]  ffffffffc0679b50 ffffffffc065aebc
ffff882ee9af3de0 0000000000000009
[Fri Sep  1 06:02:17 2017]  ffff882ee9af3d98 ffffffffc0636893
0000000200000008 ffff880eef834010
[Fri Sep  1 06:02:17 2017]  00000001660a7d00 ffff8824d80fbd80
0000000000000000 0000000000000000
[Fri Sep  1 06:02:17 2017] Call Trace:
[Fri Sep  1 06:02:17 2017]  [<ffffffffc065aebc>] ?
xfs_trans_roll+0x2c/0x50 [xfs]
[Fri Sep  1 06:02:17 2017]  [<ffffffffc0636893>]
xfs_attr3_node_inactive+0x183/0x220 [xfs]
[Fri Sep  1 06:02:17 2017]  [<ffffffffc06369dc>]
xfs_attr3_root_inactive+0xac/0x100 [xfs]
[Fri Sep  1 06:02:17 2017]  [<ffffffffc0636b7c>]
xfs_attr_inactive+0x14c/0x1a0 [xfs]
[Fri Sep  1 06:02:17 2017]  [<ffffffffc0650d95>] xfs_inactive+0x85/0x120 [xfs]
[Fri Sep  1 06:02:17 2017]  [<ffffffffc06562e5>]
xfs_fs_evict_inode+0xa5/0x100 [xfs]
[Fri Sep  1 06:02:17 2017]  [<ffffffff8122887e>] evict+0xbe/0x190
[Fri Sep  1 06:02:17 2017]  [<ffffffff81228b61>] iput+0x1c1/0x240
[Fri Sep  1 06:02:17 2017]  [<ffffffff8121d659>] do_unlinkat+0x199/0x2d0
[Fri Sep  1 06:02:17 2017]  [<ffffffff8121e1f6>] SyS_unlink+0x16/0x20
[Fri Sep  1 06:02:17 2017]  [<ffffffff8182db32>]
entry_SYSCALL_64_fastpath+0x16/0x71
[Fri Sep  1 06:02:17 2017] Code: 55 48 89 e5 41 54 53 4d 89 c4 48 89
fb 48 83 ec 10 48 c7 04 24 50 9b 67 c0 e8 dd fe ff ff 85 c0 75 46 48
85 db 74 41 49 8b 34 24 <48> 8b 96 a0 00 00 00 0f b7 52 08 66 c1 c2 08
66 81 fa be 3e 74
[Fri Sep  1 06:02:17 2017] RIP  [<ffffffffc061a5a0>]
xfs_da3_node_read+0x30/0xb0 [xfs]
[Fri Sep  1 06:02:17 2017]  RSP <ffff882ee9af3d00>
[Fri Sep  1 06:02:17 2017] CR2: 00000000000000a0
[Fri Sep  1 06:02:17 2017] ---[ end trace d41664a5b9f3d7d2 ]---
