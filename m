From: Ronny Hegewald <ronny.hegewald@online.de>
Subject: Re: [PATCH] mark rbd requiring stable pages
Date: Fri, 23 Oct 2015 00:52:47 +0000
Message-ID: <201510230052.47499.ronny.hegewald@online.de>
References: <201510151850.48348.ronny.hegewald@online.de> <CAOi1vP_zx+Cz+tM07pZa_ciFhnJ8ddHX+dy35cqhOJ3BT4a8jw@mail.gmail.com> <56291B60.1040106@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61737 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932567AbbJWAvP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 20:51:15 -0400
In-Reply-To: <56291B60.1040106@cs.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>

On Thursday 22 October 2015, you wrote:
> It could be due to a recent change. Ronny, tell us about the workload
> and I will check iscsi.
 
I guess the best testcase is a kernel compilation in a make clean; make -j (> 
1); loop. The data-corruptions usually happen in the generated .cmd files, 
which breaks the build immediatelly and makes the corruption easy to spot.

Beside that i have seen data corruptions in other simple circumstances. 
Copying data from non-rbd to rbd device, from rbd to rbd device, scp data from 
another machine to the rbd. 

Also i have mounted the rbds on the same machines im running the OSD, which 
might be a contributing factor. 

Unfortunatly there seems to be nothing that increases the likelyhood of the 
corruption to happen. I tried all kinds of things with no success.

Another part of the corruption might have been the amount of free memory. 
Before i added the flag for stable patches i regularly had warnings like. 
Since the use of stable pages for rbd these warnings are gone too.


