From: Mandell Degerness <mandell@pistoncloud.com>
Subject: ceph-mon blocked error
Date: Wed, 2 Nov 2011 21:30:55 -0700
Message-ID: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60443 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab1KCEa4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 00:30:56 -0400
Received: by vcge1 with SMTP id e1so787183vcg.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 Nov 2011 21:30:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Should this error showing up in the log worry me?


Nov  2 21:28:12 node-172-16-0-128 kernel: INFO: task ceph-mon:5715
blocked for more than 120 seconds.
Nov  2 21:28:12 node-172-16-0-128 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Nov  2 21:28:12 node-172-16-0-128 kernel: ceph-mon        D
0000000006bcdc9f     0  5715      1 0x00000000
Nov  2 21:28:12 node-172-16-0-128 kernel: ffff88080d5dfc38
0000000000000086 ffff8807eadec0c0 ffff8804274d60c0
Nov  2 21:28:12 node-172-16-0-128 kernel: ffff88080d5dfc48
0000000000011980 0000000000011980 0000000000011980
Nov  2 21:28:12 node-172-16-0-128 kernel: ffff88080d5dffd8
0000000000011980 0000000000011980 ffff88080d5dffd8
Nov  2 21:28:12 node-172-16-0-128 kernel: Call Trace:
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff81630b5e>]
schedule+0x6d/0x83
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff81630ee2>]
schedule_timeout+0x36/0xe3
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff81630360>]
wait_for_common+0xa0/0x105
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff81048595>] ?
try_to_wake_up+0x1ed/0x1ed
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff812462a8>] ?
xfs_bwrite+0x4b/0x95
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff8116ef45>] ?
__sync_filesystem+0xa1/0xa1
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff81630553>]
wait_for_completion+0x30/0x46
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff812457c6>]
xfs_buf_iowait+0x61/0xb9
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff812462a8>]
xfs_bwrite+0x4b/0x95
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff81254c70>]
xfs_sync_fsdata+0x4b/0x66
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff81255138>]
xfs_quiesce_data+0x39/0xa3
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff81252b49>]
xfs_fs_sync_fs+0x34/0x71
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff8116ef1b>]
__sync_filesystem+0x77/0xa1
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff8116ef6e>]
sync_one_sb+0x29/0x3f
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff8114620e>]
iterate_supers+0x7c/0xe3
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff8116ee2f>]
sync_filesystems+0x2f/0x45
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff8116f02e>]
sys_sync+0x34/0x5a
Nov  2 21:28:12 node-172-16-0-128 kernel: [<ffffffff8163326b>]
system_call_fastpath+0x16/0x1b
