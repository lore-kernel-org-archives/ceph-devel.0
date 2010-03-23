From: Sage Weil <sage@newdream.net>
Subject: mmap_sem lockdep warning
Date: Tue, 23 Mar 2010 09:53:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1003230919090.28286@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

Not sure if this is a real problem or not.. I don't think we can ever 
fault in sendmsg since we're always passing in a kernel pointer?

[ 1615.328733] =======================================================
[ 1615.331050] [ INFO: possible circular locking dependency detected ]
[ 1615.331050] 2.6.34-rc2 #22
[ 1615.331050] -------------------------------------------------------
[ 1615.331050] fixdep/3263 is trying to acquire lock:
[ 1615.331050]  (&osdc->request_mutex){+.+...}, at: [<ffffffffa007b66c>] ceph_osdc_start_request+0x4d/0x278 [ceph]
[ 1615.331050] 
[ 1615.331050] but task is already holding lock:
[ 1615.331050]  (&mm->mmap_sem){++++++}, at: [<ffffffff810208c0>] do_page_fault+0x104/0x278
[ 1615.331050] 
[ 1615.331050] which lock already depends on the new lock.
[ 1615.331050] 
[ 1615.331050] 
[ 1615.331050] the existing dependency chain (in reverse order) is:
[ 1615.331050] 
[ 1615.331050] -> #3 (&mm->mmap_sem){++++++}:
[ 1615.331050]        [<ffffffff81059fd3>] validate_chain+0xa4d/0xd28
[ 1615.331050]        [<ffffffff8105aa7f>] __lock_acquire+0x7d1/0x84e
[ 1615.331050]        [<ffffffff8105ab84>] lock_acquire+0x88/0xa5
[ 1615.331050]        [<ffffffff81094daf>] might_fault+0x90/0xb3
[ 1615.331050]        [<ffffffff81390d1e>] memcpy_fromiovecend+0x54/0x8e
[ 1615.331050]        [<ffffffff813b6ea7>] ip_generic_getfrag+0x2a/0x8f
[ 1615.331050]        [<ffffffff813b5da2>] ip_append_data+0x5f6/0x971
[ 1615.331050]        [<ffffffff813d35bf>] udp_sendmsg+0x4e8/0x603
[ 1615.331050]        [<ffffffff813d91e3>] inet_sendmsg+0x46/0x53
[ 1615.331050]        [<ffffffff813878c1>] sock_sendmsg+0xd4/0xf5
[ 1615.331050]        [<ffffffff81387e0f>] sys_sendto+0xdf/0x107
[ 1615.331050]        [<ffffffff810029eb>] system_call_fastpath+0x16/0x1b
[ 1615.331050] 
[ 1615.331050] -> #2 (sk_lock-AF_INET){+.+.+.}:
[ 1615.331050]        [<ffffffff81059fd3>] validate_chain+0xa4d/0xd28
[ 1615.331050]        [<ffffffff8105aa7f>] __lock_acquire+0x7d1/0x84e
[ 1615.331050]        [<ffffffff8105ab84>] lock_acquire+0x88/0xa5
[ 1615.331050]        [<ffffffff8138a562>] lock_sock_nested+0xeb/0xff
[ 1615.331050]        [<ffffffff813da29d>] inet_stream_connect+0x2b/0x25c
[ 1615.331050]        [<ffffffffa006eea6>] try_write+0x26e/0x102c [ceph]
[ 1615.331050]        [<ffffffffa00705ba>] con_work+0x126/0x6bc [ceph]
[ 1615.529553]        [<ffffffff8104774e>] worker_thread+0x1e8/0x2fa
[ 1615.529553]        [<ffffffff8104a4aa>] kthread+0x7d/0x85
[ 1615.529553]        [<ffffffff81003794>] kernel_thread_helper+0x4/0x10
[ 1615.529553] 
[ 1615.529553] -> #1 (&con->mutex){+.+.+.}:
[ 1615.529553]        [<ffffffff81059fd3>] validate_chain+0xa4d/0xd28
[ 1615.529553]        [<ffffffff8105aa7f>] __lock_acquire+0x7d1/0x84e
[ 1615.529553]        [<ffffffff8105ab84>] lock_acquire+0x88/0xa5
[ 1615.529553]        [<ffffffff81425727>] mutex_lock_nested+0x62/0x32c
[ 1615.529553]        [<ffffffffa0070cd3>] ceph_con_send+0xb3/0x244 [ceph]
[ 1615.529553]        [<ffffffffa007b591>] __send_request+0x108/0x196 [ceph]
[ 1615.529553]        [<ffffffffa007b794>] ceph_osdc_start_request+0x175/0x278 [ceph]
[ 1615.529553]        [<ffffffffa006029d>] ceph_writepages_start+0xb23/0x112a [ceph]
[ 1615.529553]        [<ffffffff810849aa>] do_writepages+0x1f/0x28
[ 1615.529553]        [<ffffffff810ca5e8>] writeback_single_inode+0xb6/0x1f5
[ 1615.529553]        [<ffffffff810cad9b>] writeback_inodes_wb+0x2d1/0x378
[ 1615.529553]        [<ffffffff810cafa8>] wb_writeback+0x166/0x1e0
[ 1615.529553]        [<ffffffff810cb154>] wb_do_writeback+0x83/0x1d3
[ 1615.529553]        [<ffffffff810cb2d2>] bdi_writeback_task+0x2e/0x9b
[ 1615.529553]        [<ffffffff8108fd73>] bdi_start_fn+0x71/0xd2
[ 1615.529553]        [<ffffffff8104a4aa>] kthread+0x7d/0x85
[ 1615.529553]        [<ffffffff81003794>] kernel_thread_helper+0x4/0x10
[ 1615.529553] 
[ 1615.529553] -> #0 (&osdc->request_mutex){+.+...}:
[ 1615.529553]        [<ffffffff81059cbf>] validate_chain+0x739/0xd28
[ 1615.529553]        [<ffffffff8105aa7f>] __lock_acquire+0x7d1/0x84e
[ 1615.529553]        [<ffffffff8105ab84>] lock_acquire+0x88/0xa5
[ 1615.529553]        [<ffffffff81425727>] mutex_lock_nested+0x62/0x32c
[ 1615.529553]        [<ffffffffa007b66c>] ceph_osdc_start_request+0x4d/0x278 [ceph]
[ 1615.529553]        [<ffffffffa007d8b6>] ceph_osdc_readpages+0x123/0x222 [ceph]
[ 1615.529553]        [<ffffffffa005f4b7>] ceph_readpages+0x193/0x456 [ceph]
[ 1615.529553]        [<ffffffff81085bd1>] __do_page_cache_readahead+0x17d/0x1f5
[ 1615.529553]        [<ffffffff81085c65>] ra_submit+0x1c/0x20
[ 1615.529553]        [<ffffffff81085fab>] ondemand_readahead+0x264/0x277
[ 1615.529553]        [<ffffffff81086092>] page_cache_sync_readahead+0x33/0x35
[ 1615.529553]        [<ffffffff8107f0d7>] filemap_fault+0x143/0x31f
[ 1615.529553]        [<ffffffff810913bf>] __do_fault+0x50/0x415
[ 1615.529553]        [<ffffffff810934d9>] handle_mm_fault+0x334/0x6a6
[ 1615.529553]        [<ffffffff810209af>] do_page_fault+0x1f3/0x278
[ 1615.529553]        [<ffffffff814281ff>] page_fault+0x1f/0x30
[ 1615.529553] 
[ 1615.529553] other info that might help us debug this:
[ 1615.529553] 
[ 1615.529553] 1 lock held by fixdep/3263:
[ 1615.529553]  #0:  (&mm->mmap_sem){++++++}, at: [<ffffffff810208c0>] do_page_fault+0x104/0x278
[ 1615.529553] 
[ 1615.529553] stack backtrace:
[ 1615.529553] Pid: 3263, comm: fixdep Not tainted 2.6.34-rc2 #22
[ 1615.529553] Call Trace:
[ 1615.529553]  [<ffffffff81058f49>] print_circular_bug+0xb3/0xc1
[ 1615.529553]  [<ffffffff81059cbf>] validate_chain+0x739/0xd28
[ 1615.529553]  [<ffffffff810099d7>] ? native_sched_clock+0x37/0x71
[ 1615.824177]  [<ffffffff8105aa7f>] __lock_acquire+0x7d1/0x84e
[ 1615.824177]  [<ffffffff8105ab84>] lock_acquire+0x88/0xa5
[ 1615.824177]  [<ffffffffa007b66c>] ? ceph_osdc_start_request+0x4d/0x278 [ceph]
[ 1615.824177]  [<ffffffffa007b66c>] ? ceph_osdc_start_request+0x4d/0x278 [ceph]
[ 1615.824177]  [<ffffffff81425727>] mutex_lock_nested+0x62/0x32c
[ 1615.824177]  [<ffffffffa007b66c>] ? ceph_osdc_start_request+0x4d/0x278 [ceph]
[ 1615.824177]  [<ffffffffa007b66c>] ceph_osdc_start_request+0x4d/0x278 [ceph]
[ 1615.824177]  [<ffffffffa007d8b6>] ceph_osdc_readpages+0x123/0x222 [ceph]
[ 1615.824177]  [<ffffffffa005f4b7>] ceph_readpages+0x193/0x456 [ceph]
[ 1615.824177]  [<ffffffff810099d7>] ? native_sched_clock+0x37/0x71
[ 1615.824177]  [<ffffffff81056580>] ? get_lock_stats+0x19/0x4c
[ 1615.824177]  [<ffffffff81085bd1>] __do_page_cache_readahead+0x17d/0x1f5
[ 1615.824177]  [<ffffffff81085ad0>] ? __do_page_cache_readahead+0x7c/0x1f5
[ 1615.824177]  [<ffffffff8107d848>] ? find_get_page+0xd9/0x12d
[ 1615.824177]  [<ffffffff81085c65>] ra_submit+0x1c/0x20
[ 1615.916887]  [<ffffffff81085fab>] ondemand_readahead+0x264/0x277
[ 1615.916887]  [<ffffffff81086092>] page_cache_sync_readahead+0x33/0x35
[ 1615.931403]  [<ffffffff8107f0d7>] filemap_fault+0x143/0x31f
[ 1615.931403]  [<ffffffff810913bf>] __do_fault+0x50/0x415
[ 1615.931403]  [<ffffffff8105aa99>] ? __lock_acquire+0x7eb/0x84e
[ 1615.946963]  [<ffffffff810934d9>] handle_mm_fault+0x334/0x6a6
[ 1615.946963]  [<ffffffff810209af>] do_page_fault+0x1f3/0x278
[ 1615.946963]  [<ffffffff814281ff>] page_fault+0x1f/0x30

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
