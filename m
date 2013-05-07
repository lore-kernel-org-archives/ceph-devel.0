From: Travis Rhoden <trhoden@gmail.com>
Subject: General Protection Fault in 3.8.5
Date: Mon, 6 May 2013 21:48:24 -0400
Message-ID: <CACkq2mpBF4pPmBox4uNv5xcd1aO5cyMviBruFHrij6ourByj9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:56437 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759637Ab3EGBsq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:48:46 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so18493bkc.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:48:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hey folks,

We have two servers that map a lot of RBDs (20 to 30 each so far),
using the RBD kernel module.  They are running Ubuntu 12.10, and I
originally saw a lot of kernel panics (obviously from Ceph) when
running a 3.5.7 kernel.

I upgrade a while back to a 3.8.5 kernel to get a much newer RBD
module, and the kernel panics from Ceph went away...and were replaced
by these nebulous "General Protection Faults" that I couldn't really
tell what was causing them.

Today we saw one that actually had a Ceph backtrace in it, so I wanted
to throw it on here:

May  6 23:02:58 nfs1 kernel: [295972.423165] general protection fault:
0000 [#3] SMP
May  6 23:02:58 nfs1 kernel: [295972.428252] Modules linked in: rbd
libceph libcrc32c coretemp nfsd kvm nfs_acl auth_rpcgss nfs fscache
lockd sunrpc gpio_ich psmouse microcode serio_raw i7core_edac ipmi_si
edac_core lpc_ich ioatdma ipmi_devintf mac_hid ipmi_msghandler bonding
lp parport tcp_bic raid10 raid456 async_pq async_xor xor async_memcpy
async_raid6_recov hid_generic raid6_pq usbhid async_tx hid igb raid1
myri10ge raid0 ahci ptp libahci dca pps_core multipath linear
May  6 23:02:58 nfs1 kernel: [295972.468114] CPU 17
May  6 23:02:58 nfs1 kernel: [295972.470133] Pid: 15920, comm:
kworker/17:2 Tainted: G      D      3.8.5-030805-generic #201303281651
Penguin Computing Relion 1751/X8DTU
May  6 23:02:58 nfs1 kernel: [295972.482635] RIP:
0010:[<ffffffff811851ff>]  [<ffffffff811851ff>]
kmem_cache_alloc_trace+0x5f/0x140
May  6 23:02:58 nfs1 kernel: [295972.491686] RSP:
0018:ffff880624cb1a98  EFLAGS: 00010202
May  6 23:02:58 nfs1 kernel: [295972.497074] RAX: 0000000000000000
RBX: ffff88032ddc46d0 RCX: 000000000003c867
May  6 23:02:58 nfs1 kernel: [295972.504283] RDX: 000000000003c866
RSI: 0000000000008050 RDI: 0000000000016c80
May  6 23:02:58 nfs1 kernel: [295972.511490] RBP: ffff880624cb1ae8
R08: ffff880333d76c80 R09: 0000000000000002
May  6 23:02:58 nfs1 kernel: [295972.518697] R10: ffff88032ce40070
R11: 000000000000000d R12: ffff880333802200
May  6 23:02:58 nfs1 kernel: [295972.525906] R13: 2e0460b9275465f2
R14: ffffffffa023901e R15: 0000000000008050
May  6 23:02:58 nfs1 kernel: [295972.533113] FS:
0000000000000000(0000) GS:ffff880333d60000(0000)
knlGS:0000000000000000
May  6 23:02:58 nfs1 kernel: [295972.541274] CS:  0010 DS: 0000 ES:
0000 CR0: 000000008005003b
May  6 23:02:58 nfs1 kernel: [295972.547095] CR2: 00007fbf9467f2b0
CR3: 0000000001c0d000 CR4: 00000000000007e0
May  6 23:02:58 nfs1 kernel: [295972.554305] DR0: 0000000000000000
DR1: 0000000000000000 DR2: 0000000000000000
May  6 23:02:58 nfs1 kernel: [295972.561512] DR3: 0000000000000000
DR6: 00000000ffff0ff0 DR7: 0000000000000400
May  6 23:02:58 nfs1 kernel: [295972.568720] Process kworker/17:2
(pid: 15920, threadinfo ffff880624cb0000, task ffff88032b600000)
May  6 23:02:58 nfs1 kernel: [295972.577656] Stack:
May  6 23:02:58 nfs1 kernel: [295972.579756]  0000000000000000
0000000000000000 0000000000000060 0000000000000000
May  6 23:02:58 nfs1 kernel: [295972.587292]  0000000000000000
ffff88032ddc46d0 0000000000000004 ffff88032ddc46c0
May  6 23:02:58 nfs1 kernel: [295972.594819]  ffff88032b432b30
0000000000000000 ffff880624cb1b28 ffffffffa023901e
May  6 23:02:58 nfs1 kernel: [295972.602347] Call Trace:
May  6 23:02:58 nfs1 kernel: [295972.604886]  [<ffffffffa023901e>]
get_ticket_handler.isra.4+0x5e/0xc0 [libceph]
May  6 23:02:58 nfs1 kernel: [295972.612271]  [<ffffffffa02394b4>]
ceph_x_proc_ticket_reply+0x274/0x440 [libceph]
May  6 23:02:58 nfs1 kernel: [295972.619740]  [<ffffffffa023973d>]
ceph_x_handle_reply+0xbd/0x110 [libceph]
May  6 23:02:58 nfs1 kernel: [295972.626696]  [<ffffffffa023765c>]
ceph_handle_auth_reply+0x18c/0x200 [libceph]
May  6 23:02:58 nfs1 kernel: [295972.633988]  [<ffffffffa022d590>]
handle_auth_reply.isra.12+0xa0/0x230 [libceph]
May  6 23:02:58 nfs1 kernel: [295972.641457]  [<ffffffffa022e87d>]
dispatch+0xbd/0x120 [libceph]
May  6 23:02:58 nfs1 kernel: [295972.647450]  [<ffffffffa0228205>]
process_message+0xa5/0xc0 [libceph]
May  6 23:02:58 nfs1 kernel: [295972.653966]  [<ffffffffa022c1b1>]
try_read+0x2e1/0x430 [libceph]
May  6 23:02:58 nfs1 kernel: [295972.660048]  [<ffffffffa022c38f>]
con_work+0x8f/0x140 [libceph]
May  6 23:02:58 nfs1 kernel: [295972.666043]  [<ffffffff81078c31>]
process_one_work+0x141/0x490
May  6 23:02:58 nfs1 kernel: [295972.671952]  [<ffffffff81079b08>]
worker_thread+0x168/0x400
May  6 23:02:58 nfs1 kernel: [295972.677601]  [<ffffffff810799a0>] ?
manage_workers+0x120/0x120
May  6 23:02:58 nfs1 kernel: [295972.683513]  [<ffffffff8107eff0>]
kthread+0xc0/0xd0
May  6 23:02:58 nfs1 kernel: [295972.688469]  [<ffffffff8107ef30>] ?
flush_kthread_worker+0xb0/0xb0
May  6 23:02:58 nfs1 kernel: [295972.694726]  [<ffffffff816f532c>]
ret_from_fork+0x7c/0xb0
May  6 23:02:58 nfs1 kernel: [295972.700203]  [<ffffffff8107ef30>] ?
flush_kthread_worker+0xb0/0xb0
May  6 23:02:58 nfs1 kernel: [295972.706456] Code: 00 4d 8b 04 24 65
4c 03 04 25 08 dc 00 00 49 8b 50 08 4d 8b 28 4d 85 ed 0f 84 cf 00 00
00 49 63 44 24 20 49 8b 3c 24 48 8d 4a 01 <49> 8b 5c 05 00 4c 89 e8 65
48 0f c7 0f 0f 94 c0 84 c0 74 c2 49
May  6 23:02:58 nfs1 kernel: [295972.726468] RIP  [<ffffffff811851ff>]
kmem_cache_alloc_trace+0x5f/0x140
May  6 23:02:58 nfs1 kernel: [295972.733182]  RSP <ffff880624cb1a98>
May  6 23:02:58 nfs1 kernel: [295972.736838] ---[ end trace
20e9b6a1bb611aba ]---

I'm not sure whether the problem started here or not.  I mentioned
that the previous GPFs were nebulous -- one thing most of them have
had in common is that it's almost always from nfsd (this one isn't --
first and only time I've seen this one).  Howevever, I am using NFS to
re-export some RBDs (to provide access to multiple clients) so Ceph is
still in the picture on those.

I know its not a lot to go on, but any advice would be appreciated.

 - Travis
