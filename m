From: "Stephen Perkins" <perkins@netmass.com>
Subject: RE: Ideal hardware spec?
Date: Mon, 27 Aug 2012 13:05:32 -0500
Message-ID: <00b301cd847e$8cb65e00$a6231a00$@netmass.com>
References: <20120822135530.GB10015@csail.mit.edu> <5034E9F3.10001@widodh.nl> <00d301cd8073$faa0f7e0$efe2e7a0$@netmass.com> <5035E8AB.8090006@widodh.nl> <005b01cd8203$43f6e860$cbe4b920$@netmass.com> <50379830.4000000@inktank.com> <5037C3FB.200@widodh.nl> <5037C6A2.4050403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 142.122.233.72.static.reverse.ltdomains.com ([72.233.122.142]:54002
	"EHLO stgateway01.netmass.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750971Ab2H0SFh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Aug 2012 14:05:37 -0400
In-Reply-To: <5037C6A2.4050403@inktank.com>
Content-Language: en-us
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: 'Mark Nelson' <mark.nelson@inktank.com>

>>> Given that "massive" is a relative term, I am as well... but I'm 
>>> also trying to reduce the footprint (power and space) of that 
>>> "massive" cluster.
>>> I also
>>> want to start small (1/2 rack) and scale as needed.
>>
>> If you do end up testing Brazos processes, please post your results! 
>> I think it really depends on what kind of performance you are aiming for.
>> Our stock 2U test boxes have 6-core opterons, and our SC847a has dual 
>> 6-core low power Xeon E5s. At 10GbE+ these are probably going to be 
>> pushed pretty hard, especially during recovery.
>>
>
> I'm aiming for a Ceph cluster of a couple of hundred TB consisting out 
> of 5 or 6 racks full of 1U machines with each 4x 1TB.

Thinking along the lines of the approach of many 1U by 4 drive host (as
above) with no hardware RAID... what are the thoughts between SATAII (3G/s)
vs SATAIII (6G/s) and on 1G Ethernet versus 10G Ethernet.

- Steve

P.S.  I will be assuming a replication level of 3 copies and would probably
be looking at 10 nodes or less initially.  Maybe populating with 6 drives
instead of 4 (if I can find the right chassis).




