From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: FS / Kernel question choosing the correct kernel version
Date: Tue, 26 Jun 2012 15:07:08 -0500
Message-ID: <4FEA166C.4080609@inktank.com>
References: <4FE60A65.2030800@profihost.ag> <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net> <4FE97BE8.6010603@profihost.ag> <4FE9E006.6030404@profihost.ag> <4FE9E360.8050807@inktank.com> <4FE9E6CB.8080803@profihost.ag> <4FE9EA85.9030809@inktank.com> <4FE9F60E.3020105@profihost.ag> <4FE9F640.7060600@profihost.ag> <4FE9F9CB.5090205@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:46875 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab2FZUHZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 16:07:25 -0400
Received: by ghrr11 with SMTP id r11so337532ghr.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 13:07:24 -0700 (PDT)
In-Reply-To: <4FE9F9CB.5090205@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "hch@infradead.org >> Christoph Hellwig" <hch@infradead.org>

On 06/26/2012 01:04 PM, Stefan Priebe wrote:
> Or these:
> 359.933112] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> [ 359.949567] ceph-osd D ffffffff8180e9c0 0 3841 1 0x00000000
> [ 359.966452] ffff880db567d7b8 0000000000000082 ffff880db6c30000
> 0000000000012200
> [ 359.983845] ffff880db567dfd8 ffff880db567c010 0000000000012200
> 0000000000012200
> [ 360.001308] ffff880db567dfd8 0000000000012200 ffff881038ee1810
> ffff880db6c30000
> [ 360.019065] Call Trace:
> [ 360.036550] [<ffffffff816296e4>] schedule+0x24/0x70
> [ 360.054562] [<ffffffff81627a3d>] schedule_timeout+0x1fd/0x2e0
> [ 360.054566] [<ffffffff812affe4>] ? xfs_iext_bno_to_ext+0x84/0x160
> [ 360.054568] [<ffffffff8162888a>] __down+0x6a/0xb0
> [ 360.054571] [<ffffffff8126d885>] ? _xfs_buf_find+0xe5/0x230
> [ 360.054573] [<ffffffff8106310b>] down+0x3b/0x50
> [ 360.054575] [<ffffffff8126d640>] xfs_buf_lock+0x40/0xe0
> [ 360.054576] [<ffffffff8126d885>] _xfs_buf_find+0xe5/0x230
> [ 360.054578] [<ffffffff8126d9ff>] xfs_buf_get+0x2f/0x1b0
> [ 360.054580] [<ffffffff812bb2a2>] ? xfs_icsb_modify_counters+0xa2/0x190
> [ 360.054581] [<ffffffff8126e1f7>] xfs_buf_read+0x27/0x100
> [ 360.054584] [<ffffffff812c64c7>] xfs_trans_read_buf+0x1f7/0x430
> [ 360.054588] [<ffffffff81283ab1>] xfs_read_agf+0x61/0x190
> [ 360.054589] [<ffffffff81283c14>] xfs_alloc_read_agf+0x34/0xd0
> [ 360.054592] [<ffffffff81286fd7>] xfs_alloc_fix_freelist+0x427/0x4a0
> [ 360.054594] [<ffffffff816296e4>] ? schedule+0x24/0x70
> [ 360.054596] [<ffffffff8162a21d>] ? rwsem_down_failed_common+0xbd/0x150
> [ 360.054599] [<ffffffff8110351b>] ? kmem_cache_free+0x1b/0xf0
> [ 360.054601] [<ffffffff812bccee>] ? xfs_trans_free_item_desc+0x2e/0x30
> [ 360.054603] [<ffffffff812bab63>] ? xfs_perag_get+0x33/0xb0
> [ 360.054605] [<ffffffff812870e7>] ? xfs_free_extent+0x97/0x140
> [ 360.054607] [<ffffffff812870fb>] xfs_free_extent+0xab/0x140
> [ 360.054609] [<ffffffff812915bd>] xfs_bmap_finish+0x15d/0x1a0
> [ 360.054611] [<ffffffff812b3487>] xfs_itruncate_extents+0xf7/0x2a0
> [ 360.054613] [<ffffffff81278d34>] xfs_setattr_size+0x394/0x410
> [ 360.054615] [<ffffffff81278de2>] xfs_vn_setattr+0x32/0x40
> [ 360.054617] [<ffffffff8112481a>] notify_change+0x13a/0x2e0
> [ 360.054619] [<ffffffff8110a28f>] do_truncate+0x5f/0x90
> [ 360.054621] [<ffffffff8110a4bf>] sys_truncate+0x12f/0x150
> [ 360.054623] [<ffffffff8162ae62>] system_call_fastpath+0x16/0x1b
> [ 360.054625] INFO: task ceph-osd:3843 blocked for more than 120 seconds.
> [ 360.054626] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 360.054627] ceph-osd D 0000000000000002 0 3843 1 0x00000000
> [ 360.054629] ffff880db5689678 0000000000000082 ffff880db5681810
> 0000000000012200
> [ 360.054631] ffff880db5689fd8 ffff880db5688010 0000000000012200
> 0000000000012200
> [ 360.054633] ffff880db5689fd8 0000000000012200 ffff881038f3e040
> ffff880db5681810
> [ 360.054635] Call Trace:
> [ 360.054637] [<ffffffff816296e4>] schedule+0x24/0x70
> [ 360.054639] [<ffffffff81627a3d>] schedule_timeout+0x1fd/0x2e0
> [ 360.054641] [<ffffffff8106aa44>] ? T.1708+0x44/0x50
> [ 360.054643] [<ffffffff8106ddaf>] ? try_to_wake_up+0x23f/0x2b0
> [ 360.054645] [<ffffffff81628d54>] wait_for_common+0xc4/0x160
> [ 360.054647] [<ffffffff8106de20>] ? try_to_wake_up+0x2b0/0x2b0
> [ 360.054649] [<ffffffff81628e98>] wait_for_completion+0x18/0x20
> [ 360.054650] [<ffffffff81283a3d>] xfs_alloc_vextent+0x6d/0x80
> [ 360.054652] [<ffffffff812922b1>] xfs_bmap_btalloc+0x2a1/0x7d0
> [ 360.054654] [<ffffffff81298301>] ?
> xfs_bmap_add_extent_delay_real+0xff1/0x17a0
> [ 360.054656] [<ffffffff81287780>] ? __xfs_alloc_vextent+0x5f0/0x5f0
> [ 360.054658] [<ffffffff812927e9>] xfs_bmap_alloc+0x9/0x10
> [ 360.054659] [<ffffffff81298b78>] xfs_bmapi_allocate+0xc8/0x2c0
> [ 360.054661] [<ffffffff81299279>] xfs_bmapi_write+0x509/0x780
> [ 360.054664] [<ffffffff81276ab4>] xfs_iomap_write_allocate+0x134/0x370
> [ 360.054666] [<ffffffff8126b325>] xfs_map_blocks+0x155/0x230
> [ 360.054667] [<ffffffff8126b597>] xfs_vm_writepage+0x197/0x540
> [ 360.054669] [<ffffffff812bccee>] ? xfs_trans_free_item_desc+0x2e/0x30
> [ 360.054672] [<ffffffff810cc4a2>] __writepage+0x12/0x40
> [ 360.054674] [<ffffffff810cd5f6>] write_cache_pages+0x236/0x4c0
> [ 360.054675] [<ffffffff812c27ef>] ? xfs_log_commit_cil+0x3bf/0x480
> [ 360.054677] [<ffffffff810cc490>] ? set_page_dirty+0x70/0x70
> [ 360.054679] [<ffffffff812bccac>] ? xfs_trans_free+0x5c/0x70
> [ 360.054680] [<ffffffff812bde3b>] ? xfs_trans_commit+0xab/0x260
> [ 360.054682] [<ffffffff8127362e>] ? xfs_iunlock+0x7e/0xd0
> [ 360.054684] [<ffffffff810cd8cc>] generic_writepages+0x4c/0x70
> [ 360.054686] [<ffffffff81269fef>] xfs_vm_writepages+0x4f/0x60
> [ 360.054688] [<ffffffff810cd90c>] do_writepages+0x1c/0x40
> [ 360.054689] [<ffffffff810c3b7b>] __filemap_fdatawrite_range+0x5b/0x60
> [ 360.054691] [<ffffffff810c3e1e>] filemap_fdatawrite_range+0xe/0x10
> [ 360.054694] [<ffffffff811361ae>] sys_sync_file_range+0x14e/0x180
> [ 360.054696] [<ffffffff81109240>] ? filp_close+0x60/0x90
> [ 360.054698] [<ffffffff8162ae62>] system_call_fastpath+0x16/0x1b
>
> Am 26.06.2012 19:49, schrieb Stefan Priebe:
>> and these:
>> 359.919732] INFO: task xfsaild/sdd1:2247 blocked for more than 120
>> seconds.
>> [ 359.934620] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [ 359.950059] xfsaild/sdd1 D 0000000000000007 0 2247 2
>> 0x00000000
>> [ 359.966026] ffff8810349d9cf0 0000000000000046 ffff881034809810
>> 0000000000012200
>> [ 359.982249] ffff8810349d9fd8 ffff8810349d8010 0000000000012200
>> 0000000000012200
>> [ 359.998634] ffff8810349d9fd8 0000000000012200 ffff881038ef8000
>> ffff881034809810
>> [ 360.015139] Call Trace:
>> [ 360.031552] [<ffffffff816296e4>] schedule+0x24/0x70
>> [ 360.048356] [<ffffffff812c2a9a>] xlog_cil_force_lsn+0xea/0x110
>> [ 360.065363] [<ffffffff8106de20>] ? try_to_wake_up+0x2b0/0x2b0
>> [ 360.082348] [<ffffffff816279c9>] ? schedule_timeout+0x189/0x2e0
>> [ 360.099128] [<ffffffff812c0ab4>] _xfs_log_force+0x64/0x240
>> [ 360.115616] [<ffffffff812c0e13>] xfs_log_force+0x13/0x40
>> [ 360.132031] [<ffffffff812c5646>] xfsaild+0x106/0x6d0
>> [ 360.148296] [<ffffffff812c5540>] ?
>> xfs_trans_ail_update_bulk+0x260/0x260
>> [ 360.164963] [<ffffffff8105d8d6>] kthread+0x96/0xa0
>> [ 360.181658] [<ffffffff8162c094>] kernel_thread_helper+0x4/0x10
>> [ 360.198516] [<ffffffff8105d840>] ? kthread_worker_fn+0x130/0x130
>> [ 360.215534] [<ffffffff8162c090>] ? gs_change+0xb/0xb
>> [ 480.048246] INFO: task ceph-osd:3282 blocked for more than 120 seconds.
>> [ 480.065939] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [ 480.083979] ceph-osd D ffffffff8180e9c0 0 3282 1
>> 0x00000004
>> [ 480.102327] ffff880dbbb9d7b8 0000000000000086 ffff880dbbba0000
>> 0000000000012200
>> [ 480.121333] ffff880dbbb9dfd8 ffff880dbbb9c010 0000000000012200
>> 0000000000012200
>> [ 480.140374] ffff880dbbb9dfd8 0000000000012200 ffff881038e69810
>> ffff880dbbba0000
>> [ 480.159738] Call Trace:
>> [ 480.178812] [<ffffffff816296e4>] schedule+0x24/0x70
>> [ 480.198230] [<ffffffff81627a3d>] schedule_timeout+0x1fd/0x2e0
>> [ 480.217775] [<ffffffff812affe4>] ? xfs_iext_bno_to_ext+0x84/0x160
>> [ 480.237500] [<ffffffff8162888a>] __down+0x6a/0xb0
>> [ 480.257254] [<ffffffff8126d885>] ? _xfs_buf_find+0xe5/0x230
>> [ 480.277179] [<ffffffff8106310b>] down+0x3b/0x50
>> [ 480.297102] [<ffffffff8126d640>] xfs_buf_lock+0x40/0xe0
>> [ 480.317000] [<ffffffff8126d885>] _xfs_buf_find+0xe5/0x230
>> [ 480.337193] [<ffffffff8126d9ff>] xfs_buf_get+0x2f/0x1b0
>> [ 480.357648] [<ffffffff812bb2a2>] ? xfs_icsb_modify_counters+0xa2/0x190
>> [ 480.378666] [<ffffffff8126e1f7>] xfs_buf_read+0x27/0x100
>> [ 480.399694] [<ffffffff812c64c7>] xfs_trans_read_buf+0x1f7/0x430
>> [ 480.421093] [<ffffffff81283ab1>] xfs_read_agf+0x61/0x190
>> [ 480.442728] [<ffffffff81282e67>] ? kmem_zone_alloc+0x77/0xf0
>> [ 480.464717] [<ffffffff81283c14>] xfs_alloc_read_agf+0x34/0xd0
>> [ 480.486433] [<ffffffff81286fd7>] xfs_alloc_fix_freelist+0x427/0x4a0
>> [ 480.508220] [<ffffffff8129350f>] ? xfs_bmap_del_extent+0x45f/0xac0
>> [ 480.530335] [<ffffffff8110351b>] ? kmem_cache_free+0x1b/0xf0
>> [ 480.552300] [<ffffffff812bccee>] ? xfs_trans_free_item_desc+0x2e/0x30
>> [ 480.574439] [<ffffffff812bab63>] ? xfs_perag_get+0x33/0xb0
>> [ 480.596523] [<ffffffff812870e7>] ? xfs_free_extent+0x97/0x140
>> [ 480.618126] [<ffffffff812870fb>] xfs_free_extent+0xab/0x140
>> [ 480.639105] [<ffffffff812915bd>] xfs_bmap_finish+0x15d/0x1a0
>> [ 480.659636] [<ffffffff812b3487>] xfs_itruncate_extents+0xf7/0x2a0
>> [ 480.659645] [<ffffffff81278d34>] xfs_setattr_size+0x394/0x410
>> [ 480.659647] [<ffffffff81278de2>] xfs_vn_setattr+0x32/0x40
>> [ 480.659650] [<ffffffff8112481a>] notify_change+0x13a/0x2e0
>> [ 480.659652] [<ffffffff8110a28f>] do_truncate+0x5f/0x90
>> [ 480.659654] [<ffffffff8110a4bf>] sys_truncate+0x12f/0x150
>> [ 480.659657] [<ffffffff8162ae62>] system_call_fastpath+0x16/0x1b
>> [ 480.659659] INFO: task ceph-osd:3283 blocked for more than 120 seconds.
>> [ 480.659659] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [ 480.659661] ceph-osd D 0000000000000001 0 3283 1
>> 0x00000004
>> [ 480.659663] ffff880dbbb9f678 0000000000000086 ffff880dbbba1810
>> 0000000000012200
>> [ 480.659666] ffff880dbbb9ffd8 ffff880dbbb9e010 0000000000012200
>> 0000000000012200
>> [ 480.659669] ffff880dbbb9ffd8 0000000000012200 ffff881036ab1810
>> ffff880dbbba1810
>> [ 480.659671] Call Trace:
>> [ 480.659674] [<ffffffff816296e4>] schedule+0x24/0x70
>> [ 480.659676] [<ffffffff81627a3d>] schedule_timeout+0x1fd/0x2e0
>> [ 480.659679] [<ffffffff8106aa44>] ? T.1708+0x44/0x50
>> [ 480.659681] [<ffffffff8106ddaf>] ? try_to_wake_up+0x23f/0x2b0
>> [ 480.659684] [<ffffffff81628d54>] wait_for_common+0xc4/0x160
>> [ 480.659686] [<ffffffff8106de20>] ? try_to_wake_up+0x2b0/0x2b0
>> [ 480.659688] [<ffffffff81628e98>] wait_for_completion+0x18/0x20
>> [ 480.659691] [<ffffffff81283a3d>] xfs_alloc_vextent+0x6d/0x80
>> [ 480.659693] [<ffffffff812922b1>] xfs_bmap_btalloc+0x2a1/0x7d0
>> [ 480.659695] [<ffffffff81066215>] ? check_preempt_curr+0x75/0xa0
>> [ 480.659698] [<ffffffff81287780>] ? __xfs_alloc_vextent+0x5f0/0x5f0
>> [ 480.659700] [<ffffffff812927e9>] xfs_bmap_alloc+0x9/0x10
>> [ 480.659702] [<ffffffff81298b78>] xfs_bmapi_allocate+0xc8/0x2c0
>> [ 480.659704] [<ffffffff81299279>] xfs_bmapi_write+0x509/0x780
>> [ 480.659707] [<ffffffff81276ab4>] xfs_iomap_write_allocate+0x134/0x370
>> [ 480.659709] [<ffffffff8126b325>] xfs_map_blocks+0x155/0x230
>> [ 480.659711] [<ffffffff8126b597>] xfs_vm_writepage+0x197/0x540
>> [ 480.659713] [<ffffffff812bccee>] ? xfs_trans_free_item_desc+0x2e/0x30
>> [ 480.659717] [<ffffffff810cc4a2>] __writepage+0x12/0x40
>> [ 480.659720] [<ffffffff810cd5f6>] write_cache_pages+0x236/0x4c0
>> [ 480.659722] [<ffffffff812c27ef>] ? xfs_log_commit_cil+0x3bf/0x480
>> [ 480.659724] [<ffffffff810cc490>] ? set_page_dirty+0x70/0x70
>> [ 480.659726] [<ffffffff812bccac>] ? xfs_trans_free+0x5c/0x70
>> [ 480.659728] [<ffffffff812bde3b>] ? xfs_trans_commit+0xab/0x260
>> [ 480.659731] [<ffffffff8127362e>] ? xfs_iunlock+0x7e/0xd0
>> [ 480.659733] [<ffffffff810cd8cc>] generic_writepages+0x4c/0x70
>> [ 480.659735] [<ffffffff81269fef>] xfs_vm_writepages+0x4f/0x60
>> [ 480.659737] [<ffffffff810cd90c>] do_writepages+0x1c/0x40
>> [ 480.659739] [<ffffffff810c3b7b>] __filemap_fdatawrite_range+0x5b/0x60
>> [ 480.659742] [<ffffffff810c3e1e>] filemap_fdatawrite_range+0xe/0x10
>> [ 480.659745] [<ffffffff811361ae>] sys_sync_file_range+0x14e/0x180
>> [ 480.659747] [<ffffffff81109240>] ? filp_close+0x60/0x90
>> [ 480.659749] [<ffffffff8162ae62>] system_call_fastpath+0x16/0x1b
>> [ 480.659756] INFO: task flush-8:64:3184 blocked for more than 120
>> seconds.
>> [ 480.659757] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [ 480.659758] flush-8:64 D ffffffff8180e9c0 0 3184 2
>> 0x00000000
>> [ 480.659761] ffff880dbcf31920 0000000000000046 ffff880dbdbcc830
>> 0000000000012200
>> [ 480.659763] ffff880dbcf31fd8 ffff880dbcf30010 0000000000012200
>> 0000000000012200
>> [ 480.659766] ffff880dbcf31fd8 0000000000012200 ffff881038e89810
>> ffff880dbdbcc830
>> [ 480.659768] Call Trace:
>> [ 480.659772] [<ffffffff810c34e0>] ? __lock_page+0x70/0x70
>> [ 480.659774] [<ffffffff816296e4>] schedule+0x24/0x70
>> [ 480.659777] [<ffffffff816297b7>] io_schedule+0x87/0xd0
>> [ 480.659779] [<ffffffff810c34e9>] sleep_on_page+0x9/0x10
>> [ 480.659781] [<ffffffff81627bd2>] __wait_on_bit_lock+0x52/0xb0
>> [ 480.659783] [<ffffffff810c547d>] ? find_get_pages_tag+0xcd/0x180
>> [ 480.659785] [<ffffffff810c34d2>] __lock_page+0x62/0x70
>> [ 480.659789] [<ffffffff8105de10>] ? autoremove_wake_function+0x40/0x40
>> [ 480.659791] [<ffffffff810cf190>] ? pagevec_lookup_tag+0x20/0x30
>> [ 480.659793] [<ffffffff810cd736>] write_cache_pages+0x376/0x4c0
>> [ 480.659796] [<ffffffff810cc490>] ? set_page_dirty+0x70/0x70
>> [ 480.659798] [<ffffffff810cd8cc>] generic_writepages+0x4c/0x70
>> [ 480.659800] [<ffffffff81269fef>] xfs_vm_writepages+0x4f/0x60
>> [ 480.659802] [<ffffffff810cd90c>] do_writepages+0x1c/0x40
>> [ 480.659805] [<ffffffff811308ff>] writeback_single_inode+0x18f/0x400
>> [ 480.659807] [<ffffffff81130d06>] writeback_sb_inodes+0x196/0x260
>> [ 480.659809] [<ffffffff81130e66>] __writeback_inodes_wb+0x96/0xc0
>> [ 480.659811] [<ffffffff811317bb>] wb_writeback+0x1eb/0x2c0
>> [ 480.659814] [<ffffffff8104c1a1>] ? try_to_del_timer_sync+0x81/0xe0
>> [ 480.659816] [<ffffffff81131a89>] wb_do_writeback+0x1f9/0x250
>> [ 480.659818] [<ffffffff81131b7a>] bdi_writeback_thread+0x9a/0x230
>> [ 480.659820] [<ffffffff81131ae0>] ? wb_do_writeback+0x250/0x250
>> [ 480.659822] [<ffffffff81131ae0>] ? wb_do_writeback+0x250/0x250
>> [ 480.659824] [<ffffffff8105d8d6>] kthread+0x96/0xa0
>> [ 480.659827] [<ffffffff8162c094>] kernel_thread_helper+0x4/0x10
>> [ 480.659829] [<ffffffff8105d840>] ? kthread_worker_fn+0x130/0x130
>> [ 480.659832] [<ffffffff8162c090>] ? gs_change+0xb/0xb
>>
>> Am 26.06.2012 19:49, schrieb Stefan Priebe:
>>> I would but both XFS and btrfs are crashing after a short period.
>>>
>>> XFS crashes with this one:
>>> [ 479.732636] INFO: task ceph-osd:3217 blocked for more than 120
>>> seconds.
>>> [ 479.747724] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [ 479.763534] ceph-osd D ffffffff8180e9c0 0 3217 1
>>> 0x00000000
>>> [ 479.779837] ffff880bc4321bd8 0000000000000082 ffff880bc5694830
>>> 0000000000012200
>>> [ 479.779840] ffff880bc4321fd8 ffff880bc4320010 0000000000012200
>>> 0000000000012200
>>> [ 479.779841] ffff880bc4321fd8 0000000000012200 ffff880e40ea9810
>>> ffff880bc5694830
>>> [ 479.779843] Call Trace:
>>> [ 479.779850] [<ffffffff816296e4>] schedule+0x24/0x70
>>> [ 479.779853] [<ffffffff812c2049>] xlog_wait+0x69/0x90
>>> [ 479.779856] [<ffffffff8106de20>] ? try_to_wake_up+0x2b0/0x2b0
>>> [ 479.779858] [<ffffffff812c23b3>] xlog_cil_push+0x343/0x3c0
>>> [ 479.779861] [<ffffffff8126ce09>] ? xfs_buf_unlock+0x19/0x70
>>> [ 479.779862] [<ffffffff812c2ab1>] xlog_cil_force_lsn+0x101/0x110
>>> [ 479.779864] [<ffffffff812bccee>] ? xfs_trans_free_item_desc+0x2e/0x30
>>> [ 479.779865] [<ffffffff812bcd77>] ? xfs_trans_free_items+0x87/0xb0
>>> [ 479.779867] [<ffffffff812c07c8>] _xfs_log_force_lsn+0x48/0x290
>>> [ 479.779871] [<ffffffff8110351b>] ? kmem_cache_free+0x1b/0xf0
>>> [ 479.779872] [<ffffffff812bdfdb>] xfs_trans_commit+0x24b/0x260
>>> [ 479.779875] [<ffffffff81271e9d>] xfs_fs_log_dummy+0x5d/0x90
>>> [ 479.779877] [<ffffffff812bed9c>] ? xfs_log_need_covered+0x7c/0xc0
>>> [ 479.779879] [<ffffffff8127d378>] xfs_quiesce_data+0x88/0x90
>>> [ 479.779881] [<ffffffff8127b428>] xfs_fs_sync_fs+0x28/0x60
>>> [ 479.779884] [<ffffffff811363ae>] __sync_filesystem+0x5e/0x90
>>> [ 479.779885] [<ffffffff811364b3>] sync_filesystem+0x43/0x60
>>> [ 479.779887] [<ffffffff81136518>] sys_syncfs+0x48/0x80
>>> [ 479.779890] [<ffffffff8162ae62>] system_call_fastpath+0x16/0x1b

I'm not really familiar enough with XFS to help here.  :/  Did Ben 
Myer's suggestion to look at /proc/sysrq-trigger back in May provide any 
useful information?

Despite my ignorance here, it kind of seems like most of this is log or 
maybe an AG locking issue?  If you change around the size of the log 
(maybe internal vs external too?) and/or reduce the number of AGs to 1 
does it have any effect?

Mark
