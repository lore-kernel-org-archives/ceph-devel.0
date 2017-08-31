From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: cephfs kernel bug (4.9.44)?
Date: Thu, 31 Aug 2017 15:59:56 +0200
Message-ID: <CAOi1vP_SX9MfkxnH3hcS3C2niA-gUnz5mjrkJcanjeO1bwSsqA@mail.gmail.com>
References: <CAGbvivJVFCGXLC_VroD6JVYjXk7sOV4e6-go1nx4nRg5JtXi7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:37913 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdHaN76 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Aug 2017 09:59:58 -0400
Received: by mail-io0-f170.google.com with SMTP id 81so23238259ioj.5
        for <ceph-devel@vger.kernel.org>; Thu, 31 Aug 2017 06:59:58 -0700 (PDT)
In-Reply-To: <CAGbvivJVFCGXLC_VroD6JVYjXk7sOV4e6-go1nx4nRg5JtXi7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Aug 31, 2017 at 3:09 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> Discovered this message in my kernel logs today, running 4.9.44 kernel
> with a kernel cephfs mount:
>
>
> [Wed Aug 30 14:17:04 2017] kernel BUG at
> /home/kernel/COD/linux/net/ceph/osd_client.c:1554!
> [Wed Aug 30 14:17:04 2017] invalid opcode: 0000 [#1] SMP
> [Wed Aug 30 14:17:04 2017] Modules linked in: binfmt_misc ipmi_devintf
> ceph libceph libcrc32c fscache ipmi_ssif intel_powerclamp coretemp
> kvm_intel kvm gpio_ich input_leds ipmi_si serio_raw irqbypass
> intel_cstate shpchp i7core_edac hpilo lpc_ich edac_core
> acpi_power_meter ipmi_msghandler mac_hid 8021q garp mrp stp llc
> bonding nfsd auth_rpcgss nfs_acl lp lockd grace parport sunrpc autofs4
> btrfs xor raid6_pq mlx4_en ptp pps_core hid_generic i2c_algo_bit ttm
> drm_kms_helper usbhid syscopyarea sysfillrect sysimgblt fb_sys_fops
> hid mlx4_core hpsa psmouse drm pata_acpi bnx2 devlink
> scsi_transport_sas fjes
> [Wed Aug 30 14:17:04 2017] CPU: 18 PID: 471071 Comm: vsftpd Tainted: G
>          I     4.9.44-040944-generic #201708161731
> [Wed Aug 30 14:17:04 2017] Hardware name: HP ProLiant DL360 G6, BIOS
> P64 08/16/2015
> [Wed Aug 30 14:17:04 2017] task: ffff9268331bc080 task.stack: ffffab4a96988000
> [Wed Aug 30 14:17:04 2017] RIP: 0010:[<ffffffffc09c44f7>]
> [<ffffffffc09c44f7>] send_request+0xa27/0xab0 [libceph]
> [Wed Aug 30 14:17:04 2017] RSP: 0018:ffffab4a9698b8e8  EFLAGS: 00010293
> [Wed Aug 30 14:17:04 2017] RAX: 0000000000000000 RBX: 0000000000002201
> RCX: ffff925e48490000
> [Wed Aug 30 14:17:04 2017] RDX: ffff926242fcf553 RSI: 0000000000001295
> RDI: 0000000000002201
> [Wed Aug 30 14:17:04 2017] RBP: ffffab4a9698b958 R08: ffff92685f95c9e0
> R09: 0000000000000000
> [Wed Aug 30 14:17:04 2017] R10: 0000000000000000 R11: ffff926842265680
> R12: ffff92684078c610
> [Wed Aug 30 14:17:04 2017] R13: 0000000000000001 R14: ffff926242fc608b
> R15: ffff92684078c610
> [Wed Aug 30 14:17:04 2017] FS:  00007f5b59fd5700(0000)
> GS:ffff92685f940000(0000) knlGS:0000000000000000
> [Wed Aug 30 14:17:04 2017] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Wed Aug 30 14:17:04 2017] CR2: 00007fec2bb2f003 CR3: 000000068ef59000
> CR4: 00000000000006e0
> [Wed Aug 30 14:17:04 2017] Stack:
> [Wed Aug 30 14:17:04 2017]  01ffffffc09b9cd7 ffff92685f959300
> 0000000000000067 ffff9268331bc080
> [Wed Aug 30 14:17:04 2017]  ffff926242fc7000 ffff926241a3e000
> ffff926840215200 00000e8100002201
> [Wed Aug 30 14:17:04 2017]  0000000000000000 ffff92684078c610
> ffff926841ddf7c0 0000000000000000
> [Wed Aug 30 14:17:04 2017] Call Trace:
> [Wed Aug 30 14:17:04 2017]  [<ffffffffc09c815a>]
> __submit_request+0x20a/0x2f0 [libceph]
> [Wed Aug 30 14:17:04 2017]  [<ffffffffc09c826b>]
> submit_request+0x2b/0x30 [libceph]
> [Wed Aug 30 14:17:05 2017]  [<ffffffffc09c8c14>]
> ceph_osdc_writepages+0x104/0x1a0 [libceph]
> [Wed Aug 30 14:17:05 2017]  [<ffffffffc0a0f4b1>]
> writepage_nounlock+0x2c1/0x470 [ceph]
> [Wed Aug 30 14:17:05 2017]  [<ffffffffa65f120a>] ? page_mkclean+0x6a/0xb0
> [Wed Aug 30 14:17:05 2017]  [<ffffffffa65ef3b0>] ?
> __page_check_address+0x1c0/0x1c0
> [Wed Aug 30 14:17:05 2017]  [<ffffffffc0a11f9c>]
> ceph_update_writeable_page+0xdc/0x4a0 [ceph]
> [Wed Aug 30 14:17:05 2017]  [<ffffffffa65a974d>] ?
> pagecache_get_page+0x17d/0x2a0
> [Wed Aug 30 14:17:05 2017]  [<ffffffffc0a123ca>]
> ceph_write_begin+0x6a/0x120 [ceph]
> [Wed Aug 30 14:17:05 2017]  [<ffffffffa65a89b8>]
> generic_perform_write+0xc8/0x1c0
> [Wed Aug 30 14:17:05 2017]  [<ffffffffa66592ee>] ? file_update_time+0x5e/0x110
> [Wed Aug 30 14:17:05 2017]  [<ffffffffc0a0c402>]
> ceph_write_iter+0xba2/0xbe0 [ceph]
> [Wed Aug 30 14:17:05 2017]  [<ffffffffa6b6238c>] ? release_sock+0x8c/0xa0
> [Wed Aug 30 14:17:05 2017]  [<ffffffffa6bce0b9>] ? tcp_recvmsg+0x4c9/0xb50
> [Wed Aug 30 14:17:05 2017]  [<ffffffffa6b5d65d>] ? sock_recvmsg+0x3d/0x50
> [Wed Aug 30 14:17:05 2017]  [<ffffffffa663ad45>] __vfs_write+0xe5/0x160
> [Wed Aug 30 14:17:05 2017]  [<ffffffffa663bfe5>] vfs_write+0xb5/0x1a0
> [Wed Aug 30 14:17:05 2017]  [<ffffffffa663d465>] SyS_write+0x55/0xc0
> [Wed Aug 30 14:17:05 2017]  [<ffffffffa6c9b9bb>]
> entry_SYSCALL_64_fastpath+0x1e/0xad
> [Wed Aug 30 14:17:05 2017] Code: fb ab e5 e9 de f6 ff ff ba 14 00 00
> 00 e9 42 f7 ff ff 49 c7 46 08 00 00 00 00 41 c7 46 10 00 00 00 00 49
> 8d 56 14 e9 6d fb ff ff <0f> 0b 0f 0b be 8f 05 00 00 48 c7 c7 d8 0c 9e
> c0 e8 b4 fb ab e5
> [Wed Aug 30 14:17:05 2017] RIP  [<ffffffffc09c44f7>]
> send_request+0xa27/0xab0 [libceph]
> [Wed Aug 30 14:17:05 2017]  RSP <ffffab4a9698b8e8>
> [Wed Aug 30 14:17:05 2017] ---[ end trace 5c55854998e663dc ]---

Hi Wyllys,

Yes, looks like MOSDOp size was miscalculated.

Could you give some context?  Anything before this splat in the kernel
log, ceph version, cephfs configuration -- pools, namespaces, snapshots,
fscache, etc.

Thanks,

                Ilya
