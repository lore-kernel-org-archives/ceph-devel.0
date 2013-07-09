From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH] ceph: Add FScache support
Date: Tue, 9 Jul 2013 10:07:21 -0400
Message-ID: <CANP1eJFqL_12Qejxxt5sWLuRdnSSsuznNjL1tk+6EP7dN7y1eQ@mail.gmail.com>
References: <20130629035155.GA7975@gmail.com>
	<CANP1eJGJ4eAn1BtXSnKLu5egDAtK5DFAX9S1nWtBFnbLKWDtJA@mail.gmail.com>
	<CANP1eJGouH+_FXEbaRsrqt1QMY5HEPj6bLV2Pw7LhY5v37Hapw@mail.gmail.com>
	<11954.1372792498@warthog.procyon.org.uk>
	<CANP1eJGQqiijOVsX+sz1WY6CwViYweh3fo0N0VUznmTGVQCJzQ@mail.gmail.com>
	<12577.1372793962@warthog.procyon.org.uk>
	<CANP1eJGqq0ocQQUS5sBsvdT35qADSMoFLC71uprt_qw7=Pphrg@mail.gmail.com>
	<1074.1372798161@warthog.procyon.org.uk>
	<CANP1eJH9PU3wX8m9auNjHrRt=rQWKCMmnFjfQ+V4tSG7mBBoEg@mail.gmail.com>
	<3869.1372808417@warthog.procyon.org.uk>
	<CANP1eJFQgoLBjZ7-vCTzRb62H2P6hX5ZD8u2XyMQAjwZtFJDJQ@mail.gmail.com>
	<CANP1eJG1=58P70-j0GH=iS_0a6_0mWDFeg0e4batRN9_caYz_w@mail.gmail.com>
	<6424.1373366024@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35982 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab3GIOHV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jul 2013 10:07:21 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so12727701iec.36
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jul 2013 07:07:21 -0700 (PDT)
In-Reply-To: <6424.1373366024@warthog.procyon.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Trond.Myklebust@netapp.com, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, linux-cachefs@redhat.com

David,

I have another one for you... I though maybe I caused this somehow so
I spent like 8 hours tracking. But now I'm not so sure. I got this
error when running this  "stress test"

