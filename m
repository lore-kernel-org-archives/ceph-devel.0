From: Joe Landman <landman@scalableinformatics.com>
Subject: Re: Ideal hardware spec?
Date: Fri, 24 Aug 2012 10:41:13 -0400
Message-ID: <50379289.305@scalableinformatics.com>
References: <20120822135530.GB10015@csail.mit.edu> <5034E9F3.10001@widodh.nl> <00d301cd8073$faa0f7e0$efe2e7a0$@netmass.com> <5035E8AB.8090006@widodh.nl> <005b01cd8203$43f6e860$cbe4b920$@netmass.com>
Reply-To: landman@scalableinformatics.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ec2-23-23-234-153.compute-1.amazonaws.com ([23.23.234.153]:38890
	"EHLO mail2.scalableinformatics.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964819Ab2HXOkK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Aug 2012 10:40:10 -0400
In-Reply-To: <005b01cd8203$43f6e860$cbe4b920$@netmass.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Perkins <perkins@netmass.com>
Cc: 'Wido den Hollander' <wido@widodh.nl>, ceph-devel@vger.kernel.org

On 08/24/2012 10:17 AM, Stephen Perkins wrote:

>>> The thought here is that you can add compute nodes, storage shelves,
>>> and disks all independently.  With proper masking, you could provide
> redundancy
>>> to cover drive, node, and shelf failures.    You could also add disks
>>> "horizontally" if you have spare slots in a shelf, and you could add
>>> shelves "vertically" and increase the disk count available to existing
> nodes.
>>>
>>
>> What would the benefit be from building such a complex SAS environment?
>> You'd be spending a lot of money on SAS switch, JBODs and cabling.
>
> Density.

As a solutions vendor, we try to stay out of these discussions in 
general, as we are biased (of course).

Your discussion of being able to scale up density, fabric, and other 
relevant things is rather precisely what one of our products is meant to 
do, though we take a different route on the fabric.

Rather than using SAS switching and SAS targets, we use iSCSI and iSER 
transports over 10 and 40GbE and IB.  Our targets are iSCSI/iSER.  Put 
these underneath what we call the presentation layer, where the Ceph 
OSDs, MDSs, etc will live.

Otherwise they are quite similar.

I don't want to pollute this discussion with a commercial.  Just wanted 
to chime in here to let Stephen know that we've been doing that sort of 
design for a while.

>> Your SPOF would still be your whole SAS setup.

Actually no.  This design is, when well implemented, more resilient than 
many others.

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
> You can then get compute nodes fairly densely packed by purchasing
> SuperMicro 2uTwin enclosures:
> 	http://www.supermicro.com/products/nfo/2UTwin2.cfm
>
> You can get 3 - 4 of those compute enclosure with dual SAS connectors (each
> enclosure not necessarily fully populated initially). The beauty is that the
> SAS interconnect is fast.   Much faster than Ethernet.

You remove SPOFs by accepting the reality that its effectively 
impossible to have truly redundant power/data pathways on single 
backplane boards (literally the definition of a single point of 
failure).  If your redundant power supplies have a single power path to 
your backplane, is that redundant power (in the event of a short on the 
backplane)?  No, not even close.  And if your expander unit completely 
fails and locks hard ..., do you have a completely electrically separate 
pathway to your data?  With the single backplane/data path units, no you 
don't have this.  So putting multiple RAID cards into these units 
provides you with something akin to "security theatre".

>
> Please bear in mind that I am looking to create a highly available and
> scalable storage system that will fit in as small an area as possible and
> draw as little power as possible.  The reasoning is that we co-locate all
> our equipment at remote data centers.  Each rack (along with its associated
> power and any needed cross connects) represents a significant ongoing
> operational expense.  Therefore, for me, density and incremental scalability
> are important.

Not trying to be a commercial:  Think multi PB per 42U rack without heroics.

>
>> And what is the benefit for having Ceph run on top of that? If you have all
> the disks available to all the nodes, why not run ZFS?
>> ZFS would give you better performance since what you are building would
> actually be a local filesystem.
>
> There is no high availability here.  Yes... You can try to do old school
> magic with SAN file systems, complicated clustering, and synchronous
> replication, but a RAIN approach appeals to me.  That is what I see in Ceph.
> Don't get me wrong... I love ZFS... but am trying to figure out a scalable
> HA solution that looks like RAIN. (Am I missing a feature of ZFS)?

RAIN has some use cases, but rebuild times for a limited number of RAIDs 
and a huge number of drives will be HUGE.  Especially if your 
distributed LUNs start looking like multi tens to hundreds of TB. 
Really, you'd have to go Ceph at this point.

>
>> For risk spreading you should not interconnect all the nodes.
>
> I do understand this.  However, our operational setup will not allow
> multiple racks at the beginning.  So... given the constraints of 1 rack
> (with dual power and dual WAN links), I do not see that a pair of cross
> connected SAS switches is any less reliable than a pair of cross connected
> ethernet switches...
>
> As storage scales and we outgrow the single rack at a location, we can
> overflow into a second rack etc.
>
>> The more complexity you add to the whole setup, the more likely it's to go
> down completely at some point in time.
>>
>> I'm just trying to understand why you would want to run a distributed
> filesystem on top of a bunch of direct attached disks.
>
> I guess I don't consider a SAN a bunch of direct attached disks.  The SAS
> infrastructure is a SAN with SAS interconnects  (versus fiber,  iscsi or
> infiniband)...  The disks are accessed via JBOD if desired... or you can put
> RAID on top of a group of them.  The multiple shelves of drives are a way to
> attempt to reduce the dependence on a single piece of hardware (i.e. it
> becomes RAIN).
>
>> Again, if all the disks are attached locally you'd be better of by using
> ZFS.
>
> This is not highly available, and AFAICT, the compute load would not scale
> with the storage.
>
>>> My goal is to be able to scale without having to draw the enormous
>>> power of lots of 1U devices or buy lots of disks and shelves each time
>>> I wasn't to add a little capacity.
>>>
>>
>> You can do that, scale by adding a 1U node with 2, 3 of 4 disks at the
> time, depending on your crushmap you might need to add 3 machines at a once.
>
> Adding three machines at once is what I was trying to avoid (I believe that
> I need 3 replicas to make things reasonably redundant).  From first glance,
> it does not seem like a very dense solution to try to add a bunch of 1U
> servers with a few disks.  The associated cost of a bunch of 1U Servers over
> JBOD, plus (and more importantly) the rack space and power draw, can cause
> OPEX problems.  I can purchase multiple enclosures, but not fully populate
> them with disks/cpus.  This gives me a redundant array of nodes (RAIN).
> Then. as needed, I can add drives or compute cards to the existing
> enclosures for little incremental cost.
>
> In your 3 1U server case above, I can add 12 disks to existing 4 enclosures
> (in groups of three) instead of three 1U servers with 4 disks each.  I can
> then either run more OSDs on existing compute nodes or I can add one more
> compute node and it can handle the new drives with one or more OSDs.  If I
> run out of space in enclosures, I can add one more shelf (just one) and
> start adding drives.  I can then "include" the new drives into existing OSDs
> such that each existing OSD has a little more storage it needs to worry
> about.  (The specifics of growing an existing OSD by adding a disk is still
> a little fuzzy to me).
>
>>> Anybody looked at atom processors?
>>>
>>
>> Yes, I have..
>>
>> I'm running Atom D525 (SuperMicro X7SPA-HF) nodes with 4GB of RAM and 4 2TB
> disks and a 80GB SSD (old X25-M) for journaling.
>>
>> That works, but what I notice is that under heavy recover the Atoms can't
> cope with it.
>>
>> I'm thinking about building a couple of nodes with the AMD Brazos
> mainboard, somelike like an Asus E35M1-I.
>>
>> That is not a serverboard, but it would just be a reference to see what it
> does.
>>
>> One of the problems with the Atoms is the 4GB memory limitation, with the
> AMD Brazos you can use 8GB.
>>
>> I'm trying to figure out a way to have a really large amount of small nodes
> for a low price to have
>> a massive cluster where the impact of loosing one node is very small.
>
> Given that "massive" is a relative term, I am as well... but I'm also trying
> to reduce the footprint (power and space) of that "massive" cluster.  I also
> want to start small (1/2 rack) and scale as needed.

Again, not a commericial:  Think 1PB in less than 1/2 a 42U rack, with a 
little more than 1 ton of AC.

>
> - Steve
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Joseph Landman, Ph.D
Founder and CEO
Scalable Informatics Inc.
email: landman@scalableinformatics.com
web  : http://scalableinformatics.com
        http://scalableinformatics.com/sicluster
phone: +1 734 786 8423 x121
fax  : +1 866 888 3112
cell : +1 734 612 4615
