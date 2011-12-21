From: =?windows-1252?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Subject: Re: BTRFS Warning
Date: Wed, 21 Dec 2011 14:22:07 +0100
Message-ID: <4EF1DD7F.1040802@filoo.de>
References: <4EEEF5C7.7090701@filoo.de> <CAF3hT9Bqoq-sO7m0e-waEcJ6ONRu9rLYoM7ZHck-=f-UaCPqGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-7.de-punkt.de ([93.190.64.37]:49700 "EHLO
	mail-7.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab1LUNWJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2011 08:22:09 -0500
In-Reply-To: <CAF3hT9Bqoq-sO7m0e-waEcJ6ONRu9rLYoM7ZHck-=f-UaCPqGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Am 19.12.2011 19:51, schrieb Gregory Farnum:
> On Mon, Dec 19, 2011 at 12:28 AM, Jens Rehp=F6hler
> <jens.rehpoehler@filoo.de> wrote:
>> Good morning !!
>>
>> i got the following warning as soon as i use btrfs as underlaying
>> filesystem (for stability reasons i use ext4). I converted one OSD b=
ack
>> to btrfs to give it another try.
>>
>> kernel: 3.2rc6
>> ceph: ceph/stable uptodate 0.39-9-g37e7a52-1~bpo60+1
>> dist: debian squeeze
>>
>> [ 8930.692232] ------------[ cut here ]------------
>> [ 8930.692282] WARNING: at fs/btrfs/inode.c:1969
>> btrfs_orphan_commit_root+0x7f/0x9b [btrfs]()
>> [ 8930.692327] Hardware name: X8DT3
>> [ 8930.692349] Modules linked in: loop aes_x86_64 aes_generic cbc
>> kvm_intel xt_multiport ext2 iptable_filter ip_tables vhost_net macvt=
ap
>> macvlan tun brd ebt_arp ebtable_filter ebtables x_tables kvm fuse ce=
ph
>> libceph bridge stp llc ext4 jbd2 crc16 tpm_tis tpm joydev pcspkr ioa=
tdma
>> tpm_bios processor i2c_i801 thermal_sys serio_raw button i2c_core ev=
dev
>> ext3 jbd mbcache btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10d=
if
>> usbhid hid uhci_hcd ehci_hcd usbcore ixgbe 3w_sas mdio usb_common
>> scsi_mod igb dca [last unloaded: scsi_wait_scan]
>> [ 8930.698021] Pid: 336, comm: kworker/2:1 Tainted: G         C
>> 3.2.0-rc6 #2
>> [ 8930.698050] Call Trace:
>> [ 8930.698075]  [<ffffffff81047257>] ? warn_slowpath_common+0x78/0x8=
c
>> [ 8930.698116]  [<ffffffffa011ee22>] ?
>> btrfs_orphan_commit_root+0x7f/0x9b [btrfs]
>> [ 8930.698171]  [<ffffffffa01182f3>] ? commit_fs_roots+0xa2/0x159 [b=
trfs]
>> [ 8930.698208]  [<ffffffffa0118fcd>] ?
>> btrfs_commit_transaction+0x3e2/0x71b [btrfs]
>> [ 8930.698254]  [<ffffffff8103b794>] ? pick_next_task_fair+0xfc/0x10=
e
>> [ 8930.698285]  [<ffffffff81060b69>] ? wake_up_bit+0x20/0x20
>> [ 8930.698320]  [<ffffffffa011952f>] ? btrfs_end_transaction+0x12/0x=
12
>> [btrfs]
>> [ 8930.698361]  [<ffffffffa0119541>] ? do_async_commit+0x12/0x1b [bt=
rfs]
>> [ 8930.698392]  [<ffffffff8105cd0e>] ? process_one_work+0x1cc/0x2ea
>> [ 8930.698420]  [<ffffffff8105cf59>] ? worker_thread+0x12d/0x247
>> [ 8930.698448]  [<ffffffff8105ce2c>] ? process_one_work+0x2ea/0x2ea
>> [ 8930.698476]  [<ffffffff8105ce2c>] ? process_one_work+0x2ea/0x2ea
>> [ 8930.698504]  [<ffffffff8106072d>] ? kthread+0x7a/0x82
>> [ 8930.698531]  [<ffffffff813316b4>] ? kernel_thread_helper+0x4/0x10
>> [ 8930.698560]  [<ffffffff810606b3>] ? kthread_worker_fn+0x147/0x147
>> [ 8930.698588]  [<ffffffff813316b0>] ? gs_change+0x13/0x13
>> [ 8930.698614] ---[ end trace 3b774941bf3fc465 ]---
>>
>> Anything to worry about ?
> This doesn't look familiar to me =97 if you can reproduce it (or mayb=
e
> just provide more detail) the btrfs folks will probably be interested=
=2E
> -Greg

Hi Greg,

reproduction is possible, if i destroy one osd und start a fresh resync
(actual 550 GB of data).
After a short while i get:

