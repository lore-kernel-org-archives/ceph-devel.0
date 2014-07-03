From: Milosz Tanski <milosz@adfin.com>
Subject: fscache resulting in process kill in high
Date: Thu, 3 Jul 2014 18:13:05 -0400
Message-ID: <CANP1eJEaY1UPgd6Fcn=ZaU10mP=_FPp2y-kFi1GTUamY9DUK3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41429 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbaGCWNG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jul 2014 18:13:06 -0400
Received: by mail-wg0-f42.google.com with SMTP id z12so854500wgg.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jul 2014 15:13:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>

David I hope all is well with you.

I have recently been running into an OOM scenario with fscache and
readahead that results in the application getting a SIGBUS error
(mmaped file region). In some cases the page alloc failure does not
follow a SIGBUS, but the SIGBUS is always preceded by a page alloc
failure.

This happens when the machine is under a decent amount pressure (doing
lots of processing) but if you do some forensics on the machine a lot
of memory is uses in cache, not much in buffers, and most of it is
read only mappings that are non-locked. The swap is also entirely free
(if anything needs to be paged out).

For spending a good hour investigating this it like something isn't
quite right with the state of the page / mapping we leave it in after
failing to do a cachefiles page read.

Let me know what I can to figure this out / help to figure it out.

Best,
- Milosz


petabucket: page allocation failure: order:0, mode:0x11110
CPU: 5 PID: 18044 Comm: petabucket Not tainted 3.14.0-virtual #72
 0000000000000000 ffff8800234a5588 ffffffff81591b99 ffff8803bdd4fe50
 0000000000011110 ffff8800234a5618 ffffffff811371fe 0000000000000240
 00000000ffffffff ffff8800234a55b8 ffffffff81139bb6 ffff8803be218b38
Call Trace:
 [<ffffffff81591b99>] dump_stack+0x46/0x58
 [<ffffffff811371fe>] warn_alloc_failed+0xee/0x140
 [<ffffffff81139bb6>] ? drain_local_pages+0x16/0x20
 [<ffffffff8113b58a>] __alloc_pages_nodemask+0x93a/0xa20
 [<ffffffff81178e92>] alloc_pages_current+0xb2/0x170
 [<ffffffff81131bb7>] __page_cache_alloc+0xb7/0xd0
 [<ffffffffa030daea>] cachefiles_read_or_alloc_pages+0x56a/0xe20 [cachefiles]
 [<ffffffff810a766e>] ? wake_up_bit+0x2e/0x40
 [<ffffffffa01ba13a>] ? fscache_run_op.isra.3+0x5a/0x90 [fscache]
 [<ffffffffa01ba6dc>] ? fscache_submit_op+0x1dc/0x4e0 [fscache]
 [<ffffffffa01bd420>] __fscache_read_or_alloc_pages+0x2f0/0x460 [fscache]
 [<ffffffffa02c47a2>] ceph_readpages_from_fscache+0x102/0x1c0 [ceph]
 [<ffffffffa02a840b>] ceph_readpages+0x4b/0x710 [ceph]
 [<ffffffff81178e92>] ? alloc_pages_current+0xb2/0x170
 [<ffffffff81131bb7>] ? __page_cache_alloc+0xb7/0xd0
 [<ffffffff8113e0cf>] __do_page_cache_readahead+0x1bf/0x270
 [<ffffffff8113e481>] ra_submit+0x21/0x30
 [<ffffffff811337e7>] filemap_fault+0x297/0x4a0
 [<ffffffffa02a7ff8>] ceph_filemap_fault+0xd8/0x250 [ceph]
 [<ffffffff81598496>] ? _raw_spin_unlock_irqrestore+0x16/0x20
 [<ffffffff810a75a3>] ? __wake_up+0x53/0x70
 [<ffffffff81005f58>] ? pte_pfn_to_mfn+0x88/0xa0
 [<ffffffff81158aff>] __do_fault+0x6f/0x4e0
 [<ffffffff81008f2c>] ? pte_mfn_to_pfn+0x9c/0x120
 [<ffffffff8115c149>] handle_mm_fault+0x259/0xc60
 [<ffffffff81097507>] ? wake_up_process+0x27/0x50
 [<ffffffff810ae52d>] ? __rwsem_do_wake+0xdd/0x170
 [<ffffffff8159c57a>] __do_page_fault+0x19a/0x550
 [<ffffffff81003e13>] ? xen_write_msr_safe+0xa3/0xc0
 [<ffffffff810145ed>] ? __switch_to+0x16d/0x4d0
 [<ffffffff8108fe78>] ? finish_task_switch+0x58/0xd0
 [<ffffffff81595070>] ? __schedule+0x360/0x7c0
 [<ffffffff8159c95b>] do_page_fault+0x2b/0x40
 [<ffffffff81598f88>] page_fault+0x28/0x30
