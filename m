From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Ceph slow request & unstable issue
Date: Thu, 17 Jan 2013 01:06:32 +0300
Message-ID: <CABYiri87N-Mt+wqBxU7M0aHtTZxk0Pi04mDRBDhNvu0-raSMOA@mail.gmail.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC5DCC63@SHSMSX102.ccr.corp.intel.com>
 <CABYiri_50ijzfm1y-ryNULXq8DDNUWghrBaQBfzBkspzjpZx1A@mail.gmail.com>
 <alpine.DEB.2.00.1301160854170.15921@cobra.newdream.net> <CABYiri8za+nNOMEf9WKtE_Zsj-Z2YGvp8tRzbGiBDPBVaXEwYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:54114 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab3APWGx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 17:06:53 -0500
Received: by mail-oa0-f49.google.com with SMTP id l10so2005002oag.36
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 14:06:53 -0800 (PST)
In-Reply-To: <CABYiri8za+nNOMEf9WKtE_Zsj-Z2YGvp8tRzbGiBDPBVaXEwYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 16, 2013 at 10:35 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
> On Wed, Jan 16, 2013 at 8:58 PM, Sage Weil <sage@inktank.com> wrote:
>> Hi,
>>
>> On Wed, 16 Jan 2013, Andrey Korolyov wrote:
>>> On Wed, Jan 16, 2013 at 4:58 AM, Chen, Xiaoxi <xiaoxi.chen@intel.com> wrote:
>>> > Hi list,
>>> >         We are suffering from OSD or OS down when there is continuing high pressure on the Ceph rack.
>>> >         Basically we are on Ubuntu 12.04+ Ceph 0.56.1, 6 nodes, in each nodes with 20 * spindles + 4* SSDs as journal.(120 spindles in total)
>>> >         We create a lots of RBD volumes (say 240),mounting to 16 different client machines ( 15 RBD Volumes/ client) and running DD concurrently on top of each RBD.
>>> >
>>> >         The issues are:
>>> > 1. Slow requests
>>> > ??From the list-archive it seems solved in 0.56.1 but we still notice such warning
>>> > 2. OSD Down or even host down
>>> > Like the message below.Seems some OSD has been blocking there for quite a long time.
>>> >
>>> >         Suggestions are highly appreciate.Thanks
>>> >                                                                                                                                                                         Xiaoxi
>>> >
>>> > _____________________________________________
>>> >
>>> > Bad news:
>>> >
>>> > I have  back all my Ceph machine?s OS to kernel  3.2.0-23, which Ubuntu 12.04 use.
>>> > I run dd command (dd if=/dev/zero bs=1M count=60000 of=/dev/rbd${i} & )on Ceph client to create data prepare test at last night.
>>> > Now, I have one machine down (can?t be reached by ping), another two machine has all OSD daemon down, while the three left has some daemon down.
>>> >
>>> > I have many warnings in OSD log like this:
>>> >
>>> > no flag points reached
>>> > 2013-01-15 19:14:22.769898 7f20a2d57700  0 log [WRN] : slow request 52.218106 seconds old, received at 2013-01-15 19:13:30.551718: osd_op(client.10674.1:1002417 rb.0.27a8.6b8b4567.000000000eba [write 3145728~524288] 2.c61810ee RETRY) currently waiting for sub ops
>>> > 2013-01-15 19:14:23.770077 7f20a2d57700  0 log [WRN] : 21 slow requests, 6 included below; oldest blocked for > 1132.138983 secs
>>> > 2013-01-15 19:14:23.770086 7f20a2d57700  0 log [WRN] : slow request 53.216404 seconds old, received at 2013-01-15 19:13:30.553616: osd_op(client.10671.1:1066860 rb.0.282c.6b8b4567.000000001057 [write 2621440~524288] 2.ea7acebc) currently waiting for sub ops
>>> > 2013-01-15 19:14:23.770096 7f20a2d57700  0 log [WRN] : slow request 51.442032 seconds old, received at 2013-01-15 19:13:32.327988: osd_op(client.10674.1:1002418
>>> >
>>> > Similar info in dmesg we have saw pervious:
>>> >
>>> > [21199.036476] INFO: task ceph-osd:7788 blocked for more than 120 seconds.
>>> > [21199.037493] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>> > [21199.038841] ceph-osd        D 0000000000000006     0  7788      1 0x00000000
>>> > [21199.038844]  ffff880fefdafcc8 0000000000000086 0000000000000000 ffffffffffffffe0
>>> > [21199.038848]  ffff880fefdaffd8 ffff880fefdaffd8 ffff880fefdaffd8 0000000000013780
>>> > [21199.038852]  ffff88081aa58000 ffff880f68f52de0 ffff880f68f52de0 ffff882017556200
>>> > [21199.038856] Call Trace:
>>> > [21199.038858]  [<ffffffff8165a55f>] schedule+0x3f/0x60
>>> > [21199.038861]  [<ffffffff8106b7e5>] exit_mm+0x85/0x130
>>> > [21199.038864]  [<ffffffff8106b9fe>] do_exit+0x16e/0x420
>>> > [21199.038866]  [<ffffffff8109d88f>] ? __unqueue_futex+0x3f/0x80
>>> > [21199.038869]  [<ffffffff8107a19a>] ? __dequeue_signal+0x6a/0xb0
>>> > [21199.038872]  [<ffffffff8106be54>] do_group_exit+0x44/0xa0
>>> > [21199.038874]  [<ffffffff8107ccdc>] get_signal_to_deliver+0x21c/0x420
>>> > [21199.038877]  [<ffffffff81013865>] do_signal+0x45/0x130
>>> > [21199.038880]  [<ffffffff810a091c>] ? do_futex+0x7c/0x1b0
>>> > [21199.038882]  [<ffffffff810a0b5a>] ? sys_futex+0x10a/0x1a0
>>> > [21199.038885]  [<ffffffff81013b15>] do_notify_resume+0x65/0x80
>>> > [21199.038887]  [<ffffffff81664d50>] int_signal+0x12/0x17
>>
>> We have seen this stack trace several times over the past 6 months, but
>> are not sure what the trigger is.  In principle, the ceph server-side
>> daemons shouldn't be capable of locking up like this, but clearly
>> something is amiss between what they are doing in userland and how the
>> kernel is tolerating that.  Low memory, perhaps?  In each case where we
>> tried to track it down, the problem seemed to go away on its own.  Is this
>> easily reproducible in your case?
>>
>>> my 0.02$:
>>> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg11531.html
>>> and kernel panic from two different hosts from yesterday during ceph
>>> startup(on 3.8-rc3, images from console available at
>>> http://imgur.com/wIRVn,k0QCS#0) leads to suggestion that Ceph may have
>>> been introduced lockup-alike behavior not a long ago, causing, in my
>>> case, excessive amount of context switches on the host leading to osd
>>> flaps and panic at the ip-ib stack due to same issue.
>>
>> For the stack trace my first guess would be a problem with the IB driver
>> that is triggered by memory pressure.  Can you characterize what the
>> system utilization (CPU, memory) looks like leading up to the lockup?
>>
>
> Yep, residing of cpu-hungry VM on same node raising the probability of
> lockup times up, but there was very small cpu times anyway, one or two
> of 24 HT cores to VM an some percents, even less than core, to osd
> processes, real la not more than 1.5. Physical memory commit also was
> very low(GB or two on 64G node), except virtual memory _may_ have been
> in fact overcommited on very selected nodes and on small percentage of
> all cases of these lockups (since I`m aware only of RSS commit and do
> not limit virtual commit amount at all). All systems has no swap and
> swappiness set to 5.

Some update - 3.2 was able to stay some longer, but one node has stuck
in the I/O and osd processes on it died leaving meaningless backtrace.
I have pushed cluster to the limit for three hours and it stayed well,
doing both intensive writes and snapshot creation (<tnt> mentioned
same issue with softlockups in the IRC today). Just to be clear, panic
above happens only with 3.8, not with earlier kernels. I`ll very
appreciate for any suggestions on additional profiling.

Thanks!
