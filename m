From: Sage Weil <sage@inktank.com>
Subject: bloom filter thoughts
Date: Wed, 25 Sep 2013 17:34:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309251629090.12717@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32819 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab3IZAeS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Sep 2013 20:34:18 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 590818004F
	for <ceph-devel@vger.kernel.org>; Wed, 25 Sep 2013 17:34:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 33F1F8004F
	for <ceph-devel@vger.kernel.org>; Wed, 25 Sep 2013 17:34:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I spent some time on the plane playing with bloom filters.  We're looking 
at using these on the OSD to (more) efficiently keep track of which 
objects have (probably) been touched in recent history.  This can then be 
used by the caching and tiering code to identify objects that have 
(definitely) not been touched that should be demoted or purged from a 
given tier.

The false positive probility (in our case, probability we'll think an 
object has been touched when it actually hasn't) is dependent on size of 
the bloom filter and the number of insertions.  

When you create the bloom_filter, you tell it how many insertions you 
expect to do and what fpp you want and it sizes itself.  For ~1% fpp, it 
costs just over 1 byte per insertion.

wip-bloom has some cleanups and unit tests that test the false positive 
behavior.

A few issues/notes:

- If we build a sequence of filters covering intervals of time, this let's 
us estimate "atime".  However, if we have N filters of 1/Nth the size, our 
total_ffp = N * fpp, so each bin's bloom needs to be 1/Nth as big with 
1/Nth the desired fpp.  In my simple test, going from 1 to 16 bins moves 
the bloom_filter size from 20 KB to 32 KB (that's 16k insertions and 
target_ffp of .01).

- In the OSD, we won't necessarily know how many insertions a bin will 
have.  The user inputs will/should be something like:
 - target fpp
 - time interval we want to record/estimate over (say, 1 day)
and we'll need to translate that into a particular sized bloom.  We 
probably need to estimate that based on recent pg workload/activity.  If 
we have a filter that "fills up" quickly, the next one will be bigger.  If 
we have an unfull one after some period of time, we can compress/fold it 
down into a smaller filter (a convenient trick) and start the next smaller 
one.

I suggest the pg_pool_t get:

 uint8_t bloom_fpp_pow;  //< desired false positive rate == 2^(-bloom_fpp_pow)
 uint16_t bloom_period;  //< period for that false positive rate (seconds)
 uint16_t bloom_bins;    //< the approx "resolution" we want
 uint16_t bloom_max;     //< how many periods we retain history for

which would make the OSD try to create a new filter roughly every 
(period/bins) seconds with some simple estimation.

Other thoughts on the OSD side stuff:

- The past history of filters may be large.  I suggest we stick them in an 
omap object that lives with the PG and is recovered/backfilled but that 
needs to happen in a way that is out of band wrt to other objects.  It 
should get scrubbed.

- Before anything is trimmed from the pg log it needs to be added to the 
currently-accumulating bloom filter.  We can delay this until (well) after 
last_complete_on_disk so that we never have to worry about divergent 
entries.

sage
