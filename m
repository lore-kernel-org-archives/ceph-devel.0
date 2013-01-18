From: Sage Weil <sage@inktank.com>
Subject: Re: Hit suicide timeout after adding new osd
Date: Fri, 18 Jan 2013 13:28:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50042 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab3ARV2a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 16:28:30 -0500
In-Reply-To: <50F930EE.9070201@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 18 Jan 2013, Jens Kristian S?gaard wrote:
> Hi Sage,
> 
> > Unfortunately I can't see what the thread gets stuck doing after it stops
> > doing work (at an apparently normal point).  Is there any chance you can
> > attach to it with gdb as soon as the log slows down and the initial timeout
> > messages appear?  Or check the core file and see what thread 7fd8c1ff3700 is
> > up to?
> 
> Here's the info from the core file:
> 
> (gdb) thread 45
> [Switching to thread 45 (Thread 0x7fd8c1ff3700 (LWP 995))]
> #0  0x000000360de0acb4 in pthread_rwlock_rdlock () from /lib64/libpthread.so.0
> 
> (gdb) bt
> #0  0x000000360de0acb4 in pthread_rwlock_rdlock () from /lib64/libpthread.so.0
> #1  0x00000000006e34a9 in RWLock::get_read (this=0x1aa54c8) at
> common/RWLock.h:51
> #2  0x00000000006a0857 in OSD::queue_want_up_thru (this=this@entry=0x1aa44f0,
> want=want@entry=460) at osd/OSD.cc:2585
> Python Exception <type 'exceptions.IndexError'> list index out of range:
> #3  0x00000000006ce175 in OSD::process_peering_events (this=0x1aa44f0,
> pgs=std::list) at osd/OSD.cc:6193
> Python Exception <type 'exceptions.IndexError'> list index out of range:
> #4  0x0000000000709617 in OSD::PeeringWQ::_process (this=<optimized out>,
> pgs=std::list) at osd/OSD.h:718
> #5  0x00000000008cbefc in ThreadPool::worker (this=0x1aa4938, wt=0x3c539a0) at
> common/WorkQueue.cc:113
> #6  0x00000000008cce70 in ThreadPool::WorkThread::entry (this=<optimized out>)
> at common/WorkQueue.h:288
> #7  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
> #8  0x000000360d6f167d in clone () from /lib64/libc.so.6

Getting closer.. it looks like someone is blocked with map_lock held, or 
leaked the lock.  Can you do a 'thread apply all bt' with that same core 
file/process?

sage


> 
> 
> Does this help?
> 
> -- 
> Jens Kristian S?gaard, Mermaid Consulting ApS,
> jens@mermaidconsulting.dk,
> http://www.mermaidconsulting.com/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
