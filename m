Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288F2E0938
	for <ceph-devel@vger.kernel.org>; Fri, 20 Feb 2026 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771605265; cv=none; b=tTNVgmKU9o2sNGCVjA2tNLpoonlTL9ouU2H4TITYHzopkAvOMGFtoxMaDppDE6ynXjvMyd4Sd86vjGH1PLvvAXMZtARbBEyJ5F0GyeJFbtOBA1n+VTin6FfMzgs2xwgiBc8UCcGimB9WXh0kM0+a/13OqgdEftld99SOPe4gKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771605265; c=relaxed/simple;
	bh=j5UIjmTlNXxHMJcF5LfZFyuZYiCHqZd2uSg5kNHFe5A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GDjBMvX1wJPtbAmYsRw1CKIjBkymijWMkWOycoJiGjsrDDpLtn3kk6MqC33GqyC9H7GYmPxviO0dlEzNAITB0Np85ctxOItJ1WqNCmoYuXTI6gWYWaGWbmdTtWsRki0Wv+9d4HavdE9qAZnuIqQRs3Yn4OQD9eFiJbbn9OHrUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=HuPzM9ld; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="HuPzM9ld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1771605148; h=message-id
 : date : mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding : from;
 bh=j5UIjmTlNXxHMJcF5LfZFyuZYiCHqZd2uSg5kNHFe5A=;
 b=HuPzM9ld7/IRgbsQhlmcWjmi4+rlSDoj1J6+OTVCfr5RSkUciSEZO+/FQaI1tILdb2Chd
 WEZUUp4esFm7kb4M4tBXITCUP8wSE2bY1geX1w0WwNceuEPhI0mUotMYUe48R7Uvh89449I
 J+DzkSl43Hiti3Pqcfc8zPDHWG+ATlrAdCVKSBmzTrb7qvdRbnFaPGE5QcrYMevoPLF7Z8Z
 7MOU4eLoGpH2NdboBbTW7rr7KrMwSWtEAC7jMGjUrhQ2udL40GQqimoWBRVn7bvcOaHrpLR
 g3h7NE8JF0unQ+yq7NVa/3JHKw/8qm7L/2p9swiepfIl2pTRSL79CtN4Tutg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 752E45FB57;
	Fri, 20 Feb 2026 17:32:28 +0100 (CET)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 0DB6A5FC9C;
	Fri, 20 Feb 2026 17:32:28 +0100 (CET)
Message-ID: <775f9e1d-ab5c-4965-a8fc-bebebf3d1b0a@tu-ilmenau.de>
Date: Fri, 20 Feb 2026 17:32:27 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ilya Dryomov <idryomov@gmail.com>, amarkuze@redhat.com, slava@dubeyko.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [bug report] libceph: slab-out-of-bounds memory access in
 messenger_v2
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I encountered a bug in the kernel Ceph client (specifically in the 
messenger_v2 implementation). I have two slightly different stack traces 
that point to the same issue: [1],[2].

The bug realizes as an out-of-bounds memory access in the function 
process_message_header() in net/ceph/messenger_v2.c:2843.

 From my perspective, the following happens:
Prerequisite: Messenger_v2 connection that isn't in ms_mode secure.
The bug can be triggered in states CEPH_CON_S_V2_HELLO (stack trace [1]) 
and CEPH_CON_S_V2_AUTH (stack trace [2]), by a message with tag 
FRAME_TAG_MESSAGE and a small value for ctrl_len. This message leads to 
the following behavior when received from ceph_con_v2_try_read() 
(net/ceph/messenger_v2.c:3128):
- First iteration in ceph_con_v2_try_read(): populate_in_iter() -> 
handle_preamble() -> prepare_read_control(). In line 1780, ctrl_len is 
read from the incoming message and in lines 1787/1788 a buffer is 
allocated with a size calculated using crtl_len. In line 1795, 
add_in_kvec() is called using a part of this buffer.
- Second iteration in ceph_con_v2_try_read(): populate_in_iter() -> 
handle_control() -> __handle_control().
   - Case CEPH_CON_S_V2_HELLO: __handle_control() is called with the 
previously added kvec (line 2991).
   - Case CEPH_CON_S_V2_AUTH: A new buffer with length ctrl_len is 
