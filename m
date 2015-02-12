From: Thorwald Lundqvist <thorwald@jumpstarter.io>
Subject: RBD Kernel panic rbd_dev_refresh
Date: Thu, 12 Feb 2015 15:39:15 +0100
Message-ID: <CAPZO0-PBVXKoCu3N0USFSO=8NmTj9k2Ys82zJBnFVv2Q4xEFkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:45733 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416AbbBLOjQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 09:39:16 -0500
Received: by labge10 with SMTP id ge10so10369474lab.12
        for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 06:39:15 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I just experienced a kernel panic. I have no idea what caused it and
therefor don't know how to reproduce. But I do have a trace:


[772336.044392] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000050
[772336.046559] IP: [<ffffffffa0243d2b>] rbd_dev_refresh+0xcb/0x140 [rbd]
[772336.047611] PGD bb985067 PUD bb986067 PMD 0
[772336.047611] Oops: 0002 [#1] PREEMPT SMP
[772336.047611] Modules linked in: veth ipt_MASQUERADE
nf_nat_masquerade_ipv4 cbc ipt_REJECT nf_reject_ipv4 xt_conntrack
iptable_filter iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 nf_nat nf_conntrack xt_tcpudp iptable_mangle ip_tables
x_tables cfg80211 rfkill joydev mousedev crct10dif_pclmul ppdev
crc32_pclmul ghash_clmulni_intel parport_pc aesni_intel cirrus
aes_x86_64 ttm lrw gf128mul evdev drm_kms_helper glue_helper mac_hid
ablk_helper drm cryptd parport serio_raw pvpanic syscopyarea
sysfillrect pcspkr processor psmouse intel_agp intel_gtt i2c_piix4
sysimgblt button i2c_core rbd libceph crc32c_generic crc32c_intel
libcrc32c ext4 crc16 mbcache jbd2 hid_generic usbhid hid sd_mod
ata_generic pata_acpi virtio_balloon virtio_scsi virtio_net atkbd
libps2 floppy i8042 serio virtio_pci virtio_ring virtio ata_piix
uhci_hcd usbcore usb_common libata scsi_mod
[772336.047611] CPU: 0 PID: 27553 Comm: kworker/u2:3 Not tainted 3.18.5-1-js #2
[772336.047611] Hardware name: OpenStack Foundation OpenStack Nova,
BIOS Bochs 01/01/2011
[772336.047611] Workqueue: ceph-watch-notify do_event_work [libceph]
[772336.047611] task: ffff8800913b6eb0 ti: ffff8801999f8000 task.ti:
ffff8801999f8000
[772336.047611] RIP: 0010:[<ffffffffa0243d2b>]  [<ffffffffa0243d2b>]
rbd_dev_refresh+0xcb/0x140 [rbd]
[772336.047611] RSP: 0018:ffff8801999fbd68  EFLAGS: 00010246
[772336.047611] RAX: 0000000000000000 RBX: ffff8801a6f27000 RCX:
0000000000000000
[772336.047611] RDX: ffffffff00000001 RSI: fffffffffffffffe RDI:
ffff8801a6f27058
[772336.047611] RBP: ffff8801999fbd88 R08: 00000000000164c0 R09:
ffffea0002c2acc0
[772336.047611] R10: ffffffffa02435c5 R11: ffffea0002ecee40 R12:
0000000000a00000
[772336.047611] R13: 0000000000000000 R14: 000004e90000001b R15:
000004e90000001b
[772336.047611] FS:  0000000000000000(0000) GS:ffff8801bfc00000(0000)
knlGS:0000000000000000
[772336.047611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[772336.047611] CR2: 0000000000000050 CR3: 00000000bb8c5000 CR4:
00000000001406f0
[772336.047611] Stack:
[772336.047611]  ffff8801999fbdc0 ffff8801a6f27000 ffff88009a7f8ea0
0000000000000001
[772336.047611]  ffff8801999fbdb8 ffffffffa0243dd4 ffff8801af658500
ffff88009a7f8ea0
[772336.047611]  0000000000000001 00000000000003af ffff8801999fbdf8
ffffffffa02066b7
[772336.047611] Call Trace:
[772336.047611]  [<ffffffffa0243dd4>] rbd_watch_cb+0x34/0x180 [rbd]
[772336.047611]  [<ffffffffa02066b7>] do_event_work+0x47/0xb0 [libceph]
[772336.047611]  [<ffffffff8108be25>] process_one_work+0x145/0x400
[772336.047611]  [<ffffffff8108c3eb>] worker_thread+0x6b/0x480
[772336.047611]  [<ffffffff8108c380>] ? init_pwq.part.22+0x10/0x10
[772336.047611]  [<ffffffff8109144a>] kthread+0xea/0x100
[772336.047611]  [<ffffffff81091360>] ? kthread_create_on_node+0x1c0/0x1c0
[772336.047611]  [<ffffffff8155c33c>] ret_from_fork+0x7c/0xb0
[772336.047611]  [<ffffffff81091360>] ? kthread_create_on_node+0x1c0/0x1c0
[772336.047611] Code: ab c8 00 00 00 4c 89 e7 e8 d3 7c 31 e1 41 83 e5
02 75 25 4c 8b a3 58 01 00 00 49 c1 ec 09 f6 05 55 9d 00 00 04 75 51
48 8b 43 10 <4c> 89 60 50 48 8b 7b 10 e8 d8 94 fc e0 31 c0 48 83 c4 08
5b 41
[772336.047611] RIP  [<ffffffffa0243d2b>] rbd_dev_refresh+0xcb/0x140 [rbd]
[772336.047611]  RSP <ffff8801999fbd68>
[772336.047611] CR2: 0000000000000050
[772336.047611] ------------[ cut here ]------------
[772336.047611] kernel BUG at arch/x86/mm/pageattr.c:216!
[772336.047611] invalid opcode: 0000 [#2] PREEMPT SMP
[772336.047611] Modules linked in: veth ipt_MASQUERADE
nf_nat_masquerade_ipv4 cbc ipt_REJECT nf_reject_ipv4 xt_conntrack
iptable_filter iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 nf_nat nf_conntrack xt_tcpudp iptable_mangle ip_tables
x_tables cfg80211 rfkill joydev mousedev crct10dif_pclmul ppdev
crc32_pclmul ghash_clmulni_intel parport_pc aesni_intel cirrus
aes_x86_64 ttm lrw gf128mul evdev drm_kms_helper glue_helper mac_hid
ablk_helper drm cryptd parport serio_raw pvpanic syscopyarea
sysfillrect pcspkr processor psmouse intel_agp intel_gtt i2c_piix4
sysimgblt button i2c_core rbd libceph crc32c_generic crc32c_intel
libcrc32c ext4 crc16 mbcache jbd2 hid_generic usbhid hid sd_mod
ata_generic pata_acpi virtio_balloon virtio_scsi virtio_net atkbd
libps2 floppy i8042 serio virtio_pci virtio_ring virtio ata_piix
uhci_hcd usbcore usb_common libata scsi_mod
[772336.047611] CPU: 0 PID: 27553 Comm: kworker/u2:3 Not tainted 3.18.5-1-js #2
[772336.047611] Hardware name: OpenStack Foundation OpenStack Nova,
BIOS Bochs 01/01/2011
[772336.047611] Workqueue: ceph-watch-notify do_event_work [libceph]
[772336.047611] task: ffff8800913b6eb0 ti: ffff8801999f8000 task.ti:
ffff8801999f8000
[772336.047611] RIP: 0010:[<ffffffff81063c96>]  [<ffffffff81063c96>]
change_page_attr_set_clr+0x496/0x4d0
[772336.047611] RSP: 0018:ffff8801999faf48  EFLAGS: 00010046
[772336.047611] RAX: 0000000000000046 RBX: 0000000000000000 RCX:
0000000000000005
[772336.047611] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000080000000
[772336.047611] RBP: ffff8801999fafe8 R08: ffff880000000690 R09:
000000009a53a000
[772336.047611] R10: 0000000000000010 R11: 0000000000000001 R12:
0000000000000000
[772336.047611] R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000200
[772336.047611] FS:  0000000000000000(0000) GS:ffff8801bfc00000(0000)
knlGS:0000000000000000
[772336.047611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[772336.047611] CR2: 0000000000000050 CR3: 0000000001811000 CR4:
00000000001406f0
[772336.047611] Stack:
[772336.047611]  0000000400000008 0000000000000000 0000000000000010
ffff880074221000
[772336.047611]  ffff8801999faf98 0000000000000000 0000000000000000
0000000000000010
[772336.047611]  0000000000000000 0000000500000001 000000000009a4e0
0000020000000000
[772336.047611] Call Trace:
[772336.047611]  [<ffffffff8106427a>] _set_pages_array+0xfa/0x150
[772336.047611]  [<ffffffff81064303>] set_pages_array_wc+0x13/0x20
[772336.047611]  [<ffffffffa0348f0f>] ttm_set_pages_caching+0x2f/0x70 [ttm]
[772336.047611]  [<ffffffffa0349009>]
ttm_alloc_new_pages.isra.6+0xb9/0x180 [ttm]
[772336.047611]  [<ffffffffa0349594>] ttm_pool_populate+0x404/0x500 [ttm]
[772336.047611]  [<ffffffffa03573ae>] cirrus_ttm_tt_populate+0xe/0x10 [cirrus]
[772336.047611]  [<ffffffffa0345e31>] ttm_bo_move_memcpy+0x5e1/0x640 [ttm]
[772336.047611]  [<ffffffffa03413ac>] ? ttm_tt_init+0x8c/0xb0 [ttm]
[772336.047611]  [<ffffffffa0357358>] cirrus_bo_move+0x18/0x20 [cirrus]
[772336.047611]  [<ffffffffa0343152>] ttm_bo_handle_move_mem+0x2b2/0x660 [ttm]
[772336.047611]  [<ffffffffa0343c00>] ? ttm_bo_mem_space+0xf0/0x370 [ttm]
[772336.047611]  [<ffffffffa034438b>] ttm_bo_validate+0x20b/0x220 [ttm]
[772336.047611]  [<ffffffff8106159b>] ? iounmap+0x7b/0xb0
[772336.047611]  [<ffffffffa0357b86>] cirrus_bo_push_sysram+0x96/0xf0 [cirrus]
[772336.047611]  [<ffffffffa0355d04>]
cirrus_crtc_do_set_base.isra.6.constprop.7+0x84/0x420 [cirrus]
[772336.047611]  [<ffffffffa03564ea>] cirrus_crtc_mode_set+0x44a/0x4c0 [cirrus]
[772336.047611]  [<ffffffffa031596d>]
drm_crtc_helper_set_mode+0x32d/0x590 [drm_kms_helper]
[772336.047611]  [<ffffffffa0316740>]
drm_crtc_helper_set_config+0x9c0/0xb50 [drm_kms_helper]
[772336.047611]  [<ffffffffa02de3a0>]
drm_mode_set_config_internal+0x60/0xf0 [drm]
[772336.047611]  [<ffffffffa031f4b5>]
drm_fb_helper_pan_display+0x95/0xf0 [drm_kms_helper]
[772336.047611]  [<ffffffff8132944a>] fb_pan_display+0x9a/0x160
[772336.047611]  [<ffffffff813233b0>] bit_update_start+0x20/0x50
[772336.047611]  [<ffffffff81320ba1>] fbcon_switch+0x3b1/0x5e0
[772336.047611]  [<ffffffff81399269>] redraw_screen+0x1a9/0x250
[772336.047611]  [<ffffffff8131ff8a>] fbcon_blank+0x23a/0x340
[772336.047611]  [<ffffffff81145a9f>] ? irq_work_queue+0xf/0xa0
[772336.047611]  [<ffffffff810c8b9c>] ? wake_up_klogd+0x3c/0x60
[772336.047611]  [<ffffffff810c8e42>] ? console_unlock+0x282/0x460
[772336.047611]  [<ffffffff810da433>] ? internal_add_timer+0x63/0x80
[772336.047611]  [<ffffffff810db364>] ? mod_timer+0x114/0x250
[772336.047611]  [<ffffffff81399d9a>] do_unblank_screen+0xaa/0x1d0
[772336.047611]  [<ffffffff81399ed0>] unblank_screen+0x10/0x20
[772336.047611]  [<ffffffff812c7e99>] bust_spinlocks+0x19/0x40
[772336.047611]  [<ffffffff81018798>] oops_end+0x38/0xe0
[772336.047611]  [<ffffffff81060133>] no_context+0x173/0x3d0
[772336.047611]  [<ffffffff810604bd>] __bad_area_nosemaphore+0x12d/0x250
[772336.047611]  [<ffffffff810605f3>] bad_area_nosemaphore+0x13/0x20
[772336.047611]  [<ffffffff81060c34>] __do_page_fault+0x344/0x600
[772336.047611]  [<ffffffffa01fe064>] ? ceph_msg_release+0x174/0x1f0 [libceph]
[772336.047611]  [<ffffffff81060f57>] trace_do_page_fault+0x37/0xf0
[772336.047611]  [<ffffffff8105901a>] do_async_page_fault+0x1a/0x80
[772336.047611]  [<ffffffff8155e2c8>] async_page_fault+0x28/0x30
[772336.047611]  [<ffffffffa02435c5>] ? rbd_dev_header_info+0x3b5/0xa50 [rbd]
[772336.047611]  [<ffffffffa0243d2b>] ? rbd_dev_refresh+0xcb/0x140 [rbd]
[772336.047611]  [<ffffffffa0243d0d>] ? rbd_dev_refresh+0xad/0x140 [rbd]
[772336.047611]  [<ffffffffa0243dd4>] rbd_watch_cb+0x34/0x180 [rbd]
[772336.047611]  [<ffffffffa02066b7>] do_event_work+0x47/0xb0 [libceph]
[772336.047611]  [<ffffffff8108be25>] process_one_work+0x145/0x400
[772336.047611]  [<ffffffff8108c3eb>] worker_thread+0x6b/0x480
[772336.047611]  [<ffffffff8108c380>] ? init_pwq.part.22+0x10/0x10
[772336.047611]  [<ffffffff8109144a>] kthread+0xea/0x100
[772336.047611]  [<ffffffff81091360>] ? kthread_create_on_node+0x1c0/0x1c0
[772336.047611]  [<ffffffff8155c33c>] ret_from_fork+0x7c/0xb0
[772336.047611]  [<ffffffff81091360>] ? kthread_create_on_node+0x1c0/0x1c0
[772336.047611] Code: 01 74 d2 be 00 10 00 00 4c 89 f7 e8 b5 dc ff ff
eb c3 0f 1f 00 be 00 10 00 00 4c 89 f7 e8 a3 dc ff ff e9 0a fe ff ff
0f 0b 0f 0b <0f> 0b be ba 00 00 00 48 c7 c7 86 09 70 81 44 89 95 78 ff
ff ff
[772336.047611] RIP  [<ffffffff81063c96>] change_page_attr_set_clr+0x496/0x4d0
[772336.047611]  RSP <ffff8801999faf48>
[772336.047611] ---[ end trace 5ef90e3c40b63b6c ]---



Hope it helps
Regards
-- 
Thorwald Lundqvist


Public key:
https://pgp.mit.edu/pks/lookup?op=get&search=0x3A7FCB6C88CE396A
