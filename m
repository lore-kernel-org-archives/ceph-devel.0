From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ideal hardware spec?
Date: Fri, 24 Aug 2012 20:12:11 +0200
Message-ID: <5037C3FB.200@widodh.nl>
References: <20120822135530.GB10015@csail.mit.edu> <5034E9F3.10001@widodh.nl> <00d301cd8073$faa0f7e0$efe2e7a0$@netmass.com> <5035E8AB.8090006@widodh.nl> <005b01cd8203$43f6e860$cbe4b920$@netmass.com> <50379830.4000000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:52684 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab2HXSMM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 14:12:12 -0400
In-Reply-To: <50379830.4000000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org



On 08/24/2012 05:05 PM, Mark Nelson wrote:
>>>
>>> I'm running Atom D525 (SuperMicro X7SPA-HF) nodes with 4GB of RAM and
>>> 4 2TB
>> disks and a 80GB SSD (old X25-M) for journaling.
>>>
>>> That works, but what I notice is that under heavy recover the Atoms
>>> can't
>> cope with it.
>>>
>>> I'm thinking about building a couple of nodes with the AMD Brazos
>> mainboard, somelike like an Asus E35M1-I.
>>>
>>> That is not a serverboard, but it would just be a reference to see
>>> what it
>> does.
>>>
>>> One of the problems with the Atoms is the 4GB memory limitation, with
>>> the
>> AMD Brazos you can use 8GB.
>>>
>>> I'm trying to figure out a way to have a really large amount of small
>>> nodes
>> for a low price to have
>>> a massive cluster where the impact of loosing one node is very small.
>>
>> Given that "massive" is a relative term, I am as well... but I'm also
>> trying
>> to reduce the footprint (power and space) of that "massive" cluster.
>> I also
>> want to start small (1/2 rack) and scale as needed.
>
> If you do end up testing Brazos processes, please post your results!  I
> think it really depends on what kind of performance you are aiming for.
>   Our stock 2U test boxes have 6-core opterons, and our SC847a has dual
> 6-core low power Xeon E5s.  At 10GbE+ these are probably going to be
> pushed pretty hard, especially during recovery.
>

I'm aiming for a Ceph cluster of a couple of hundred TB consisting out 
of 5 or 6 racks full of 1U machines with each 4x 1TB.

Having about ~200 of these nodes all doing not that much work.

If one fails I'd loose 0.5% of my cluster and recovery shouldn't be that 
hard. Assuming here that the node crashes due to hardware failure, not 
being plagued by some Ceph or BTRFS bug cluster-wide :)

Wido
