From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Questions about CRUSH
Date: Fri, 08 Oct 2010 23:41:49 +0200
Message-ID: <1286574109.3132.7.camel@wido-laptop.pcextreme.nl>
References: <1286482123.2633.17.camel@wido-laptop.pcextreme.nl>
	 <Pine.LNX.4.64.1010071344240.16416@cobra.newdream.net>
	 <1286563273.3132.1.camel@wido-laptop.pcextreme.nl>
	 <Pine.LNX.4.64.1010081150350.7262@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:40786 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003Ab0JHVlw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Oct 2010 17:41:52 -0400
In-Reply-To: <Pine.LNX.4.64.1010081150350.7262@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi,

On Fri, 2010-10-08 at 11:58 -0700, Sage Weil wrote:
> > > The rule generalizes to N replicas, where N can be 2..10 (that's what the 
> > > min/max size fields are for).  And the chooseleaf line is correct.  That 
> > > chooses N leaves/devices that are nested beneath N distinct racks.  Which 
> > > is what you want!
> > > 
> > > You could also do
> > > 
> > > 	step take root
> > > 	step choose firstn 0 type rack
> > > 	step choose firstn 1 type device
> > > 	step emit
> > 
> > Shouldn't that be:
> > 
> > 	step take root
> > 	step choose firstn 0 type rack
> > 	step choose firstn 1 type host
> > 	step choose firstn 2 type device
> > 	step emit
> > 
> > Or am I wrong here?
> 
> The X in 
> 
> 	step choose firstn X type T
> 
> is normally the number of items to choose.  But the rule is run with an 
> implicit N, e.g., "run this rule and get 5 replicas."  If X <= 0, then we 
> substitude in N+X, so for your case (N=3) it's really
> 
> 	step take root
> 	step choose firstn 3 type rack
> 
> Any subsequent choose steps
> 
> 	step choose firstn 1 type device
> 
> loop over the current result set.  Once you have the 3 racks, it chooses 1 
> device under each one.  Then
> 
> 	step emit
> 
> emits the final result.  
> 

Makes sense. So for a dynamic env, where you could have multiple
replication levels, 0 would be a safe step in the root, since one pool
could have 3 as level, where the other could have 2 or even 4.

After we found enough leafs at the root (lets say I have enough leafs
for any replication level), we only need one host or device.

> Your example
> 
> > 	step take root
> > 	step choose firstn 0 type rack
> > 	step choose firstn 1 type host
> > 	step choose firstn 2 type device
> > 	step emit
> 
> would choose N(=3) racks, pick 1 host in each rack, and then pick 2 
> devices on each host (for a total of 6 devices).
> 
> Does that make sense?

Makes sense, so this should be fine:

step take root
step choose firstn 0 type rack
step choose firstn 1 type host
step choose firstn 1 type device
step emit

This way we find enough "racks" to store all my replicas.

Since my replication is set to three, that should be enough, since I selected three hosts/devices.

Is there any benefit from finding more devices then the replication level?

What would I benefit if I found 6 devices, where 3 should be enough? Does CRUSH also select OSD's which are down?

Or should I just stick to "chooseleaf" in this situation?

Wido

> sage
> 
> 
> 
> > 
> > > 
> > > That would choose N racks, and then for each rack, choose a nested device.  
> > > The problem is when one of the racks it chooses has no (or few) online 
> > > devices beneath it, we fail to find a usable device, and the result set 
> > > will have <N devices.  Chooseleaf doesn't have that problem.
> > 
> > So chooseleaf rack should be safe enough in this case?
> > 
> > > 
> > > sage
> > 
> > Wido
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

