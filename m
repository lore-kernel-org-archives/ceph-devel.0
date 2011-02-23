From: Sage Weil <sage@newdream.net>
Subject: Re: some thoughts about logging
Date: Wed, 23 Feb 2011 09:01:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102230856050.2601@cobra.newdream.net>
References: <AANLkTikz0B8N84wztix+RFV9VC0uz74OSwnt9exRZ-co@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42055 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab1BWQ7y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 11:59:54 -0500
In-Reply-To: <AANLkTikz0B8N84wztix+RFV9VC0uz74OSwnt9exRZ-co@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

(CCing list)

On Wed, 23 Feb 2011, Colin McCabe wrote:
> I was reading a paper about the use of LTT-ng in large computer
> clusters at Google and elsewhere.
> 
> It's here: http://lttng.org/files/papers/bligh-Reprint.pdf
> 
> LTT-ng is one of the many tracing toolkits for the Linux kernel. It's
> interesting to me because when I last compared tracing toolkits (which
> was admittedly a while ago) LTT-ng seemed to be the closest to
> achieving a dtrace-like level of functionality.
> 
> I wonder if LTT-ng, or something like it, could help us get a handle
> on how our performance changes on a kernel level. Some of the examples
> they show mention problems with mysterious I/O slowdowns and other
> familiar problems.
> 
> I also noticed a few interesting passages detailing their philosophy
> about logging:
> 
> > In addition, we need a system that can capture failures
> > at the earliest possible moment; if a problem takes a
> > week to reproduce, and 10 iterations are required to col-
> > lect enough information to fix it, the debugging process
> > quickly becomes intractable. The ability to instrument a
> > wide spectrum of the system ahead of time, and provide
> > meaningful data the first time the problem appears, is
> > extremely useful. Having a system that can be deployed
> > in a production environment is also invaluable. Some
> > problems only appear when you run your application in
> > a full cluster deployment; re-creating them in a sandbox
> > is impossible.
> 
> When running a production system, they don't just turn logging off;
> they log to a circular buffer in memory. If there is a problem, they
> have the full contents of the circular buffer to help debug it, which
> in their case means they have the last few minutes of messages.
> Periodically, they flush high-priority messages (but not low priority
> ones!) out to disk. They also use per-CPU buffers to avoid cache-line
> bouncing. In this way you can have a pretty complete picture of what's
> going on, without imposing a high performance overhead.
> 
> I do wonder if we'll end up having to implement something like their
> circular buffer system to make progress on some of our Ceph issues. We
> have a lot of potential race conditions, and not all of them are going
> to be nice enough to reproduce themselves on command. We have a lot of
> performance problems where the cause may not be apparent either.

This is definitely interesting.  One of the problems right now is that it 
is difficult to diagnose problems without logging, and logging is 
pretty heavyweight... especially in the MDS.  

My main concern is that I think most of the logging overhead is related to 
the string rendering... all of the operator<< overloads result in a pretty 
deep call tree.  It would be interesting at some point to run an 
experiment that logs to the line buffer but doesn't actually write 
anything to disk and compares to logging fully on and off to see where the 
time is spent.  Same goes for dropping the lock to see how much is locking 
contention.

In the end, though, I think what will really be needed is some careful 
adjustment of logging levels so that we can get the most useful 
information with say debug level 5.  99% of the current output is at 10 or 
20 because the value judgement of how important a message is was difficult 
to make when the code was written.

sage
