From: Jens Rehpoehler <jens.rehpoehler@filoo.de>
Subject: small bug ?
Date: Sun, 08 Jan 2012 11:06:19 +0100
Message-ID: <4F096A9B.4020207@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-7.de-punkt.de ([93.190.64.37]:38835 "EHLO
	mail-7.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab2AHKGX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Jan 2012 05:06:23 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

i just got an kernel oops and want to describe what i've done:

root@cephnode3:~# rbd map data/vm-905-disk-1.rbd

[153462.346359] libceph: mon0 10.0.0.10:6789 session established
[153462.382244]  rbd0: p1 p2 < p5 >
[153462.382496] rbd: rbd0: added with size 0x200000000

-> everything ist fine

root@cephnode3:~# mount /dev/rbd0p1 /mnt/

-> works .... i can access my files in /mnt

next i didn't unmount /mnt but "unmapped" the rbd0 device

root@cephnode3:/# rbd unmap /dev/rbd0

-> works without any error message (should this work with a mounted
filesystem to /mnt ?)

df shows:

/dev/rbd0p1            7867856    714560   6753632  10% /mnt

If i unmount the /mnt mountpoint now -> everything is fine.

but: if i forget to unmount /mnt und map another rbd file:

root@cephnode3:/# rbd map data/vm-906-disk-1.rbd

Message from syslogd@cephnode3 at Jan  8 10:59:46 ...
 kernel:[153891.372190] ------------[ cut here ]------------
Message from syslogd@cephnode3 at Jan  8 10:59:46 ...
 kernel:[153891.372241] invalid opcode: 0000 [#1] SMP
Message from syslogd@cephnode3 at Jan  8 10:59:46 ...
 kernel:[153891.373120] Stack:
Message from syslogd@cephnode3 at Jan  8 10:59:46 ...
 kernel:[153891.373291] Call Trace:
Message from syslogd@cephnode3 at Jan  8 10:59:46 ...
 kernel:[153891.373548] Code: 5a fe ff ff 41 57 41 56 41 89 f6 41 55 41
54 55 48 89 d5 53 48 89 fb 48 83 ec 28 48 85 ff 74 0b 85 f6 75 0b 48 83
7f 30 00 75 14 <0f> 0b eb fe b9 ea ff ff ff 48 83 7f 30 00 0f 84 0b 01
00 00 48

3891.371931] ------------[ cut here ]------------
[153891.371938] WARNING: at fs/sysfs/dir.c:481 sysfs_add_one+0x90/0xa3()
[153891.371940] Hardware name: PDSMi
[153891.371941] sysfs: cannot create duplicate filename
'/devices/virtual/block/rbd0'
[153891.371943] Modules linked in: rbd ceph libceph fuse loop tpm_tis
tpm rng_core pcspkr i2c_i801 i2c_core evdev tpm_bios shpchp pci_hotplug
container processor thermal_sys button ext3 jbd mbcache btrfs
zlib_deflate crc32c libcrc32c sd_mod crc_t10dif uhci_hcd ahci libahci
libata ehci_hcd scsi_mod usbcore e1000e usb_common [last unloaded:
scsi_wait_scan]
[153891.371972] Pid: 4077, comm: rbd Not tainted 3.2.0 #5
[153891.371974] Call Trace:
[153891.371978]  [<ffffffff81047263>] ? warn_slowpath_common+0x78/0x8c
[153891.371981]  [<ffffffff81047316>] ? warn_slowpath_fmt+0x45/0x4a
[153891.371984]  [<ffffffff81148270>] ? sysfs_add_one+0x90/0xa3
[153891.371987]  [<ffffffff81148a7b>] ? create_dir+0x67/0x9f
[153891.371990]  [<ffffffff81148b44>] ? sysfs_create_dir+0x91/0xa5
[153891.371994]  [<ffffffff811a0f3e>] ? vsnprintf+0x7e/0x428
[153891.371997]  [<ffffffff8119b085>] ? kobject_add_internal+0xc8/0x181
[153891.372000]  [<ffffffff8119b2cc>] ? kobject_add+0x66/0x6b
[153891.372003]  [<ffffffff810ebdbb>] ? __kmalloc+0xce/0xda
[153891.372006]  [<ffffffff8119af0a>] ? kobject_get+0x12/0x17
[153891.372009]  [<ffffffff811915ca>] ? get_disk+0x8d/0x8d
[153891.372013]  [<ffffffff81233cf7>] ? device_add+0xcf/0x5d0
[153891.372016]  [<ffffffff81232e85>] ? dev_set_name+0x3f/0x44
[153891.372019]  [<ffffffff811911ad>] ? register_disk+0x37/0x155
[153891.372022]  [<ffffffff8119064d>] ? blk_register_region+0x22/0x27
[153891.372024]  [<ffffffff8119139a>] ? add_disk+0xcf/0x272
[153891.372029]  [<ffffffffa020563f>] ? rbd_add+0x812/0xa9b [rbd]
[153891.372032]  [<ffffffff810d14a2>] ? handle_mm_fault+0x107/0x194
[153891.372036]  [<ffffffff8114750c>] ? sysfs_write_file+0xd3/0x10f
[153891.372039]  [<ffffffff810f2d34>] ? vfs_write+0xa4/0xfe
[153891.372042]  [<ffffffff810f2e44>] ? sys_write+0x45/0x6e
[153891.372046]  [<ffffffff8132fad2>] ? system_call_fastpath+0x16/0x1b
[153891.372048] ---[ end trace 07aa2735707e0993 ]---
[153891.372051] kobject_add_internal failed for rbd0 with -EEXIST, don't
try to register things with the same name in the same directory.
[153891.372122] Pid: 4077, comm: rbd Tainted: G        W    3.2.0 #5
[153891.372123] Call Trace:
[153891.372126]  [<ffffffff8119b114>] ? kobject_add_internal+0x157/0x181
[153891.372129]  [<ffffffff8119b2cc>] ? kobject_add+0x66/0x6b
[153891.372132]  [<ffffffff810ebdbb>] ? __kmalloc+0xce/0xda
[153891.372135]  [<ffffffff8119af0a>] ? kobject_get+0x12/0x17
[153891.372137]  [<ffffffff811915ca>] ? get_disk+0x8d/0x8d
[153891.372140]  [<ffffffff81233cf7>] ? device_add+0xcf/0x5d0
[153891.372143]  [<ffffffff81232e85>] ? dev_set_name+0x3f/0x44
[153891.372146]  [<ffffffff811911ad>] ? register_disk+0x37/0x155
[153891.372149]  [<ffffffff8119064d>] ? blk_register_region+0x22/0x27
[153891.372151]  [<ffffffff8119139a>] ? add_disk+0xcf/0x272
[153891.372164]  [<ffffffffa020563f>] ? rbd_add+0x812/0xa9b [rbd]
[153891.372167]  [<ffffffff810d14a2>] ? handle_mm_fault+0x107/0x194
[153891.372170]  [<ffffffff8114750c>] ? sysfs_write_file+0xd3/0x10f
[153891.372173]  [<ffffffff810f2d34>] ? vfs_write+0xa4/0xfe
[153891.372176]  [<ffffffff810f2e44>] ? sys_write+0x45/0x6e
[153891.372180]  [<ffffffff8132fad2>] ? system_call_fastpath+0x16/0x1b
[153891.372190] ------------[ cut here ]------------
[153891.372215] kernel BUG at fs/sysfs/group.c:65!
[153891.372241] invalid opcode: 0000 [#1] SMP
[153891.372269] CPU 2
[153891.372275] Modules linked in: rbd ceph libceph fuse loop tpm_tis
tpm rng_core pcspkr i2c_i801 i2c_core evdev tpm_bios shpchp pci_hotplug
container processor thermal_sys button ext3 jbd mbcache btrfs
zlib_deflate crc32c libcrc32c sd_mod crc_t10dif uhci_hcd ahci libahci
libata ehci_hcd scsi_mod usbcore e1000e usb_common [last unloaded:
scsi_wait_scan]
[153891.372505]
[153891.372525] Pid: 4077, comm: rbd Tainted: G        W    3.2.0 #5
Supermicro PDSMi/PDSMi+
[153891.372577] RIP: 0010:[<ffffffff81149d75>]  [<ffffffff81149d75>]
internal_create_group+0x27/0x160
[153891.372629] RSP: 0018:ffff8801d265bd28  EFLAGS: 00010246
[153891.372655] RAX: 00000000ffffffef RBX: ffff8801d18b8478 RCX:
0000000000000000
[153891.372699] RDX: ffffffff81624440 RSI: 0000000000000000 RDI:
ffff8801d18b8478
[153891.372742] RBP: ffffffff81624440 R08: ffff880217002300 R09:
ffffffff812341d7
[153891.372785] R10: 0000000000000000 R11: ffff8802056cb2c0 R12:
ffff8801d18b8468
[153891.372829] R13: ffff8801d18b8400 R14: 0000000000000000 R15:
ffff8802056cb2c0
[153891.372873] FS:  00007face11ba760(0000) GS:ffff88021fd00000(0000)
knlGS:0000000000000000
[153891.372918] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[153891.372946] CR2: 000000000055c290 CR3: 00000001d2870000 CR4:
00000000000006e0
[153891.372989] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[153891.373032] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
0000000000000400
[153891.373076] Process rbd (pid: 4077, threadinfo ffff8801d265a000,
task ffff8801d0faca40)
[153891.373120] Stack:
[153891.373140]  0000000000000010 ffff8801d265bd88 ffff8801d265bd48
00000000e4add280
[153891.373190]  ffff8802056cb3f8 ffff8801d18b8400 ffff8802056cb2c0
ffff8801d18b8468
[153891.373240]  ffff8801d18b8400 ffff8801d18b8400 ffff8802056cb2c0
ffffffff8118c4b2
[153891.373291] Call Trace:
[153891.373315]  [<ffffffff8118c4b2>] ? blk_register_queue+0x45/0xeb
[153891.373343]  [<ffffffff811913a2>] ? add_disk+0xd7/0x272
[153891.373371]  [<ffffffffa020563f>] ? rbd_add+0x812/0xa9b [rbd]
[153891.373399]  [<ffffffff810d14a2>] ? handle_mm_fault+0x107/0x194
[153891.373428]  [<ffffffff8114750c>] ? sysfs_write_file+0xd3/0x10f
[153891.373456]  [<ffffffff810f2d34>] ? vfs_write+0xa4/0xfe
[153891.373483]  [<ffffffff810f2e44>] ? sys_write+0x45/0x6e
[153891.373520]  [<ffffffff8132fad2>] ? system_call_fastpath+0x16/0x1b
[153891.373548] Code: 5a fe ff ff 41 57 41 56 41 89 f6 41 55 41 54 55 48
89 d5 53 48 89 fb 48 83 ec 28 48 85 ff 74 0b 85 f6 75 0b 48 83 7f 30 00
75 14 <0f> 0b eb fe b9 ea ff ff ff 48 83 7f 30 00 0f 84 0b 01 00 00 48
[153891.373734] RIP  [<ffffffff81149d75>] internal_create_group+0x27/0x160
[153891.373765]  RSP <ffff8801d265bd28>
[153891.374010] ---[ end trace 07aa2735707e0994 ]---

I know that my mistake is, that i didn't unmount the rbd0 device. Should
it be possible to use unmap if a mountpoint to this device exists ? I my
opinion i should get something like "can not unmap mounted device" error
message.

Maybe someone can explain that ....

Thank you

Jens
