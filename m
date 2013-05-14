From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: pg balancing
Date: Tue, 14 May 2013 09:39:48 -0600
Message-ID: <51925AC4.5010502@sandia.gov>
References: <alpine.DEB.2.00.1305131730380.10961@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:54410 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932361Ab3ENPkK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 11:40:10 -0400
In-Reply-To: <alpine.DEB.2.00.1305131730380.10961@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

[resent to list because I missed that Cc:]

Hi Sage,

On 05/13/2013 06:35 PM, Sage Weil wrote:
> Hi Jim-
> 
> You mentioned the other day your concerns about the uniformity of the PG 
> and data distribution.  There are several ways to attack it (including 
> increasing the number of PGs), but one that we haven't tested much yet is 
> the 'reweight-by-utilization' function in the monitor.
> 
> The idea is that there will always be some statistical variance in the 
> distribution and a non-zero probability of having outlier OSDs with too 
> many PG.  We adjust for this by taking nodes that are substantially above 
> the mean down by some adjustment factor in an automated way.
> 
>  ceph osd reweight-by-utilization MIN
> 
> where MIN is the minimum relative utilization at which we will start 
> adjusting down.  It is always > 100 (100% of the mean), and defaults to 
> 120.  After it adjusts the reweights, you should see the result in 'ceph 
> osd tree' output
> 
> Have you played with this at all on your cluster?  I'd be very interested 
> in how well this does/does not improve things for you.

I haven't yet, but likely it's because I don't understand
what the reweighting does, exactly.  Maybe you can comment
inline below where I go wrong?  Here's my thinking:

I'm only partially motivated by the actual amount of storage
used per OSD, although it is a factor.

My major concern is a performance issue for our parallel
application codes.  Their computation cycle is: compute
furiously, write results, repeat.  The issue is that none
of our codes implement write-behind; each task must finish
writing results before any can resume computing.

So, when some OSDs carry more PGs, they cannot complete
their portion of the write phase as quickly as other OSDs
with  fewer PGs.  Thus, the application's ability to resume
computation is delayed by the busiest OSDs.

My concern is that when we rebalance, we just cause some
other subset of the OSDs to be the busiest, in order to
send fewer writes to the overused OSDs and more writes
to underused OSDs.

At least, that's what I was thinking, without actually 
examining the code to see what is really going on in
rebalancing, and without testing.

Another thing I haven't done is actually compute from the
statistics of uniform distributions what the expected variance
is for my specific layout, (now 256K PGs across 576 OSDs, with
root/host/device hierarchy, 24 OSDs/host).  That's mostly due
to my lack of knowledge of statistics....

If I'm getting more variance than expected I want to understand
why, in case it can be fixed.

In any event, I think it's past time I tried reweighting.

Suppose I use 'ceph osd reweight-by-utilization 101', on the
theory that I'd cause continuous, small adjustments to
utilization, and I'd learn what the maximum impact can be.
Does that seem like a bad idea to you, and if so could you
help me understand why?

Thanks for taking the time to think about this -
I know you're busy.

PS - FWIW, another reason I keep pushing the number of PGs is
because when we actually deploy Ceph for production, it'll
be at a bigger scale than my testbed.  So, I'm trying to
shake out any scale-related issues now, to make sure our
users' first experience with Ceph is a good one.

-- Jim

> 
> Thanks!
> sage
> 
> 
> 


