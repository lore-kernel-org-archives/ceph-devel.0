From: Sage Weil <sage@newdream.net>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Tue, 5 Apr 2016 08:35:43 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604050828340.19675@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com> <CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com> <20160401035610.GA5671@onthe.net.au> <alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
 <20160401052838.GA8044@onthe.net.au> <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com> <20160401194912.GA18636@onthe.net.au> <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com> <20160402040736.GA22721@onthe.net.au>
 <CY1PR0201MB1897416E6B245E1FC2B9CEBEE89B0@CY1PR0201MB1897.namprd02.prod.outlook.com> <20160404150042.GA25465@onthe.net.au> <CY1PR0201MB18973631BB493B8DCE1A5C4AE89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37633 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbcDEMfu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 08:35:50 -0400
In-Reply-To: <CY1PR0201MB18973631BB493B8DCE1A5C4AE89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Chris Dunlop <chris@onthe.net.au>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 4 Apr 2016, Allen Samuels wrote:
> But there's an approximation that gets the job done for us.
> 
> When U is VERY SMALL (this will always be true for us :)).
> 
> The you can approximate 1-(1-U)^D as D * U.  (for even modest values of 
> U (say 10-5), this is a very good approximation).
> 
> Now the math is easy.
> 
> The odds of failure for reading a block of size D is now D * U, with 
> checksum correction it becomes (D * U) / (2^C).
>
> It's now clear that if you double the data size, you need to add one bit 
> to your checksum to compensate.
> 
> (Again, the actual math is less than 1 bit, but in the range we care 
> about 1 bit will always do it).
> 
> Anyways, that's what we worked out.

D = block size, U = hw UBER, C = checksum.  Let's add N = number of bits 
you actually want to read.  In that case, we have to read (N / D) blocks 
of D bits, and we get

P(reading N bits and getting some bad data and not knowing it)
	= (D * U) / (2^C) * (N / D)
	= U * N / 2^C

and the D term (block size) disappears.  IIUC this is what Chris was 
originally getting at.  The block size affects the probability I get an 
error on one block, but if I am a user reading something, you don't care 
about block size--you care about how much data you want to read.  I think 
in that case it doesn't really matter (modulo rounding error, minimum read 
size, how precisely we can locate the error, etc.).

Is that right?

sage
