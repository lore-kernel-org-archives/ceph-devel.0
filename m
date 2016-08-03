From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: ceph osd kernel divide error
Date: Wed, 3 Aug 2016 11:38:01 +0200
Message-ID: <CAOi1vP9c9ZXkCVx-4YaVrCJNb6+iFwpyTNDo5+euAtvJhvMruA@mail.gmail.com>
References: <CALXUmNR27AxBz53UDajf3eKq0xYGoHV7xiPDRmnKhxZ-mL0bgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36823 "EHLO
	mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757731AbcHCKlb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2016 06:41:31 -0400
Received: by mail-ua0-f170.google.com with SMTP id j59so149179481uaj.3
        for <ceph-devel@vger.kernel.org>; Wed, 03 Aug 2016 03:41:31 -0700 (PDT)
In-Reply-To: <CALXUmNR27AxBz53UDajf3eKq0xYGoHV7xiPDRmnKhxZ-mL0bgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Payno <vpayno@gaikai.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Patrick McLean <patrickm@gaikai.com>, Roderick Colenbrander <roderick@gaikai.com>, Cliff Pajaro <cpajaro@gaikai.com>

On Tue, Aug 2, 2016 at 8:36 PM, Victor Payno <vpayno@gaikai.com> wrote:
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

This is a known kernel scheduler bug, nothing to do with ceph.  It's
fixed in 4.4.16 - see http://tracker.ceph.com/issues/16579.

>
>
> A rack of rbd clients kernel crashed (no networking stack but the
> kernels are spamming the serial consoles with this:

What do you mean by "a rack of rbd clients" and "no networking stack"?

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

This is

    rbd_assert(rbd_image_format_valid(rbd_dev->image_format))

which amounts to

    (image_format == 1 || rbimage_format == 2)

Can you tell us more about this crash?  When did it occur, what sort of
test was being run, etc?

Thanks,

                Ilya
