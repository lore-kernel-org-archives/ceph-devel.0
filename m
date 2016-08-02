From: Patrick McLean <patrickm@gaikai.com>
Subject: Re: ceph osd kernel divide error
Date: Tue, 2 Aug 2016 16:56:36 -0700
Message-ID: <CAE2NFgUZuU9DDCMx-UUYshY8DXYNcC3U0eAHQucOyHTgGBRsVg@mail.gmail.com>
References: <CALXUmNR27AxBz53UDajf3eKq0xYGoHV7xiPDRmnKhxZ-mL0bgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:35654 "EHLO
	mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbcHBX4u convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Aug 2016 19:56:50 -0400
Received: by mail-it0-f42.google.com with SMTP id u186so285524188ita.0
        for <ceph-devel@vger.kernel.org>; Tue, 02 Aug 2016 16:56:37 -0700 (PDT)
In-Reply-To: <CALXUmNR27AxBz53UDajf3eKq0xYGoHV7xiPDRmnKhxZ-mL0bgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Payno <vpayno@gaikai.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Roderick Colenbrander <roderick@gaikai.com>, Cliff Pajaro <cpajaro@gaikai.com>

Here is the decoded stacktrace, with line numbers and disasm:

$ scripts/decode_stacktrace.sh vmlinux /usr/src/linux-4.7.0/
/usr/src/linux-4.7.0/ < /tmp/oops.txt
[310363.450313] BUG: unable to handle kernel paging request at ffffffffffffffd8
[310363.457786] IP: kthread_data (/usr/src/linux/kernel/kthread.c:137)
[310363.463799] PGD 1e0a067 PUD 1e0c067 PMD 0
[310363.468573] Oops: 0000 [#2] SMP
[310363.472072] Modules linked in: rbd libceph sg rpcsec_gss_krb5
xt_UDPLB(O) xt_nat xt_multiport xt_addrtype iptable_mangle iptable_raw
iptable_nat nf_nat_ipv4 nf_nat ext4 jbd2 mbcache x86_pkg_temp_thermal
gkuart(O) usbserial ie31200_edac edac_core tpm_tis raid1 crc32c_intel
[310363.499255] CPU: 6 PID: 15231 Comm: kworker/u16:1 Tainted: G
D    O    4.7.0-vanilla-ams-3 #1
[310363.508717] Hardware name: Quanta T6BC-S1N/T6BC, BIOS T6BC2A01 03/26/2014
[310363.515845] task: ffff880097438d40 ti: ffff88030b0e8000 task.ti:
ffff88030b0e8000
[310363.523827] RIP: kthread_data (/usr/src/linux/kernel/kthread.c:137)
[310363.532444] RSP: 0018:ffff88030b0eba28  EFLAGS: 00010002
[310363.538110] RAX: 0000000000000000 RBX: ffff88041fd97e80 RCX:
0000000000000006
[310363.545750] RDX: ffff88040f005000 RSI: ffff880097438d40 RDI:
ffff880097438d40
[310363.553390] RBP: ffff88030b0eba30 R08: 0000000000000000 R09:
0000000000001000
[310363.561030] R10: 0000000000000000 R11: ffffea0003654801 R12:
0000000000017e80
[310363.568671] R13: 0000000000000000 R14: ffff880097439200 R15:
ffff880097438d40
[310363.576308] FS:  0000000000000000(0000) GS:ffff88041fd80000(0000)
knlGS:0000000000000000
[310363.584926] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[310363.590997] CR2: 0000000000000028 CR3: 00000002afe5f000 CR4:
00000000001406e0
[310363.598650] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[310363.606285] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[310363.613923] Stack:
[310363.616386]  ffffffff8112645e ffff88030b0eba78 ffffffff8185ab3e
ffff880097438d40
[310363.624653]  ffff88030b0eba90 ffff88030b0ec000 ffff88030b0ebad0
ffff88030b0eb6e8
[310363.632888]  ffff88040d5c8000 0000000000000000 ffff88030b0eba90
ffffffff8185aef5
[310363.645877] Call Trace:
[310363.648649] ? wq_worker_sleeping (/usr/src/linux/kernel/workqueue.c:884)
[310363.654896] __schedule (/usr/src/linux/kernel/sched/core.c:3326)
[310363.660538] schedule
(/usr/src/linux/./arch/x86/include/asm/bitops.h:311 (discriminator 1)
/usr/src/linux/include/linux/thread_info.h:92 (discriminator 1)
/usr/src/linux/include/linux/sched.h:3237 (discriminator 1)
/usr/src/linux/kernel/sched/core.c:3378 (discriminator 1))
[310363.665836] do_exit (/usr/src/linux/kernel/exit.c:829)
[310363.671212] oops_end (/usr/src/linux/arch/x86/kernel/dumpstack.c:232)
[310363.676505] die (/usr/src/linux/arch/x86/kernel/dumpstack.c:309)
[310363.681371] do_trap (/usr/src/linux/arch/x86/kernel/traps.c:192
/usr/src/linux/arch/x86/kernel/traps.c:238)
[310363.686663] do_error_trap (/usr/src/linux/arch/x86/kernel/traps.c:278)
[310363.692396] ? rbd_dev_header_info
(/usr/src/linux/drivers/block/rbd.c:4638) rbd
[310363.699514] ? irq_work_queue (/usr/src/linux/kernel/irq_work.c:98)
[310363.705505] ? wake_up_klogd (/usr/src/linux/kernel/printk/printk.c:2753)
[310363.711407] ? console_unlock (/usr/src/linux/kernel/printk/printk.c:2340)
[310363.717569] do_invalid_op (/usr/src/linux/arch/x86/kernel/traps.c:288)
[310363.723298] invalid_op (/usr/src/linux/arch/x86/entry/entry_64.S:761)
[310363.728777] ? rbd_dev_header_info
(/usr/src/linux/drivers/block/rbd.c:4638) rbd
[310363.735896] ? update_curr (/usr/src/linux/kernel/sched/stats.h:261
/usr/src/linux/kernel/sched/fair.c:779)
[310363.741716] ? dequeue_task_fair (/usr/src/linux/kernel/sched/fair.c:4561)
[310363.748226] rbd_dev_refresh (/usr/src/linux/drivers/block/rbd.c:3584) rbd
[310363.754649] rbd_watch_cb (/usr/src/linux/drivers/block/rbd.c:3094) rbd
[310363.760814] do_watch_notify
(/usr/src/linux/net/ceph/osd_client.c:2102) libceph
[310363.767586] process_one_work
(/usr/src/linux/include/linux/compiler.h:222
/usr/src/linux/./arch/x86/include/asm/atomic.h:26
/usr/src/linux/include/linux/jump_label.h:172
/usr/src/linux/include/linux/jump_label.h:182
/usr/src/linux/include/trace/events/workqueue.h:111
/usr/src/linux/kernel/workqueue.c:2101)
[310363.773746] worker_thread
(/usr/src/linux/include/linux/compiler.h:222
/usr/src/linux/include/linux/list.h:189
/usr/src/linux/kernel/workqueue.c:2231)
[310363.779562] ? __schedule (/usr/src/linux/kernel/sched/core.c:2859
/usr/src/linux/kernel/sched/core.c:3347)
[310363.785374] ? process_one_work (/usr/src/linux/kernel/workqueue.c:2173)
[310363.791716] ? process_one_work (/usr/src/linux/kernel/workqueue.c:2173)
[310363.798058] kthread (/usr/src/linux/kernel/kthread.c:209)
[310363.803264] ret_from_fork (/usr/src/linux/arch/x86/entry/entry_64.S:390)
[310363.808993] ? kthread_create_on_node (/usr/src/linux/kernel/kthread.c:178)
[310363.815849] Code: 02 00 00 00 e8 a1 fd ff ff 5d c3 0f 1f 44 00 00
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 60 04 00 00 55
48 89 e5 5d <48> 8b 40 d8 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
00 55
All code
========
   0: 02 00                 add    (%rax),%al
   2: 00 00                 add    %al,(%rax)
   4: e8 a1 fd ff ff       callq  0xfffffffffffffdaa
   9: 5d                   pop    %rbp
   a: c3                   retq
   b: 0f 1f 44 00 00       nopl   0x0(%rax,%rax,1)
  10: 66 2e 0f 1f 84 00 00 nopw   %cs:0x0(%rax,%rax,1)
  17: 00 00 00
  1a: 0f 1f 44 00 00       nopl   0x0(%rax,%rax,1)
  1f: 48 8b 87 60 04 00 00 mov    0x460(%rdi),%rax
  26: 55                   push   %rbp
  27: 48 89 e5             mov    %rsp,%rbp
  2a: 5d                   pop    %rbp
  2b:* 48 8b 40 d8           mov    -0x28(%rax),%rax <-- trapping instruction
  2f: c3                   retq
  30: 66 2e 0f 1f 84 00 00 nopw   %cs:0x0(%rax,%rax,1)
  37: 00 00 00
  3a: 0f 1f 44 00 00       nopl   0x0(%rax,%rax,1)
  3f: 55                   push   %rbp

Code starting with the faulting instruction
===========================================
   0: 48 8b 40 d8           mov    -0x28(%rax),%rax
   4: c3                   retq
   5: 66 2e 0f 1f 84 00 00 nopw   %cs:0x0(%rax,%rax,1)
   c: 00 00 00
   f: 0f 1f 44 00 00       nopl   0x0(%rax,%rax,1)
  14: 55                   push   %rbp
[310363.841079] RIP kthread_data (/usr/src/linux/kernel/kthread.c:137)
[310363.847159]  RSP <ffff88030b0eba28>
[310363.850977] CR2: ffffffffffffffd8
[310363.854624] ---[ end trace eca4993be8f8ac80 ]---
[310363.859568] Fixing recursive fault but reboot is needed!

On Tue, Aug 2, 2016 at 11:36 AM, Victor Payno <vpayno@gaikai.com> wrote:
> On a node with osd.14 we got this kernel message.
>
> [Sun Jul 31 01:06:01 2016] md: md127: data-check done.
> [Tue Aug  2 11:15:58 2016] divide error: 0000 [#1] SMP
> [Tue Aug  2 11:15:58 2016] Modules linked in: rbd libceph dns_resolver
> xfs sg 8021q garp mrp x86_pkg_temp_thermal sb_edac edac_core ioatdma
> ipmi_ssif tpm_tis ext4 mbcache jbd2 raid1 ixgbe dca crc32c_intel mdio
> tg3 megaraid_sas
> [Tue Aug  2 11:15:58 2016] CPU: 4 PID: 9319 Comm: ceph-osd Not tainted
> 4.4.12-vanilla-base-1 #1
> [Tue Aug  2 11:15:58 2016] Hardware name: Dell Inc. PowerEdge
> R730xd/0599V5, BIOS 1.3.6 06/03/2015
> [Tue Aug  2 11:15:58 2016] task: ffff880036537080 ti: ffff88039d84c000
> task.ti: ffff88039d84c000
> [Tue Aug  2 11:15:58 2016] RIP: 0010:[<ffffffff81166b31>]
> [<ffffffff81166b31>] task_numa_find_cpu+0x1b1/0x5f0
> [Tue Aug  2 11:15:58 2016] RSP: 0000:ffff88039d84fc30  EFLAGS: 00010257
> [Tue Aug  2 11:15:58 2016] RAX: 0000000000000000 RBX: 000000000000000b
> RCX: 0000000000000000
> [Tue Aug  2 11:15:58 2016] RDX: 0000000000000000 RSI: 0000000000000001
> RDI: ffff88071de3b300
> [Tue Aug  2 11:15:58 2016] RBP: ffff88039d84fcc0 R08: ffff881299278000
> R09: 0000000000000000
> [Tue Aug  2 11:15:58 2016] R10: fffffffffffffdcd R11: 0000000000000019
> R12: 0000000000000253
> [Tue Aug  2 11:15:58 2016] R13: 0000000000000014 R14: fffffffffffffdf0
> R15: ffff880036537080
> [Tue Aug  2 11:15:58 2016] FS:  00007fe293b28700(0000)
> GS:ffff88103f680000(0000) knlGS:0000000000000000
> [Tue Aug  2 11:15:58 2016] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Tue Aug  2 11:15:58 2016] CR2: 0000559fdc257d10 CR3: 000000141238d000
> CR4: 00000000001406e0
> [Tue Aug  2 11:15:58 2016] Stack:
> [Tue Aug  2 11:15:58 2016]  0000000000016ac0 fffffffffffffdf5
> 0000000000000253 ffff881299278000
> [Tue Aug  2 11:15:58 2016]  ffff881299278000 ffffffffffffffd5
> 0000000000000019 ffff880036537080
> [Tue Aug  2 11:15:58 2016]  ffff88039d84fcc0 00000000000000ca
> 00000000000000ee 0000000000000015
> [Tue Aug  2 11:15:58 2016] Call Trace:
> [Tue Aug  2 11:15:58 2016]  [<ffffffff8116722e>] ? task_numa_migrate+0x2be/0x8d0
> [Tue Aug  2 11:15:58 2016]  [<ffffffff8116a684>] ? task_numa_fault+0xab4/0xd50
> [Tue Aug  2 11:15:58 2016]  [<ffffffff81169a42>] ?
> should_numa_migrate_memory+0x52/0x120
> [Tue Aug  2 11:15:58 2016]  [<ffffffff81246ca4>] ? mpol_misplaced+0xd4/0x180
> [Tue Aug  2 11:15:58 2016]  [<ffffffff81229b6c>] ? handle_mm_fault+0xe0c/0x1590
> [Tue Aug  2 11:15:58 2016]  [<ffffffff810a1278>] ? __do_page_fault+0x178/0x410
> [Tue Aug  2 11:15:58 2016]  [<ffffffff816b9818>] ? page_fault+0x28/0x30
> [Tue Aug  2 11:15:58 2016] Code: 18 4c 89 ef e8 31 c2 ff ff 49 8b 85
> a8 00 00 00 31 d2 49 0f af 87 00 01 00 00 49 8b 4d 70 4c 8b 6d 20 4c
> 8b 44 24 18 48 83 c1 01 <48> f7 f1 49 89 c7 49 29 c5 4c 03 7d 48 4d 39
> f4 48 8b 4d 78 7e
> [Tue Aug  2 11:15:58 2016] RIP  [<ffffffff81166b31>]
> task_numa_find_cpu+0x1b1/0x5f0
> [Tue Aug  2 11:15:58 2016]  RSP <ffff88039d84fc30>
> [Tue Aug  2 11:15:58 2016] ---[ end trace 7aa8747e90bb7d77 ]---
>
>
> The rest of the OSDs on that node are still responsive but we can't do
> a process listing and the 15 minute load is holding at 350+.
>
>
> A rack of rbd clients kernel crashed (no networking stack but the
> kernels are spamming the serial consoles with this:
>
> [310363.138601] kernel BUG at drivers/block/rbd.c:4638!
> [310363.143843] invalid opcode: 0000 [#1] SMP
> [310363.148204] Modules linked in: rbd libceph sg rpcsec_gss_krb5
> xt_UDPLB(O) xt_nat xt_multiport xt_addrtype iptable_mangle iptable_raw
> iptable_nat nf_nat_ipv4 nf_nat ext4 jbd2 mbcache x86_pkg_temp_thermal
> gkuart(O) usbserial ie31200_edac edac_core tpm_tis raid1 crc32c_intel
> [310363.175783] CPU: 6 PID: 15231 Comm: kworker/u16:1 Tainted: G
>     O    4.7.0-vanilla-ams-3 #1
> [310363.185246] Hardware name: Quanta T6BC-S1N/T6BC, BIOS T6BC2A01 03/26/2014
> [310363.192374] Workqueue: ceph-watch-notify do_watch_notify [libceph]
> [310363.198969] task: ffff880097438d40 ti: ffff88030b0e8000 task.ti:
> ffff88030b0e8000
> [310363.206949] RIP: 0010:[<ffffffffa01731c9>]  [<ffffffffa01731c9>]
> rbd_dev_header_info+0x5a9/0x940 [rbd]
> [310363.216839] RSP: 0018:ffff88030b0ebd30  EFLAGS: 00010286
> [310363.222480] RAX: 0000000000000077 RBX: ffff88030d2ac800 RCX:
> 0000000000000000
> [310363.230114] RDX: 0000000000000077 RSI: ffff88041fd8dd08 RDI:
> ffff88041fd8dd08
> [310363.237747] RBP: ffff88030b0ebd98 R08: 0000000000000030 R09:
> 0000000000000000
> [310363.245391] R10: 0000000000000000 R11: 0000000000000d44 R12:
> ffff88037b105000
> [310363.253089] R13: ffff88030d2ac9b0 R14: 0000000000000000 R15:
> ffff88006e020a00
> [310363.260786] FS:  0000000000000000(0000) GS:ffff88041fd80000(0000)
> knlGS:0000000000000000
> [310363.269377] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [310363.275456] CR2: 00007f8f0800a048 CR3: 00000002afe5f000 CR4:
> 00000000001406e0
> [310363.283090] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [310363.290724] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [310363.298364] Stack:
> [310363.300700]  ffffffff8113a91a ffff880097438d40 ffff88041fd97ef0
> ffff88041fd97ef0
> [310363.308940]  ffff88041fd97ef0 000000000006625c ffff88030b0ebdd8
> ffffffff8113d968
> [310363.317304]  ffff88030d2ac800 ffff88037b105000 ffff88030d2ac9b0
> 0000000000000000
> [310363.325619] Call Trace:
> [310363.328503]  [<ffffffff8113a91a>] ? update_curr+0x8a/0x110
> [310363.334350]  [<ffffffff8113d968>] ? dequeue_task_fair+0x618/0x1150
> [310363.340872]  [<ffffffffa0173591>] rbd_dev_refresh+0x31/0xf0 [rbd]
> [310363.347322]  [<ffffffffa0173719>] rbd_watch_cb+0x29/0xa0 [rbd]
> [310363.353569]  [<ffffffffa013efdc>] do_watch_notify+0x4c/0x80 [libceph]
> [310363.360339]  [<ffffffff811258e9>] process_one_work+0x149/0x3c0
> [310363.366532]  [<ffffffff81125bae>] worker_thread+0x4e/0x490
> [310363.372351]  [<ffffffff8185a9f5>] ? __schedule+0x225/0x6f0
> [310363.378172]  [<ffffffff81125b60>] ? process_one_work+0x3c0/0x3c0
> [310363.384523]  [<ffffffff81125b60>] ? process_one_work+0x3c0/0x3c0
> [310363.390858]  [<ffffffff8112b1e9>] kthread+0xc9/0xe0
> [310363.396065]  [<ffffffff8185e4ff>] ret_from_fork+0x1f/0x40
> [310363.401808]  [<ffffffff8112b120>] ? kthread_create_on_node+0x170/0x170
> [310363.408672] Code: 0b 44 8b 6d b8 e9 1d ff ff ff 48 c7 c1 f0 60 17
> a0 ba 1e 12 00 00 48 c7 c6 90 6e 17 a0 48 c7 c7 20 58 17 a0 31 c0 e8
> 8a fd 07 e1 <0f> 0b 75 14 49 8b 7f 68 41 bd 92 ff ff ff e8 d4 e0 fc ff
> e9 dc
> [310363.433950] RIP  [<ffffffffa01731c9>] rbd_dev_header_info+0x5a9/0x940 [rbd]
> [310363.441329]  RSP <ffff88030b0ebd30>
> [310363.445232] ---[ end trace eca4993be8f8ac7f ]---
> [310363.450313] BUG: unable to handle kernel paging request at ffffffffffffffd8
> [310363.457786] IP: [<ffffffff8112b821>] kthread_data+0x11/0x20
> [310363.463799] PGD 1e0a067 PUD 1e0c067 PMD 0
> [310363.468573] Oops: 0000 [#2] SMP
> [310363.472072] Modules linked in: rbd libceph sg rpcsec_gss_krb5
> xt_UDPLB(O) xt_nat xt_multiport xt_addrtype iptable_mangle iptable_raw
> iptable_nat nf_nat_ipv4 nf_nat ext4 jbd2 mbcache x86_pkg_temp_thermal
> gkuart(O) usbserial ie31200_edac edac_core tpm_tis raid1 crc32c_intel
> [310363.499255] CPU: 6 PID: 15231 Comm: kworker/u16:1 Tainted: G
> D    O    4.7.0-vanilla-ams-3 #1
> [310363.508717] Hardware name: Quanta T6BC-S1N/T6BC, BIOS T6BC2A01 03/26/2014
> [310363.515845] task: ffff880097438d40 ti: ffff88030b0e8000 task.ti:
> ffff88030b0e8000
> [310363.523827] RIP: 0010:[<ffffffff8112b821>]  [<ffffffff8112b821>]
> kthread_data+0x11/0x20
> [310363.532444] RSP: 0018:ffff88030b0eba28  EFLAGS: 00010002
> [310363.538110] RAX: 0000000000000000 RBX: ffff88041fd97e80 RCX:
> 0000000000000006
> [310363.545750] RDX: ffff88040f005000 RSI: ffff880097438d40 RDI:
> ffff880097438d40
> [310363.553390] RBP: ffff88030b0eba30 R08: 0000000000000000 R09:
> 0000000000001000
> [310363.561030] R10: 0000000000000000 R11: ffffea0003654801 R12:
> 0000000000017e80
> [310363.568671] R13: 0000000000000000 R14: ffff880097439200 R15:
> ffff880097438d40
> [310363.576308] FS:  0000000000000000(0000) GS:ffff88041fd80000(0000)
> knlGS:0000000000000000
> [310363.584926] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [310363.590997] CR2: 0000000000000028 CR3: 00000002afe5f000 CR4:
> 00000000001406e0
> [310363.598650] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [310363.606285] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [310363.613923] Stack:
> [310363.616386]  ffffffff8112645e ffff88030b0eba78 ffffffff8185ab3e
> ffff880097438d40
> [310363.624653]  ffff88030b0eba90 ffff88030b0ec000 ffff88030b0ebad0
> ffff88030b0eb6e8
> [310363.632888]  ffff88040d5c8000 0000000000000000 ffff88030b0eba90
> ffffffff8185aef5
> [310363.645877] Call Trace:
> [310363.648649]  [<ffffffff8112645e>] ? wq_worker_sleeping+0xe/0x90
> [310363.654896]  [<ffffffff8185ab3e>] __schedule+0x36e/0x6f0
> [310363.660538]  [<ffffffff8185aef5>] schedule+0x35/0x80
> [310363.665836]  [<ffffffff81110ff9>] do_exit+0x739/0xb50
> [310363.671212]  [<ffffffff8108833c>] oops_end+0x9c/0xd0
> [310363.676505]  [<ffffffff810887ab>] die+0x4b/0x70
> [310363.681371]  [<ffffffff81085b26>] do_trap+0xb6/0x150
> [310363.686663]  [<ffffffff81085d87>] do_error_trap+0x77/0xe0
> [310363.692396]  [<ffffffffa01731c9>] ? rbd_dev_header_info+0x5a9/0x940 [rbd]
> [310363.699514]  [<ffffffff811d7a3d>] ? irq_work_queue+0x6d/0x80
> [310363.705505]  [<ffffffff811575d4>] ? wake_up_klogd+0x34/0x40
> [310363.711407]  [<ffffffff81157aa6>] ? console_unlock+0x4c6/0x510
> [310363.717569]  [<ffffffff810863c0>] do_invalid_op+0x20/0x30
> [310363.723298]  [<ffffffff8185fb6e>] invalid_op+0x1e/0x30
> [310363.728777]  [<ffffffffa01731c9>] ? rbd_dev_header_info+0x5a9/0x940 [rbd]
> [310363.735896]  [<ffffffff8113a91a>] ? update_curr+0x8a/0x110
> [310363.741716]  [<ffffffff8113d968>] ? dequeue_task_fair+0x618/0x1150
> [310363.748226]  [<ffffffffa0173591>] rbd_dev_refresh+0x31/0xf0 [rbd]
> [310363.754649]  [<ffffffffa0173719>] rbd_watch_cb+0x29/0xa0 [rbd]
> [310363.760814]  [<ffffffffa013efdc>] do_watch_notify+0x4c/0x80 [libceph]
> [310363.767586]  [<ffffffff811258e9>] process_one_work+0x149/0x3c0
> [310363.773746]  [<ffffffff81125bae>] worker_thread+0x4e/0x490
> [310363.779562]  [<ffffffff8185a9f5>] ? __schedule+0x225/0x6f0
> [310363.785374]  [<ffffffff81125b60>] ? process_one_work+0x3c0/0x3c0
> [310363.791716]  [<ffffffff81125b60>] ? process_one_work+0x3c0/0x3c0
> [310363.798058]  [<ffffffff8112b1e9>] kthread+0xc9/0xe0
> [310363.803264]  [<ffffffff8185e4ff>] ret_from_fork+0x1f/0x40
> [310363.808993]  [<ffffffff8112b120>] ? kthread_create_on_node+0x170/0x170
> [310363.815849] Code: 02 00 00 00 e8 a1 fd ff ff 5d c3 0f 1f 44 00 00
> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 60 04 00 00 55
> 48 89 e5 5d <48> 8b 40 d8 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
> 00 55
> [310363.841079] RIP  [<ffffffff8112b821>] kthread_data+0x11/0x20
> [310363.847159]  RSP <ffff88030b0eba28>
> [310363.850977] CR2: ffffffffffffffd8
> [310363.854624] ---[ end trace eca4993be8f8ac80 ]---
> [310363.859568] Fixing recursive fault but reboot is needed!
>
>
> Unfortunately these weren't getting logged to disk at the time the
> crash happened.
>
>
> In the logs for osd.14 I found this on 7/30:
>
>
>
>
> 2016-07-30 02:31:20.573018 7fe28d73f700  0 -- 172.20.2.63:6802/51944
>>> 172.20.2.63:6818/57494 pipe(0x559fb7dd7000 sd=143 :6802 s=0 pgs=0
> cs=0 l=0 c=0x559f54624580).accept connect_seq 4 vs existing 3 state
> standby
> 2016-07-30 02:32:48.446507 7fe2912dd700  0 bad crc in data 2422823894
> != exp 1069346241
> 559f3d5418c02:32:48.464973 7fe2c37f0700  0 -- 10.10.2.63:6802/51944
> submit_message osd_op_reply(5438
> rbd_data.1d22311949ab7a.0000000000000028 [set-alloc-hint object_size
> 4194304 write_size 4194304,write 106496~4096] v107879'7535 uv7535
> ondisk = 0) v6 remote, 10.9.5.23:0/574015403, failed lossy con,
> dropping message 0
> 2016-07-30 02:38:57.432169 7fe29c34c700  0 -- 172.20.2.63:6802/51944
>>> 172.20.3.63:6812/9319 pipe(0x559f6308c000 sd=236 :47180 s=2 pgs=10
> cs=1 l=0 c=0x559f29944c60).fault with nothing to send, going to
> standby
>
>
> The rest of the messages on 08/02 look like this:
>
> 2016-08-02 08:53:21.305431 7fe2ae49e700  0 log_channel(cluster) log
> [INF] : 1.313 scrub ok
> 2016-08-02 10:00:55.230664 7fe2aec9f700  0 log_channel(cluster) log
> [INF] : 2.30d scrub starts
> 2016-08-02 10:00:55.232653 7fe2aec9f700  0 log_channel(cluster) log
> [INF] : 2.30d scrub ok
> 2016-08-02 11:18:05.074495 7fe2ab498700 -1 osd.14 114237
> heartbeat_check: no reply from osd.6 since back 2016-08-02
> 11:17:44.568097 front 2016-08-02 11:18:00.972352 (cutoff 2016-08-02
> 11:17:45.074414)
> 2016-08-02 11:18:05.458396 7fe2c964a700 -1 osd.14 114237
> heartbeat_check: no reply from osd.6 since back 2016-08-02
> 11:17:44.568097 front 2016-08-02 11:18:05.073552 (cutoff 2016-08-02
> 11:17:45.458393)
> 2016-08-02 11:18:06.458605 7fe2c964a700 -1 osd.14 114237
> heartbeat_check: no reply from osd.6 since back 2016-08-02
> 11:17:44.568097 front 2016-08-02 11:18:05.073552 (cutoff 2016-08-02
> 11:17:46.458602)
> ...
> 2016-08-02 11:19:35.404897 7fe2ab498700 -1 osd.14 114245
> heartbeat_check: no reply from osd.6 since back 2016-08-02
> 11:17:44.568097 front 2016-08-02 11:19:30.702775 (cutoff 2016-08-02
> 11:19:15.404896)
> 2016-08-02 11:19:35.472022 7fe2c964a700 -1 osd.14 114245
> heartbeat_check: no reply from osd.6 since back 2016-08-02
> 11:17:44.568097 front 2016-08-02 11:19:35.404031 (cutoff 2016-08-02
> 11:19:15.472020)
> EOF
>
>
> --
> Victor Payno
> ビクター·ペイン
>
> Sr. Release Engineer
> シニアリリースエンジニア
>
>
>
> Gaikai, a Sony Computer Entertainment Company   ∆○×□
> ガイカイ、ソニー・コンピュータエンタテインメント傘下会社
> 65 Enterprise
> Aliso Viejo, CA 92656 USA
>
> Web: www.gaikai.com
> Email: vpayno@gaikai.com
> Phone: (949) 330-6850
