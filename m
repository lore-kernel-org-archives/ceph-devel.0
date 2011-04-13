From: Fyodor Ustinov <ufm@ufm.su>
Subject: It's not a bug of ceph, but
Date: Wed, 13 Apr 2011 13:57:04 +0300
Message-ID: <4DA58180.7090701@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:53820 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab1DMK5H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Apr 2011 06:57:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id B7A21600306
	for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2011 13:57:04 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bvLT3B6Qt3uI for <ceph-devel@vger.kernel.org>;
	Wed, 13 Apr 2011 13:57:04 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 88EBA6002BB
	for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2011 13:57:04 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

may be anyone seen this trouble?

it's OSD on ubuntu 11.04 beta (sic!).
ext2 (sic!!)
and journal on tmpfs (sic!!! :)

FS mounted by

/dev/md0 /mfs ext2 rw,noatime,nodiratime,async,noexec,nodev,user_xattr  0 0


It's absolutely reproduced in any time.

[48106.592387] ------------[ cut here ]------------
[48106.592478] kernel BUG at 
/build/buildd/linux-2.6.38/fs/ext2/balloc.c:1169!
[48106.592595] invalid opcode: 0000 [#1] SMP
[48106.592669] last sysfs file: 
/sys/devices/system/cpu/cpu3/cache/index2/shared_cpu_map
[48106.592782] CPU 2
[48106.592820] Modules linked in: 8021q garp stp radeon ttm lp 
drm_kms_helper drm parport ghes bonding i2c_algo_bit i3200_edac video 
hed serio_raw edac_core shpchp raid10 raid456 async_pq async_xor xor 
async_memcpy async_raid6_recov raid6_pq async_tx raid1 raid0 multipath 
e1000e linear btrfs pata_it8213 zlib_deflate libcrc32c
[48106.593715]
[48106.593749] Pid: 1860, comm: cosd Not tainted 2.6.38-8-server 
#41-Ubuntu Supermicro X7SBi/X7SBi
[48106.593926] RIP: 0010:[<ffffffff811f07e8>]  [<ffffffff811f07e8>] 
ext2_try_to_allocate_with_rsv+0x2c8/0x2d0
[48106.594092] RSP: 0018:ffff880126f31a68  EFLAGS: 00010246
[48106.594174] RAX: 0000000000000027 RBX: ffff880126e80c40 RCX: 
000000000003ffff
[48106.594273] RDX: 0000000000000000 RSI: 0000000000000082 RDI: 
0000000000000246
[48106.594372] RBP: ffff880126f31af8 R08: 0000000000000034 R09: 
000000000001558b
[48106.594474] R10: 0000000000000000 R11: 0000000000000001 R12: 
0000000000000000
[48106.594579] R13: ffff880125818400 R14: 0000000000000e37 R15: 
ffff8801254ea778
[48106.594682] FS:  00007fd1d1de2700(0000) GS:ffff8800cfd00000(0000) 
knlGS:0000000000000000
[48106.594808] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[48106.594889] CR2: 00007fd1c08b7000 CR3: 0000000126361000 CR4: 
00000000000406e0
[48106.594991] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[48106.595099] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[48106.595200] Process cosd (pid: 1860, threadinfo ffff880126f30000, 
task ffff880123760000)
[48106.595319] Stack:
[48106.595359]  ffff880126f31a98 ffff8801254ea750 ffff880126f31a98 
ffffffff811934a7
[48106.595509]  0000000000000000 ffff880126e80c60 00000000071bffff 
ffff880126f31b78
[48106.595655]  00000000071b8000 0000000000000e37 ffff880125818400 
0000000000000001
[48106.595801] Call Trace:
[48106.595844]  [<ffffffff811934a7>] ? __find_get_block+0x87/0xe0
[48106.595929]  [<ffffffff811f0e83>] ext2_new_blocks+0x203/0x620
[48106.596008]  [<ffffffff811f4f4d>] ? ext2_write_begin+0x3d/0x80
[48106.596096]  [<ffffffff811f12c1>] ext2_new_block+0x21/0x30
[48106.596185]  [<ffffffff811f99cd>] ext2_xattr_set2+0x2bd/0x430
[48106.596270]  [<ffffffff8115538f>] ? __kmalloc+0xff/0x140
[48106.596353]  [<ffffffff811fa2b0>] ext2_xattr_set+0x520/0x8e0
[48106.596449]  [<ffffffff811fa8d9>] ext2_xattr_user_set+0x49/0x50
[48106.601478]  [<ffffffff81186bad>] generic_setxattr+0x6d/0x80
[48106.601478]  [<ffffffff811873b0>] __vfs_setxattr_noperm+0x50/0x1a0
[48106.601478]  [<ffffffff8116fb08>] ? inode_permission+0xa8/0xd0
[48106.601478]  [<ffffffff811875bc>] vfs_setxattr+0xbc/0xc0
[48106.601478]  [<ffffffff81187682>] setxattr+0xc2/0x150
[48106.601478]  [<ffffffff8116fd85>] ? putname+0x35/0x50
[48106.601478]  [<ffffffff81172d02>] ? user_path_at+0x62/0xa0
[48106.601478]  [<ffffffff8109c72b>] ? do_futex+0xbb/0x210
[48106.601478]  [<ffffffff8109c8fb>] ? sys_futex+0x7b/0x180
[48106.650005]  [<ffffffff811877a5>] sys_setxattr+0x95/0xb0
[48106.650005]  [<ffffffff8100bfc2>] system_call_fastpath+0x16/0x1b
[48106.650005] Code: 48 ff ff ff 48 8d 14 11 48 89 53 28 eb e6 48 63 45 
8c 48 01 43 28 eb dc 48 81 c7 48 01 00 00 48 c7 c6 40 6b 62 81 e8 f8 f6 
ff ff <0f> 0b 66 0f 1f 44 00 00 55 48 89 e5 41 54 53 0f 1f 44 00 00 4c
[48106.650005] RIP  [<ffffffff811f07e8>] 
ext2_try_to_allocate_with_rsv+0x2c8/0x2d0
[48106.650005]  RSP <ffff880126f31a68>
[48106.697951] ---[ end trace 7a9e6977fb082a2e ]---

