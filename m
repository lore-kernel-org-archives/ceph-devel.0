From: Alex Elder <elder@inktank.com>
Subject: Re: Fwd: rbd kernel module fail
Date: Tue, 13 Nov 2012 07:19:40 -0600
Message-ID: <50A248EC.408@inktank.com>
References: <CAHULbCn+bdCHY3jm7Co+p3edQN5+wN6ACr_B8E1wwgFZ3cPpMg@mail.gmail.com> <CAHULbCnGJ1uFW=WHLnP==jO_HOR6pEjHeVOffPjOcEc-QhErrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37997 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab2KMNTe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 08:19:34 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so10629379iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 05:19:34 -0800 (PST)
In-Reply-To: <CAHULbCnGJ1uFW=WHLnP==jO_HOR6pEjHeVOffPjOcEc-QhErrA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ruslan usifov <ruslan.usifov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 11/13/2012 05:54 AM, ruslan usifov wrote:
> Hello
> 
> I test ceph cluster on VmWare machines (3 nodes in cluster) to make
> rbd scalable block device, and have troubles when try to map rbd image
> to device, i got follow message in kernel.log

I haven't looked into this really yet, but this is a relatively
old version of rbd.  Current rbd does not use /dev/rbd0 (which
is evidently being reused in this case, or at least that's why
the error occurred).

I'll look a little closer later.  I would be very interested
to know if doing the same thing with current code exposes a
similar problem, or whether you are hitting a problem that
has been fixed.

					-Alex

