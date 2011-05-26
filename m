From: Sage Weil <sage@newdream.net>
Subject: Re: rbd write rate
Date: Thu, 26 May 2011 09:42:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105260933550.3034@cobra.newdream.net>
References: <BANLkTimsL17LUHPg4F_TO5y3qnMcPeQOYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39437 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab1EZQkf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2011 12:40:35 -0400
In-Reply-To: <BANLkTimsL17LUHPg4F_TO5y3qnMcPeQOYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 26 May 2011, huang jun wrote:
> hi,all
> i have another rbd question,when i use rbd to wite a file to OSD
> my configuration is : 4 OSDs 1MON 1MDS,linux kernel version is 2.6.37.6
> and the average write rate is about 5MB/s.
> when i look into the log in /var/log/kernel.log, and find that the
> client get items from request_queue
> with the write size between 1 page and 31 pages.
> i think it results in the low write rate.am i right?

What are you using to measure throughput?

The request size is determined by something in the block layer above RBD; 
I typically see 128k reads/writes.  I'm not sure offhand if/how that is 
adjusted.

There is a larger problem with RBD performance in general that frequently 
comes up and we haven't had time to address.  Overall, read and write 
latency is comparable to that of a standard disk (although it can vary 
depending on the hardware you're using for the rados cluster).  On average 
RBD write latencies are probably a bit higher, although with the right 
hardware they can be much lower.  The big difference, though, is that a 
normal disk has a write cache of several megabytes and acknowledges writes 
before they are stable.  Modern sane file systems issue flush commands at 
critical points to ensure that previous writes really hit disk.  RBD does 
no such thing; every write goes all the way to disk (on all replicas) 
before it is acknowledges.  For many (most?) workloads this makes the 
storage appear very slow, even though the overall throughput may be much 
higher.

We think the solution is to make the rbd layer have some tunable that puts 
a cap on the number of written bytes that will be acknowledged before 
they are actually written, more or less simulating a write cache, and make 
it behave more like a disk.  There are open issues for this in teh tracker 
for both librbd (for qemu) and the kernel implementation, but we haven't 
had time to look at it yet.  Anyone on the list who is interested in this 
is more than welcome to take a stab at it!

sage

