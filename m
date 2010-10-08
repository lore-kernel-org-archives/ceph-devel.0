From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about CRUSH
Date: Fri, 8 Oct 2010 11:58:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010081150350.7262@cobra.newdream.net>
References: <1286482123.2633.17.camel@wido-laptop.pcextreme.nl>
 <Pine.LNX.4.64.1010071344240.16416@cobra.newdream.net>
 <1286563273.3132.1.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57822 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab0JHS4P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Oct 2010 14:56:15 -0400
In-Reply-To: <1286563273.3132.1.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

> > The rule generalizes to N replicas, where N can be 2..10 (that's what the 
> > min/max size fields are for).  And the chooseleaf line is correct.  That 
> > chooses N leaves/devices that are nested beneath N distinct racks.  Which 
> > is what you want!
> > 
> > You could also do
> > 
> > 	step take root
> > 	step choose firstn 0 type rack
> > 	step choose firstn 1 type device
> > 	step emit
> 
> Shouldn't that be:
> 
> 	step take root
> 	step choose firstn 0 type rack
> 	step choose firstn 1 type host
> 	step choose firstn 2 type device
> 	step emit
> 
> Or am I wrong here?

The X in 

	step choose firstn X type T

is normally the number of items to choose.  But the rule is run with an 
implicit N, e.g., "run this rule and get 5 replicas."  If X <= 0, then we 
substitude in N+X, so for your case (N=3) it's really

	step take root
	step choose firstn 3 type rack

Any subsequent choose steps

	step choose firstn 1 type device

loop over the current result set.  Once you have the 3 racks, it chooses 1 
device under each one.  Then

	step emit

emits the final result.  

Your example

> 	step take root
> 	step choose firstn 0 type rack
> 	step choose firstn 1 type host
> 	step choose firstn 2 type device
> 	step emit

would choose N(=3) racks, pick 1 host in each rack, and then pick 2 
devices on each host (for a total of 6 devices).

Does that make sense?
sage



> 
> > 
> > That would choose N racks, and then for each rack, choose a nested device.  
> > The problem is when one of the racks it chooses has no (or few) online 
> > devices beneath it, we fail to find a usable device, and the result set 
> > will have <N devices.  Chooseleaf doesn't have that problem.
> 
> So chooseleaf rack should be safe enough in this case?
> 
> > 
> > sage
> 
> Wido
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
