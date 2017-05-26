From: Loic Dachary <loic@dachary.org>
Subject: Re: Adding / removing OSDs with weight set
Date: Fri, 26 May 2017 18:00:16 +0300
Message-ID: <45e32a02-85ca-87cf-193d-e8821ade99e2@dachary.org>
References: <e794a980-b701-a8b1-a2ee-b0f13bd23831@dachary.org>
 <alpine.DEB.2.11.1705261334290.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52105 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936350AbdEZPA1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 26 May 2017 11:00:27 -0400
In-Reply-To: <alpine.DEB.2.11.1705261334290.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 05/26/2017 04:41 PM, Sage Weil wrote:
> On Fri, 26 May 2017, Loic Dachary wrote:
>> Hi Sage,
>>
>> If weight set are created and updated, either offline via "crush 
>> optimize" (possible now) or via a ceph-mgr task (hopefully in the 
>> future), adding and removing OSDs won't work via the ceph cli 
>> (CrushWrapper errors out on create_or_move_item which is what osd crush 
>> create-or-move needs, for instance).
>>
>> Requiring a workflow where OSDs must be added to the crushmap instead of 
>> the usual ceph osd crush create-or-move is impractical. Instead, 
>> create_or_move_item should be modified to update the weight sets, if 
>> any. What we could not figure out a few weeks ago is which values make 
>> sense for a newly added OSD.
>>
>> Assuming the weight set are updated via an incremental rebalancing 
>> process, I think the weight set of a new OSD should simply be zero for 
>> all positions and the target weight is set as usual. The next time the 
>> rebalancing process runs, it will set the weight set to the right value 
>> and backfilling will start. Or, if it proceeds incrementally, it will 
>> gradually increase the weight set until it reaches the optimal value. 
>> From the user perspective, the only difference is that backfilling does 
>> not happen right away, it has to wait for the next rebalancing update.
> 
> This is interesting!  Gradually weighting the OSD in is often a 
> good/desired thing anyway, so this is pretty appealing.  But,
> 
>> Preparing an OSD to be decomissionned can be done by setting the target 
>> weight to zero. The rebalancing process will (gradually or not) set the 
>> weight set to zero and all PGs will move out of the OSD.
> 
> more importantly, we need to make things like 'move' and 'reweight' work, 
> too.
> 
> I think we should assume that the choose_args weights are going 
> to be incrementally different than the canonical weights, and make all of 
> these crush modifications make a best-effort attempt to preserve them.  
> 
> - Remove is simple--it can just remove the entry for the removed item.
> 
> - Add can either do zeros (as you suggest) or just use the canonical 
> weight (and let subsequent optimization optimize).
> 
> - Move is trickier, but I think the simplest is just to treat it as an add 
> and remove.

Yes. If adding an OSD always sets the weight set to zero it means that moving an OSD from a bucket to another will 

a) move all the PGs it contains to other OSDs because its weight is zero and 
b) receive other PGs at its new location when the weight is set to a non zero value

If it turns out that the PGs in the new location are the mostly the same as the PGs in the old location, it's useless data movement. I can't think of a case where that would happen though. Am I missing something ?

> - Similarly, when you add or move and item, the parent buckets' weights 
> increase or decrease.  For those adjustments, I think the choose_args 
> weights should be scaled proportionally.  (This is likely to be the 
> "right" thing both for optimizations of the specific pgid inputs, and 
> probably pretty close for the multipick-anomaly optimization too.)
> 
> That leaves the 'add' behavior as the big question mark (should it start 
> at 0 or at the canonical weight).  My inclination is to go with either the 
> canonical weight or have an option to choose which you want (and have that 
> start at the canonical weight).  It's not going to make sense to start at 
> 0 until we have an automated mgr thing that does the optimization and 
> throttles itself to move slowly.  Once that is in place then having things 
> weight up from 0 makes a lot of sense (even as the default) but until then 
> I don't think we can have a default behavior rely on an external 
> optimization process being in place...
> 
> What do you think?

I can't think of a scenario where someone would add weight_set (via crush optimize or otherwise) and want a default weight set for a newly added OSD other than zero.

If using crush optimize, rebalancing will start at the root of the rule down to the bucket containing the new OSD. Since adding the OSD modifies the weight to the top of the hierarchy, it is likely to need rebalancing. The most common case is an uneven distribution due to a low number of PGs and we cannot predict which bucket will over or under fill. There is no predictible ratio at any level of the hierarchy because the distribution is uneven in a random way. In general the variance is lower than 50% but in some cases (CERN cluster for instance) it is higher. In the case of the multipick anomaly we know that OSDs with the lowest weights will overfill and those with higher weights will underfill and we could try to figure out a non zero default weight that makes sense but that would be tri
 cky. 

If the weight set are modified with another logic in mind, a zero weight is not going to disturb it. A contrario, a default weight set based on the target weight or the ratio between the target weight and the weight set of other OSDs is unlikely to match whatever rationale was used to set the weight set. And PGs will likely move back and forth uselessly because of that.

In other words, I came to realize that it is highly unlikely that someone will try to manually set the weight set and that whatever tool they are using, a zero weight will always be a sane default. Note that this *only* applies to weight set, if there are choose args and does not otherwise change anything if choose args are not set.

The big question mark for me is your intuition that choose_args weights should be scaled proportionaly. It would be great if you could expand on that so I better understand it.

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