allocated and __handle_control() is called with this one (line 2988).
   In __handle_control(), process_message_header() is called (line 
2901). In this function, the pointer to the allocated buffer is 
reinterpreted as a ceph_msg_header2*, which is possibly larger than the 
allocated buffer and therefore causes the overflow.

The bug can be triggered deterministically over the network and could 
therefore potentially be exploited.

Note: I also created a corresponding issue at 
https://tracker.ceph.com/issues/75054.

Best regards,
Raphael


[1]
BUG: KASAN: slab-out-of-bounds in __handle_control+0x200c/0x51d0 [libceph]
[  368.183535] Read of size 8 at addr ffff8881015a6aa0 by task 
kworker/22:1/293

[  368.185184] CPU: 22 UID: 0 PID: 293 Comm: kworker/22:1 Not tainted 
6.19.2 #1 PREEMPT(voluntary)
[  368.185188] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  368.185189] Workqueue: ceph-msgr ceph_con_workfn [libceph]
[  368.185215] Call Trace:
[  368.185217]  <TASK>
[  368.185218]  dump_stack_lvl+0x76/0xa0
[  368.185222]  print_report+0xd1/0x620
[  368.185226]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  368.185229]  ? kasan_complete_mode_report_info+0x26/0x210
[  368.185231]  kasan_report+0xe7/0x130
[  368.185233]  ? __handle_control+0x200c/0x51d0 [libceph]
[  368.185257]  ? __handle_control+0x200c/0x51d0 [libceph]
[  368.185280]  __asan_report_load_n_noabort+0xf/0x20
[  368.185282]  __handle_control+0x200c/0x51d0 [libceph]
[  368.185304]  ? inet_recvmsg+0xfc/0x4e0
[  368.185308]  ? __pfx___handle_control+0x10/0x10 [libceph]
[  368.185330]  ? apparmor_socket_recvmsg+0x6b/0xa0
[  368.185334]  ? __pfx_inet_recvmsg+0x10/0x10
[  368.185336]  ? do_recvmsg+0x17c/0x250 [libceph]
[  368.185359]  ? __pfx_do_recvmsg+0x10/0x10 [libceph]
[  368.185382]  ? __kasan_kmalloc+0xc3/0xd0
[  368.185385]  ceph_con_v2_try_read+0x445/0x6c80 [libceph]
[  368.185409]  ? __pfx_ceph_con_v2_try_read+0x10/0x10 [libceph]
[  368.185431]  ? save_fpregs_to_fpstate+0xb0/0x230
[  368.185434]  ? raw_spin_rq_unlock+0x17/0xa0
[  368.185438]  ? finish_task_switch.isra.0+0x13b/0x760
[  368.185440]  ? __switch_to+0x385/0xda0
[  368.185443]  ? __kasan_check_write+0x14/0x30
[  368.185445]  ? mutex_lock+0x8d/0xe0
[  368.185448]  ? __pfx_mutex_lock+0x10/0x10
[  368.185451]  ceph_con_workfn+0x248/0x10c0 [libceph]
[  368.185473]  process_one_work+0x629/0xf80
[  368.185477]  ? __kasan_check_write+0x14/0x30
[  368.185479]  worker_thread+0x87f/0x1570
[  368.185481]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  368.185483]  ? __pfx_try_to_wake_up+0x10/0x10
[  368.185486]  ? kasan_print_address_stack_frame+0x1f7/0x280
[  368.185488]  ? __pfx_worker_thread+0x10/0x10
[  368.185491]  kthread+0x396/0x830
[  368.185493]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  368.185495]  ? __pfx_kthread+0x10/0x10
[  368.185497]  ? __kasan_check_write+0x14/0x30
[  368.185499]  ? recalc_sigpending+0x180/0x210
[  368.185502]  ? __pfx_kthread+0x10/0x10
[  368.185504]  ret_from_fork+0x3f7/0x610
[  368.185507]  ? __pfx_ret_from_fork+0x10/0x10
[  368.185509]  ? __switch_to+0x385/0xda0
[  368.185511]  ? __pfx_kthread+0x10/0x10
[  368.185513]  ret_from_fork_asm+0x1a/0x30
[  368.185517]  </TASK>

