From: huang jun <hjwsm1989@gmail.com>
Subject: osd timeout result in client heavyly pause
Date: Fri, 18 Mar 2011 10:04:30 +0800
Message-ID: <AANLkTinJtCEc0Zq14XTerdMx78bSt-rouTbs-A7PWGmN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61421 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533Ab1CRCEb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2011 22:04:31 -0400
Received: by vxi39 with SMTP id 39so3195217vxi.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 Mar 2011 19:04:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi=A3=AC
my ceph cluster is:
1 mon=A3=AC1 mds, 6 osds
use a client to write files
but after two days,the client can not write anymore , dmesg show:
[152312.784043] libceph:  tid 221531 timed out on osd2, will reset osd
[152322.800025] libceph:  tid 221534 timed out on osd1, will reset osd
[152362.864029] libceph:  tid 221553 timed out on osd3, will reset osd
[152362.864115] libceph:  tid 221556 timed out on osd0, will reset osd
[152362.864175] libceph:  tid 221558 timed out on osd4, will reset osd
[152362.864236] libceph:  tid 221568 timed out on osd5, will reset osd
[152372.880024] libceph:  tid 221531 timed out on osd2, will reset osd
[152432.976030] libceph:  tid 221531 timed out on osd2, will reset osd
[152493.072035] libceph:  tid 221531 timed out on osd2, will reset osd
[152553.168039] libceph:  tid 221531 timed out on osd2, will reset osd
[152613.264027] libceph:  tid 221531 timed out on osd2, will reset osd
[152673.360028] libceph:  tid 221531 timed out on osd2, will reset osd
[152733.456028] libceph:  tid 221531 timed out on osd2, will reset osd
[152793.552026] libceph:  tid 221531 timed out on osd2, will reset osd
[152853.648025] libceph:  tid 221531 timed out on osd2, will reset osd
[152913.744029] libceph:  tid 221531 timed out on osd2, will reset osd
[152973.840026] libceph:  tid 221531 timed out on osd2, will reset osd
[153033.936026] libceph:  tid 221531 timed out on osd2, will reset osd

and on osd2:
dmesg show :

[140056.772753] btrfs: truncated 1 orphans
[140108.340423] btrfs: truncated 1 orphans
[141681.918175] btrfs: truncated 1 orphans
[148394.437973] btrfs: truncated 1 orphans
[152007.353121] btrfs: truncated 1 orphans
[152338.400197] btrfs: truncated 1 orphans
[152880.944055] INFO: task btrfs-transacti:3046 blocked for more than
120 seconds.
[152880.944341] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[152880.944664] btrfs-transac D ffff88007e0996c8     0  3046      2 0x0=
0000000
[152880.944677]  ffff88007e28d6f0 0000000000000046 0000000000000002
0000000000013500
[152880.944688]  ffff88006f5b3fd8 ffff88006f5b3fd8 ffff88007e099430
0000000000013500
[152880.944699]  0000000000013500 0000000000013500 ffff88007e099430
0000000000000286
[152880.944710] Call Trace:
[152880.944727]  [<ffffffff8114c646>] ? wait_for_commit+0x8f/0xd5
[152880.944738]  [<ffffffff810536e2>] ? autoremove_wake_function+0x0/0x=
2e
[152880.944748]  [<ffffffff8114d4cf>] ? btrfs_commit_transaction+0xff/0=
x5ec
[152880.944759]  [<ffffffff8130ecb4>] ? schedule_timeout+0x202/0x222
[152880.944769]  [<ffffffff810536e2>] ? autoremove_wake_function+0x0/0x=
2e
[152880.944779]  [<ffffffff8114928d>] ? transaction_kthread+0x158/0x20c
[152880.944789]  [<ffffffff81149135>] ? transaction_kthread+0x0/0x20c
[152880.944798]  [<ffffffff81053299>] ? kthread+0x79/0x81
[152880.944808]  [<ffffffff81003824>] ? kernel_thread_helper+0x4/0x10
[152880.944818]  [<ffffffff81053220>] ? kthread+0x0/0x81
[152880.944827]  [<ffffffff81003820>] ? kernel_thread_helper+0x0/0x10
[152880.944837] INFO: task cosd:3137 blocked for more than 120 seconds.
[152880.945157] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[152880.945513] cosd          D ffff88006f5b5038     0  3137      1 0x0=
0000000
[152880.945523]  ffff88007ebd34b0 0000000000000086 0000000000000000
0000000000013500
[152880.945531]  ffff88007e2dffd8 ffff88007e2dffd8 ffff88006f5b4da0
0000000000013500
[152880.945540]  0000000000013500 0000000000013500 ffff88006f5b4da0
ffffffff810a5ba3

everything seems ok after we out osd2,client works fluently.
does the problem relate to btrfs ?
thanks !
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
