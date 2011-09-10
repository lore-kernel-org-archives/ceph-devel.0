From: Martin Mailand <martin@tuxadero.com>
Subject: ceph kernel bug
Date: Sat, 10 Sep 2011 23:12:20 +0200
Message-ID: <4E6BD2B4.7050709@tuxadero.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:36218 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934091Ab1IJVM0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Sep 2011 17:12:26 -0400
Received: from [192.168.1.106] (e178225239.adsl.alicedsl.de [85.178.225.239])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8ALCJcT026384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sat, 10 Sep 2011 23:12:24 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I hit the following Bug. My Setup is very simple I have two osd (osd1 
and osd2) and one monitor.
On the fourth machine I mount ceph via the rbd device and I use the rbd 
device for a qemu instance.
When I reboot one of the two osds I hit reproducible this bug.
On all machine I use the kernel version 3.1.0-rc5 and ceph version 
0.34-1natty from the newdream repro.

Regards,
  martin

[  105.746163] libceph: osd2 192.168.42.114:6800 socket closed
[  105.757635] libceph: osd2 192.168.42.114:6800 connection failed
[  106.040203] libceph: osd2 192.168.42.114:6800 connection failed
[  107.040231] libceph: osd2 192.168.42.114:6800 connection failed
[  109.040508] libceph: osd2 192.168.42.114:6800 connection failed
[  113.050453] libceph: osd2 192.168.42.114:6800 connection failed
[  121.060191] libceph: osd2 192.168.42.114:6800 connection failed
[  137.090484] libceph: osd2 192.168.42.114:6800 connection failed
[  198.237123] ------------[ cut here ]------------
[  198.246419] kernel BUG at net/ceph/messenger.c:2193!
[  198.246949] invalid opcode: 0000 [#1] SMP
[  198.246949] CPU 0
[  198.246949] Modules linked in: rbd libceph libcrc32c ip6table_filter 
ip6_tables iptable_filter ip_tables x_tables nv_tco bridge stp kvm_amd 
kvm radeon ttm psmouse drm_kms_helper drm i2c_algo_bit k10temp 
i2c_nforce2 shpchp amd64_edac_mod serio_raw edac_core edac_mce_amd lp 
parport ses enclosure aacraid forcedeth
[  198.246949]
[  198.246949] Pid: 10, comm: kworker/0:1 Not tainted 3.1.0-rc5-custom 
#1 Supermicro H8DM8-2/H8DM8-2
[  198.246949] RIP: 0010:[<ffffffffa02d83f1>]  [<ffffffffa02d83f1>] 
ceph_con_send+0x111/0x120 [libceph]
[  198.246949] RSP: 0018:ffff880405cd5bc0  EFLAGS: 00010202
[  198.246949] RAX: ffff880803fe7878 RBX: ffff880403fb8030 RCX: 
ffff880803fd1650
[  198.246949] RDX: ffff880405cd5fd8 RSI: ffff880803fe7800 RDI: 
ffff880403fb81a8
[  198.246949] RBP: ffff880405cd5be0 R08: ffff880405cd5b70 R09: 
0000000000000002
[  198.246949] R10: 0000000000000002 R11: 0000000000000072 R12: 
ffff880403fb81a8
[  198.246949] R13: ffff880803fe7800 R14: ffff880803fd1660 R15: 
ffff880803fd1650
[  198.246949] FS:  00007fea65610700(0000) GS:ffff88040fc00000(0000) 
knlGS:0000000000000000
[  198.246949] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  198.246949] CR2: 00007f61e407f000 CR3: 0000000001a05000 CR4: 
00000000000006f0
[  198.246949] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  198.246949] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[  198.246949] Process kworker/0:1 (pid: 10, threadinfo 
ffff880405cd4000, task ffff880405cc5bc0)
[  198.246949] Stack:
[  198.246949]  ffff880405cd5be0 ffff880804fb5800 ffff880803fd1630 
ffff880803fd15a8
[  198.246949]  ffff880405cd5c30 ffffffffa02dd8ad ffff880803fd1480 
ffff880803fd1600
[  198.246949]  ffff880405cd5c30 ffff8803fde4c644 ffff880803fd15a8 
0000000000000000
[  198.246949] Call Trace:
[  198.246949]  [<ffffffffa02dd8ad>] send_queued+0xed/0x130 [libceph]
[  198.246949]  [<ffffffffa02dfd81>] ceph_osdc_handle_map+0x261/0x3b0 
[libceph]
[  198.246949]  [<ffffffffa02d711c>] ? ceph_msg_new+0x15c/0x230 [libceph]
[  198.246949]  [<ffffffffa02e01e0>] dispatch+0x150/0x360 [libceph]
[  198.246949]  [<ffffffffa02da54f>] con_work+0x214f/0x21d0 [libceph]
[  198.246949]  [<ffffffffa02d8400>] ? ceph_con_send+0x120/0x120 [libceph]
[  198.246949]  [<ffffffff8108110d>] process_one_work+0x11d/0x430
[  198.246949]  [<ffffffff81081c69>] worker_thread+0x169/0x360
[  198.246949]  [<ffffffff81081b00>] ? manage_workers.clone.21+0x240/0x240
[  198.246949]  [<ffffffff81086496>] kthread+0x96/0xa0
[  198.246949]  [<ffffffff815e5bb4>] kernel_thread_helper+0x4/0x10
[  198.246949]  [<ffffffff81086400>] ? flush_kthread_worker+0xb0/0xb0
[  198.246949]  [<ffffffff815e5bb0>] ? gs_change+0x13/0x13
[  198.246949] Code: 65 f0 4c 8b 6d f8 c9 c3 66 90 48 8d be 88 00 00 00 
48 c7 c6 70 a8 2d a0 e8 dd 9c 00 e1 48 8b 5d e8 4c 8b 65 f0 4c 8b 6d f8 
c9 c3 <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57
[  198.246949] RIP  [<ffffffffa02d83f1>] ceph_con_send+0x111/0x120 [libceph]
[  198.246949]  RSP <ffff880405cd5bc0>
[  198.927024] ---[ end trace 03cb81299b093f05 ]---
[  198.940010] BUG: unable to handle kernel paging request at 
fffffffffffffff8
[  198.949892] IP: [<ffffffff810868f0>] kthread_data+0x10/0x20
[  198.949892] PGD 1a07067 PUD 1a08067 PMD 0
[  198.949892] Oops: 0000 [#2] SMP
[  198.949892] CPU 0
[  198.949892] Modules linked in: rbd libceph libcrc32c ip6table_filter 
ip6_tables iptable_filter ip_tables x_tables nv_tco bridge stp kvm_amd 
kvm radeon ttm psmouse drm_kms_helper drm i2c_algo_bit k10temp 
i2c_nforce2 shpchp amd64_edac_mod serio_raw edac_core edac_mce_amd lp 
parport ses enclosure aacraid forcedeth
[  198.949892]
[  198.949892] Pid: 10, comm: kworker/0:1 Tainted: G      D 
3.1.0-rc5-custom #1 Supermicro H8DM8-2/H8DM8-2
[  198.949892] RIP: 0010:[<ffffffff810868f0>]  [<ffffffff810868f0>] 
kthread_data+0x10/0x20
[  198.949892] RSP: 0018:ffff880405cd5868  EFLAGS: 00010096
[  198.949892] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[  198.949892] RDX: ffff880405cc5bc0 RSI: 0000000000000000 RDI: 
ffff880405cc5bc0
[  198.949892] RBP: ffff880405cd5868 R08: 0000000000989680 R09: 
0000000000000000
[  198.949892] R10: 0000000000000400 R11: 0000000000000006 R12: 
ffff880405cc5f88
[  198.949892] R13: 0000000000000000 R14: 0000000000000000 R15: 
ffff880405cc5e90
[  198.949892] FS:  00007fea65610700(0000) GS:ffff88040fc00000(0000) 
knlGS:0000000000000000
[  198.949892] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  198.949892] CR2: fffffffffffffff8 CR3: 0000000001a05000 CR4: 
00000000000006f0
[  198.949892] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  198.949892] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[  198.949892] Process kworker/0:1 (pid: 10, threadinfo 
ffff880405cd4000, task ffff880405cc5bc0)
[  198.949892] Stack:
[  198.949892]  ffff880405cd5888 ffffffff81082345 ffff880405cd5888 
ffff88040fc13080
[  198.949892]  ffff880405cd5918 ffffffff815d9092 ffff880405e5a558 
ffff880405cc5bc0
[  198.949892]  ffff880405cd58d8 ffff880405cd5fd8 ffff880405cd4000 
ffff880405cd5fd8
[  198.949892] Call Trace:
[  198.949892]  [<ffffffff81082345>] wq_worker_sleeping+0x15/0xa0
[  198.949892]  [<ffffffff815d9092>] __schedule+0x5c2/0x8b0
[  198.949892]  [<ffffffff812caf96>] ? put_io_context+0x46/0x70
[  198.949892]  [<ffffffff8105b72f>] schedule+0x3f/0x60
[  198.949892]  [<ffffffff81068223>] do_exit+0x5e3/0x8a0
[  198.949892]  [<ffffffff815dcc4f>] oops_end+0xaf/0xf0
[  198.949892]  [<ffffffff8101689b>] die+0x5b/0x90
[  198.949892]  [<ffffffff815dc354>] do_trap+0xc4/0x170
[  198.949892]  [<ffffffff81013f25>] do_invalid_op+0x95/0xb0
[  198.949892]  [<ffffffffa02d83f1>] ? ceph_con_send+0x111/0x120 [libceph]
[  198.949892]  [<ffffffffa02e276a>] ? ceph_calc_pg_acting+0x2a/0x90 
[libceph]
[  198.949892]  [<ffffffff815e5a2b>] invalid_op+0x1b/0x20
[  198.949892]  [<ffffffffa02d83f1>] ? ceph_con_send+0x111/0x120 [libceph]
[  198.949892]  [<ffffffffa02dd8ad>] send_queued+0xed/0x130 [libceph]
[  198.949892]  [<ffffffffa02dfd81>] ceph_osdc_handle_map+0x261/0x3b0 
[libceph]
[  198.949892]  [<ffffffffa02d711c>] ? ceph_msg_new+0x15c/0x230 [libceph]
[  198.949892]  [<ffffffffa02e01e0>] dispatch+0x150/0x360 [libceph]
[  198.949892]  [<ffffffffa02da54f>] con_work+0x214f/0x21d0 [libceph]
[  198.949892]  [<ffffffffa02d8400>] ? ceph_con_send+0x120/0x120 [libceph]
[  198.949892]  [<ffffffff8108110d>] process_one_work+0x11d/0x430
[  198.949892]  [<ffffffff81081c69>] worker_thread+0x169/0x360
[  198.949892]  [<ffffffff81081b00>] ? manage_workers.clone.21+0x240/0x240
[  198.949892]  [<ffffffff81086496>] kthread+0x96/0xa0
[  198.949892]  [<ffffffff815e5bb4>] kernel_thread_helper+0x4/0x10
[  198.949892]  [<ffffffff81086400>] ? flush_kthread_worker+0xb0/0xb0
[  198.949892]  [<ffffffff815e5bb0>] ? gs_change+0x13/0x13
[  198.949892] Code: 5e 41 5f c9 c3 be 3e 01 00 00 48 c7 c7 5b 3a 7d 81 
e8 85 d3 fd ff e9 84 fe ff ff 55 48 89 e5 66 66 66 66 90 48 8b 87 70 03 
00 00
[  198.949892]  8b 40 f8 c9 c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 66
[  198.949892] RIP  [<ffffffff810868f0>] kthread_data+0x10/0x20
[  198.949892]  RSP <ffff880405cd5868>
[  198.949892] CR2: fffffffffffffff8
[  198.949892] ---[ end trace 03cb81299b093f06 ]---
[  198.949892] Fixing recursive fault but reboot is needed!

