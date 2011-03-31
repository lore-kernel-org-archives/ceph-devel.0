From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 31 Mar 2011 11:41:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103311140240.28788@cobra.newdream.net>
References: <4D939FF7.1070104@sandia.gov> <Pine.LNX.4.64.1103301449400.18670@cobra.newdream.net>
 <4D948CAC.6040709@sandia.gov> <Pine.LNX.4.64.1103310920460.13796@cobra.newdream.net>
 <4D94B333.4060700@sandia.gov> <4D94B573.7070505@sandia.gov>
 <Pine.LNX.4.64.1103311022500.13796@cobra.newdream.net> <4D94C302.5000004@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34401 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758920Ab1CaSiV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2011 14:38:21 -0400
In-Reply-To: <4D94C302.5000004@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 31 Mar 2011, Jim Schutt wrote:
> Sage Weil wrote:
> > On Thu, 31 Mar 2011, Jim Schutt wrote:
> > > Jim Schutt wrote:
> > > > Sage Weil wrote:
> > > > > On Thu, 31 Mar 2011, Jim Schutt wrote:
> > > > > > > I was actually suggesting we try to make it core dump inside the
> > > > > > > "delete
> > > > > > > this" and watching for a stall in progress and then sending
> > > > > > > SIGABRT to
> > > > > > > dump
> > > > > > > core in the act.  That way we verify it really is in the allocator
> > > > > > > (and
> > > > > > > maybe even see where).  That's a bit harder to set up, though!  
> > > > > > Right, I couldn't think of how to automate that stall detection
> > > > > > during the stall, rather than after.  At least, I couldn't
> > > > > > think of how to do it without incurring possibly excessive
> > > > > > overhead, say by starting a timer on every "delete this".
> > > > > Yeah.  I wonder if dumping core on a cosd right when it gets marked
> > > > > down
> > > > > would do the trick?  That should catch it ~20 seconds or whatever in
> > > > > the
> > > > > stall.  By watching for the "osdfoo marked down" messages from ceph
> > > > > -w?
> > > > What about making Cond::Wait() use pthread_cond_timedwait()
> > > > with a suitable timeout value, say 10 seconds, and asserting
> > > > on timeout?  Do you think there would be many legitimate 10
> > > > second delays in OSD processing?
> > > > 
> > > Or, I could make a Cond::WaitIntervalOrAbort(), and
> > > use it just on the pipe lock, since that's the source
> > > of the trouble.  Sound useful?
> > 
> > Yeah that sounds like the way to go.. then you can hand pick the site(s)
> > that is/are waiting a long time in this case and switch those to
> > WaitIntervalOrAbort?  Hopefully the cond timer will go off despite whatever
> > badness is going on in delete this...
> 
> Actually, it occurs to me Wait() isn't what I'm after:
> that is used to wait some unknown time for some event.
> 
> I think instead I need to use TryLock() on the pipe_lock
> in submit_message(), in a loop with a suitable sleep,
> say 100us, and assert when it takes too long to acquire
> the lock.
> 
> So, maybe add a Mutex::LockOrAbort(), and use it in
> submit_message()?
> 
> submit_message() is intended to return immediately, no?
> And the issue is caused by heartbeat() being unable to
> queue messages, so this sounds to me to be a useful
> test.
> 
> Does that seem to have low enough overhead to
> be useful?

Yeah, that sounds right!

sage
