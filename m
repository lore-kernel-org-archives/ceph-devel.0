From: Jeff Layton <jlayton@redhat.com>
Subject: Re: should CephContext be a singleton?
Date: Thu, 14 Sep 2017 09:28:11 -0400
Message-ID: <1505395691.4870.22.camel@redhat.com>
References: <1505314715.4822.24.camel@redhat.com>
         <20170913150915.GA31125@ultraspiritum.eng.arb.redhat.com>
         <CALe9h7fsx9OCa8TFFz7OXtWzEDZOVPp-ZStDx4of6EcFR-0hJA@mail.gmail.com>
         <20170913153021.GB31125@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:46298 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbdINN2P (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 09:28:15 -0400
Received: by mail-qk0-f182.google.com with SMTP id z143so6709208qkb.3
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 06:28:15 -0700 (PDT)
In-Reply-To: <20170913153021.GB31125@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>, John Spray <jspray@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, 2017-09-13 at 11:30 -0400, Adam C. Emerson wrote:
> On 13/09/2017, John Spray wrote:
> [snip]
> > The separation between process global stuff and per-cluster stuff
> > still seems entirely sensible, I don't know how much progress was made
> > with that for the RGW/RBD bits that have cluster-spanning daemons?
> 
> As I understand it, people agreed on getting rid of g_ceph_context but
> not on separation, but if people like separation....
> 
> But! Either way, the other advantage of getting rid of g_ceph_context
> is that it makes embedding potentially multiple daemons in processes
> and clears up other librarification issues. (For example, if we ever
> wanted to try client-side erasure coding, the g_ceph_context in the
> ErasureCode library might be a problem.)
> 
> Sage also worried about logging and the problem of marking messages
> from multiple OSDs in a single process and making sure they went to
> the appropriate files and so on. I had an idea for keeping the
> per-process context and logging thread-local and simulating dynamic
> scoping on top of it to address the logging problem, but that was
> thought to be too complicated and people liked just passing it around
> instead.
> 
> 
> > I was wondering about this the other day, does std::mutex give us the
> > cycle detection some other way?  lockdep is a seriously useful thing.
> 
> Well! If you want lockdep, there's common/mutex_debug.h which plugs
> into lockdep. You could insert it anywhere you wanted to use lockdep
> or have more run-time checking.
> 

Fair enough, and thanks for all the input. At this point, I've pretty
much determined that the main problem in that tracker bug is with
lockdep.

I'm going to opt for smaller, more targeted surgery that should keep
things working more or less as they are, but close the races that can
occur when the cct is unregistered from lockdep while other threads are
concurrently manipulating mutexes. That has the advantage of being
relatively easy to backport too, I think.

I should have a PR up in a day or two, once I do some more testing with
the series.

Thanks!
-- 
Jeff Layton <jlayton@redhat.com>
