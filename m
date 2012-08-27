From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ideal hardware spec?
Date: Tue, 28 Aug 2012 00:33:25 +0200
Message-ID: <503BF5B5.6000100@widodh.nl>
References: <20120822135530.GB10015@csail.mit.edu> <5034E9F3.10001@widodh.nl> <00d301cd8073$faa0f7e0$efe2e7a0$@netmass.com> <5035E8AB.8090006@widodh.nl> <005b01cd8203$43f6e860$cbe4b920$@netmass.com> <50379830.4000000@inktank.com> <5037C3FB.200@widodh.nl> <5037C6A2.4050403@inktank.com> <00b301cd847e$8cb65e00$a6231a00$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:45225 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab2H0Wd3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 18:33:29 -0400
In-Reply-To: <00b301cd847e$8cb65e00$a6231a00$@netmass.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Perkins <perkins@netmass.com>
Cc: ceph-devel@vger.kernel.org



On 08/27/2012 08:05 PM, Stephen Perkins wrote:
>>>> Given that "massive" is a relative term, I am as well... but I'm
>>>> also trying to reduce the footprint (power and space) of that
>>>> "massive" cluster.
>>>> I also
>>>> want to start small (1/2 rack) and scale as needed.
>>>
>>> If you do end up testing Brazos processes, please post your results!
>>> I think it really depends on what kind of performance you are aiming for.
>>> Our stock 2U test boxes have 6-core opterons, and our SC847a has dual
>>> 6-core low power Xeon E5s. At 10GbE+ these are probably going to be
>>> pushed pretty hard, especially during recovery.
>>>
>>
>> I'm aiming for a Ceph cluster of a couple of hundred TB consisting out
>> of 5 or 6 racks full of 1U machines with each 4x 1TB.
>
> Thinking along the lines of the approach of many 1U by 4 drive host (as
> above) with no hardware RAID... what are the thoughts between SATAII (3G/s)
> vs SATAIII (6G/s) and on 1G Ethernet versus 10G Ethernet.
>

While SATA3 offers more bandwidth you won't benefit that much with 
7200RPM disks.

Buffer writes might go a bit faster, but it won't be shocking.

You will however notice the difference when using a SSD for journaling, 
since the new SSDs are able to utilize the SATA3 bandwidth much better.

I think that 10G would be overkill for a node with just 4 OSDs running 
on 4 disks in total, but you might want to look at trunking 2 1Gb NIC's 
with LACP?

> - Steve
>
> P.S.  I will be assuming a replication level of 3 copies and would probably
> be looking at 10 nodes or less initially.  Maybe populating with 6 drives
> instead of 4 (if I can find the right chassis).
>

I'd go with 3 as well. Going with 2 would cause you to limp whenever 
just one machine/disk fails.

If you want to go for 6 drives in 1U you'd be looking at 2.5" drives. 
It's a bummer they are still so expensive when looking at price per GB.

Wido
