From: huang jun <hjwsm1989@gmail.com>
Subject: rbd error: kernel BUG at fs/bio.c:1499!
Date: Wed, 25 May 2011 17:48:34 +0800
Message-ID: <BANLkTi=L4S39cG+Ns+FQMC3+92ubXw0ODg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53843 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab1EYJsf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 05:48:35 -0400
Received: by wya21 with SMTP id 21so5625671wya.19
        for <ceph-devel@vger.kernel.org>; Wed, 25 May 2011 02:48:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
Recently,i got a error when write a file to rbd mount directory.
what i have done are below:
  mkfs.btrfs /dev/rbd0
  mount /dev/rbd0  /rbd
  then, i write a 400M file in /rbd
the errors are:
May 25 10:20:29 T02-MON12 kernel: [  159.004710] rbd:  fetched request
May 25 10:20:29 T02-MON12 kernel: [  159.004711] rbd:  write 0x1f000
bytes at 0x8bf0000
May 25 10:20:29 T02-MON12 kernel: [  159.004712] rbd:  rq->bio->bi_vcnt=31
May 25 10:20:29 T02-MON12 kernel: [  159.004714] rbd:  bio_chain_clone
split! total=0 remaining=65536bi_size=126976
May 25 10:20:29 T02-MON12 kernel: [  159.004737] ------------[ cut
here ]------------
May 25 10:20:29 T02-MON12 kernel: [  159.004885] kernel BUG at fs/bio.c:1499!
May 25 10:20:29 T02-MON12 kernel: [  159.005006] invalid opcode: 0000 [#1] SMP
May 25 10:20:29 T02-MON12 kernel: [  159.005143] last sysfs file:
/sys/block/rbd0/removable
May 25 10:20:29 T02-MON12 kernel: [  159.005300] CPU 1
May 25 10:20:29 T02-MON12 kernel: [  159.005362] Modules linked in:
rbd libceph usbhid hid ohci_hcd snd_hda_codec_realtek tpm_tis evdev
tpm tpm_bios snd_hda_intel snd_hda_codec intel_agp pcspkr snd_pcm
snd_timer snd serio_raw parport_pc psmouse parport soundcore i2c_i801
video output i2c_core intel_gtt processor button snd_page_alloc
rng_core dm_mirror dm_region_hash dm_log dm_snapshot dm_mod raid10
raid456 async_pq async_xor xor async_memcpy async_raid6_recov raid6_pq
async_tx raid1 raid0 multipath linear md_mod sd_mod ide_pci_generic
ide_core ata_piix ata_generic libata scsi_mod r8169 mii ehci_hcd
uhci_hcd floppy thermal fan thermal_sys [last unloaded:
scsi_wait_scan]
May 25 10:20:29 T02-MON12 kernel: [  159.007488]
May 25 10:20:29 T02-MON12 kernel: [  159.007536] Pid: 2789, comm:
btrfs-submit-0 Not tainted 2.6.37 #1 DG41WV/
May 25 10:20:29 T02-MON12 kernel: [  159.007764] RIP:
0010:[<ffffffff81106bd1>]  [<ffffffff81106bd1>] bio_split+0x84/0x17b
May 25 10:20:29 T02-MON12 kernel: [  159.008009] RSP:
0018:ffff88013a129b10  EFLAGS: 00010206
May 25 10:20:29 T02-MON12 kernel: [  159.008009] RAX: ffff880138e73c00
RBX: ffff88013892f380 RCX: 0000000000000086
May 25 10:20:29 T02-MON12 kernel: [  159.008009] RDX: ffff88013baaa800
RSI: 0000000000011200 RDI: 0000000000000206
May 25 10:20:29 T02-MON12 kernel: [  159.008009] RBP: ffff880139c05800
R08: ffffffff810091cb R09: ffffffff810ab88f
May 25 10:20:29 T02-MON12 kernel: [  159.008009] R10: 0000000000000000
R11: ffff88013a1299f0 R12: ffff88013a193c00
May 25 10:20:29 T02-MON12 kernel: [  159.008009] R13: 0000000000000080
R14: ffff88013946c200 R15: 0000000000046000
May 25 10:20:29 T02-MON12 kernel: [  159.008009] FS:
0000000000000000(0000) GS:ffff8800bd680000(0000)
knlGS:0000000000000000
May 25 10:20:29 T02-MON12 kernel: [  159.008009] CS:  0010 DS: 0000
ES: 0000 CR0: 000000008005003b
May 25 10:20:29 T02-MON12 kernel: [  159.008009] CR2: 00007f632a290000
CR3: 0000000138fc2000 CR4: 00000000000406e0
May 25 10:20:29 T02-MON12 kernel: [  159.008009] DR0: 0000000000000000
DR1: 0000000000000000 DR2: 0000000000000000
May 25 10:20:29 T02-MON12 kernel: [  159.008009] DR3: 0000000000000000
DR6: 00000000ffff0ff0 DR7: 0000000000000400
May 25 10:20:29 T02-MON12 kernel: [  159.008009] Process
btrfs-submit-0 (pid: 2789, threadinfo ffff88013a128000, task
ffff88013bbac440)
May 25 10:20:29 T02-MON12 kernel: [  159.008009] Stack:
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  0000000000000000
0000000000000080 ffff880139c05800 0000000000000000
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  0000000000000000
ffff88013a193c00 0000000000010000 ffffffffa0270059
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  0000000000000002
0000000008bd1000 000000000001f000 ffff880139c03000
May 25 10:20:29 T02-MON12 kernel: [  159.008009] Call Trace:
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffffa0270059>]
? rbd_rq_fn+0x19c/0x36b [rbd]
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff8121b5fb>]
? __make_request+0x410/0x49d
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff81219a8f>]
? generic_make_request+0x359/0x3c6
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff8100156c>]
? __switch_to+0xd5/0x2a5
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff81219bc8>]
? submit_bio+0xcc/0xd5
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff81049df8>]
? lock_timer_base+0x26/0x4c
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff811cb6ac>]
? run_scheduled_bios+0x2a4/0x49f
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff811d0a33>]
? worker_loop+0x0/0x561
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff811d0bd9>]
? worker_loop+0x1a6/0x561
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff811d0a33>]
? worker_loop+0x0/0x561
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff81056f98>]
? kthread+0x7e/0x86
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff810037e4>]
? kernel_thread_helper+0x4/0x10
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff81056f1a>]
? kthread+0x0/0x86
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  [<ffffffff810037e0>]
? kernel_thread_helper+0x0/0x10
May 25 10:20:29 T02-MON12 kernel: [  159.008009] Code: 46 00 48 85 ed
74 1b 48 8b 7d 08 44 89 f9 4c 89 e2 4c 89 f6 ff 55 00 48 83 c5 10 48
83 7d 00 00 eb e3 66 41 83 7c 24 28 01 74 04 <0f> 0b eb fe 66 41 83 7c
24 2a 00 74 04 0f 0b eb fe c7 83 f0 00
May 25 10:20:29 T02-MON12 kernel: [  159.008009] RIP
[<ffffffff81106bd1>] bio_split+0x84/0x17b
May 25 10:20:29 T02-MON12 kernel: [  159.008009]  RSP <ffff88013a129b10>
May 25 10:20:29 T02-MON12 kernel: [  159.187690] ---[ end trace
7cc886f66dca092a ]---
May 25 10:20:29 T02-MON12 kernel: [  159.191976] libceph:  con_work
ffff880138af5030 start, clearing QUEUED

thanks!
