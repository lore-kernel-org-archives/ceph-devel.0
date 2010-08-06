From: Sage Weil <sage@newdream.net>
Subject: Re: Kernel oops on df : offline ceph still mounted.
Date: Fri, 6 Aug 2010 11:08:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008061101060.26680@cobra.newdream.net>
References: <14C7F4F06DB5814AB0DE29716C4F6D670C4C77A5@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49551 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964829Ab0HFSFj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Aug 2010 14:05:39 -0400
In-Reply-To: <14C7F4F06DB5814AB0DE29716C4F6D670C4C77A5@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Smets, Jan (Jan)" <jan.smets@alcatel-lucent.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 6 Aug 2010, Smets, Jan (Jan) wrote:
> I'm using the Debian packages. Kernel 2.6.35.
> 
> This occured on a 'df' command while the ceph fs was mounted, but 
> mds/mon/osd were all offline.
> 
> I hope you find this usefull.

This looks like a btrfs directio problem.  IIRC that was just merged in 
2.6.35, so it may be buggy.  I suspect it's from the osd journal being on 
a btrfs volume?  You can try putting that on a separate partition (block 
device or non-btrfs file system), or try adding 'journal dio = false' to 
the [osd] section of your ceph.conf.

(Incidentally a ceph 'df' interacts only with the monitor.. the timing was 
probably coincidental.)

sage


