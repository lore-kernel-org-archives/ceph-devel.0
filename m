From: Milosz Tanski <milosz@adfin.com>
Subject: Re: 10/14/2014 Weekly Ceph Performance Meeting
Date: Thu, 23 Oct 2014 18:06:17 -0400
Message-ID: <CANP1eJGZVQ2Ssm2E1uZX7s+gbZ-bc08VCPXNpz17M+pVkaTxig@mail.gmail.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC020C8323@shsmsx102.ccr.corp.intel.com>
	<811a14ba-31af-49d2-bd37-841ebadbca23@mailpro>
	<6F3FA899187F0043BA1827A69DA2F7CC020C8403@shsmsx102.ccr.corp.intel.com>
	<alpine.DEB.2.00.1410231452250.29946@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:51395 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaJWWGS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 18:06:18 -0400
Received: by mail-lb0-f175.google.com with SMTP id u10so1632198lbd.34
        for <ceph-devel@vger.kernel.org>; Thu, 23 Oct 2014 15:06:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1410231452250.29946@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mark Nelson <mark.nelson@inktank.com>

On Thu, Oct 23, 2014 at 5:53 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 16 Oct 2014, Chen, Xiaoxi wrote:
>> >Hi, indeed qemu use a single thread per queue.
>> >I think it's not a problem with common storage (nfs,scsi,..) because they use less cpu ressource than librbd, so you can reach
>> >easily > 100000iops with 1thread.
>>
>> I think it's a common problem shared by all storage backend(nfs,scsi),
>> but Ceph take longer time to sent out an IO(30us), while NFS and scsi is
>> really simple(no crush, no stripping, etc) that may only take 3us to
>> send out an IO, so the upper bound is 10X than ceph.
>
> I would be very interested in seeing where the CPU time is actually spent.
> I know there are is some locking contention in librbd, but with the
> librados changes that layer at least should have have a much lower
> overhead.  We also should be preserving mappings for PGs in most cases to
> avoid much time spent in CRUSH.  It would be very interesting to be
> proven wrong, though!

Measuring both should be simple. pref is a really great at getting
these kinds of answers quickly. The CPU time part is pretty easy
measure so I'll skip that. And to measure contention you can have pref
watch for the sys:futex_enter tracepoint event. This way you measure
all the times a lock was content... and not only which lock but also
what code path.

Make sure you compile the application (or at very least the library)
without omit-frame pointer gcc flag (it's default on x86_64). And then
the perf command to do that is:

shell $ perf record -g -e syscalls:sys_exit_futex ./my_appname
shell $ perf report

You should have an answer to contention points at the end of your
test. I would offer to help more, but don't use RBD and have no
experience with those parts.

Make sure you're using a newish kernel / newish perf with support for
tracepoints, and you make sure you have the right permission to use
tracepoint events in perf.

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
