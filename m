From: Sage Weil <sage@newdream.net>
Subject: Re: Logging braindump
Date: Thu, 22 Mar 2012 04:26:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203220356270.15882@cobra.newdream.net>
References: <CAORUGqCqK0WUEGiXyM+6KYfWswPrW_eV=qp8Q2CCAUSXguYdDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52255 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041Ab2CVL0x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 07:26:53 -0400
In-Reply-To: <CAORUGqCqK0WUEGiXyM+6KYfWswPrW_eV=qp8Q2CCAUSXguYdDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is well-timed.. I just started playing with this code on the flight 
over here.  

There are a couple pieces to what I've done so far:

 - clearly segmented logging code into a new set of classes in src/log, 
   without dependencies on everything else
 - set up config infrastructure to control 'log' and 'gather' levels for 
   different subsystems, where gather controls what messages are 
   generated, and log controls which of those reach disk (in non-crash 
   situation)
 - made a relatively naive implementation that works (messages on heap, 
   separate thread to write out, dump recent history on crash).
 - a lot of the weird interaction/bootstrapping stuff with contexts and 
   config now go away entirely if we just rely on cerr for errors during
   config parsing, etc. (like that simple spinlock Greg was complaining 
   about).

> MY RECOMMENDATIONS [biased, as always ;-]
> 
> - bundle the MessagePack library

I'm worried about requiring tools to read logs.  And I think most of the 
current overhead is the sync writes (which are easily addressed).  But 
string serialization is also a significant chunk, I think, so this may be 
worth it... need to do some real tests.

> - in thread that calls log: serialize as MessagePack onto stack,
> allocate needed bytes from ringbuffer, copy event to ringbuffer
> - write to disk is now very simple, could even be done in a different
> process (mmap header+ringbuffer)

My naive implementation puts entries on heap and links them into a list: 
can't easily extract from a core, but otherwise equivalent to a ring of 
pointers.  My limited tests showed std::string assignment had a huge 
overhead, though, so I suspect writing a stringbuf implementation that 
writes into cheaply preallocated buffers (maybe allocated off a large 
preallocated ring buffer), optimized for common case (40-80 byte message).  
But I need to read more of the Disruptor stuff to see what exactly they're 
doing and why.

In any case, the new structure makes it easier to test implementations 
given things are better contained.

> - let disk files be named after timestamp they were started at, start
> new ones based on time & size (no .0 -> .1 -> .2 renaming needed)
> - make it really simple to process+delete chunks of log, feeding them
> into Brisk or Graylog, then deleting from the node (perhaps after a
> delay, so last 24h is locally browseable)
>   (and don't remove things that haven't been processed)

Currently that's done with rename, sighup, wait for new log to 
appear, then process+delete.  Are there problems there that make it worth 
taking a non-standard approach to the log file naming?


Anyway, pushing what I have now to wip-log.  The exposed interface is just 
the macro in common/dout.h now.  Alternative approaches will probably 
change log/Entry.h and probably the allocation steps, but otherwise be 
pretty simple to swap in/out. 

The main piece that is sitll missing is an interface for logging 
structured content.  I suspect the way to do that is by putting stuff in 
the ostream stream (ala std::setiosflags(foo) and their ilk) so that you 
can easily stick key/value pairs in th code (... << log::kv("foo", "bar") 
<< ... or something)?  Hopefully that can reduce to something efficient, 
at least, so we don't have to replace the current dout logging sites with 
something completely different.

sage
