From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Possible deadlock condition
Date: Mon, 18 Jun 2012 15:57:50 -0700
Message-ID: <4FDFB26E.1060109@inktank.com>
References: <CA+jddaPMp5R0adi2sLVUWeFytDzfOjAeryXL+jPjGAk8kKqafg@mail.gmail.com> <CA+jddaO_BY08H2PPb17EKGLZ3TS1BZ7XpxSUxswPRAZ-QN1Cfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49492 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab2FRW5x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 18:57:53 -0400
Received: by dady13 with SMTP id y13so7558681dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 15:57:53 -0700 (PDT)
In-Reply-To: <CA+jddaO_BY08H2PPb17EKGLZ3TS1BZ7XpxSUxswPRAZ-QN1Cfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

Does the xfs on the OSD have plenty of free space left, or could this be 
an allocation deadlock?

On 06/18/2012 03:17 PM, Mandell Degerness wrote:
> Here is, perhaps, a more useful traceback from a different run of
> tests that we just ran into:
>
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.680815] INFO: task
> flush-254:0:29582 blocked for more than 120 seconds.
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.681040] "echo 0>
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.681458] flush-254:0
>    D ffff880bd9ca2fc0     0 29582      2 0x00000000
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.681740]
> ffff88006e51d160 0000000000000046 0000000000000002 ffff88061b362040
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.682173]
> ffff88006e51d160 00000000000120c0 00000000000120c0 00000000000120c0
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.682659]
> ffff88006e51dfd8 00000000000120c0 00000000000120c0 ffff88006e51dfd8
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.683088] Call Trace:
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.683302]
> [<ffffffff81520132>] schedule+0x5a/0x5c
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.683514]
> [<ffffffff815203e7>] schedule_timeout+0x36/0xe3
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.683784]
> [<ffffffff8101e0b2>] ? physflat_send_IPI_mask+0xe/0x10
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.683999]
> [<ffffffff8101a237>] ? native_smp_send_reschedule+0x46/0x48
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.684219]
> [<ffffffff811e0071>] ? list_move_tail+0x27/0x2c
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.684432]
> [<ffffffff81520d13>] __down_common+0x90/0xd4
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.684708]
> [<ffffffff811e1120>] ? _xfs_buf_find+0x17f/0x210
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.684925]
> [<ffffffff81520dca>] __down+0x1d/0x1f
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.685139]
> [<ffffffff8105db4e>] down+0x2d/0x3d
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.685350]
> [<ffffffff811e0f68>] xfs_buf_lock+0x76/0xaf
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.685565]
> [<ffffffff811e1120>] _xfs_buf_find+0x17f/0x210
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.685836]
> [<ffffffff811e13b6>] xfs_buf_get+0x2a/0x177
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.686052]
> [<ffffffff811e19f6>] xfs_buf_read+0x1f/0xca
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.686270]
> [<ffffffff8122a0b7>] xfs_trans_read_buf+0x205/0x308
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.686490]
> [<ffffffff81205e01>] xfs_btree_read_buf_block.clone.22+0x4f/0xa7
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.687015]
> [<ffffffff8122a3ee>] ? xfs_trans_log_buf+0xb2/0xc1
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.687232]
> [<ffffffff81205edd>] xfs_btree_lookup_get_block+0x84/0xac
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.687449]
> [<ffffffff81208e83>] xfs_btree_lookup+0x12b/0x3dc
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.687721]
> [<ffffffff811f6bb2>] ? xfs_alloc_vextent+0x447/0x469
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.687939]
> [<ffffffff811fd171>] xfs_bmbt_lookup_eq+0x1f/0x21
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.688156]
> [<ffffffff811ffa88>] xfs_bmap_add_extent_delay_real+0x5b5/0xfec
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.688378]
> [<ffffffff810f155b>] ? kmem_cache_alloc+0x87/0xf3
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.688650]
> [<ffffffff81204c40>] ? xfs_bmbt_init_cursor+0x3f/0x107
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.688867]
> [<ffffffff81201160>] xfs_bmapi_allocate+0x1f6/0x23a
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.689084]
> [<ffffffff812185bd>] ? xfs_iext_bno_to_irec+0x95/0xb9
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.689301]
> [<ffffffff81203414>] xfs_bmapi_write+0x32d/0x5a2
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.689519]
> [<ffffffff811e99e4>] xfs_iomap_write_allocate+0x1a5/0x29f
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.689797]
> [<ffffffff811df12a>] xfs_map_blocks+0x13e/0x1dd
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.690016]
> [<ffffffff811dfbff>] xfs_vm_writepage+0x24e/0x410
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.690233]
> [<ffffffff810bde1e>] __writepage+0x17/0x30
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.690446]
> [<ffffffff810be6ed>] write_cache_pages+0x276/0x3c8
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.690693]
> [<ffffffff810bde07>] ? set_page_dirty+0x60/0x60
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.690908]
> [<ffffffff810be884>] generic_writepages+0x45/0x5c
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.691123]
> [<ffffffff811defcb>] xfs_vm_writepages+0x4d/0x54
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.691337]
> [<ffffffff810bf832>] do_writepages+0x21/0x2a
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.691552]
> [<ffffffff811218f5>] writeback_single_inode+0x12a/0x2cc
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.691800]
> [<ffffffff81121d92>] writeback_sb_inodes+0x174/0x215
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.692016]
> [<ffffffff81122185>] __writeback_inodes_wb+0x78/0xb9
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.692231]
> [<ffffffff811224b5>] wb_writeback+0x136/0x22a
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.692444]
> [<ffffffff810becd1>] ? determine_dirtyable_memory+0x1d/0x26
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.692692]
> [<ffffffff81122d1e>] wb_do_writeback+0x19c/0x1b7
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.692907]
> [<ffffffff81122dc5>] bdi_writeback_thread+0x8c/0x20f
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.693122]
> [<ffffffff81122d39>] ? wb_do_writeback+0x1b7/0x1b7
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.693336]
> [<ffffffff81122d39>] ? wb_do_writeback+0x1b7/0x1b7
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.693553]
> [<ffffffff8105911d>] kthread+0x82/0x8a
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.693803]
> [<ffffffff81523c34>] kernel_thread_helper+0x4/0x10
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.694018]
> [<ffffffff8105909b>] ? kthread_worker_fn+0x13b/0x13b
> Jun 18 17:58:51 node-172-29-0-15 kernel: [242522.694232]
> [<ffffffff81523c30>] ? gs_change+0xb/0xb
>
>
> On Mon, Jun 18, 2012 at 11:37 AM, Mandell Degerness
> <mandell@pistoncloud.com>  wrote:
>> We've been seeing random issues of apparent deadlocks.  We are running
>> ceph 0.47 on kernel 3.2.18.  OSDs are running on XFS file system.
>> mysqld (which ran into the particular problems in the attached kernel
>> log) is running on an RBD with XFS (mounted on a system which includes
>> OSDs).  We have sync_fs, and gcc ver 4.5.3-r2.  The mysqld process in
>> both instances returned an error to the calling process.
>>
>> Regards,
>> Mandell Degerness
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
