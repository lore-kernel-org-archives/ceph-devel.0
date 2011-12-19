From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: BTRFS Warning
Date: Mon, 19 Dec 2011 10:51:07 -0800
Message-ID: <CAF3hT9Bqoq-sO7m0e-waEcJ6ONRu9rLYoM7ZHck-=f-UaCPqGg@mail.gmail.com>
References: <4EEEF5C7.7090701@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42656 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab1LSSvH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 13:51:07 -0500
Received: by iaeh11 with SMTP id h11so8933970iae.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2011 10:51:07 -0800 (PST)
In-Reply-To: <4EEEF5C7.7090701@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Cc: ceph-devel@vger.kernel.org, oliver.francke@filoo.de

On Mon, Dec 19, 2011 at 12:28 AM, Jens Rehp=F6hler
<jens.rehpoehler@filoo.de> wrote:
> Good morning !!
>
> i got the following warning as soon as i use btrfs as underlaying
> filesystem (for stability reasons i use ext4). I converted one OSD ba=
ck
> to btrfs to give it another try.
>
> kernel: 3.2rc6
> ceph: ceph/stable uptodate 0.39-9-g37e7a52-1~bpo60+1
> dist: debian squeeze
>
> [ 8930.692232] ------------[ cut here ]------------
> [ 8930.692282] WARNING: at fs/btrfs/inode.c:1969
> btrfs_orphan_commit_root+0x7f/0x9b [btrfs]()
> [ 8930.692327] Hardware name: X8DT3
> [ 8930.692349] Modules linked in: loop aes_x86_64 aes_generic cbc
> kvm_intel xt_multiport ext2 iptable_filter ip_tables vhost_net macvta=
p
> macvlan tun brd ebt_arp ebtable_filter ebtables x_tables kvm fuse cep=
h
> libceph bridge stp llc ext4 jbd2 crc16 tpm_tis tpm joydev pcspkr ioat=
dma
> tpm_bios processor i2c_i801 thermal_sys serio_raw button i2c_core evd=
ev
> ext3 jbd mbcache btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10di=
f
> usbhid hid uhci_hcd ehci_hcd usbcore ixgbe 3w_sas mdio usb_common
> scsi_mod igb dca [last unloaded: scsi_wait_scan]
> [ 8930.698021] Pid: 336, comm: kworker/2:1 Tainted: G =A0 =A0 =A0 =A0=
 C
> 3.2.0-rc6 #2
> [ 8930.698050] Call Trace:
> [ 8930.698075] =A0[<ffffffff81047257>] ? warn_slowpath_common+0x78/0x=
8c
> [ 8930.698116] =A0[<ffffffffa011ee22>] ?
> btrfs_orphan_commit_root+0x7f/0x9b [btrfs]
> [ 8930.698171] =A0[<ffffffffa01182f3>] ? commit_fs_roots+0xa2/0x159 [=
btrfs]
> [ 8930.698208] =A0[<ffffffffa0118fcd>] ?
> btrfs_commit_transaction+0x3e2/0x71b [btrfs]
> [ 8930.698254] =A0[<ffffffff8103b794>] ? pick_next_task_fair+0xfc/0x1=
0e
> [ 8930.698285] =A0[<ffffffff81060b69>] ? wake_up_bit+0x20/0x20
> [ 8930.698320] =A0[<ffffffffa011952f>] ? btrfs_end_transaction+0x12/0=
x12
> [btrfs]
> [ 8930.698361] =A0[<ffffffffa0119541>] ? do_async_commit+0x12/0x1b [b=
trfs]
> [ 8930.698392] =A0[<ffffffff8105cd0e>] ? process_one_work+0x1cc/0x2ea
> [ 8930.698420] =A0[<ffffffff8105cf59>] ? worker_thread+0x12d/0x247
> [ 8930.698448] =A0[<ffffffff8105ce2c>] ? process_one_work+0x2ea/0x2ea
> [ 8930.698476] =A0[<ffffffff8105ce2c>] ? process_one_work+0x2ea/0x2ea
> [ 8930.698504] =A0[<ffffffff8106072d>] ? kthread+0x7a/0x82
> [ 8930.698531] =A0[<ffffffff813316b4>] ? kernel_thread_helper+0x4/0x1=
0
> [ 8930.698560] =A0[<ffffffff810606b3>] ? kthread_worker_fn+0x147/0x14=
7
> [ 8930.698588] =A0[<ffffffff813316b0>] ? gs_change+0x13/0x13
> [ 8930.698614] ---[ end trace 3b774941bf3fc465 ]---
>
> Anything to worry about ?

This doesn't look familiar to me =97 if you can reproduce it (or maybe
just provide more detail) the btrfs folks will probably be interested.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
