From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: recovery priority preemption
Date: Wed, 13 Sep 2017 20:02:01 +0200
Message-ID: <20170913180201.GB9903@mailware>
References: <alpine.DEB.2.11.1709131458410.24068@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:46518 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbdIMSLD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 13 Sep 2017 14:11:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1709131458410.24068@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Wed, Sep 13, 2017 at 03:03:22PM +0000, Sage Weil wrote:
> I recently observed a problem on the lab cluster while doing a log of 
> rebalancing (filestore->bluestore conversion):
> 
>  - lots of pgs in backfill_wait
>  - a few pgs that need pg log recovery, but these appear after backfills 
> are already in progress, so they end up in backfill_wait too (confusing 
> state name!)
>  - ongoing write activity extents pg logs for those pgs, but they cannot 
> trim
>  - pg logs reach 5x-10x the max
>  - OSDs OOM

Why we're keeping so many pg logs in RAM anyway? We could dump them to storage
and once things stabilize, just reload them by few hundred entries at once.

> I think what is needed is for the recovery priority scheduling to allow 
> preemption.  If we are currently working on recovery/backfill for PG X, 
> but PG Y appears with a higher priority, we should suspend work on X and 
> switch to Y.
> 
> Piotr, I didn't look too closely at forced recovery changes you folks 
> recently did, but I'm guessing that it was added to address this sort of 
> situation, right? 

Not exactly that, but close.
The problem we wanted to solve (or at least reduce) was the risk of SLA
reduction for at least some of customers when cascading failures occur. 
We host multiple Ceph clusters that are used by even more VMs, meaning
a lot of data to recover and that sometimes takes days to finish - so if
one rack fails for some reason, the risk of failures in remaining two racks
is very real and very scary. 
Because pgs are recovered in pretty much random order (or at least not in
any order that would recover entire images one-by-one), we wanted to add some
predictability to that, so if cascading failures do occur, less customers
would be impacted by that because at least some of them managed to recover. 

> Would a general solution that preempts and always works 
> on the highest priority PG resolve the problem you've observed?

Preempting (in exact meaning of that - "drop whatever you're doing and focus
on that instead") any ongoing recovery with force-recovery wasn't exactly a
priority and we didn't want to make it even more complex than it already got.
If entire rack needs recovery, waiting for a single pg that is currently
in progress isn't a *big* issue in the case mentioned above. Still, that would
be very welcome! Well, except if that would mean stopping recovery of pg that's
90% done and then restarting it from beginning later.

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl
