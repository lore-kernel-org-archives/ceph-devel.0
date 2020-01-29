From: Satoru Takeuchi <satoru.takeuchi@gmail.com>
Subject: Some tasks got to hang_task that would be due to RBD driver
Date: Wed, 29 Jan 2020 16:24:33 +0900
Message-ID: <CAMym5ws4+-XstsJyvJmhzSHgvNYk8pbzOuY3cmT_ySwNDHkqCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38154 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgA2HYs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jan 2020 02:24:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so11142900lfm.5
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jan 2020 23:24:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

In Rook(*1)/Ceph community, some users encountered hang_task in XFS and it
would be caused by RBD driver.

Although we've not reproduced this problem in the newest kernel, could anyone
give us any hint about this problem, if possible?

*1) An Ceph orchestration in Kubernetes

- A question about this problem in linux-xfs ML
  https://marc.info/?l=linux-xfs&m=158009629016068&w=2

- The reply to the above-mentioned question from Dave Chinner.
  https://marc.info/?l=linux-xfs&m=158018349207976&w=2

I copied-and-pasted the discussion of above-mentioned mails here.

my question:
```
Under some workload in Ceph, many processes got to hang_task. We found
that there are two kinds of processes.

a) In very high CPU load
b) Encountered hang_task in the XFS

In addition,a user got the following two kernel traces.

A (b) process's backtrace with `hung_task_panic=1`.

```
[51717.039319] INFO: task kworker/2:1:5938 blocked for more than 120 seconds.
[51717.039361]       Not tainted 4.15.0-72-generic #81-Ubuntu
[51717.039388] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[51717.039426] kworker/2:1     D    0  5938      2 0x80000000
[51717.039471] Workqueue: xfs-sync/rbd0 xfs_log_worker [xfs]
[51717.039472] Call Trace:
[51717.039478]  __schedule+0x24e/0x880
[51717.039504]  ? xlog_sync+0x2d5/0x3c0 [xfs]
[51717.039506]  schedule+0x2c/0x80
[51717.039530]  _xfs_log_force_lsn+0x20e/0x350 [xfs]
[51717.039533]  ? wake_up_q+0x80/0x80
[51717.039556]  __xfs_trans_commit+0x20b/0x280 [xfs]
[51717.039577]  xfs_trans_commit+0x10/0x20 [xfs]
[51717.039600]  xfs_sync_sb+0x6d/0x80 [xfs]
[51717.039623]  xfs_log_worker+0xe7/0x100 [xfs]
[51717.039626]  process_one_work+0x1de/0x420
[51717.039627]  worker_thread+0x32/0x410
[51717.039628]  kthread+0x121/0x140
[51717.039630]  ? process_one_work+0x420/0x420
[51717.039631]  ? kthread_create_worker_on_cpu+0x70/0x70
[51717.039633]  ret_from_fork+0x35/0x40
```

A (b) process's backtrace that is got by `sudo cat /proc/<PID of a D
process>/stack`

```
[<0>] _xfs_log_force_lsn+0x20e/0x350 [xfs]
[<0>] __xfs_trans_commit+0x20b/0x280 [xfs]
[<0>] xfs_trans_commit+0x10/0x20 [xfs]
[<0>] xfs_sync_sb+0x6d/0x80 [xfs]
[<0>] xfs_log_sbcount+0x4b/0x60 [xfs]
[<0>] xfs_unmountfs+0xe7/0x200 [xfs]
[<0>] xfs_fs_put_super+0x3e/0xb0 [xfs]
[<0>] generic_shutdown_super+0x72/0x120
[<0>] kill_block_super+0x2c/0x80
[<0>] deactivate_locked_super+0x48/0x80
[<0>] deactivate_super+0x40/0x60
[<0>] cleanup_mnt+0x3f/0x80
[<0>] __cleanup_mnt+0x12/0x20
[<0>] task_work_run+0x9d/0xc0
[<0>] exit_to_usermode_loop+0xc0/0xd0
[<0>] do_syscall_64+0x121/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[<0>] 0xffffffffffffffff
```

Here is the result of my investigation:

- I couldn't find any commit that would be related to this problem,
both in the upstream
  master and master and XFS's for-next
- I couldn't find any discussions that would be related to the
above-mentioned backtrace
  in linux-xfs ML
- There would be a problem in the transaction commit of XFS. In both
of two traces,
  (b) processes hung in _xfs_log_force_lsn+0x20e/0x350 [xfs]. This
code is one of
  the following two xlog_wait().

  https://github.com/torvalds/linux/blob/master/fs/xfs/xfs_log.c#L3366
  https://github.com/torvalds/linux/blob/master/fs/xfs/xfs_log.c#L3387

  These processes released CPU voluntarily in the following line.

  https://github.com/torvalds/linux/blob/master/fs/xfs/xfs_log_priv.h#L549

  These two processes should be woken by the other process after that.
  However, unfortunately, it didn't happen.

Test environment:
- kernel: 4.15.0-<x>-generic
- XFS # Anyone hasn't reported this problem with other filesystems yet.

Related discussions:
- Issue of Rook:
  https://github.com/rook/rook/issues/3132
- Issue of Ceph
  https://tracker.ceph.com/issues/40068
```

