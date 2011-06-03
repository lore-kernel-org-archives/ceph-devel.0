From: Fyodor Ustinov <ufm@ufm.su>
Subject: crash on umount
Date: Fri, 03 Jun 2011 13:40:44 +0300
Message-ID: <4DE8BA2C.6030309@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:55083 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879Ab1FCKkt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 3 Jun 2011 06:40:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 41D23600484
	for <ceph-devel@vger.kernel.org>; Fri,  3 Jun 2011 13:40:46 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V1R9pnB-E+BC for <ceph-devel@vger.kernel.org>;
	Fri,  3 Jun 2011 13:40:46 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 214F1600447
	for <ceph-devel@vger.kernel.org>; Fri,  3 Jun 2011 13:40:45 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

kernel 2.6.39
ceph - 0.28.2

In sysctl.conf set
vm.min_free_kbytes=262144


Jun  2 03:08:17 amanda kernel: [35398.757055] libceph: msg_new can't 
allocate 4096 bytes
Jun  2 03:08:17 amanda kernel: [35398.757088] libceph: msg_new can't 
create type 0 front 4096
Jun  2 03:08:17 amanda kernel: [35398.757148] libceph: msgpool osd_op 
alloc failed
Jun  2 03:08:17 amanda kernel: [35398.759437] libceph: msg_new can't 
allocate 4096 bytes
Jun  2 03:08:17 amanda kernel: [35398.759469] libceph: msg_new can't 
create type 0 front 4096
Jun  2 03:08:17 amanda kernel: [35398.759491] libceph: msgpool osd_op 
alloc failed
Jun  2 03:08:17 amanda kernel: [35398.775955] libceph: msg_new can't 
allocate 4096 bytes
Jun  2 03:08:17 amanda kernel: [35398.775987] libceph: msg_new can't 
create type 0 front 4096
Jun  2 03:08:17 amanda kernel: [35398.776008] libceph: msgpool osd_op 
alloc failed
Jun  3 00:16:47 amanda kernel: [111508.961385] libceph: msg_new can't 
allocate 4096 bytes
Jun  3 00:16:47 amanda kernel: [111508.961415] libceph: msg_new can't 
create type 0 front 4096
Jun  3 00:16:47 amanda kernel: [111508.961442] libceph: msgpool osd_op 
alloc failed
Jun  3 13:33:10 amanda kernel: [159291.960881] ------------[ cut here 
]------------
Jun  3 13:33:10 amanda kernel: [159291.960930] kernel BUG at 
mm/mempool.c:186!
Jun  3 13:33:10 amanda kernel: [159291.960971] invalid opcode: 0000 [#1] 
SMP
Jun  3 13:33:10 amanda kernel: [159291.961011] last sysfs file: 
/sys/devices/system/cpu/cpu1/cache/index2/shared_cpu_map
Jun  3 13:33:10 amanda kernel: [159291.961074] CPU 1
Jun  3 13:33:10 amanda kernel: [159291.961093] Modules linked in: 8021q 
garp stp ceph libceph i915 drm_kms_helper bonding drm psmouse 
i2c_algo_bit serio_raw video btrfs lp parport zlib_deflate libcrc32c 
raid10 raid456 async_pq async_xor xor async_memcpy async_raid6_recov 
e1000e raid6_pq async_tx raid1 raid0 multipath linear
Jun  3 13:33:10 amanda kernel: [159291.961414]
Jun  3 13:33:10 amanda kernel: [159291.961431] Pid: 4236, comm: umount 
Not tainted 2.6.39-ufm2+ #1 Gigabyte Technology Co., Ltd. 
EG41MF-US2H/EG41MF-US2H
Jun  3 13:33:10 amanda kernel: [159291.961525] RIP: 
0010:[<ffffffff8110a5c8>]  [<ffffffff8110a5c8>] mempool_destroy+0x18/0x20
Jun  3 13:33:10 amanda kernel: [159291.961601] RSP: 
0018:ffff88000f1dbdf8  EFLAGS: 00010297
Jun  3 13:33:10 amanda kernel: [159291.961644] RAX: 000000000000000a 
RBX: ffff880078ebf1a8 RCX: 0000000000000000
Jun  3 13:33:10 amanda kernel: [159291.961701] RDX: 000000000000001e 
RSI: ffffea0000c0c130 RDI: ffff88003712a6c0
Jun  3 13:33:10 amanda kernel: [159291.961759] RBP: ffff88000f1dbdf8 
R08: ffff88007d002200 R09: ffffffff8110a5a5
Jun  3 13:33:10 amanda kernel: [159291.961816] R10: 0000000000000001 
R11: dead000000200200 R12: ffff8800795d3040
Jun  3 13:33:10 amanda kernel: [159291.961872] R13: ffff880078eeef00 
R14: ffff88000f1dbf28 R15: ffff880078eeef40
Jun  3 13:33:10 amanda kernel: [159291.961929] FS:  
00007f767c662760(0000) GS:ffff88007da80000(0000) knlGS:0000000000000000
Jun  3 13:33:10 amanda kernel: [159291.961993] CS:  0010 DS: 0000 ES: 
0000 CR0: 000000008005003b
Jun  3 13:33:10 amanda kernel: [159291.962040] CR2: 00007f767bd7b0d0 
CR3: 00000000770d3000 CR4: 00000000000406e0
Jun  3 13:33:10 amanda kernel: [159291.962096] DR0: 0000000000000000 
DR1: 0000000000000000 DR2: 0000000000000000
Jun  3 13:33:10 amanda kernel: [159291.963761] DR3: 0000000000000000 
DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jun  3 13:33:10 amanda kernel: [159291.965395] Process umount (pid: 
4236, threadinfo ffff88000f1da000, task ffff880036d60000)
Jun  3 13:33:10 amanda kernel: [159291.967062] Stack:
Jun  3 13:33:10 amanda kernel: [159291.968711]  ffff88000f1dbe08 
ffffffffa02a59e2 ffff88000f1dbe28 ffffffffa02a7fc3
Jun  3 13:33:10 amanda kernel: [159291.970432]  ffff880078ebe400 
ffff880078ebf000 ffff88000f1dbe48 ffffffffa02a158d
Jun  3 13:33:10 amanda kernel: [159291.970496]  ffff8800795d3040 
ffff880078ebe400 ffff88000f1dbe68 ffffffffa02cebf3
Jun  3 13:33:10 amanda kernel: [159291.970496] Call Trace:
Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffffa02a59e2>] 
ceph_msgpool_destroy+0x12/0x20 [libceph]
Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffffa02a7fc3>] 
ceph_osdc_stop+0x83/0xb0 [libceph]
Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffffa02a158d>] 
ceph_destroy_client+0x1d/0x60 [libceph]
Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffffa02cebf3>] 
destroy_fs_client+0x63/0x70 [ceph]
Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffffa02cec41>] 
ceph_kill_sb+0x41/0x50 [ceph]
Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffff81162865>] 
deactivate_locked_super+0x45/0x70
Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffff811632ba>] 
deactivate_super+0x4a/0x70
Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffff8117ddb4>] 
mntput_no_expire+0xa4/0xf0
Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffff8117eb0c>] 
sys_umount+0x6c/0x3a0
Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffff815ddec2>] 
system_call_fastpath+0x16/0x1b
Jun  3 13:33:10 amanda kernel: [159291.970496] Code: 48 89 df e8 ab 5a 
04 00 48 83 c4 08 5b 41 5c 41 5d c9 c3 55 48 89 e5 0f 1f 44 00 00 8b 47 
04 39 47 08 75 07 e8 8a ff ff ff c9 c3 <0f> 0b 66 0f 1f 44 00 00 55 48 
89 e5 41 57 41 56 41 55 41 54 53
Jun  3 13:33:10 amanda kernel: [159291.970496] RIP  [<ffffffff8110a5c8>] 
mempool_destroy+0x18/0x20
Jun  3 13:33:10 amanda kernel: [159291.970496]  RSP <ffff88000f1dbdf8>
Jun  3 13:33:10 amanda kernel: [159292.007957] ---[ end trace 
d333fc57eb1e6ccd ]---
