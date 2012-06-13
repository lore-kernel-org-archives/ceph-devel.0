From: "Yan, Zheng" <zheng.z.yan@linux.intel.com>
Subject: Re: [PATCH 09/13] libceph: start tracking connection socket state
Date: Wed, 13 Jun 2012 09:50:02 +0800
Message-ID: <4FD7F1CA.2080304@linux.intel.com>
References: <4FC673FC.3060004@inktank.com> <4FC6766B.1090307@inktank.com> <CAAM7YA=4M_NQq03UCiEO=RQ=D3d3LHq1T9fbCkiqBxvv-AQyLA@mail.gmail.com> <Pine.LNX.4.64.1206112158170.10716@cobra.newdream.net> <4FD6CD6A.9040505@linux.intel.com> <4FD7753A.7060000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48995 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390Ab2FMBuE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jun 2012 21:50:04 -0400
In-Reply-To: <4FD7753A.7060000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 06/13/2012 12:58 AM, Alex Elder wrote:
> On 06/12/2012 12:02 AM, Yan, Zheng wrote:
>> On 06/12/2012 01:00 PM, Sage Weil wrote:
>>> Yep.  This was just fixed yesterday, in the testing-next branch, by 
>>> 'libceph: transition socket state prior to actual connect'.
>>>
>>> Are you still hitting the bio null deref?
>>>
>> No,
>>
>> Cheers
>> Yan, Zheng
> 
> Would you be able to narrow down exactly what fixed the bio null
> problem?  Are you able to easily reproduce it?  Are you running
> the master branch, or testing, or what?
> 
The 'clear msg->bio_iter' patch. Without it, I always got below Oops
when xfstest reached the 49th test case. 

---
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.610673] libceph: osd3 10.239.36.78:6807 socket closed
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.612784] BUG: unable to handle kernel NULL pointer dereference at 0000000000000048
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.614482] IP: [<ffffffffa062bc98>] con_work+0x19a8/0x2c80 [libceph]
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.616120] PGD 137d91067 PUD 137d92067 PMD 0
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.617749] Oops: 0000 [#1] SMP
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.619404] CPU 6
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.621059] Pid: 8239, comm: kworker/6:6 Not tainted 3.5.0-rc2+ #91 Dell Inc. Studio XPS 8000/0X231R
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.622700] RIP: 0010:[<ffffffffa062bc98>]  [<ffffffffa062bc98>] con_work+0x19a8/0x2c80 [libceph]
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.624371] RSP: 0018:ffff88000efb7cb0  EFLAGS: 00010246
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.626119] RAX: 0000000000000000 RBX: ffff880122370030 RCX: 000000000006a000
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.627694] RDX: 0000000000000000 RSI: 0000000000016000 RDI: ffff880122370420
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.629267] RBP: ffff88000efb7e00 R08: 00000000418d4bd6 R09: 0000000000000000
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.630811] R10: 0000000000000002 R11: 0000000000000dc7 R12: 0000000000080000
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.632441] R13: 0000000000000000 R14: ffff88003af1bd00 R15: ffffea00044aec40
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.633996] FS:  0000000000000000(0000) GS:ffff88013fd80000(0000) knlGS:0000000000000000
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.635621] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.637239] CR2: 0000000000000048 CR3: 0000000137d90000 CR4: 00000000000007e0
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.638841] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.640493] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.642255] Process kworker/6:6 (pid: 8239, threadinfo ffff88000efb6000, task ffff880041242e60)
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.643917] Stack:
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.645588]  ffff880000000001 ffffffff00000006 ffff88000efb7dac 0000000600000002
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.647270]  ffff88000efb7d30 ffffffff810930d1 ffff88013b00a400 0000000000000087
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.648923]  0000000eed1e4f54 ffff880041242e60 ffff88000efb7d30 ffffffff00000000
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.650563] Call Trace:
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.652162]  [<ffffffff810930d1>] ? update_curr+0x141/0x1f0
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.653688]  [<ffffffffa062a2f0>] ? ceph_msg_new+0x2d0/0x2d0 [libceph]
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.655203]  [<ffffffff81075f6d>] process_one_work+0x11d/0x470
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.656714]  [<ffffffff81077069>] worker_thread+0x159/0x340
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.658278]  [<ffffffff81076f10>] ? manage_workers+0x230/0x230
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.659606]  [<ffffffff8107bee3>] kthread+0x93/0xa0
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.660932]  [<ffffffff8160d9e4>] kernel_thread_helper+0x4/0x10
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.662293]  [<ffffffff8107be50>] ? kthread_freezable_should_stop+0x70/0x70
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.663670]  [<ffffffff8160d9e0>] ? gs_change+0x13/0x13
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.665027] Code: ef fb ff ff 0f 1f 80 00 00 00 00 49 83 be 90 00 00 00 00 0f 84 7a 01 00 00 49 63 86 a0 00 00 00 49 8b 96 98 00 00 00 48 c1 e0 04 <48> 03 42 48 4c 8b 38 8b 48 0c 8b 50 08 e9 08 f8 ff ff 49 89 86
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.666570] RIP  [<ffffffffa062bc98>] con_work+0x19a8/0x2c80 [libceph]
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.668232]  RSP <ffff88000efb7cb0>
Jun 13 09:34:14 zyan5-desk kernel: [ 1192.669795] CR2: 0000000000000048

