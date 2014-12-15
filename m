From: Sage Weil <sage@newdream.net>
Subject: Re: Improving latency and ordering of the backfilling workload
Date: Mon, 15 Dec 2014 08:44:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412150841220.5263@cobra.newdream.net>
References: <548EEF2C.1010703@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41409 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbaLOQoe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 11:44:34 -0500
In-Reply-To: <548EEF2C.1010703@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Samuel Just <sam.just@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 15 Dec 2014, Loic Dachary wrote:
> Hi Sam,
> 
> Here is what could be done (in the context of http://tracker.ceph.com/issues/9566
> ), please let me know if that makes sense:
> 
> * ordering:
> 
>   * when dequeuing a pending local reservation, chose one that contains 
> a PG that belongs to the busiest OSD (i.e. the OSD for which there are 
> more PGs waiting for a local reservation than any other)

I'm worried the reservation count won't be an accurate enough proxy for 
the amount of work the remote OSD has to do.  It would be very easy to 
piggyback some load information on the heartbeat messages which we should 
already be exchanging with anyone we would backfill with.

If we go down that path, there are a bunch of patches in the wip-read-hole 
series that lay useful groundwork.  Getting that branch into shape 
is the next big item after I finish the current batch of pull 
requests.

>   * when sending a remote reservation request, set the priority to 
> reflect the total number of pending PG (absolute workload) and the 
> number local pending PG for the destination OSD (workload queued locally 
> for the remote OSD)
>   * on the receiving side, the priority of the remote reservation 
> request makes sure the busiest OSD gets a remote reservation before the 
> others
> 
> * reducing latency:
>   
>   * if there are N pending remote reservations, reject a remote 
> reservation request instead of queuing it so that the local reservation 
> can be used instead of waiting.
> 
> Cheers
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 

