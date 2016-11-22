From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: crush multi-pick anomaly
Date: Tue, 22 Nov 2016 17:23:54 -0500
Message-ID: <20161122222354.GC20744@ultraspiritum.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1611221521220.11236@piezo.us.to>
 <20161122173013.GA20744@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1611222139450.15296@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932474AbcKVWZG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 22 Nov 2016 17:25:06 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 226CC61B9C
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 22:25:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1611222139450.15296@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: sjust@redhat.com, ceph-devel@vger.kernel.org

On 22/11/2016, Sage Weil wrote:
> Hmm.  What if the weights are alternatives based on num_rep, but
> rather based on r (or rather which replica we are choosing).  So the
> first choice is based on the actual weights.  The second choice is
> based on the r=2 weights.  The third choice is based on r=3 weights.
>
> In a perfect world, those weights are actually a function of our
> previous selection(s); in this case, since that is not
> computationally feasible (right?), we can precalculate values that
> are "average" for possible prior choices. It'd be a bit more
> complicated, but assume for a moment that we could do this...

So! We /can/ do something like this. A 'cumulative' reweighting, where
we calibrate r=n as a correction on r=n-1.

The downsides would be that there are fewer 'possible' distributions
if we skew per-round. (That is, there are distributions we can achieve
adjusting everything up-front that we can't achieve going per-round.)
I'm strongly suspect that as our maximum 'r' goes up the difference
between possible all-at-once distributions and possible per-round
distributions gets bigger.

Second, currently every OSD has an equal chance of being the primary,
secondary, tertiary... Under this scheme the lowest weight OSDs would
be the primary for a disproportionately large share of the objects
they hold. If we assume that low-weight OSDs are smaller machines and
primaries do more work than secondaries, this might be bad.

Third, it would be more computationally intensive. Especially if we
want to support a large bucket where each OSD has a unique weight
shared by no other OSD. I don't nkow HOW intensive (and there's room
to try and make things smarter) but it might be unavoidably quite long
for large buckets.

If those don't seem too bad as tradeoffs, we can do something along
these lines and I'll get to hammering at it. It seems like a fairly
large amount of complexity for the problem being solved, but that all
depends on how much the Distribution Surprise is biting people, I
guess.

I /suspect/ we will want to support the old, unmodified mode of
operation on a scale finer than a CRUSH tunable.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