Dec 20 19:45:22 fcmsnode4 kernel: [170010.477676] ------------[ cut her=
e
]------------
Dec 20 19:45:22 fcmsnode4 kernel: [170010.477727] WARNING: at
fs/btrfs/inode.c:1969 btrfs_orphan_commit_root+0x7f/0x9b [btrfs]()
Dec 20 19:45:22 fcmsnode4 kernel: [170010.477772] Hardware name: X8DT3
Dec 20 19:45:22 fcmsnode4 kernel: [170010.477795] Modules linked in:
zram(C) dm_mod rbd loop aes_x86_64 aes_generic cbc kvm_intel
xt_multiport ext2 iptable_filter ip_tables vhost_net macvtap macvlan tu=
n
brd ebt_arp ebtable_filter ebtables x_tables kvm fuse ceph libceph
bridge stp llc ext4 jbd2 crc16 tpm_tis tpm joydev pcspkr ioatdma
tpm_bios processor i2c_i801 thermal_sys serio_raw button i2c_core evdev
ext3 jbd mbcache btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10dif
usbhid hid uhci_hcd ehci_hcd usbcore ixgbe 3w_sas mdio usb_common
scsi_mod igb dca [last unloaded: scsi_wait_scan]
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478130] Pid: 6790, comm:
btrfs-transacti Tainted: G        WC   3.2.0-rc6 #2
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478173] Call Trace:
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478199]  [<ffffffff81047257>]
? warn_slowpath_common+0x78/0x8c
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478237]  [<ffffffffa011ee22>]
? btrfs_orphan_commit_root+0x7f/0x9b [btrfs]
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478289]  [<ffffffffa01182f3>]
? commit_fs_roots+0xa2/0x159 [btrfs]
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478332]  [<ffffffff810ece7c>]
? kmem_cache_free+0x12/0x9e
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478377]  [<ffffffffa0118fcd>]
? btrfs_commit_transaction+0x3e2/0x71b [btrfs]
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478423]  [<ffffffff81053026>]
? del_timer_sync+0x34/0x3e
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478453]  [<ffffffff81328237>]
? schedule_timeout+0xa8/0xd7
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478482]  [<ffffffff81060b69>]
? wake_up_bit+0x20/0x20
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478517]  [<ffffffffa0113c8d>]
? transaction_kthread+0x173/0x22d [btrfs]
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478560]  [<ffffffffa0113b1a>]
? find_and_setup_root+0xdc/0xdc [btrfs]
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478600]  [<ffffffffa0113b1a>]
? find_and_setup_root+0xdc/0xdc [btrfs]
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478630]  [<ffffffff8106072d>]
? kthread+0x7a/0x82
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478658]  [<ffffffff813316b4>]
? kernel_thread_helper+0x4/0x10
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478687]  [<ffffffff810606b3>]
? kthread_worker_fn+0x147/0x147
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478716]  [<ffffffff813316b0>]
? gs_change+0x13/0x13
Dec 20 19:45:22 fcmsnode4 kernel: [170010.478742] ---[ end trace
3b774941bf3fc467 ]---
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535021] ------------[ cut her=
e
]------------
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535072] WARNING: at
fs/btrfs/inode.c:1969 btrfs_orphan_commit_root+0x7f/0x9b [btrfs]()
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535117] Hardware name: X8DT3
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535139] Modules linked in:
zram(C) dm_mod rbd loop aes_x86_64 aes_generic cbc kvm_intel
xt_multiport ext2 iptable_filter ip_tables vhost_net macvtap macvlan tu=
n
brd ebt_arp ebtable_filter ebtables x_tables kvm fuse ceph libceph
bridge stp llc ext4 jbd2 crc16 tpm_tis tpm joydev pcspkr ioatdma
tpm_bios processor i2c_i801 thermal_sys serio_raw button i2c_core evdev
ext3 jbd mbcache btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10dif
usbhid hid uhci_hcd ehci_hcd usbcore ixgbe 3w_sas mdio usb_common
scsi_mod igb dca [last unloaded: scsi_wait_scan]
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535471] Pid: 6790, comm:
btrfs-transacti Tainted: G        WC   3.2.0-rc6 #2
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535514] Call Trace:
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535539]  [<ffffffff81047257>]
? warn_slowpath_common+0x78/0x8c
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535577]  [<ffffffffa011ee22>]
? btrfs_orphan_commit_root+0x7f/0x9b [btrfs]
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535629]  [<ffffffffa01182f3>]
? commit_fs_roots+0xa2/0x159 [btrfs]
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535661]  [<ffffffff810ece7c>]
? kmem_cache_free+0x12/0x9e
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535697]  [<ffffffffa0118fcd>]
? btrfs_commit_transaction+0x3e2/0x71b [btrfs]
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535743]  [<ffffffff81053026>]
? del_timer_sync+0x34/0x3e
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535773]  [<ffffffff81328237>]
? schedule_timeout+0xa8/0xd7
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535803]  [<ffffffff81060b69>]
? wake_up_bit+0x20/0x20
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535838]  [<ffffffffa0113c8d>]
? transaction_kthread+0x173/0x22d [btrfs]
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535876]  [<ffffffffa0113b1a>]
? find_and_setup_root+0xdc/0xdc [btrfs]
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535914]  [<ffffffffa0113b1a>]
? find_and_setup_root+0xdc/0xdc [btrfs]
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535944]  [<ffffffff8106072d>]
? kthread+0x7a/0x82
Dec 20 19:48:57 fcmsnode4 kernel: [170225.535971]  [<ffffffff813316b4>]
? kernel_thread_helper+0x4/0x10
Dec 20 19:48:57 fcmsnode4 kernel: [170225.536000]  [<ffffffff810606b3>]
? kthread_worker_fn+0x147/0x147
Dec 20 19:48:57 fcmsnode4 kernel: [170225.536028]  [<ffffffff813316b0>]
? gs_change+0x13/0x13
Dec 20 19:48:57 fcmsnode4 kernel: [170225.536054] ---[ end trace
3b774941bf3fc468 ]---

Seems to me, that this happens if the btrfs is under heavy load.

Thanks and merry christmas !

Jens
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
