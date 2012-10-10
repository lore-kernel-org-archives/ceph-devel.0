From: Sage Weil <sage@inktank.com>
Subject: Re: Client Location
Date: Wed, 10 Oct 2012 09:39:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210100935380.8499@cobra.newdream.net>
References: <653431320.70.1349860564219.JavaMail.root@corellia.pncl.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37340 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488Ab2JJQjO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 12:39:14 -0400
In-Reply-To: <653431320.70.1349860564219.JavaMail.root@corellia.pncl.co.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Horner <james.horner@precedent.co.uk>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org, Mark Kampe <mark.kampe@inktank.com>

On Wed, 10 Oct 2012, James Horner wrote:
> Hi There
> 
> The basic setup Im trying to get is a backend to a Hypervisor cluster, 
> so that auto-failover and live migration works. The mail thing is that 
> we have a number of datacenters with a gigabit interconnect that is not 
> always 100% reliable. In the event of a failure we want all the virtual 
> machines to fail over to the remaining datacenters, so we need all the 
> data in each location.
>
> The other issue is that within each datacenter we can use link 
> aggregation to increase the bandwidth between hypervisors and the ceph 
> cluster but between the datacenters we only have the gigabit so it 
> become essential to have the hyperviors looking at the storage in the 
> same datacenter.

The ceph replication is syncrhonous, so even if you are writing to a local 
OSD, it will be updating the replica at the remote DC. The 1gbps link may 
quickly become a bottleneck.  This is a matter of having your cake and 
eating it too... you can't seamlessly fail over to another DC if you don't 
synchronously replicate to it.

> Another consideration is that the virtual machines might get migrated 
> between datacenters without any failure, and the main problem I see with 
> Mark suggests is that in this mode the migrated VM would still be 
> connecting to the OSD's in the remote datacenter.

The new rbd cloning functionality can be used to 'migrate' and image by 
cloning to a different pool (the new local DC) and then later (in teh 
background, whenever) doing a 'flatten' to migrate teh data from the 
parent to the clone.  Performance will be slower initially but improve 
once the data is migrated.

This isn't a perfect solution for your use-case, but it would work..

sage

> Tbh Im fairly new to ceph and I know im asking for everything and the 
> kitchen sink! Any thoughts would be very helpful though.
> 
> Thanks
> James
> 
> ----- Original Message -----
> From: "Gregory Farnum" <greg@inktank.com>
> To: "Mark Kampe" <mark.kampe@inktank.com>
> Cc: "James Horner" <james.horner@precedent.co.uk>, ceph-devel@vger.kernel.org
> Sent: Tuesday, October 9, 2012 5:48:37 PM
> Subject: Re: Client Location
> 
> On Tue, Oct 9, 2012 at 9:43 AM, Mark Kampe <mark.kampe@inktank.com> wrote:
> > I'm not a real engineer, so please forgive me if I misunderstand,
> > but can't you create a separate rule for each data center (choosing
> > first a local copy, and then remote copies), which should ensure
> > that the primary is always local.  Each data center would then
> > use a different pool, associated with the appropriate location-
> > sensitive rule.
> >
> > Does this approach get you the desired locality preference?
> 
> This sounds right to me ? I think maybe there's a misunderstanding
> about how CRUSH works. What precisely are you after, James?
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
