From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Initial newstore vs filestore results
Date: Fri, 10 Apr 2015 07:07:05 -0500
Message-ID: <5527BCE9.2060609@redhat.com>
References: <5523F069.3000400@redhat.com> <55242D15.8080800@redhat.com> <55248856.1010808@redhat.com> <alpine.DEB.2.00.1504071951120.4469@cobra.newdream.net> <5525EFCC.3070607@redhat.com> <5526B044.2090002@redhat.com> <A9F57F2ABA6BB2469F01E127557C6C9B112D385D@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33250 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754422AbbDJMHK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Apr 2015 08:07:10 -0400
In-Reply-To: <A9F57F2ABA6BB2469F01E127557C6C9B112D385D@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Duan, Jiangang" <jiangang.duan@intel.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I don't disagree, but I agree with Sage that testing different overlay 
values is useful as well.  I will have results to post later this 
morning.  At some point soon I'll move on to testing how rocksdb WAL on 
SSD and/or rocksdb entirely on SSD helps. There's definitely some 
interesting trade-offs here.

Mark

On 04/10/2015 01:11 AM, Duan, Jiangang wrote:
> IMHO, the newstore performance depends so much on KV store performance due to the WAL -  so pick up the right KV or tune it will be the 1st step to do.
>
> -jiangang
>
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Friday, April 10, 2015 1:01 AM
> To: Sage Weil
> Cc: ceph-devel
> Subject: Re: Initial newstore vs filestore results
>
> On 04/08/2015 10:19 PM, Mark Nelson wrote:
>> On 04/07/2015 09:58 PM, Sage Weil wrote:
>>> What would be very interesting would be to see the 4KB performance
>>> with the defaults (newstore overlay max = 32) vs overlays disabled
>>> (newstore overlay max = 0) and see if/how much it is helping.
>>
>> And here we go.  1 OSD, 1X replication.  16GB RBD volume.
>>
>> 4MB        write    read    randw    randr
>> default overlay    36.13    106.61    34.49    92.69
>> no overlay    36.29    105.61    34.49    93.55
>>
>> 128KB        write    read    randw    randr
>> default overlay    1.71    97.90    1.65    25.79
>> no overlay    1.72    97.80    1.66    25.78
>>
>> 4KB        write    read    randw    randr
>> default overlay    0.40    61.88    1.29    1.11
>> no overlay    0.05    61.26    0.05    1.10
>>
>
> Update this morning.  Also ran filestore tests for comparison.  Next we'll look at how tweaking the overlay for different IO sizes affects things.  IE the overlay threshold is 64k right now and it appears that 128K write IOs for instance are quite a bit worse with newstore currently than with filestore.  Sage also just committed changes that will allow overlay writes during append/create which may help improve small IO write performance as well in some cases.
>
> 4MB		write	read	randw	randr
> default overlay	36.13	106.61	34.49	92.69
> no overlay	36.29	105.61	34.49	93.55
> filestore	36.17	84.59	34.11	79.85
> 				
> 128KB		write	read	randw	randr
> default overlay	1.71	97.90	1.65	25.79
> no overlay	1.72	97.80	1.66	25.78
> filestore	27.15	79.91	8.77	19.00
> 				
> 4KB		write	read	randw	randr
> default overlay	0.40	61.88	1.29	1.11
> no overlay	0.05	61.26	0.05	1.10
> filestore	4.14	56.30	0.42	0.76
>
> Seekwatcher movies and graphs available here:
>
> http://nhm.ceph.com/newstore/20150408/
>
> Note for instance the very interesting blktrace patterns for 4K random writes on the OSD in each case:
>
> http://nhm.ceph.com/newstore/20150408/filestore/RBD_00004096_randwrite.png
> http://nhm.ceph.com/newstore/20150408/default_overlay/RBD_00004096_randwrite.png
> http://nhm.ceph.com/newstore/20150408/no_overlay/RBD_00004096_randwrite.png
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
