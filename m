From: Patrick McLean <patrickm@gaikai.com>
Subject: deadlocks in rbd unmap and map
Date: Thu, 7 Jul 2016 18:28:52 -0700
Message-ID: <CAE2NFgVL6_+6JmW7aFO+v3j37BFnxXEneaOHk0eOCx-Vj1pAOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35955 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbcGHB2x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jul 2016 21:28:53 -0400
Received: by mail-io0-f180.google.com with SMTP id l202so34669842ioe.3
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jul 2016 18:28:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is on linus git master as of 2016/07/01

These appear to be two separate deadlocks, one on a a map operation,
and one on an unmap operation. We can reproduce these pretty
regularly, but it seems like there is some sort of race condition, as
it happens no where near every time.

We are currently working to reproduce on a kernel with lockdep
enabled, as well as better debugging information. Please let me know
if I can provide any more information.

# grep -C 40 rbd /proc/*/stack
/proc/14109/stack-[<ffffffff8111c7c4>] __queue_work+0x144/0x420
/proc/14109/stack-[<ffffffff8112c1c0>] default_wake_function+0x0/0x10
/proc/14109/stack:[<ffffffffa01561ee>]
rbd_obj_method_sync.constprop.48+0x1be/0x290 [rbd]
/proc/14109/stack:[<ffffffffa0156aea>] rbd_dev_header_info+0x15a/0x930 [rbd]
/proc/14109/stack:[<ffffffffa0157450>] rbd_watch_cb+0x0/0xa0 [rbd]
/proc/14109/stack:[<ffffffffa0157586>]
rbd_dev_image_probe.part.42+0x96/0x910 [rbd]
/proc/14109/stack:[<ffffffffa015640e>] rbd_dev_image_id+0x14e/0x1b0 [rbd]
/proc/14109/stack:[<ffffffffa015828f>] do_rbd_add.isra.43+0x48f/0xbb0 [rbd]
/proc/14109/stack-[<ffffffff8123ba27>] __kmalloc+0x27/0x170
/proc/14109/stack-[<ffffffff812b7f3a>] kernfs_fop_write+0x10a/0x190
/proc/14109/stack-[<ffffffff8124dc63>] __vfs_write+0x23/0x120
/proc/14109/stack-[<ffffffff8124e8f3>] vfs_write+0xb3/0x1a0
/proc/14109/stack-[<ffffffff8124fbd2>] SyS_write+0x42/0xa0
/proc/14109/stack-[<ffffffff81816f72>] entry_SYSCALL_64_fastpath+0x1a/0xa4
/proc/14109/stack-[<ffffffffffffffff>] 0xffffffffffffffff
--
/proc/29744/stack-[<ffffffff813c7c63>] call_rwsem_down_write_failed+0x13/0x20
/proc/29744/stack:[<ffffffffa01572dd>] rbd_dev_refresh+0x1d/0xf0 [rbd]
/proc/29744/stack:[<ffffffffa0157413>] rbd_watch_errcb+0x33/0x70 [rbd]
/proc/29744/stack-[<ffffffffa0126a2e>] do_watch_error+0x2e/0x40 [libceph]
/proc/29744/stack-[<ffffffff8111d935>] process_one_work+0x145/0x3c0
/proc/29744/stack-[<ffffffff8111dbfa>] worker_thread+0x4a/0x470
/proc/29744/stack-[<ffffffff8111dbb0>] worker_thread+0x0/0x470
/proc/29744/stack-[<ffffffff81122e4d>] kthread+0xbd/0xe0
/proc/29744/stack-[<ffffffff8181717f>] ret_from_fork+0x1f/0x40
/proc/29744/stack-[<ffffffff81122d90>] kthread+0x0/0xe0
/proc/29744/stack-[<ffffffffffffffff>] 0xffffffffffffffff
--
/proc/3426/stack-[<ffffffff8115ea31>] try_to_del_timer_sync+0x41/0x60
/proc/3426/stack-[<ffffffff8115ea94>] del_timer_sync+0x44/0x50
/proc/3426/stack-[<ffffffff8112c1c0>] default_wake_function+0x0/0x10
/proc/3426/stack-[<ffffffff8111b35f>] flush_workqueue+0x12f/0x540
/proc/3426/stack:[<ffffffffa015376b>] do_rbd_remove.isra.25+0xfb/0x190 [rbd]
/proc/3426/stack-[<ffffffff812b7f3a>] kernfs_fop_write+0x10a/0x190
/proc/3426/stack-[<ffffffff8124dc63>] __vfs_write+0x23/0x120
/proc/3426/stack-[<ffffffff8124e8f3>] vfs_write+0xb3/0x1a0
/proc/3426/stack-[<ffffffff8124fbd2>] SyS_write+0x42/0xa0
/proc/3426/stack-[<ffffffff81816f72>] entry_SYSCALL_64_fastpath+0x1a/0xa4
/proc/3426/stack-[<ffffffffffffffff>] 0xffffffffffffffff

 # ps aux | egrep '(14109|29744|3426)'
root      3426  0.0  0.0 181256 10488 ?        Dl   Jul06   0:00 rbd
unmap /dev/rbd0
root     14109  0.0  0.0 246704 10228 ?        Sl   Jul03   0:01 rbd
map --pool XXXX XXXXXXX
root     29744  0.0  0.0      0     0 ?        D    Jul05   0:00 [kworker/u16:2]
