From: Sage Weil <sage@newdream.net>
Subject: Re: Improving latency and ordering of the backfilling workload
Date: Mon, 15 Dec 2014 10:03:17 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412150959150.22847@cobra.newdream.net>
References: <548EEF2C.1010703@dachary.org> <alpine.DEB.2.00.1412150841220.5263@cobra.newdream.net> <548F15E5.2030304@dachary.org> <alpine.DEB.2.00.1412150913400.5263@cobra.newdream.net> <548F1EDF.5020401@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42207 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaLOSDR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 13:03:17 -0500
In-Reply-To: <548F1EDF.5020401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 15 Dec 2014, Loic Dachary wrote:
> On 15/12/2014 18:20, Sage Weil wrote:
> > On Mon, 15 Dec 2014, Loic Dachary wrote:
> >> Hi Sage,
> >>
> >> On 15/12/2014 17:44, Sage Weil wrote:
> >>> On Mon, 15 Dec 2014, Loic Dachary wrote:
> >>>> Hi Sam,
> >>>>
> >>>> Here is what could be done (in the context of http://tracker.ceph.com/issues/9566
> >>>> ), please let me know if that makes sense:
> >>>>
> >>>> * ordering:
> >>>>
> >>>>   * when dequeuing a pending local reservation, chose one that contains 
> >>>> a PG that belongs to the busiest OSD (i.e. the OSD for which there are 
> >>>> more PGs waiting for a local reservation than any other)
> >>>
> >>> I'm worried the reservation count won't be an accurate enough proxy for 
> >>> the amount of work the remote OSD has to do.  
> >>
> >> Are you thinking about taking into account the number and size of 
> >> objects in a given PGs ? The length of the local reservation queue 
> >> accurately reflects the number of PGs that need work (because the length 
> >> of the reservation queue is not bounded). But it does not reflect the 
> >> content of the PGs at all, indeed.
> > 
> > Including that information could help, yeah, but the main thing is that 
> > any estimate of "the busiest OSD" based on local information is going to 
> > be weak if it's only based on info reservation requests.  
> 
> What other information would be relevant in addition to the number of 
> PGs that need to backfill and their size (objects & bytes) ?

Maybe the background client workload?  If an OSD is more heavily loaded 
than others than it should probably start it's recovery sooner as its rate 
of progress will be a bit lower.

> > Unless that 
> > information is refreshed periodically by the requesting OSD (I think we 
> > also discussed that a bit last week).
> 
> I tried to take that into account by proposing to calculate the priority 
> when the reservation is dequeued from the waiting list instead of when 
> it is added to the waiting list. When the local reservation is dequeued, 
> it gets one of the osd_max_backfill slots in the AsyncReserver and will 
> then get work to do : the delay between calculating the priority and 
> actual backfilling is minimum. The delay actually is the latency between 
> when the remote reservation is sent and when it comes back successfully. 
> By adding the priority to the remote reservation request, we make the 
> peer OSD aware of the local priority and compare it with the priority of 
> the other OSDs asking for a remote reservation. The peer OSD will be 
> grant us a remote reservation quickly if we are the OSD declaring to 
> have most work to do.
> 
> I sense you have something else in mind in terms of algorithm and/or 
> data sources. Hopefully this explanation will allow you to see what I'm 
> missing and guide me ;-)

Oh, I see.  That sounds very reasonable.  I suspect even with this 
approach though it will help to periodically refresh that reservation, 
though, as the remote OSD may have lots of people contending for recovery.  
Whoever is not first in line will be there for a while and their priority 
will likely be less than accurate by the time the next item is dequeued 
there?

Sorry if my drive-by suggestions aren't helping; I'm only half following 
this discussion!

sage
