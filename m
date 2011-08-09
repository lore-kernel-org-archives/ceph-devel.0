From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: msgpool osd_op_reply alloc failed
Date: Tue, 09 Aug 2011 13:51:46 +0300
Message-ID: <4E411142.1030505@ufm.su>
References: <4E41010E.2000008@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:39713 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713Ab1HIKvt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Aug 2011 06:51:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id DDDE8600247
	for <ceph-devel@vger.kernel.org>; Tue,  9 Aug 2011 13:51:47 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hqMeBwge4R27 for <ceph-devel@vger.kernel.org>;
	Tue,  9 Aug 2011 13:51:47 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id AEB51600245
	for <ceph-devel@vger.kernel.org>; Tue,  9 Aug 2011 13:51:47 +0300 (EEST)
In-Reply-To: <4E41010E.2000008@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 08/09/2011 12:42 PM, Fyodor Ustinov wrote:

Additional. umount ceph fs:

Aug  9 12:44:54 backup-ext kernel: [209941.023884] ------------[ cut 
here ]------------
Aug  9 12:44:54 backup-ext kernel: [209941.023978] kernel BUG at 
mm/mempool.c:186!
Aug  9 12:44:54 backup-ext kernel: [209941.024061] invalid opcode: 0000 
[#1] SMP
Aug  9 12:44:54 backup-ext kernel: [209941.024146] CPU 0
Aug  9 12:44:54 backup-ext kernel: [209941.024163] Modules linked in: 
nfs lockd fscache auth_rpcgss nfs_acl sunrpc ceph libceph libcrc32c 
ppdev vmw_balloon psmouse serio_raw parport_pc i2c_piix4 shpchp lp 
parport e1000 mptspi mptscsih mptbase
Aug  9 12:44:54 backup-ext kernel: [209941.024533]
Aug  9 12:44:54 backup-ext kernel: [209941.024596] Pid: 8812, comm: 
umount Not tainted 3.0.0-ceph #1 VMware, Inc. VMware Virtual 
Platform/440BX Desktop Reference Platform
Aug  9 12:44:54 backup-ext kernel: [209941.024791] RIP: 
0010:[<ffffffff8110a0e8>]  [<ffffffff8110a0e8>] mempool_destroy+0x18/0x20
Aug  9 12:44:54 backup-ext kernel: [209941.024961] RSP: 
0000:ffff880036983df8  EFLAGS: 00010297
Aug  9 12:44:54 backup-ext kernel: [209941.025052] RAX: 000000000000000a 
RBX: ffff88003b3379a8 RCX: 0000000000000000
Aug  9 12:44:54 backup-ext kernel: [209941.025206] RDX: 0000000000000028 
RSI: ffffea0000ceaed0 RDI: ffff88003b0d6360
Aug  9 12:44:54 backup-ext kernel: [209941.025400] RBP: ffff880036983df8 
R08: ffff88003f802200 R09: ffffffff8110a0c5
Aug  9 12:44:54 backup-ext kernel: [209941.025590] R10: 0000000000000000 
R11: 0000000000015c08 R12: ffff880036820080
Aug  9 12:44:54 backup-ext kernel: [209941.025775] R13: ffff8800368d2900 
R14: ffff880036983f28 R15: ffff8800368d2940
Aug  9 12:44:54 backup-ext kernel: [209941.025961] FS:  
00007fb370018760(0000) GS:ffff88003fc00000(0000) knlGS:0000000000000000
Aug  9 12:44:54 backup-ext kernel: [209941.026155] CS:  0010 DS: 0000 
ES: 0000 CR0: 000000008005003b
Aug  9 12:44:54 backup-ext kernel: [209941.026268] CR2: 00007fffe92c9958 
CR3: 000000002ba25000 CR4: 00000000000006f0
Aug  9 12:44:54 backup-ext kernel: [209941.026520] DR0: 0000000000000000 
DR1: 0000000000000000 DR2: 0000000000000000
Aug  9 12:44:54 backup-ext kernel: [209941.026733] DR3: 0000000000000000 
DR6: 00000000ffff0ff0 DR7: 0000000000000400
Aug  9 12:44:54 backup-ext kernel: [209941.026920] Process umount (pid: 
8812, threadinfo ffff880036982000, task ffff88003c8ac4d0)
Aug  9 12:44:54 backup-ext kernel: [209941.027115] Stack:
Aug  9 12:44:54 backup-ext kernel: [209941.027194]  ffff880036983e08 
ffffffffa00a9a02 ffff880036983e28 ffffffffa00abfe3
Aug  9 12:44:54 backup-ext kernel: [209941.027388]  ffff88003b336800 
ffff88003b337800 ffff880036983e48 ffffffffa00a558d
Aug  9 12:44:54 backup-ext kernel: [209941.027582]  ffff880036820080 
ffff88003b336800 ffff880036983e68 ffffffffa00d0c23
Aug  9 12:44:54 backup-ext kernel: [209941.027782] Call Trace:
Aug  9 12:44:54 backup-ext kernel: [209941.027881]  [<ffffffffa00a9a02>] 
ceph_msgpool_destroy+0x12/0x20 [libceph]
Aug  9 12:44:54 backup-ext kernel: [209941.028009]  [<ffffffffa00abfe3>] 
ceph_osdc_stop+0x83/0xb0 [libceph]
Aug  9 12:44:54 backup-ext kernel: [209941.028131]  [<ffffffffa00a558d>] 
ceph_destroy_client+0x1d/0x60 [libceph]
Aug  9 12:44:54 backup-ext kernel: [209941.028262]  [<ffffffffa00d0c23>] 
destroy_fs_client+0x63/0x70 [ceph]
Aug  9 12:44:54 backup-ext kernel: [209941.028383]  [<ffffffffa00d0c71>] 
ceph_kill_sb+0x41/0x50 [ceph]
Aug  9 12:44:54 backup-ext kernel: [209941.028501]  [<ffffffff81163045>] 
deactivate_locked_super+0x45/0x70
Aug  9 12:44:54 backup-ext kernel: [209941.028620]  [<ffffffff81163a9a>] 
deactivate_super+0x4a/0x70
Aug  9 12:44:54 backup-ext kernel: [209941.028734]  [<ffffffff8117e714>] 
mntput_no_expire+0xa4/0xf0
Aug  9 12:44:54 backup-ext kernel: [209941.028847]  [<ffffffff8117f46c>] 
sys_umount+0x6c/0x3a0
Aug  9 12:44:54 backup-ext kernel: [209941.028958]  [<ffffffff815dc182>] 
system_call_fastpath+0x16/0x1b
Aug  9 12:44:54 backup-ext kernel: [209941.029074] Code: 48 89 df e8 db 
65 04 00 48 83 c4 08 5b 41 5c 41 5d c9 c3 55 48 89 e5 66 66 66 66 90 8b 
47 04 39 47 08 75 07 e8 8a ff ff ff c9 c3 <0f> 0b 66 0f 1f 44 00 00 55 
48 89 e5 41 57 41 56 41 55 41 54 53
Aug  9 12:44:54 backup-ext kernel: [209941.029513] RIP  
[<ffffffff8110a0e8>] mempool_destroy+0x18/0x20
Aug  9 12:44:54 backup-ext kernel: [209941.029631]  RSP <ffff880036983df8>
Aug  9 12:44:54 backup-ext kernel: [209941.029952] ---[ end trace 
a6e59f3f9dbca805 ]---

