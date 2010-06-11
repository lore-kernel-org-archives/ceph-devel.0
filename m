From: Matt Weil <mweil@watson.wustl.edu>
Subject: Re: 2.6.34 soft lockup - CPU#1 stuck for 61s!
Date: Fri, 11 Jun 2010 08:23:30 -0500
Message-ID: <4C1238D2.9000700@watson.wustl.edu>
References: <4C110BBD.7070402@watson.wustl.edu> <AANLkTil5rDlFX56U8ohpLxBfVyiXJXl3PaYnKgwESRnU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050902020008000200000608"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:36580 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756216Ab0FKNXb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jun 2010 09:23:31 -0400
In-Reply-To: <AANLkTil5rDlFX56U8ohpLxBfVyiXJXl3PaYnKgwESRnU@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050902020008000200000608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Yehuda Sadeh Weinraub wrote:
> That usually happens when there's some pending request that waits too
> long. It's really hard to tell what exactly happened from this log as
> for some reason we don't see the expected backtrace.

Thanks for the response.

was just cp'n some files into a ceph volume.

see attached.

> 
> Yehuda
> 
> On Thu, Jun 10, 2010 at 8:58 AM, Matt Weil <mweil@watson.wustl.edu> wrote:
>> anyone seen this?
>>
>> ceph client
>>


--------------050902020008000200000608
Content-Type: text/plain;
 name="cp_process_CPU1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cp_process_CPU1.txt"

Jun 10 08:45:22 linuscs102 kernel: [174034.263762]  [<ffffffff81144e05>] ? get_write_access+0x45/0x70
Jun 10 08:45:22 linuscs102 kernel: [174034.263762]  [<ffffffff811474d3>] ? do_last+0x4c3/0x690
Jun 10 08:45:22 linuscs102 kernel: [174034.263762]  [<ffffffff8114964b>] ? do_filp_open+0x21b/0x660
Jun 10 08:45:22 linuscs102 kernel: [174034.263762]  [<ffffffff8115459a>] ? alloc_fd+0x10a/0x150
Jun 10 08:45:22 linuscs102 kernel: [174034.263762]  [<ffffffff811390f9>] ? do_sys_open+0x69/0x140
Jun 10 08:45:22 linuscs102 kernel: [174034.263762]  [<ffffffff81139210>] ? sys_open+0x20/0x30
Jun 10 08:45:22 linuscs102 kernel: [174034.263762]  [<ffffffff8100a072>] ? system_call_fastpath+0x16/0x1b
Jun 10 08:46:28 linuscs102 kernel: [174099.720617] BUG: soft lockup - CPU#1 stuck for 61s! [cp:1980]
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] Modules linked in: nfs fbcon tileblit font bitblit softcursor nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs lp radeon ttm drm_kms_helper i5000_edac psmouse ipmi_si bnx2 edac_core serio_raw parport drm ipmi_msghandler shpchp hpilo i2c_algo_bit i5k_amb usbhid hid cciss
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] CPU 1
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] Modules linked in: nfs fbcon tileblit font bitblit softcursor nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs lp radeon ttm drm_kms_helper i5000_edac psmouse ipmi_si bnx2 edac_core serio_raw parport drm ipmi_msghandler shpchp hpilo i2c_algo_bit i5k_amb usbhid hid cciss
Jun 10 08:46:28 linuscs102 kernel: [174099.723131]
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] Pid: 1980, comm: cp Not tainted 2.6.34-ceph-client2 #1 /ProLiant DL380 G5
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] RIP: 0010:[<ffffffff81031aee>]  [<ffffffff81031aee>] __ticket_spin_lock+0xe/0x20
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] RSP: 0018:ffff88038ae178c8  EFLAGS: 00000286
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] RAX: 000000000000d4d4 RBX: ffff88038ae178c8 RCX: 7fffffffffffffff
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] RDX: ffff88020c834c70 RSI: 0000000000002000 RDI: ffff88020c834d1c
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] RBP: ffffffff8100aa0e R08: ffff88020c834d88 R09: ffff88038ae17b38
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] R10: 0000000000000001 R11: 00000000ffffffff R12: ffff88020c834d88
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] R13: ffff88038ae17b38 R14: 0000000000000001 R15: 00000000ffffffff
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] FS:  00007fb14d7677a0(0000) GS:ffff880001e40000(0000) knlGS:0000000000000000
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] CR2: 00000000015cb2b0 CR3: 000000040cc9c000 CR4: 00000000000006e0
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] Process cp (pid: 1980, threadinfo ffff88038ae16000, task ffff88041cbb5c00)
Jun 10 08:46:28 linuscs102 kernel: [174099.723131] Stack:
Jun 10 08:46:28 linuscs102 kernel: [174099.733130]  ffff88038ae178d8 ffffffff815bd06e ffff88038ae17908 ffffffff812a0b15
Jun 10 08:46:28 linuscs102 kernel: [174099.733130] <0> ffff88041c929688 0000000000000016 0000000000000001 0000000000000000
Jun 10 08:46:28 linuscs102 kernel: [174099.733130] <0> ffff88038ae17b18 ffffffff8129de66 0000000000000001 00000000ffffffff
Jun 10 08:46:28 linuscs102 kernel: [174099.733130] Call Trace:
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff815bd06e>] ? _raw_spin_lock+0xe/0x20
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff812a0b15>] ? ceph_caps_revoking+0x25/0xa0
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff8129de66>] ? ceph_writepages_start+0x66/0xad0
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff8100aa0e>] ? apic_timer_interrupt+0xe/0x20
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff810f6525>] ? pagevec_lookup_tag+0x25/0x40
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff810ec2d6>] ? filemap_fdatawait_range+0xa6/0x1a0
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff8100aa0e>] ? apic_timer_interrupt+0xe/0x20
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff810f56c1>] ? do_writepages+0x21/0x40
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff810ec45b>] ? __filemap_fdatawrite_range+0x5b/0x60
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff810ec4ba>] ? filemap_write_and_wait_range+0x5a/0x80
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff81296c20>] ? __ceph_do_pending_vmtruncate+0x60/0x130
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff81296fdd>] ? ceph_setattr+0x2ed/0x5f0
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff8115359b>] ? notify_change+0x16b/0x310
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff8113a334>] ? do_truncate+0x64/0xa0
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff812cfb6f>] ? security_inode_permission+0x1f/0x30
Jun 10 08:46:28 linuscs102 kernel: [174099.741260]  [<ffffffff81144e05>] ? get_write_access+0x45/0x70


--------------050902020008000200000608--
