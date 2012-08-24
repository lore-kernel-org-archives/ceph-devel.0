From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ideal hardware spec?
Date: Fri, 24 Aug 2012 20:09:29 +0200
Message-ID: <5037C359.2090501@widodh.nl>
References: <20120822135530.GB10015@csail.mit.edu> <5034E9F3.10001@widodh.nl> <00d301cd8073$faa0f7e0$efe2e7a0$@netmass.com> <5035E8AB.8090006@widodh.nl> <005b01cd8203$43f6e860$cbe4b920$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:52534 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab2HXSJc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 14:09:32 -0400
In-Reply-To: <005b01cd8203$43f6e860$cbe4b920$@netmass.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Perkins <perkins@netmass.com>
Cc: ceph-devel@vger.kernel.org



On 08/24/2012 04:17 PM, Stephen Perkins wrote:
>
>> Your SPOF would still be your whole SAS setup.
>
> Well... I'm not sure I would consider it a single point of failure...  a
> pair of cross-connected switches and 3-5 disk shelves.  Shelves can be
> purchased with fully redundant internals (dual data paths etc to SAS
> drives).  That is not even that important. If each shelf is just looked at
> as JBOD, then you can group disks from different shelves into btrfs or
> hardware RAID groups.  Or... you can look at each disk as its own storage
> with its own OSD.
>
> A SAS switch going offline would have no impact since everything is cross
> connected.
>
> A whole shelf can go offline and it would only appear as a single drive
> failure in a RAID group (if disks groups are distributed properly).
>

I'm not against your idea and I get the reasoning, however, in my 
opinion a distributed filesystem should not have interconnects on SAS 
basis between OSD nodes.

There are multiple ways to Rome, I know, but I'm just trying to view 
this from another perspective.

> You can then get compute nodes fairly densely packed by purchasing
> SuperMicro 2uTwin enclosures:
> 	http://www.supermicro.com/products/nfo/2UTwin2.cfm
>
> You can get 3 - 4 of those compute enclosure with dual SAS connectors (each
> enclosure not necessarily fully populated initially). The beauty is that the
> SAS interconnect is fast.   Much faster than Ethernet.

Yes, SAS is faster than ethernet, but all the replication traffic 
between OSDs will still go over Ethernet. The OSD in his turn will write 
the data over SAS.

I'd actually think your SAS bus (although they are beefy) could become a 
bottleneck at some point.

>
> Please bear in mind that I am looking to create a highly available and
> scalable storage system that will fit in as small an area as possible and
> draw as little power as possible.  The reasoning is that we co-locate all
> our equipment at remote data centers.  Each rack (along with its associated
> power and any needed cross connects) represents a significant ongoing
> operational expense.  Therefore, for me, density and incremental scalability
> are important.
>

Got ya. Operational costs in datacenters are getting higher and higher, 
sometimes it's worth investing more upfront so you can save operationally.

>
> There is no high availability here.  Yes... You can try to do old school
> magic with SAN file systems, complicated clustering, and synchronous
> replication, but a RAIN approach appeals to me.  That is what I see in Ceph.
> Don't get me wrong... I love ZFS... but am trying to figure out a scalable
> HA solution that looks like RAIN. (Am I missing a feature of ZFS)?
>

I'm managing a couple of 50TB ZFS systems with Nexenta. The two nodes 
have 96GB of RAM each and all the disks are in LSI 630J JBOD's with LSI 
SAS switches, this way both nodes have access to the disks and thus the 
ZFS pool.

Expansion can be done by adding extra disks or creating a second pool 
and running that pool on a different node.

Since you are staying inside on rack I don't think you'll be doing that 
much IOps. A descent ZFS system can do 100k IOps without any issues, I 
don't think you'll do that with Ceph very soon in one rack (assuming 
your clients are in the same rack).

Don't get me wrong, I'm not trying to scare you away from Ceph, just 
trying to view it from a different perspective.

>> For risk spreading you should not interconnect all the nodes.
>
> I do understand this.  However, our operational setup will not allow
> multiple racks at the beginning.  So... given the constraints of 1 rack
> (with dual power and dual WAN links), I do not see that a pair of cross
> connected SAS switches is any less reliable than a pair of cross connected
> ethernet switches...
>

The problem with interconnected SAS switches is that IF something goes 
wrong your filesystem looses it's connection to the disk, risking 
valuable data which could still be in transit from buffers.

The risk would be that all the OSDs will loose access to their disks all 
at once.

Yes, it is redundant, but you wouldn't be the first to suffer from a 
firmware glitch somewhere.

By physically keeping this separated you don't have the risk of all OSDs 
loosing disk access at once.

> As storage scales and we outgrow the single rack at a location, we can
> overflow into a second rack etc.
>

True, that is something that you won't do with a ZFS setup that fast. 
The question you have to ask yourself: Do you want all your data on one 
system? Do you want to bet everything on one horse?

Wido
