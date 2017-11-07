From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 2/2] rbd: get rid of rbd_mapping::read_only
Date: Tue, 7 Nov 2017 17:56:51 +0100
Message-ID: <CAOi1vP87GtgauS4OXGXDeBXD3ce_CM+N3p_j8+6XXDsG1TYgwQ@mail.gmail.com>
References: <1509983370-1853-1-git-send-email-idryomov@gmail.com>
 <1509983370-1853-2-git-send-email-idryomov@gmail.com> <20171107142627.0d66f97b@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:46953 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758204AbdKGQ4w (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Nov 2017 11:56:52 -0500
Received: by mail-io0-f194.google.com with SMTP id 101so2845244ioj.3
        for <ceph-devel@vger.kernel.org>; Tue, 07 Nov 2017 08:56:52 -0800 (PST)
In-Reply-To: <20171107142627.0d66f97b@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 7, 2017 at 2:26 PM, David Disseldorp <ddiss@suse.de> wrote:
> Hi Ilya,
>
> On Mon,  6 Nov 2017 16:49:30 +0100, Ilya Dryomov wrote:
>
>> -     /* Only reads are allowed to a read-only device */
>> -
>> -     if (op_type != OBJ_OP_READ) {
>> -             if (rbd_dev->mapping.read_only) {
>> -                     result = -EROFS;
>> -                     goto err_rq;
>> -             }
>> -             rbd_assert(rbd_dev->spec->snap_id == CEPH_NOSNAP);
>> -     }
>> +     rbd_assert(op_type == OBJ_OP_READ ||
>> +                rbd_dev->spec->snap_id == CEPH_NOSNAP);
>
> AFAICT, the block layer can still queue non-read requests, despite the
> block device read-only policy flag, so I think an -EROFS handler needs
> to stay.
> The following was run on mainline (e4880bc5dfb1f02b152e62a894b5c6f3e995)
> with these two patches applied:
>
> RBD mapped at: /dev/rbd/rbd/img@snap
> rapido1:/# blockdev --getro /dev/rbd/rbd/img@snap
> 1
> rapido1:/# mkfs.xfs /dev/rbd/rbd/img@snap
> [   12.346216]
> [   12.346216] Assertion failure in rbd_queue_workfn() at line 4028:
> [   12.346216]
> [   12.346216]  rbd_assert(op_type == OBJ_OP_READ || rbd_dev->spec->snap_id == CEPH_NOSNAP);
> [   12.346216]
> [   12.347529] ------------[ cut here ]------------
> [   12.347910] kernel BUG at drivers/block/rbd.c:4028!
> [   12.348479] invalid opcode: 0000 [#1] SMP
> [   12.349044] Modules linked in:
> [   12.349499] CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 4.14.0-rc8+ #405
> [   12.350407] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
> [   12.352001] Workqueue: rbd rbd_queue_workfn
> [   12.352498] task: ffff88001d27b480 task.stack: ffffc90000090000
> [   12.353058] RIP: 0010:rbd_queue_workfn+0x4f9/0x500
> [   12.353527] RSP: 0018:ffffc90000093e08 EFLAGS: 00010282
> [   12.354036] RAX: 0000000000000086 RBX: ffff88001a7c7980 RCX: ffffffff81829398
> [   12.354890] RDX: 0000000000000001 RSI: 0000000000000086 RDI: ffffffff819f9f6c
> [   12.355580] RBP: ffffc90000093e60 R08: 00000000fffffffe R09: 000000000000048f
> [   12.356285] R10: 0000000000000005 R11: 000000000000048e R12: ffff88001ca6f000
> [   12.356964] R13: 0000000000000000 R14: 0000000000000002 R15: ffff88001a7c7ac0
> [   12.357650] FS:  0000000000000000(0000) GS:ffff88001e500000(0000) knlGS:0000000000000000
> [   12.358443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.359031] CR2: 00007fcd19a14000 CR3: 000000001f069000 CR4: 00000000000006a0
> [   12.359806] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   12.360604] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   12.361397] Call Trace:
> [   12.361686]  process_one_work+0x11e/0x280
> [   12.362145]  worker_thread+0x45/0x3b0
> [   12.362564]  kthread+0xff/0x140
> [   12.362935]  ? process_one_work+0x280/0x280
> [   12.363409]  ? kthread_create_on_node+0x40/0x40
> [   12.363936]  ret_from_fork+0x22/0x30
> [   12.364338] Code: 85 e1 fb ff ff e9 99 fb ff ff 48 c7 c1 e8 af 71 81 ba bc 0f 00 00 48 c7 c6 f0 bb 64 81 48 c7 c7 40 9d 71 81 31 c0 e8 65 df d5 ff <0f> 0b 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 41 54 49 89 fc 53
> [   12.366440] RIP: rbd_queue_workfn+0x4f9/0x500 RSP: ffffc90000093e08
> [   12.367147] ---[ end trace 75c22000d1a0b248 ]---

Hi David,

Heh, apparently I only tested writes and didn't do discards...  Writes
go through blkdev_write_iter() but zeroout/discards seem to rely solely
on FMODE_WRITE checks, which the block layer doesn't enforce.

I'd rather try to fix it in the block layer before working around it in
krbd.  I'll work up a patch tomorrow.

Thanks,

                Ilya
