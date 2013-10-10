From: Sage Weil <sage@inktank.com>
Subject: Re: PG distribution scattered
Date: Thu, 10 Oct 2013 03:57:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310100349400.7703@cobra.newdream.net>
References: <4120b8bc5ae688af65d616f5a487e9bd@niklasgoerke.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40517 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab3JJK5R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Oct 2013 06:57:17 -0400
In-Reply-To: <4120b8bc5ae688af65d616f5a487e9bd@niklasgoerke.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Niklas Goerke <niklas@niklasgoerke.de>
Cc: ceph-devel@vger.kernel.org

On Thu, 10 Oct 2013, Niklas Goerke wrote:
> Hi there
> 
> I'm currently evaluating ceph and started filling my cluster for the first
> time. After filling it up to about 75%, it reported some OSDs being
> "near-full".
> After some evaluation I found that the PGs are not distributed evenly over all
> the osds.
> 
> My Setup:
> * Two Hosts with 45 Disks each --> 90 OSDs
> * Only one newly created pool with 4500 PGs and a Replica Size of 2 --> should
> be about 100 PGs per OSD
> 
> What I found was that one OSD only had 72 PGs, while another had 123 PGs [1].
> That means that - if I did the math correctly - I can only fill the cluster to
> about 81%, because thats when the first OSD is completely full[2].
> 
> I did some experimenting and found, that if I add another pool with 4500 PGs,
> each OSD will have exacly doubled the amount of PGs as with one pool. So this
> is not an accident (tried it multiple times). On another test-cluster with 4
> Hosts and 15 Disks each, the Distribution was similarly worse. I also tried
> that on a different cluster and got very similar results.
> 
> To me it looks like the rjenkins algorithm is not working as it - in my
> opinion - should be.
> 
> Am I doing anything wrong?
> Is this behaviour to be expected?
> Can I do something about it?

I suspect there are a few things going on.

First, the new 'hashpspool' pool flag is not default (yet) but will make 
it so new pools don't line up on top of old pools and amplify any 
imbalance.  The ability to add the flag to an existing pool hasn't been 
merged yet, but new pools can get it if you put

	osd pool default flag hashpspool = true

in your [mon] section and restart the mons.

There is also a function call 'reweight-by-utilization' that will make 
minor adjustments to the (post-crush) weights to correct for the 
inevitable stastical variation.  Try running

	ceph osd reweight-by-utilization 110

and it will adjust any OSD more than 10% above the mean.

Also not that these utilization will be a bit noisy until there are a lot 
of objects in the systems; the reweight is based on bytes used and not 
PGs, so don't run it until you have written a fair bit of data to ceph.

sage


> 
> Thank you very much in advance
> Niklas
> 
> P.S.: I did ask on ceph-users before:
> http://comments.gmane.org/gmane.comp.file-systems.ceph.user/4317
> http://comments.gmane.org/gmane.comp.file-systems.ceph.user/4496
> 
> [1] I built a small script that will parse pgdump and output the amount of pgs
> on each osd: http://pastebin.com/5ZVqhy5M
> [2] I know I should not fill my cluster completely but I'm talking about
> theory and adding a margin only makes it worse.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
