From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Fri, 29 Jun 2012 15:02:47 +0200
Message-ID: <4FEDA777.1060309@profihost.ag>
References: <4FED8792.1090905@profihost.ag> <4FED964D.3080201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53051 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579Ab2F2NCz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 09:02:55 -0400
In-Reply-To: <4FED964D.3080201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 29.06.2012 13:49, schrieb Mark Nelson:
> I'll try to replicate your findings in house.  I've got some other
> things I have to do today, but hopefully I can take a look next week. If
> I recall correctly, in the other thread you said that sequential writes
> are using much less CPU time on your systems?

Random 4k writes: 10% idle
Seq 4k writes: !! 99,7% !! idle
Seq 4M writes: 90% idle


 >  Do you see better scaling in that case?

3 osd nodes:
1 VM:
Rand 4k writes: 7000 iops
Seq 4k writes: 19900 iops

2 VMs:
Rand 4k writes: 6000 iops each
Seq 4k writes: 4000 iops each VM 1
Seq 4k writes: 18500 iops each VM 2


4 osd nodes:
1 VM:
Rand 4k writes: 14400 iops
Seq 4k writes: 19000 iops

2 VMs:
Rand 4k writes: 7000 iops each
Seq 4k writes: 18000 iops each



> To figure out where CPU is being used, you could try various options:
> oprofile, perf, valgrind, strace.  Each has it's own advantages.
>
> Here's how you can create a simple callgraph with perf:
>
> http://lwn.net/Articles/340010/
10s perf data output while doing random 4k writes:
https://raw.github.com/gist/2c16136faebec381ae35/09e6de68a5461a198430a9ec19dfd5392f276706/gistfile1.txt

Stefan
