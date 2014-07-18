From: Gregory Farnum <greg@inktank.com>
Subject: Re: Disabling CRUSH for erasure code and doing custom placement
Date: Fri, 18 Jul 2014 11:14:41 -0700
Message-ID: <CAPYLRzi1vBwVon1Zbb08xWUuJM7R=GR=16YZOLHoHvGNxyHFcQ@mail.gmail.com>
References: <CALUBZ__98nzUjucW9NmFKEHzPFvu0yY0X5yHEtFH7g9QkhqSAQ@mail.gmail.com>
	<CAPYLRzgeb2DB_tJfRFvK1gk5XEYYd7mgHH5E5URqYsn_2bH4mQ@mail.gmail.com>
	<CALUBZ_-gBR2KHMQcGe65+GDHE3xC+Fq9_J+DZLDqf+7LQHrq6g@mail.gmail.com>
	<CAPYLRzhoiP7t81VG5FEgo53xP9GVMOu6e8zQdwU+HxF2gB7HRQ@mail.gmail.com>
	<CFEEFD16.5F5CB%kaifeng@yahoo-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:53556 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030597AbaGRSOn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jul 2014 14:14:43 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so3927875wgh.32
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jul 2014 11:14:41 -0700 (PDT)
In-Reply-To: <CFEEFD16.5F5CB%kaifeng@yahoo-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kaifeng Yao <kaifeng@yahoo-inc.com>
Cc: Shayan Saeed <shayansaeed93@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jul 18, 2014 at 2:12 AM, Kaifeng Yao <kaifeng@yahoo-inc.com> wrote:
> I was thinking about 'PG preferred' to allow binding a PG's placement to
> arbitrary OSDs. My angle is to make the PG more evenly distributed across
> OSDs, thus to potentially save ~20% cost. I am searching the 'pg
> preferred' implementation in CEPH to get more context.

The pg preferred implementation doesn't exist any more (it was
difficult to maintain and its primary use case didn't really benefit
from using it anyway), and since it required remembering which objects
were in which PGs it really only made sense for systems which already
had a metadata overhead which could easily remember that (eg, the
filesystem...it was really added for Hadoop).

> For the PG -> OSD distribution problem, we have tried the after-fact
> reweight-by-utilization, which results heavy data movements, and finally
> the PG/OSD variation dropped from +- 2x% to +- 1x%. We also tried
> pre-reweight right after the pool creation but before any data is stored.
> Similar to reweight-by-utilization but here the weight is calculated by
> PGs per OSD. In this way it can run several rounds of iterations
> relatively quicker and the variation can drop to +- 10%. Neither is good
> enough. So I wonder if we can work around CRUSH placement for this case.
>
> Here are the scenarios I am thinking about:
> Admin can create a pool with a given crush rule, then adjust the PG's
> 'preferred OSD' to its one or several replicas (or EC strips). Basically
> if OSD #n is overloaded and OSD #m is less occupied, then we enumerate the
> PGs that have some replica on OSD #n, and move that replica to #m. This
> process can be automated. After some iterations it should be very close to
> uniform distribution (+- 5% variation or less?).

This isn't quite how pg preferred placement worked even when we had it
in the code base; my recollection is that it forced the *primary* for
an OSD to be the preferred location, but then it used CRUSH for the
others in its normal order. So unless the OSD you were trying to get
data off of was the last one in the proper mapping, this wouldn't
actually remove data from it.
Also, we never tried changing the preferred_pg on existing PGs; rather
we created special "local" PGs for each OSD. Even if it was worth
resurrecting preferred placement for this (I'm not convinced), there
are probably a lot of bugs and other issues to work out with flipping
the preferred value on and off.

>
> Some more stuff to consider:
> 1) The setting takes effect only if it complies to the CRUSH rule, and the
> OSD is in.
> 2) For scaling out/in cases, the preferred flags have to be recalculated
> to make the distribution even again. It is not so good as CRUSH's
> consistent hashing. But this can be automated too.

Something we've discussed (blue-skied, really) adding in the past is a
system that takes as inputs the data weighting you *want* your OSDs to
have, and then runs a bunch of CRUSH mapping simulations to try and
figure out the optimal CRUSH weights to apply to actually *get* that
distribution. Something like this obviously still relies on data being
distributed evenly across the hash space, but with a bit of compute
time should be able to figure out the weighting values to put in
everywhere so that the pseudo-random calculation actually distributes
PGs evenly (most imbalances are generally because of disparities in PG
counts on an OSD, and the disparity in size between PGs that cover
double hash space, not disparities in data concentration on the hash
space).
The downside to something like this is that the weights could change a
fair bit when growth; nobody's modeled how that would or would not
change.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
