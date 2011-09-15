From: Martin Mailand <martin@tuxadero.com>
Subject: Re: ceph kernel bug
Date: Thu, 15 Sep 2011 21:41:10 +0200
Message-ID: <4E7254D6.9020509@tuxadero.com>
References: <4E6BD2B4.7050709@tuxadero.com> <Pine.LNX.4.64.1109101546370.19147@cobra.newdream.net> <4E6BF6C3.5010202@tuxadero.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:35007 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934532Ab1IOTlV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2011 15:41:21 -0400
In-Reply-To: <4E6BF6C3.5010202@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Hi Sage,
I am still hitting this in -rc6. It happeneds every time I stop an OSD.
Do you need more information to reproduce it?

Best Regards,
  martin

[103159.164630] libceph: osd0 192.168.42.113:6800 socket closed
[103169.153484] ------------[ cut here ]------------
[103169.162935] kernel BUG at net/ceph/messenger.c:2193!
[103169.163332] invalid opcode: 0000 [#1] SMP
[103169.163332] CPU 0
[103169.163332] Modules linked in: btrfs zlib_deflate rbd libceph 
libcrc32c ip6table_filter ip6_tables iptable_filter ip_tables x_tables 
kvm_amd kvm bridge nv_tco stp radeon ttm drm_kms_helper drm lp parport 
i2c_algo_bit amd64_edac_mod i2c_nforce2 edac_core edac_mce_amd k10temp 
shpchp psmouse serio_raw ses enclosure aacraid forcedeth
[103169.163332]
[103169.163332] Pid: 4405, comm: kworker/0:1 Not tainted 3.1.0-rc6 #1 
Supermicro H8DM8-2/H8DM8-2
[103169.163332] RIP: 0010:[<ffffffffa02b73f1>]  [<ffffffffa02b73f1>] 
ceph_con_send+0x111/0x120 [libceph]
[103169.163332] RSP: 0018:ffff88031c5b3bd0  EFLAGS: 00010202
[103169.163332] RAX: ffff88040502c678 RBX: ffff88040452b030 RCX: 
ffff88031c8a9e50
[103169.163332] RDX: ffff88031c5b3fd8 RSI: ffff88040502c600 RDI: 
ffff88040452b1a8
[103169.163332] RBP: ffff88031c5b3bf0 R08: ffff88040fc0de40 R09: 
0000000000000002
[103169.163332] R10: 0000000000000002 R11: 0000000000000072 R12: 
ffff88040452b1a8
[103169.163332] R13: ffff88040502c600 R14: ffff88031c8a9e60 R15: 
ffff88031c8a9e50
[103169.163332] FS:  00007f6d43dd2700(0000) GS:ffff88040fc00000(0000) 
knlGS:0000000000000000
[103169.163332] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[103169.163332] CR2: ffffffffff600400 CR3: 0000000403fb1000 CR4: 
00000000000006f0
[103169.163332] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[103169.163332] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[103169.163332] Process kworker/0:1 (pid: 4405, threadinfo 
ffff88031c5b2000, task ffff880405cd5bc0)
[103169.163332] Stack:
[103169.163332]  ffff88031c5b3bf0 ffff880404632a00 ffff88031c8a9e30 
ffff88031c8a9da8
[103169.163332]  ffff88031c5b3c40 ffffffffa02bc8ad ffff88031c8a9c80 
ffff88031c8a9e00
[103169.163332]  ffff88031c5b3c40 ffff8804045b7151 ffff88031c8a9da8 
0000000000000000
[103169.163332] Call Trace:
[103169.163332]  [<ffffffffa02bc8ad>] send_queued+0xed/0x130 [libceph]
[103169.163332]  [<ffffffffa02bed81>] ceph_osdc_handle_map+0x261/0x3b0 
[libceph]
[103169.163332]  [<ffffffffa02bb31f>] dispatch+0x10f/0x580 [libceph]
[103169.163332]  [<ffffffffa02b954f>] con_work+0x214f/0x21d0 [libceph]
[103169.163332]  [<ffffffffa02b7400>] ? ceph_con_send+0x120/0x120 [libceph]
[103169.163332]  [<ffffffff8108110d>] process_one_work+0x11d/0x430
[103169.163332]  [<ffffffff81081c69>] worker_thread+0x169/0x360
[103169.163332]  [<ffffffff81081b00>] ? manage_workers.clone.21+0x240/0x240
[103169.163332]  [<ffffffff81086496>] kthread+0x96/0xa0
[103169.163332]  [<ffffffff815e5c34>] kernel_thread_helper+0x4/0x10
[103169.163332]  [<ffffffff81086400>] ? flush_kthread_worker+0xb0/0xb0
[103169.163332]  [<ffffffff815e5c30>] ? gs_change+0x13/0x13
[103169.163332] Code: 65 f0 4c 8b 6d f8 c9 c3 66 90 48 8d be 88 00 00 00 
48 c7 c6 70 98 2b a0 e8 1d ad 02 e1 48 8b 5d e8 4c 8b 65 f0 4c 8b 6d f8 
c9 c3 <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57
[103169.163332] RIP  [<ffffffffa02b73f1>] ceph_con_send+0x111/0x120 
[libceph]
[103169.163332]  RSP <ffff88031c5b3bd0>
[103169.805672] ---[ end trace 49d197af1dff5a93 ]---
[103169.818910] BUG: unable to handle kernel paging request at 
fffffffffffffff8
[103169.828781] IP: [<ffffffff810868f0>] kthread_data+0x10/0x20
[103169.828781] PGD 1a07067 PUD 1a08067 PMD 0
[103169.828781] Oops: 0000 [#2] SMP
[103169.828781] CPU 0
[103169.828781] Modules linked in: btrfs zlib_deflate rbd libceph 
libcrc32c ip6table_filter ip6_tables iptable_filter ip_tables x_tables 
kvm_amd kvm bridge nv_tco stp radeon ttm drm_kms_helper drm lp parport 
i2c_algo_bit amd64_edac_mod i2c_nforce2 edac_core edac_mce_amd k10temp 
shpchp psmouse serio_raw ses enclosure aacraid forcedeth
[103169.828781]
[103169.828781] Pid: 4405, comm: kworker/0:1 Tainted: G      D 
3.1.0-rc6 #1 Supermicro H8DM8-2/H8DM8-2
[103169.828781] RIP: 0010:[<ffffffff810868f0>]  [<ffffffff810868f0>] 
kthread_data+0x10/0x20
[103169.828781] RSP: 0018:ffff88031c5b3878  EFLAGS: 00010096
[103169.828781] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[103169.828781] RDX: ffff880405cd5bc0 RSI: 0000000000000000 RDI: 
ffff880405cd5bc0
[103169.828781] RBP: ffff88031c5b3878 R08: 0000000000989680 R09: 
0000000000000000
[103169.828781] R10: 0000000000000400 R11: 0000000000000005 R12: 
ffff880405cd5f88
[103169.828781] R13: 0000000000000000 R14: 0000000000000000 R15: 
ffff880405cd5e90
[103169.828781] FS:  00007f6d43dd2700(0000) GS:ffff88040fc00000(0000) 
knlGS:0000000000000000
[103169.828781] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[103169.828781] CR2: fffffffffffffff8 CR3: 0000000403fb1000 CR4: 
00000000000006f0
[103169.828781] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[103169.828781] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[103169.828781] Process kworker/0:1 (pid: 4405, threadinfo 
ffff88031c5b2000, task ffff880405cd5bc0)
[103169.828781] Stack:
[103169.828781]  ffff88031c5b3898 ffffffff81082345 ffff88031c5b3898 
ffff88040fc13080
[103169.828781]  ffff88031c5b3928 ffffffff815d9142 ffff88031c5b38c8 
ffff880405cd5bc0
[103169.828781]  ffff880405cd5bc0 ffff88031c5b3fd8 ffff88031c5b2000 
ffff88031c5b3fd8
[103169.828781] Call Trace:
[103169.828781]  [<ffffffff81082345>] wq_worker_sleeping+0x15/0xa0
[103169.828781]  [<ffffffff815d9142>] __schedule+0x5c2/0x8b0
[103169.828781]  [<ffffffff8105b72f>] schedule+0x3f/0x60
[103169.828781]  [<ffffffff81068223>] do_exit+0x5e3/0x8a0
[103169.828781]  [<ffffffff815dcccf>] oops_end+0xaf/0xf0
[103169.828781]  [<ffffffff8101689b>] die+0x5b/0x90
[103169.828781]  [<ffffffff815dc3d4>] do_trap+0xc4/0x170
[103169.828781]  [<ffffffff81013f25>] do_invalid_op+0x95/0xb0
[103169.828781]  [<ffffffffa02b73f1>] ? ceph_con_send+0x111/0x120 [libceph]
[103169.828781]  [<ffffffff8103be49>] ? default_spin_lock_flags+0x9/0x10
[103169.828781]  [<ffffffff815e5aab>] invalid_op+0x1b/0x20
[103169.828781]  [<ffffffffa02b73f1>] ? ceph_con_send+0x111/0x120 [libceph]
[103169.828781]  [<ffffffffa02bc8ad>] send_queued+0xed/0x130 [libceph]
[103169.828781]  [<ffffffffa02bed81>] ceph_osdc_handle_map+0x261/0x3b0 
[libceph]
[103169.828781]  [<ffffffffa02bb31f>] dispatch+0x10f/0x580 [libceph]
[103169.828781]  [<ffffffffa02b954f>] con_work+0x214f/0x21d0 [libceph]
[103169.828781]  [<ffffffffa02b7400>] ? ceph_con_send+0x120/0x120 [libceph]
[103169.828781]  [<ffffffff8108110d>] process_one_work+0x11d/0x430
[103169.828781]  [<ffffffff81081c69>] worker_thread+0x169/0x360
[103169.828781]  [<ffffffff81081b00>] ? manage_workers.clone.21+0x240/0x240
[103169.828781]  [<ffffffff81086496>] kthread+0x96/0xa0
[103169.828781]  [<ffffffff815e5c34>] kernel_thread_helper+0x4/0x10
[103169.828781]  [<ffffffff81086400>] ? flush_kthread_worker+0xb0/0xb0
[103169.828781]  [<ffffffff815e5c30>] ? gs_change+0x13/0x13
[103169.828781] Code: 5e 41 5f c9 c3 be 3e 01 00 00 48 c7 c7 54 3a 7d 81 
e8 85 d3 fd ff e9 84 fe ff ff 55 48 89 e5 66 66 66 66 90 48 8b 87 70 03 
00 00
[103169.828781]  8b 40 f8 c9 c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 
e5 66
[103169.828781] RIP  [<ffffffff810868f0>] kthread_data+0x10/0x20
[103169.828781]  RSP <ffff88031c5b3878>
[103169.828781] CR2: fffffffffffffff8
[103169.828781] ---[ end trace 49d197af1dff5a94 ]---
[103169.828781] Fixing recursive fault but reboot is needed!

> Sage Weil schrieb:
>> Hi Martin,
>>
>> Is this reproducible?  If so, does the patch below fix it?
>>
>> Thanks!
>> sage
>>
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index 5634216..dcd3475 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -31,6 +31,7 @@ static void __unregister_linger_request(struct 
>> ceph_osd_client *osdc,
>>                                         struct ceph_osd_request *req);
>>  static int __send_request(struct ceph_osd_client *osdc,
>>                           struct ceph_osd_request *req);
>> +static void __cancel_request(struct ceph_osd_request *req);
>>  
>>  static int op_needs_trail(int op)
>>  {
>> @@ -571,6 +572,7 @@ static void __kick_osd_requests(struct 
>> ceph_osd_client *osdc,
>>                 return;
>>  
>>         list_for_each_entry(req, &osd->o_requests, r_osd_item) {
>> +               __cancel_request(req);
>>                 list_move(&req->r_req_lru_item, &osdc->req_unsent);
>>                 dout("requeued %p tid %llu osd%d\n", req, req->r_tid,
>>                      osd->o_osd);
>>
>>
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
