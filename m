From: Martin Mailand <martin@tuxadero.com>
Subject: Re: ceph kernel bug
Date: Sun, 11 Sep 2011 01:46:11 +0200
Message-ID: <4E6BF6C3.5010202@tuxadero.com>
References: <4E6BD2B4.7050709@tuxadero.com> <Pine.LNX.4.64.1109101546370.19147@cobra.newdream.net>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:36648 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab1IJXqU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Sep 2011 19:46:20 -0400
In-Reply-To: <Pine.LNX.4.64.1109101546370.19147@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
no it did not fix it. Here the new trace.

Regards,
  martin

[  182.721180] libceph: osd2 192.168.42.114:6800 socket closed
[  182.732642] libceph: osd2 192.168.42.114:6800 connection failed
[  183.040233] libceph: osd2 192.168.42.114:6800 connection failed
[  184.040204] libceph: osd2 192.168.42.114:6800 connection failed
[  186.040244] libceph: osd2 192.168.42.114:6800 connection failed
[  190.060233] libceph: osd2 192.168.42.114:6800 connection failed
[  198.060214] libceph: osd2 192.168.42.114:6800 connection failed
[  213.964994] ------------[ cut here ]------------
[  213.974288] kernel BUG at net/ceph/messenger.c:2193!
[  213.974470] invalid opcode: 0000 [#1] SMP
[  213.974470] CPU 0
[  213.974470] Modules linked in: rbd libceph libcrc32c ip6table_filter 
ip6_tables iptable_filter ip_tables x_tables nv_tco bridge stp kvm_amd 
kvm radeon lp psmouse shpchp parport i2c_nforce2 amd64_edac_mod ttm 
drm_kms_helper drm edac_core i2c_algo_bit edac_mce_amd serio_raw k10temp 
ses enclosure aacraid forcedeth
[  213.974470]
[  213.974470] Pid: 10, comm: kworker/0:1 Not tainted 3.1.0-rc5-custom 
#3 Supermicro H8DM8-2/H8DM8-2
[  213.974470] RIP: 0010:[<ffffffffa02cf3f1>]  [<ffffffffa02cf3f1>] 
ceph_con_send+0x111/0x120 [libceph]
[  213.974470] RSP: 0018:ffff880405cddbd0  EFLAGS: 00010283
[  213.974470] RAX: ffff880403e93c78 RBX: ffff880803f97030 RCX: 
ffff8808034d2e50
[  213.974470] RDX: ffff880405cddfd8 RSI: ffff880403e93c00 RDI: 
ffff880803f971a8
[  213.974470] RBP: ffff880405cddbf0 R08: ffff88040fc0de40 R09: 
000000000000fffb
[  213.974470] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff880803f971a8
[  213.974470] R13: ffff880403e93c00 R14: ffff8808034d2e60 R15: 
ffff8808034d2e50
[  213.974470] FS:  00007f5909978720(0000) GS:ffff88040fc00000(0000) 
knlGS:0000000000000000
[  213.974470] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  213.974470] CR2: ffffffffff600400 CR3: 0000000404e6f000 CR4: 
00000000000006f0
[  213.974470] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  213.974470] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[  213.974470] Process kworker/0:1 (pid: 10, threadinfo 
ffff880405cdc000, task ffff880405cb5bc0)
[  213.974470] Stack:
[  213.974470]  ffff880405cddbf0 ffff880403e0ac00 ffff8808034d2e30 
ffff8808034d2da8
[  213.974470]  ffff880405cddc40 ffffffffa02d490d ffff8808034d2c80 
ffff8808034d2e00
[  213.974470]  ffff880405cddc40 ffff8804041d1c91 ffff8808034d2da8 
0000000000000000
[  213.974470] Call Trace:
[  213.974470]  [<ffffffffa02d490d>] send_queued+0xed/0x130 [libceph]
[  213.974470]  [<ffffffffa02d6d91>] ceph_osdc_handle_map+0x261/0x3b0 
[libceph]
[  213.974470]  [<ffffffffa02d331f>] dispatch+0x10f/0x580 [libceph]
[  213.974470]  [<ffffffffa02d154f>] con_work+0x214f/0x21d0 [libceph]
[  213.974470]  [<ffffffffa02cf400>] ? ceph_con_send+0x120/0x120 [libceph]
[  213.974470]  [<ffffffff8108110d>] process_one_work+0x11d/0x430
[  213.974470]  [<ffffffff81081c69>] worker_thread+0x169/0x360
[  213.974470]  [<ffffffff81081b00>] ? manage_workers.clone.21+0x240/0x240
[  213.974470]  [<ffffffff81086496>] kthread+0x96/0xa0
[  213.974470]  [<ffffffff815e5bb4>] kernel_thread_helper+0x4/0x10
[  213.974470]  [<ffffffff81086400>] ? flush_kthread_worker+0xb0/0xb0
[  213.974470]  [<ffffffff815e5bb0>] ? gs_change+0x13/0x13
[  213.974470] Code: 65 f0 4c 8b 6d f8 c9 c3 66 90 48 8d be 88 00 00 00 
48 c7 c6 70 18 2d a0 e8 dd 2c 01 e1 48 8b 5d e8 4c 8b 65 f0 4c 8b 6d f8 
c9 c3 <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57
[  213.974470] RIP  [<ffffffffa02cf3f1>] ceph_con_send+0x111/0x120 [libceph]
[  213.974470]  RSP <ffff880405cddbd0>
[  214.640753] ---[ end trace 837698aee31a73fc ]---
[  214.653687] BUG: unable to handle kernel paging request at 
fffffffffffffff8
[  214.663571] IP: [<ffffffff810868f0>] kthread_data+0x10/0x20
[  214.663571] PGD 1a07067 PUD 1a08067 PMD 0
[  214.663571] Oops: 0000 [#2] SMP
[  214.663571] CPU 0
[  214.663571] Modules linked in: rbd libceph libcrc32c ip6table_filter 
ip6_tables iptable_filter ip_tables x_tables nv_tco bridge stp kvm_amd 
kvm radeon lp psmouse shpchp parport i2c_nforce2 amd64_edac_mod ttm 
drm_kms_helper drm edac_core i2c_algo_bit edac_mce_amd serio_raw k10temp 
ses enclosure aacraid forcedeth
[  214.663571]
[  214.663571] Pid: 10, comm: kworker/0:1 Tainted: G      D 
3.1.0-rc5-custom #3 Supermicro H8DM8-2/H8DM8-2
[  214.663571] RIP: 0010:[<ffffffff810868f0>]  [<ffffffff810868f0>] 
kthread_data+0x10/0x20
[  214.663571] RSP: 0018:ffff880405cdd878  EFLAGS: 00010096
[  214.663571] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[  214.663571] RDX: ffff880405cb5bc0 RSI: 0000000000000000 RDI: 
ffff880405cb5bc0
[  214.663571] RBP: ffff880405cdd878 R08: 0000000000989680 R09: 
0000000000000000
[  214.663571] R10: 0000000000000400 R11: 0000000000000006 R12: 
ffff880405cb5f88
[  214.663571] R13: 0000000000000000 R14: 0000000000000000 R15: 
ffff880405cb5e90
[  214.663571] FS:  00007f5909978720(0000) GS:ffff88040fc00000(0000) 
knlGS:0000000000000000
[  214.663571] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  214.663571] CR2: fffffffffffffff8 CR3: 0000000404e6f000 CR4: 
00000000000006f0
[  214.663571] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  214.663571] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[  214.663571] Process kworker/0:1 (pid: 10, threadinfo 
ffff880405cdc000, task ffff880405cb5bc0)
[  214.663571] Stack:
[  214.663571]  ffff880405cdd898 ffffffff81082345 ffff880405cdd898 
ffff88040fc13080
[  214.663571]  ffff880405cdd928 ffffffff815d9092 ffff8804050938b8 
ffff880405cb5bc0
[  214.663571]  ffff880405cdd8e8 ffff880405cddfd8 ffff880405cdc000 
ffff880405cddfd8
[  214.663571] Call Trace:
[  214.663571]  [<ffffffff81082345>] wq_worker_sleeping+0x15/0xa0
[  214.663571]  [<ffffffff815d9092>] __schedule+0x5c2/0x8b0
[  214.663571]  [<ffffffff812caf96>] ? put_io_context+0x46/0x70
[  214.663571]  [<ffffffff8105b72f>] schedule+0x3f/0x60
[  214.663571]  [<ffffffff81068223>] do_exit+0x5e3/0x8a0
[  214.663571]  [<ffffffff815dcc4f>] oops_end+0xaf/0xf0
[  214.663571]  [<ffffffff8101689b>] die+0x5b/0x90
[  214.663571]  [<ffffffff815dc354>] do_trap+0xc4/0x170
[  214.663571]  [<ffffffff81013f25>] do_invalid_op+0x95/0xb0
[  214.663571]  [<ffffffffa02cf3f1>] ? ceph_con_send+0x111/0x120 [libceph]
[  214.663571]  [<ffffffff812e9759>] ? vsnprintf+0x479/0x620
[  214.663571]  [<ffffffff8103be49>] ? default_spin_lock_flags+0x9/0x10
[  214.663571]  [<ffffffff815e5a2b>] invalid_op+0x1b/0x20
[  214.663571]  [<ffffffffa02cf3f1>] ? ceph_con_send+0x111/0x120 [libceph]
[  214.663571]  [<ffffffffa02d490d>] send_queued+0xed/0x130 [libceph]
[  214.663571]  [<ffffffffa02d6d91>] ceph_osdc_handle_map+0x261/0x3b0 
[libceph]
[  214.663571]  [<ffffffffa02d331f>] dispatch+0x10f/0x580 [libceph]
[  214.663571]  [<ffffffffa02d154f>] con_work+0x214f/0x21d0 [libceph]
[  214.663571]  [<ffffffffa02cf400>] ? ceph_con_send+0x120/0x120 [libceph]
[  214.663571]  [<ffffffff8108110d>] process_one_work+0x11d/0x430
[  214.663571]  [<ffffffff81081c69>] worker_thread+0x169/0x360
[  214.663571]  [<ffffffff81081b00>] ? manage_workers.clone.21+0x240/0x240
[  214.663571]  [<ffffffff81086496>] kthread+0x96/0xa0
[  214.663571]  [<ffffffff815e5bb4>] kernel_thread_helper+0x4/0x10
[  214.663571]  [<ffffffff81086400>] ? flush_kthread_worker+0xb0/0xb0
[  214.663571]  [<ffffffff815e5bb0>] ? gs_change+0x13/0x13
[  214.663571] Code: 5e 41 5f c9 c3 be 3e 01 00 00 48 c7 c7 5b 3a 7d 81 
e8 85 d3 fd ff e9 84 fe ff ff 55 48 89 e5 66 66 66 66 90 48 8b 87 70 03 
00 00
[  214.663571]  8b 40 f8 c9 c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 66
[  214.663571] RIP  [<ffffffff810868f0>] kthread_data+0x10/0x20
[  214.663571]  RSP <ffff880405cdd878>
[  214.663571] CR2: fffffffffffffff8
[  214.663571] ---[ end trace 837698aee31a73fd ]---
[  214.663571] Fixing recursive fault but reboot is needed!



Sage Weil schrieb:
> Hi Martin,
> 
> Is this reproducible?  If so, does the patch below fix it?
> 
> Thanks!
> sage
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 5634216..dcd3475 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -31,6 +31,7 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
>                                         struct ceph_osd_request *req);
>  static int __send_request(struct ceph_osd_client *osdc,
>                           struct ceph_osd_request *req);
> +static void __cancel_request(struct ceph_osd_request *req);
>  
>  static int op_needs_trail(int op)
>  {
> @@ -571,6 +572,7 @@ static void __kick_osd_requests(struct ceph_osd_client *osdc,
>                 return;
>  
>         list_for_each_entry(req, &osd->o_requests, r_osd_item) {
> +               __cancel_request(req);
>                 list_move(&req->r_req_lru_item, &osdc->req_unsent);
>                 dout("requeued %p tid %llu osd%d\n", req, req->r_tid,
>                      osd->o_osd);
> 
> 
> 