root@pbnode-58019a39:/mnt/cluster/petabucket/prod# find -type f |
xargs -P 16 cat | pv > /dev/null
^C83GB 0:00:52 [   0B/s] [
<=>

Any ideas where to look for the issue?

- Milosz

[4123376.919781] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000040
[4123376.919799]
[4123376.919800] CacheFiles: Error: Unexpected object collision
[4123376.919803] object: OBJ35bf
[4123376.919806] objstate=LOOK_UP_OBJECT fl=8 wbusy=2 ev=0[0]
[4123376.919807] ops=0 inp=0 exc=0
[4123376.919808] parent=ffff880ecafec180
[4123376.919809] cookie=ffff880bc9cb5f00 [pr=ffff880ece306000
nd=ffff880eaadeb648 fl=3]
[4123376.919820] key=[16] '1d86000000010000feffffffffffffff'
[4123376.919821] xobject: OBJ35bc
[4123376.919824] xobjstate=WAIT_FOR_CLEARANCE fl=30 wbusy=0 ev=0[10]
[4123376.919826] xops=1 inp=1 exc=0
[4123376.919826] xparent=ffff880ecafec180
[4123376.919828] xcookie=ffff880bc9cb5d80 [pr=ffff880ece306000 nd=
     (null) fl=10]
[4123376.919861] IP: [<ffffffffa01aed62>]
__fscache_read_or_alloc_pages+0x122/0x400 [fscache]
[4123376.919882] PGD bc9eaa067 PUD d7a501067 PMD 0
[4123376.919892] Oops: 0000 [#1] SMP
[4123376.919901] Modules linked in: ceph libceph cachefiles
ghash_clmulni_intel aesni_intel ablk_helper cryptd lrw gf128mul
glue_helper aes_x86_64 microcode auth_rpcgss oid_registry nfsv4 nfs
fscache lockd sunrpc raid10 raid456 async_pq async_xor async_memcpy
async_raid6_recov async_tx raid1 multipath linear btrfs raid6_pq
lzo_compress raid0 xor zlib_deflate libcrc32c
[4123376.919966] CPU: 12 PID: 2523 Comm: cat Not tainted 3.10.0-virtual #22
[4123376.919973] task: ffff880ecbfdae40 ti: ffff880bc2cda000 task.ti:
ffff880bc2cda000
[4123376.919982] RIP: e030:[<ffffffffa01aed62>]  [<ffffffffa01aed62>]
__fscache_read_or_alloc_pages+0x122/0x400 [fscache]
[4123376.919998] RSP: e02b:ffff880bc2cdb928  EFLAGS: 00010206
[4123376.920004] RAX: 0000000000000000 RBX: ffff880bc9cb5d80 RCX:
ffff880f1b68c000
[4123376.920012] RDX: ffff880bc9cb5d80 RSI: 0000000000000000 RDI:
ffff880bc9cb5d90
[4123376.920019] RBP: ffff880bc2cdb978 R08: f020000000000000 R09:
0ecac6e278100000
[4123376.920027] R10: f1173cd039a89e04 R11: 0000000000302135 R12:
ffff880bc9c79200
[4123376.920036] R13: ffff880ecac6e240 R14: ffff880bc9c79280 R15:
ffff880bc2cdba64
[4123376.920050] FS:  00007fc8b53bb700(0000) GS:ffff880f1b580000(0000)
knlGS:0000000000000000
[4123376.920059] CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
[4123376.920065] CR2: 0000000000000040 CR3: 0000000bc9c61000 CR4:
0000000000002660
[4123376.920073] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[4123376.920081] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
0000000000000400
[4123376.920090] Stack:
[4123376.920095]  ffff880eca660a00 0000000000000000 ffff880bc9cb5d90
ffff880bc2cdbb38
[4123376.920108]  ffff880bc2cdb978 ffff880eaadebb20 ffff880bc2cdbb38
ffff880eaadeb9a8
[4123376.920121]  ffff880bc2cdba64 0000000000000016 ffff880bc2cdb9c8
ffffffffa02f3a93
[4123376.920133] Call Trace:
[4123376.920147]  [<ffffffffa02f3a93>]
__ceph_readpages_from_fscache+0x93/0xc0 [ceph]
[4123376.920160]  [<ffffffffa02e1f35>] ceph_readpages+0x45/0x400 [ceph]
[4123376.920173]  [<ffffffff8115868a>] ? alloc_pages_current+0xba/0x170
[4123376.920184]  [<ffffffff81116547>] ? __page_cache_alloc+0xb7/0xd0
[4123376.920193]  [<ffffffff81132939>] ? zone_statistics+0x99/0xc0
[4123376.920204]  [<ffffffff811224f2>] __do_page_cache_readahead+0x1b2/0x260
[4123376.920216]  [<ffffffff812a9ecb>] ? radix_tree_lookup+0xb/0x10
[4123376.920225]  [<ffffffff81122aa9>] ondemand_readahead+0x189/0x230
[4123376.920233]  [<ffffffff81122c31>] page_cache_sync_readahead+0x31/0x50
[4123376.920242]  [<ffffffff81118188>] generic_file_aio_read+0x4a8/0x720
[4123376.920253]  [<ffffffffa02e7d2b>] ? ceph_get_caps+0xcb/0x1e0 [ceph]
[4123376.920265]  [<ffffffffa02dfca1>] ceph_aio_read+0x531/0x5c0 [ceph]
[4123376.920275]  [<ffffffff81190f28>] ? __mnt_want_write+0x58/0x70
[4123376.920285]  [<ffffffff8118bcf7>] ? file_update_time+0xa7/0x100
[4123376.920296]  [<ffffffff81171a4a>] do_sync_read+0x7a/0xb0
[4123376.920304]  [<ffffffff81172920>] vfs_read+0xb0/0x180
[4123376.920313]  [<ffffffff81172ba2>] SyS_read+0x52/0xa0
[4123376.920323]  [<ffffffff8155de99>] system_call_fastpath+0x16/0x1b
[4123376.920329] Code: 89 e7 e8 e2 d4 ff ff 85 c0 0f 88 f2 00 00 00 48
8b 7d c0 e8 41 66 3a e1 f0 ff 05 96 59 00 00 49 8b 56 18 49 8b 75 70
48 8b 42 48 <48> 8b 40 40 48 85 c0 74 06 48 8b 7a 58 ff d0 4c 89 e7 48
c7 c1
[4123376.920399] RIP  [<ffffffffa01aed62>]
__fscache_read_or_alloc_pages+0x122/0x400 [fscache]
[4123376.920412]  RSP <ffff880bc2cdb928>
[4123376.920416] CR2: 0000000000000040
[4123376.920422] ---[ end trace c2ccf1289b7570af ]---
[4123376.920425] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000020
[4123376.920431] IP: [<ffffffffa02d09b5>]
__cachefiles_printk_object+0xe9/0x161 [cachefiles]
[4123376.920436] PGD bca510067 PUD bdea09067 PMD 0
[4123376.920438] Oops: 0000 [#2] SMP
[4123376.920439] Modules linked in: ceph libceph cachefiles
ghash_clmulni_intel aesni_intel ablk_helper cryptd lrw gf128mul
glue_helper aes_x86_64 microcode auth_rpcgss oid_registry nfsv4 nfs
fscache lockd sunrpc raid10 raid456 async_pq async_xor async_memcpy
async_raid6_recov async_tx raid1 multipath linear btrfs raid6_pq
lzo_compress raid0 xor zlib_deflate libcrc32c
[4123376.920488] CPU: 4 PID: 1027 Comm: kworker/u32:2 Tainted: G
D      3.10.0-virtual #22
[4123376.920500] Workqueue: fscache_object fscache_object_work_func [fscache]
[4123376.920509] task: ffff880eca469720 ti: ffff880ecd21e000 task.ti:
ffff880ecd21e000
[4123376.920517] RIP: e030:[<ffffffffa02d09b5>]  [<ffffffffa02d09b5>]
__cachefiles_printk_object+0xe9/0x161 [cachefiles]
[4123376.920531] RSP: e02b:ffff880ecd21fbc8  EFLAGS: 00010286
[4123376.920537] RAX: 0000000000000000 RBX: ffff880bc9cb5d80 RCX:
0000000000002322
[4123376.920546] RDX: 0000000000000200 RSI: ffff880ecaddc000 RDI:
0000000000000000
[4123376.920554] RBP: ffff880ecd21fc08 R08: 00000000430e73cc R09:
ffffffff81c228a4
[4123376.923888] [kworke] unexpected submission OP111e11 [OBJ35c1
LOOK_UP_OBJECT]
[4123376.923890] [kworke] objstate=LOOK_UP_OBJECT [LOOK_UP_OBJECT]
[4123376.923890] [kworke] objflags=a
[4123376.923891] [kworke] objevent=0 [0]
[4123376.923892] [kworke] ops=0 inp=0 exc=0
[4123376.923895] CPU: 1 PID: 99 Comm: kworker/1:1 Tainted: G      D
  3.10.0-virtual #22
[4123376.923905] Workqueue: ceph-msgr con_work [libceph]
[4123376.923909]  ffff880ecc8c0700 ffff880eccccfb28 ffffffff8154f6cc
ffff880eccccfb78
[4123376.923911]  ffffffffa01ac6b2 ffff880bc9c78268 ffff880ecff4c9b8
0000000000000000
[4123376.923913]  ffff880bc9cb5c00 ffffea002eb8cd80 ffff880bc9c78200
ffff880ecc8c0700
[4123376.923913] Call Trace:
[4123376.923922]  [<ffffffff8154f6cc>] dump_stack+0x19/0x1b
[4123376.923930]  [<ffffffffa01ac6b2>] fscache_submit_op+0x492/0x500 [fscache]
[4123376.923934]  [<ffffffffa01ad8a2>]
__fscache_write_page+0x302/0x4f0 [fscache]
[4123376.923941]  [<ffffffffa02f3aee>]
__ceph_readpage_to_fscache+0x2e/0x60 [ceph]
[4123376.923945]  [<ffffffffa02e2e5e>] finish_read+0x9e/0x160 [ceph]
[4123376.923950]  [<ffffffffa02645fd>] dispatch+0x3fd/0x730 [libceph]
[4123376.923954]  [<ffffffffa025d7e4>] con_work+0x1294/0x2150 [libceph]
[4123376.923960]  [<ffffffff81555455>] ? _raw_spin_unlock_irq+0x15/0x20
[4123376.923964]  [<ffffffff810855e3>] ? finish_task_switch+0x63/0xd0
[4123376.923968]  [<ffffffff810736ed>] process_one_work+0x17d/0x490
[4123376.923970]  [<ffffffff810747eb>] worker_thread+0x11b/0x370
[4123376.923972]  [<ffffffff810746d0>] ? manage_workers.isra.21+0x2e0/0x2e0
[4123376.923975]  [<ffffffff8107af88>] kthread+0xd8/0xe0
[4123376.923977]  [<ffffffff8107aeb0>] ? flush_kthread_worker+0xe0/0xe0
[4123376.923980]  [<ffffffff8155ddec>] ret_from_fork+0x7c/0xb0
[4123376.923982]  [<ffffffff8107aeb0>] ? flush_kthread_worker+0xe0/0xe0
[4123377.122015] R10: 0000000000000068 R11: 000000000003b4d8 R12:
ffffffffa02d1fbb
[4123377.122024] R13: ffff880bc9c79230 R14: ffff880ecaddc000 R15:
0000000000000000
[4123377.122035] FS:  00007f14a1362700(0000) GS:ffff880f1b480000(0000)
knlGS:0000000000000000
[4123377.122044] CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
[4123377.122050] CR2: 0000000000000020 CR3: 0000000bc9e6c000 CR4:
0000000000002660
[4123377.122057] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[4123377.122065] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
0000000000000400
[4123377.122072] Stack:
[4123377.122076]  0000000000000010 00000010c9c79350 ffff880ecd21fc38
ffff880bc9c79200
[4123377.122090]  ffff880bc9c78900 ffff880ecaddc000 ffff880bc9c79200
ffff880bc9c79350
[4123377.122102]  ffff880ecd21fc38 ffffffffa02d0a89 0000000000000606
ffff880bc9c78900
[4123377.122114] Call Trace:
[4123377.122128]  [<ffffffffa02d0a89>]
cachefiles_printk_object+0x5c/0x5d3 [cachefiles]
[4123377.122140]  [<ffffffffa02ccaf2>]
cachefiles_walk_to_object+0xbd2/0xda0 [cachefiles]
[4123377.122153]  [<ffffffff810d51fe>] ? irq_get_irq_data+0xe/0x10
[4123377.122163]  [<ffffffff81010640>] ? xen_smp_send_reschedule+0x10/0x20
[4123377.122174]  [<ffffffff81087760>] ? resched_task+0x60/0x70
[4123377.122185]  [<ffffffffa02ca40c>]
cachefiles_lookup_object+0x6c/0x180 [cachefiles]
[4123377.122200]  [<ffffffffa01aa4a9>]
fscache_look_up_object+0xe9/0x370 [fscache]
[4123377.122212]  [<ffffffffa01aac47>]
fscache_object_work_func+0x107/0x4b0 [fscache]
[4123377.122221]  [<ffffffff810736ed>] process_one_work+0x17d/0x490
[4123377.122227]  [<ffffffff810747eb>] worker_thread+0x11b/0x370
[4123377.122232]  [<ffffffff810746d0>] ? manage_workers.isra.21+0x2e0/0x2e0
[4123377.122238]  [<ffffffff8107af88>] kthread+0xd8/0xe0
[4123377.122243]  [<ffffffff8107aeb0>] ? flush_kthread_worker+0xe0/0xe0
[4123377.122251]  [<ffffffff8155ddec>] ret_from_fork+0x7c/0xb0
[4123377.122256]  [<ffffffff8107aeb0>] ? flush_kthread_worker+0xe0/0xe0
[4123377.122260] Code: 4c 8b 4b 70 48 89 da 4c 89 e6 4c 8b 43 58 45 31
ff e8 15 b3 27 e1 4d 85 f6 74 2d 48 8b 43 48 ba 00 02 00 00 4c 89 f6
48 8b 7b 58 <ff> 50 20 44 0f b7 f8 eb 14 4c 89 e6 48 c7 c7 92 1f 2d a0
31 c0
[4123377.122307] RIP  [<ffffffffa02d09b5>]
__cachefiles_printk_object+0xe9/0x161 [cachefiles]
[4123377.122315]  RSP <ffff880ecd21fbc8>
[4123377.122318] CR2: 0000000000000020
[4123377.122349] ---[ end trace c2ccf1289b7570b0 ]---
[4123377.122415] BUG: unable to handle kernel paging request at ffffffffffffffc8
[4123377.122436] IP: [<ffffffff8107afd1>] kthread_data+0x11/0x20
[4123377.122442] PGD 1a0f067 PUD 1a11067 PMD 0
[4123377.122447] Oops: 0000 [#3] SMP
[4123377.122452] Modules linked in: ceph libceph cachefiles
ghash_clmulni_intel aesni_intel ablk_helper cryptd lrw gf128mul
glue_helper aes_x86_64 microcode auth_rpcgss oid_registry nfsv4 nfs
fscache lockd sunrpc raid10 raid456 async_pq async_xor async_memcpy
async_raid6_recov async_tx raid1 multipath linear btrfs raid6_pq
lzo_compress raid0 xor zlib_deflate libcrc32c
[4123377.122495] CPU: 4 PID: 1027 Comm: kworker/u32:2 Tainted: G
D      3.10.0-virtual #22
[4123377.122511] task: ffff880eca469720 ti: ffff880ecd21e000 task.ti:
ffff880ecd21e000
[4123377.122516] RIP: e030:[<ffffffff8107afd1>]  [<ffffffff8107afd1>]
kthread_data+0x11/0x20
[4123377.122523] RSP: e02b:ffff880ecd21f7b0  EFLAGS: 00010046
[4123377.122527] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
ffffffff81c62a80
[4123377.321869] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880eca469720
[4123377.321876] RBP: ffff880ecd21f7c8 R08: 000000000a046368 R09:
0000000000000000
[4123377.321881] R10: ffffffff81287372 R11: ffff880ecbe72a08 R12:
0000000000000004
[4123377.321888] R13: ffff880eca469ae8 R14: ffff880ed00e8000 R15:
ffff880eca4699f0
[4123377.321899] FS:  00007f14a1362700(0000) GS:ffff880f1b480000(0000)
knlGS:0000000000000000
[4123377.321907] CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
[4123377.321913] CR2: 0000000000000028 CR3: 0000000bc9e6c000 CR4:
0000000000002660
[4123377.321921] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[4123377.321929] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
0000000000000400
[4123377.321937] Stack:
[4123377.321941]  ffffffff81074c66 ffff880f1b494200 0000000000000004
ffff880ecd21f848
[4123377.321955]  ffffffff81554048 ffff880ecd21f7f8 ffff880ecbde59d8
ffff880eca469720
[4123377.321968]  ffff880ecd21ffd8 ffff880ecd21ffd8 ffff880ecd21ffd8
ffff880ecbde59d8
[4123377.321981] Call Trace:
[4123377.321990]  [<ffffffff81074c66>] ? wq_worker_sleeping+0x16/0x90
[4123377.322002]  [<ffffffff81554048>] __schedule+0x5c8/0x810
[4123377.322010]  [<ffffffff81554349>] schedule+0x29/0x70
[4123377.322022]  [<ffffffff8105ab20>] do_exit+0x6e0/0xa60
[4123377.322032]  [<ffffffff8154bd02>] ? printk+0x4d/0x4f
[4123377.322043]  [<ffffffff8100afc2>] ? check_events+0x12/0x20
[4123377.322054]  [<ffffffff815566c0>] oops_end+0xb0/0xf0
[4123377.322063]  [<ffffffff8154b5c0>] no_context+0x276/0x285
[4123377.322071]  [<ffffffff8154b7a2>] __bad_area_nosemaphore+0x1d3/0x1f2
[4123377.322080]  [<ffffffff8154b7d4>] bad_area_nosemaphore+0x13/0x15
[4123377.322088]  [<ffffffff81559502>] __do_page_fault+0x3b2/0x550
[4123377.322100]  [<ffffffff810196b9>] ? sched_clock+0x9/0x10
[4123377.322111]  [<ffffffff8108cd8d>] ? sched_clock_cpu+0xbd/0x110
[4123377.322121]  [<ffffffff8108ce14>] ? local_clock+0x34/0x40
[4123377.322131]  [<ffffffff81555380>] ? _raw_spin_unlock_irqrestore+0x20/0x30
[4123377.322142]  [<ffffffff81080336>] ? down_trylock+0x36/0x50
[4123377.322152]  [<ffffffff815596ae>] do_page_fault+0xe/0x10
[4123377.322161]  [<ffffffff81555b18>] page_fault+0x28/0x30
[4123377.322171]  [<ffffffffa02d09b5>] ?
__cachefiles_printk_object+0xe9/0x161 [cachefiles]
[4123377.322183]  [<ffffffffa02d09a0>] ?
__cachefiles_printk_object+0xd4/0x161 [cachefiles]
[4123377.322195]  [<ffffffffa02d0a89>]
cachefiles_printk_object+0x5c/0x5d3 [cachefiles]
[4123377.322207]  [<ffffffffa02ccaf2>]
cachefiles_walk_to_object+0xbd2/0xda0 [cachefiles]
[4123377.322218]  [<ffffffff810d51fe>] ? irq_get_irq_data+0xe/0x10
[4123377.322228]  [<ffffffff81010640>] ? xen_smp_send_reschedule+0x10/0x20
[4123377.322237]  [<ffffffff81087760>] ? resched_task+0x60/0x70
[4123377.322247]  [<ffffffffa02ca40c>]
cachefiles_lookup_object+0x6c/0x180 [cachefiles]
[4123377.322261]  [<ffffffffa01aa4a9>]
fscache_look_up_object+0xe9/0x370 [fscache]
[4123377.322274]  [<ffffffffa01aac47>]
fscache_object_work_func+0x107/0x4b0 [fscache]
[4123377.322285]  [<ffffffff810736ed>] process_one_work+0x17d/0x490
[4123377.322293]  [<ffffffff810747eb>] worker_thread+0x11b/0x370
[4123377.322303]  [<ffffffff810746d0>] ? manage_workers.isra.21+0x2e0/0x2e0
[4123377.322311]  [<ffffffff8107af88>] kthread+0xd8/0xe0
[4123377.322320]  [<ffffffff8107aeb0>] ? flush_kthread_worker+0xe0/0xe0
[4123377.322329]  [<ffffffff8155ddec>] ret_from_fork+0x7c/0xb0
[4123377.322337]  [<ffffffff8107aeb0>] ? flush_kthread_worker+0xe0/0xe0
[4123377.322344] Code: 48 89 e5 5d 48 8b 40 b8 48 c1 e8 02 83 e0 01 c3
66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 48 8b 87 70 03 00 00 55
48 89 e5 5d <48> 8b 40 c8 c3 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66
90 55
[4123377.322414] RIP  [<ffffffff8107afd1>] kthread_data+0x11/0x20
[4123377.322426]  RSP <ffff880ecd21f7b0>
[4123377.322431] CR2: ffffffffffffffc8
[4123377.322437] ---[ end trace c2ccf1289b7570b1 ]---
[4123377.322443] Fixing recursive fault but reboot is needed!

On Tue, Jul 9, 2013 at 6:33 AM, David Howells <dhowells@redhat.com> wrote:
> Milosz Tanski <milosz@adfin.com> wrote:
>
>> It looks like both the cifs and NFS code do not bother with any
>> locking around cifs_fscache_set_inode_cookie. Is there no concern over
>> multiple open() calls racing to create the cookie in those
>> filesystems?
>
> Yeah...  That's probably wrong.  AFS obviates the need for special locking by
> doing it in afs_iget().
>
> Hmmm...  I think I've just spotted what might be the cause of pages getting
> marked PG_fscache whilst belonging to the allocator.
>
>         void nfs_fscache_set_inode_cookie(struct inode *inode, struct file *filp)
>         {
>                 if (NFS_FSCACHE(inode)) {
>                         nfs_fscache_inode_lock(inode);
>                         if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
>                                 nfs_fscache_disable_inode_cookie(inode);
>                         else
>                                 nfs_fscache_enable_inode_cookie(inode);
>                         nfs_fscache_inode_unlock(inode);
>                 }
>         }
>
> can release the cookie whilst reads are in progress on it when an inode being
> read suddenly changes to an inode being written.  We need some sort of
> synchronisation on that there.
>
> David
