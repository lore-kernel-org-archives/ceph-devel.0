From: Sage Weil <sweil@redhat.com>
Subject: mark out vs crush weight 0
Date: Wed, 18 May 2016 17:23:00 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605181713350.30956@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60908 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959AbcERVWo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 May 2016 17:22:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

Currently, after an OSD has been down for 5 minutes, we mark the OSD 
"out", whic redistributes the data to other OSDs in the cluster.  If the 
OSD comes back up, it marks the OSD back in (with the same reweight value, 
usually 1.0).

The good thing about marking OSDs out is that exactly the amount of data 
on the OSD moves.  (Well, pretty close.)  It is uniformly distributed 
across all other devices.

The bad thing is that if the OSD really is dead, and you remove it from 
the cluster, or replace it and recreate the new OSD with a new OSD id, 
there is a second data migration that sucks data out of the part of the 
crush tree where the removed OSD was.  This move is non-optimal: if the 
drive is size X, some data "moves" from the dead OSD to other N OSDs on 
the host (X/N to each), and the same amount of data (X) moves off the host 
(uniformly coming from all N+1 drives it used to live on).  The same thing 
happens at the layer up: some data will move from the host to peer hosts 
in the rack, and the same amount will move out of the rack.  This is a 
byproduct of CRUSH's hierarchical placement.

If the lifecycle is to let drives fail, mark them out, and leave them 
there forever in the 'out' state, then the current behavior is fine, 
although over time you'll have lot sof dead+out osds that slow things down 
marginally.

If the procedure is to replace dead OSDs and re-use the same OSD id, then 
this also works fine.  Unfortunately the tools don't make this easy (that 
I know of).

But if the procedure is to remove dead OSDs, or to remove dead OSDs and 
recreate new OSDs in their place, probably with a fresh OSD id, then you 
get this extra movement.  In that case, I'm wondering if we should allow 
the mons to *instead* se the crush weight to 0 after the osd is down for 
too long.  For that to work we need to set a flag so that if the OSD comes 
back up it'll restore the old crush weight (or more likely make the 
normal osd startup crush location update do so with the OSDs advertised 
capacity).  Is it sensible?

And/or, anybody have a good idea how the tools can/should be changed to 
make the osd replacement re-use the osd id?

sage


