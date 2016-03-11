From: Sage Weil <sage@newdream.net>
Subject: Re: Greetings Ceph Community : GSOC Queries
Date: Fri, 11 Mar 2016 09:34:42 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603110929380.14377@cpach.fuggernut.com>
References: <CAJXHLwDGYDy27XS7h0KwCJjC0tzEma9EFkiyJoOz6xS9D+2XMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34259 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932102AbcCKOfF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2016 09:35:05 -0500
In-Reply-To: <CAJXHLwDGYDy27XS7h0KwCJjC0tzEma9EFkiyJoOz6xS9D+2XMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vineet Purswani <vineetcse813@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Vineet,

On Wed, 9 Mar 2016, Vineet Purswani wrote:
> Greetings Ceph Community,
> 
> My name is Vineet Purswani and I am a fourth year Computer Science
> MTech Integrated student at IIT Kanpur, India. I am interested in
> knowing more about a project listed on Ceph GSOC ideas page -
> Implement cache layer on top of userspace nvme driver

This project relates to using the new BlueStore OSD backend on NVMe 
devices with the SPDK kernel-bypass library.  When we use the kernel 
block device (with normal HDDs, SSDs, or even NVMe without the SPDK 
driver) we can just do buffered reads and writes from the block device 
(i.e., not use O_DIRECT) and the kernel will cache things for us.  SPDK 
doesn't have a cache, though, and in a few places in BlueStore we reply 
on that cache.

The goal of this project is to build a very efficient cache layer that we 
can use in certain cases on top of the SPDK device.  The interface in 
question is os/bluestore/BlockDevice.h (that's the abstract interface), 
and the SPDK implementation of it is NVMEDevice.h.  For refernce the 
KernelDevice.h is there too, although there isn't much to see there, 
except that there are two read/write paths.. one that uses an O_DIRECT fd 
with aio, and one that does normal buffered reads and writes.

There is a performance-tuned bit of caching code in the tree at 
os/memstore/PageSet.h that might be a useful starting point, although it 
almost certainly needs to be adapted to be useful here.

sage


> I have a great interest in Computer Systems, specifically operating
> systems, computer architecture and cloud computing. I did a project on
> compiler design, wherein I developed a Java compiler in python using
> PLY library. I have worked on NACHOS to test some of the scheduling
> algorithms, demand paging techniques, implemented condition variables
> and semaphores. I did an architecture project to get my hands on over
> cache hierarchy techniques and branch & target predictors. I am
> currently working on computer security projects, wherein I have done
> control hijacking, privilege separation, learnt about several symbolic
> execution techniques like DART, KLEE & EXE. I have a basic knowledge
> of compiler design, databases, functional programming, machine
> learning and computer security as well. You can find my work here:
> https://github.com/vineetpurswani
> 
> Kindly guide me as to how do I start working on this idea? Which bug
> fix/enhancement should I work on? Expectations in proposal?
> 
> Kindly share any details that you would like to share or any questions
> that you may have for me regarding this GSOC project.
> 
> Let me know what you think. Thanks a lot.
> 
> Yours Sincerely
> Vineet Purswani
> IIT Kanpur
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
