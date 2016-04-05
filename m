From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Wed, 6 Apr 2016 01:10:30 +1000
Message-ID: <20160405151030.GA20891@onthe.net.au>
References: <alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
 <20160401052838.GA8044@onthe.net.au>
 <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
 <20160401194912.GA18636@onthe.net.au>
 <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160402040736.GA22721@onthe.net.au>
 <CY1PR0201MB1897416E6B245E1FC2B9CEBEE89B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160404150042.GA25465@onthe.net.au>
 <CY1PR0201MB18973631BB493B8DCE1A5C4AE89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1604050828340.19675@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:53010 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758582AbcDEPKe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 11:10:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1604050828340.19675@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Apr 05, 2016 at 08:35:43AM -0400, Sage Weil wrote:
> On Mon, 4 Apr 2016, Allen Samuels wrote:
>> But there's an approximation that gets the job done for us.
>> 
>> When U is VERY SMALL (this will always be true for us :)).
>> 
>> The you can approximate 1-(1-U)^D as D * U.  (for even modest values of 
>> U (say 10-5), this is a very good approximation).
>> 
>> Now the math is easy.
>> 
>> The odds of failure for reading a block of size D is now D * U, with 
>> checksum correction it becomes (D * U) / (2^C).
>>
>> It's now clear that if you double the data size, you need to add one bit 
>> to your checksum to compensate.
>> 
>> (Again, the actual math is less than 1 bit, but in the range we care 
>> about 1 bit will always do it).
>> 
>> Anyways, that's what we worked out.
> 
> D = block size, U = hw UBER, C = checksum.  Let's add N = number of bits 
> you actually want to read.  In that case, we have to read (N / D) blocks 
> of D bits, and we get
> 
> P(reading N bits and getting some bad data and not knowing it)
> 	= (D * U) / (2^C) * (N / D)
> 	= U * N / 2^C
> 
> and the D term (block size) disappears.  IIUC this is what Chris was 
> originally getting at.  The block size affects the probability I get an 
> error on one block, but if I am a user reading something, you don't care 
> about block size--you care about how much data you want to read.  I think 
> in that case it doesn't really matter (modulo rounding error, minimum read 
> size, how precisely we can locate the error, etc.).
>
> Is that right?

Yep, that's pretty much what I was thinking. My probability algebra is more
than a little rusty but that looks like the formula I was starting to put
together.

Chris
