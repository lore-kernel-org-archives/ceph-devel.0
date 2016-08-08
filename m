From: Victor Payno <vpayno@gaikai.com>
Subject: Re: linux 4.7.0 rbd client kernel panic when OSD process was killed
 by OOM
Date: Mon, 8 Aug 2016 13:16:18 -0700
Message-ID: <CALXUmNTVdqn3vBirg-=+a=bq=nAhV=LCR-eAAO4BRyyL6XYpQQ@mail.gmail.com>
References: <CALXUmNQ91fBrvKQJOeyfT_BZXLikEyDOA9tOMH54pt3NDU+taQ@mail.gmail.com>
 <CAOi1vP8_D6FwQPzGuqsiRv=be3Zv4U7kmO-HjcQEVehD8sYwHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:33026 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbcHHUQj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Aug 2016 16:16:39 -0400
Received: by mail-io0-f170.google.com with SMTP id 38so368462451iol.0
        for <ceph-devel@vger.kernel.org>; Mon, 08 Aug 2016 13:16:39 -0700 (PDT)
In-Reply-To: <CAOi1vP8_D6FwQPzGuqsiRv=be3Zv4U7kmO-HjcQEVehD8sYwHA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick McLean <patrickm@gaikai.com>, Roderick Colenbrander <roderick@gaikai.com>, Cliff Pajaro <cpajaro@gaikai.com>, Ceph Development <ceph-devel@vger.kernel.org>

ping doesn't respond, usually when I see a non-kernel panic even if
SSH is unresponsive, the kernel still responds to pings and
applications ports are still open but not usually working. That might
just be on older kernels now.

