From: Gregory Farnum <greg@inktank.com>
Subject: Re: Throttle::wait use case clarification
Date: Tue, 22 Jan 2013 10:01:39 -0800
Message-ID: <DC6CBA4986C64B7FB13FD6118EEFF2A6@inktank.com>
References: <50FBF3A4.4010200@dachary.org>
 <6AF9B5AC8C404CFBB78E54BA8C7FA1D2@inktank.com>
 <50FD4635.9040301@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:36378 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030Ab3AVSBn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 13:01:43 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so2285428pbb.27
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 10:01:42 -0800 (PST)
In-Reply-To: <50FD4635.9040301@dachary.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, sage@inktank.com

On Monday, January 21, 2013 at 5:44 AM, Loic Dachary wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 01/21/2013 12:02 AM, Gregory Farnum wrote:
> > On Sunday, January 20, 2013 at 5:39 AM, Loic Dachary wrote:
> > > Hi,
> > > 
> > > While working on unit tests for Throttle.{cc,h} I tried to figure out a use case related to the Throttle::wait method but couldn't
> > > 
> > > https://github.com/ceph/ceph/pull/34/files#L3R258
> > > 
> > > Although it was not a blocker and I managed to reach 100% coverage anyway, it got me curious and I would very much appreciate pointers to understand the rationale.
> > > 
> > > wait() can be called to set a new maximum before waiting for all pending threads to get get what they asked for. Since the maximum has changed, wait() wakes up the first thread : the conditions under which it decided to go to sleep have changed and the conclusion may be different.
> > > 
> > > However, it only does so when the new maximum is less than current one. For instance
> > > 
> > > A) decision does not change
> > > 
> > > max = 10, current 9
> > > thread 1 tries to get 5 but only 1 is available, it goes to sleep
> > > wait(8)
> > > max = 8, current 9
> > > wakes up thread 1
> > > thread 1 tries to get 5 but current is already beyond the maximum, it goes to sleep
> > > 
> > > B) decision changes
> > > 
> > > max = 10, current 1
> > > thread 1 tries to get 10 but only 9 is available, it goes to sleep
> > > wait(9)
> > > max = 9, current 1
> > > wakes up thread 1
> > > thread 1 tries to get 10 which is above the maximum : it succeeds because current is below the new maximum
> > > 
> > > It will not wake up a thread if the maximum increases, for instance:
> > > 
> > > max = 10, current 9
> > > thread 1 tries to get 5 but only 1 is available, it goes to sleep
> > > wait(20)
> > > max = 20, current 9
> > > does *not* wake up thread 1
> > > keeps waiting until another thread put(N) with N >= 0 although there now is 11 available and it would allow it to get 5 out of it
> > > 
> > > Why is it not desirable for thread 1 to wake up in this case ? When debugging a real world situation, I think it would show as a thread blocked although the throttle it is waiting on has enough to satisfy its request. What am I missing ?
> > > 
> > > Cheers
> > > 
> > > 
> > > Attachments:
> > > - loic.vcf
> > 
> > 
> > 
> > 
> > Looking through the history of that test (in _reset_max), I think it's an accident and we actually want to be waking up the front if the maximum increases (or possibly in all cases, in case the front is a very large request we're going to let through anyway). Want to submit a patch? :)
> :-) Here it is. "make check" does not complain. I've not run teuthology + qa-suite though. I figured out how to run teuthology but did not yet try qa-suite.
> 
> http://marc.info/?l=ceph-devel&m=135877502606311&w=4
> 
> > 
> > The other possibility I was trying to investigate is that it had something to do with handling get() requests larger than the max correctly, but I can't find any evidence of that one...
> I've run the Throttle unit tests after uncommenting
> https://github.com/ceph/ceph/pull/34/files#L3R269
> and commenting out
> https://github.com/ceph/ceph/pull/34/files#L3R266
> and it passes.
> 
> I'm not sure if I should have posted the proposed Throttle unit test to the list instead of proposing it as a pull request
> https://github.com/ceph/ceph/pull/34
> 
> What is best ?
Pull requests are good; you just sent it in on a weekend and we've all got a queue before we evaluate code pulls. :)
Thanks!
-Greg

