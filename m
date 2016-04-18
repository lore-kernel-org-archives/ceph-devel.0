From: Sage Weil <sage@newdream.net>
Subject: OSDMap partitioning
Date: Mon, 18 Apr 2016 10:00:18 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604180945280.4797@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54995 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcDROAS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 10:00:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, 15 Apr 2016, Adam C. Emerson wrote:
> 
> # Map Partitioning #
> 
> There are two huge problems with scalability in Ceph.
> 1.  The OSDMap knows too many things
> 2.  A single monitor manages all updates of everything and replicates them to
>     other monitors.
> 
> ## Too Big to Not Fail ##
> 
> The monitor map and MDS maps are fine. Each holds data needed to
> locate servers and that's it. It would be very hard to put enough data
> in them to cause problems. The OSD map however contains a trove of data that
> must be updated serially in Paxos and propagated to every OSD,
> monitor, MDS, and client in the cluster.
> 
> Pools are a notorious example. We can't create as many pools as users
> would like. Pools are heavyweight, and while they depend on other
> items in the OSD map (like erasure code profiles), it would be nice if
> we divide them between several monitor clusters, each of which would
> hold a subset of pools. We would need to make sure that clients had up
> to date versions of whatever pools they are using along with the
> status of the OSDs they're speaking to, but that's not
> impossible. Likewise, we should split placement rules out of the OSD
> map, especially once we get into larger numbers of potentially larger
> Flexible Placement style functions.
> 
> Nodes should then only need to subscribe to the set of pools and
> placement functions they need to access their data. Changes like these
> should allow users to create the number of pools they want without
> causing the cluster difficulty.

I'm not sure I'm convinced.  The mon is doing way more than it should 
right now, but we are about to rip all/most of the PGMonitor work out of 
ceph-mon and move it into ceph-mgr. At that point, the OSDMap is a pretty 
small burden for the mon to manage.  Even if we have clusters that are 2 
orders of magnitude larger (100,000 OSDs), that's maybe a 100MB data 
structure at most.  Why do we need to partition it?

I get that pools are heavyweight, but I think that derivse from the fact 
that it is a *placement* function, and we *want* placement to be an 
administrative property, not a tentant/user property that can proliferate. 
Placement should depend on the hardware that comprises the cluster, and 
that doesn't change so quickly, and the scale does not change quickly.
Tenants want to create their own workspaces to do their thing, but I think 
needs to remain a slice within the existing placement primitives so they 
do't have direct control.  e.g., rados namespaces, or something more 
powerful if we need it, because we'll have anywhere from 1 tenant to a 
million tenants, and we can't have them spamming the cluster 
placement topology.

At least, I think that's true on the OSD side of things.  On the client 
side, might make sense to limit the client's view to certain pools.  
Maybe.

Anyway, assuming we have some tenant primitive (like namespace slice of a 
pool), I don't see the motivation for the huge complexity of breaking 
apart OSDMap.  What am I missing?

> ### Consistency ###
> 
> Partitioning makes consistency harder. A simple remedy might be to
> stop referring to data by name or integer. An erasure code profile
> should be specified by UUID and version. So should pools and placement
> functions. When sending a request to the OSD, a client should send the
> versions of the pool, the ruleset, and the OSDMap it used and the OSD
> should check that all three are current.
> 
> ## The OSD Set ##
> 
> The complicating case here is the OSD status set.  Running this
> through a single Paxos limits the number of OSDs that can coexist in a
> cluster.  We ought split the set of OSDs between multiple masters to
> distribute the load. Each 'Up' or 'Down' event is independent of
> others, so all we require is that events get propagated into the
> correct OSDs and primaries and followers act as they're supposed to.
> 
> Versioning is a bigger problem here. We might have all masters
> increment their version when one increments its version if that could
> be managed without inefficiency. We might send a compound version with
> `MOSDOp`s, but combining that with the compound version above might be
> unwieldly. (Feedback on this issue would be greatly appreciated.)
> 
> ### Subscription ###
> 
> For a large number of OSDs, it would be nice if not everyone were
> notified of all state changes.
> 
> For a pool whose placement rule spans only a subset of all OSDs,
> clients using that pool should be able to subscribe to a subset of the
> OSD set corresponding to that pool. This should be fairly easy so long
> as the subset is explicit.
> 
> In the case of pools not providing an explicit subset, a monitor (or
> perhaps a proxy in front of a set of monitors) could look at common
> patterns of subscription requests and merge those with significant
> overlap together, so as to give clients a subset without being
> destroyed by the irresistible force of combinatorial explosion.

The OSDMap sharing is gossip-based and (I think) lightweight.  
OSDMap::Incrementals are small.  Is this really going to be a problem?


Now, going in a somewhat tangential direction... what I *am* worried about 
is the failure granularity.  Right now we have an up/down state for an 
OSD, and all PG shards live or die together.  But it seems like we might 
want to localize a failure to a PG, so that if we have some media error, 
or we encounter some metadata corruption, we can fail a PG in isolation 
without taking down the other ~99 on the device.  Having a 
fail-pg-but-don't-crash mode of operation will also be really helpful when 
we have multiple OSDs living within the same process.

Perhaps that's just a map of PG states (that includes down), similar to 
pg_temp, that gets bundled into the OSDMap...

sage

