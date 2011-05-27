From: Fyodor Ustinov <ufm@ufm.su>
Subject: fs selection.
Date: Fri, 27 May 2011 14:59:03 +0300
Message-ID: <4DDF9207.4090008@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:34952 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab1E0L7G (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 27 May 2011 07:59:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id C7E8D600485
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 14:59:04 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AKdgXExMLt1C for <ceph-devel@vger.kernel.org>;
	Fri, 27 May 2011 14:59:04 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 964B5600484
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 14:59:04 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

ceph is a very powerful thing.

it kills ext3:

[49531.320004]  [<ffffffff811d3c4c>] ext3_new_blocks+0x40c/0x6b0
[49531.320004]  [<ffffffff811d3f11>] ext3_new_block+0x21/0x30
[49531.320004]  [<ffffffff811e798e>] ext3_xattr_block_set+0x2ae/0x790
[49531.320004]  [<ffffffff811e86ba>] ext3_xattr_set_handle+0x30a/0x4c0
[49531.320004]  [<ffffffff811e88f5>] ext3_xattr_set+0x85/0xe0
[49531.320004]  [<ffffffff81277053>] ? 
security_inode_exec_permission+0x23/0x30
[49531.320004]  [<ffffffff811e8ae9>] ext3_xattr_user_set+0x49/0x50
[49531.320004]  [<ffffffff811818e4>] generic_setxattr+0x74/0x90
[49531.320004]  [<ffffffff811820c0>] __vfs_setxattr_noperm+0x50/0x1a0
[49531.320004]  [<ffffffff8116adb8>] ? inode_permission+0xa8/0xd0
[49531.320004]  [<ffffffff811822cc>] vfs_setxattr+0xbc/0xc0
[49531.320004]  [<ffffffff81182392>] setxattr+0xc2/0x150
[49531.320004]  [<ffffffff8114fec0>] ? kmem_cache_free+0x20/0x110
[49531.320004]  [<ffffffff8116ae33>] ? putname+0x33/0x50
[49531.320004]  [<ffffffff8116ef84>] ? user_path_at+0x64/0xa0
[49531.320004]  [<ffffffff815d3493>] ? schedule+0x3d3/0xa00
[49531.320004]  [<ffffffff81099c7b>] ? sys_futex+0x7b/0x180
[49531.320004]  [<ffffffff811824b5>] sys_setxattr+0x95/0xb0
[49531.320004]  [<ffffffff815ddec2>] system_call_fastpath+0x16/0x1b

it kills btrfs:

[91970.322381]  [<ffffffff81062bbf>] warn_slowpath_common+0x7f/0xc0
[91970.322385]  [<ffffffff81062c1a>] warn_slowpath_null+0x1a/0x20
[91970.322394]  [<ffffffffa01a1b58>] btrfs_alloc_free_block+0x1f8/0x330 
[btrfs]
[91970.322403]  [<ffffffffa018f6cf>] __btrfs_cow_block+0x14f/0x600 [btrfs]
[91970.322414]  [<ffffffffa01ab5c0>] ? btrfs_buffer_uptodate+0x50/0x70 
[btrfs]
[91970.322422]  [<ffffffffa018fc93>] btrfs_cow_block+0x113/0x240 [btrfs]
[91970.322431]  [<ffffffffa0194c15>] btrfs_search_slot+0x555/0x850 [btrfs]
[91970.322441]  [<ffffffffa01a82af>] btrfs_lookup_inode+0x2f/0xa0 [btrfs]
[91970.322453]  [<ffffffffa01b597e>] btrfs_update_inode+0x5e/0x100 [btrfs]
[91970.322464]  [<ffffffffa01b9957>] btrfs_truncate+0x587/0x600 [btrfs]
[91970.322476]  [<ffffffffa01b9cef>] btrfs_setsize+0x4f/0xd0 [btrfs]
[91970.322488]  [<ffffffffa01b9e2c>] btrfs_setattr+0xbc/0xd0 [btrfs]
[91970.322492]  [<ffffffff8117aa89>] notify_change+0x189/0x370
[91970.322496]  [<ffffffff8115eb11>] do_truncate+0x61/0x90
[91970.322500]  [<ffffffff8116a323>] ? generic_permission+0x23/0xd0
[91970.322504]  [<ffffffff8116bec2>] ? get_write_access+0x42/0x70
[91970.322507]  [<ffffffff8115ecca>] sys_truncate+0x18a/0x1a0
[91970.322512]  [<ffffffff815ddec2>] system_call_fastpath+0x16/0x1b

[91973.333974]  [<ffffffff81062bbf>] warn_slowpath_common+0x7f/0xc0
[91973.333978]  [<ffffffff81062c1a>] warn_slowpath_null+0x1a/0x20
[91973.333990]  [<ffffffffa01b568b>] btrfs_orphan_commit_root+0xbb/0xd0 
[btrfs]
[91973.334001]  [<ffffffffa01aee84>] commit_fs_roots.clone.20+0x94/0x120 
[btrfs]
[91973.334013]  [<ffffffffa01afc62>] 
btrfs_commit_transaction+0x342/0x7c0 [btrfs]
[91973.334017]  [<ffffffff810846d0>] ? wake_up_bit+0x40/0x40
[91973.334021]  [<ffffffff81051dd1>] ? finish_task_switch+0x41/0xe0
[91973.334033]  [<ffffffffa01b00e0>] ? 
btrfs_commit_transaction+0x7c0/0x7c0 [btrfs]
[91973.334044]  [<ffffffffa01b00ff>] do_async_commit+0x1f/0x30 [btrfs]
[91973.334048]  [<ffffffff8107ecdd>] process_one_work+0x11d/0x420
[91973.334052]  [<ffffffff8107f799>] worker_thread+0x169/0x360
[91973.334055]  [<ffffffff8107f630>] ? manage_workers.clone.21+0x240/0x240
[91973.334059]  [<ffffffff81083f36>] kthread+0x96/0xa0
[91973.334063]  [<ffffffff815defe4>] kernel_thread_helper+0x4/0x10
[91973.334067]  [<ffffffff81083ea0>] ? flush_kthread_worker+0xb0/0xb0
[91973.334070]  [<ffffffff815defe0>] ? gs_change+0x13/0x13

I choose what to kill next? XFS may be? (bloodthirsty grins).

WBR,
     Fyodor.

