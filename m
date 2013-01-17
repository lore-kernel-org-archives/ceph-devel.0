From: Sage Weil <sage@inktank.com>
Subject: RE: Ceph slow request & unstable issue
Date: Thu, 17 Jan 2013 08:57:09 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301170855260.1415@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC5DCC63@SHSMSX102.ccr.corp.intel.com> <CABYiri_50ijzfm1y-ryNULXq8DDNUWghrBaQBfzBkspzjpZx1A@mail.gmail.com> <alpine.DEB.2.00.1301160854170.15921@cobra.newdream.net> <6F3FA899187F0043BA1827A69DA2F7CC5DF17D@SHSMSX102.ccr.corp.intel.com>
 <alpine.DEB.2.00.1301161816060.23687@cobra.newdream.net> <6F3FA899187F0043BA1827A69DA2F7CC5DF1C2@SHSMSX102.ccr.corp.intel.com> <alpine.DEB.2.00.1301161834230.23687@cobra.newdream.net> <6F3FA899187F0043BA1827A69DA2F7CC5E091B@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33175 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab3AQQ5K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 11:57:10 -0500
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5E091B@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 17 Jan 2013, Chen, Xiaoxi wrote:
> Some update& summary for tested case till now:
> Ceph is v0.56.1
> 
> 1.	RBD:Ubuntu 13.04 + 3.7Kernel 
> 	OSD:Ubuntu 13.04 + 3.7Kernel
> 	XFS
> 
> 	Result: Kernel Panic on both RBD and OSD sides

We're very interested in the RBD client-side kernel panic!  I don't think 
there are known issues with 3.7.

> 2.	RBD:Ubuntu 13.04 +3.2Kernel
> 	OSD:Ubuntu 13.04 +3.2Kernel
> 	XFS
> 	
> 	Result:Kernel Panic on RBD( ~15Minus)

This less so; we've only backported fixes as far as 3.4.

> 3.	RBD:Ubuntu 13.04 + 3.6.7 Kernel (Suggested by Ceph.com)
> 	OSD:Ubuntu 13.04 + 3.2	 Kernel 
> 	XFS
> 
> 	Result: Auto-reset on OSD ( ~ 30 mins after the test started)
> 
> 4.	RBD:Ubuntu 13.04+3.6.7 Kernel (Suggested by Ceph.com)
> 	OSD:Ubuntu 12.04 + 3.2.0-36 Kernel (Suggested by Ceph.com)
> 	XFS
> 	
> 	Result:auto-reset on OSD ( ~ 30 mins after the test started)

These the the weird exit_mm traces shown below?

> 5.	RBD:Ubuntu 13.04+3.6.7 Kernel (Suggested by Ceph.com)
> 	OSD:Ubuntu 13.04 +3.6.7 (Suggested by Sage)
> 	XFS
> 
> 	Result: seems stable for last 1 hour, still running till now

Eager to hear how this goes.

Thanks!
sage


