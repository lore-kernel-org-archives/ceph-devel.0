From: Sage Weil <sage@inktank.com>
Subject: Re: bloom filter thoughts
Date: Thu, 26 Sep 2013 08:52:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309260848390.12714@cobra.newdream.net>
References: <alpine.DEB.2.00.1309251629090.12717@cobra.newdream.net> <524434A7.9020001@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39805 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab3IZPw7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Sep 2013 11:52:59 -0400
In-Reply-To: <524434A7.9020001@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 26 Sep 2013, Mark Nelson wrote:
> On 09/25/2013 07:34 PM, Sage Weil wrote:
> > I spent some time on the plane playing with bloom filters.  We're looking
> > at using these on the OSD to (more) efficiently keep track of which
> > objects have (probably) been touched in recent history.  This can then be
> > used by the caching and tiering code to identify objects that have
> > (definitely) not been touched that should be demoted or purged from a
> > given tier.
> 
> You know this is making me want to work on my photon mapping engine again
> instead of running benchmarks for Bryan. :P  Anyway, this seems like a great
> use case.  Are there any other places we want to fast intersection tests where
> we could use these?  k-nearest-neighbor searches would be tons of fun to do
> too if we only had a use case!
> 
> > 
> > The false positive probility (in our case, probability we'll think an
> > object has been touched when it actually hasn't) is dependent on size of
> > the bloom filter and the number of insertions.
> > 
> > When you create the bloom_filter, you tell it how many insertions you
> > expect to do and what fpp you want and it sizes itself.  For ~1% fpp, it
> > costs just over 1 byte per insertion.
> 
> It's been a long time since I looked at bloom filters, but isn't this also
> affected by the number of hash functions used?  Are we going to try to have it
> auto-select the number?

The bloom_filter class hides this.  You feed it the desired fpp and 
insertion count and it chooses the number of hashes (actually, 1 hash but 
N salts) and table size.  Unit tests verify the actual fpp very closely 
matches the target.

> 
> > 
> > wip-bloom has some cleanups and unit tests that test the false positive
> > behavior.
> > 
> > A few issues/notes:
> > 
> > - If we build a sequence of filters covering intervals of time, this let's
> > us estimate "atime".  However, if we have N filters of 1/Nth the size, our
> > total_ffp = N * fpp, so each bin's bloom needs to be 1/Nth as big with
> > 1/Nth the desired fpp.  In my simple test, going from 1 to 16 bins moves
> > the bloom_filter size from 20 KB to 32 KB (that's 16k insertions and
> > target_ffp of .01).
> > 
> > - In the OSD, we won't necessarily know how many insertions a bin will
> > have.  The user inputs will/should be something like:
> >   - target fpp
> >   - time interval we want to record/estimate over (say, 1 day)
> > and we'll need to translate that into a particular sized bloom.  We
> > probably need to estimate that based on recent pg workload/activity.  If
> > we have a filter that "fills up" quickly, the next one will be bigger.  If
> > we have an unfull one after some period of time, we can compress/fold it
> > down into a smaller filter (a convenient trick) and start the next smaller
> > one.
> 
> So basically we try to keep a running log of the PG activity so we can guess
> as to how big future filters should be, and if our guess is short we move on
> and make the next one bigger, but if we overshot we compress it into a smaller
> filter and make the next one smaller?  I think this is exactly what you said
> but I want to make sure I got it. :)

Exactly.

> > 
> > I suggest the pg_pool_t get:
> > 
> >   uint8_t bloom_fpp_pow;  //< desired false positive rate ==
> > 2^(-bloom_fpp_pow)
> >   uint16_t bloom_period;  //< period for that false positive rate (seconds)
> >   uint16_t bloom_bins;    //< the approx "resolution" we want
> >   uint16_t bloom_max;     //< how many periods we retain history for
> > 
> > which would make the OSD try to create a new filter roughly every
> > (period/bins) seconds with some simple estimation.
> > 
> > Other thoughts on the OSD side stuff:
> > 
> > - The past history of filters may be large.  I suggest we stick them in an
> > omap object that lives with the PG and is recovered/backfilled but that
> > needs to happen in a way that is out of band wrt to other objects.  It
> > should get scrubbed.
> 
> Any guesses as to how large this will get yet?  It's too early in the morning
> for me to do math...

Greg did a quick calc yesterday, I forget.  It was enough that it might 
fit in RAM for a spinning disk for 1-2 days of history, but only 
marginally.

sage

 
> > 
> > - Before anything is trimmed from the pg log it needs to be added to the
> > currently-accumulating bloom filter.  We can delay this until (well) after
> > last_complete_on_disk so that we never have to worry about divergent
> > entries.
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
