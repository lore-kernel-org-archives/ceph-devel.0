From: Sage Weil <sage@newdream.net>
Subject: Re: rbd snap
Date: Fri, 16 Sep 2011 09:30:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109160928170.11043@cobra.newdream.net>
References: <4E736107.4050309@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51276 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab1IPQY3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2011 12:24:29 -0400
In-Reply-To: <4E736107.4050309@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

There is a patch for a btrfs bug in the clone ioctl reservation that 
hasn't made it upstream yet.  See

	http://marc.info/?l=linux-btrfs&m=131291225105499&w=2

That should sort you out!

sage


On Fri, 16 Sep 2011, Martin Mailand wrote:

> Hi,
> should rbd snap work? I created a snapshot and then I want to list it.
> rbd snap create --snap=2011091601 lenny1
> rbd snap ls lenny1
> 
> But the ls command does not come back and I get a Kernel bug on 2 OSD.
> It is reproducible.
> 
> 
> [ 7658.115729] ------------[ cut here ]------------
> [ 7658.115779] kernel BUG at fs/btrfs/delayed-inode.c:1693!
> [ 7658.115812] invalid opcode: 0000 [#1] SMP
> [ 7658.115846] CPU 1
> [ 7658.115861] Modules linked in: radeon ttm drm_kms_helper drm i2c_algo_bit
> psmouse k8temp sp5100_tco edac_core edac_mce_amd serio_raw shpchp i2c_piix4 lp
> parport ahci pata_atiixp libahci btrfs e1000e zlib_deflate libcrc32c
> [ 7658.116080]
> [ 7658.116095] Pid: 1418, comm: cosd Tainted: G        W   3.1.0-rc6 #1
> MICRO-STAR INTERNATIONAL CO., LTD MS-96B3/MS-96B3
> [ 7658.116167] RIP: 0010:[<ffffffffa007ffd0>]  [<ffffffffa007ffd0>]
> btrfs_delayed_update_inode+0x2a0/0x2b0 [btrfs]
> [ 7658.116278] RSP: 0018:ffff8801160efbc8  EFLAGS: 00010286
> [ 7658.116311] RAX: 00000000ffffffe4 RBX: ffff8800777c0120 RCX:
> 0000000000018000
> [ 7658.116351] RDX: 000000000000f7e5 RSI: 0000000000018000 RDI:
> ffff880116b10160
> [ 7658.116389] RBP: ffff8801160efc08 R08: ffffe8ffffc81a40 R09:
> ffff8800886826a0
> [ 7658.116428] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff880001e4af50
> [ 7658.116467] R13: ffff8800777c0168 R14: ffff880117122ea0 R15:
> ffff880115113000
> [ 7658.116507] FS:  00007f80e30eb700(0000) GS:ffff88011fc80000(0000)
> knlGS:0000000000000000
> [ 7658.116550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7658.116583] CR2: ffffffffff600400 CR3: 0000000116015000 CR4:
> 00000000000006e0
> [ 7658.116623] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [ 7658.116662] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [ 7658.116700] Process cosd (pid: 1418, threadinfo ffff8801160ee000, task
> ffff880116aeade0)
> [ 7658.116744] Stack:
> [ 7658.116759]  0000000000000282 0000000000018000 ffff8801160efc18
> ffff880001e4af50
> [ 7658.116817]  ffff880117122ea0 ffff8800391b01e0 ffff8801171113f0
> 0000000000000000
> [ 7658.116875]  ffff8801160efc58 ffffffffa003f353 ffff8801160efc38
> ffffffffa00677f8
> [ 7658.116933] Call Trace:
> [ 7658.116978]  [<ffffffffa003f353>] btrfs_update_inode+0x53/0x160 [btrfs]
> [ 7658.117039]  [<ffffffffa00677f8>] ? btrfs_tree_unlock+0x78/0xb0 [btrfs]
> [ 7658.117099]  [<ffffffffa0063184>] btrfs_ioctl_clone+0x9b4/0xd20 [btrfs]
> [ 7658.117164]  [<ffffffffa00666f6>] btrfs_ioctl+0x306/0xe20 [btrfs]
> [ 7658.117204]  [<ffffffff81175f32>] ? do_filp_open+0x42/0xa0
> [ 7658.117240]  [<ffffffff81178048>] do_vfs_ioctl+0x98/0x540
> [ 7658.117277]  [<ffffffff81156f40>] ? kmem_cache_free+0x20/0x100
> [ 7658.117313]  [<ffffffff81178581>] sys_ioctl+0x91/0xa0
> [ 7658.117347]  [<ffffffff815f02c2>] system_call_fastpath+0x16/0x1b
> [ 7658.117381] Code: 00 03 00 00 8d 0c 49 48 89 ca 48 89 4d c8 e8 f8 7d fa ff
> 85 c0 48 8b 4d c8 75 10 48 89 4b 08 e9 cc fd ff ff 0f 1f 80 00 00 00 00 <0f>
> 0b 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 53
> [ 7658.117814] RIP  [<ffffffffa007ffd0>]
> btrfs_delayed_update_inode+0x2a0/0x2b0 [btrfs]
> [ 7658.117883]  RSP <ffff8801160efbc8>
> [ 7658.122364] ---[ end trace c8a580615cad6cbe ]---
> 
> Best Regards,
>  Martin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