> 
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319319] ------------[
> cut here ]------------
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319437] kernel BUG at
> /build/buildd/linux-3.2.0/fs/sysfs/group.c:65!
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319583] invalid
> opcode: 0000 [#1] SMP.
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319756] CPU 0.
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319814] Modules
> linked in: rbd libceph ppdev vmw_balloon psmouse vmwgfx serio_raw ttm
> drm parport_pc i2c_piix
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.320989].
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.321063] Pid: 1860,
> comm: rbd Tainted: G        W    3.2.0-32-generic #51-Ubuntu VMware,
> Inc. VMware Virtual P
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.321426] RIP:
> 0010:[<ffffffff811efbc8>]  [<ffffffff811efbc8>]
> internal_create_group+0xf8/0x110
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.321659] RSP:
> 0018:ffff8800135f1cc8  EFLAGS: 00010246
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.321785] RAX:
> 00000000ffffffef RBX: ffff88001ab8e078 RCX: 0000000000014a7b
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.321937] RDX:
> ffffffff81c34b00 RSI: 0000000000000000 RDI: ffff88001ab8e078
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.322090] RBP:
> ffff8800135f1d08 R08: ffffea0000718480 R09: ffffffff813f3499
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.322241] R10:
> 0000000000000000 R11: 0000000000000000 R12: ffffffff81c34b00
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.322394] R13:
> ffff88001ab8e068 R14: 0000000000000000 R15: ffff88001ab8e000
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.323204] FS:
> 00007f8bcf3aa780(0000) GS:ffff88001fc00000(0000)
> knlGS:0000000000000000
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.323398] CS:  0010 DS:
> 0000 ES: 0000 CR0: 0000000080050033
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.323540] CR2:
> 00007f084b07f000 CR3: 000000001425c000 CR4: 00000000000006f0
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.323720] DR0:
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.323891] DR3:
> 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.324047] Process rbd
> (pid: 1860, threadinfo ffff8800135f0000, task ffff880014275c00)
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.324237] Stack:
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.324318]
> ffff8800135f1d28 ffffffff813f34a9 0000000000000100 ffff880000000010
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.324629]
> ffff88001ab8e000 ffff88001f270eb0 ffff88001ab8e068 ffff88001ab8e00c
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.324941]
> ffff8800135f1d18 ffffffff811efc13 ffff8800135f1d28 ffffffff810feaf4
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.325253] Call Trace:
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.325344]
> [<ffffffff813f34a9>] ? device_add+0x89/0x3e0
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.325476]
> [<ffffffff811efc13>] sysfs_create_group+0x13/0x20
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.325621]
> [<ffffffff810feaf4>] blk_trace_init_sysfs+0x14/0x20
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.325762]
> [<ffffffff812f5660>] blk_register_queue+0x40/0x110
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.325901]
> [<ffffffff812fbacc>] add_disk+0xbc/0x230
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.326028]
> [<ffffffffa01950a1>] rbd_init_disk+0x1b1/0x1d0 [rbd]
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.326170]
> [<ffffffffa0195455>] rbd_add+0x285/0x4e0 [rbd]
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.326304]
> [<ffffffff81157ce6>] ? alloc_pages_current+0xb6/0x120
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.326447]
> [<ffffffff813f4727>] bus_attr_store+0x27/0x30
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.326579]
> [<ffffffff811ec24f>] sysfs_write_file+0xef/0x170
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.326715]
> [<ffffffff81178113>] vfs_write+0xb3/0x180
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.326842]
> [<ffffffff8117843a>] sys_write+0x4a/0x90
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.326971]
> [<ffffffff81663442>] system_call_fastpath+0x16/0x1b
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.327110] Code: c3 66
> 90 89 45 c8 e8 b8 d7 ff ff 8b 45 c8 eb df 0f 1f 00 4c 8b 6b 30 4c 89
> 6d d8 e9 77 ff ff ff
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.329592] RIP
> [<ffffffff811efbc8>] internal_create_group+0xf8/0x110
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.329773]  RSP <ffff8800135f1cc8>
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.329912]---[ end trace
> 2d22165b460e6596 ]---
> 
> 
> Also i see different log message in kernel.log
> 
> 
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318832] ------------[
> cut here ]------------
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318862] WARNING: at
> /build/buildd/linux-3.2.0/fs/sysfs/dir.c:481 sysfs_add_one+0xc0/0xf0()
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318867] Hardware
> name: VMware Virtual Platform
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318868] sysfs: cannot
> create duplicate filename '/devices/virtual/block/rbd0'
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318871] Modules
> linked in: rbd libceph ppdev vmw_balloon psmouse vmwgfx serio_raw ttm
> drm parport_pc i2c_piix
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318895] Pid: 1860,
> comm: rbd Not tainted 3.2.0-32-generic #51-Ubuntu
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318897] Call Trace:
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318910]
> [<ffffffff81066e2f>] warn_slowpath_common+0x7f/0xc0
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318913]
> [<ffffffff81066f26>] warn_slowpath_fmt+0x46/0x50
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318915]
> [<ffffffff811edf60>] sysfs_add_one+0xc0/0xf0
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318917]
> [<ffffffff811ee007>] create_dir+0x77/0xd0
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318926]
> [<ffffffff81192142>] ? inode_init_always+0x102/0x1c0
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318928]
> [<ffffffff811ee10d>] sysfs_create_dir+0x7d/0xc0
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318940]
> [<ffffffff8130d7c1>] kobject_add_internal+0xb1/0x200
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318943]
> [<ffffffff8130dc87>] kobject_add+0x67/0xc0
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318945]
> [<ffffffff8130d6fa>] ? kobject_get+0x1a/0x30
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318958]
> [<ffffffff813f351d>] device_add+0xfd/0x3e0
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318963]
> [<ffffffff812fb8d1>] register_disk+0x41/0x180
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318965]
> [<ffffffff812fbac4>] add_disk+0xb4/0x230
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318969]
> [<ffffffffa01950a1>] rbd_init_disk+0x1b1/0x1d0 [rbd]
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318971]
> [<ffffffffa0195455>] rbd_add+0x285/0x4e0 [rbd]
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318980]
> [<ffffffff81157ce6>] ? alloc_pages_current+0xb6/0x120
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318983]
> [<ffffffff813f4727>] bus_attr_store+0x27/0x30
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318985]
> [<ffffffff811ec24f>] sysfs_write_file+0xef/0x170
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318989]
> [<ffffffff81178113>] vfs_write+0xb3/0x180
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.318991]
> [<ffffffff8117843a>] sys_write+0x4a/0x90
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319002]
> [<ffffffff81663442>] system_call_fastpath+0x16/0x1b
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319004] ---[ end
> trace 2d22165b460e6595 ]---
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319006]
> kobject_add_internal failed for rbd0 with -EEXIST, don't try to
> register things with the same name in
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319260] Pid: 1860,
> comm: rbd Tainted: G        W    3.2.0-32-generic #51-Ubuntu
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319261] Call Trace:
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319263]
> [<ffffffff8130d865>] kobject_add_internal+0x155/0x200
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319266]
> [<ffffffff8130dc87>] kobject_add+0x67/0xc0
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319268]
> [<ffffffff8130d6fa>] ? kobject_get+0x1a/0x30
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319270]
> [<ffffffff813f351d>] device_add+0xfd/0x3e0
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319272]
> [<ffffffff812fb8d1>] register_disk+0x41/0x180
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319274]
> [<ffffffff812fbac4>] add_disk+0xb4/0x230
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319277]
> [<ffffffffa01950a1>] rbd_init_disk+0x1b1/0x1d0 [rbd]
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319279]
> [<ffffffffa0195455>] rbd_add+0x285/0x4e0 [rbd]
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319281]
> [<ffffffff81157ce6>] ? alloc_pages_current+0xb6/0x120
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319283]
> [<ffffffff813f4727>] bus_attr_store+0x27/0x30
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319285]
> [<ffffffff811ec24f>] sysfs_write_file+0xef/0x170
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319287]
> [<ffffffff81178113>] vfs_write+0xb3/0x180
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319289]
> [<ffffffff8117843a>] sys_write+0x4a/0x90
> Nov 13 15:32:47 ceph-precie-64-02 kernel: [  188.319291]
> [<ffffffff81663442>] system_call_fastpath+0x16/0x1b
> 
> 
> I use ubuntu 12.0.4 (Linux ceph-precie-64-02 3.2.0-32-generic
> #51-Ubuntu SMP Wed Sep 26 21:33:09 UTC 2012 x86_64 x86_64 x86_64
> GNU/Linux), and laster stable ceph release from
> http://ceph.com/debian/, also i use pacemaker + corosync with follow
> conf:
> 
> node ceph-precie-64-01
> node ceph-precie-64-02
> node ceph-precie-64-03
> primitive samba_fs ocf:heartbeat:Filesystem \
>         params device="-U cb4d3dda-92e9-4bd8-9fbc-2940c096e8ec"
> directory="/mnt" fstype="ext4"
> primitive samba_rbd ocf:ceph:rbd \
>         params name="samba"
> group samba samba_rbd samba_fs
> property $id="cib-bootstrap-options" \
>         dc-version="1.1.6-9971ebba4494012a93c03b40a2c58ec0eb60f50c" \
>         cluster-infrastructure="openais" \
>         expected-quorum-votes="3" \
>         stonith-enabled="false" \
>         no-quorum-policy="stop" \
>         last-lrm-refresh="1352806660"
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