On Mon, Aug 8, 2016 at 1:14 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Mon, Aug 8, 2016 at 9:57 PM, Victor Payno <vpayno@gaikai.com> wrote:
>> We have another problem where an RBD client was killed when an OSD was
>> killed by the OOM on a server. The servers have 4.4.16 kernels.
>>
>> ams2 login: [789881.620147] ------------[ cut here ]------------
>> [789881.625094] kernel BUG at drivers/block/rbd.c:4638!
>> [789881.630311] invalid opcode: 0000 [#1] SMP
>> [789881.634650] Modules linked in: rbd libceph sg rpcsec_gss_krb5
>> xt_nat xt_UDPLB(O) xt_multiport xt_addrtype iptable_mangle iptable_raw
>> iptable_nat nf_nat_ipv4 nf_nat ext4 jbd2 mbcache x86_pkg_temp_thermal
>> gkuart(O) usbserial ie31200_edac edac_core tpm_tis raid1 crc32c_intel
>> [789881.661718] CPU: 4 PID: 4111 Comm: kworker/u16:0 Tainted: G
>>    O    4.7.0-vanilla-ams-3 #1
>> [789881.671091] Hardware name: Quanta T6BC-S1N/T6BC, BIOS T6BC2A01 03/26/2014
>> [789881.678212] Workqueue: ceph-watch-notify do_watch_notify [libceph]
>> [789881.684814] task: ffff88032069ea00 ti: ffff8803f0c90000 task.ti:
>> ffff8803f0c90000
>> [789881.692802] RIP: 0010:[<ffffffffa016d1c9>]  [<ffffffffa016d1c9>]
>> rbd_dev_header_info+0x5a9/0x940 [rbd]
>> [789881.702702] RSP: 0018:ffff8803f0c93d30  EFLAGS: 00010286
>> [789881.708344] RAX: 0000000000000077 RBX: ffff8802a6a63800 RCX:
>> 0000000000000000
>> [789881.715985] RDX: 0000000000000077 RSI: ffff88041fd0dd08 RDI:
>> ffff88041fd0dd08
>> [789881.723625] RBP: ffff8803f0c93d98 R08: 0000000000000030 R09:
>> 0000000000000000
>> [789881.731261] R10: 0000000000000000 R11: 0000000000004479 R12:
>> ffff8800d6eaf000
>> [789881.738899] R13: ffff8802a6a639b0 R14: 0000000000000000 R15:
>> ffff880327e6e780
>> [789881.746533] FS:  0000000000000000(0000) GS:ffff88041fd00000(0000)
>> knlGS:0000000000000000
>> [789881.755120] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [789881.761197] CR2: 00007fbb18242838 CR3: 0000000001e07000 CR4:
>> 00000000001406e0
>> [789881.768846] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [789881.776482] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [789881.784118] Stack:
>> [789881.786457]  ffffffff8113a91a ffff88032069ea00 ffff88041fd17ef0
>> ffff88041fd17ef0
>> [789881.794713]  ffff88041fd17ef0 0000000000030289 ffff8803f0c93dd8
>> ffffffff8113d968
>> [789881.802965]  ffff8802a6a63800 ffff8800d6eaf000 ffff8802a6a639b0
>> 0000000000000000
>> [789881.811207] Call Trace:
>> [789881.813988]  [<ffffffff8113a91a>] ? update_curr+0x8a/0x110
>> [789881.819810]  [<ffffffff8113d968>] ? dequeue_task_fair+0x618/0x1150
>> [789881.826321]  [<ffffffffa016d591>] rbd_dev_refresh+0x31/0xf0 [rbd]
>> [789881.832760]  [<ffffffffa016d719>] rbd_watch_cb+0x29/0xa0 [rbd]
>> [789881.838930]  [<ffffffffa0138fdc>] do_watch_notify+0x4c/0x80 [libceph]
>> [789881.845706]  [<ffffffff811258e9>] process_one_work+0x149/0x3c0
>> [789881.856639]  [<ffffffff81125bae>] worker_thread+0x4e/0x490
>> [789881.862453]  [<ffffffff81125b60>] ? process_one_work+0x3c0/0x3c0
>> [789881.868823]  [<ffffffff8112b1e9>] kthread+0xc9/0xe0
>> [789881.874033]  [<ffffffff8185e4ff>] ret_from_fork+0x1f/0x40
>> [789881.879764]  [<ffffffff8112b120>] ? kthread_create_on_node+0x170/0x170
>> [789881.886618] Code: 0b 44 8b 6d b8 e9 1d ff ff ff 48 c7 c1 f0 00 17
>> a0 ba 1e 12 00 00 48 c7 c6 90 0e 17 a0 48 c7 c7 20 f8 16 a0 31 c0 e8
>> 8a 5d 08 e1 <0f> 0b 75 14 49 8b 7f 68 41 bd 92 ff ff ff e8 d4 e0 fc ff
>> e9 dc
>> [789881.911744] RIP  [<ffffffffa016d1c9>] rbd_dev_header_info+0x5a9/0x940 [rbd]
>> [789881.919116]  RSP <ffff8803f0c93d30>
>> [789881.922989] ---[ end trace 12b8d1c2ed74d6c1 ]---
>> [789881.927971] BUG: unable to handle kernel paging request at ffffffffffffffd8
>> [789881.935435] IP: [<ffffffff8112b821>] kthread_data+0x11/0x20
>> [789881.941427] PGD 1e0a067 PUD 1e0c067 PMD 0
>> [789881.946117] Oops: 0000 [#2] SMP
>> [789881.949591] Modules linked in: rbd libceph sg rpcsec_gss_krb5
>> xt_nat xt_UDPLB(O) xt_multiport xt_addrtype iptable_mangle iptable_raw
>> iptable_nat nf_nat_ipv4 nf_nat ext4 jbd2 mbcache x86_pkg_temp_thermal
>> gkuart(O) usbserial ie31200_edac edac_core tpm_tis raid1 crc32c_intel
>> [789881.976900] CPU: 4 PID: 4111 Comm: kworker/u16:0 Tainted: G      D
>>    O    4.7.0-vanilla-ams-3 #1
>> [789881.986280] Hardware name: Quanta T6BC-S1N/T6BC, BIOS T6BC2A01 03/26/2014
>> [789881.993410] task: ffff88032069ea00 ti: ffff8803f0c90000 task.ti:
>> ffff8803f0c90000
>> [789882.001411] RIP: 0010:[<ffffffff8112b821>]  [<ffffffff8112b821>]
>> kthread_data+0x11/0x20
>> [789882.010024] RSP: 0018:ffff8803f0c93a28  EFLAGS: 00010002
>> [789882.015682] RAX: 0000000000000000 RBX: ffff88041fd17e80 RCX:
>> 0000000000000004
>> [789882.023342] RDX: ffff88040f005000 RSI: ffff88032069ea00 RDI:
>> ffff88032069ea00
>> [789882.030996] RBP: ffff8803f0c93a30 R08: 0000000000000000 R09:
>> 0000000000079800
>> [789882.038645] R10: 0000000000000001 R11: 0000000000000001 R12:
>> 0000000000017e80
>> [789882.046288] R13: 0000000000000000 R14: ffff88032069eec0 R15:
>> ffff88032069ea00
>> [789882.053926] FS:  0000000000000000(0000) GS:ffff88041fd00000(0000)
>> knlGS:0000000000000000
>> [789882.062524] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [789882.068603] CR2: 0000000000000028 CR3: 0000000001e07000 CR4:
>> 00000000001406e0
>> [789882.076261] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [789882.083920] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [789882.091577] Stack:
>> [789882.093935]  ffffffff8112645e ffff8803f0c93a78 ffffffff8185ab3e
>> ffff88032069ea00
>> [789882.102194]  ffff8803f0c93a78 ffff8803f0c94000 ffff8803f0c93ad0
>> ffff8803f0c936e8
>> [789882.110438]  ffff88040d5c8000 0000000000000000 ffff8803f0c93a90
>> ffffffff8185aef5
>> [789882.118689] Call Trace:
>> [789882.121484]  [<ffffffff8112645e>] ? wq_worker_sleeping+0xe/0x90
>> [789882.127752]  [<ffffffff8185ab3e>] __schedule+0x36e/0x6f0
>> [789882.133411]  [<ffffffff8185aef5>] schedule+0x35/0x80
>> [789882.138712]  [<ffffffff81110ff9>] do_exit+0x739/0xb50
>> [789882.144098]  [<ffffffff8108833c>] oops_end+0x9c/0xd0
>> [789882.149400]  [<ffffffff810887ab>] die+0x4b/0x70
>> [789882.154276]  [<ffffffff81085b26>] do_trap+0xb6/0x150
>> [789882.159583]  [<ffffffff81085d87>] do_error_trap+0x77/0xe0
>> [789882.165322]  [<ffffffffa016d1c9>] ? rbd_dev_header_info+0x5a9/0x940 [rbd]
>> [789882.172446]  [<ffffffff811d7a3d>] ? irq_work_queue+0x6d/0x80
>> [789882.178441]  [<ffffffff811575d4>] ? wake_up_klogd+0x34/0x40
>> [789882.184363]  [<ffffffff81157aa6>] ? console_unlock+0x4c6/0x510
>> [789882.190532]  [<ffffffff810863c0>] do_invalid_op+0x20/0x30
>> [789882.196265]  [<ffffffff8185fb6e>] invalid_op+0x1e/0x30
>> [789882.201740]  [<ffffffffa016d1c9>] ? rbd_dev_header_info+0x5a9/0x940 [rbd]
>> [789882.208866]  [<ffffffff8113a91a>] ? update_curr+0x8a/0x110
>> [789882.214694]  [<ffffffff8113d968>] ? dequeue_task_fair+0x618/0x1150
>> [789882.221225]  [<ffffffffa016d591>] rbd_dev_refresh+0x31/0xf0 [rbd]
>> [789882.227662]  [<ffffffffa016d719>] rbd_watch_cb+0x29/0xa0 [rbd]
>> [789882.233855]  [<ffffffffa0138fdc>] do_watch_notify+0x4c/0x80 [libceph]
>> [789882.240647]  [<ffffffff811258e9>] process_one_work+0x149/0x3c0
>> [789882.246811]  [<ffffffff81125bae>] worker_thread+0x4e/0x490
>> [789882.252629]  [<ffffffff81125b60>] ? process_one_work+0x3c0/0x3c0
>> [789882.258969]  [<ffffffff8112b1e9>] kthread+0xc9/0xe0
>> [789882.264182]  [<ffffffff8185e4ff>] ret_from_fork+0x1f/0x40
>> [789882.269917]  [<ffffffff8112b120>] ? kthread_create_on_node+0x170/0x170
>> [789882.276784] Code: 02 00 00 00 e8 a1 fd ff ff 5d c3 0f 1f 44 00 00
>> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 60 04 00 00 55
>> 48 89 e5 5d <48> 8b 40 d8 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
>> 00 55
>> [789882.301941] RIP  [<ffffffff8112b821>] kthread_data+0x11/0x20
>> [789882.308016]  RSP <ffff8803f0c93a28>
>> [789882.311847] CR2: ffffffffffffffd8
>> [789882.315505] ---[ end trace 12b8d1c2ed74d6c2 ]---
>> [789882.320462] Fixing recursive fault but reboot is needed!
>
> That's the same one you've reported in the "ceph osd kernel divide
> error", right?  I've filed http://tracker.ceph.com/issues/16963 and
> should get to it later this week.
>
> What did you mean by "no networking stack" in that thread?
>
> Thanks,
>
>                 Ilya



-- 
Victor Payno
ビクター·ペイン

Sr. Release Engineer
シニアリリースエンジニア



Gaikai, a Sony Computer Entertainment Company   ∆○×□
ガイカイ、ソニー・コンピュータエンタテインメント傘下会社
65 Enterprise
Aliso Viejo, CA 92656 USA

Web: www.gaikai.com
Email: vpayno@gaikai.com
Phone: (949) 330-6850
