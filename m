From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: warning: btrfs warning while running cosd
Date: Sat, 8 Jan 2011 18:01:34 -0800
Message-ID: <A07D74FF-DE82-4670-BCFF-F5039A365636@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:58853 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab1AICBf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Jan 2011 21:01:35 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>

This warning in btrfs was thrown in cosd's context. Has this been seen? Maybe this needs to go to the btrfs list...?

-----

[156155.871399] WARNING: at /build/buildd/linux-2.6.35/fs/btrfs/inode.c:2116 btrfs_orphan_commit_root+0xb0/0xc0 [btrfs]()
[156155.871402] Hardware name: H8DMR-82
[156155.871404] Modules linked in: btrfs zlib_deflate crc32c libcrc32c nfsd exportfs nfs lockd fscache nfs_acl auth_rpcgss sunrpc radeon ttm ib_mthca drm_kms_helper ib_mad joydev amd64_edac_mod drm ib_core psmouse i2c_algo_bit shpchp serio_raw k8temp edac_core edac_mce_amd i2c_nforce2 lp parport usbhid hid floppy e1000 pata_amd sata_nv forcedeth
[156155.871436] Pid: 23113, comm: cosd Not tainted 2.6.35-22-server #33-Ubuntu
[156155.871438] Call Trace:
[156155.871447]  [<ffffffff8106080f>] warn_slowpath_common+0x7f/0xc0
[156155.871451]  [<ffffffff8106086a>] warn_slowpath_null+0x1a/0x20
[156155.871464]  [<ffffffffa03e2990>] btrfs_orphan_commit_root+0xb0/0xc0 [btrfs]
[156155.871476]  [<ffffffffa03de691>] commit_fs_roots+0xa1/0x140 [btrfs]
[156155.871488]  [<ffffffffa03df8f8>] btrfs_commit_transaction+0x2e8/0x6f0 [btrfs]
[156155.871500]  [<ffffffffa03cecf6>] ? btrfs_trans_reserve_metadata+0x66/0xa0 [btrfs]
[156155.871504]  [<ffffffff8107f080>] ? autoremove_wake_function+0x0/0x40
[156155.871517]  [<ffffffffa040cafd>] create_snapshot+0xed/0x150 [btrfs]
[156155.871529]  [<ffffffffa040cca2>] btrfs_mksubvol+0x142/0x200 [btrfs]
[156155.871541]  [<ffffffffa040ce73>] btrfs_ioctl_snap_create+0x113/0x160 [btrfs]
[156155.871553]  [<ffffffffa040e43a>] btrfs_ioctl+0x2ea/0x4b0 [btrfs]
[156155.871558]  [<ffffffff81090a62>] ? futex_wake+0x112/0x130
[156155.871563]  [<ffffffff81083894>] ? hrtimer_start_range_ns+0x14/0x20
[156155.871567]  [<ffffffff81162e1d>] vfs_ioctl+0x3d/0xd0
[156155.871570]  [<ffffffff811635b1>] do_vfs_ioctl+0x81/0x3d0
[156155.871574]  [<ffffffff81152f42>] ? vfs_write+0x132/0x1a0
[156155.871577]  [<ffffffff81163981>] sys_ioctl+0x81/0xa0
[156155.871582]  [<ffffffff8100a0f2>] system_call_fastpath+0x16/0x1b

