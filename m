From: Christian Brunner <chb@muc.de>
Subject: btrfs-work master repo
Date: Sun, 13 Nov 2011 20:57:55 +0100
Message-ID: <CAO47_-9XWh+p1WZ_UDOnLUCe88N3t4Kz3P26jL--48hDfKCb5g@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56161 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab1KMT54 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Nov 2011 14:57:56 -0500
Received: by vcbgb30 with SMTP id gb30so26053vcb.19
        for <ceph-devel@vger.kernel.org>; Sun, 13 Nov 2011 11:57:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josef Bacik <josef@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi Josef,

I've patched one of our ceph nodes with the stuff in your master repo
(including lxo's patches).

The WARNING in inode.c seems to be gone now, but load is still going
up after a day.

Another thing I've witnessed is that I'm getting a new warning, when I
umount the filesystem (see below).

I just wanted to tell you, hoping that this gives you a hint what's going on.

Regards,
Christian


[126852.379582] ------------[ cut here ]------------
[126852.384892] WARNING: at fs/btrfs/extent-tree.c:7177
btrfs_free_block_groups+                                0x1f3/0x2e0
[btrfs]()
[126852.394937] Hardware name: ProLiant DL180 G6
[126852.400045] Modules linked in: btrfs zlib_deflate libcrc32c sunrpc
bonding i                                pv6 sr_mod cdrom sg serio_raw
pcspkr ghes hed iTCO_wdt iTCO_vendor_support i7cor
           e_edac edac_core ixgbe dca mdio hpsa squashfs usb_storage
[last unloaded: iomemo                                ry_vsl]
[126852.425695] Pid: 23308, comm: umount Tainted: P        W
3.0.8-1.fits.4.el                                6.x86_64 #1
[126852.434769] Call Trace:
[126852.437648]  [<ffffffff8106334f>] warn_slowpath_common+0x7f/0xc0
[126852.444508]  [<ffffffffa028db31>] ?
btrfs_free_block_groups+0x211/0x2e0 [btr
 fs]
[126852.452808]  [<ffffffff810633aa>] warn_slowpath_null+0x1a/0x20
[126852.459474]  [<ffffffffa028db13>]
btrfs_free_block_groups+0x1f3/0x2e0 [btrfs
   ]
[126852.467581]  [<ffffffffa02a0de9>] close_ctree+0x1e9/0x3b0 [btrfs]
[126852.474528]  [<ffffffff8154c8b9>] ? down_write+0x29/0x50
[126852.480609]  [<ffffffffa027f63d>] btrfs_put_super+0x1d/0x30 [btrfs]
[126852.487754]  [<ffffffff811616d2>] generic_shutdown_super+0x72/0xf0
[126852.494800]  [<ffffffff811617e6>] kill_anon_super+0x16/0x60
[126852.501169]  [<ffffffff81161f15>] deactivate_locked_super+0x45/0x70
[126852.508301]  [<ffffffff81162b6a>] deactivate_super+0x4a/0x70
[126852.514767]  [<ffffffff8117c8cc>] mntput_no_expire+0x13c/0x1c0
[126852.521427]  [<ffffffff8117d0eb>] sys_umount+0x7b/0x3a0
[126852.527408]  [<ffffffff81169952>] ? path_put+0x22/0x30
[126852.533283]  [<ffffffff81555702>] system_call_fastpath+0x16/0x1b
[126852.540127] ---[ end trace b81b341d82417095 ]---
[126852.545430] space_info 4 has 40870576128 free, is not full
[126852.551703] space_info total=43092279296, used=2213249024,
pinned=0, reserve                                d=0, may_use=479232,
readonly=8454144