[  368.230973] Allocated by task 293 on cpu 22 at 368.180643s:
[  368.232245]  kasan_save_stack+0x39/0x70
[  368.232250]  kasan_save_track+0x18/0x70
[  368.232252]  kasan_save_alloc_info+0x37/0x60
[  368.232255]  __kasan_kmalloc+0xc3/0xd0
[  368.232257]  __kvmalloc_node_noprof+0x274/0x8d0
[  368.232260]  alloc_conn_buf+0x6c/0x1a0 [libceph]
[  368.232285]  ceph_con_v2_try_read+0x41b5/0x6c80 [libceph]
[  368.232308]  ceph_con_workfn+0x248/0x10c0 [libceph]
[  368.232332]  process_one_work+0x629/0xf80
[  368.232334]  worker_thread+0x87f/0x1570
[  368.232337]  kthread+0x396/0x830
[  368.232339]  ret_from_fork+0x3f7/0x610
[  368.232342]  ret_from_fork_asm+0x1a/0x30

[  368.232874] The buggy address belongs to the object at ffff8881015a6a80
                 which belongs to the cache kmalloc-rnd-03-64 of size 64
[  368.235730] The buggy address is located 32 bytes inside of
                 allocated 38-byte region [ffff8881015a6a80, 
ffff8881015a6aa6)

[  368.239115] The buggy address belongs to the physical page:
[  368.240404] page: refcount:0 mapcount:0 mapping:0000000000000000 
index:0x0 pfn:0x1015a6
[  368.240408] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  368.240412] page_type: f5(slab)
[  368.240415] raw: 0017ffffc0000000 ffff88810004b980 dead000000000122 
0000000000000000
[  368.240418] raw: 0000000000000000 0000000080200020 00000000f5000000 
0000000000000000
[  368.240419] page dumped because: kasan: bad access detected

[  368.241053] Memory state around the buggy address:
[  368.242303]  ffff8881015a6980: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  368.243891]  ffff8881015a6a00: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  368.245482] >ffff8881015a6a80: 00 00 00 00 06 fc fc fc fc fc fc fc fc 
fc fc fc
[  368.247056]                                ^
[  368.248114]  ffff8881015a6b00: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  368.249706]  ffff8881015a6b80: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  368.251297] 
==================================================================


[2]
[  262.128999] BUG: KASAN: slab-out-of-bounds in 
__handle_control+0x200c/0x51d0 [libceph]
[  262.130770] Read of size 8 at addr ffff8881a47c83f0 by task 
kworker/22:1/279

[  262.132487] CPU: 22 UID: 0 PID: 279 Comm: kworker/22:1 Tainted: G 
    W           6.19.2 #1 PREEMPT(voluntary)