Dave's answer:
```
> Under some workload in Ceph, many processes got to hang_task. We found
> that there
> are two kinds of processes.
>
> a) In very high CPU load
> b) Encountered hang_task in the XFS
>
> In addition,a user got the following two kernel traces.
>
> A (b) process's backtrace with `hung_task_panic=1`.
>
> ```
> [51717.039319] INFO: task kworker/2:1:5938 blocked for more than 120 seconds.
> [51717.039361]       Not tainted 4.15.0-72-generic #81-Ubuntu

Kinda old, and not an upstream LTS kernel, right?

> [51717.039388] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [51717.039426] kworker/2:1     D    0  5938      2 0x80000000
> [51717.039471] Workqueue: xfs-sync/rbd0 xfs_log_worker [xfs]

Filesystem is on a Ceph RBD device.

> [51717.039472] Call Trace:
> [51717.039478]  __schedule+0x24e/0x880
> [51717.039504]  ? xlog_sync+0x2d5/0x3c0 [xfs]
> [51717.039506]  schedule+0x2c/0x80
> [51717.039530]  _xfs_log_force_lsn+0x20e/0x350 [xfs]
> [51717.039533]  ? wake_up_q+0x80/0x80
> [51717.039556]  __xfs_trans_commit+0x20b/0x280 [xfs]
> [51717.039577]  xfs_trans_commit+0x10/0x20 [xfs]
> [51717.039600]  xfs_sync_sb+0x6d/0x80 [xfs]
> [51717.039623]  xfs_log_worker+0xe7/0x100 [xfs]
> [51717.039626]  process_one_work+0x1de/0x420
> [51717.039627]  worker_thread+0x32/0x410
> [51717.039628]  kthread+0x121/0x140
> [51717.039630]  ? process_one_work+0x420/0x420
> [51717.039631]  ? kthread_create_worker_on_cpu+0x70/0x70
> [51717.039633]  ret_from_fork+0x35/0x40

That's waiting for log IO completion.

> ```
>
> A (b) process's backtrace that is got by `sudo cat /proc/<PID of a D
> process>/stack`
>
> ```
> [<0>] _xfs_log_force_lsn+0x20e/0x350 [xfs]
> [<0>] __xfs_trans_commit+0x20b/0x280 [xfs]
> [<0>] xfs_trans_commit+0x10/0x20 [xfs]
> [<0>] xfs_sync_sb+0x6d/0x80 [xfs]
> [<0>] xfs_log_sbcount+0x4b/0x60 [xfs]
> [<0>] xfs_unmountfs+0xe7/0x200 [xfs]
> [<0>] xfs_fs_put_super+0x3e/0xb0 [xfs]
> [<0>] generic_shutdown_super+0x72/0x120
> [<0>] kill_block_super+0x2c/0x80
> [<0>] deactivate_locked_super+0x48/0x80
> [<0>] deactivate_super+0x40/0x60
> [<0>] cleanup_mnt+0x3f/0x80
> [<0>] __cleanup_mnt+0x12/0x20
> [<0>] task_work_run+0x9d/0xc0
> [<0>] exit_to_usermode_loop+0xc0/0xd0
> [<0>] do_syscall_64+0x121/0x130
> [<0>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [<0>] 0xffffffffffffffff

ANd this is the last reference to the filesystem being dropped and
it waiting for log IO completion.

So, the filesytem has been unmounted, and it's waiting for journal
IO on the device to complete.  I wonder if a wakeup was missed
somewhere?

Did the system stop/tear down /dev/rbd0 prematurely?

> Related discussions:
> - Issue of Rook:
>   https://github.com/rook/rook/issues/3132
> - Issue of Ceph
>   https://tracker.ceph.com/issues/40068

These point to Ceph RBDs failing to respond under high load and
tasks hanging because they are waiting on IO. That's exactly the
symptoms you are reporting here. That points to it being a Ceph RBD
issue to me, especially the reports where rbd devices report no IO
load but the ceph back end is at 100% disk utilisation doing
-something-.
```

Thanks,
Satoru
