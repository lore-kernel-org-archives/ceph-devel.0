From: Chris Dunlop <chris@onthe.net.au>
Subject: Bug #563 - osd: btrfs, warning at inode.c (
 btrfs_orphan_commit_root )
Date: Fri, 4 Feb 2011 19:48:08 +1100
Message-ID: <20110204084808.GA3814@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:45876 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab1BDIsK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Feb 2011 03:48:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp1.onthe.net.au (Postfix) with ESMTP id 3FDCB60DB0
	for <ceph-devel@vger.kernel.org>; Fri,  4 Feb 2011 19:47:58 +1100 (EST)
Received: from smtp1.onthe.net.au ([127.0.0.1])
	by localhost (smtp1.onthe.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EB91TS6BVpbv for <ceph-devel@vger.kernel.org>;
	Fri,  4 Feb 2011 19:47:57 +1100 (EST)
Received: from o1.office.otn.net.au (unknown [180.148.179.26])
	by smtp1.onthe.net.au (Postfix) with ESMTP id 6A21F60DA3
	for <ceph-devel@vger.kernel.org>; Fri,  4 Feb 2011 19:47:57 +1100 (EST)
Received: from achates.office.onthe.net.au (achates.office.onthe.net.au [10.1.32.53])
	by o1.office.otn.net.au (Postfix) with ESMTP id 079567A530
	for <ceph-devel@vger.kernel.org>; Fri,  4 Feb 2011 19:48:07 +1100 (EST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

G'day,

http://tracker.newdream.net/issues/563

I see this bug was closed 5 days ago. Which commit[s] closed it? I'm
getting it on ceph-client 9aae8fa + btrfs-work bacae12 when I do a
mkcephfs on 3 x 2 GB OSDs, e.g.:

Feb  4 19:09:04 b3 kernel: [16780.260695] ------------[ cut here ]------------
Feb  4 19:09:04 b3 kernel: [16780.260716] WARNING: at fs/btrfs/inode.c:2143 btrfs_orphan_commit_root+0x7f/0x9b [btrfs]()
Feb  4 19:09:04 b3 kernel: [16780.260724] Hardware name: System Product Name
Feb  4 19:09:04 b3 kernel: [16780.260729] Modules linked in: kvm_amd kvm loop btrfs zlib_deflate crc32c libcrc32c dm_mod tpm_tis tpm psmouse tpm_bios i2c_piix4 i2c_core button shpchp pci_hotplug processor nfs lockd nfs_acl auth_rpcgss sunrpc sd_mod ata_generic ahci libahci libata ehci_hcd r8169 mii ohci_hcd scsi_mod thermal fan thermal_sys [last unloaded: scsi_wait_scan]
Feb  4 19:09:04 b3 kernel: [16780.260783] Pid: 5233, comm: kworker/0:2 Tainted: G        W   2.6.37-otn1-33361-ga3f5274 #3
Feb  4 19:09:04 b3 kernel: [16780.260792] Call Trace:
Feb  4 19:09:04 b3 kernel: [16780.260805]  [<ffffffffa0215444>] ? btrfs_orphan_commit_root+0x7f/0x9b [btrfs]
Feb  4 19:09:04 b3 kernel: [16780.260815]  [<ffffffff81044644>] ? warn_slowpath_common+0x78/0x8d
Feb  4 19:09:04 b3 kernel: [16780.260828]  [<ffffffffa0215444>] ? btrfs_orphan_commit_root+0x7f/0x9b [btrfs]
Feb  4 19:09:04 b3 kernel: [16780.260842]  [<ffffffffa020adfe>] ? commit_fs_roots+0x87/0xef [btrfs]
Feb  4 19:09:04 b3 kernel: [16780.260855]  [<ffffffffa020ba71>] ? btrfs_commit_transaction+0x342/0x60f [btrfs]
Feb  4 19:09:04 b3 kernel: [16780.260869]  [<ffffffffa00aef5d>] ? xprt_release_xprt+0x41/0x73 [sunrpc]
Feb  4 19:09:04 b3 kernel: [16780.260877]  [<ffffffff8105df3a>] ? autoremove_wake_function+0x0/0x2e
Feb  4 19:09:04 b3 kernel: [16780.260886]  [<ffffffffa00ace70>] ? call_transmit+0x214/0x24f [sunrpc]
Feb  4 19:09:04 b3 kernel: [16780.260899]  [<ffffffffa020bd50>] ? do_async_commit+0x12/0x1b [btrfs]
Feb  4 19:09:04 b3 kernel: [16780.260906]  [<ffffffff8105903b>] ? process_one_work+0x22c/0x3a5
Feb  4 19:09:04 b3 kernel: [16780.260918]  [<ffffffffa020bd3e>] ? do_async_commit+0x0/0x1b [btrfs]
Feb  4 19:09:04 b3 kernel: [16780.260924]  [<ffffffff81059507>] ? worker_thread+0x1d5/0x353
Feb  4 19:09:04 b3 kernel: [16780.260930]  [<ffffffff81059332>] ? worker_thread+0x0/0x353
Feb  4 19:09:04 b3 kernel: [16780.260936]  [<ffffffff8105daf0>] ? kthread+0x7e/0x86
Feb  4 19:09:04 b3 kernel: [16780.260942]  [<ffffffff8100a7e4>] ? kernel_thread_helper+0x4/0x10
Feb  4 19:09:04 b3 kernel: [16780.260949]  [<ffffffff8105da72>] ? kthread+0x0/0x86
Feb  4 19:09:04 b3 kernel: [16780.260954]  [<ffffffff8100a7e0>] ? kernel_thread_helper+0x0/0x10
Feb  4 19:09:04 b3 kernel: [16780.260961] ---[ end trace e1f5276f9dfbd540 ]---
Feb  4 19:09:05 b3 kernel: [16782.127219] ------------[ cut here ]------------
Feb  4 19:09:05 b3 kernel: [16782.127241] WARNING: at fs/btrfs/inode.c:2143 btrfs_orphan_commit_root+0x7f/0x9b [btrfs]()
Feb  4 19:09:05 b3 kernel: [16782.127248] Hardware name: System Product Name
Feb  4 19:09:05 b3 kernel: [16782.127253] Modules linked in: kvm_amd kvm loop btrfs zlib_deflate crc32c libcrc32c dm_mod tpm_tis tpm psmouse tpm_bios i2c_piix4 i2c_core button shpchp pci_hotplug processor nfs lockd nfs_acl auth_rpcgss sunrpc sd_mod ata_generic ahci libahci libata ehci_hcd r8169 mii ohci_hcd scsi_mod thermal fan thermal_sys [last unloaded: scsi_wait_scan]
Feb  4 19:09:05 b3 kernel: [16782.127306] Pid: 5848, comm: kworker/1:2 Tainted: G        W   2.6.37-otn1-33361-ga3f5274 #3
Feb  4 19:09:05 b3 kernel: [16782.127314] Call Trace:
Feb  4 19:09:05 b3 kernel: [16782.127326]  [<ffffffffa0215444>] ? btrfs_orphan_commit_root+0x7f/0x9b [btrfs]
Feb  4 19:09:05 b3 kernel: [16782.128628]  [<ffffffff81044644>] ? warn_slowpath_common+0x78/0x8d
Feb  4 19:09:05 b3 kernel: [16782.128642]  [<ffffffffa0215444>] ? btrfs_orphan_commit_root+0x7f/0x9b [btrfs]
Feb  4 19:09:05 b3 kernel: [16782.128658]  [<ffffffffa020adfe>] ? commit_fs_roots+0x87/0xef [btrfs]
Feb  4 19:09:05 b3 kernel: [16782.128672]  [<ffffffffa020ba71>] ? btrfs_commit_transaction+0x342/0x60f [btrfs]
Feb  4 19:09:05 b3 kernel: [16782.128682]  [<ffffffff8105df3a>] ? autoremove_wake_function+0x0/0x2e
Feb  4 19:09:05 b3 kernel: [16782.128695]  [<ffffffffa020bd50>] ? do_async_commit+0x12/0x1b [btrfs]
Feb  4 19:09:05 b3 kernel: [16782.128701]  [<ffffffff8105903b>] ? process_one_work+0x22c/0x3a5
Feb  4 19:09:05 b3 kernel: [16782.128713]  [<ffffffffa020bd3e>] ? do_async_commit+0x0/0x1b [btrfs]
Feb  4 19:09:05 b3 kernel: [16782.128719]  [<ffffffff81059507>] ? worker_thread+0x1d5/0x353
Feb  4 19:09:05 b3 kernel: [16782.128725]  [<ffffffff81059332>] ? worker_thread+0x0/0x353
Feb  4 19:09:05 b3 kernel: [16782.128732]  [<ffffffff8105daf0>] ? kthread+0x7e/0x86
Feb  4 19:09:05 b3 kernel: [16782.128738]  [<ffffffff8100a7e4>] ? kernel_thread_helper+0x4/0x10
Feb  4 19:09:05 b3 kernel: [16782.128745]  [<ffffffff8105da72>] ? kthread+0x0/0x86
Feb  4 19:09:05 b3 kernel: [16782.128750]  [<ffffffff8100a7e0>] ? kernel_thread_helper+0x0/0x10
Feb  4 19:09:05 b3 kernel: [16782.128756] ---[ end trace e1f5276f9dfbd541 ]---


Cheers,

Chris.
