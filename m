From: Sage Weil <sage@inktank.com>
Subject: avoiding data migration for cold rados pool
Date: Wed, 29 Oct 2014 11:10:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410291050550.24169@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38050 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbaJ2SKz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 14:10:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: grawinkel@uni-mainz.de, ml@irq0.org
Cc: ceph-devel@vger.kernel.org

Hi Matthias, Marcel,

Thanks for the discussion yesterday on a cold storage tier[1].  I think 
the idea of minimizing/preventing migration of data for a particular RADOS 
pool while still minimizing placement metadata (i.e., no MDS) is very 
interesting and has lots of possible applications.  I thought I'd 
summarize what I was suggesting yesterday in case it didn't come across 
well verbally.

The basic tradeoff is around placement metadata.  In RADOS we have a 
compact OSDMap structure on the client that lets you calculate where any 
object is based on a simple policy (pool properties, CRUSH map) and OSD 
state (up/down/in/out, current IP address).  If placement of an object 
is purely a function of the name and the cluster state, then generally 
when the cluster changes data will move.

To avoid that, my suggestion is to incorporate a timestamp into part of 
the name (say, a prefix).  Then placement becomes a function of an 
arbitrary string, time written (which together form the object name), and 
cluster state.  This would normally mean a metadata layer so that you can 
tell that 'foo' was written at time X and is actually 'X_foo'.  But, if we 
combine it with the proposed RADOS redirect mechanism, then the active 
storage tier would have a zillion pointers (stored as 'foo') that point 
off into some cold tier with the correct name ('X_foo').  Basically, 
another RADOS pool becomes that metadata layer.  At that point it needn't 
even be 'X_foo'.. it could be X-anything, as long as it is unique and has 
the timestamp X in there to inform placement.

For the placement thing, my suggestion is to look at the basic idea behind 
the original RUSH-L algorithm (reimplemented as CRUSH list buckets), 
originally described in this paper

http://pdf.aminer.org/000/409/291/replication_under_scalable_hashing_a_family_of_algorithms_for_scalable.pdf

The core idea is that at a point in time, data is distributed in a 
particular way.  In the base case, we just hash/stripe over a set of 
identical nodes.  Each time we deploy new gear, we "patch" the previous
distribution, so that some % of objects are instead placed on the new 
gear.  This approach has various flaws, mainly when it comes to removing 
old gear, but I think the idea of patching the previous distirbution can 
be applied here.  

Currently, we do:

 object_name
 hash(object_name) % pg_num -> ps (placement seed)
 (ps, poolid) -> pgid
 crush(pgid) -> [set of osds]

Here, we could define a series of time intervals, and for each interval, 
we would create a new set of PGs.  More like:

 (name, timestamp)
 hash(object_name) % interval_pg_num -> ps
 (ps, poolid, interval #) -> tpgid
 crush(tpgid) -> [set of osds]

The trick would be that for each time interval, CRUSH would define how the 
objects distribute.  When they fill or new hardware is deployed, we'd 
close out the current interval and start a new interval that mapped to 
new PGs that CRUSH mapped to new hardware.

Hmm, you could actually do this by simply creating a new RADOS pool for 
every interval and not changing anything in the existing code at all.  As 
HW in old pools fails you'd have to include some new HW in the mix to 
offload some content.  There are probably some changes we can do 
there to avoid writing anything new to the surviving full nodes (that case 
is awkward to handle currently).  Or, there may be benefits to pulling 
this functionality into a new approach within CRUSH.. I'm not sure.  
Would need to think about it a bit more ...

sage

[1]
 http://pad.ceph.com/p/hammer-cold_storage
 https://wiki.ceph.com/Planning/Blueprints/Hammer/Towards_Ceph_Cold_Storage
 http://youtu.be/FARNRvYMQJ4
