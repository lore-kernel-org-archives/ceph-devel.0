From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about CRUSH
Date: Fri, 8 Oct 2010 15:02:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010081458450.3163@cobra.newdream.net>
References: <1286482123.2633.17.camel@wido-laptop.pcextreme.nl>
 <Pine.LNX.4.64.1010071344240.16416@cobra.newdream.net>
 <1286563273.3132.1.camel@wido-laptop.pcextreme.nl>
 <Pine.LNX.4.64.1010081150350.7262@cobra.newdream.net>
 <1286574109.3132.7.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57262 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759679Ab0JHV7e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Oct 2010 17:59:34 -0400
In-Reply-To: <1286574109.3132.7.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On Fri, 8 Oct 2010, Wido den Hollander wrote:
> > Your example
> > 
> > > 	step take root
> > > 	step choose firstn 0 type rack
> > > 	step choose firstn 1 type host
> > > 	step choose firstn 2 type device
> > > 	step emit
> > 
> > would choose N(=3) racks, pick 1 host in each rack, and then pick 2 
> > devices on each host (for a total of 6 devices).
> > 
> > Does that make sense?
> 
> Makes sense, so this should be fine:
> 
> step take root
> step choose firstn 0 type rack
> step choose firstn 1 type host
> step choose firstn 1 type device
> step emit
> 
> This way we find enough "racks" to store all my replicas.

Yeah, this will work.  But the 'chooseleaf' approach is still better, 
because the above rule might pick a rack that has no active devices, and 
end up with a smaller result.

> Since my replication is set to three, that should be enough, since I 
> selected three hosts/devices.
> 
> Is there any benefit from finding more devices then the replication 
> level?
> 
> What would I benefit if I found 6 devices, where 3 should be enough? 
> Does CRUSH also select OSD's which are down?

I'm not sure offhand what the system would do in that case.  It might 
help mitigate the problems above, but I haven't checked.
 
> Or should I just stick to "chooseleaf" in this situation?

Yeah :)

sage


> 
> Wido
> 
> > sage
> > 
> > 
> > 
> > > 
> > > > 
> > > > That would choose N racks, and then for each rack, choose a nested device.  
> > > > The problem is when one of the racks it chooses has no (or few) online 
> > > > devices beneath it, we fail to find a usable device, and the result set 
> > > > will have <N devices.  Chooseleaf doesn't have that problem.
> > > 
> > > So chooseleaf rack should be safe enough in this case?
> > > 
> > > > 
> > > > sage
> > > 
> > > Wido
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
