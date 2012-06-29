From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Fri, 29 Jun 2012 06:49:33 -0500
Message-ID: <4FED964D.3080201@inktank.com>
References: <4FED8792.1090905@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50404 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754Ab2F2Ltj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 07:49:39 -0400
Received: by yenl2 with SMTP id l2so2586093yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jun 2012 04:49:39 -0700 (PDT)
In-Reply-To: <4FED8792.1090905@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 6/29/12 5:46 AM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> i've made some further testing and have the problem that ceph doesn't
> scale for me. I added a 4th osd server to my existing 3 node osd
> cluster. I also reformated all to be able to start with a clean system.
>
> While doing random 4k writes from two VMs i see about 8% idle on the osd
> servers (Single Intel Xeon E5 8 cores 3,6Ghz). I believe that this is
> the limiting factor and also the reason why i don't see any improvement
> by adding osd servers.
>
> 3 nodes: 2VMS: 7000 IOp/s 4k writes osds: 7-15% idle
> 4 nodes: 2VMS: 7500 IOp/s 4k writes osds: 7-15% idle
>
> Even the cpu is not the limiting factor i think it would be really
> important to lower the CPU usage while doing 4k writes. The CPU is only
> used by the ceph-osd process. I see nearly no usage by other processes
> (only 5% by kworker and 5% flush).
>
> Could somebody recommand me a way to debug this? So we know where all
> this CPU usage goes?

Hi Stefan,

I'll try to replicate your findings in house.  I've got some other 
things I have to do today, but hopefully I can take a look next week. 
If I recall correctly, in the other thread you said that sequential 
writes are using much less CPU time on your systems?  Do you see better 
scaling in that case?

To figure out where CPU is being used, you could try various options: 
oprofile, perf, valgrind, strace.  Each has it's own advantages.

Here's how you can create a simple callgraph with perf:

http://lwn.net/Articles/340010/

A more general tutorial is here:

https://perf.wiki.kernel.org/index.php/Tutorial

Mark
