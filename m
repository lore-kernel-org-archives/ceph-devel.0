From: Sage Weil <sage@newdream.net>
Subject: Re: OSD scalability & thread stacksize
Date: Thu, 1 Jul 2010 07:51:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007010724060.5822@cobra.newdream.net>
References: <AANLkTilDYesH_4FFEPUdLGvQRoZcW99czwfGru44RW3i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48205 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab0GAOu0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jul 2010 10:50:26 -0400
In-Reply-To: <AANLkTilDYesH_4FFEPUdLGvQRoZcW99czwfGru44RW3i@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul <paul_chiang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

Hi Paul,

On Thu, 1 Jul 2010, Paul wrote:
> Follow up on the discussion on IRC late last night:
> 
> On x86_64 2.6 kernels, pthread_create seems to allocate by default
> 8196KB stack size for the newly created thread. Since there can be
> potentially a large number of SimpleMessenger::Pipe instances (for
> example, when there are many OSDs and they need to heartbeat each
> other) and each instance has a reader and writer thread, a system can
> quickly run out of available memory to create new threads.

This is surprising to me.  My understanding is that each thread is 
allocated a big chunk of _virtual_ memory for its stack, but no physical 
pages are allocated until that memory is actually touched.  That, at 
least, is what I take away from e.g.

http://www.kegel.com/stackcheck/

Also, looking at the memory map for a random cmon process, I see the 8MB 
stack, but Rss is only 8 KB:

$ cat /proc/$pid/smaps
[...]
7f18b27fe000-7f18b2ffe000 rw-p 00000000 00:00 0 
Size:               8192 kB
Rss:                   8 kB
Pss:                   8 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         8 kB
Referenced:            8 kB
Swap:                  0 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
7f18b2ffe000-7f18b2fff000 ---p 00000000 00:00 0 
Size:                  4 kB
Rss:                   0 kB
Pss:                   0 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            0 kB
Swap:                  0 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB

Do you see a large Rss in your environment?  Maybe it's a library behavior 
thing?

Or maybe the problem is just that the virtual memory reserved for thread 
stacks is exhausted.  Maybe there is some way to make the process 
initialization reserve a larger area of memory for thread stacks?

> A short term solution would be to decrease the amount of stack space
> allocated for the reader and writer threads. I guess something along
> the lines of:
> http://github.com/tcloud/ceph/commit/39ffa236f3de2082c475a5ea5edc8afa09941bd6
> and
> http://github.com/tcloud/ceph/commit/1dbd42a5c4b064c581ddc152d41b9553f346df8a

This seems reasonable as a workaround.

> Yehudasa suggested a stacksize of 512KB, and it seems to work fine.

Looking at the Rss value for stack threads in /proc/$pid/smaps would be a 
pretty good way to see what kind of stack utilization those threads are 
seeing.  I suspect something much smaller than 512KB would be safe (16 
KB?).  

> However, as the cluster grows, there will eventually be some point
> where we hit a hard limit on either the number of concurrent threads
> or the number of concurrent tcp connections. Is it possible to
> redesign SimpleMessenger and/or the heartbeat mechanism so that only a
> constant number of connections are established?

Well, the number of peers an OSD has is generally bounded (it's related to 
the number of PGs each OSD gets).  The number of clients is not, though.  
The messenger should put the Pipes in some sort of LRU so that it can 
close out old, idle connections.  For the MDS the connection state needs 
to stick around, but it shouldn't be hard to make the reader/writer 
threads stop when it goes into a STANDBY state (if they don't already).

Adding a hard limit is also doable, although I would worry about that just 
slowing things down in large clusters when peers keep having to reconnect.

sage
