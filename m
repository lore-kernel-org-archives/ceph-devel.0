From: Sage Weil <sage@newdream.net>
Subject: crush optimization targets
Date: Wed, 10 May 2017 13:00:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705101247210.18953@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33028 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdEJNAH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 May 2017 09:00:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Peter Maloney <peter.maloney@brockmann-consult.de>, Ceph Development <ceph-devel@vger.kernel.org>

This is slightly off topic, but I want to throw out one more thing into 
this discussion: we ultimately (with all of these methods) want to address 
CRUSH rules that only target a subset of the overall hierarchy.  I tried 
to do this in the pg-upmap improvemnets PR (which, incidentally, Loic, 
could use a review :) at

	https://github.com/ceph/ceph/pull/14902

In this commit

	https://github.com/ceph/ceph/pull/14902/commits/a9ba66c46e76b5ef8e5184a5100a37598a7e7695

it uses the get_rule_weight_osd_map() method, which returns a weighted map 
of how much "weight" a rule is trying to store on each of the OSDs that 
are potentially targetted by the CRUSH rule.  This helper us currently 
used by the 'df' code when trying to calculate the MAX AVAIL value and 
is not quite perfect (it doesn't factor in complex crush rules with 
multiple 'take' ops, for one) but for basic rules it works fine.

Anyway, that upmap code will take the set of pools you're balancing, look 
at how much they collectively *should* be putting on the target OSDs, and 
optimize against that (as opposed to the raw device CRUSH weight).

I *think* this is the simplest way to approach this (at least currently), 
although it is not in fact perfect.  We basically assume that the crush 
rules the admin has set up "make sense."  For example, if you have two 
crush rules that target a subset of the hierarchy, but they are 
overlapping (e.g., one is a subset of the other), then the subset that is 
covered by both will get utilized by the sum of the two and have a higher 
utilization--and the optimizer will not care (in fact, it will expect it).

That rules out at least one potential use-case, though: say you have a 
pool and rule defined that target a single host.  Depending on how much 
you store in that pool, those devices will be that much more utilized.  
One could imagine wanting Ceph to automatically monitor that pool's 
utilization (directly or indirectly) and push other pools' data out of 
those devices as the host-local pool fills.  I don't really like this 
scenario, though, so I can't tell if it is a "valid" one we should care 
about.

In any case, my hope is that at the end of the day we have a suite of 
opimization mechanisms: crush weights via the new choose_args, pg-upmap, 
and (if we don't deprecate it entirely) the osd reweight; and pg-based or 
osd utilization-based optimization (expected usage vs actual usage, or 
however you want to put it).  Ideally, they could use a common setup 
framework that handles the calculation of what the expected/optimal 
targets we're optimizing against (using something like the above) so that 
it isn't reinvented/reimplemented (or, more likely, not!) for each one.

Is it possible?
sage
