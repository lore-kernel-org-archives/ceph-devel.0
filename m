From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ideal hardware spec?
Date: Sat, 25 Aug 2012 13:48:25 +0200
Message-ID: <5038BB89.9020405@widodh.nl>
References: <20120822135530.GB10015@csail.mit.edu> <5034E9F3.10001@widodh.nl> <00d301cd8073$faa0f7e0$efe2e7a0$@netmass.com> <5035E8AB.8090006@widodh.nl> <005b01cd8203$43f6e860$cbe4b920$@netmass.com> <50379830.4000000@inktank.com> <5037C3FB.200@widodh.nl> <00ae01cd823e$84e2ed20$8ea8c760$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:59407 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab2HYLs0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 Aug 2012 07:48:26 -0400
In-Reply-To: <00ae01cd823e$84e2ed20$8ea8c760$@netmass.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Perkins <perkins@netmass.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

(CC back to the list)

On 08/24/2012 11:22 PM, Stephen Perkins wrote:
> Hi Wildo,
>
> Why 4 x 1TB?  I get the 4 (many boards seem to have  4 sata connectors so
> you don't need a separate controller).  However... why not 2TB or 3TB
> drives?  Is recover time too large?
>

Yes, due to recovery time mainly. With 4x 1TB I'd loose about 3.2TB of 
data (85% full) at max, that is recoverable for the cluster.

Would I increase that to 2TB or 3TB disks the recovery would indeed get 
harder for the CPU and Memory.

I could have less nodes to get the same amount of storage, but in this 
situation I also get more IOps since I have more spindles running.

> I'm guessing no RAID and one OSD process per disk?
>

Correct. RAID is expensive and the Ceph replication already provides the 
data redundancy here.

> I'm still evaluating your "looking at things differently" to see about a
> bunch of cheap 1Us.
>
> Would your 1Us have redundant power and be redundantly Ethernet connected?
> Or... cheaper single power and single Ethernet (reduced cabling)?
>
> ECC memory?
>

No redundant power, no redundant Ethernet (or switches) and no ECC memory.

I'm quoting here from the CRUSH publication Sage wrote [0]:

"Data safety is of critical importance in large storage systems,
where the large number of devices makes hardware failure
the rule rather than the exception." (4.4 Reliability)

I've been designing by that rule.

I'm relying on CRUSH to do all the redundancy work for me. By 
strategically placing nodes on different power feeds and different 
switches I can mitigate hardware failure. You just have to make sure 
that your CRUSH map resembles your physical layout of your cluster.

Make sure that two copies of your data never end up in the same rack or 
on the same switch.

Wido

[0]: http://ceph.newdream.net/papers/weil-crush-sc06.pdf

> - Steve
>
>
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Wido den Hollander
> Sent: Friday, August 24, 2012 1:12 PM
> To: Mark Nelson
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Ideal hardware spec?
>
>
>
> On 08/24/2012 05:05 PM, Mark Nelson wrote:
>>>>
>>>> I'm running Atom D525 (SuperMicro X7SPA-HF) nodes with 4GB of RAM
>>>> and
>>>> 4 2TB
>>> disks and a 80GB SSD (old X25-M) for journaling.
>>>>
>>>> That works, but what I notice is that under heavy recover the Atoms
>>>> can't
>>> cope with it.
>>>>
>>>> I'm thinking about building a couple of nodes with the AMD Brazos
>>> mainboard, somelike like an Asus E35M1-I.
>>>>
>>>> That is not a serverboard, but it would just be a reference to see
>>>> what it
>>> does.
>>>>
>>>> One of the problems with the Atoms is the 4GB memory limitation,
>>>> with the
>>> AMD Brazos you can use 8GB.
>>>>
>>>> I'm trying to figure out a way to have a really large amount of
>>>> small nodes
>>> for a low price to have
>>>> a massive cluster where the impact of loosing one node is very small.
>>>
>>> Given that "massive" is a relative term, I am as well... but I'm also
>>> trying to reduce the footprint (power and space) of that "massive"
>>> cluster.
>>> I also
>>> want to start small (1/2 rack) and scale as needed.
>>
>> If you do end up testing Brazos processes, please post your results!
>> I think it really depends on what kind of performance you are aiming for.
>>    Our stock 2U test boxes have 6-core opterons, and our SC847a has
>> dual 6-core low power Xeon E5s.  At 10GbE+ these are probably going to
>> be pushed pretty hard, especially during recovery.
>>
>
> I'm aiming for a Ceph cluster of a couple of hundred TB consisting out of 5
> or 6 racks full of 1U machines with each 4x 1TB.
>
> Having about ~200 of these nodes all doing not that much work.
>
> If one fails I'd loose 0.5% of my cluster and recovery shouldn't be that
> hard. Assuming here that the node crashes due to hardware failure, not being
> plagued by some Ceph or BTRFS bug cluster-wide :)
>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
>