kernel: swapper/1: page allocation failure: order:0, mode:0x20
kernel:  0000000000000000 ffff88012fc83b68 ffffffff8143f171 0000000000000000
kernel:  0000000000000020 ffff88012fc83bf8 ffffffff81127fda ffff88012fff9838
kernel:  ffff880109bc7100 01ff88012fc83be8 ffffffff8164aa40 0000002000000000
kernel: Call Trace:
kernel:  <IRQ>  [<ffffffff8143f171>] dump_stack+0x48/0x5f
kernel:  [<ffffffff81127fda>] warn_alloc_failed+0xea/0x130
kernel:  [<ffffffff8112918a>] __alloc_pages_nodemask+0x69a/0x910
kernel:  [<ffffffffa04ad060>] ? br_handle_frame_finish+0x500/0x500 [bridge]
kernel:  [<ffffffff81162827>] alloc_pages_current+0xa7/0x170
kernel:  [<ffffffffa03dbc4c>] atl1c_alloc_rx_buffer+0x36c/0x430 [atl1c]
kernel:  [<ffffffffa03ddc52>] atl1c_clean+0x212/0x3b0 [atl1c]
kernel:  [<ffffffff813a6fcf>] net_rx_action+0x15f/0x320
kernel:  [<ffffffff81069383>] __do_softirq+0x123/0x2e0
kernel:  [<ffffffff81069626>] irq_exit+0x96/0xc0
kernel:  [<ffffffff81446575>] do_IRQ+0x65/0x110
kernel:  [<ffffffff81444532>] common_interrupt+0x72/0x72
kernel:  <EOI>  [<ffffffff814445a4>] ? retint_restore_args+0x13/0x13
kernel:  [<ffffffff8101f4a2>] ? mwait_idle+0x72/0xb0
kernel:  [<ffffffff8101f499>] ? mwait_idle+0x69/0xb0
kernel:  [<ffffffff8101f24f>] arch_cpu_idle+0xf/0x20
kernel:  [<ffffffff8109ebeb>] cpu_startup_entry+0x22b/0x3e0
kernel:  [<ffffffff81047996>] start_secondary+0x156/0x180
kernel: Mem-Info:
kernel: Node 0 DMA per-cpu:
kernel: CPU    0: hi:    0, btch:   1 usd:   0
kernel: CPU    1: hi:    0, btch:   1 usd:   0
kernel: CPU    2: hi:    0, btch:   1 usd:   0
kernel: CPU    3: hi:    0, btch:   1 usd:   0
kernel: Node 0 DMA32 per-cpu:
kernel: CPU    0: hi:  186, btch:  31 usd: 182
kernel: CPU    1: hi:  186, btch:  31 usd: 179
kernel: CPU    2: hi:  186, btch:  31 usd: 156
kernel: CPU    3: hi:  186, btch:  31 usd: 170
kernel: Node 0 Normal per-cpu:
kernel: CPU    0: hi:  186, btch:  31 usd: 138
kernel: CPU    1: hi:  186, btch:  31 usd: 130
kernel: CPU    2: hi:  186, btch:  31 usd:  73
kernel: CPU    3: hi:  186, btch:  31 usd: 122
kernel: active_anon:499711 inactive_anon:128139 isolated_anon:0
kernel:  active_file:132181 inactive_file:145093 isolated_file:22
kernel:  unevictable:4083 dirty:1526 writeback:15597 unstable:0
kernel:  free:5225 slab_reclaimable:23735 slab_unreclaimable:29775
kernel:  mapped:11742 shmem:18846 pagetables:3946 bounce:0
kernel:  free_cma:0
kernel: Node 0 DMA free:15284kB min:32kB low:40kB high:48kB active_anon:0kB 
inactive_anon:96kB active_file:232kB inactive_file:80kB unevictable:0kB 
isolated(anon):0kB isolated(file):0kB present:15992kB managed:15908kB 
mlocked:0kB dirty:0kB writeback:0kB mapped:12kB shmem:0kB 
slab_reclaimable:52kB slab_unreclaimable:80kB kernel_stack:16kB pagetables:0kB 
unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:88 
all_unreclaimable? no
kernel: lowmem_reserve[]: 0 3107 3818 3818
kernel: Node 0 DMA32 free:5064kB min:6420kB low:8024kB high:9628kB 
active_anon:1718524kB inactive_anon:365504kB active_file:418964kB 
inactive_file:469748kB unevictable:0kB isolated(anon):0kB isolated(file):88kB 
present:3257216kB managed:3183616kB mlocked:0kB dirty:5900kB writeback:48264kB 
mapped:39204kB shmem:54364kB slab_reclaimable:76256kB 
slab_unreclaimable:93456kB kernel_stack:6240kB pagetables:12280kB unstable:0kB 
bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? 
no
kernel: lowmem_reserve[]: 0 0 710 710
kernel: Node 0 Normal free:552kB min:1468kB low:1832kB high:2200kB 
active_anon:280320kB inactive_anon:146956kB active_file:109528kB 
inactive_file:110544kB unevictable:16332kB isolated(anon):0kB 
isolated(file):0kB present:786432kB managed:728012kB mlocked:0kB dirty:204kB 
writeback:14124kB mapped:7752kB shmem:21020kB slab_reclaimable:18632kB 
slab_unreclaimable:25564kB kernel_stack:2432kB pagetables:3504kB unstable:0kB 
bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:608 all_unreclaimable? 
no
kernel: lowmem_reserve[]: 0 0 0 0
kernel: Node 0 DMA: 4*4kB (UE) 4*8kB (UEM) 2*16kB (UE) 5*32kB (UEM) 3*64kB 
(UM) 2*128kB (UE) 1*256kB (E) 2*512kB (EM) 3*1024kB (UEM) 3*2048kB (UEM) 
1*4096kB (R) = 15280kB
kernel: Node 0 DMA32: 0*4kB 1*8kB (R) 0*16kB 0*32kB 1*64kB (R) 1*128kB (R) 
1*256kB (R) 3*512kB (R) 1*1024kB (R) 1*2048kB (R) 0*4096kB = 5064kB
kernel: Node 0 Normal: 0*4kB 1*8kB (R) 0*16kB 1*32kB (R) 1*64kB (R) 1*128kB 
(R) 1*256kB (R) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 488kB
kernel: 308023 total pagecache pages
kernel: 7793 pages in swap cache
kernel: Swap cache stats: add 320089, delete 312296, find 144121/183225
kernel: Free swap  = 1728464kB
kernel: Total swap = 2052092kB
kernel: 1014910 pages RAM
kernel: 0 pages HighMem/MovableOnly
kernel: 33026 pages reserved
 

