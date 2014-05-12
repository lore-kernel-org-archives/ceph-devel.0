From: Hannes Landeholm <hannes@jumpstarter.io>
Subject: Re: crash in rbd_img_request_create
Date: Mon, 12 May 2014 19:28:46 +0200
Message-ID: <CABt9es8snhMJ5jg9OkiYVmXU6iX9aj3jAG8_XL1Th_BmJpgonQ@mail.gmail.com>
References: <CABt9es_QVVHR30D+VyKyn+gr=0pHahwwvZAbXAvG78ixX9t86w@mail.gmail.com>
	<536EEA5C.70503@ieee.org>
	<CALFYKtBXLKhm1HvwK=FGQpJdx_TMaWE_7a0s6Qo7=9vdcsjkkw@mail.gmail.com>
	<53704F70.3090800@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:49051 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759301AbaELR2s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 May 2014 13:28:48 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so7651404lbg.4
        for <ceph-devel@vger.kernel.org>; Mon, 12 May 2014 10:28:46 -0700 (PDT)
In-Reply-To: <53704F70.3090800@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>, Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Thorwald Lundqvist <thorwald@jumpstarter.io>

FYI, we just saw two other kernel paging failures unrelated to rbd, so
rbd might have been the victim and not the culprit:

May 12 17:43:20 localhost kernel: BUG: unable to handle kernel paging
request at ffffffff81666480
May 12 17:43:20 localhost kernel: IP: [<ffffffff810b0b2b>] mspin_lock+0x2b/0x40
May 12 17:43:20 localhost kernel: PGD 180f067 PUD 1810063 PMD 80000000016001e1
May 12 17:43:20 localhost kernel: Oops: 0003 [#1] PREEMPT SMP
May 12 17:43:20 localhost kernel: Modules linked in: xt_recent
xt_conntrack ipt_REJECT xt_limit xt_tcpudp iptable_filter veth
ipt_MASQUERADE iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 nf_nat nf_conntrack ip_tables x_tables cbc bridge stp llc
zfs(PO) zunicode(PO) zavl(PO) zcommon(PO) znvpair(PO) spl(O) co
retemp x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm iTCO_wdt
iTCO_vendor_support evdev mac_hid crct10dif_pclmul crc32_pclmul
crc32c_intel ghash_clmulni_intel aesni_intel ast aes_x86_64 lrw
gf128mul glue_helper ttm ablk_helper cryptd drm_kms_helper igb
microcode drm psmouse ptp pps_core hwmon serio_raw dca pcspk
r syscopyarea i2c_i801 sysfillrect sysimgblt i2c_algo_bit i2c_core
lpc_ich fan thermal ipmi_si battery ipmi_msghandler video mei_me
shpchp mei tpm_infineon tpm_tis tpm button processor rbd libceph
May 12 17:43:20 localhost kernel:  crc32c libcrc32c ext4 crc16 mbcache
jbd2 sd_mod sr_mod crc_t10dif cdrom crct10dif_common atkbd libps2 ahci
libahci libata ehci_pci xhci_hcd ehci_hcd scsi_mod usbcore usb_common
i8042 serio
May 12 17:43:20 localhost kernel: CPU: 1 PID: 22265 Comm: proc1
Tainted: P           O 3.14.1-1-js #1
May 12 17:43:20 localhost kernel: Hardware name: ASUSTeK COMPUTER INC.
RS100-E8-PI2/P9D-M Series, BIOS 0302 05/10/2013
May 12 17:43:20 localhost kernel: task: ffff88007a5909d0 ti:
ffff8802ba42c000 task.ti: ffff8802ba42c000
May 12 17:43:20 localhost kernel: RIP: 0010:[<ffffffff810b0b2b>]
[<ffffffff810b0b2b>] mspin_lock+0x2b/0x40
May 12 17:43:20 localhost kernel: RSP: 0018:ffff8802ba42de00  EFLAGS: 00010282
May 12 17:43:20 localhost kernel: RAX: ffffffff81666480 RBX:
ffff8802c8a9bc08 RCX: 00000000ffffffff
May 12 17:43:20 localhost kernel: RDX: 0000000000000000 RSI:
ffff8802ba42de10 RDI: ffff8802c8a9bc28
May 12 17:43:20 localhost kernel: RBP: ffff8802ba42de00 R08:
0000000000000000 R09: 0000000000000000
May 12 17:43:20 localhost kernel: R10: 0000000000000002 R11:
0000000000000400 R12: 000000008189ad60
May 12 17:43:20 localhost kernel: R13: ffff8802c8a9bc28 R14:
ffff88007a5909d0 R15: ffff8802ba42dfd8
May 12 17:43:20 localhost kernel: FS:  00007f86df906df0(0000)
GS:ffff88042fc40000(0000) knlGS:0000000000000000
May 12 17:43:20 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
May 12 17:43:20 localhost kernel: CR2: ffffffff81666480 CR3:
00000002e3378000 CR4: 00000000001407e0
May 12 17:43:20 localhost kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
May 12 17:43:20 localhost kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
May 12 17:43:20 localhost kernel: Stack:
May 12 17:43:20 localhost kernel:  ffff8802ba42de58 ffffffff814dce6d
0000000000000000 ffff880000000000
May 12 17:43:20 localhost kernel:  ffff880419518660 ffff8802ba42de40
ffff8802c8a9bc08 ffff8802c8a9bc08
May 12 17:43:20 localhost kernel:  ffff8802c8a9bc00 ffff88008d0589d8
ffff880419518660 ffff8802ba42de70
May 12 17:43:20 localhost kernel: Call Trace:
May 12 17:43:20 localhost kernel:  [<ffffffff814dce6d>]
__mutex_lock_slowpath+0x6d/0x1f0
May 12 17:43:20 localhost kernel:  [<ffffffff814dd007>] mutex_lock+0x17/0x27
May 12 17:43:20 localhost kernel:  [<ffffffff811ed170>]
eventpoll_release_file+0x50/0xa0
May 12 17:43:20 localhost kernel:  [<ffffffff811a8273>] __fput+0x1f3/0x220
May 12 17:43:20 localhost kernel:  [<ffffffff811a82ee>] ____fput+0xe/0x10
May 12 17:43:20 localhost kernel:  [<ffffffff810848cf>] task_work_run+0x9f/0xe0
May 12 17:43:20 localhost kernel:  [<ffffffff81015adc>]
do_notify_resume+0x8c/0xa0
May 12 17:43:20 localhost kernel:  [<ffffffff814e6920>] int_signal+0x12/0x17
May 12 17:43:20 localhost kernel: Code: 0f 1f 44 00 00 55 c7 46 08 00
00 00 00 48 89 f0 48 c7 06 00 00 00 00 48 89 e5 48 87 07 48 85 c0 75
09 c7 46 08 01 00 00 00 5d c3 <48> 89 30 8b 46 08 85 c0 75 f4 f3 90 8b
46 08 85 c0 74 f7 5d c3
May 12 17:43:20 localhost kernel: RIP  [<ffffffff810b0b2b>] mspin_lock+0x2b/0x40
May 12 17:43:20 localhost kernel:  RSP <ffff8802ba42de00>
May 12 17:43:20 localhost kernel: CR2: ffffffff81666480
May 12 17:43:20 localhost kernel: ---[ end trace 60b4ebe6d1932f8a ]---
May 12 17:43:20 localhost kernel: note: proc1[22265] exited with preempt_count 1

----

May 12 17:43:50 localhost kernel: kernel tried to execute NX-protected
page - exploit attempt? (uid: 0)
May 12 17:43:50 localhost kernel: BUG: unable to handle kernel paging
request at ffff880419518660
May 12 17:43:50 localhost kernel: IP: [<ffff880419518660>] 0xffff880419518660
May 12 17:43:50 localhost kernel: PGD 1b28067 PUD 1b2b067 PMD 80000004194001e3
May 12 17:43:50 localhost kernel: Oops: 0011 [#2] PREEMPT SMP
May 12 17:43:50 localhost kernel: Modules linked in: xt_recent
xt_conntrack ipt_REJECT xt_limit xt_tcpudp iptable_filter veth
ipt_MASQUERADE iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 nf_nat nf_conntrack ip_tables x_tables cbc bridge stp llc
zfs(PO) zunicode(PO) zavl(PO) zcommon(PO) znvpair(PO) spl(O) coretemp
x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm iTCO_wdt
iTCO_vendor_support evdev mac_hid crct10dif_pclmul crc32_pclmul
crc32c_intel ghash_clmulni_intel aesni_intel ast aes_x86_64 lrw
gf128mul glue_helper ttm ablk_helper cryptd drm_kms_helper igb
microcode drm psmouse ptp pps_core hwmon serio_raw dca pcspkr
syscopyarea i2c_i801 sysfillrect sysimgblt i2c_algo_bit i2c_core
lpc_ich fan thermal ipmi_si battery ipmi_msghandler video mei_me
shpchp mei tpm_infineon tpm_tis tpm button processor rbd libceph
May 12 17:43:50 localhost kernel:  crc32c libcrc32c ext4 crc16 mbcache
jbd2 sd_mod sr_mod crc_t10dif cdrom crct10dif_common atkbd libps2 ahci
libahci libata ehci_pci xhci_hcd ehci_hcd scsi_mod usbcore usb_common
i8042 serio
May 12 17:43:50 localhost kernel: CPU: 3 PID: 22285 Comm: proc2
Tainted: P      D    O 3.14.1-1-js #1
May 12 17:43:50 localhost kernel: Hardware name: ASUSTeK COMPUTER INC.
RS100-E8-PI2/P9D-M Series, BIOS 0302 05/10/2013
May 12 17:43:50 localhost kernel: task: ffff8803070c4e80 ti:
ffff8802ba4d2000 task.ti: ffff8802ba4d2000
May 12 17:43:50 localhost kernel: RIP: 0010:[<ffff880419518660>]
[<ffff880419518660>] 0xffff880419518660
May 12 17:43:50 localhost kernel: RSP: 0018:ffff8802ba4d3c78  EFLAGS: 00010246
May 12 17:43:50 localhost kernel: RAX: ffff8802ba42de10 RBX:
ffff8802c8a9bc00 RCX: 0000000000000246
May 12 17:43:50 localhost kernel: RDX: ffff8802ba4d3cb8 RSI:
ffff8802c8a9bc00 RDI: ffff88015075b200
May 12 17:43:50 localhost kernel: RBP: ffff8802ba4d3ca8 R08:
ffff8803070c4e80 R09: ffff88011e9fc018
May 12 17:43:50 localhost kernel: R10: 00000000ffffffff R11:
0000000000000202 R12: ffff88015075b200
May 12 17:43:50 localhost kernel: R13: ffff8802ba4d3cb8 R14:
0000000000000000 R15: ffff88015b6d8700
May 12 17:43:50 localhost kernel: FS:  00007fff346793e0(0000)
GS:ffff88042fcc0000(0000) knlGS:0000000000000000
May 12 17:43:50 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
May 12 17:43:50 localhost kernel: CR2: ffff880419518660 CR3:
000000031150c000 CR4: 00000000001407e0
May 12 17:43:50 localhost kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
May 12 17:43:50 localhost kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
May 12 17:43:50 localhost kernel: Stack:
May 12 17:43:50 localhost kernel:  ffffffff813d03a0 ffff88011e9fc000
ffff88011e9fc018 ffff8802ba4d3cf0
May 12 17:43:50 localhost kernel:  ffff8802ba4d3d08 ffff8802c26316c0
ffff8802ba4d3ce8 ffffffff811ec07d
May 12 17:43:50 localhost kernel:  0000000000000000 0000000080002018
ffffffff811ebff0 ffff8802ba4d3d08
May 12 17:43:50 localhost kernel: Call Trace:
May 12 17:43:50 localhost kernel:  [<ffffffff813d03a0>] ? sock_poll+0x110/0x120
May 12 17:43:50 localhost kernel:  [<ffffffff811ec07d>]
ep_read_events_proc+0x8d/0xc0
May 12 17:43:50 localhost kernel:  [<ffffffff811ebff0>] ?
ep_show_fdinfo+0xa0/0xa0
May 12 17:43:50 localhost kernel:  [<ffffffff811ec80a>]
ep_scan_ready_list.isra.12+0x8a/0x1c0
May 12 17:43:50 localhost kernel:  [<ffffffff811ec940>] ?
ep_scan_ready_list.isra.12+0x1c0/0x1c0
May 12 17:43:50 localhost kernel:  [<ffffffff811ec95e>]
ep_poll_readyevents_proc+0x1e/0x20
May 12 17:43:50 localhost kernel:  [<ffffffff811ec493>]
ep_call_nested.constprop.13+0xb3/0x110
May 12 17:43:50 localhost kernel:  [<ffffffff811ece83>]
ep_eventpoll_poll+0x63/0xa0
May 12 17:43:50 localhost kernel:  [<ffffffff811ec157>]
ep_send_events_proc+0xa7/0x1c0
May 12 17:43:50 localhost kernel:  [<ffffffff811ec0b0>] ?
ep_read_events_proc+0xc0/0xc0
May 12 17:43:50 localhost kernel:  [<ffffffff811ec80a>]
ep_scan_ready_list.isra.12+0x8a/0x1c0
May 12 17:43:50 localhost kernel:  [<ffffffff811eca73>] ep_poll+0x113/0x340
May 12 17:43:50 localhost kernel:  [<ffffffff811c239e>] ? __fget+0x6e/0xb0
May 12 17:43:50 localhost kernel:  [<ffffffff811ee015>] SyS_epoll_wait+0xb5/0xe0
May 12 17:43:50 localhost kernel:  [<ffffffff814e66e9>]
system_call_fastpath+0x16/0x1b
May 12 17:43:50 localhost kernel: Code: 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40 86 51 19 04 88
ff ff 80 87 c0 1e 04 88 ff ff <80> 87 c0 1e 04 88 ff ff 00 c8 52 19 04
88 ff ff 00 40 00 00 00
May 12 17:43:50 localhost kernel: RIP  [<ffff880419518660>] 0xffff880419518660
May 12 17:43:50 localhost kernel:  RSP <ffff8802ba4d3c78>
May 12 17:43:50 localhost kernel: CR2: ffff880419518660
May 12 17:43:50 localhost kernel: ---[ end trace 60b4ebe6d1932f8b ]---

The above happened when I was killing some stress-test processes that
used a lot of memory with CTRL+C (SIGINT). In two instances this
caused kernel paging failures in the two unrelated processes above
(used for a different stress test), so something is probably horribly
wrong with the memory manager state in the kernel. Maybe some module
is doing double free or similar causing memory to be shared between
different contexts when it's allocated? Right now my guess would be
that ZFS is the problem as it is known for poorly integrating with the
kernel memory wise. We where experimenting to use ZFS as a backend for
CEPH just to see what the performance and storage saving
characteristics was like but we're gonna completely switch to ext4 now
and see if the problem goes away.

Thank you for your time,
Hannes
