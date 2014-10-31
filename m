From: Sage Weil <sage@inktank.com>
Subject: cache tiering sessions at CDS
Date: Fri, 31 Oct 2014 14:01:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410311327280.31314@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55261 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbaJaVBo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Oct 2014 17:01:44 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C3FEB813CB
	for <ceph-devel@vger.kernel.org>; Fri, 31 Oct 2014 14:01:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 8F551813CB
	for <ceph-devel@vger.kernel.org>; Fri, 31 Oct 2014 14:01:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There were a pair of CDS sessions Wednesday on cache tiering that prompted 
a great discussion about the current performance problems we're seeing and 
ways to address them.  It was a long discussion but I'll do my best to 
summarize.  Please chime in if I miss anything or if you disagree with 
my conclusions!

The first session was about fine-grained promotion.  I.e., promoting or 
storing only portions of an object in the cache.  Currently an object 
always exists in its entirely in the cache tier, but the latency from 
promotion can be expensive if the original write is small.

Sam and I generally agreed that there are advantages to doing this, but 
that the implementation will be quite complex.  There are also several 
simpler improvements that can be made that address many (most?) of the 
problematic workload patterns and are significantly simpler.

-- Reads --

Currently we either forward a read (decline to promote) or block a read 
while we promote.  Doing more declining (e.g. promote on 2nd read) is 
shown to help, but we should be able to do a lot better.

The first step is wip-promote-forward, or something similar, which 
forwards the read *and* initiates a promote.  The the original IO isn't 
delayed, only subsequent reads that arrive shortly after.

Second, even those subsequent reads need not wait for a promote: we can 
safely forward them too while promotion is in progress without breaking 
consistency from the client's perspective, as long as we preserve the 
order of reads and writes for each client.

9979 osd: cache: proxy reads (instead of redirect)
9980 osd: cache: proxy reads during promote

Note: I belive there is some ordering problems with *redirecting* reads 
and then stopping (e.g., redirect, start promote, finish promote, read 
from cache ... the second read reply could reach the client before the 
first).  We may need to proxy in general?  :/

Anyway, proxying reads during promotion effectively makes the promotion 
asynchronous and transparent to the read workload, modulo the extra IO 
that the cache and base tiers will do (competition for network and disk 
IO).  I believe this will mitigate most of the impact on reads.

More importantly, it is least as good as the more complicated proposal of 
satisfying the read from the intermediate promotion result before it is 
written into the cache tier.  In particular, I think the *only* time using 
the intermediate promote result is better is when the read falls entirely 
within the current in-flight copy-get operation (in flight to the base 
tier, or in the process of being written to the cache but still in 
memory).  Any other time (unaligned read, read arrives before promote 
starts) it's better to proxy it.

Also, note that it is mainly small reads that we care about.  We expect 
large reads to be less frequent and, when they happen, to be generally 
okay with sending those to the base tier anyway.

-> Stategies that hide promotion cost are probably more useful than 
strategies that promote less (or partial) object data.

-- Writes --

The situation for writes is a bit more complex.  First, if we add the 
ability to proxy writes to the backend, we give ourselves the ability to 
decide if/when to promote (currently we unconditionally promote on write). 
This would allow a 'promote on 2nd write' type of behavior (similar to 
what we did for read).

We talked about the possibility of combining the small write into the 
promotion's write of the full object into the cache.  Since these are 
currently pipelined, it is not clear that this will improve things very 
much.  Promoting only object metadata and writing a partial bit of 
data into the cache tier is the big win, but it's complex, and we should 
do all the simple things (like write proxying) first.

Finally, we talked about making a write-full on an object skip the data 
portion of the promote.  This is only moderately complex and seems doable.  
However, it would be helpful to know how frequent write_full is in real 
workloads first.  Also, a write_full is arguably the type of operation 
where we might decline to promote at all, and simply proxy the write back 
to the base tier.

I think in the short term, the next step should be:

9981 osd: cache: proxy writes (instead of unconditionally promoting)

-- read-only cache --

Finally, we brought up the idea of a read-only cache tier:

 - reads would promote (or not) just as they do now
 - writes would invalidate (delete object from cache) and then 
forward/proxy

h/t to Dan Lambright for that suggestion.  Note that we already have a 
readonly cache mode; the delta here is how we handle the writes.

9982 osd: cache: make writes in readonly mode invalidate and then forward 


There was a lot of discussion here so if you're interested you way want to 
check the pads or watch the videos.

http://pad.ceph.com/p/hammer-osd_tiering_promotion_unit
http://pad.ceph.com/p/hammer-osd_tiering_latencies_cache_tier_miss
http://youtu.be/7p8ZkOIJjUA
http://youtu.be/AGDOnJFffrc


sage