Mem-Info
Mem-Info:
Node 0 DMA per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
CPU    1: hi:    0, btch:   1 usd:   0
CPU    2: hi:    0, btch:   1 usd:   0
CPU    3: hi:    0, btch:   1 usd:   0
CPU    4: hi:    0, btch:   1 usd:   0
CPU    5: hi:    0, btch:   1 usd:   0
CPU    6: hi:    0, btch:   1 usd:   0
CPU    7: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: hi:  186, btch:  31 usd:   0
CPU    1: hi:  186, btch:  31 usd:   0
CPU    2: hi:  186, btch:  31 usd:   0
CPU    3: hi:  186, btch:  31 usd:   0
CPU    4: hi:  186, btch:  31 usd:   0
CPU    5: hi:  186, btch:  31 usd:   0
CPU    6: hi:  186, btch:  31 usd:   0
CPU    7: hi:  186, btch:  31 usd:   0
Node 0 Normal per-cpu:
CPU    0: hi:  186, btch:  31 usd:   0
CPU    1: hi:  186, btch:  31 usd:   0
CPU    2: hi:  186, btch:  31 usd:   2
CPU    3: hi:  186, btch:  31 usd:   0
CPU    4: hi:  186, btch:  31 usd:   0
CPU    5: hi:  186, btch:  31 usd:   0
CPU    6: hi:  186, btch:  31 usd:   0
CPU    7: hi:  186, btch:  31 usd:   0
active_anon:79355 inactive_anon:11986 isolated_anon:0
 active_file:208716 inactive_file:3435634 isolated_file:64
 unevictable:0 dirty:24 writeback:0 unstable:0
 free:18870 slab_reclaimable:72212 slab_unreclaimable:6804
 mapped:194402 shmem:55 pagetables:2223 bounce:0
 free_cma:0
Node 0 DMA free:15912kB min:16kB low:20kB high:24kB active_anon:0kB
inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB
isolated(anon):0kB isolated(file):0kB present:15996kB managed:15912kB
mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB
slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
pagetables:0kB unstable
ree_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 4066 15027 15027
Node 0 DMA32 free:48036kB min:4240kB low:5300kB high:6360kB
active_anon:74036kB inactive_anon:15008kB active_file:234268kB
inactive_file:3672984kB unevictable:0kB isolated(anon):0kB
isolated(file):256kB present:4177920kB managed:4167288kB mlocked:0kB
dirty:24kB writeback:0kB mapped:229196kB shmem:68kB
slab_reclaimable:102328kB slab_unreclaimable:8268kB kernel_stack:288kB
pagetables:2404kB unstable:0kB bounce:0kB free_cma:0kB
writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 10960 10960
Node 0 Normal free:11532kB min:11436kB low:14292kB high:17152kB
active_anon:243384kB inactive_anon:32936kB active_file:600596kB
inactive_file:10069168kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:11542528kB managed:11223440kB mlocked:0kB
dirty:72kB writeback:0kB mapped:548412kB shmem:152kB
slab_reclaimable:186520kB slab_unreclaimable:18948kB
kernel_stack:1136kB pagetables:6488kB unstable:0kB bounce:0kB
free_cma:0kB writeback_tmp:0kB pages_scanned:32 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 1*8kB (U) 0*16kB 1*32kB (U) 2*64kB (U) 1*128kB (U)
1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (R) 3*4096kB (M) = 15912kB
Node 0 DMA32: 8971*4kB (UEM) 159*8kB (UEM) 23*16kB (UR) 57*32kB (UER)
92*64kB (UE) 22*128kB (UR) 2*256kB (UR) 0*512kB 0*1024kB 0*2048kB
0*4096kB = 48564kB
Node 0 Normal: 2587*4kB (M) 0*8kB 3*16kB (R) 12*32kB (R) 3*64kB (R)
0*128kB 1*256kB (R) 1*512kB (R) 0*1024kB 0*2048kB 0*4096kB = 11740kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
3532636 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 8388604kB
Total swap = 8388604kB
3934111 pages RAM
0 pages HighMem/MovableOnly
79772 pages reserved
0 pages hwpoisoned
init: petabucket main process (18043) killed by BUS signal
init: petabucket main process ended, respawning

-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
