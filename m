From: Sage Weil <sage@newdream.net>
Subject: Re: Logging braindump
Date: Thu, 22 Mar 2012 13:32:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203221311470.25117@cobra.newdream.net>
References: <CAORUGqCqK0WUEGiXyM+6KYfWswPrW_eV=qp8Q2CCAUSXguYdDA@mail.gmail.com>
 <CA+qbEUPQcVqmUgNYXu6+U4+QCUjxsSkq9pVQ98=Es8rKscT12Q@mail.gmail.com>
 <4F6B6CB0.1000400@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54756 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab2CVUcp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 16:32:45 -0400
In-Reply-To: <4F6B6CB0.1000400@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <Mark.Kampe@dreamhost.com>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 22 Mar 2012, Mark Kampe wrote:
> On 03/22/12 09:38, Colin McCabe wrote:
> > On Mon, Mar 19, 2012 at 1:53 PM, Tommi Virtanen
> > <tommi.virtanen@dreamhost.com>  wrote:
> > > [mmap'ed buffer discussion]
> > 
> > I always thought mmap'ed circular buffers were an elegant approach for
> > getting data that survived a process crash, but not paying the
> > overhead of write(2) and read(2).  The main problem is that you need
> > special tools to read the circular buffer files off of the disk.  As
> > Sage commented, that is probably undesirable for many users.
> 
> (a) I actually favor not simply mmaping the circular buffer,
>     but having a program that pulls the data out of memory
>     and writes it to disk (ala Varnish).  In addition to doing
>     huge writes (greatly reducing the write overhead), it can
>     filter what it processes, so that we have extensive logging
>     for the last few seconds, and more manageable logs on disk
>     extending farther back in time (modulo log rotation).

The code in wip-log does this (dumps high level messages unless/until 
there is a reason to dump it all).  Well, more importantly, it sets up the 
infrastructure to control those logging levels (the actually logging code 
is very short and simple).  I don't see the value in putting this in a 
separate process, though (as opposed to a separate thread); that just 
seems like it would complicate ops...

> (b) The most interesting logs are probably the ones in coredumps
>     (that didn't make it out to disk) for which we want a
>     crawler/extractor anyway.  It probably isn't very hard to
>     make the program that extracts logs from memory also be
>     able to pick the pockets of dead bodies (put a big self
>     identifying header on the front of each buffer).
> 
>     Note also that having the ability to extract the logs from
>     a coredump pretty much eliminates any motivations to flush
>     log entries out to disk promptly/expensively.  If the process
>     exits clealy, we'll get the logs.  If the process produces
>     a coredump, we'll still get the logs.

This mostly seems like an argument to keep the in-memory layout simple, to 
keep the post-mortem code simple.  But at worst it's a 
complexity/performance tradeoff... and, if we're lucky, there's no 
difficult choice to make.  Honestly, I don't think the overhead is where 
we think it is.  But need to do some real testing to see.

> (c) I have always loved text logs that I can directly view.
>     Their immediate and effortless accessibility encourages
>     their use, which encourages work in optimizing their content
>     (lots of the stuff you need, and little else).
> 
>     But binary logs are less than half the size (cheaper to
>     take and keep twice as much info), and a program that
>     formats them can take arguments about which records/fields
>     you want and how you want them formatted ... and getting
>     the output the way you want it (whether for browsing or
>     subsequent reprocessing) is a huge win.  You get used to
>     running the log processing command quickly, but the benefits
> 
> (d) If somebody really wants text logs for archival, it is completely
>     trivial to run the output of the log-extractor through the
>     formatter before writing it to disk ... so the in memory
>     format need not be tied to the on-disk format.  The rotation
>     code won't care.

Yeah.  My hope is that we can find some way that makes structure 
logging/annotation easy that is an easy transition from the current stuff.  
We'll see.  It may just be dout(n) << string vs dlog(n) << something 
structured.. but we'll see.

> > An mmap'ed buffer, even a lockless one, is a simple beast.  Do you
> > really need a whole library just for that?  Maybe I'm just
> > old-fashioned.
> 
> IMHO, surprisingly few things involving large numbers of performance
> critical threads turn out to be simple :-)  For example:
> 
> 	If we are logging a lot, buffer management has the potential
> 	to become a bottle-neck ... so we need to be able to allocate
> 	a record of the required size from the circular buffer
> 	with atomic instructions (at least in non-wrap situations).
> 
> 	But if records are allocated and then filled, we have to
> 	consider how to handle the case where the filling is
>         delayed, and the reader catches up with an incomplete
> 	log record (e.g. skip it, wait how long, ???).
> 
> 	And while we hope this will never happen, we have to deal
> 	with what happens when the writer catches up with the
> 	reader, or worse, an incomplete log block ... where we might
> 	have to determine whether or not the owner is deceased (making
> 	it safe to break his record lock) ... or should we simply take
> 	down the service at that point (on the assumption that something
> 	has gone very wrong).
> 
> 	If we are going to use multiple buffers, we may have to
> 	do a transaction dance (last guy in has to close this
> 	buffer to new writes, start a new one, and somebody has
> 	to wait for pending additions to complete, queue this
> 	one for delivery or perhaps even flush it to disk if we
> 	don't have some other thread/process doing this).

Honestly I don't think these will be too hard to solve, since we don't 
care about how quickly logged data is written out... but we'll see!  With 
disruptor, for instance, latency is king, but in our case it's only 
producer latency that matters, not consumer.

sage

