From: Sage Weil <sweil@redhat.com>
Subject: Re: [GSoC2016] BlueStore SMR Support
Date: Fri, 11 Mar 2016 09:50:06 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603110942520.14377@cpach.fuggernut.com>
References: <CAPLK-i83vpHT7CwoczKULwpvJ+-eMLdhxWUy6YwyE0wj27kiOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33942 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119AbcCKOu1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Mar 2016 09:50:27 -0500
In-Reply-To: <CAPLK-i83vpHT7CwoczKULwpvJ+-eMLdhxWUy6YwyE0wj27kiOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Shehbaz,

Sorry for the slow reply!  I'm just catching up on GSoC queries.

On Fri, 4 Mar 2016, Shehbaz Jaffer wrote:
> Hi All,
> 
> I am a 1st Year PhD student at University of Toronto. I am interested
> in working on the SMR friendly allocator for Bluestore file system. I
> am new to Ceph. But I am familiar with FS development in user space, and
> SMR drives. I am currently going through Ceph codebase.
> It looks like the allocator is very basic, hence the current name of
> the block allocator:
> os/bluestore/StupidAllocator.cc :-)

:)

> Few initial questions:
> 
> 1) Will the project involve Drive managed SMR drives or Host Managed SMR 
> drives?

The goal is to make an allocator that will work with host managed SMR.  
Presumably that will work just as well on host-aware SMR.

A drive-managed SMR disk that doesn't tell us the zone layout is a bit of 
a lost cause, I think.

> 2) Will scope of project be to build an allocator on a simulator for
> SMR Drives? Or will I get actual HDDs to work with? In case of
> simulators, will the project involve building a simulator on disksim?

I seem to remember hearing something about a dm module that simulated SMR, 
but I'm not sure.  We may also be able to get some SMR disks to play 
with--I'll reach out to our drive vendor friends.

> 3) Ideally, the benchmark should be to compare StupidAllocator scheme
> with a SmartAllocator scheme in terms of the following performance
> metrics:
> a) speed
> b) correctness
> c) fragmentation
> d) garbage collection efficiency
> 
> are there any other metrics that we would like to measure the allocator for?

That sounds about right, (b) being the first and most important step.

Our only big idea here so far is that we probably want to put writes for 
each PG in a distinct zone, as I suspect PG is thing we have that is most 
closely correlated to object lifetime (because when the cluster does a 
rebalance or repair, and entire PG's worth of objects will typically get 
moved around).  That might mean a lot of open zones, though, and mean lots 
of seeks on writes if new objects are randomly spread across PGs (as they 
generally will be).  So we should probably explore other strategies as 
well.

> Thanks and I look forward to working on this project. Please feel free
> to send out your comments/suggestions.

Great!
sage
