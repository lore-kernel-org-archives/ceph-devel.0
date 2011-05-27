From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: fs selection.
Date: Fri, 27 May 2011 08:18:14 -0700
Message-ID: <BANLkTi=6RAQgCnqoNvMPFfchgCtLpF7qhg@mail.gmail.com>
References: <4DDF9207.4090008@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41751 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab1E0PSQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 May 2011 11:18:16 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 5B525C516
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 08:18:16 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id DB09EC167
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 08:18:15 -0700 (PDT)
Received: by eyx24 with SMTP id 24so693438eyx.19
        for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 08:18:14 -0700 (PDT)
In-Reply-To: <4DDF9207.4090008@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

You are really putting this stuff through the wringer -- nobody else
hits these issues so frequently!

Can you remind us of your test setup? I'd like to figure out how
you're killing these FSes so badly.

And just randomly, I'd try ext4 before xfs. :)
-Greg

On Fri, May 27, 2011 at 4:59 AM, Fyodor Ustinov <ufm@ufm.su> wrote:
> Hi!
>
> ceph is a very powerful thing.
>
> it kills ext3:
>
> [49531.320004] =A0[<ffffffff811d3c4c>] ext3_new_blocks+0x40c/0x6b0
> [49531.320004] =A0[<ffffffff811d3f11>] ext3_new_block+0x21/0x30
> [49531.320004] =A0[<ffffffff811e798e>] ext3_xattr_block_set+0x2ae/0x7=
90
> [49531.320004] =A0[<ffffffff811e86ba>] ext3_xattr_set_handle+0x30a/0x=
4c0
> [49531.320004] =A0[<ffffffff811e88f5>] ext3_xattr_set+0x85/0xe0
> [49531.320004] =A0[<ffffffff81277053>] ?
> security_inode_exec_permission+0x23/0x30
> [49531.320004] =A0[<ffffffff811e8ae9>] ext3_xattr_user_set+0x49/0x50
> [49531.320004] =A0[<ffffffff811818e4>] generic_setxattr+0x74/0x90
> [49531.320004] =A0[<ffffffff811820c0>] __vfs_setxattr_noperm+0x50/0x1=
a0
> [49531.320004] =A0[<ffffffff8116adb8>] ? inode_permission+0xa8/0xd0
> [49531.320004] =A0[<ffffffff811822cc>] vfs_setxattr+0xbc/0xc0
> [49531.320004] =A0[<ffffffff81182392>] setxattr+0xc2/0x150
> [49531.320004] =A0[<ffffffff8114fec0>] ? kmem_cache_free+0x20/0x110
> [49531.320004] =A0[<ffffffff8116ae33>] ? putname+0x33/0x50
> [49531.320004] =A0[<ffffffff8116ef84>] ? user_path_at+0x64/0xa0
> [49531.320004] =A0[<ffffffff815d3493>] ? schedule+0x3d3/0xa00
> [49531.320004] =A0[<ffffffff81099c7b>] ? sys_futex+0x7b/0x180
> [49531.320004] =A0[<ffffffff811824b5>] sys_setxattr+0x95/0xb0
> [49531.320004] =A0[<ffffffff815ddec2>] system_call_fastpath+0x16/0x1b
>
> it kills btrfs:
>
> [91970.322381] =A0[<ffffffff81062bbf>] warn_slowpath_common+0x7f/0xc0
> [91970.322385] =A0[<ffffffff81062c1a>] warn_slowpath_null+0x1a/0x20
> [91970.322394] =A0[<ffffffffa01a1b58>] btrfs_alloc_free_block+0x1f8/0=
x330
> [btrfs]
> [91970.322403] =A0[<ffffffffa018f6cf>] __btrfs_cow_block+0x14f/0x600 =
[btrfs]
> [91970.322414] =A0[<ffffffffa01ab5c0>] ? btrfs_buffer_uptodate+0x50/0=
x70
> [btrfs]
> [91970.322422] =A0[<ffffffffa018fc93>] btrfs_cow_block+0x113/0x240 [b=
trfs]
> [91970.322431] =A0[<ffffffffa0194c15>] btrfs_search_slot+0x555/0x850 =
[btrfs]
> [91970.322441] =A0[<ffffffffa01a82af>] btrfs_lookup_inode+0x2f/0xa0 [=
btrfs]
> [91970.322453] =A0[<ffffffffa01b597e>] btrfs_update_inode+0x5e/0x100 =
[btrfs]
> [91970.322464] =A0[<ffffffffa01b9957>] btrfs_truncate+0x587/0x600 [bt=
rfs]
> [91970.322476] =A0[<ffffffffa01b9cef>] btrfs_setsize+0x4f/0xd0 [btrfs=
]
> [91970.322488] =A0[<ffffffffa01b9e2c>] btrfs_setattr+0xbc/0xd0 [btrfs=
]
> [91970.322492] =A0[<ffffffff8117aa89>] notify_change+0x189/0x370
> [91970.322496] =A0[<ffffffff8115eb11>] do_truncate+0x61/0x90
> [91970.322500] =A0[<ffffffff8116a323>] ? generic_permission+0x23/0xd0
> [91970.322504] =A0[<ffffffff8116bec2>] ? get_write_access+0x42/0x70
> [91970.322507] =A0[<ffffffff8115ecca>] sys_truncate+0x18a/0x1a0
> [91970.322512] =A0[<ffffffff815ddec2>] system_call_fastpath+0x16/0x1b
>
> [91973.333974] =A0[<ffffffff81062bbf>] warn_slowpath_common+0x7f/0xc0
> [91973.333978] =A0[<ffffffff81062c1a>] warn_slowpath_null+0x1a/0x20
> [91973.333990] =A0[<ffffffffa01b568b>] btrfs_orphan_commit_root+0xbb/=
0xd0
> [btrfs]
> [91973.334001] =A0[<ffffffffa01aee84>] commit_fs_roots.clone.20+0x94/=
0x120
> [btrfs]
> [91973.334013] =A0[<ffffffffa01afc62>] btrfs_commit_transaction+0x342=
/0x7c0
> [btrfs]
> [91973.334017] =A0[<ffffffff810846d0>] ? wake_up_bit+0x40/0x40
> [91973.334021] =A0[<ffffffff81051dd1>] ? finish_task_switch+0x41/0xe0
> [91973.334033] =A0[<ffffffffa01b00e0>] ? btrfs_commit_transaction+0x7=
c0/0x7c0
> [btrfs]
> [91973.334044] =A0[<ffffffffa01b00ff>] do_async_commit+0x1f/0x30 [btr=
fs]
> [91973.334048] =A0[<ffffffff8107ecdd>] process_one_work+0x11d/0x420
> [91973.334052] =A0[<ffffffff8107f799>] worker_thread+0x169/0x360
> [91973.334055] =A0[<ffffffff8107f630>] ? manage_workers.clone.21+0x24=
0/0x240
> [91973.334059] =A0[<ffffffff81083f36>] kthread+0x96/0xa0
> [91973.334063] =A0[<ffffffff815defe4>] kernel_thread_helper+0x4/0x10
> [91973.334067] =A0[<ffffffff81083ea0>] ? flush_kthread_worker+0xb0/0x=
b0
> [91973.334070] =A0[<ffffffff815defe0>] ? gs_change+0x13/0x13
>
> I choose what to kill next? XFS may be? (bloodthirsty grins).
>
> WBR,
> =A0 =A0Fyodor.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
