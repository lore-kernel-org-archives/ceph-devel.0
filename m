From: Mark Nelson <mnelson@redhat.com>
Subject: Re: RocksDB tuning
Date: Tue, 14 Jun 2016 08:00:32 -0500
Message-ID: <0b91d95a-b933-0a21-1003-7dd7ac22e8a3@redhat.com>
References: <D37DE46C.5743E%manavalan.krishnan@sandisk.com>
 <BL2PR02MB2115DF8FF9EF7CF822C838BAF4500@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606100533300.6221@cpach.fuggernut.com>
 <BLUPR0201MB15246B72324C2D633EBCB21AE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606101052190.6221@cpach.fuggernut.com>
 <BLUPR0201MB15247A41BDD4C4D49FD7AA8AE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <BL2PR02MB2115E53F772F80B3CBA36842F4500@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606101139590.6221@cpach.fuggernut.com>
 <9b9e6fb5-250c-0b8e-b356-f0814103bcc5@mirantis.com>
 <BLUPR0201MB1524B3804817815A542A44EBE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <393863fe-933c-738b-79b6-8338bc94b240@mirantis.com>
 <alpine.DEB.2.11.1606101415320.6221@cpach.fuggernut.com>
 <5b255c4f-58a2-034b-e2cb-1aa28b1ea217@mirantis.com>
 <alpine.DEB.2.11.1606140712270.29071@cpach.fuggernut.com>
 <b6610943-8380-8bff-baf3-839057f3b4da@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34070 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbcFNNAj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Jun 2016 09:00:39 -0400
In-Reply-To: <b6610943-8380-8bff-baf3-839057f3b4da@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Igor Fedotov <ifedotov@mirantis.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 06/14/2016 06:53 AM, Mark Nelson wrote:
>
>
> On 06/14/2016 06:17 AM, Sage Weil wrote:
>> On Tue, 14 Jun 2016, Igor Fedotov wrote:
>>> This result are for compression = none and write block size limited to
>>> 4K.
>>
>> I've been thinking more about this and I'm wondering if we should revisit
>> the choice to use a min_alloc_size of 4K on flash.  If it's 4K, then a 4K
>> write means
>>
>>  - 4K write (to newly allocated block)
>>  - bdev flush
>>  - kv commit (4k-ish?)
>>  - bdev flush
>
> AFAIK these flushes should happen async under the hood (ie almost free)
> on devices with proper power loss protection.
>
>>
>> which puts a 2 write lower bound on latency.  If we have
>> min_alloc_size of
>> 8K or 16K, then a 4K write is
>>
>>  - kv commit (4K + 4k-ish)
>>  - bdev flush
>>  - [async] 4k write
>
> Given what I've seen about how rocksdb behaves (even on ramdisk), I
> think this is actually going to be worse than above in a lot of cases. I
> could be wrong though.  For SSDs that don't have PLP this might be
> significantly faster.

Sage pointed out that the smaller min_alloc_size will increase the size 
of the onode.  More than anything this would probably be the reason imho 
to increase the min_alloc_size (so long as we can keep the extra data 
from moving out of the WAL).

>
>>
>> Fewer bdev flushes, and only marginally more writes to the device.  I
>> guess the question is is whether write-amp is really that important for a
>> 4k workload?
>>
>> The upside of a larger min_alloc_size is the worst case metadata (onode)
>> size is 1/2 or 1/4.  The sequential read cost of a previously
>> random-written object will also be better (fewer IOs).
>>
>> There is probably a case where 4k min_alloc_size is the right choice but
>> it feels like we're optimizing for write-amp to the detriment of other
>> more important things.  For example, even after we improve the onode
>> encoding, it may be that the larger metadata results in more write-amp
>> than the WAL for the 4k writes does.
>>
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