[  262.132491] Tainted: [W]=WARN
[  262.132492] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  262.132494] Workqueue: ceph-msgr ceph_con_workfn [libceph]
[  262.132518] Call Trace:
[  262.132519]  <TASK>
[  262.132520]  dump_stack_lvl+0x76/0xa0
[  262.132524]  print_report+0xd1/0x620
[  262.132526]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  262.132528]  ? kasan_save_stack+0x39/0x70
[  262.132531]  ? kasan_complete_mode_report_info+0x26/0x210
[  262.132533]  kasan_report+0xe7/0x130
[  262.132535]  ? __handle_control+0x200c/0x51d0 [libceph]
[  262.132558]  ? __handle_control+0x200c/0x51d0 [libceph]
[  262.132581]  __asan_report_load_n_noabort+0xf/0x20
[  262.132583]  __handle_control+0x200c/0x51d0 [libceph]
[  262.132607]  ? __pfx___handle_control+0x10/0x10 [libceph]
[  262.132629]  ? kvm_sched_clock_read+0x11/0x20
[  262.132632]  ? sched_clock_noinstr+0x9/0x10
[  262.132634]  ? kasan_save_track+0x27/0x70
[  262.132637]  ? kasan_save_alloc_info+0x37/0x60
[  262.132638]  ? __kasan_kmalloc+0xc3/0xd0
[  262.132641]  ? __kvmalloc_node_noprof+0x288/0x8e0
[  262.132644]  ? alloc_conn_buf+0xd3/0x2b0 [libceph]
[  262.132667]  ceph_con_v2_try_read+0x357d/0x6c80 [libceph]
[  262.132691]  ? __pfx_ceph_con_v2_try_read+0x10/0x10 [libceph]
[  262.132713]  ? save_fpregs_to_fpstate+0xb0/0x230
[  262.132715]  ? raw_spin_rq_unlock+0x17/0xa0
[  262.132718]  ? finish_task_switch.isra.0+0x13b/0x760
[  262.132720]  ? __switch_to+0x385/0xda0
[  262.132722]  ? __kasan_check_write+0x14/0x30
[  262.132724]  ? mutex_lock+0x8d/0xe0
[  262.132726]  ? __pfx_mutex_lock+0x10/0x10
[  262.132729]  ceph_con_workfn+0x248/0x10c0 [libceph]
[  262.132752]  process_one_work+0x629/0xf80
[  262.132754]  ? __kasan_check_write+0x14/0x30
[  262.132757]  worker_thread+0x87f/0x1570
[  262.132759]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  262.132761]  ? __pfx_try_to_wake_up+0x10/0x10
[  262.132764]  ? kasan_print_address_stack_frame+0x1b7/0x280
[  262.132766]  ? __pfx_worker_thread+0x10/0x10
[  262.132769]  kthread+0x396/0x830
[  262.132771]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  262.132773]  ? __pfx_kthread+0x10/0x10
[  262.132775]  ? __kasan_check_write+0x14/0x30
[  262.132776]  ? recalc_sigpending+0x180/0x210
[  262.132779]  ? __pfx_kthread+0x10/0x10
[  262.132781]  ret_from_fork+0x3f7/0x610
[  262.132784]  ? __pfx_ret_from_fork+0x10/0x10
[  262.132786]  ? __switch_to+0x385/0xda0
[  262.132788]  ? __pfx_kthread+0x10/0x10
[  262.132790]  ret_from_fork_asm+0x1a/0x30
[  262.132793]  </TASK>

[  262.181727] Allocated by task 279 on cpu 22 at 262.127486s:
[  262.183055]  kasan_save_stack+0x39/0x70
[  262.183062]  kasan_save_track+0x18/0x70
[  262.183065]  kasan_save_alloc_info+0x37/0x60
[  262.183068]  __kasan_kmalloc+0xc3/0xd0
[  262.183070]  __kvmalloc_node_noprof+0x288/0x8e0
[  262.183074]  alloc_conn_buf+0xd3/0x2b0 [libceph]
[  262.183103]  ceph_con_v2_try_read+0x3535/0x6c80 [libceph]
[  262.183127]  ceph_con_workfn+0x248/0x10c0 [libceph]
[  262.183152]  process_one_work+0x629/0xf80
[  262.183156]  worker_thread+0x87f/0x1570
[  262.183159]  kthread+0x396/0x830
[  262.183162]  ret_from_fork+0x3f7/0x610
[  262.183165]  ret_from_fork_asm+0x1a/0x30

[  262.183719] The buggy address belongs to the object at ffff8881a47c83f0
                 which belongs to the cache kmalloc-rnd-15-8 of size 8
[  262.186670] The buggy address is located 0 bytes inside of
                 allocated 2-byte region [ffff8881a47c83f0, 
ffff8881a47c83f2)

[  262.190210] The buggy address belongs to the physical page:
[  262.191489] page: refcount:0 mapcount:0 mapping:0000000000000000 
index:0x0 pfn:0x1a47c8
[  262.191494] memcg:ffff88811cfe6001
[  262.191495] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  262.191499] page_type: f5(slab)
[  262.191502] raw: 0017ffffc0000000 ffff88810005b980 dead000000000122 
0000000000000000
[  262.191505] raw: 0000000000000000 0000000080550055 00000000f5000000 
ffff88811cfe6001
[  262.191507] page dumped because: kasan: bad access detected

[  262.192067] Memory state around the buggy address:
[  262.193215]  ffff8881a47c8280: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  262.194795]  ffff8881a47c8300: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  262.196608] >ffff8881a47c8380: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc 02 fc
[  262.198301] 
    ^
[  262.199832]  ffff8881a47c8400: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  262.201432]  ffff8881a47c8480: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  262.203017] 
==================================================================
