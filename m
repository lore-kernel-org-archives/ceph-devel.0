From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: krbd kernel 3.16.0-1 with v0.83 got stuck during write
Date: Thu, 7 Aug 2014 21:56:34 +0400
Message-ID: <CALFYKtCpSyPZX_gTpyhJu7MuEEUevsCgdNFvFBTz0Jx--VNTVA@mail.gmail.com>
References: <alpine.DEB.2.00.1407291820100.5744@cobra.newdream.net>
	<CA+SSH2qOdNne-ExmOjLGnNKfZYXtO+KJ8vSQzvJj07hOK5H8qA@mail.gmail.com>
	<alpine.DEB.2.00.1408050653170.18917@cobra.newdream.net>
	<20140807173646.GA1130@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:52636 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbaHGR4f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Aug 2014 13:56:35 -0400
Received: by mail-qg0-f51.google.com with SMTP id a108so4892989qge.10
        for <ceph-devel@vger.kernel.org>; Thu, 07 Aug 2014 10:56:35 -0700 (PDT)
In-Reply-To: <20140807173646.GA1130@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 7, 2014 at 9:36 PM, Kasper Dieter
<dieter.kasper@ts.fujitsu.com> wrote:
> Hi,
>
> I'm running a 3 node cluster with 126 OSDs in total under CentOS-6.5 with
> ceph version 0.83 (78ff1f0a5dfd3c5850805b4021738564c36c92b8)
>
> On the client side it's 0.83, too
> with kernel 3.16.0-1.el6.elrepo.x86_64
>
> rbd showmapped
> id pool   image           snap device
> 0  SAS-r2 sas2-r2-1T-4m.0 -    /dev/rbd0
> 1  SAS-r2 sas2-r2-1T-4m.1 -    /dev/rbd1
> 2  SAS-r2 sas2-r2-1T-4m.2 -    /dev/rbd2
>
> After a couple of minutes (trying to fill the 1TB volume)
> fio --filename=/dev/rbd0 --direct=1 --rw=write --bs=8M --size=8G --numjobs=128 --offset_increment=8G --runtime=3600 --group_reporting --name=file1
> got stuck.
>
> /var/log/message:
> (...)
> Aug  7 19:22:34 rx37-0 kernel: libceph: osd118 192.168.113.54:6902 socket closed (con state OPEN)
> Aug  7 19:22:34 rx37-0 kernel: libceph: osd40 192.168.113.52:6920 socket closed (con state OPEN)
> Aug  7 19:22:34 rx37-0 kernel: libceph: osd109 192.168.113.54:6875 socket closed (con state OPEN)
> Aug  7 19:22:34 rx37-0 kernel: libceph: osd67 192.168.113.53:6875 socket closed (con state OPEN)
> Aug  7 19:22:34 rx37-0 kernel: libceph: osd37 192.168.113.52:6911 socket closed (con state OPEN)
> Aug  7 19:22:34 rx37-0 kernel: libceph: osd98 192.168.113.54:6842 socket closed (con state OPEN)
> Aug  7 19:22:34 rx37-0 kernel: libceph: osd26 192.168.113.52:6878 socket closed (con state OPEN)
> Aug  7 19:24:43 rx37-0 kernel: INFO: task kworker/2:0:19 blocked for more than 120 seconds.
> Aug  7 19:24:43 rx37-0 kernel:      Not tainted 3.16.0-1.el6.elrepo.x86_64 #1
> Aug  7 19:24:43 rx37-0 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Aug  7 19:24:43 rx37-0 kernel: kworker/2:0     D 0000000000000002     0    19      2 0x00000000
> Aug  7 19:24:43 rx37-0 kernel: Workqueue: ceph-msgr con_work [libceph]
> Aug  7 19:24:43 rx37-0 kernel: ffff8810307bfb68 0000000000000046 ffff8810307bfb18 ffff8810307bc010
> Aug  7 19:24:43 rx37-0 kernel: 0000000000014380 0000000000014380 ffff8810307ae390 ffff880079678250
> Aug  7 19:24:43 rx37-0 kernel: 0000003500004040 ffff88102a1fd7c8 ffff88102a1fd7cc ffff8810307ae390
> Aug  7 19:24:43 rx37-0 kernel: Call Trace:
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffff81647629>] schedule+0x29/0x70
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffff8164778e>] schedule_preempt_disabled+0xe/0x10
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffff816490fb>] __mutex_lock_slowpath+0xdb/0x1d0
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffff81649213>] mutex_lock+0x23/0x40
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffffa0615e0f>] get_reply+0x3f/0x200 [libceph]
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffffa0616058>] alloc_msg+0x88/0x90 [libceph]
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffffa060d8f1>] ceph_con_in_msg_alloc+0x71/0x240 [libceph]
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffffa060eba8>] read_partial_message+0x1e8/0x3d0 [libceph]
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffffa060d278>] ? ceph_tcp_recvmsg+0x48/0x60 [libceph]
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffffa06101d6>] try_read+0x2b6/0x430 [libceph]
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffffa0610688>] con_work+0x78/0x220 [libceph]
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffff8108d60c>] process_one_work+0x17c/0x420
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffff8108e7d3>] worker_thread+0x123/0x420
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffff8108e6b0>] ? maybe_create_worker+0x180/0x180
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffff810943be>] kthread+0xce/0xf0
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffff810942f0>] ? kthread_freezable_should_stop+0x70/0x70
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffff8164ae3c>] ret_from_fork+0x7c/0xb0
> Aug  7 19:24:43 rx37-0 kernel: [<ffffffff810942f0>] ? kthread_freezable_should_stop+0x70/0x70
> Aug  7 19:24:43 rx37-0 kernel: INFO: task kworker/3:0:24 blocked for more than 120 seconds.
> Aug  7 19:24:43 rx37-0 kernel:      Not tainted 3.16.0-1.el6.elrepo.x86_64 #1
> Aug  7 19:24:43 rx37-0 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Aug  7 19:24:43 rx37-0 kernel: kworker/3:0     D 0000000000000003     0    24      2 0x00000000
> Aug  7 19:24:43 rx37-0 kernel: Workqueue: ceph-msgr con_work [libceph]
> Aug  7 19:24:43 rx37-0 kernel: ffff881030027c98 0000000000000046 ffff881019afe330 ffff881030024010
> (...)
>
>
> Any ideas ?
>
> With Kernel 3.10.32 on the client side everythink worked fine.

http://tracker.ceph.com/issues/8818, the fix is on its way to mainline
and will be backported to 3.15 and 3.16.

Thanks,

                Ilya
