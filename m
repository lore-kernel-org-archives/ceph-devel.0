From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Fri, 1 Apr 2016 16:28:38 +1100
Message-ID: <20160401052838.GA8044@onthe.net.au>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
 <CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160401035610.GA5671@onthe.net.au>
 <alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:49322 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbcDAF2m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 01:28:42 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Apr 01, 2016 at 12:56:48AM -0400, Sage Weil wrote:
> On Fri, 1 Apr 2016, Chris Dunlop wrote:
>> On Wed, Mar 30, 2016 at 10:52:37PM +0000, Allen Samuels wrote:
>>> One thing to also factor in is that if you increase the span of a
>>> checksum, you degrade the quality of the checksum. So if you go with 128K
>>> chunks of data you'll likely want to increase the checksum itself from
>>> something beyond a CRC-32. Maybe somebody out there has a good way of
>>> describing this quanitatively.
>> 
>> I would have thought the "quality" of a checksum would be a function of how
>> many bits it is, and how evenly and randomly it's distributed, and unrelated
>> to the amount of data being checksummed.
>> 
>> I.e. if you have any amount of data covered by an N-bit evenly randomly
>> distributed checksum, and "something" goes wrong with the data (or the
>> checksum), the chance of the checksum still matching the data is 1 in 2^n.
> 
> Say there is some bit error rate per bit.  If you double the amount of 
> data you're checksumming, then you'll see twice as many errors.  That 
> means that even though your 32-bit checksum is right 2^32-1 times out of 
> 2^32, you're twice as likely to hit that 1 in 2^32 chance of getting a 
> correct checksum on wrong data.

It seems to me, if we're talking about a single block of data protected by a
32-bit checksum, it doesn't matter how many errors there are within the
block, the chance of a false checksum match is still only 1 in 2^32.

If we're talking about a stream of checksummed blocks, where the stream is
subject to some BER, then, yes, your chances of getting a false match go up.
But that's still independent of the block size, rather it's a function of
the number of possibly corrupt blocks.

In fact, if you have a stream of data subject to some BER and split into
checksummed blocks, the larger the blocks and thereby the lower the number
of blocks, the lower the chance of a false match.

Chris
