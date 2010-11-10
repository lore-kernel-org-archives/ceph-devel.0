From: Wido den Hollander <wido@widodh.nl>
Subject: Re: mount error on cephv0.22.2
Date: Wed, 10 Nov 2010 14:55:47 +0100
Message-ID: <1289397347.2212.8.camel@wido-desktop>
References: <AANLkTinJUHUs1Zub-05ov=SXnLEn7mHrGihxnzad4G3+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:35264 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab0KJNzt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Nov 2010 08:55:49 -0500
In-Reply-To: <AANLkTinJUHUs1Zub-05ov=SXnLEn7mHrGihxnzad4G3+@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: srimugunthan dhandapani <srimugunthan.dhandapani@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

It seems you OSD is stalling.

When you do "ps aux", do you see any processes in the "D" state (beside
cosd)

And what does "ceph -s" show?

Btw, in your ceph.conf, use "host = <hostname>" instead of the
IP-Address of the machine.

Wido

On Wed, 2010-11-10 at 18:45 +0530, srimugunthan dhandapani wrote:
> Hi all,
> I used v0.22.2 ceph with latest git "ceph-standalone-client kernel"
> (2.6.36-rc8) and when i try to mount i get the following error
> mount error 5 = Input/output error
> the dmesg call trace is as follows:
> [  199.099511] ceph: loaded (mds proto 32)
> [  227.730778] libceph: client4099 fsid 2bf77910-49e4-89cb-8ef0-b74ce321acc4
> [  227.730999] libceph: mon0 192.168.1.79:6789 session established
> [  360.236062] INFO: task cosd:5004 blocked for more than 120 seconds.
> [  360.236068] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  360.236073] cosd          D f4f7df20     0  5004      1 0x00000000
> [  360.236080]  f4f7df30 00200086 00000002 f4f7df20 f4f7dee8 c01673d0
> ffffffff 00000000
> [  360.236092]  c02383f0 f4f758d0 c085c940 f4f75b58 f4f75b5c 5adef48d
> 00000035 c085c940
> [  360.236104]  c085c940 c085c940 00000000 c085c940 5ade69ed 00000035
> f4f758d0 00000001
> [  360.236115] Call Trace:
> [  360.236128]  [<c01673d0>] ? autoremove_wake_function+0x20/0x50
> [  360.236135]  [<c02383f0>] ? blkdev_writepage+0x0/0x20
> [  360.236143]  [<c05a21e5>] rwsem_down_failed_common+0x95/0xf0
> [  360.236148]  [<c05a2272>] rwsem_down_read_failed+0x12/0x20
> [  360.236153]  [<c05a22c7>] call_rwsem_down_read_failed+0x7/0x10
> [  360.236157]  [<c05a16ec>] ? down_read+0x1c/0x20
> [  360.236163]  [<c020f51f>] iterate_supers+0x5f/0xc0
> [  360.236167]  [<c0230400>] ? sync_one_sb+0x0/0x30
> [  360.236171]  [<c0230459>] sys_sync+0x29/0x60
> [  360.236176]  [<c0102fe3>] sysenter_do_call+0x12/0x28
> 
> my ceph.conf is attached. i was able to mount with the same ceph.conf
> file in ceph0.21.1 and kernel 2.6.35  and also with ceph0.21.3 and
> 2.6.35 kernel.
> I got  the same error with v0.22.2 and kernel 2.6.35 . So i updated
> the kernel but it didn't help.
> In ceph code , in src/cmds.cc and src/cosd.cc i commented out the line
> //  g_conf.profiler_running = IsHeapProfilerRunning;
> for the compilation to pass.
> 
> the steps i used the following commands as root:
> 
> mkcephfs -c /etc/ceph/ceph.conf --allhosts -v
> /etc/init.d/ceph -a start
> modprobe ceph
> mount -t ceph 192.168.1.79:/ /ceph
> 
> Kindly point out what i am missing.
> thanks,
> mugunthan

