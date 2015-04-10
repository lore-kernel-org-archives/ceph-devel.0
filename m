From: Ning Yao <zay11022@gmail.com>
Subject: Re: Initial newstore vs filestore results
Date: Fri, 10 Apr 2015 18:25:43 +0800
Message-ID: <CALZt5jzyg2vODYfhPP_WS7cgY5tutDfkVwwAqfqFKQRCa-udwQ@mail.gmail.com>
References: <5523F069.3000400@redhat.com>
	<55242D15.8080800@redhat.com>
	<55248856.1010808@redhat.com>
	<alpine.DEB.2.00.1504071951120.4469@cobra.newdream.net>
	<5525EFCC.3070607@redhat.com>
	<5526B044.2090002@redhat.com>
	<A9F57F2ABA6BB2469F01E127557C6C9B112D385D@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35282 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773AbbDJKZo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Apr 2015 06:25:44 -0400
Received: by wgyo15 with SMTP id o15so13239735wgy.2
        for <ceph-devel@vger.kernel.org>; Fri, 10 Apr 2015 03:25:43 -0700 (PDT)
In-Reply-To: <A9F57F2ABA6BB2469F01E127557C6C9B112D385D@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Duan, Jiangang" <jiangang.duan@intel.com>
Cc: Mark Nelson <mnelson@redhat.com>, Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

KV store introduces too much write amplification, we may need
self-implemented WAL?
Regards
Ning Yao


2015-04-10 14:11 GMT+08:00 Duan, Jiangang <jiangang.duan@intel.com>:
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
> 4MB             write   read    randw   randr
> default overlay 36.13   106.61  34.49   92.69
> no overlay      36.29   105.61  34.49   93.55
> filestore       36.17   84.59   34.11   79.85
>
> 128KB           write   read    randw   randr
> default overlay 1.71    97.90   1.65    25.79
> no overlay      1.72    97.80   1.66    25.78
> filestore       27.15   79.91   8.77    19.00
>
> 4KB             write   read    randw   randr
> default overlay 0.40    61.88   1.29    1.11
> no overlay      0.05    61.26   0.05    1.10
> filestore       4.14    56.30   0.42    0.76
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
