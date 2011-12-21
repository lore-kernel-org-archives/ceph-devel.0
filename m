From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: BTRFS Warning
Date: Wed, 21 Dec 2011 08:25:13 -0800
Message-ID: <CAF3hT9A23kxPB08dx=-dRqxxB-gyb8FWYwqy36CvEooQQB9EDQ@mail.gmail.com>
References: <4EEEF5C7.7090701@filoo.de>
	<CAF3hT9Bqoq-sO7m0e-waEcJ6ONRu9rLYoM7ZHck-=f-UaCPqGg@mail.gmail.com>
	<4EF1DD7F.1040802@filoo.de>
	<CAO47_-93b=xQBkid2Xkb+KFmKhiZpqvi=DCjNQXg=S5ryda20w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62696 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab1LUQZP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2011 11:25:15 -0500
Received: by iaeh11 with SMTP id h11so12094527iae.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Dec 2011 08:25:14 -0800 (PST)
In-Reply-To: <CAO47_-93b=xQBkid2Xkb+KFmKhiZpqvi=DCjNQXg=S5ryda20w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: =?ISO-8859-1?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>, ceph-devel@vger.kernel.org

On Wed, Dec 21, 2011 at 7:35 AM, Christian Brunner <chb@muc.de> wrote:
> 2011/12/21 Jens Rehp=F6hler <jens.rehpoehler@filoo.de>:
>> Am 19.12.2011 19:51, schrieb Gregory Farnum:
>>> On Mon, Dec 19, 2011 at 12:28 AM, Jens Rehp=F6hler
>>> <jens.rehpoehler@filoo.de> wrote:
>>>> Good morning !!
>>>>
>>>> i got the following warning as soon as i use btrfs as underlaying
>>>> filesystem (for stability reasons i use ext4). I converted one OSD=
 back
>>>> to btrfs to give it another try.
>>>>
>>>> kernel: 3.2rc6
>>>> ceph: ceph/stable uptodate 0.39-9-g37e7a52-1~bpo60+1
>>>> dist: debian squeeze
>>>>
>>>> [...]
>>>>
>>>> Anything to worry about ?
>>> This doesn't look familiar to me =97 if you can reproduce it (or ma=
ybe
>>> just provide more detail) the btrfs folks will probably be interest=
ed.
>>> -Greg
>>
>> Hi Greg,
>>
>> reproduction is possible, if i destroy one osd und start a fresh res=
ync
>> (actual 550 GB of data).
>> After a short while i get:
>>
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.477676] ------------[ cut =
here
>> ]------------
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.477727] WARNING: at
>> fs/btrfs/inode.c:1969 btrfs_orphan_commit_root+0x7f/0x9b [btrfs]()
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.477772] Hardware name: X8D=
T3
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.477795] Modules linked in:
>> zram(C) dm_mod rbd loop aes_x86_64 aes_generic cbc kvm_intel
>> xt_multiport ext2 iptable_filter ip_tables vhost_net macvtap macvlan=
 tun
>> brd ebt_arp ebtable_filter ebtables x_tables kvm fuse ceph libceph
>> bridge stp llc ext4 jbd2 crc16 tpm_tis tpm joydev pcspkr ioatdma
>> tpm_bios processor i2c_i801 thermal_sys serio_raw button i2c_core ev=
dev
>> ext3 jbd mbcache btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10d=
if
>> usbhid hid uhci_hcd ehci_hcd usbcore ixgbe 3w_sas mdio usb_common
>> scsi_mod igb dca [last unloaded: scsi_wait_scan]
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478130] Pid: 6790, comm:
>> btrfs-transacti Tainted: G =A0 =A0 =A0 =A0WC =A0 3.2.0-rc6 #2
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478173] Call Trace:
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478199] =A0[<ffffffff81047=
257>]
>> ? warn_slowpath_common+0x78/0x8c
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478237] =A0[<ffffffffa011e=
e22>]
>> ? btrfs_orphan_commit_root+0x7f/0x9b [btrfs]
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478289] =A0[<ffffffffa0118=
2f3>]
>> ? commit_fs_roots+0xa2/0x159 [btrfs]
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478332] =A0[<ffffffff810ec=
e7c>]
>> ? kmem_cache_free+0x12/0x9e
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478377] =A0[<ffffffffa0118=
fcd>]
>> ? btrfs_commit_transaction+0x3e2/0x71b [btrfs]
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478423] =A0[<ffffffff81053=
026>]
>> ? del_timer_sync+0x34/0x3e
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478453] =A0[<ffffffff81328=
237>]
>> ? schedule_timeout+0xa8/0xd7
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478482] =A0[<ffffffff81060=
b69>]
>> ? wake_up_bit+0x20/0x20
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478517] =A0[<ffffffffa0113=
c8d>]
>> ? transaction_kthread+0x173/0x22d [btrfs]
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478560] =A0[<ffffffffa0113=
b1a>]
>> ? find_and_setup_root+0xdc/0xdc [btrfs]
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478600] =A0[<ffffffffa0113=
b1a>]
>> ? find_and_setup_root+0xdc/0xdc [btrfs]
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478630] =A0[<ffffffff81060=
72d>]
>> ? kthread+0x7a/0x82
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478658] =A0[<ffffffff81331=
6b4>]
>> ? kernel_thread_helper+0x4/0x10
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478687] =A0[<ffffffff81060=
6b3>]
>> ? kthread_worker_fn+0x147/0x147
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478716] =A0[<ffffffff81331=
6b0>]
>> ? gs_change+0x13/0x13
>> Dec 20 19:45:22 fcmsnode4 kernel: [170010.478742] ---[ end trace
>> 3b774941bf3fc467 ]---
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535021] ------------[ cut =
here
>> ]------------
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535072] WARNING: at
>> fs/btrfs/inode.c:1969 btrfs_orphan_commit_root+0x7f/0x9b [btrfs]()
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535117] Hardware name: X8D=
T3
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535139] Modules linked in:
>> zram(C) dm_mod rbd loop aes_x86_64 aes_generic cbc kvm_intel
>> xt_multiport ext2 iptable_filter ip_tables vhost_net macvtap macvlan=
 tun
