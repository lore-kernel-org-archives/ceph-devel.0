From: Christian Brunner <chb@muc.de>
Subject: Re: btrfs-work master repo
Date: Mon, 14 Nov 2011 09:23:00 +0100
Message-ID: <CAO47_-_NLemDp8115qmh-FeFszKcJ07saZmd4VJ0rJ5Y7PFsSw@mail.gmail.com>
References: <CAO47_-9XWh+p1WZ_UDOnLUCe88N3t4Kz3P26jL--48hDfKCb5g@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55895 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab1KNIXA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 03:23:00 -0500
Received: by vws1 with SMTP id 1so4860315vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2011 00:23:00 -0800 (PST)
In-Reply-To: <CAO47_-9XWh+p1WZ_UDOnLUCe88N3t4Kz3P26jL--48hDfKCb5g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josef Bacik <josef@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi Josef,

sorry, I've to correct this. The warning is still there:

[12648.951991] ------------[ cut here ]------------
[12648.957288] WARNING: at fs/btrfs/inode.c:1968
btrfs_orphan_commit_root+0xb0/0xc0 [btrfs]()
[12648.966707] Hardware name: ProLiant DL180 G6
[12648.971858] Modules linked in: btrfs zlib_deflate libcrc32c sunrpc
bonding ipv6 sr_mod cdrom sg serio_raw pcspkr ghes hed iTCO_wdt
iTCO_vendor_support ixgbe dca mdio i7core_edac edac_core
iomemory_vsl(P) hpsa squashfs usb_storage [last unloaded:
scsi_wait_scan]
[12649.000417] Pid: 2280, comm: ceph-osd Tainted: P        W
3.0.8-1.fits.4.el6.x86_64 #1
[12649.009629] Call Trace:
[12649.012484]  [<ffffffff8106334f>] warn_slowpath_common+0x7f/0xc0
[12649.019371]  [<ffffffff810633aa>] warn_slowpath_null+0x1a/0x20
[12649.026081]  [<ffffffffa02a6b30>] btrfs_orphan_commit_root+0xb0/0xc0=
 [btrfs]
[12649.034132]  [<ffffffffa02a22f5>] commit_fs_roots+0xc5/0x1b0 [btrfs]
[12649.041371]  [<ffffffff8154c241>] ? mutex_lock+0x31/0x60
[12649.047427]  [<ffffffffa0281f8a>] ? btrfs_free_path+0x2a/0x40 [btrfs=
]
[12649.054793]  [<ffffffffa02a3236>]
btrfs_commit_transaction+0x3c6/0x890 [btrfs]
[12649.063052]  [<ffffffffa02a2658>] ? wait_current_trans+0x28/0x110 [b=
trfs]
[12649.070824]  [<ffffffffa02a381b>] ? join_transaction+0x2b/0x260 [btr=
fs]
[12649.078391]  [<ffffffff81086310>] ? wake_up_bit+0x40/0x40
[12649.084638]  [<ffffffffa027e2f9>] btrfs_sync_fs+0x59/0xd0 [btrfs]
[12649.091647]  [<ffffffffa02d19cd>] btrfs_ioctl+0x47d/0x1050 [btrfs]
[12649.098728]  [<ffffffff8125ec90>] ? inode_has_perm+0x30/0x40
[12649.105179]  [<ffffffff8126199c>] ? file_has_perm+0xdc/0xf0
[12649.111601]  [<ffffffff811707da>] do_vfs_ioctl+0x9a/0x5a0
[12649.117801]  [<ffffffff81170d81>] sys_ioctl+0xa1/0xb0
[12649.123624]  [<ffffffff81555702>] system_call_fastpath+0x16/0x1b
[12649.130482] ---[ end trace 6f256945fc353904 ]---

To aid debuging, I can also send you an ftrace with btrfs events and
function_graph enabled. Just tell me if you need it.

Thanks,
Christian

2011/11/13 Christian Brunner <chb@muc.de>:
> Hi Josef,
>
> I've patched one of our ceph nodes with the stuff in your master repo
> (including lxo's patches).
>
> The WARNING in inode.c seems to be gone now, but load is still going
> up after a day.
>
> Another thing I've witnessed is that I'm getting a new warning, when =
I
> umount the filesystem (see below).
>
> I just wanted to tell you, hoping that this gives you a hint what's g=
oing on.
>
> Regards,
> Christian
>
>
> [126852.379582] ------------[ cut here ]------------
> [126852.384892] WARNING: at fs/btrfs/extent-tree.c:7177
> btrfs_free_block_groups+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A00x1f3/0x2e0
> [btrfs]()
> [126852.394937] Hardware name: ProLiant DL180 G6
> [126852.400045] Modules linked in: btrfs zlib_deflate libcrc32c sunrp=
c
> bonding i =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0pv6 sr_mod cdrom sg serio_raw
> pcspkr ghes hed iTCO_wdt iTCO_vendor_support i7cor
> =A0 =A0 =A0 =A0 =A0 e_edac edac_core ixgbe dca mdio hpsa squashfs usb=
_storage
> [last unloaded: iomemo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0ry_vsl]
> [126852.425695] Pid: 23308, comm: umount Tainted: P =A0 =A0 =A0 =A0W
> 3.0.8-1.fits.4.el =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A06.x86_64 #1
> [126852.434769] Call Trace:
> [126852.437648] =A0[<ffffffff8106334f>] warn_slowpath_common+0x7f/0xc=
0
> [126852.444508] =A0[<ffffffffa028db31>] ?
> btrfs_free_block_groups+0x211/0x2e0 [btr
> =A0fs]
> [126852.452808] =A0[<ffffffff810633aa>] warn_slowpath_null+0x1a/0x20
> [126852.459474] =A0[<ffffffffa028db13>]
> btrfs_free_block_groups+0x1f3/0x2e0 [btrfs
> =A0 ]
> [126852.467581] =A0[<ffffffffa02a0de9>] close_ctree+0x1e9/0x3b0 [btrf=
s]
> [126852.474528] =A0[<ffffffff8154c8b9>] ? down_write+0x29/0x50
> [126852.480609] =A0[<ffffffffa027f63d>] btrfs_put_super+0x1d/0x30 [bt=
rfs]
> [126852.487754] =A0[<ffffffff811616d2>] generic_shutdown_super+0x72/0=
xf0
> [126852.494800] =A0[<ffffffff811617e6>] kill_anon_super+0x16/0x60
> [126852.501169] =A0[<ffffffff81161f15>] deactivate_locked_super+0x45/=
0x70
> [126852.508301] =A0[<ffffffff81162b6a>] deactivate_super+0x4a/0x70
> [126852.514767] =A0[<ffffffff8117c8cc>] mntput_no_expire+0x13c/0x1c0
> [126852.521427] =A0[<ffffffff8117d0eb>] sys_umount+0x7b/0x3a0
> [126852.527408] =A0[<ffffffff81169952>] ? path_put+0x22/0x30
> [126852.533283] =A0[<ffffffff81555702>] system_call_fastpath+0x16/0x1=
b
> [126852.540127] ---[ end trace b81b341d82417095 ]---
> [126852.545430] space_info 4 has 40870576128 free, is not full
> [126852.551703] space_info total=3D43092279296, used=3D2213249024,
> pinned=3D0, reserve =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0d=3D0, may_use=3D479232,
> readonly=3D8454144
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