> 
> - Jan
> 
> 
> [37668.773921] BUG: unable to handle kernel NULL pointer dereference at 0000000000000007
> [37668.776457] IP: [<ffffffff810e16a2>] __kmalloc+0xd3/0x136
> [37668.776457] PGD 12091b067 PUD 11036a067 PMD 0
> [37668.776457] Oops: 0000 [#1] SMP
> [37668.776457] last sysfs file: /sys/module/btrfs/initstate
> [37668.776457] CPU 0
> [37668.776457] Modules linked in: ceph fuse bonding loop radeon ttm drm_kms_helper drm it8213 i2c_i801 i2c_algo_bit e1000e shpchp i3200_edac ide_core i2c_core edac_core pci_hotplug parport_pc snd_pcsp parport tpm_tis video tpm container output tpm_bios snd_pcm snd_timer evdev snd button processor soundcore snd_page_alloc ext4 mbcache jbd2 crc16 btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10dif ata_generic ata_piix libata scsi_mod thermal thermal_sys
> [37668.776457]
> [37668.776457] Pid: 25179, comm: cosd Not tainted 2.6.35-trunk-amd64 #1 X7SBi-LN4/X7SBi-LN4
> [37668.776457] RIP: 0010:[<ffffffff810e16a2>]  [<ffffffff810e16a2>] __kmalloc+0xd3/0x136
> [37668.776457] RSP: 0018:ffff88012d9af8a8  EFLAGS: 00010002
> [37668.776457] RAX: 0000000000000000 RBX: 0000000000000007 RCX: ffffffffa018d642
> [37668.776457] RDX: 0000000100000000 RSI: 0000000000000000 RDI: 0000000000000003
> [37668.776457] RBP: ffffffff81625268 R08: ffff880001a124c8 R09: ffff880080375e40
> [37668.776457] R10: 0000000000001000 R11: ffffffff81625268 R12: 0000000000000004
> [37668.776457] R13: 0000000000000050 R14: 0000000000000050 R15: 0000000000000246
> [37668.776457] FS:  00007f0f096fc710(0000) GS:ffff880001a00000(0000) knlGS:0000000000000000
> [37668.776457] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [37668.776457] CR2: 0000000000000007 CR3: 000000012bf5c000 CR4: 00000000000406f0
> [37668.776457] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [37668.776457] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [37668.776457] Process cosd (pid: 25179, threadinfo ffff88012d9ae000, task ffff88012e2ba210)
> [37668.776457] Stack:
> [37668.776457]  ffff880109fbd580 ffffffffa018d642 ffff88012d9af910 ffff88012dff7e00
> [37668.776457] <0> ffff880080375e40 ffff880006037758 ffff8800458bd000 ffff88012e3f0400
> [37668.776457] <0> 0000000000000001 ffffffffa018d642 ffff88012f67f9c0 ffffffff8110b53d
> [37668.776457] Call Trace:
> [37668.776457]  [<ffffffffa018d642>] ? btrfs_submit_direct+0x9b/0x233 [btrfs]
> [37668.776457]  [<ffffffffa018d642>] ? btrfs_submit_direct+0x9b/0x233 [btrfs]
> [37668.776457]  [<ffffffff8110b53d>] ? bio_alloc_bioset+0x6c/0xb5
> [37668.776457]  [<ffffffffa0186993>] ? __btrfs_submit_bio_done+0x0/0x18 [btrfs]
> [37668.776457]  [<ffffffff8110dfdd>] ? dio_bio_submit+0x62/0x8a
> [37668.776457]  [<ffffffff8110e042>] ? dio_send_cur_page+0x3d/0xa1
> [37668.776457]  [<ffffffff8110e158>] ? submit_page_section+0xb2/0x125
> [37668.776457]  [<ffffffff8110ea5e>] ? __blockdev_direct_IO_newtrunc+0x6ba/0x95f
> [37668.776457]  [<ffffffff8110ed62>] ? __blockdev_direct_IO+0x5f/0xbd
> [37668.776457]  [<ffffffffa018dfd2>] ? btrfs_get_blocks_direct+0x0/0x409 [btrfs]
> [37668.776457]  [<ffffffffa018d5a7>] ? btrfs_submit_direct+0x0/0x233 [btrfs]
> [37668.776457]  [<ffffffffa0186f00>] ? btrfs_direct_IO+0x22d/0x343 [btrfs]
> [37668.776457]  [<ffffffffa018dfd2>] ? btrfs_get_blocks_direct+0x0/0x409 [btrfs]
> [37668.776457]  [<ffffffffa018d5a7>] ? btrfs_submit_direct+0x0/0x233 [btrfs]
> [37668.776457]  [<ffffffffa018d8e3>] ? btrfs_get_extent+0x0/0x6ef [btrfs]
> [37668.776457]  [<ffffffff810af3cd>] ? generic_file_direct_write+0xdb/0x14f
> [37668.776457]  [<ffffffffa0190592>] ? btrfs_file_aio_write+0x244/0x7da [btrfs]
> [37668.776457]  [<ffffffffa019034e>] ? btrfs_file_aio_write+0x0/0x7da [btrfs]
> [37668.776457]  [<ffffffff810e8ce0>] ? do_sync_readv_writev+0x9a/0xd5
> [37668.776457]  [<ffffffff810e8a91>] ? copy_from_user+0x18/0x30
> [37668.776457]  [<ffffffff810e97ff>] ? rw_copy_check_uvector+0x6a/0xe1
> [37668.776457]  [<ffffffff810e991a>] ? do_readv_writev+0xa4/0x118
> [37668.776457]  [<ffffffff812ffd81>] ? mutex_lock+0xd/0x33
> [37668.776457]  [<ffffffff810e9ab3>] ? sys_writev+0x45/0x90
> [37668.776457]  [<ffffffff810089c2>] ? system_call_fastpath+0x16/0x1b
> [37668.776457] Code: 0f 1f 44 00 00 49 89 c7 fa 66 0f 1f 44 00 00 65 4c 8b 04 25 80 ea 00 00 48 8b 45 00 49 01 c0 49 8b 18 48 85 db 74 0d 48 63 45 18 <48> 8b 04 03 49 89 00 eb 11 83 ca ff 44 89 f6 48 89 ef e8 a1 f1
> [37668.776457] RIP  [<ffffffff810e16a2>] __kmalloc+0xd3/0x136
> [37668.776457]  RSP <ffff88012d9af8a8>
> [37668.776457] CR2: 0000000000000007
> [37669.097165] ---[ end trace b253e7c846e7635e ]---
> [37669.098037] ------------[ cut here ]------------
> [37669.098040] kernel BUG at /build/mattems-linux-2.6_2.6.35-1~experimental.1-amd64-OCge0v/linux-2.6-2.6.35/debian/build/source_amd64_none/mm/slub.c:2834!
> [37669.098043] invalid opcode: 0000 [#2] SMP
> [37669.098045] last sysfs file: /sys/module/btrfs/initstate
> [37669.098048] CPU 2
> [37669.098049] Modules linked in: ceph fuse bonding loop radeon ttm drm_kms_helper drm it8213 i2c_i801 i2c_algo_bit e1000e shpchp i3200_edac ide_core i2c_core edac_core pci_hotplug parport_pc snd_pcsp parport tpm_tis video tpm container output tpm_bios snd_pcm snd_timer evdev snd button processor soundcore snd_page_alloc ext4 mbcache jbd2 crc16 btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10dif ata_generic ata_piix libata scsi_mod thermal thermal_sys
> [37669.098079]
> [37669.098082] Pid: 25309, comm: btrfs-endio-wri Tainted: G      D     2.6.35-trunk-amd64 #1 X7SBi-LN4/X7SBi-LN4
> [37669.098084] RIP: 0010:[<ffffffff810e0755>]  [<ffffffff810e0755>] kfree+0x5b/0xc8
> [37669.098093] RSP: 0018:ffff88012d54fd90  EFLAGS: 00010246
> [37669.098095] RAX: 0200000000000400 RBX: ffff880100000000 RCX: 0000000000001000
> [37669.098097] RDX: ffffea0000000000 RSI: ffffea0003800000 RDI: ffff880100000000
> [37669.098099] RBP: 0000000000000000 R08: ffff880006037758 R09: ffff88012bf2b100
> [37669.098102] R10: dead000000200200 R11: 0000000000000282 R12: ffffffffa018b905
> [37669.098104] R13: ffff88012e08f3c8 R14: ffff8800458bd000 R15: ffff8800803750c0
> [37669.098106] FS:  0000000000000000(0000) GS:ffff880001b00000(0000) knlGS:0000000000000000
> [37669.098109] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [37669.098111] CR2: 00007fb5f41c5cc8 CR3: 000000012bf5c000 CR4: 00000000000406e0
> [37669.098113] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [37669.098115] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [37669.098118] Process btrfs-endio-wri (pid: 25309, threadinfo ffff88012d54e000, task ffff88012d938000)
> [37669.098119] Stack:
> [37669.098120]  ffff88012dff7080 0000000000000000 ffff880006037758 ffffffffa018b905
> [37669.098122] <0> ffff880109fbd600 0000000000000286 ffffffffa0180cb6 0000000000000000
> [37669.098124] <0> ffff88012e08f3e8 0000000000000286 ffff8800060375d0 ffff880109fbd638
> [37669.098126] Call Trace:
> [37669.098153]  [<ffffffffa018b905>] ? btrfs_endio_direct_write+0x23a/0x25b [btrfs]
> [37669.098163]  [<ffffffffa0180cb6>] ? end_workqueue_fn+0x101/0x118 [btrfs]
> [37669.098174]  [<ffffffffa01a6152>] ? worker_loop+0x186/0x4a1 [btrfs]
> [37669.098183]  [<ffffffffa01a5fcc>] ? worker_loop+0x0/0x4a1 [btrfs]
> [37669.098187]  [<ffffffff8105b3a1>] ? kthread+0x75/0x7d
> [37669.098193]  [<ffffffff810097e4>] ? kernel_thread_helper+0x4/0x10
> [37669.098195]  [<ffffffff8105b32c>] ? kthread+0x0/0x7d
> [37669.098197]  [<ffffffff810097e0>] ? kernel_thread_helper+0x0/0x10
> [37669.098198] Code: c5 10 48 83 7d 00 00 eb e6 48 83 fb 10 0f 86 80 00 00 00 48 89 df e8 a9 f0 ff ff 48 89 c6 48 8b 00 84 c0 78 16 66 a9 00 c0 75 04 <0f> 0b eb fe 5b 5d 41 5c 48 89 f7 e9 6d 6b fd ff 48 8b 4c 24 18
> [37669.098210] RIP  [<ffffffff810e0755>] kfree+0x5b/0xc8
> [37669.098213]  RSP <ffff88012d54fd90>
> [37669.098216] ---[ end trace b253e7c846e7635f ]---
> [37669.409175] BUG: unable to handle kernel NULL pointer dereference at 0000000000000007
> [37669.417002] IP: [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37669.417002] PGD 12091b067 PUD 11036a067 PMD 0
> [37669.417002] Oops: 0000 [#3] SMP
> [37669.417002] last sysfs file: /sys/module/btrfs/initstate
> [37669.417002] CPU 0
> [37669.417002] Modules linked in: ceph fuse bonding loop radeon ttm drm_kms_helper drm it8213 i2c_i801 i2c_algo_bit e1000e shpchp i3200_edac ide_core i2c_core edac_core pci_hotplug parport_pc snd_pcsp parport tpm_tis video tpm container output tpm_bios snd_pcm snd_timer evdev snd button processor soundcore snd_page_alloc ext4 mbcache jbd2 crc16 btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10dif ata_generic ata_piix libata scsi_mod thermal thermal_sys
> [37669.417002]
> [37669.417002] Pid: 25182, comm: cosd Tainted: G      D     2.6.35-trunk-amd64 #1 X7SBi-LN4/X7SBi-LN4
> [37669.417002] RIP: 0010:[<ffffffff810e2fef>]  [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37669.417002] RSP: 0018:ffff88012d401d78  EFLAGS: 00010002
> [37669.417002] RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00000000000000e6
> [37669.417002] RDX: 0000000100000000 RSI: ffff88012d401da8 RDI: 0000000000000003
> [37669.417002] RBP: ffffffff81625268 R08: ffff880001a124c8 R09: ffff88012d401e78
> [37669.417002] R10: 0000000000000005 R11: 00007f0f07ef63f0 R12: 0000000000000005
> [37669.417002] R13: 00000000000000d0 R14: 00000000000000d0 R15: ffffffff81100c58
> [37669.417002] FS:  00007f0f07ef9710(0000) GS:ffff880001a00000(0000) knlGS:0000000000000000
> [37669.417002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [37669.417002] CR2: 0000000000000007 CR3: 000000012bf5c000 CR4: 00000000000406f0
> [37669.417002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [37669.417002] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [37669.417002] Process cosd (pid: 25182, threadinfo ffff88012d400000, task ffff88012e2b8000)
> [37669.417002] Stack:
> [37669.417002]  ffff88012bbd1898 0000000000000246 ffff88012bbd1948 0000000000000000
> [37669.417002] <0> 0000000000000005 00007f0efc684000 0000000000000005 0000000000a43ec0
> [37669.417002] <0> 00007f0efc055c50 ffffffff810bf59d 0000000000000000 ffff88012fb88780
> [37669.417002] Call Trace:
> [37669.417002]  [<ffffffff810bf59d>] ? memdup_user+0x1c/0x57
> [37669.417002]  [<ffffffff81100c58>] ? setxattr+0x96/0xed
> [37669.417002]  [<ffffffff810df7f7>] ? virt_to_head_page+0x9/0x2a
> [37669.417002]  [<ffffffff810f3ae5>] ? user_path_at+0x52/0x78
> [37669.417002]  [<ffffffff81181380>] ? _atomic_dec_and_lock+0x30/0x4c
> [37669.417002]  [<ffffffff81100d91>] ? sys_setxattr+0x60/0x85
> [37669.417002]  [<ffffffff810089c2>] ? system_call_fastpath+0x16/0x1b
> [37669.417002] Code: 44 00 00 48 89 44 24 08 fa 66 0f 1f 44 00 00 65 4c 8b 04 25 80 ea 00 00 48 8b 45 00 49 01 c0 49 8b 18 48 85 db 74 0d 48 63 45 18 <48> 8b 04 03 49 89 00 eb 14 4c 89 f9 83 ca ff 44 89 f6 48 89 ef
> [37669.417002] RIP  [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37669.417002]  RSP <ffff88012d401d78>
> [37669.417002] CR2: 0000000000000007
> [37669.417002] ---[ end trace b253e7c846e76360 ]---
> [37669.417603] BUG: unable to handle kernel NULL pointer dereference at 0000000000000007
> [37669.417606] IP: [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37669.417609] PGD 12091b067 PUD 11036a067 PMD 0
> [37669.417611] Oops: 0000 [#4] SMP
> [37669.417612] last sysfs file: /sys/module/btrfs/initstate
> [37669.417614] CPU 0
> [37669.417614] Modules linked in: ceph fuse bonding loop radeon ttm drm_kms_helper drm it8213 i2c_i801 i2c_algo_bit e1000e shpchp i3200_edac ide_core i2c_core edac_core pci_hotplug parport_pc snd_pcsp parport tpm_tis video tpm container output tpm_bios snd_pcm snd_timer evdev snd button processor soundcore snd_page_alloc ext4 mbcache jbd2 crc16 btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10dif ata_generic ata_piix libata scsi_mod thermal thermal_sys
> [37669.417630]
> [37669.417632] Pid: 25183, comm: cosd Tainted: G      D     2.6.35-trunk-amd64 #1 X7SBi-LN4/X7SBi-LN4
> [37669.417634] RIP: 0010:[<ffffffff810e2fef>]  [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37669.417637] RSP: 0018:ffff88012da83d78  EFLAGS: 00010002
> [37669.417639] RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00000000000000e6
> [37669.417641] RDX: 0000000100000000 RSI: ffff88012da83da8 RDI: 0000000000000003
> [37669.417643] RBP: ffffffff81625268 R08: ffff880001a124c8 R09: ffff88012da83e78
> [37669.417644] R10: 0000000000000005 R11: 00007f0f076f53f0 R12: 0000000000000005
> [37669.417646] R13: 00000000000000d0 R14: 00000000000000d0 R15: ffffffff81100c58
> [37669.417648] FS:  00007f0f076f8710(0000) GS:ffff880001a00000(0000) knlGS:0000000000000000
> [37669.417650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [37669.417652] CR2: 0000000000000007 CR3: 000000012bf5c000 CR4: 00000000000406f0
> [37669.417654] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [37669.417656] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [37669.417658] Process cosd (pid: 25183, threadinfo ffff88012da82000, task ffff88012e2bdf60)
> [37669.417659] Stack:
> [37669.417660]  ffff88012bbd1c70 0000000000000246 ffff88012bbd1d20 0000000000000000
> [37669.417661] <0> 0000000000000005 00007f0ef4012000 0000000000000005 0000000000a43ec0
> [37669.417663] <0> 0000000000b26ce0 ffffffff810bf59d 0000000000000000 ffff880110824000
> [37669.417666] Call Trace:
> [37669.417668]  [<ffffffff810bf59d>] ? memdup_user+0x1c/0x57
> [37669.417671]  [<ffffffff81100c58>] ? setxattr+0x96/0xed
> [37669.417673]  [<ffffffff810df7f7>] ? virt_to_head_page+0x9/0x2a
> [37669.417675]  [<ffffffff810f3ae5>] ? user_path_at+0x52/0x78
> [37669.417677]  [<ffffffff81181380>] ? _atomic_dec_and_lock+0x30/0x4c
> [37669.417679]  [<ffffffff81100d91>] ? sys_setxattr+0x60/0x85
> [37669.417682]  [<ffffffff810089c2>] ? system_call_fastpath+0x16/0x1b
> [37669.417683] Code: 44 00 00 48 89 44 24 08 fa 66 0f 1f 44 00 00 65 4c 8b 04 25 80 ea 00 00 48 8b 45 00 49 01 c0 49 8b 18 48 85 db 74 0d 48 63 45 18 <48> 8b 04 03 49 89 00 eb 14 4c 89 f9 83 ca ff 44 89 f6 48 89 ef
> [37669.417695] RIP  [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37669.417698]  RSP <ffff88012da83d78>
> [37669.417699] CR2: 0000000000000007
> [37669.417700] ---[ end trace b253e7c846e76361 ]---
> [37670.273456] BUG: unable to handle kernel NULL pointer dereference at 0000000000000007
> [37670.277433] IP: [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37670.277433] PGD 12eb9d067 PUD 12d6b4067 PMD 0
> [37670.277433] Oops: 0000 [#5] SMP
> [37670.304018] last sysfs file: /sys/module/btrfs/initstate
> [37670.304018] CPU 0
> [37670.304018] Modules linked in: ceph fuse bonding loop radeon ttm drm_kms_helper drm it8213 i2c_i801 i2c_algo_bit e1000e shpchp i3200_edac ide_core i2c_core edac_core pci_hotplug parport_pc snd_pcsp parport tpm_tis video tpm container output tpm_bios snd_pcm snd_timer evdev snd button processor soundcore snd_page_alloc ext4 mbcache jbd2 crc16 btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10dif ata_generic ata_piix libata scsi_mod thermal thermal_sys
> [37670.304018]
> [37670.304018] Pid: 25003, comm: cmon Tainted: G      D     2.6.35-trunk-amd64 #1 X7SBi-LN4/X7SBi-LN4
> [37670.304018] RIP: 0010:[<ffffffff810e2fef>]  [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37670.304018] RSP: 0018:ffff88012dff1d08  EFLAGS: 00010002
> [37670.304018] RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000000006
> [37670.304018] RDX: 0000000100000000 RSI: 0000000000000000 RDI: 0000000000000003
> [37670.304018] RBP: ffffffff81625268 R08: ffff880001a124c8 R09: ffff88005a67b000
> [37670.304018] R10: ffff88012f8c7a80 R11: ffff88005a67b010 R12: 0000000000000006
> [37670.304018] R13: 00000000000000d0 R14: 00000000000000d0 R15: ffffffff810f19c4
> [37670.304018] FS:  00007f6e560f5710(0000) GS:ffff880001a00000(0000) knlGS:0000000000000000
> [37670.304018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [37670.304018] CR2: 0000000000000007 CR3: 000000012e669000 CR4: 00000000000406f0
> [37670.304018] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [37670.304018] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [37670.304018] Process cmon (pid: 25003, threadinfo ffff88012dff0000, task ffff88011bd9d890)
> [37670.304018] Stack:
> [37670.304018]  ffff88012b862730 0000000000000246 0000000000000003 ffff88012f8c7b20
> [37670.304018] <0> ffff88012f8c7a80 ffff88012b862730 ffff88012f8c7780 ffff88012dff1df8
> [37670.304018] <0> ffff88012b862730 ffffffff810bf71c ffff88012f8c7a80 0000000000000006
> [37670.304018] Call Trace:
> [37670.304018]  [<ffffffff810bf71c>] ? kstrdup+0x2a/0x40
> [37670.304018]  [<ffffffff810f19c4>] ? vfs_rename+0xa9/0x3e4
> [37670.304018]  [<ffffffff810f0d29>] ? __lookup_hash+0xc2/0xe9
> [37670.304018]  [<ffffffff810f3348>] ? sys_renameat+0x1aa/0x22b
> [37670.304018]  [<ffffffff8108ef4f>] ? rcu_start_gp+0x1f7/0x218
> [37670.304018]  [<ffffffff810ea13a>] ? fput+0x18f/0x1c4
> [37670.304018]  [<ffffffff810fd9ea>] ? mntput_no_expire+0x23/0xde
> [37670.304018]  [<ffffffff810e7829>] ? filp_close+0x5f/0x6a
> [37670.304018]  [<ffffffff810089c2>] ? system_call_fastpath+0x16/0x1b
> [37670.304018] Code: 44 00 00 48 89 44 24 08 fa 66 0f 1f 44 00 00 65 4c 8b 04 25 80 ea 00 00 48 8b 45 00 49 01 c0 49 8b 18 48 85 db 74 0d 48 63 45 18 <48> 8b 04 03 49 89 00 eb 14 4c 89 f9 83 ca ff 44 89 f6 48 89 ef
> [37670.304018] RIP  [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37670.304018]  RSP <ffff88012dff1d08>
> [37670.304018] CR2: 0000000000000007
> [37670.304018] ---[ end trace b253e7c846e76362 ]---
> [37670.729093] BUG: unable to handle kernel NULL pointer dereference at 0000000000000007
> [37670.732993] IP: [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37670.732993] PGD 12dccf067 PUD 12dc97067 PMD 0
> [37670.732993] Oops: 0000 [#6] SMP
> [37670.732993] last sysfs file: /sys/module/btrfs/initstate
> [37670.732993] CPU 0
> [37670.732993] Modules linked in: ceph fuse bonding loop radeon ttm drm_kms_helper drm it8213 i2c_i801 i2c_algo_bit e1000e shpchp i3200_edac ide_core i2c_core edac_core pci_hotplug parport_pc snd_pcsp parport tpm_tis video tpm container output tpm_bios snd_pcm snd_timer evdev snd button processor soundcore snd_page_alloc ext4 mbcache jbd2 crc16 btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10dif ata_generic ata_piix libata scsi_mod thermal thermal_sys
> [37670.732993]
> [37670.732993] Pid: 25212, comm: cosd Tainted: G      D     2.6.35-trunk-amd64 #1 X7SBi-LN4/X7SBi-LN4
> [37670.732993] RIP: 0010:[<ffffffff810e2fef>]  [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37670.732993] RSP: 0018:ffff88012d4a5d78  EFLAGS: 00010002
> [37670.732993] RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00000000000000e6
> [37670.841005] RDX: 0000000100000000 RSI: ffff88012d4a5da8 RDI: 0000000000000003
> [37670.841005] RBP: ffffffff81625268 R08: ffff880001a124c8 R09: ffff88012d4a5e78
> [37670.841005] R10: 0000000000000005 R11: 00007fb5fc3dd3f0 R12: 0000000000000005
> [37670.841005] R13: 00000000000000d0 R14: 00000000000000d0 R15: ffffffff81100c58
> [37670.841005] FS:  00007fb5fc3e0710(0000) GS:ffff880001a00000(0000) knlGS:0000000000000000
> [37670.841005] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [37670.841005] CR2: 0000000000000007 CR3: 000000012dd3d000 CR4: 00000000000406f0
> [37670.841005] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [37670.841005] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [37670.841005] Process cosd (pid: 25212, threadinfo ffff88012d4a4000, task ffff88012f000da0)
> [37670.841005] Stack:
> [37670.841005]  ffff88012bbd2048 0000000000000246 ffff88012bbd20f8 0000000000000000
> [37670.841005] <0> 0000000000000005 00000000024f3000 0000000000000005 0000000002497ec0
> [37670.841005] <0> 00000000025cac50 ffffffff810bf59d 0000000000000000 ffff88005bbd2180
> [37670.841005] Call Trace:
> [37670.841005]  [<ffffffff810bf59d>] ? memdup_user+0x1c/0x57
> [37670.841005]  [<ffffffff81100c58>] ? setxattr+0x96/0xed
> [37670.841005]  [<ffffffff810df7f7>] ? virt_to_head_page+0x9/0x2a
> [37670.841005]  [<ffffffff810f3ae5>] ? user_path_at+0x52/0x78
> [37670.841005]  [<ffffffff81181380>] ? _atomic_dec_and_lock+0x30/0x4c
> [37670.841005]  [<ffffffff81100d91>] ? sys_setxattr+0x60/0x85
> [37670.841005]  [<ffffffff810089c2>] ? system_call_fastpath+0x16/0x1b
> [37670.841005] Code: 44 00 00 48 89 44 24 08 fa 66 0f 1f 44 00 00 65 4c 8b 04 25 80 ea 00 00 48 8b 45 00 49 01 c0 49 8b 18 48 85 db 74 0d 48 63 45 18 <48> 8b 04 03 49 89 00 eb 14 4c 89 f9 83 ca ff 44 89 f6 48 89 ef
> [37670.841005] RIP  [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37670.841005]  RSP <ffff88012d4a5d78>
> [37670.841005] CR2: 0000000000000007
> [37670.841005] ---[ end trace b253e7c846e76363 ]---
> [37670.878220] BUG: unable to handle kernel NULL pointer dereference at 0000000000000007
> [37670.878223] IP: [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37670.878226] PGD 12dccf067 PUD 12dc97067 PMD 0
> [37670.878228] Oops: 0000 [#7] SMP
> [37670.878230] last sysfs file: /sys/module/btrfs/initstate
> [37670.878231] CPU 0
> [37670.878232] Modules linked in: ceph fuse bonding loop radeon ttm drm_kms_helper drm it8213 i2c_i801 i2c_algo_bit e1000e shpchp i3200_edac ide_core i2c_core edac_core pci_hotplug parport_pc snd_pcsp parport tpm_tis video tpm container output tpm_bios snd_pcm snd_timer evdev snd button processor soundcore snd_page_alloc ext4 mbcache jbd2 crc16 btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10dif ata_generic ata_piix libata scsi_mod thermal thermal_sys
> [37670.878250]
> [37670.878252] Pid: 25213, comm: cosd Tainted: G      D     2.6.35-trunk-amd64 #1 X7SBi-LN4/X7SBi-LN4
> [37670.878253] RIP: 0010:[<ffffffff810e2fef>]  [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37670.878257] RSP: 0018:ffff88012bf89d78  EFLAGS: 00010002
> [37670.878258] RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00000000000000e6
> [37670.878260] RDX: 0000000100000000 RSI: ffff88012bf89da8 RDI: 0000000000000003
> [37670.878262] RBP: ffffffff81625268 R08: ffff880001a124c8 R09: ffff88012bf89e78
> [37670.878264] R10: 0000000000000005 R11: 00007fb5fbbdc3f0 R12: 0000000000000005
> [37670.878266] R13: 00000000000000d0 R14: 00000000000000d0 R15: ffffffff81100c58
> [37670.878268] FS:  00007fb5fbbdf710(0000) GS:ffff880001a00000(0000) knlGS:0000000000000000
> [37670.878270] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [37670.878271] CR2: 0000000000000007 CR3: 000000012dd3d000 CR4: 00000000000406f0
> [37670.878273] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [37670.878275] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [37670.878277] Process cosd (pid: 25213, threadinfo ffff88012bf88000, task ffff88012f0073d0)
> [37670.878278] Stack:
> [37670.878279]  ffff88012ba6c560 0000000000000246 ffff88012ba6c610 0000000000000000
> [37670.878281] <0> 0000000000000005 00007fb5e89cc000 0000000000000005 00007fb5fbbdec40
> [37670.878283] <0> 00000000025d8c50 ffffffff810bf59d 0000000000000000 ffff88012b8336c0
> [37670.878285] Call Trace:
> [37670.878288]  [<ffffffff810bf59d>] ? memdup_user+0x1c/0x57
> [37670.878290]  [<ffffffff81100c58>] ? setxattr+0x96/0xed
> [37670.878292]  [<ffffffff810df7f7>] ? virt_to_head_page+0x9/0x2a
> [37670.878294]  [<ffffffff810f3ae5>] ? user_path_at+0x52/0x78
> [37670.878296]  [<ffffffff810df7f7>] ? virt_to_head_page+0x9/0x2a
> [37670.878299]  [<ffffffff810f34ee>] ? do_unlinkat+0x10d/0x149
> [37670.878302]  [<ffffffff81181380>] ? _atomic_dec_and_lock+0x30/0x4c
> [37670.878304]  [<ffffffff81100d91>] ? sys_setxattr+0x60/0x85
> [37670.878307]  [<ffffffff810089c2>] ? system_call_fastpath+0x16/0x1b
> [37670.878308] Code: 44 00 00 48 89 44 24 08 fa 66 0f 1f 44 00 00 65 4c 8b 04 25 80 ea 00 00 48 8b 45 00 49 01 c0 49 8b 18 48 85 db 74 0d 48 63 45 18 <48> 8b 04 03 49 89 00 eb 14 4c 89 f9 83 ca ff 44 89 f6 48 89 ef
> [37670.878320] RIP  [<ffffffff810e2fef>] __kmalloc_track_caller+0xc7/0x12d
> [37670.878323]  RSP <ffff88012bf89d78>
> [37670.878324] CR2: 0000000000000007
> [37670.878326] ---[ end trace b253e7c846e76364 ]---
> [37671.450883] BUG: unable to handle kernel NULL pointer dereference at 0000000000000007
> [37671.455481] IP: [<ffffffff810e16a2>] __kmalloc+0xd3/0x136
> [37671.455481] PGD 12dccf067 PUD 12dc97067 PMD 0
> [37671.455481] Oops: 0000 [#8] SMP
> [37671.455481] last sysfs file: /sys/module/btrfs/initstate
> [37671.455481] CPU 0
> [37671.455481] Modules linked in: ceph fuse bonding loop radeon ttm drm_kms_helper drm it8213 i2c_i801 i2c_algo_bit e1000e shpchp i3200_edac ide_core i2c_core edac_core pci_hotplug parport_pc snd_pcsp parport tpm_tis video tpm container output tpm_bios snd_pcm snd_timer evdev snd button processor soundcore snd_page_alloc ext4 mbcache jbd2 crc16 btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10dif ata_generic ata_piix libata scsi_mod thermal thermal_sys
> [37671.455481]
> [37671.455481] Pid: 25209, comm: cosd Tainted: G      D     2.6.35-trunk-amd64 #1 X7SBi-LN4/X7SBi-LN4
> [37671.455481] RIP: 0010:[<ffffffff810e16a2>]  [<ffffffff810e16a2>] __kmalloc+0xd3/0x136
> [37671.455481] RSP: 0018:ffff88012dae58a8  EFLAGS: 00010002
> [37671.455481] RAX: 0000000000000000 RBX: 0000000000000007 RCX: ffffffffa018d642
> [37671.455481] RDX: 0000000000000000 RSI: ffff8800cf43da80 RDI: 0000000000000003
> [37671.455481] RBP: ffffffff81625268 R08: ffff880001a124c8 R09: ffff880080375540
> [37671.455481] R10: 0000000000001000 R11: ffff8800cf43d080 R12: 0000000000000004
> [37671.455481] R13: 0000000000000050 R14: 0000000000000050 R15: 0000000000000246
> [37671.455481] FS:  00007fb5fdbe3710(0000) GS:ffff880001a00000(0000) knlGS:0000000000000000
> [37671.455481] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [37671.455481] CR2: 0000000000000007 CR3: 000000012dd3d000 CR4: 00000000000406f0
> [37671.455481] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [37671.455481] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [37671.455481] Process cosd (pid: 25209, threadinfo ffff88012dae4000, task ffff88012f005890)
> [37671.455481] Stack:
> [37671.455481]  ffff88012bb65368 ffffffffa018d642 ffff88012dae5910 ffff88012dff7fc0
> [37671.455481] <0> ffff880080375540 ffff88012bb654c0 ffff880096186000 ffff8800c2a76800
> [37671.455481] <0> 0000000000000001 ffffffffa018d642 ffff88012f67f9c0 ffffffff8110b53d
> [37671.455481] Call Trace:
> [37671.455481]  [<ffffffffa018d642>] ? btrfs_submit_direct+0x9b/0x233 [btrfs]
> [37671.455481]  [<ffffffffa018d642>] ? btrfs_submit_direct+0x9b/0x233 [btrfs]
> [37671.455481]  [<ffffffff8110b53d>] ? bio_alloc_bioset+0x6c/0xb5
> [37671.455481]  [<ffffffff8110dfdd>] ? dio_bio_submit+0x62/0x8a
> [37671.455481]  [<ffffffff8110e042>] ? dio_send_cur_page+0x3d/0xa1
> [37671.455481]  [<ffffffff8110e158>] ? submit_page_section+0xb2/0x125
> [37671.455481]  [<ffffffff8110ea5e>] ? __blockdev_direct_IO_newtrunc+0x6ba/0x95f
> [37671.455481]  [<ffffffff8110ed62>] ? __blockdev_direct_IO+0x5f/0xbd
> [37671.455481]  [<ffffffffa018dfd2>] ? btrfs_get_blocks_direct+0x0/0x409 [btrfs]
> [37671.455481]  [<ffffffffa018d5a7>] ? btrfs_submit_direct+0x0/0x233 [btrfs]
> [37671.455481]  [<ffffffffa0186f00>] ? btrfs_direct_IO+0x22d/0x343 [btrfs]
> [37671.455481]  [<ffffffffa018dfd2>] ? btrfs_get_blocks_direct+0x0/0x409 [btrfs]
> [37671.455481]  [<ffffffffa018d5a7>] ? btrfs_submit_direct+0x0/0x233 [btrfs]
> [37671.455481]  [<ffffffffa018d8e3>] ? btrfs_get_extent+0x0/0x6ef [btrfs]
> [37671.455481]  [<ffffffff810af3cd>] ? generic_file_direct_write+0xdb/0x14f
> [37671.455481]  [<ffffffffa0190592>] ? btrfs_file_aio_write+0x244/0x7da [btrfs]
> [37671.455481]  [<ffffffffa019034e>] ? btrfs_file_aio_write+0x0/0x7da [btrfs]
> [37671.455481]  [<ffffffff810e8ce0>] ? do_sync_readv_writev+0x9a/0xd5
> [37671.455481]  [<ffffffff810e8a91>] ? copy_from_user+0x18/0x30
> [37671.455481]  [<ffffffff810e97ff>] ? rw_copy_check_uvector+0x6a/0xe1
> [37671.455481]  [<ffffffff810e991a>] ? do_readv_writev+0xa4/0x118
> [37671.455481]  [<ffffffff81300740>] ? rwsem_down_read_failed+0x22/0x2b
> [37671.455481]  [<ffffffff812ffd81>] ? mutex_lock+0xd/0x33
> [37671.455481]  [<ffffffff81189787>] ? call_rwsem_wake+0x17/0x30
> [37671.455481]  [<ffffffff810e9ab3>] ? sys_writev+0x45/0x90
> [37671.455481]  [<ffffffff810089c2>] ? system_call_fastpath+0x16/0x1b
> [37671.455481] Code: 0f 1f 44 00 00 49 89 c7 fa 66 0f 1f 44 00 00 65 4c 8b 04 25 80 ea 00 00 48 8b 45 00 49 01 c0 49 8b 18 48 85 db 74 0d 48 63 45 18 <48> 8b 04 03 49 89 00 eb 11 83 ca ff 44 89 f6 48 89 ef e8 a1 f1
> [37671.455481] RIP  [<ffffffff810e16a2>] __kmalloc+0xd3/0x136
> [37671.455481]  RSP <ffff88012dae58a8>
> [37671.455481] CR2: 0000000000000007
> [37671.455481] ---[ end trace b253e7c846e76365 ]---
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
