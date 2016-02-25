From: Sage Weil <sage@newdream.net>
Subject: Re: Trying to reduce OSD start-up impact on busy clusters
Date: Wed, 24 Feb 2016 19:12:56 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602241902560.7555@cpach.fuggernut.com>
References: <CAANLjFoGHbiWMLbHLNSD+roBvuWYUqrwO3dpt5bUbhx77kjWkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58394 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbcBYAN0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Feb 2016 19:13:26 -0500
In-Reply-To: <CAANLjFoGHbiWMLbHLNSD+roBvuWYUqrwO3dpt5bUbhx77kjWkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 24 Feb 2016, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> I've been looking through the code the last couple of days trying to
> figure out how to reduce the start-up impact of OSD on busy clusters
> or OSDs that are constrained on RAM. What I see in the logs is right
> after "state: booting -> active" client OPs (both client and repops)
> are getting queued at the OSD even though none of the PGs are active.
> This causes at least 20 seconds of latency for the first OPs to get
> serviced (at least on my test cluster), and that is really bad for
> RBD.
> 
> So I was looking for a way to delay the client I/O to the OSD until at
> least the PG was active. It would be nice if I could even delay the
> PGMap until after at least one attempt of recovery was tried so that
> on busy clusters there isn't a huge backlog of OPs blocked waiting for
> a long list of RepOps that have been queued from the newly started PGs
> who now have client OPs to service.
> 
> My first thought was when a client OP came in and the PG was not
> active, then create a pg_temp and NACK the client (I think a pg_temp
> would make the client retry anyway). I thought this might be dirty and
> get some client OPs out of order and in any case add latency (bad for
> RBD). But on idle clusters, there wouldn't need to be a pg_temp for
> each PG.
> 
> My second thought was in load_pgs create the pg_temp there so that at
> start_boot it would just have the "right" PGMap to begin with and the
> clients just keep using the original OSDs until later when the pg_temp
> is removed after the PG has been recovered. I have a feeling that this
> will not work because the other OSDs won't see that this OSD is up and
> ready to start recovery/backfill. If the other OSDs can know that this
> one is up because it contacts them and shares a map, will it suddenly
> start sending it repops? I'm really not sure on this and could use
> some help.
> 
> If I can get this pg_temp thing to work, then it is possible to try
> and do much of the recovery as fast as possible before any client load
> even hits it. Since only recovery OPs would be hammering the disk,
> there is no need to slow it down, or at least throttle it so much.
> 
> Here is a workflow that I can see working:
> 1. load_pgs - create pg_temp
> 2. start_boot
> 3. walk through each PG
> 3a. recover the PG, if it is the second iteration, activate the PG by
> removing the pg_temp
> 4. Loop through 3 twice, the first to catch up the PGs as fast as
> possible, the second to activate them.

So, 1-3ish should sort of already be happening, but in a slightly 
different way: mon/OSDMonitor.cc should be calling the 
maybe_prime_pg_temp() and prime_pg_temp(), which should identify which PG 
mappings are about to change and install pg_temp mappings with their prior 
mappings.  That way the same OSDMap epoch that shows the OSD coming up 
*also* has the pg_temp keeping it out of the acting set.  Then, when 
peering completes and if backfill isn't necessary the mapping will be 
removed.

First, I would verify that this is actually happening.. it sounds like 
maybe it isn't... and if not we should fix that.  Maybe reproduce one of 
these transitions (bringing a down OSD back up) and see what happens?

But, assuming it is, I think the main thing that can be done is to change 
the peering code to do any log based recovery too to the up but not acting 
osd before removing the pg_temp mapping.  That way, when the pg_temp 
mapping is removed, it should be a very fast peering transition.

I think the last thing that is probably slowing things down is that on any 
peering transition there is the up_thru update that has to be applied on 
the mon before the PG can go active.  This can be slow.  It's there so 
that a series of OSDMap changes don't get us in a situation where there 
are mappings that the map had that the OSDs never realized, the OSDs then 
failed, and we cannot peer because we're stuck trying to probe OSDs 
that never wrote data.  (This is the maybe_went_rw logic in PG.cc and 
osd_types.cc and we'll need to be very careful making optimizations here.)

sage
