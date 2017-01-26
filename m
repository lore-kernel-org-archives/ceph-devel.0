From: Sage Weil <sage@redhat.com>
Subject: crush multipick anomaly
Date: Thu, 26 Jan 2017 03:05:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51972 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbdAZDFz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jan 2017 22:05:55 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
        by cobra.newdream.net (Postfix) with ESMTP id 2277C813F9
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jan 2017 19:05:55 -0800 (PST)
Received: from localhost.localdomain (unknown [64.111.99.127])
        by cobra.newdream.net (Postfix) with ESMTPSA id 0201B8021C
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jan 2017 19:05:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a longstanding bug,

	http://tracker.ceph.com/issues/15653

that causes low-weighted devices to get more data than they should. Loic's 
recent activity resurrected discussion on the original PR

	https://github.com/ceph/ceph/pull/10218

but since it's closed and almost nobody will see it I'm moving the 
discussion here.

The main news is that I have a simple adjustment for the weights that 
works (almost perfectly) for the 2nd round of placements.  The solution is 
pretty simple, although as with most probabilities it tends to make my 
brain hurt.

The idea is that, on the second round, the original weight for the small 
OSD (call it P(pick small)) isn't what we should use.  Instead, we want 
P(pick small | first pick not small).  Since P(a|b) (the probability of a 
given b) is P(a && b) / P(b),

 P(pick small | first pick not small)
 = P(pick small && first pick not small) / P(first pick not small)

The last term is easy to calculate,

 P(first pick not small) = (total_weight - small_weight) / total_weight

and the && term is the distribution we're trying to produce.  For exmaple, 
if small has 1/10 the weight, then we should see 1/10th of the PGs have 
their second replica be the small OSD.  So

 P(pick small && first pick not small) = small_weight / total_weight

Putting those together,

 P(pick small | first pick not small)
 = P(pick small && first pick not small) / P(first pick not small)
 = (small_weight / total_weight) / ((total_weight - small_weight) / total_weight)
 = small_weight / (total_weight - small_weight)

This is, on the second round, we should adjust the weights by the above so 
that we get the right distribution of second choices.  It turns out it 
works to adjust *all* weights like this to get hte conditional probability 
that they weren't already chosen.

I have a branch that hacks this into straw2 and it appears to work 
properly for num_rep = 2.  With a test bucket of [99 99 99 99 4], and the 
current code, you get

$ bin/crushtool -c cm.txt --test --show-utilization --min-x 0 --max-x 40000000 --num-rep 2
rule 0 (data), x = 0..40000000, numrep = 2..2
rule 0 (data) num_rep 2 result size == 2:       40000001/40000001
  device 0:             19765965        [9899364,9866601]
  device 1:             19768033        [9899444,9868589]
  device 2:             19769938        [9901770,9868168]
  device 3:             19766918        [9898851,9868067]
  device 6:             929148  [400572,528576]

which is very close for the first replica (primary), but way off for the 
second.  With my hacky change,

rule 0 (data), x = 0..40000000, numrep = 2..2
rule 0 (data) num_rep 2 result size == 2:       40000001/40000001
  device 0:             19797315        [9899364,9897951]
  device 1:             19799199        [9899444,9899755]
  device 2:             19801016        [9901770,9899246]
  device 3:             19797906        [9898851,9899055]
  device 6:             804566  [400572,403994]

which is quite close, but still skewing slightly high (by a big less than 
1%).

Next steps:

1- generalize this for >2 replicas
2- figure out why it skews high
3- make this work for multi-level hierarchical descent

sage

