From: Mark Kampe <Mark.Kampe@dreamhost.com>
Subject: Re: Logging braindump
Date: Thu, 22 Mar 2012 11:17:20 -0700
Message-ID: <4F6B6CB0.1000400@dreamhost.com>
References: <CAORUGqCqK0WUEGiXyM+6KYfWswPrW_eV=qp8Q2CCAUSXguYdDA@mail.gmail.com> <CA+qbEUPQcVqmUgNYXu6+U4+QCUjxsSkq9pVQ98=Es8rKscT12Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48192 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab2CVSRV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 14:17:21 -0400
In-Reply-To: <CA+qbEUPQcVqmUgNYXu6+U4+QCUjxsSkq9pVQ98=Es8rKscT12Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 03/22/12 09:38, Colin McCabe wrote:
> On Mon, Mar 19, 2012 at 1:53 PM, Tommi Virtanen
> <tommi.virtanen@dreamhost.com>  wrote:
>> [mmap'ed buffer discussion]
>
> I always thought mmap'ed circular buffers were an elegant approach for
> getting data that survived a process crash, but not paying the
> overhead of write(2) and read(2).  The main problem is that you need
> special tools to read the circular buffer files off of the disk.  As
> Sage commented, that is probably undesirable for many users.

(a) I actually favor not simply mmaping the circular buffer,
     but having a program that pulls the data out of memory
     and writes it to disk (ala Varnish).  In addition to doing
     huge writes (greatly reducing the write overhead), it can
     filter what it processes, so that we have extensive logging
     for the last few seconds, and more manageable logs on disk
     extending farther back in time (modulo log rotation).

(b) The most interesting logs are probably the ones in coredumps
     (that didn't make it out to disk) for which we want a
     crawler/extractor anyway.  It probably isn't very hard to
     make the program that extracts logs from memory also be
     able to pick the pockets of dead bodies (put a big self
     identifying header on the front of each buffer).

     Note also that having the ability to extract the logs from
     a coredump pretty much eliminates any motivations to flush
     log entries out to disk promptly/expensively.  If the process
     exits clealy, we'll get the logs.  If the process produces
     a coredump, we'll still get the logs.

(c) I have always loved text logs that I can directly view.
     Their immediate and effortless accessibility encourages
     their use, which encourages work in optimizing their content
     (lots of the stuff you need, and little else).

     But binary logs are less than half the size (cheaper to
     take and keep twice as much info), and a program that
     formats them can take arguments about which records/fields
     you want and how you want them formatted ... and getting
     the output the way you want it (whether for browsing or
     subsequent reprocessing) is a huge win.  You get used to
     running the log processing command quickly, but the benefits

(d) If somebody really wants text logs for archival, it is completely
     trivial to run the output of the log-extractor through the
     formatter before writing it to disk ... so the in memory
     format need not be tied to the on-disk format.  The rotation
     code won't care.

> An mmap'ed buffer, even a lockless one, is a simple beast.  Do you
> really need a whole library just for that?  Maybe I'm just
> old-fashioned.

IMHO, surprisingly few things involving large numbers of performance
critical threads turn out to be simple :-)  For example:

	If we are logging a lot, buffer management has the potential
	to become a bottle-neck ... so we need to be able to allocate
	a record of the required size from the circular buffer
	with atomic instructions (at least in non-wrap situations).

	But if records are allocated and then filled, we have to
	consider how to handle the case where the filling is
         delayed, and the reader catches up with an incomplete
	log record (e.g. skip it, wait how long, ???).

	And while we hope this will never happen, we have to deal
	with what happens when the writer catches up with the
	reader, or worse, an incomplete log block ... where we might
	have to determine whether or not the owner is deceased (making
	it safe to break his record lock) ... or should we simply take
	down the service at that point (on the assumption that something
	has gone very wrong).

	If we are going to use multiple buffers, we may have to
	do a transaction dance (last guy in has to close this
	buffer to new writes, start a new one, and somebody has
	to wait for pending additions to complete, queue this
	one for delivery or perhaps even flush it to disk if we
	don't have some other thread/process doing this).

