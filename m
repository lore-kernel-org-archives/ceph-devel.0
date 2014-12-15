From: Sage Weil <sage@newdream.net>
Subject: Re: Improving latency and ordering of the backfilling workload
Date: Mon, 15 Dec 2014 09:20:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412150913400.5263@cobra.newdream.net>
References: <548EEF2C.1010703@dachary.org> <alpine.DEB.2.00.1412150841220.5263@cobra.newdream.net> <548F15E5.2030304@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41712 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbaLORUF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 12:20:05 -0500
In-Reply-To: <548F15E5.2030304@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 15 Dec 2014, Loic Dachary wrote:
> Hi Sage,
> 
> On 15/12/2014 17:44, Sage Weil wrote:
> > On Mon, 15 Dec 2014, Loic Dachary wrote:
> >> Hi Sam,
> >>
> >> Here is what could be done (in the context of http://tracker.ceph.com/issues/9566
> >> ), please let me know if that makes sense:
> >>
> >> * ordering:
> >>
> >>   * when dequeuing a pending local reservation, chose one that contains 
> >> a PG that belongs to the busiest OSD (i.e. the OSD for which there are 
> >> more PGs waiting for a local reservation than any other)
> > 
> > I'm worried the reservation count won't be an accurate enough proxy for 
> > the amount of work the remote OSD has to do.  
> 
> Are you thinking about taking into account the number and size of 
> objects in a given PGs ? The length of the local reservation queue 
> accurately reflects the number of PGs that need work (because the length 
> of the reservation queue is not bounded). But it does not reflect the 
> content of the PGs at all, indeed.

Including that information could help, yeah, but the main thing is that 
any estimate of "the busiest OSD" based on local information is going to 
be weak if it's only based on info reservation requests.  Unless that 
information is refreshed periodically by the requesting OSD (I think we 
also discussed that a bit last week).

> It would be very easy to 
> > piggyback some load information on the heartbeat messages which we should 
> > already be exchanging with anyone we would backfill with.
> > 
> > If we go down that path, there are a bunch of patches in the wip-read-hole 
> > series that lay useful groundwork.  Getting that branch into shape 
> > is the next big item after I finish the current batch of pull 
> > requests.
> 
> Would you mind telling me which of 
> https://github.com/ceph/ceph/commits/wip-read-hole commits are relevant 
> ? I assume 
> https://github.com/ceph/ceph/commit/ee72f699e236371a5b8651cd900013a2bd2227fb 
> is to some extent.

Yeah that's the one.  There's a later patch that give each PG a handy 
reference to that struct for the acting set (for quick access), though in 
this case not all backfill peers will be in acting.

Note that there is also a osd_peer_stat_t struct in MOSDPing that is 
currently unused cruft.  We could replace/supplement that with whatever 
information we thing would be helpful.

If we go down that path at least.. I think ahve reservers refresh their 
reservation periodically with updated priorities would also work.

sage


> 
> Cheers
> 
> >>   * when sending a remote reservation request, set the priority to 
> >> reflect the total number of pending PG (absolute workload) and the 
> >> number local pending PG for the destination OSD (workload queued locally 
> >> for the remote OSD)
> >>   * on the receiving side, the priority of the remote reservation 
> >> request makes sure the busiest OSD gets a remote reservation before the 
> >> others
> >>
> >> * reducing latency:
> >>   
> >>   * if there are N pending remote reservations, reject a remote 
> >> reservation request instead of queuing it so that the local reservation 
> >> can be used instead of waiting.
> >>
> >> Cheers
> >>
> >> -- 
> >> Lo?c Dachary, Artisan Logiciel Libre
> >>
> >>
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 
