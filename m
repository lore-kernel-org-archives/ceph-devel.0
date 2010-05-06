From: Sage Weil <sage@newdream.net>
Subject: Re: RBD/OSD questions
Date: Thu, 6 May 2010 14:22:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005061415070.18563@cobra.newdream.net>
References: <190959.13001.qm@web36108.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58297 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab0EFVTj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 May 2010 17:19:39 -0400
In-Reply-To: <190959.13001.qm@web36108.mail.mud.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Fick <mogulguy@yahoo.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 6 May 2010, Martin Fick wrote:
> > For cold objects, shedding could help, but only if 
> > there is a sufficient load disparity between replicas to 
> > compensate for the overhead of shedding.
> 
> I could see how "shedding" as you mean it would 
> add some overhead, but a simple client based 
> fanout shouldn't really add much overhead.  You 
> have designed CRUSH to allow fast direct IO with 
> the OSDs, shedding seems to be a step backwards 
> performance wise from this design, but client 
> fanout to replicas directly is really not much 
> different than stripping using CRUSH, it should 
> be fast!
> 
> If this client fanout does help, one way to make
> it smarter, or more cluster responsive would be
> to expose some OSD queue/length info via the 
> client APIs allowing clients themselves to do some
> smart load balancing in these situations.  This 
> could be applicable not just for seeky workloads, 
> but also for unusual workloads which for some 
> reason might bog down a particular OSD.  CRUSH
> should normally prevent this from happening in
> a well balanced cluster, but if a cluster is not
> very heterogenous and has many OSD nodes with
> varying latencies and perhaps other external
> (non OSD) loads on them, your queue length idea 
> with smart clients could help balance such a 
> cluster on the clients themselves.

Yeah, allowing a client to read from other replicas is pretty 
straightforward.  The normal caps mechanism even tells the client when 
this is safe (no racing writes).  The hard part is knowing when it is 
useful (since, in general, it isn't).  The in general the OSDs won't be 
conversing with an individual client frequently enough for it to have 
accurate load information.  I suppose in some circumstances it might be 
(small number of clients and osds, heavy load).

One thing I've thought about is having some way to osds piggyback "this 
client is super hot!" on replies to clients, and clients to piggyback that 
information back to the mds, so that future clients reading that hot file 
can direct their reads to replicas on a per-file basis...

sage
