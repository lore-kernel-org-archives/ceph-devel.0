From: Sage Weil <sage@newdream.net>
Subject: Re: The costs of logging and not logging
Date: Mon, 21 Nov 2011 10:54:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111211047330.24847@cobra.newdream.net>
References: <4ECA7C83.1090702@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44648 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab1KUSyM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Nov 2011 13:54:12 -0500
In-Reply-To: <4ECA7C83.1090702@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 21 Nov 2011, Mark Kampe wrote:
> The bugs we most dread are situations that only happen rarely,
> and are only detected long after the damage has been done.
> Given the business we are in, we will face many of them.
> We apparently have such bugs open at this very moment.
> 
> In most cases, the primary debugging tools one has are
> audit and diagnostic logs ... which WE do not have because
> they are too expensive (because they are synchronously
> written with C++ streams) to leave enabled all the time.
> 
> I think it is a mistake to think of audit and diagnostic
> logs as a tool to be turned on when we have a problem to
> debug.  There should be a basic level of logging that is
> always enabled (so we will have data after the first
> instance of the bug) ... which can be cranked up from
> verbose to bombastic when we find a problem that won't
> yield to more moderate interrogation:
> 
>  (a) after the problem happens is too late to
>      start collecting data.
> 
>  (b) these logs are gold mines of information for
>      a myriad of purposes we cannot yet even imagine.
> 
> This can only be done if the logging mechanism is
> sufficiently inexpensive that we are not afraid to
> use it:
>     low execution artifact from the logging operations
>     reansonable memory costs for bufferring
>     small enough on disk that we can keep them for months
> 
> Not having such a mechanism is (if I correctly
> understand) already hurting us for internal debugging,
> and will quickly cripple us when we have customer
> (i.e. people who cannot diagnose problems for
> themselves) problems to debug.
> 
> There are many tricks to make logging cheap, and the
> sizes acceptable.  There are probably a dozen open-source
> implementations that already do what we need, and if they
> don't something basic can be built in a two-digit number
> of hours.  The real cost is not in the mechanism but in
> adapting existing code to use it.  This cost can be
> mitigated by making the changes opportunistically ...
> one component at a time, as dictated by need/fear.
> 
> But we cannot make that change-over until we have a
> mechanism.  Because the greatest cost is not the
> mechanism, but the change-over, we should give more
> than passing thought to what mechanism to choose ...
> so that the decision we make remains a good one for
> the next few years.
> 
> This may be something that we need to do sooner,
> rather than later.

Yep.

I see two main issues with the slowness of the current logs:

 - all of the string rendering in the operator<<()'s is slow.  things like 
prefixing every line with a dump of the pg state is great for debugging, 
but makes the overhead very high.  we could scale all of that back, but 
it'd be a big project.
 - the logging always goes to a file, synchronously.  we could write to a 
ring buffer and either write it out only on crash, or (at the very least) 
write it async.

I wonder, though, if something different might work.  gcc lets you 
arbitrarily instrument function calls with -finstrument-functions.  
Something that logs function calls and arguments to an in-memory ring 
buffer and dumps that out on crash could potentially have a low overhead 
(if we restrict it to certain code) and would give us lots of insight into 
what happend leading up to the crash.

sage