>> brd ebt_arp ebtable_filter ebtables x_tables kvm fuse ceph libceph
>> bridge stp llc ext4 jbd2 crc16 tpm_tis tpm joydev pcspkr ioatdma
>> tpm_bios processor i2c_i801 thermal_sys serio_raw button i2c_core ev=
dev
>> ext3 jbd mbcache btrfs zlib_deflate crc32c libcrc32c sd_mod crc_t10d=
if
>> usbhid hid uhci_hcd ehci_hcd usbcore ixgbe 3w_sas mdio usb_common
>> scsi_mod igb dca [last unloaded: scsi_wait_scan]
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535471] Pid: 6790, comm:
>> btrfs-transacti Tainted: G =A0 =A0 =A0 =A0WC =A0 3.2.0-rc6 #2
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535514] Call Trace:
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535539] =A0[<ffffffff81047=
257>]
>> ? warn_slowpath_common+0x78/0x8c
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535577] =A0[<ffffffffa011e=
e22>]
>> ? btrfs_orphan_commit_root+0x7f/0x9b [btrfs]
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535629] =A0[<ffffffffa0118=
2f3>]
>> ? commit_fs_roots+0xa2/0x159 [btrfs]
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535661] =A0[<ffffffff810ec=
e7c>]
>> ? kmem_cache_free+0x12/0x9e
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535697] =A0[<ffffffffa0118=
fcd>]
>> ? btrfs_commit_transaction+0x3e2/0x71b [btrfs]
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535743] =A0[<ffffffff81053=
026>]
>> ? del_timer_sync+0x34/0x3e
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535773] =A0[<ffffffff81328=
237>]
>> ? schedule_timeout+0xa8/0xd7
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535803] =A0[<ffffffff81060=
b69>]
>> ? wake_up_bit+0x20/0x20
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535838] =A0[<ffffffffa0113=
c8d>]
>> ? transaction_kthread+0x173/0x22d [btrfs]
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535876] =A0[<ffffffffa0113=
b1a>]
>> ? find_and_setup_root+0xdc/0xdc [btrfs]
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535914] =A0[<ffffffffa0113=
b1a>]
>> ? find_and_setup_root+0xdc/0xdc [btrfs]
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535944] =A0[<ffffffff81060=
72d>]
>> ? kthread+0x7a/0x82
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.535971] =A0[<ffffffff81331=
6b4>]
>> ? kernel_thread_helper+0x4/0x10
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.536000] =A0[<ffffffff81060=
6b3>]
>> ? kthread_worker_fn+0x147/0x147
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.536028] =A0[<ffffffff81331=
6b0>]
>> ? gs_change+0x13/0x13
>> Dec 20 19:48:57 fcmsnode4 kernel: [170225.536054] ---[ end trace
>> 3b774941bf3fc468 ]---
>>
>> Seems to me, that this happens if the btrfs is under heavy load.
>
> I was thinking that everyone using ceph on btrfs is hitting this
> WARNING sooner or later.
>
> We have seen this a long time ago:
>
> http://tracker.newdream.net/issues/563
>
> There were several threads on the btrfs list, but there is no solutio=
n
> yet. Here is one for example:
>
> http://comments.gmane.org/gmane.comp.file-systems.btrfs/14193
>
> The good news is, that I haven't experienced any problems that I coul=
d
> relate to this warning. (Which doesn't mean that I am happy with the
> current state of btrfs).

Well the backtrace is different from in that bug, and not one I
remember =97=A0but I don't know btrfs real well and I'm not sure which
functions are the important ones there. It certainly *could* be the
same thing; maybe somebody who's written btrfs patches would know...
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