> 
> 
> Test 3&4 are repeatable.
> My test setup 
> OSD side:
>   3 nodes, 60 Disks(20 per nodes,1 per OSD),10Gb E, 4 *Intel 520 SSD per node as journal,XFS
>   For each node,2 * Intel(R) Xeon(R) CPU E5-2670 0 @ 2.60GH + 128GB RAM were used.
> RBD side:
>   8 nodes,for each node:10Gb E,2 * Intel(R) Xeon(R) CPU E5-2670 0 @ 2.60GH , 128GB RAM
> 
> Method:
> 	Create 240 RBD and mounted to 8 nodes ( 30 RBD per nodes), doing DD concurrently on all 240 RBDs.
> 
> 	After ~ 30 minutes, it's likely to have one of the OSD node reset.
> 
> Ceph OSD logs, syslog and dmesg from reseted node are available if you needed.(It looks to me that no valuable information except a lot of slow-request in OSD's log)
> 
> 
> 																			Xiaoxi
> 
> 
> -----Original Message-----
> From: Sage Weil [mailto:sage@inktank.com] 
> Sent: 2013?1?17? 10:35
> To: Chen, Xiaoxi
> Subject: RE: Ceph slow request & unstable issue
> 
> On Thu, 17 Jan 2013, Chen, Xiaoxi wrote:
> > No, on the OSD node, not the same node. OSD node with 3.2 kernel while 
> > client node with 3.6 kernel
> > 
> > We did suffer kernel panic on rbd client nodes but after upgrade 
> > client kernel to 3.6.6 it seems solved .
> 
> Is it easy to try the 3.6 kernel on the osd nodes too?
> 
> 
> > 
> > 
> > -----Original Message-----
> > From: Sage Weil [mailto:sage@inktank.com]
> > Sent: 2013?1?17? 10:17
> > To: Chen, Xiaoxi
> > Subject: RE: Ceph slow request & unstable issue
> > 
> > On Thu, 17 Jan 2013, Chen, Xiaoxi wrote:
> > > It is easily to reproduce in my setup...
> > > Once I have enough high load on it and waiting for tens of minutes? I can see such log.
> > > As a forecast, "slow requests" more than 30~60s  are frequently present in ceph osd's log.
> > 
> > Just replied to your other email.  Do I understand correctly that you are seeing this problem on the *rbd client* nodes?  Or also on the OSDs?  Are they the same nodes?
> > 
> > sage
> > 
> > > 
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sage@inktank.com]
> > > Sent: 2013?1?17? 0:59
> > > To: Andrey Korolyov
> > > Cc: Chen, Xiaoxi; ceph-devel@vger.kernel.org
> > > Subject: Re: Ceph slow request & unstable issue
> > > 
> > > Hi,
> > > 
> > > On Wed, 16 Jan 2013, Andrey Korolyov wrote:
> > > > On Wed, Jan 16, 2013 at 4:58 AM, Chen, Xiaoxi <xiaoxi.chen@intel.com> wrote:
> > > > > Hi list,
> > > > >         We are suffering from OSD or OS down when there is continuing high pressure on the Ceph rack.
> > > > >         Basically we are on Ubuntu 12.04+ Ceph 0.56.1, 6 nodes, in each nodes with 20 * spindles + 4* SSDs as journal.(120 spindles in total)
> > > > >         We create a lots of RBD volumes (say 240),mounting to 16 different client machines ( 15 RBD Volumes/ client) and running DD concurrently on top of each RBD.
> > > > >
> > > > >         The issues are:
> > > > > 1. Slow requests
> > > > > ??From the list-archive it seems solved in 0.56.1 but we still 
> > > > > notice such warning 2. OSD Down or even host down Like the 
> > > > > message below.Seems some OSD has been blocking there for quite a long time.
> > > > >
> > > > >         Suggestions are highly appreciate.Thanks
> > > > >                                                                                                                                                                         
> > > > > Xiaoxi
> > > > >
> > > > > _____________________________________________
> > > > >
> > > > > Bad news:
> > > > >
> > > > > I have  back all my Ceph machine?s OS to kernel  3.2.0-23, which Ubuntu 12.04 use.
> > > > > I run dd command (dd if=/dev/zero bs=1M count=60000 of=/dev/rbd${i} & )on Ceph client to create data prepare test at last night.
> > > > > Now, I have one machine down (can?t be reached by ping), another two machine has all OSD daemon down, while the three left has some daemon down.
> > > > >
> > > > > I have many warnings in OSD log like this:
> > > > >
> > > > > no flag points reached
> > > > > 2013-01-15 19:14:22.769898 7f20a2d57700  0 log [WRN] : slow 
> > > > > request
> > > > > 52.218106 seconds old, received at 2013-01-15 19:13:30.551718: 
> > > > > osd_op(client.10674.1:1002417 rb.0.27a8.6b8b4567.000000000eba 
> > > > > [write 3145728~524288] 2.c61810ee RETRY) currently waiting for 
> > > > > sub ops
> > > > > 2013-01-15 19:14:23.770077 7f20a2d57700  0 log [WRN] : 21 slow 
> > > > > requests, 6 included below; oldest blocked for > 1132.138983 
> > > > > secs
> > > > > 2013-01-15 19:14:23.770086 7f20a2d57700  0 log [WRN] : slow 
> > > > > request
> > > > > 53.216404 seconds old, received at 2013-01-15 19:13:30.553616: 
> > > > > osd_op(client.10671.1:1066860 rb.0.282c.6b8b4567.000000001057 
> > > > > [write 2621440~524288] 2.ea7acebc) currently waiting for sub ops
> > > > > 2013-01-15 19:14:23.770096 7f20a2d57700  0 log [WRN] : slow 
> > > > > request
> > > > > 51.442032 seconds old, received at 2013-01-15 19:13:32.327988: 
> > > > > osd_op(client.10674.1:1002418
> > > > >
> > > > > Similar info in dmesg we have saw pervious:
> > > > >
> > > > > [21199.036476] INFO: task ceph-osd:7788 blocked for more than 120 seconds.
> > > > > [21199.037493] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > > [21199.038841] ceph-osd        D 0000000000000006     0  7788      1 0x00000000
> > > > > [21199.038844]  ffff880fefdafcc8 0000000000000086 
> > > > > 0000000000000000
> > > > > ffffffffffffffe0 [21199.038848]  ffff880fefdaffd8 
> > > > > ffff880fefdaffd8
> > > > > ffff880fefdaffd8 0000000000013780 [21199.038852]  
> > > > > ffff88081aa58000
> > > > > ffff880f68f52de0 ffff880f68f52de0 ffff882017556200 [21199.038856] Call Trace:
> > > > > [21199.038858]  [<ffffffff8165a55f>] schedule+0x3f/0x60 
> > > > > [21199.038861]  [<ffffffff8106b7e5>] exit_mm+0x85/0x130 
> > > > > [21199.038864]  [<ffffffff8106b9fe>] do_exit+0x16e/0x420 
> > > > > [21199.038866]  [<ffffffff8109d88f>] ? __unqueue_futex+0x3f/0x80 
> > > > > [21199.038869]  [<ffffffff8107a19a>] ? 
> > > > > __dequeue_signal+0x6a/0xb0 [21199.038872]  [<ffffffff8106be54>] 
> > > > > do_group_exit+0x44/0xa0 [21199.038874]  [<ffffffff8107ccdc>]
> > > > > get_signal_to_deliver+0x21c/0x420 [21199.038877] 
> > > > > [<ffffffff81013865>] do_signal+0x45/0x130 [21199.038880] 
> > > > > [<ffffffff810a091c>] ? do_futex+0x7c/0x1b0 [21199.038882] 
> > > > > [<ffffffff810a0b5a>] ? sys_futex+0x10a/0x1a0 [21199.038885] 
> > > > > [<ffffffff81013b15>] do_notify_resume+0x65/0x80 [21199.038887] 
> > > > > [<ffffffff81664d50>] int_signal+0x12/0x17
> > > 
> > > We have seen this stack trace several times over the past 6 months, but are not sure what the trigger is.  In principle, the ceph server-side daemons shouldn't be capable of locking up like this, but clearly something is amiss between what they are doing in userland and how the kernel is tolerating that.  Low memory, perhaps?  In each case where we tried to track it down, the problem seemed to go away on its own.  Is this easily reproducible in your case?
> > > 
> > > > my 0.02$:
> > > > http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg11531.ht
> > > > ml and kernel panic from two different hosts from yesterday during 
> > > > ceph startup(on 3.8-rc3, images from console available at
> > > > http://imgur.com/wIRVn,k0QCS#0) leads to suggestion that Ceph may 
> > > > have been introduced lockup-alike behavior not a long ago, 
> > > > causing, in my case, excessive amount of context switches on the 
> > > > host leading to osd flaps and panic at the ip-ib stack due to same issue.
> > > 
> > > For the stack trace my first guess would be a problem with the IB driver that is triggered by memory pressure.  Can you characterize what the system utilization (CPU, memory) looks like leading up to the lockup?
> > > 
> > > sage
> > > 
> > 
> 
