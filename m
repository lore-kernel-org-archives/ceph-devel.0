From: Sage Weil <sage@inktank.com>
Subject: Re: cache pool user interfaces
Date: Fri, 28 Feb 2014 07:21:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402280711240.17508@cobra.newdream.net>
References: <CAPYLRziGSJAjf3CvvOAy8euAr-0vCzM3GX8K6D_z214w-Nu4aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50825 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbaB1PV0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Feb 2014 10:21:26 -0500
In-Reply-To: <CAPYLRziGSJAjf3CvvOAy8euAr-0vCzM3GX8K6D_z214w-Nu4aw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Neil Levine <neil.levine@inktank.com>, ceph-devel@vger.kernel.org

On Wed, 26 Feb 2014, Gregory Farnum wrote:
> We/you/somebody need(s) to sit down and decide on what kind of
> interface we want to actually expose to users for working with caching
> pools. What we have right now is very flexible, but it's hard to test
> all the combinations and it's easy for users to get themselves into
> trouble.
> I know we've in the past discussed making all the configuration
> options into a single "create cache pool" command that accepts
> whatever we're interested in, and I think that's the model we want to
> go towards right now. But we're running out of time to make that
> change given the release deadline and the documentation that needs to
> be generated (eg http://tracker.ceph.com/issues/7547).

Right now the sequence is:

       ceph osd pool create cache $num_pgs
       ceph osd tier add base cache
       ceph osd tier cache-mode cache writeback
       ceph osd tier set-overlay base cache
       ceph osd pool set cache hit_set_type bloom
       ceph osd pool set cache hit_set_count 8
       ceph osd pool set cache hit_set_period 60
       ceph osd pool set cache target_max_objects 5000

(modulo some sane defaults, and the target size)

I mostly like the flexibility this presents and don't forsee any major 
problems, but nevertheless I agree that a friendly interface is safer to 
advertise and, well, friendlier.  How about:

       ceph osd pool create cache $num_pgs

(I think think this should be a separate step since users will want/need 
to adjust the crush rule and so forth to put this on the right devices 
*before* it gets set as an overlay and gets hammered by the existing 
pool's workload.)  Then

       ceph osd tier add-cache base cache

which would do the other 3 tier steps and set some sane hit_set defaults.
What do you think?

Separately:

1- I'm not sure what the default target size should be set to; maybe a 
default of 10000 objects or something?  I think it should be *something*.

2- I think we need to bite the bullet and make a 'ceph df' function that 
figures out how much space is available on a per-pool basis.  It would:
 - figure out which osds are toched by the rules for each pool, and
 - sum up only those osds' usages
 - divide by the replication factor or EC storage overhead
If there target_max_* values aren't set for the pool, this could be used 
instead, by periodically filling in a pg_pool_t approximate_capacity type 
field.  Of course, for multiple pools this is double counting free space, 
but for the purposes of the cache agent it is still perfectly usable as a 
target for controlling when the agent kicks into gear.  It would also be 
very nice for users.  (Hmm, perhaps I should write this up in a 
blueprint!)

sage


