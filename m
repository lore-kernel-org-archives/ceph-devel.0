From: =?ISO-8859-15?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Subject: BTRFS Warning
Date: Mon, 19 Dec 2011 09:28:55 +0100
Message-ID: <4EEEF5C7.7090701@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-7.de-punkt.de ([93.190.64.37]:52678 "EHLO
	mail-7.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab1LSI27 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 03:28:59 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: oliver.francke@filoo.de

Good morning !!

i got the following warning as soon as i use btrfs as underlaying
filesystem (for stability reasons i use ext4). I converted one OSD back
to btrfs to give it another try.

kernel: 3.2rc6
ceph: ceph/stable uptodate 0.39-9-g37e7a52-1~bpo60+1
dist: debian squeeze

[ 8930.692232] ------------[ cut here ]------------
[ 8930.692282] WARNING: at fs/btrfs/inode.c:1969
btrfs_orphan_commit_root+0x7f/0x9b [btrfs]()
[ 8930.692327] Hardware name: X8DT3
[ 8930.692349] Modules linked in: loop aes_x86_64 aes_generic cbc
kvm_intel xt_multiport ext2 iptable_filter ip_tables vhost_net macvtap
macvlan tun brd ebt_arp ebtable_filter ebtables x_tables kvm fuse ceph
libceph bridge stp llc ext4 jbd2 crc16 tpm_tis tpm joydev pcspkr ioatdma
tpm_bios processor i2c_i801 thermal_sys serio_raw button i2c_core evdev
ext3 jbd mbcache btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10dif
usbhid hid uhci_hcd ehci_hcd usbcore ixgbe 3w_sas mdio usb_common
scsi_mod igb dca [last unloaded: scsi_wait_scan]
[ 8930.698021] Pid: 336, comm: kworker/2:1 Tainted: G         C  
3.2.0-rc6 #2
[ 8930.698050] Call Trace:
[ 8930.698075]  [<ffffffff81047257>] ? warn_slowpath_common+0x78/0x8c
[ 8930.698116]  [<ffffffffa011ee22>] ?
btrfs_orphan_commit_root+0x7f/0x9b [btrfs]
[ 8930.698171]  [<ffffffffa01182f3>] ? commit_fs_roots+0xa2/0x159 [btrfs]
[ 8930.698208]  [<ffffffffa0118fcd>] ?
btrfs_commit_transaction+0x3e2/0x71b [btrfs]
[ 8930.698254]  [<ffffffff8103b794>] ? pick_next_task_fair+0xfc/0x10e
[ 8930.698285]  [<ffffffff81060b69>] ? wake_up_bit+0x20/0x20
[ 8930.698320]  [<ffffffffa011952f>] ? btrfs_end_transaction+0x12/0x12
[btrfs]
[ 8930.698361]  [<ffffffffa0119541>] ? do_async_commit+0x12/0x1b [btrfs]
[ 8930.698392]  [<ffffffff8105cd0e>] ? process_one_work+0x1cc/0x2ea
[ 8930.698420]  [<ffffffff8105cf59>] ? worker_thread+0x12d/0x247
[ 8930.698448]  [<ffffffff8105ce2c>] ? process_one_work+0x2ea/0x2ea
[ 8930.698476]  [<ffffffff8105ce2c>] ? process_one_work+0x2ea/0x2ea
[ 8930.698504]  [<ffffffff8106072d>] ? kthread+0x7a/0x82
[ 8930.698531]  [<ffffffff813316b4>] ? kernel_thread_helper+0x4/0x10
[ 8930.698560]  [<ffffffff810606b3>] ? kthread_worker_fn+0x147/0x147
[ 8930.698588]  [<ffffffff813316b0>] ? gs_change+0x13/0x13
[ 8930.698614] ---[ end trace 3b774941bf3fc465 ]---

Anything to worry about ?

thanks

Jens
