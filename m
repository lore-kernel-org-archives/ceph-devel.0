From: Sage Weil <sage@newdream.net>
Subject: Re: Logging braindump
Date: Tue, 27 Mar 2012 10:48:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203261613370.19530@cobra.newdream.net>
References: <CAORUGqCqK0WUEGiXyM+6KYfWswPrW_eV=qp8Q2CCAUSXguYdDA@mail.gmail.com>
 <CA+qbEUPQcVqmUgNYXu6+U4+QCUjxsSkq9pVQ98=Es8rKscT12Q@mail.gmail.com>
 <4F6B6CB0.1000400@dreamhost.com> <Pine.LNX.4.64.1203221311470.25117@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57365 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab2C0Rss (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 13:48:48 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 25B59BC795
	for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 10:48:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 00677BC795
	for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 10:48:45 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1203221311470.25117@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I did some rough benchmarking (N entries over M threads) on the current 
code vs wip-log2 (my naive implementation), which

 - allocates an Entry struct on the heap, with 80 chars preallocated
 - you write into a streambuf into that, overflowing into a std::string on 
   the heap
 - takes a mutex and adds it to a linked list

with an async thread to write it out.

For 1M lines, on a 16-core system, -O2, 

threads		old code	new (total)	new (queue)	no queue
1		4.7		~7.5		1.4		1.3
10		8.0		~8		1.54		1.0
16		7.8		~8		1.62		1.1
100		5.1		~8		1.75		1.34

A few notes:
 - The new (queue) is just the time to queue 1M events, and the total 
   includes a call to log.flush().  Normally that would happen in another 
   thread, of course, so it's only interesting as a rough measure of 
   "total work". 
 - Commenting out the mutex on submit_entry and one thread shaves off .1 
   seconds or so... about the same as the no 'queue case'.
 - Preallocating entries instead of calling new only saves about .1 
   seconds.
 - Using PreallocatedStreambuf instead of a ostringstream saves about .4 
   seconds in the single thread case (if we fit).
 - Overflowing the buffer takes about .1 seconds longer.. still better
   than the ostringstream.  It depends a bit on _how_ much we overflow,
   though.. it does powers of two over the original prealloc size, so we 
   may have to realloc multiple times.  This is probably what 
   ostringstream is doing anyway.

My thoughts:
 - I don't think we care too much about the concurrency issue (yet).
 - I think we only care about queuing time, since that is what slows down
   running code.  Having an async thread write to disk will incur some 
   background load, but in reality we won't be writing 1M records in 10 
   seconds.
 - That is especially true since we will probably collect lots of log data 
   that we never write.
 - Most of the work so far adds infrastructure to control dual log levels 
   and to clean up the logging interface, making it easy to implement
   different functionality.  I think it's worth merging as-is.
 - We'll want to tune the amount of space preallocated in each Entry.  

Missing pieces:
 - Need to throttle when writeout gets behind to cap total memory usage.

Pushing to wip-log branch for review.

sage



On Thu, 22 Mar 2012, Sage Weil wrote:

> On Thu, 22 Mar 2012, Mark Kampe wrote:
> > On 03/22/12 09:38, Colin McCabe wrote:
> > > On Mon, Mar 19, 2012 at 1:53 PM, Tommi Virtanen
> > > <tommi.virtanen@dreamhost.com>  wrote:
> > > > [mmap'ed buffer discussion]
> > > 
> > > I always thought mmap'ed circular buffers were an elegant approach for
> > > getting data that survived a process crash, but not paying the
> > > overhead of write(2) and read(2).  The main problem is that you need
> > > special tools to read the circular buffer files off of the disk.  As
> > > Sage commented, that is probably undesirable for many users.
> > 
> > (a) I actually favor not simply mmaping the circular buffer,
> >     but having a program that pulls the data out of memory
> >     and writes it to disk (ala Varnish).  In addition to doing
> >     huge writes (greatly reducing the write overhead), it can
> >     filter what it processes, so that we have extensive logging
> >     for the last few seconds, and more manageable logs on disk
> >     extending farther back in time (modulo log rotation).
> 
> The code in wip-log does this (dumps high level messages unless/until 
> there is a reason to dump it all).  Well, more importantly, it sets up the 
> infrastructure to control those logging levels (the actually logging code 
> is very short and simple).  I don't see the value in putting this in a 
> separate process, though (as opposed to a separate thread); that just 
> seems like it would complicate ops...
> 
> > (b) The most interesting logs are probably the ones in coredumps
> >     (that didn't make it out to disk) for which we want a
> >     crawler/extractor anyway.  It probably isn't very hard to
> >     make the program that extracts logs from memory also be
> >     able to pick the pockets of dead bodies (put a big self
> >     identifying header on the front of each buffer).
> > 
> >     Note also that having the ability to extract the logs from
> >     a coredump pretty much eliminates any motivations to flush
> >     log entries out to disk promptly/expensively.  If the process
> >     exits clealy, we'll get the logs.  If the process produces
> >     a coredump, we'll still get the logs.
> 
> This mostly seems like an argument to keep the in-memory layout simple, to 
> keep the post-mortem code simple.  But at worst it's a 
> complexity/performance tradeoff... and, if we're lucky, there's no 
> difficult choice to make.  Honestly, I don't think the overhead is where 
> we think it is.  But need to do some real testing to see.
> 
> > (c) I have always loved text logs that I can directly view.
> >     Their immediate and effortless accessibility encourages
> >     their use, which encourages work in optimizing their content
> >     (lots of the stuff you need, and little else).
> > 
> >     But binary logs are less than half the size (cheaper to
> >     take and keep twice as much info), and a program that
> >     formats them can take arguments about which records/fields
> >     you want and how you want them formatted ... and getting
> >     the output the way you want it (whether for browsing or
> >     subsequent reprocessing) is a huge win.  You get used to
> >     running the log processing command quickly, but the benefits
> > 
> > (d) If somebody really wants text logs for archival, it is completely
> >     trivial to run the output of the log-extractor through the
> >     formatter before writing it to disk ... so the in memory
> >     format need not be tied to the on-disk format.  The rotation
> >     code won't care.
> 
> Yeah.  My hope is that we can find some way that makes structure 
> logging/annotation easy that is an easy transition from the current stuff.  
> We'll see.  It may just be dout(n) << string vs dlog(n) << something 
> structured.. but we'll see.
> 
> > > An mmap'ed buffer, even a lockless one, is a simple beast.  Do you
> > > really need a whole library just for that?  Maybe I'm just
> > > old-fashioned.
> > 
> > IMHO, surprisingly few things involving large numbers of performance
> > critical threads turn out to be simple :-)  For example:
> > 
> > 	If we are logging a lot, buffer management has the potential
> > 	to become a bottle-neck ... so we need to be able to allocate
> > 	a record of the required size from the circular buffer
> > 	with atomic instructions (at least in non-wrap situations).
> > 
> > 	But if records are allocated and then filled, we have to
> > 	consider how to handle the case where the filling is
> >         delayed, and the reader catches up with an incomplete
> > 	log record (e.g. skip it, wait how long, ???).
> > 
> > 	And while we hope this will never happen, we have to deal
> > 	with what happens when the writer catches up with the
> > 	reader, or worse, an incomplete log block ... where we might
> > 	have to determine whether or not the owner is deceased (making
> > 	it safe to break his record lock) ... or should we simply take
> > 	down the service at that point (on the assumption that something
> > 	has gone very wrong).
> > 
> > 	If we are going to use multiple buffers, we may have to
> > 	do a transaction dance (last guy in has to close this
> > 	buffer to new writes, start a new one, and somebody has
> > 	to wait for pending additions to complete, queue this
> > 	one for delivery or perhaps even flush it to disk if we
> > 	don't have some other thread/process doing this).
> 
> Honestly I don't think these will be too hard to solve, since we don't 
> care about how quickly logged data is written out... but we'll see!  With 
> disruptor, for instance, latency is king, but in our case it's only 
> producer latency that matters, not consumer.
> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
