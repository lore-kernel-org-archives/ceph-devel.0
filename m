From: Loic Dachary <loic@dachary.org>
Subject: Re: crush optimization targets
Date: Thu, 11 May 2017 08:41:47 +0200
Message-ID: <12440f27-f33f-87ab-5ebb-0a9263c64821@dachary.org>
References: <alpine.DEB.2.11.1705101247210.18953@piezo.novalocal>
 <e566cfec-26c7-e626-cbbb-f010ef4702dc@villaneau.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:60599 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdEKGlw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 May 2017 02:41:52 -0400
In-Reply-To: <e566cfec-26c7-e626-cbbb-f010ef4702dc@villaneau.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xavier Villaneau <xavier.ceph@villaneau.fr>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Xavier,

On 05/11/2017 07:52 AM, Xavier Villaneau wrote:
> Hello Sage,
> 
> On 05/10/2017 at 09:00 AM, Sage Weil wrote:
>> I *think* this is the simplest way to approach this (at least currently),
>> although it is not in fact perfect.  We basically assume that the crush
>> rules the admin has set up "make sense."  For example, if you have two
>> crush rules that target a subset of the hierarchy, but they are
>> overlapping (e.g., one is a subset of the other), then the subset that is
>> covered by both will get utilized by the sum of the two and have a higher
>> utilization--and the optimizer will not care (in fact, it will expect it).
>>
>> That rules out at least one potential use-case, though: say you have a
>> pool and rule defined that target a single host.  Depending on how much
>> you store in that pool, those devices will be that much more utilized.
>> One could imagine wanting Ceph to automatically monitor that pool's
>> utilization (directly or indirectly) and push other pools' data out of
>> those devices as the host-local pool fills.  I don't really like this
>> scenario, though, so I can't tell if it is a "valid" one we should care
>> about.
> It looks like upmap calculation works by counting placement groups, so "weird" maps and rules are mostly a problem if the overlapping pools have different ratios of bytes per PG. Maybe that data could be used in the algorithm, but I don't know if the added complexity would be worth it. At this point, it is probably fair to think those corner cases are only seen on maps created by knowledgeable users.
> 
>> In any case, my hope is that at the end of the day we have a suite of
>> opimization mechanisms: crush weights via the new choose_args, pg-upmap,
>> and (if we don't deprecate it entirely) the osd reweight; and pg-based or
>> osd utilization-based optimization (expected usage vs actual usage, or
>> however you want to put it).  Ideally, they could use a common setup
>> framework that handles the calculation of what the expected/optimal
>> targets we're optimizing against (using something like the above) so that
>> it isn't reinvented/reimplemented (or, more likely, not!) for each one.
> I like pg-upmap, it looks great for fine control and has a small impact (compared to manipulating weights, which could move thousands of PGs around). This means it is ideal for re-balancing running clusters.

The weight manipulation is done by small increments. I believe each increment can be applied individually to throttle the PGs movements (i.e. a crushmap with slightly modified weights can be produced & uploaded at each step). It's not as fine grain as pg-upmap but it does not need to be an all-or-nothing optimization either.

> It also addresses the "weight spike" issue (that 5 1 1 1 1 case) since it can just move placement groups until it runs of options. This allows the theoretical limit cases to be reached eventually, whereas with weights it's only asymptotic.
> 
> Hopefully that won't be too confusing; reweight is already quite difficult to explain to new users, so pg-upmap will probably be too. There's also the question of how those tools interact with each other, for instance if PG-based optimization is run on top of utilization-based optimization.
> 
> (Hopefully I did not say anything too wrong, I haven't been able to follow those developments closely for the past couple of weeks),
> 
> Regards,

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
