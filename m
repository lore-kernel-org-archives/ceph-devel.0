From: Xavier Villaneau <xavier.ceph@villaneau.fr>
Subject: Re: crush optimization targets
Date: Thu, 11 May 2017 01:52:01 -0400
Message-ID: <e566cfec-26c7-e626-cbbb-f010ef4702dc@villaneau.fr>
References: <alpine.DEB.2.11.1705101247210.18953@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mo20.mail-out.ovh.net ([178.32.228.20]:33428 "EHLO
        mo20.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdEKFwH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 May 2017 01:52:07 -0400
In-Reply-To: <alpine.DEB.2.11.1705101247210.18953@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Hello Sage,

On 05/10/2017 at 09:00 AM, Sage Weil wrote:
> I *think* this is the simplest way to approach this (at least currently),
> although it is not in fact perfect.  We basically assume that the crush
> rules the admin has set up "make sense."  For example, if you have two
> crush rules that target a subset of the hierarchy, but they are
> overlapping (e.g., one is a subset of the other), then the subset that is
> covered by both will get utilized by the sum of the two and have a higher
> utilization--and the optimizer will not care (in fact, it will expect it).
>
> That rules out at least one potential use-case, though: say you have a
> pool and rule defined that target a single host.  Depending on how much
> you store in that pool, those devices will be that much more utilized.
> One could imagine wanting Ceph to automatically monitor that pool's
> utilization (directly or indirectly) and push other pools' data out of
> those devices as the host-local pool fills.  I don't really like this
> scenario, though, so I can't tell if it is a "valid" one we should care
> about.
It looks like upmap calculation works by counting placement groups, so 
"weird" maps and rules are mostly a problem if the overlapping pools 
have different ratios of bytes per PG. Maybe that data could be used in 
the algorithm, but I don't know if the added complexity would be worth 
it. At this point, it is probably fair to think those corner cases are 
only seen on maps created by knowledgeable users.

> In any case, my hope is that at the end of the day we have a suite of
> opimization mechanisms: crush weights via the new choose_args, pg-upmap,
> and (if we don't deprecate it entirely) the osd reweight; and pg-based or
> osd utilization-based optimization (expected usage vs actual usage, or
> however you want to put it).  Ideally, they could use a common setup
> framework that handles the calculation of what the expected/optimal
> targets we're optimizing against (using something like the above) so that
> it isn't reinvented/reimplemented (or, more likely, not!) for each one.
I like pg-upmap, it looks great for fine control and has a small impact 
(compared to manipulating weights, which could move thousands of PGs 
around). This means it is ideal for re-balancing running clusters.
It also addresses the "weight spike" issue (that 5 1 1 1 1 case) since 
it can just move placement groups until it runs of options. This allows 
the theoretical limit cases to be reached eventually, whereas with 
weights it's only asymptotic.

Hopefully that won't be too confusing; reweight is already quite 
difficult to explain to new users, so pg-upmap will probably be too. 
There's also the question of how those tools interact with each other, 
for instance if PG-based optimization is run on top of utilization-based 
optimization.

(Hopefully I did not say anything too wrong, I haven't been able to 
follow those developments closely for the past couple of weeks),

Regards,
-- 
Xavier Villaneau
Software Engineer, Concurrent Computer Corp.
