From: Henry Chang <henry.cy.chang@gmail.com>
Subject: rbd: null pointer dereferenced during osd_reset
Date: Tue, 29 Mar 2011 23:52:40 +0800
Message-ID: <AANLkTikr09GsB49N0dSOyvfY63CkTx9CBj4iSG460_BN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50596 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab1C2PxE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2011 11:53:04 -0400
Received: by fxm17 with SMTP id 17so334829fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 Mar 2011 08:53:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I got the NULL pointer dereference exception (see below) when I
restarted one of my osd during rbd testing. After digging into
osd_client.c, it seems that when osd_reset() is called, the req->r_osd
will be set to NULL in __unregister_linger_request(). Then, in
send_queued(), req->r_osd (NULL pointer) will be dereferenced in
__send_request().

Hope it helps.
-- 
Henry



libceph: osd2 192.168.101.146:6800 socket closed
BUG: unable to handle kernel NULL pointer dereference at 0000000000000059
IP: [<ffffffffa027ece1>] ceph_con_send+0x16/0x197 [libceph]
PGD 0
Oops: 0000 [#1] SMP
last sysfs file: /sys/devices/pci0000:00/0000:00:1e.0/0000:03:03.0/local_cpus
CPU 0
Modules linked in: rbd ceph libceph libcrc32c nfsd lockd nfs_acl
auth_rpcgss exportfs sunrpc ipv6 fuse bnx2 iTCO_wdt
iTCO_vendor_support dcdbas power_meter joydev [last unloaded:
libcrc32c]
Pid: 8789, comm: ceph-msgr/0 Not tainted
2.6.32.23-170.Elaster.xendom0.fc12.x86_64 #1 PowerEdge R210
RIP: 0010:[<ffffffffa027ece1>]  [<ffffffffa027ece1>]
ceph_con_send+0x16/0x197 [libceph]
RSP: 0018:ffff88021b1b9bf0  EFLAGS: 00010286
RAX: ffff880233a65da8 RBX: ffff880235921a00 RCX: 000000000000158c
RDX: ffff880233a65e50 RSI: ffff8802299b7080 RDI: 0000000000000030
RBP: ffff88021b1b9c60 R08: ffff880233a65e50 R09: ffff88021b3da070
R10: ffff88021b1b9c10 R11: 0000000000000000 R12: ffff880233a65da8
R13: ffff880233a65e00 R14: ffff880233a65e60 R15: ffffe8ffffa08b88
FS:  0000000000000000(0000) GS:ffff880008e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000059 CR3: 0000000001001000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process ceph-msgr/0 (pid: 8789, threadinfo ffff88021b1b8000, task
ffff880222c245f0)
Stack:
ffff88021b1b9c10 ffff880235921a00 ffff880233a65da8 ffff880233a65da8
<0> 0000002000000000 ffff880233a65e60 ffff88021b1b9c30 ffffffff81071f7c
<0> ffff88021b1b9c40 ffff880235921a00 ffff880233a65da8 ffff880233a65e00
Call Trace:
[<ffffffff81071f7c>] ? queue_delayed_work+0x26/0x28
[<ffffffffa0285a9b>] __send_request+0xc1/0xf9 [libceph]
[<ffffffffa0285b31>] send_queued+0x5e/0x94 [libceph]
[<ffffffffa0285e6d>] osd_reset+0x6c/0x92 [libceph]
[<ffffffffa0282235>] con_work+0x10e8/0x14ee [libceph]
[<ffffffff81011678>] ? __switch_to+0xdb/0x22d
[<ffffffff81050d63>] ? finish_task_switch+0x48/0xb8
[<ffffffff8145b6bb>] ? thread_return+0x78/0xdb
[<ffffffff810c698b>] ? probe_workqueue_execution+0xb1/0xcd
[<ffffffff810713f4>] worker_thread+0x1a9/0x237
[<ffffffffa028114d>] ? con_work+0x0/0x14ee [libceph]
[<ffffffff81075a1f>] ? autoremove_wake_function+0x0/0x39
[<ffffffff8107124b>] ? worker_thread+0x0/0x237
[<ffffffff81075732>] kthread+0x7f/0x87
[<ffffffff81013d6a>] child_rip+0xa/0x20
[<ffffffff810756b3>] ? kthread+0x0/0x87
[<ffffffff81013d60>] ? child_rip+0x0/0x20
Code: 48 c7 c7 22 2d 29 a0 31 c0 e8 34 bf 1d e1 eb df 41 5b 5b c9 c3
55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 48 0f 1f 44 00 00 <f6>
47 29 04 49 89 fc 48 89 f3 74 37 f6 05 8e ca 74 e1 04 74 16
RIP  [<ffffffffa027ece1>] ceph_con_send+0x16/0x197 [libceph]
RSP <ffff88021b1b9bf0>
CR2: 0000000000000059
---[ end trace 01cef995c3bab915 ]---
