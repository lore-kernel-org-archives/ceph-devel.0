From: Milosz Tanski <milosz@adfin.com>
Subject: Re: fscache recursive hang -- similar to loopback NFS issues
Date: Sat, 19 Jul 2014 16:31:45 -0400
Message-ID: <CANP1eJFtisqDxSN-vUAsPJZgqjoCDnM5JJdxoPLmqgha9dv1bA@mail.gmail.com>
References: <CANP1eJE7tU9touhSq+Utt=MLE4w5D_C4pT1TAFAiFNBh8ee_mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:53256 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbaGSUbr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jul 2014 16:31:47 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so2338070wib.2
        for <ceph-devel@vger.kernel.org>; Sat, 19 Jul 2014 13:31:46 -0700 (PDT)
In-Reply-To: <CANP1eJE7tU9touhSq+Utt=MLE4w5D_C4pT1TAFAiFNBh8ee_mA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: neilb@suse.de
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, David Howells <dhowells@redhat.com>

I forgot to mention this.... David Howells attempt to fix a similar
issue with NFS and fscache on ext4 last year:
http://www.redhat.com/archives/linux-cachefs/2013-May/msg00003.html
The problem is that ext4 it's wisdom tries to allocate a page without
using GPF_NOFS In the code: ext4/inode.c:2678 so the fix that David
added not going to do anything for us.

        /*
         * grab_cache_page_write_begin() can take a long time if the
         * system is thrashing due to memory pressure, or if the page
         * is being written back.  So grab it first before we start
         * the transaction handle.  This also allows us to allocate
         * the page (if needed) without using GFP_NOFS.
         */
retry_grab:
        page = grab_cache_page_write_begin(mapping, index, flags);
        if (!page)


On Sat, Jul 19, 2014 at 4:20 PM, Milosz Tanski <milosz@adfin.com> wrote:
> Neil,
>
> I saw your recent patcheset for improving the wait_on_bit interface
> (particular: SCHED: allow wait_on_bit_action functions to support a
> timeout.) I'm looking on some guidance on leveraging that work to
> solve other recursive lock hang in fscache.
>
> I've ran into similar issues you're trying to solve with loopback NFS
> but in the fscache code. This happens under heavy vma preasure when
> the kernel is aggressively trying to trim the page cache.
>
> The hang is caused by this serious of events
> 1. cachefiles_write_page - cachefiles (the fscache backend, sitting on
> ext4) tries to write page to disk
> 2. ext4 tries to allocate a page in writeback (without GPF_NOFS and
> with wait flag)
> 3. due to vma preasure the kernel tries to free-up pages
> 4. this causes release pages in ceph to be called
> 5. the selected page is cached page in process of write out (from step #1)
> 6. fscache_wait_on_page_write hangs forever
>
> Is there a solution that you have to NFS as another patch that
> implements the timeout that I can use a template? I'm not familiar
> with that piece of the code base.
>
> Best,
> - Milosz
>
> INFO: task kworker/u30:7:28375 blocked for more than 120 seconds.
>       Not tainted 3.15.0-virtual #74
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/u30:7   D 0000000000000000     0 28375      2 0x00000000
> Workqueue: fscache_operation fscache_op_work_func [fscache]
>  ffff88000b147148 0000000000000046 0000000000000000 ffff88000b1471c8
>  ffff8807aa031820 0000000000014040 ffff88000b147fd8 0000000000014040
>  ffff880f0c50c860 ffff8807aa031820 ffff88000b147158 ffff88007be59cd0
> Call Trace:
>  [<ffffffff815930e9>] schedule+0x29/0x70
>  [<ffffffffa018bed5>] __fscache_wait_on_page_write+0x55/0x90 [fscache]
>  [<ffffffff810a4350>] ? __wake_up_sync+0x20/0x20
>  [<ffffffffa018c135>] __fscache_maybe_release_page+0x65/0x1e0 [fscache]
>  [<ffffffffa02ad813>] ceph_releasepage+0x83/0x100 [ceph]
>  [<ffffffff811635b0>] ? anon_vma_fork+0x130/0x130
>  [<ffffffff8112cdd2>] try_to_release_page+0x32/0x50
>  [<ffffffff81140096>] shrink_page_list+0x7e6/0x9d0
>  [<ffffffff8113f278>] ? isolate_lru_pages.isra.73+0x78/0x1e0
>  [<ffffffff81140932>] shrink_inactive_list+0x252/0x4c0
>  [<ffffffff811412b1>] shrink_lruvec+0x3e1/0x670
>  [<ffffffff8114157f>] shrink_zone+0x3f/0x110
>  [<ffffffff81141b06>] do_try_to_free_pages+0x1d6/0x450
>  [<ffffffff8114a939>] ? zone_statistics+0x99/0xc0
>  [<ffffffff81141e44>] try_to_free_pages+0xc4/0x180
>  [<ffffffff81136982>] __alloc_pages_nodemask+0x6b2/0xa60
>  [<ffffffff811c1d4e>] ? __find_get_block+0xbe/0x250
>  [<ffffffff810a405e>] ? wake_up_bit+0x2e/0x40
>  [<ffffffff811740c3>] alloc_pages_current+0xb3/0x180
>  [<ffffffff8112cf07>] __page_cache_alloc+0xb7/0xd0
>  [<ffffffff8112da6c>] grab_cache_page_write_begin+0x7c/0xe0
>  [<ffffffff81214072>] ? ext4_mark_inode_dirty+0x82/0x220
>  [<ffffffff81214a89>] ext4_da_write_begin+0x89/0x2d0
>  [<ffffffff8112c6ee>] generic_perform_write+0xbe/0x1d0
>  [<ffffffff811a96b1>] ? update_time+0x81/0xc0
>  [<ffffffff811ad4c2>] ? mnt_clone_write+0x12/0x30
>  [<ffffffff8112e80e>] __generic_file_aio_write+0x1ce/0x3f0
>  [<ffffffff8112ea8e>] generic_file_aio_write+0x5e/0xe0
>  [<ffffffff8120b94f>] ext4_file_write+0x9f/0x410
>  [<ffffffff8120af56>] ? ext4_file_open+0x66/0x180
>  [<ffffffff8118f0da>] do_sync_write+0x5a/0x90
>  [<ffffffffa025c6c9>] cachefiles_write_page+0x149/0x430 [cachefiles]
>  [<ffffffff812cf439>] ? radix_tree_gang_lookup_tag+0x89/0xd0
>  [<ffffffffa018c512>] fscache_write_op+0x222/0x3b0 [fscache]
>  [<ffffffffa018b35a>] fscache_op_work_func+0x3a/0x100 [fscache]
>  [<ffffffff8107bfe9>] process_one_work+0x179/0x4a0
>  [<ffffffff8107d47b>] worker_thread+0x11b/0x370
>  [<ffffffff8107d360>] ? manage_workers.isra.21+0x2e0/0x2e0
>  [<ffffffff81083d69>] kthread+0xc9/0xe0
>  [<ffffffff81010000>] ? ftrace_raw_event_xen_mmu_release_ptpage+0x70/0x90
>  [<ffffffff81083ca0>] ? flush_kthread_worker+0xb0/0xb0
>  [<ffffffff8159eefc>] ret_from_fork+0x7c/0xb0
>  [<ffffffff81083ca0>] ? flush_kthread_worker+0xb0/0xb0
>
> --
> Milosz Tanski
> CTO
> 16 East 34th Street, 15th floor
> New York, NY 10016
>
> p: 646-253-9055
> e: milosz@adfin.com



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
