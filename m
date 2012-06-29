From: Sage Weil <sage@inktank.com>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Fri, 29 Jun 2012 08:28:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206290819170.30691@cobra.newdream.net>
References: <4FED8792.1090905@profihost.ag> <4FED964D.3080201@inktank.com>
 <4FEDA777.1060309@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55352 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab2F2P3C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 11:29:02 -0400
In-Reply-To: <4FEDA777.1060309@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 29 Jun 2012, Stefan Priebe - Profihost AG wrote:
> Am 29.06.2012 13:49, schrieb Mark Nelson:
> > I'll try to replicate your findings in house.  I've got some other
> > things I have to do today, but hopefully I can take a look next week. If
> > I recall correctly, in the other thread you said that sequential writes
> > are using much less CPU time on your systems?
> 
> Random 4k writes: 10% idle
> Seq 4k writes: !! 99,7% !! idle
> Seq 4M writes: 90% idle

I take it 'rbd cache = true'?  It sounds like librbd (or the guest file 
system) is coalescing the sequential writes into big writes.  I'm a bit 
surprised that the 4k ones have lower CPU utilization, but there are lots 
of opportunity for noise there, so I wouldn't read too far into it yet.

> >  Do you see better scaling in that case?
> 
> 3 osd nodes:
> 1 VM:
> Rand 4k writes: 7000 iops
> Seq 4k writes: 19900 iops
> 
> 2 VMs:
> Rand 4k writes: 6000 iops each
> Seq 4k writes: 4000 iops each VM 1
> Seq 4k writes: 18500 iops each VM 2
> 
> 
> 4 osd nodes:
> 1 VM:
> Rand 4k writes: 14400 iops      <------ ????

Can you double-check this number?

> Seq 4k writes: 19000 iops
> 
> 2 VMs:
> Rand 4k writes: 7000 iops each
> Seq 4k writes: 18000 iops each

With the exception of that one number above, it really sounds like the 
bottleneck is in the client (VM or librbd+librados) and not in the 
cluster.  Performance won't improve when you add OSDs if the limiting 
factor is the clients ability to dispatch/stream/sustatin IOs.  That also 
seems concistent with the fact that limiting the # of CPUs on the OSDs 
doesn't affect much.

Aboe, with 2 VMs, for instance, your total iops for the cluster doubled 
(36000 total).  Can you try with 4 VMs and see if it continues to scale in 
that dimension?  At some point you will start to saturate the OSDs, and at 
that point adding more OSDs should show aggregate throughput going up.  

I think the typical way to approach this is to first scale the client side 
independently to get the iops-per-osd figure, then pick a reasonable ratio 
between the two, then scale both the client and server side proportional 
to make sure the load distribution and network infrastructure scales 
properly.

sage



> 
> 
> 
> > To figure out where CPU is being used, you could try various options:
> > oprofile, perf, valgrind, strace.  Each has it's own advantages.
> > 
> > Here's how you can create a simple callgraph with perf:
> > 
> > http://lwn.net/Articles/340010/
> 10s perf data output while doing random 4k writes:
> https://raw.github.com/gist/2c16136faebec381ae35/09e6de68a5461a198430a9ec19dfd5392f276706/gistfile1.txt
> 
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
