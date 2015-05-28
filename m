From: John Spray <john.spray@redhat.com>
Subject: Re: RFC: progress bars
Date: Thu, 28 May 2015 17:52:04 +0100
Message-ID: <556747B4.1010808@redhat.com>
References: <5523D388.6010008@redhat.com>	<CAC6JEv8FEMieXZH0+muXNNMT1xkY863HGvsUy0qB9AMzeQLfWQ@mail.gmail.com>	<5566EA5D.3000800@redhat.com> <CAANLjFoGRNqGH34BsFKp54R3L5o1x8HKi+s9FQrN+HtbbQjBbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58055 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbbE1QwG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 May 2015 12:52:06 -0400
In-Reply-To: <CAANLjFoGRNqGH34BsFKp54R3L5o1x8HKi+s9FQrN+HtbbQjBbg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Gregory Farnum <greg@gregs42.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 28/05/2015 17:41, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Let me see if I understand this... Your idea is to have a progress bar
> that show (active+clean + active+scrub + active+deep-scrub) / pgs and
> then estimate time remaining?

Not quite: it's not about doing a calculation on the global PG state 
counts.  The code identifies specific PGs affected by specific 
operations, and then watches the status of those PGs.

>
> So if PGs are split the numbers change and the progress bar go
> backwards, is that a big deal?

I don't see a case where the progress bars go backwards with the code I 
have so far?  In the case of operations on PGs that split, it'll just 
ignore the new PGs, but you'll get a separate event tracking the 
creation of the new ones.  In general, progress bars going backwards 
isn't something we should allow to happen (happy to hear counter 
examples though, I'm mainly speaking from intuition on that point!)

If this was extended to track operations across PG splits (it's unclear 
to me that that complexity is worthwhile), then the bar still wouldn't 
need to go backwards, as whatever stat was being tracked would remain 
the same when summed across the newly split PGs.

> I don't think so, it might take a
> little time to recalculate how long it will take, but no big deal. I
> do like the idea of the progress bar even if it is fuzzy. I keep
> running ceph status or ceph -w to watch things and have to imagine it
> in my mind.

Right, the idea is to save the admin from having to interpret PG counts 
mentally.

> It might be nice to have some other stats like client I/O
> and rebuild I/O so that I can see if recovery is impacting production
> I/O.

We already have some of these stats globally, but it would be nice to be 
able to reason about what proportion of I/O is associated with specific 
operations, e.g. "I have some total recovery IO number, what proportion 
of that is due to a particular drive failure?". Without going and 
looking at current pg stat structures I don't know if there is enough 
data in the mon right now to guess those numbers.  This would 
*definitely* be heuristic rather than exact, in any case.

Cheers,
John
