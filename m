From: Christian Balzer <chibi@gol.com>
Subject: Re: [ceph-users] mark out vs crush weight 0
Date: Thu, 19 May 2016 11:57:07 +0900
Message-ID: <20160519115707.123d3597@batzmaru.gol.ad.jp>
References: <alpine.DEB.2.11.1605181713350.30956@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:42081 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbcESC5M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2016 22:57:12 -0400
In-Reply-To: <alpine.DEB.2.11.1605181713350.30956@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com


Hello Sage,

On Wed, 18 May 2016 17:23:00 -0400 (EDT) Sage Weil wrote:

> Currently, after an OSD has been down for 5 minutes, we mark the OSD 
> "out", whic redistributes the data to other OSDs in the cluster.  If the 
> OSD comes back up, it marks the OSD back in (with the same reweight
> value, usually 1.0).
> 
> The good thing about marking OSDs out is that exactly the amount of data 
> on the OSD moves.  (Well, pretty close.)  It is uniformly distributed 
> across all other devices.
> 
Others have commented already on how improve your initial suggestion
(retaining CRUSH weights) etc.
Let me butt in here with an even more invasive but impact reducing
suggestion.

Your "good thing" up there is good as far as total data movement goes, but
it still can unduly impact client performance when one OSD becomes both
the target and source of data movement at the same time during
backfill/recovery. 

So how about upping the ante with the (of course optional) concept of a
"spare OSD" per node?
People are already used to the concept, it also makes a full cluster
situation massively more unlikely. 

So expanding on the concept below, lets say we have one spare OSD per node
by default. 
It's on a disk of the same size or larger than all the other OSDs in the
node, it is fully prepared but has no ID yet. 

So we're experiencing an OSD failure and it's about to be set out by the
MON, lets consider this sequence (OSD X is the dead, S the spare one:

1. Set nobackfill/norecovery
2. OSD X gets weighted 0
3. OSD X gets set out
4. OSD S gets activated with the original weight of X and its ID.
5. Unset nobackfill/norecovery

Now data will flow only to the new OSD, other OSDs will not be subject to
simultaneous reads and writes by backfills. 

Of course in case there is no spare available (not replaced yet or
multiple OSD failures), Ceph can go ahead and do it's usual thing,
hopefully enhanced by the logic below.

Alternatively, instead of just limiting the number of backfills per OSD
make them directionally aware, that is don't allow concurrent read and
write backfills on the same OSD.

Regards,

Christian
> The bad thing is that if the OSD really is dead, and you remove it from 
> the cluster, or replace it and recreate the new OSD with a new OSD id, 
> there is a second data migration that sucks data out of the part of the 
> crush tree where the removed OSD was.  This move is non-optimal: if the 
> drive is size X, some data "moves" from the dead OSD to other N OSDs on 
> the host (X/N to each), and the same amount of data (X) moves off the
> host (uniformly coming from all N+1 drives it used to live on).  The
> same thing happens at the layer up: some data will move from the host to
> peer hosts in the rack, and the same amount will move out of the rack.
> This is a byproduct of CRUSH's hierarchical placement.
> 
> If the lifecycle is to let drives fail, mark them out, and leave them 
> there forever in the 'out' state, then the current behavior is fine, 
> although over time you'll have lot sof dead+out osds that slow things
> down marginally.
> 
> If the procedure is to replace dead OSDs and re-use the same OSD id,
> then this also works fine.  Unfortunately the tools don't make this easy
> (that I know of).
> 
> But if the procedure is to remove dead OSDs, or to remove dead OSDs and 
> recreate new OSDs in their place, probably with a fresh OSD id, then you 
> get this extra movement.  In that case, I'm wondering if we should allow 
> the mons to *instead* se the crush weight to 0 after the osd is down for 
> too long.  For that to work we need to set a flag so that if the OSD
> comes back up it'll restore the old crush weight (or more likely make
> the normal osd startup crush location update do so with the OSDs
> advertised capacity).  Is it sensible?
> 
> And/or, anybody have a good idea how the tools can/should be changed to 
> make the osd replacement re-use the osd id?
> 
> sage
> 
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 


-- 
Christian Balzer        Network/Systems Engineer                
chibi@gol.com   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
