From: Andrey Korolyov <andrey@xdel.ru>
Subject: 'rbd map' asynchronous behavior
Date: Tue, 15 May 2012 15:49:43 +0400
Message-ID: <CABYiri-Whv7tGLVb-AcwMKcA1=iMTyguOYokg2xKt9r6hzKRuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42982 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757851Ab2EOLuI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 May 2012 07:50:08 -0400
Received: by weyu7 with SMTP id u7so2417574wey.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 May 2012 04:50:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

There are strange bug when I tried to map excessive amounts of block
devices inside the pool, like following

for vol in $(rbd ls); do rbd map $vol; [some-microsleep]; [some
operation or nothing, I have stubbed guestfs mount here] ;
[some-microsleep];  unmap /dev/rbd/rbd/$vol ; [some-microsleep]; done,

udev or rbd seems to be somehow late and mapping fails. There is no
real-world harm at all, and such case can be easily avoided, but on
busy cluster timeout increases and I was able to catch same thing on
two-osd config in recovering state. For 0.1 second on healthy cluster,
all works okay, for 0.05 it may fail with following trace(just for me,
because I am testing on relatively old and crappy hardware, so others
may catch that on smaller intervals):

[ 2130.450044] libceph: client0 fsid 70204128-4328-47e7-9df7-c7253c833fc1
[ 2130.450643] libceph: mon0 192.168.10.129:6789 session established
[ 2130.454542]  rbd0: p1 p2
[ 2130.454772] rbd: rbd0: added with size 0x80000000
[ 2137.783484] libceph: client0 fsid 70204128-4328-47e7-9df7-c7253c833fc1
[ 2137.784095] libceph: mon0 192.168.10.129:6789 session established
[ 2137.787801]  rbd0: p1 p2
[ 2137.788028] rbd: rbd0: added with size 0x7d000000
[ 2138.044490] ------------[ cut here ]------------
[ 2138.044499] WARNING: at
/build/kernel/linux-2.6-3.2.15/debian/build/source_amd64_none/fs/sysfs/dir.c:481
sysfs_add_one+0x83/0x96()
[ 2138.044503] Hardware name: System Product Name
[ 2138.044505] sysfs: cannot create duplicate filename
'/devices/virtual/block/rbd0'
[ 2138.044508] Modules linked in: ip6table_filter ip6_tables
iptable_filter acpi_cpufreq mperf ip_tables cpufreq_powersave
ebtable_nat cpufreq_userspace ebtables x_tables cpufreq_conservative
cpufreq_stats cn microcode ib_iser rdma_cm ib_addr iw_cm ib_cm ib_sa
ib_mad ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi
fuse nfsd nfs nfs_acl auth_rpcgss fscache lockd sunrpc kvm_intel kvm
bridge stp ext2 rbd libceph coretemp tcp_yeah tcp_vegas loop dm_crypt
snd_hda_codec_realtek nvidia(P) snd_hda_intel snd_hda_codec snd_hwdep
nv_tco snd_pcm psmouse i2c_nforce2 i2c_core snd_page_alloc evdev
serio_raw snd_timer snd pcspkr soundcore processor button asus_atk0110
ext4 crc16 jbd2 mbcache btrfs crc32c libcrc32c zlib_deflate dm_mod
sd_mod sr_mod cdrom crc_t10dif ohci_hcd ata_generic pata_amd sata_nv
ehci_hcd libata fan forcedeth thermal thermal_sys scsi_mod usbcore
usb_common [last unloaded: scsi_wait_scan]
[ 2138.044607] Pid: 16891, comm: rbd Tainted: P           O 3.2.0-2-amd64 #1
[ 2138.044610] Call Trace:
[ 2138.044616]  [<ffffffff81046811>] ? warn_slowpath_common+0x78/0x8c
[ 2138.044620]  [<ffffffff810468bd>] ? warn_slowpath_fmt+0x45/0x4a
[ 2138.044624]  [<ffffffff8114e918>] ? sysfs_add_one+0x83/0x96
[ 2138.044628]  [<ffffffff8114e991>] ? create_dir+0x66/0xa0
[ 2138.044631]  [<ffffffff8114ea66>] ? sysfs_create_dir+0x85/0x9b
[ 2138.044636]  [<ffffffff811afb6b>] ? vsnprintf+0x7c/0x427
[ 2138.044640]  [<ffffffff811a9aa2>] ? kobject_add_internal+0xc8/0x181
[ 2138.044643]  [<ffffffff811a9e77>] ? kobject_add+0x95/0xa4
[ 2138.044647]  [<ffffffff810363c7>] ? should_resched+0x5/0x23
[ 2138.044651]  [<ffffffff811a99d5>] ? kobject_get+0x12/0x17
[ 2138.044655]  [<ffffffff8119ccb4>] ? get_disk+0x8d/0x8d
[ 2138.044659]  [<ffffffff8124bd13>] ? device_add+0xd6/0x587
[ 2138.044663]  [<ffffffff8124ad4e>] ? dev_set_name+0x42/0x47
[ 2138.044667]  [<ffffffff8119d8db>] ? register_disk+0x37/0x147
[ 2138.044670]  [<ffffffff8119ce48>] ? blk_register_region+0x22/0x27
[ 2138.044674]  [<ffffffff8119db6b>] ? add_disk+0x180/0x26c
[ 2138.044681]  [<ffffffffa0e994d0>] ? rbd_add+0x7b2/0xa32 [rbd]
[ 2138.044685]  [<ffffffff810363c7>] ? should_resched+0x5/0x23
[ 2138.044689]  [<ffffffff8114d477>] ? sysfs_write_file+0xe0/0x11c
[ 2138.044693]  [<ffffffff810f92a7>] ? vfs_write+0xa2/0xe9
[ 2138.044697]  [<ffffffff810f9484>] ? sys_write+0x45/0x6b
[ 2138.044701]  [<ffffffff8134e492>] ? system_call_fastpath+0x16/0x1b
[ 2138.044704] ---[ end trace b7a29490cafc363d ]---
[ 2138.044708] kobject_add_internal failed for rbd0 with -EEXIST,
don't try to register things with the same name in the same directory.
[ 2138.044723] Pid: 16891, comm: rbd Tainted: P        W  O 3.2.0-2-amd64 #1
[ 2138.044725] Call Trace:
[ 2138.044729]  [<ffffffff811a9b31>] ? kobject_add_internal+0x157/0x181
[ 2138.044733]  [<ffffffff811a9e77>] ? kobject_add+0x95/0xa4
[ 2138.044736]  [<ffffffff810363c7>] ? should_resched+0x5/0x23
[ 2138.044740]  [<ffffffff811a99d5>] ? kobject_get+0x12/0x17
[ 2138.044743]  [<ffffffff8119ccb4>] ? get_disk+0x8d/0x8d
[ 2138.044746]  [<ffffffff8124bd13>] ? device_add+0xd6/0x587
[ 2138.044750]  [<ffffffff8124ad4e>] ? dev_set_name+0x42/0x47
[ 2138.044757]  [<ffffffff8119d8db>] ? register_disk+0x37/0x147
[ 2138.044760]  [<ffffffff8119ce48>] ? blk_register_region+0x22/0x27
[ 2138.044763]  [<ffffffff8119db6b>] ? add_disk+0x180/0x26c
[ 2138.044769]  [<ffffffffa0e994d0>] ? rbd_add+0x7b2/0xa32 [rbd]
[ 2138.044772]  [<ffffffff810363c7>] ? should_resched+0x5/0x23
[ 2138.044776]  [<ffffffff8114d477>] ? sysfs_write_file+0xe0/0x11c
[ 2138.044780]  [<ffffffff810f92a7>] ? vfs_write+0xa2/0xe9
[ 2138.044783]  [<ffffffff810f9484>] ? sys_write+0x45/0x6b
[ 2138.044787]  [<ffffffff8134e492>] ? system_call_fastpath+0x16/0x1b
[ 2138.044928] ------------[ cut here ]------------
[ 2138.044937] kernel BUG at
/build/kernel/linux-2.6-3.2.15/debian/build/source_amd64_none/fs/sysfs/group.c:65!
[ 2138.044947] invalid opcode: 0000 [#1] SMP
[ 2138.044962] CPU 1
[ 2138.044967] Modules linked in: ip6table_filter ip6_tables
iptable_filter acpi_cpufreq mperf ip_tables cpufreq_powersave
ebtable_nat cpufreq_userspace ebtables x_tables cpufreq_conservative
cpufreq_stats cn microcode ib_iser rdma_cm ib_addr iw_cm ib_cm ib_sa
ib_mad ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi
fuse nfsd nfs nfs_acl auth_rpcgss fscache lockd sunrpc kvm_intel kvm
bridge stp ext2 rbd libceph coretemp tcp_yeah tcp_vegas loop dm_crypt
snd_hda_codec_realtek nvidia(P) snd_hda_intel snd_hda_codec snd_hwdep
nv_tco snd_pcm psmouse i2c_nforce2 i2c_core snd_page_alloc evdev
serio_raw snd_timer snd pcspkr soundcore processor button asus_atk0110
ext4 crc16 jbd2 mbcache btrfs crc32c libcrc32c zlib_deflate dm_mod
sd_mod sr_mod cdrom crc_t10dif ohci_hcd ata_generic pata_amd sata_nv
ehci_hcd libata fan forcedeth thermal thermal_sys scsi_mod usbcore
usb_common [last unloaded: scsi_wait_scan]
[ 2138.045366]
[ 2138.045380] Pid: 16891, comm: rbd Tainted: P        W  O
3.2.0-2-amd64 #1 System manufacturer System Product Name/P5N-D
[ 2138.045420] RIP: 0010:[<ffffffff8114fdb7>]  [<ffffffff8114fdb7>]
internal_create_group+0x27/0x11f
[ 2138.045454] RSP: 0018:ffff8800b19e3d38  EFLAGS: 00010246
[ 2138.045472] RAX: 00000000ffffffef RBX: ffff8800a19aac00 RCX: 0000000000002019
[ 2138.045491] RDX: ffffffff81624cb0 RSI: 0000000000000000 RDI: ffff8800a19aac78
[ 2138.045511] RBP: ffff8800a19aac78 R08: 0000000000000002 R09: 00000000fffffffe
[ 2138.045530] R10: 0000000000000001 R11: 0000000000000002 R12: ffffffff81624cb0
[ 2138.045549] R13: ffff8800a19aac68 R14: 0000000000000000 R15: ffff880037770038
[ 2138.045569] FS:  00007ffc5219a760(0000) GS:ffff88012fc80000(0000)
knlGS:0000000000000000
[ 2138.045598] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2138.045616] CR2: 00007f16285260f2 CR3: 00000000a1946000 CR4: 00000000000006e0
[ 2138.045635] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2138.045655] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 2138.045675] Process rbd (pid: 16891, threadinfo ffff8800b19e2000,
task ffff880117c76830)
[ 2138.045702] Stack:
[ 2138.045716]  0000000000000000 0000000000000010 ffff8800b19e3d98
0000000069dd99c3
[ 2138.045755]  ffff88006f63d3c0 ffff8800a19aac00 ffff880037770038
ffff880037770038
[ 2138.045793]  ffff8800a19aac68 ffff8800a19aac00 ffff880037770038
ffffffff811990b7
[ 2138.045831] Call Trace:
[ 2138.045849]  [<ffffffff811990b7>] ? blk_register_queue+0x41/0xe1
[ 2138.045868]  [<ffffffff8119db73>] ? add_disk+0x188/0x26c
[ 2138.045889]  [<ffffffffa0e994d0>] ? rbd_add+0x7b2/0xa32 [rbd]
[ 2138.045909]  [<ffffffff810363c7>] ? should_resched+0x5/0x23
[ 2138.045928]  [<ffffffff8114d477>] ? sysfs_write_file+0xe0/0x11c
[ 2138.045947]  [<ffffffff810f92a7>] ? vfs_write+0xa2/0xe9
[ 2138.045965]  [<ffffffff810f9484>] ? sys_write+0x45/0x6b
[ 2138.045984]  [<ffffffff8134e492>] ? system_call_fastpath+0x16/0x1b
[ 2138.046002] Code: 59 5b 5d c3 41 57 41 56 41 89 f6 41 55 41 54 49
89 d4 55 48 89 fd 53 48 83 ec 28 48 85 ff 74 0b 85 f6 75 09 48 83 7f
30 00 75 12 <0f> 0b 48 83 7f 30 00 b8 ea ff ff ff 0f 84 d7 00 00 00 49
8b 34
[ 2138.046248] RIP  [<ffffffff8114fdb7>] internal_create_group+0x27/0x11f
[ 2138.046270]  RSP <ffff8800b19e3d38>
[ 2138.046587] ---[ end trace b7a29490cafc363e ]---
