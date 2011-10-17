From: Martin Mailand <martin@tuxadero.com>
Subject: Re: OSD blocked for more than 120 seconds
Date: Mon, 17 Oct 2011 15:21:46 +0200
Message-ID: <4E9C2BEA.70002@tuxadero.com>
References: <4E974C87.2070204@tuxadero.com> <1318585099.2999.10.camel@wido-laptop> <CAO47_-8wOFxzjy-n2W_q75D=h7z8spswgghJ9iy8p6eQu-2kFA@mail.gmail.com> <4E99E68F.9090005@tuxadero.com> <CAO47_-9qWX5cq-Qh9Kajt68ZCyzyhdsU5XTZ8MXSTj-s8+_XzA@mail.gmail.com> <4E9C1645.3070205@tuxadero.com> <CAMvP8PC9j1V20HR1a1mTWVJKT+cbsbAHiigz+2XwBGm14dU7mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:48620 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab1JQNVx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2011 09:21:53 -0400
In-Reply-To: <CAMvP8PC9j1V20HR1a1mTWVJKT+cbsbAHiigz+2XwBGm14dU7mw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Paszkowski <ss7pro@gmail.com>
Cc: chb@muc.de, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Am 17.10.2011 14:05, schrieb Tomasz Paszkowski:
> Hi,
>
> It seems that ext4 and btrfs are not to be considered as stable for
> now. Does anyone could confirm that
> ext3 is the best choice for this moment ?

Hi,
I did a quick test with ext3, and it did not look very good.
After a few minutes one of the osds failed with this message.

[315274.737204] kjournald starting.  Commit interval 5 seconds
[315274.737919] EXT3-fs (sdb): using internal journal
[315274.737929] EXT3-fs (sdb): mounted filesystem with ordered data mode
[317040.890148] INFO: task ceph-osd:18032 blocked for more than 120 seconds.
[317040.905855] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[317040.923801] ceph-osd        D ffff880114c8b1a0     0 18032      1 
0x00000000
[317040.923812]  ffff88010f2e3cb8 0000000000000086 ffff88010f2e3cb8 
ffff88010f2e3cb8
[317040.923821]  ffff88011ffdff08 ffff88010f2e3fd8 ffff88010f2e2000 
ffff88010f2e3fd8
[317040.923830]  ffff880116dadbc0 ffff880114c8ade0 ffff88010f2e3cd8 
ffffffff8110d500
[317040.923847] Call Trace:
[317040.923865]  [<ffffffff8110d500>] ? find_get_pages_tag+0x40/0x130
[317040.923876]  [<ffffffff815d93df>] schedule+0x3f/0x60
[317040.923884]  [<ffffffff815d99ed>] schedule_timeout+0x26d/0x2e0
[317040.923893]  [<ffffffff8101a725>] ? native_sched_clock+0x15/0x70
[317040.923899]  [<ffffffff8101a789>] ? sched_clock+0x9/0x10
[317040.923908]  [<ffffffff8108d465>] ? sched_clock_local+0x25/0x90
[317040.923916]  [<ffffffff815d9219>] wait_for_common+0xd9/0x180
[317040.923924]  [<ffffffff8105bbc0>] ? try_to_wake_up+0x2b0/0x2b0
[317040.923932]  [<ffffffff815d939d>] wait_for_completion+0x1d/0x20
[317040.923941]  [<ffffffff8118d652>] sync_inodes_sb+0x92/0x1c0
[317040.923949]  [<ffffffff81192440>] ? __sync_filesystem+0x90/0x90
[317040.923956]  [<ffffffff81192430>] __sync_filesystem+0x80/0x90
[317040.923963]  [<ffffffff8119245f>] sync_one_sb+0x1f/0x30
[317040.923972]  [<ffffffff81169268>] iterate_supers+0xa8/0x100
[317040.923979]  [<ffffffff81192360>] sync_filesystems+0x20/0x30
[317040.923985]  [<ffffffff81192501>] sys_sync+0x21/0x40
[317040.923995]  [<ffffffff815e37c2>] system_call_fastpath+0x16/0x1b

Best Regards,
  martin
