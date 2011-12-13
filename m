From: Matt Weil <mweil@genome.wustl.edu>
Subject: btrfs: open_ctree failed
Date: Mon, 12 Dec 2011 21:20:58 -0600
Message-ID: <4EE6C49A.5070600@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:38645 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751203Ab1LMDbK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2011 22:31:10 -0500
Received: from Matt-Weils-MacBook-Pro.local (75-132-29-58.dhcp.stls.mo.charter.com [75.132.29.58])
	by gscsmtp.wustl.edu (Postfix) with ESMTPSA id D89D840BA1
	for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2011 21:20:58 -0600 (CST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


another butter bug?

 > btrfs: open_ctree failed
 > ------------[ cut here ]------------
 > WARNING: at fs/btrfs/inode.c:2194 btrfs_orphan_commit_root+0xb0/0xc0 
[btrfs]()
 > Hardware name: ProLiant DL380 G5
 > Modules linked in: btrfs zlib_deflate nfsd exportfs autofs4 nfs lockd 
fscache auth_rpcgss nfs_acl sunrpc bonding ipv6 dm_mirror dm_region_hash 
dm_log ipmi_si ipmi_msghandler hpilo pcspkr serio_raw sg iTCO_wdt 
iTCO_vendor_support i5k_amb i5000_edac edac_core bnx2 shpchp ext4 
mbcache jbd2 sr_mod cdrom pata_acpi ata_generic ata_piix hpsa cciss 
radeon ttm drm_kms_helper drm hwmon i2c_algo_bit i2c_core dm_mod [last 
unloaded: speedstep_lib]
 > Pid: 42, comm: kworker/4:1 Not tainted 3.0.8 #3
 > Call Trace:
 >  [<ffffffff8105ff5f>] warn_slowpath_common+0x7f/0xc0
 >  [<ffffffff8105ffba>] warn_slowpath_null+0x1a/0x20
 >  [<ffffffffa04c8250>] btrfs_orphan_commit_root+0xb0/0xc0 [btrfs]
 >  [<ffffffffa04c3845>] commit_fs_roots+0xc5/0x1b0 [btrfs]
 >  [<ffffffffa04c48fe>] btrfs_commit_transaction+0x40e/0x850 [btrfs]
 >  [<ffffffff8104cd80>] ? __dequeue_entity+0x30/0x50
 >  [<ffffffff81082670>] ? wake_up_bit+0x40/0x40
 >  [<ffffffffa04c5010>] ? btrfs_end_transaction+0x20/0x20 [btrfs]
 >  [<ffffffffa04c502f>] do_async_commit+0x1f/0x30 [btrfs]
 >  [<ffffffff8107b9d1>] process_one_work+0x131/0x450
 >  [<ffffffff8107d57c>] worker_thread+0x17c/0x3c0
 >  [<ffffffff8107d400>] ? manage_workers+0x220/0x220
 >  [<ffffffff81081ff6>] kthread+0x96/0xa0
 >  [<ffffffff814e3f04>] kernel_thread_helper+0x4/0x10
 >  [<ffffffff81081f60>] ? kthread_worker_fn+0x1a0/0x1a0
 >  [<ffffffff814e3f00>] ? gs_change+0x13/0x13
 > ---[ end trace ed99a1a191db74aa ]---
