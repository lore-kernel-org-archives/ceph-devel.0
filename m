From: Hannes Landeholm <hannes@jumpstarter.io>
Subject: crash report: paging request errors in various krbd contexts
Date: Fri, 16 May 2014 08:00:42 +0200
Message-ID: <CABt9es_p40V7zcaqNLBstrY4g=8iMsUVtAoEdDGxXTsW9NKGdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:64375 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbaEPGAn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 May 2014 02:00:43 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy5so2455834obc.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 May 2014 23:00:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Alex Elder <elder@ieee.org>

A production server just locked up and had to be hard rebooted. It had
these various rbd related crash signatures in it's system log within
the same 10 second interval:

kernel: BUG: unable to handle kernel paging request at ffffffffffffffff
kernel: IP: [<ffffffff812832dd>] strnlen+0xd/0x40
kernel: PGD 180f067 PUD 1811067 PMD 0
kernel: Oops: 0000 [#1] PREEMPT SMP
kernel: Modules linked in: xt_recent xt_limit veth ipt_MASQUERADE cbc
ipt_REJECT xt_conntrack iptable_filter iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack xt_tcpudp
iptable_mangle ip_tables x_tables coretemp hwmon x86_pkg_temp_thermal
crct10dif_pclmul crct10di
f_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel
aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd microcode evdev
pcspkr xen_netback xen_blkback xen_gntalloc xenfs xen_gntdev
xen_evtchn rbd libceph crc32c libcrc32c ext4 crc16 mbcache jbd2
ixgbevf xen_privcmd xen_pcifront xen_netfront xen_kbdfro
nt xen_fbfront syscopyarea sysfillrect sysimgblt fb_sys_fops
xen_blkfront virtio_pci virtio_net virtio_blk virtio_ring virtio
ipmi_poweroff ipmi_msghandler
kernel: CPU: 3 PID: 2887 Comm: mysqld Not tainted 3.14.1-1-js #1
kernel: task: ffff880342ce1d70 ti: ffff88033e17e000 task.ti: ffff88033e17e000
kernel: RIP: e030:[<ffffffff812832dd>]  [<ffffffff812832dd>] strnlen+0xd/0x40
kernel: RSP: e02b:ffff88033e17fa78  EFLAGS: 00010286
kernel: RAX: ffffffff816feed6 RBX: ffff8800ffb60068 RCX: fffffffffffffffe
kernel: RDX: ffffffffffffffff RSI: ffffffffffffffff RDI: ffffffffffffffff
kernel: RBP: ffff88033e17fa78 R08: 000000000000ffff R09: 000000000000ffff
kernel: R10: 756d696e612d736a R11: 2f30622d637a762f R12: ffffffffffffffff
kernel: R13: ffff8800ffb600cd R14: 00000000ffffffff R15: 0000000000000000
kernel: FS:  00007f98dec7f700(0000) GS:ffff8803b5d80000(0000)
knlGS:0000000000000000
kernel: CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
kernel: CR2: ffffffffffffffff CR3: 0000000335dcc000 CR4: 0000000000002660
kernel: Stack:
kernel:  ffff88033e17fab0 ffffffff8128562b ffff8800ffb60068 ffff8800ffb600cd
kernel:  ffff88033e17fb28 ffffffffa0196869 ffffffffa0196869 ffff88033e17fb18
kernel:  ffffffff81286ac1 ffff880389525960 ffffffff814de243 0000000000000000
kernel: Call Trace:
kernel:  [<ffffffff8128562b>] string.isra.6+0x3b/0xf0
kernel:  [<ffffffff81286ac1>] vsnprintf+0x1c1/0x610
kernel:  [<ffffffff814de243>] ? _raw_spin_unlock_irq+0x13/0x30
kernel:  [<ffffffff81286fd9>] snprintf+0x39/0x40
kernel:  [<ffffffffa01911e0>] ? rbd_img_request_fill+0x100/0x6d0 [rbd]
kernel:  [<ffffffffa019122a>] rbd_img_request_fill+0x14a/0x6d0 [rbd]
kernel:  [<ffffffffa018f4d5>] ? rbd_img_request_create+0x155/0x220 [rbd]
kernel:  [<ffffffff8125cab9>] ? blk_add_timer+0x19/0x20
kernel:  [<ffffffffa0194a1d>] rbd_request_fn+0x1ed/0x330 [rbd]
kernel:  [<ffffffff81252f13>] __blk_run_queue+0x33/0x40
kernel:  [<ffffffff8125411e>] queue_unplugged+0x2e/0xd0
kernel:  [<ffffffff81256cf0>] blk_flush_plug_list+0x1f0/0x230
kernel:  [<ffffffff812570a4>] blk_finish_plug+0x14/0x40
kernel:  [<ffffffffa00b9d6e>] ext4_writepages+0x48e/0xd50 [ext4]
kernel:  [<ffffffff81136aae>] ? generic_file_aio_write+0x5e/0xe0
kernel:  [<ffffffff811417ae>] do_writepages+0x1e/0x40
kernel:  [<ffffffff811363d9>] __filemap_fdatawrite_range+0x59/0x60
kernel:  [<ffffffff811364da>] filemap_write_and_wait_range+0x2a/0x70
kernel:  [<ffffffffa00b149a>] ext4_sync_file+0xba/0x360 [ext4]
kernel:  [<ffffffff811d50ce>] do_fsync+0x4e/0x80
kernel:  [<ffffffff811d5373>] SyS_fdatasync+0x13/0x20
kernel:  [<ffffffff814e66e9>] system_call_fastpath+0x16/0x1b
kernel: Code: c0 01 80 38 00 75 f7 48 29 f8 5d c3 31 c0 5d c3 66 66 66
66 66 2e 0f 1f 84 00 00 00 00 00 55 48 85 f6 48 8d 4e ff 48 89 e5 74
2a <80> 3f 00 74 25 48 89 f8 31 d2 eb 10 0f 1f 80 00 00 00 00 48 83
kernel: RIP  [<ffffffff812832dd>] strnlen+0xd/0x40
kernel:  RSP <ffff88033e17fa78>
kernel: CR2: ffffffffffffffff
kernel: ---[ end trace 83a2fd2a9969b20d ]---

kernel: BUG: unable to handle kernel paging request at 000000000000177b
kernel: IP: [<ffffffff814dd33c>] down_read+0xc/0x20
kernel: PGD 39c86b067 PUD 39c86a067 PMD 0
kernel: Oops: 0002 [#2] PREEMPT SMP
kernel: Modules linked in: xt_recent xt_limit veth ipt_MASQUERADE cbc
ipt_REJECT xt_conntrack iptable_filter iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack xt_tcpudp
iptable_mangle ip_tables x_tables coretemp hwmon x86_pkg_temp_thermal
crct10dif_pclmul crct10di
f_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel
aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd microcode evdev
pcspkr xen_netback xen_blkback xen_gntalloc xenfs xen_gntdev
xen_evtchn rbd libceph crc32c libcrc32c ext4 crc16 mbcache jbd2
ixgbevf xen_privcmd xen_pcifront xen_netfront xen_kbdfro
nt xen_fbfront syscopyarea sysfillrect sysimgblt fb_sys_fops
xen_blkfront virtio_pci virtio_net virtio_blk virtio_ring virtio
ipmi_poweroff ipmi_msghandler
kernel: CPU: 3 PID: 16277 Comm: jbd2/rbd115-8 Tainted: G      D
3.14.1-1-js #1
kernel: task: ffff8800e6f13110 ti: ffff8800f9d52000 task.ti: ffff8800f9d52000
kernel: RIP: e030:[<ffffffff814dd33c>]  [<ffffffff814dd33c>] down_read+0xc/0x20
kernel: RSP: e02b:ffff8800f9d53a40  EFLAGS: 00010246
kernel: RAX: 000000000000177b RBX: 000000000000176b RCX: 00000000000000ad
kernel: RDX: 0000000000000000 RSI: ffff88033c169680 RDI: 000000000000177b
kernel: RBP: ffff8800f9d53a40 R08: 0000000000017730 R09: ffff8803763c01e0
kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000177b
kernel: R13: 00000000000017c3 R14: ffff88033c169680 R15: 0000000000000000
kernel: FS:  00007f3612ef0700(0000) GS:ffff8803b5d80000(0000)
knlGS:0000000000000000
kernel: CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
kernel: CR2: 000000000000177b CR3: 000000039c86d000 CR4: 0000000000002660
kernel: Stack:
kernel:  ffff8800f9d53a78 ffffffffa015d22b 000000000000176b ffff8802a4364370
kernel:  ffff8803836e7f48 ffff88032fbe8c00 0000000000000000 ffff8800f9d53a98
kernel:  ffffffffa018fa9a ffff8802a43642c0 ffff8802a4364370 ffff8800f9d53ad8
kernel: Call Trace:
kernel:  [<ffffffffa015d22b>] ceph_osdc_start_request+0x2b/0x70 [libceph]
kernel:  [<ffffffffa018fa9a>] rbd_obj_request_submit+0x2a/0x60 [rbd]
kernel:  [<ffffffffa0193fca>] rbd_img_obj_request_submit+0x15a/0x450 [rbd]
kernel:  [<ffffffffa0194314>] rbd_img_request_submit+0x54/0x90 [rbd]
kernel:  [<ffffffffa0194ab9>] rbd_request_fn+0x289/0x330 [rbd]
kernel:  [<ffffffff81252f13>] __blk_run_queue+0x33/0x40
kernel:  [<ffffffff81256fc3>] blk_queue_bio+0x293/0x360
kernel:  [<ffffffff81254fa0>] generic_make_request+0xc0/0x110
kernel:  [<ffffffff81255068>] submit_bio+0x78/0x160
kernel:  [<ffffffff811dc496>] ? bio_alloc_bioset+0x1a6/0x2b0
kernel:  [<ffffffffa008efe8>] ? jbd2_journal_bmap+0x28/0xa0 [jbd2]
kernel:  [<ffffffff811d8b0b>] _submit_bh+0x13b/0x220
kernel:  [<ffffffff811d8c00>] submit_bh+0x10/0x20
kernel:  [<ffffffffa00862e3>]
journal_submit_commit_record.isra.10+0x173/0x1c0 [jbd2]
kernel:  [<ffffffffa00877de>]
jbd2_journal_commit_transaction+0x14ae/0x1c30 [jbd2]
kernel:  [<ffffffff814de15a>] ? _raw_spin_lock_irqsave+0x1a/0x50
kernel:  [<ffffffffa008d53e>] kjournald2+0xbe/0x240 [jbd2]
kernel:  [<ffffffff810aa930>] ? __wake_up_sync+0x20/0x20
kernel:  [<ffffffffa008d480>] ? commit_timeout+0x10/0x10 [jbd2]
kernel:  [<ffffffff81087762>] kthread+0xd2/0xf0
kernel:  [<ffffffff81087690>] ? kthread_create_on_node+0x180/0x180
kernel:  [<ffffffff814e663c>] ret_from_fork+0x7c/0xb0
kernel:  [<ffffffff81087690>] ? kthread_create_on_node+0x180/0x180
kernel: Code: b8 00 02 20 00 00 00 ad de c6 47 18 01 48 89 47 08 48 8b
7f 10 e8 b5 b0 bb ff 5d c3 0f 1f 00 0f 1f 44 00 00 55 48 89 f8 48 89
e5 <f0> 48 ff 00 79 05 e8 59 bc da ff 5d c3 0f 1f 80 00 00 00 00 0f
kernel: RIP  [<ffffffff814dd33c>] down_read+0xc/0x20
kernel:  RSP <ffff8800f9d53a40>
kernel: CR2: 000000000000177b
kernel: ---[ end trace 83a2fd2a9969b20e ]---

kernel: BUG: unable to handle kernel paging request at 0000008900000073
kernel: IP: [<ffffffff811897f5>] kmem_cache_alloc+0x75/0x210
kernel: PGD 0
kernel: Oops: 0000 [#3] PREEMPT SMP
kernel: Modules linked in: xt_recent xt_limit veth ipt_MASQUERADE cbc
ipt_REJECT xt_conntrack iptable_filter iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack xt_tcpudp
iptable_mangle ip_tables x_tables coretemp hwmon x86_pkg_temp_thermal
crct10dif_pclmul crct10di
f_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel
aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd microcode evdev
pcspkr xen_netback xen_blkback xen_gntalloc xenfs xen_gntdev
xen_evtchn rbd libceph crc32c libcrc32c ext4 crc16 mbcache jbd2
ixgbevf xen_privcmd xen_pcifront xen_netfront xen_kbdfro
nt xen_fbfront syscopyarea sysfillrect sysimgblt fb_sys_fops
xen_blkfront virtio_pci virtio_net virtio_blk virtio_ring virtio
ipmi_poweroff ipmi_msghandler
kernel: CPU: 3 PID: 2727 Comm: jbd2/rbd46-8 Tainted: G      D
3.14.1-1-js #1
kernel: task: ffff8800b4839d70 ti: ffff88038e474000 task.ti: ffff88038e474000
kernel: RIP: e030:[<ffffffff811897f5>]  [<ffffffff811897f5>]
kmem_cache_alloc+0x75/0x210
kernel: RSP: e02b:ffff88038e475b30  EFLAGS: 00010286
kernel: RAX: 0000000000000000 RBX: ffff8803272367b0 RCX: 0000000019caf483
kernel: RDX: 0000000019caf403 RSI: ffff8803b5d978b0 RDI: ffff8803a441bb00
kernel: RBP: ffff88038e475b60 R08: 00000000000178b0 R09: ffffffffa018f3b3
kernel: R10: 0000000000000001 R11: ffff8802f2bcf008 R12: 0000008900000073
kernel: R13: 0000000000000020 R14: ffff8803a441bb00 R15: ffff8803a441bb00
kernel: FS:  00007fd1d5fff700(0000) GS:ffff8803b5d80000(0000)
knlGS:0000000000000000
kernel: CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
kernel: CR2: 0000008900000073 CR3: 000000031d236000 CR4: 0000000000002660
kernel: Stack:
kernel:  ffffffff8127a16c ffff8803272367b0 ffff88038e473000 000000010802b000
kernel:  000000000000d000 0000000000000001 ffff88038e475bb0 ffffffffa018f3b3
kernel:  ffff88038e475b80 ffffffff8125cab9 ffff88038e475b98 ffff8803272367b0
kernel: Call Trace:
kernel:  [<ffffffff8127a16c>] ? cfq_add_rq_rb+0x7c/0xa0
kernel:  [<ffffffffa018f3b3>] rbd_img_request_create+0x33/0x220 [rbd]
kernel:  [<ffffffff8125cab9>] ? blk_add_timer+0x19/0x20
kernel:  [<ffffffffa01949fa>] rbd_request_fn+0x1ca/0x330 [rbd]
kernel:  [<ffffffff81252f13>] __blk_run_queue+0x33/0x40
kernel:  [<ffffffff8125411e>] queue_unplugged+0x2e/0xd0
kernel:  [<ffffffff81256cf0>] blk_flush_plug_list+0x1f0/0x230
kernel:  [<ffffffff812570a4>] blk_finish_plug+0x14/0x40
kernel:  [<ffffffffa0087396>]
jbd2_journal_commit_transaction+0x1066/0x1c30 [jbd2]
kernel:  [<ffffffff814de15a>] ? _raw_spin_lock_irqsave+0x1a/0x50
kernel:  [<ffffffffa008d53e>] kjournald2+0xbe/0x240 [jbd2]
kernel:  [<ffffffff810aa930>] ? __wake_up_sync+0x20/0x20
kernel:  [<ffffffffa008d480>] ? commit_timeout+0x10/0x10 [jbd2]
kernel:  [<ffffffff81087762>] kthread+0xd2/0xf0
kernel:  [<ffffffff81087690>] ? kthread_create_on_node+0x180/0x180
kernel:  [<ffffffff814e663c>] ret_from_fork+0x7c/0xb0
kernel:  [<ffffffff81087690>] ? kthread_create_on_node+0x180/0x180
kernel: Code: ca 00 00 00 4c 8b 26 48 8b 46 10 4d 85 e4 0f 84 52 01 00
00 48 85 c0 0f 84 49 01 00 00 49 63 46 20 48 8d 8a 80 00 00 00 4d 8b
06 <49> 8b 1c 04 4c 89 e0 65 49 0f c7 08 0f 94 c0 84 c0 74 a0 49 63
kernel: RIP  [<ffffffff811897f5>] kmem_cache_alloc+0x75/0x210
kernel:  RSP <ffff88038e475b30>
kernel: CR2: 0000008900000073
kernel: ---[ end trace 83a2fd2a9969b20f ]---

kernel: BUG: unable to handle kernel paging request at 0000008900000073
kernel: IP: [<ffffffff811897f5>] kmem_cache_alloc+0x75/0x210
kernel: PGD 0
kernel: Oops: 0000 [#4] PREEMPT SMP
kernel: Modules linked in: xt_recent xt_limit veth ipt_MASQUERADE cbc
ipt_REJECT xt_conntrack iptable_filter iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack xt_tcpudp
iptable_mangle ip_tables x_tables coretemp hwmon x86_pkg_temp_thermal
crct10dif_pclmul crct10di
f_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel
aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd microcode evdev
pcspkr xen_netback xen_blkback xen_gntalloc xenfs xen_gntdev
xen_evtchn rbd libceph crc32c libcrc32c ext4 crc16 mbcache jbd2
ixgbevf xen_privcmd xen_pcifront xen_netfront xen_kbdfro
nt xen_fbfront syscopyarea sysfillrect sysimgblt fb_sys_fops
xen_blkfront virtio_pci virtio_net virtio_blk virtio_ring virtio
ipmi_poweroff ipmi_msghandler
kernel: CPU: 3 PID: 2729 Comm: jbd2/rbd47-8 Tainted: G      D
3.14.1-1-js #1
kernel: task: ffff8802e8250000 ti: ffff8802e817e000 task.ti: ffff8802e817e000
kernel: RIP: e030:[<ffffffff811897f5>]  [<ffffffff811897f5>]
kmem_cache_alloc+0x75/0x210
kernel: RSP: e02b:ffff8802e817fb30  EFLAGS: 00010286
kernel: RAX: 0000000000000000 RBX: ffff880327236f18 RCX: 0000000019caf483
kernel: RDX: 0000000019caf403 RSI: ffff8803b5d978b0 RDI: ffff8803a441bb00
kernel: RBP: ffff8802e817fb60 R08: 00000000000178b0 R09: ffffffffa018f3b3
kernel: R10: 0000000000000001 R11: ffff8802f2bcd008 R12: 0000008900000073
kernel: R13: 0000000000000020 R14: ffff8803a441bb00 R15: ffff8803a441bb00
kernel: FS:  00007f44e33fe700(0000) GS:ffff8803b5d80000(0000)
knlGS:0000000000000000
kernel: CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
kernel: CR2: 0000008900000073 CR3: 0000000389715000 CR4: 0000000000002660
kernel: Stack:
kernel:  ffffffff8127a16c ffff880327236f18 ffff8800f60f4800 000000010800a000
kernel:  0000000000002000 0000000000000001 ffff8802e817fbb0 ffffffffa018f3b3
kernel:  ffff8802e817fb80 ffffffff8125cab9 ffff8802e817fb98 ffff880327236f18
kernel: Call Trace:
kernel:  [<ffffffff8127a16c>] ? cfq_add_rq_rb+0x7c/0xa0
kernel:  [<ffffffffa018f3b3>] rbd_img_request_create+0x33/0x220 [rbd]
kernel:  [<ffffffff8125cab9>] ? blk_add_timer+0x19/0x20
kernel:  [<ffffffffa01949fa>] rbd_request_fn+0x1ca/0x330 [rbd]
kernel:  [<ffffffff81252f13>] __blk_run_queue+0x33/0x40
kernel:  [<ffffffff8125411e>] queue_unplugged+0x2e/0xd0
kernel:  [<ffffffff81256cf0>] blk_flush_plug_list+0x1f0/0x230
kernel:  [<ffffffff812570a4>] blk_finish_plug+0x14/0x40
kernel:  [<ffffffffa0087396>]
jbd2_journal_commit_transaction+0x1066/0x1c30 [jbd2]
kernel:  [<ffffffff814de15a>] ? _raw_spin_lock_irqsave+0x1a/0x50
kernel:  [<ffffffffa008d53e>] kjournald2+0xbe/0x240 [jbd2]
kernel:  [<ffffffff810aa930>] ? __wake_up_sync+0x20/0x20
kernel:  [<ffffffffa008d480>] ? commit_timeout+0x10/0x10 [jbd2]
kernel:  [<ffffffff81087762>] kthread+0xd2/0xf0
kernel:  [<ffffffff81087690>] ? kthread_create_on_node+0x180/0x180
kernel:  [<ffffffff814e663c>] ret_from_fork+0x7c/0xb0
kernel:  [<ffffffff81087690>] ? kthread_create_on_node+0x180/0x180
kernel: Code: ca 00 00 00 4c 8b 26 48 8b 46 10 4d 85 e4 0f 84 52 01 00
00 48 85 c0 0f 84 49 01 00 00 49 63 46 20 48 8d 8a 80 00 00 00 4d 8b
06 <49> 8b 1c 04 4c 89 e0 65 49 0f c7 08 0f 94 c0 84 c0 74 a0 49 63
kernel: RIP  [<ffffffff811897f5>] kmem_cache_alloc+0x75/0x210
kernel:  RSP <ffff8802e817fb30>
kernel: CR2: 0000008900000073
kernel: ---[ end trace 83a2fd2a9969b210 ]---

kernel: BUG: unable to handle kernel paging request at 000000000000477c
kernel: IP: [<ffffffff814dd33c>] down_read+0xc/0x20
kernel: PGD 359f6b067 PUD 2eef51067 PMD 0
kernel: Oops: 0002 [#5] PREEMPT SMP
kernel: Modules linked in: xt_recent xt_limit veth ipt_MASQUERADE cbc
ipt_REJECT xt_conntrack iptable_filter iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack xt_tcpudp
iptable_mangle ip_tables x_tables coretemp hwmon x86_pkg_temp_thermal
crct10dif_pclmul crct10di
f_common crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel
aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd microcode evdev
pcspkr xen_netback xen_blkback xen_gntalloc xenfs xen_gntdev
xen_evtchn rbd libceph crc32c libcrc32c ext4 crc16 mbcache jbd2
ixgbevf xen_privcmd xen_pcifront xen_netfront xen_kbdfro
nt xen_fbfront syscopyarea sysfillrect sysimgblt fb_sys_fops
xen_blkfront virtio_pci virtio_net virtio_blk virtio_ring virtio
ipmi_poweroff ipmi_msghandler
kernel: CPU: 1 PID: 2894 Comm: mysqld Tainted: G      D      3.14.1-1-js #1
kernel: task: ffff8802eef3a740 ti: ffff8802eec2a000 task.ti: ffff8802eec2a000
kernel: RIP: e030:[<ffffffff814dd33c>]  [<ffffffff814dd33c>] down_read+0xc/0x20
kernel: RSP: e02b:ffff8802eec2bb80  EFLAGS: 00010246
kernel: RAX: 000000000000477c RBX: 000000000000476c RCX: 00000000000000ad
kernel: RDX: 0000000000000000 RSI: ffff880396ee8000 RDI: 000000000000477c
kernel: RBP: ffff8802eec2bb80 R08: 0000000000017730 R09: ffff880383448f30
kernel: R10: 0000000000000000 R11: ffffffffffffffd0 R12: 000000000000477c
kernel: R13: 00000000000047c4 R14: ffff880396ee8000 R15: 0000000000000000
kernel: FS:  00007f98debed700(0000) GS:ffff8803b5c80000(0000)
knlGS:0000000000000000
kernel: CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
kernel: CR2: 000000000000477c CR3: 0000000335dcc000 CR4: 0000000000002660
kernel: Stack:
kernel:  ffff8802eec2bbb8 ffffffffa015d22b 000000000000476c ffff8802e8751630
kernel:  ffff8802f2950f88 ffff88032fbe8c00 0000000000000000 ffff8802eec2bbd8
kernel:  ffffffffa018fa9a ffff8802e8751580 ffff8802e8751630 ffff8802eec2bc18
kernel: Call Trace:
kernel:  [<ffffffffa015d22b>] ceph_osdc_start_request+0x2b/0x70 [libceph]
kernel:  [<ffffffffa018fa9a>] rbd_obj_request_submit+0x2a/0x60 [rbd]
kernel:  [<ffffffffa0193fca>] rbd_img_obj_request_submit+0x15a/0x450 [rbd]
kernel:  [<ffffffffa0194314>] rbd_img_request_submit+0x54/0x90 [rbd]
kernel:  [<ffffffffa0194ab9>] rbd_request_fn+0x289/0x330 [rbd]
kernel:  [<ffffffff81252f13>] __blk_run_queue+0x33/0x40
kernel:  [<ffffffff8125411e>] queue_unplugged+0x2e/0xd0
kernel:  [<ffffffff81256cf0>] blk_flush_plug_list+0x1f0/0x230
kernel:  [<ffffffff812570a4>] blk_finish_plug+0x14/0x40
kernel:  [<ffffffffa00b9d6e>] ext4_writepages+0x48e/0xd50 [ext4]
kernel:  [<ffffffff811417ae>] do_writepages+0x1e/0x40
kernel:  [<ffffffff811363d9>] __filemap_fdatawrite_range+0x59/0x60
kernel:  [<ffffffff811364da>] filemap_write_and_wait_range+0x2a/0x70
kernel:  [<ffffffffa00b149a>] ext4_sync_file+0xba/0x360 [ext4]
kernel:  [<ffffffff811d50ce>] do_fsync+0x4e/0x80
kernel:  [<ffffffff811d5373>] SyS_fdatasync+0x13/0x20
kernel:  [<ffffffff814e66e9>] system_call_fastpath+0x16/0x1b
kernel: Code: b8 00 02 20 00 00 00 ad de c6 47 18 01 48 89 47 08 48 8b
7f 10 e8 b5 b0 bb ff 5d c3 0f 1f 00 0f 1f 44 00 00 55 48 89 f8 48 89
e5 <f0> 48 ff 00 79 05 e8 59 bc da ff 5d c3 0f 1f 80 00 00 00 00 0f
kernel: RIP  [<ffffffff814dd33c>] down_read+0xc/0x20

The server is uses a "stock" Arch 3.14.1 kernel with no custom
patches. We are not using any exotic kernel features except rbd
(unless you count xen guess stuff) so rbd is primary suspect imo.

uname: Linux localhost 3.14.1-1-js #1 SMP PREEMPT Tue Apr 15 17:59:05
CEST 2014 x86_64 GNU/Linux

config: http://pastebin.com/Z0T6eKmy

Thank you for your time,
Hannes
