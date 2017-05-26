From: Sage Weil <sweil@redhat.com>
Subject: Re: Adding / removing OSDs with weight set
Date: Fri, 26 May 2017 13:41:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705261334290.3646@piezo.novalocal>
References: <e794a980-b701-a8b1-a2ee-b0f13bd23831@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764826AbdEZNlS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 26 May 2017 09:41:18 -0400
In-Reply-To: <e794a980-b701-a8b1-a2ee-b0f13bd23831@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 26 May 2017, Loic Dachary wrote:
> Hi Sage,
> 
> If weight set are created and updated, either offline via "crush 
> optimize" (possible now) or via a ceph-mgr task (hopefully in the 
> future), adding and removing OSDs won't work via the ceph cli 
> (CrushWrapper errors out on create_or_move_item which is what osd crush 
> create-or-move needs, for instance).
> 
> Requiring a workflow where OSDs must be added to the crushmap instead of 
> the usual ceph osd crush create-or-move is impractical. Instead, 
> create_or_move_item should be modified to update the weight sets, if 
> any. What we could not figure out a few weeks ago is which values make 
> sense for a newly added OSD.
> 
> Assuming the weight set are updated via an incremental rebalancing 
> process, I think the weight set of a new OSD should simply be zero for 
> all positions and the target weight is set as usual. The next time the 
> rebalancing process runs, it will set the weight set to the right value 
> and backfilling will start. Or, if it proceeds incrementally, it will 
> gradually increase the weight set until it reaches the optimal value. 
> From the user perspective, the only difference is that backfilling does 
> not happen right away, it has to wait for the next rebalancing update.

This is interesting!  Gradually weighting the OSD in is often a 
good/desired thing anyway, so this is pretty appealing.  But,

> Preparing an OSD to be decomissionned can be done by setting the target 
> weight to zero. The rebalancing process will (gradually or not) set the 
> weight set to zero and all PGs will move out of the OSD.

more importantly, we need to make things like 'move' and 'reweight' work, 
too.

I think we should assume that the choose_args weights are going 
to be incrementally different than the canonical weights, and make all of 
these crush modifications make a best-effort attempt to preserve them.  

- Remove is simple--it can just remove the entry for the removed item.

- Add can either do zeros (as you suggest) or just use the canonical 
weight (and let subsequent optimization optimize).

- Move is trickier, but I think the simplest is just to treat it as an add 
and remove.

- Similarly, when you add or move and item, the parent buckets' weights 
increase or decrease.  For those adjustments, I think the choose_args 
weights should be scaled proportionally.  (This is likely to be the 
"right" thing both for optimizations of the specific pgid inputs, and 
probably pretty close for the multipick-anomaly optimization too.)

That leaves the 'add' behavior as the big question mark (should it start 
at 0 or at the canonical weight).  My inclination is to go with either the 
canonical weight or have an option to choose which you want (and have that 
start at the canonical weight).  It's not going to make sense to start at 
0 until we have an automated mgr thing that does the optimization and 
throttles itself to move slowly.  Once that is in place then having things 
weight up from 0 makes a lot of sense (even as the default) but until then 
I don't think we can have a default behavior rely on an external 
optimization process being in place...

What do you think?
sage
