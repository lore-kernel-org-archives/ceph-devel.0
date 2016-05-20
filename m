From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Min alloc size according to media type
Date: Fri, 20 May 2016 06:04:44 -0500
Message-ID: <4047211f-426c-69eb-2028-893d5197511a@redhat.com>
References: <CY1PR0201MB182075171B6FCA64CF104097854A0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1605191515090.6221@cpach.fuggernut.com>
 <BLUPR0201MB1524D22BDBA93E7F438D4382E84A0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <CY1PR0201MB1820EC5C25417E8F1EA1CF1E854B0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1605200604440.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55799 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754423AbcETLEs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 May 2016 07:04:48 -0400
In-Reply-To: <alpine.DEB.2.11.1605200604440.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 05/20/2016 05:08 AM, Sage Weil wrote:
> On Fri, 20 May 2016, Ramesh Chander wrote:
>> Thanks Sage and Allen,
>>
>>>> Unless we want to make bluestore smart enough to push object data on a
>>>> fast device (i.e., do ssd/hdd tiering internally), I'm not sure we
>>>> need per- device min_alloc_size.
>>
>> If we make it per block device even it becomes more simpler to set it on device open time and read it whenever required.
>>
>> Most of the places we are already reading block device from bdev->get_block_size(), this new one also goes with it.
>>
>> I think the gc_conf->* are read only parameters , to circumvent it I need to set this info at BlueStore structure or globally somewhere.
>>
>> Whatever you suggest is fine.
>
> FWIW the github.com/liewebas/wip-bluestore-write branch already moves
> block_size and min_alloc_size ot BlueStore class members so that it's not
> always pulling them out of g_conf and bdev.
>
>>>> Don't worry about legacy at all since bluestore has no users.  :)
>>
>> That simplifies it and I can simply remove it. Or do we still need to
>> keep the old parameter around and make that take precedence over two new
>> ones? I mean old option is applicable to both so we need to break tie
>> between new specific and old general parameter.
>
> I think having bluestore_min_alloc_size, bluestore_min_alloc_size_hdd, and
> bluestore_min_alloc_size_ssd still makes it easier to change for users.
> It'll only go in one bit of code that updates the BlueStore min_alloc_size
> member.

If we really want to go down this road, would it make sense to create 
storage class templates rather than global configuration parameters? 
Presumably you might want different compression, read ahead, or 
writeback caching depending on the device class as well.

Mark

>
> Perhaps you can base this PR on the wip-bluestore-write branch.  It's
> getting rebased still frequently but I think it's less than a
> week away from being mergeable.
>
>>>> Currently it is transient everywhere, and so far I've been trying to
>>>> keep it that way.  However, we might want to change this: if we make
>>>> min_alloc_size fixed at mkfs time, we could possibly collapse down the
>>>> size of the allocation
>>>> bitmap(s) by a factor of 16 on HDD (1 bit per min_alloc_size instead
>>>> of per block).  I'm not sure that it's worth it, though... thoughts?
>>> Collapsing the bitmap provides little DRAM savings and probably not much CPU time savings (though some additional (low risk) coding might be required to make this statement true), so I don't see much point in it.
>> Seems like extra complexity with little value.
>>
>> I think as long as our min alloc size does reduce from previous value or
>> our bitmap vector has bit per minimum possible value of min_alloc_size,
>> we are good.  But as Allen said , we will not have significant saving
>> from this as fasr as cost (cpu and dram) is concerned.
>
> Yeah, let's not worry about it then.
>
> sage
>
>
>
>>
>> -Ramesh Chander
>>
>>
>> -----Original Message-----
>> From: Allen Samuels
>> Sent: Friday, May 20, 2016 2:00 AM
>> To: Sage Weil; Ramesh Chander
>> Cc: ceph-devel@vger.kernel.org
>> Subject: RE: Min alloc size according to media type
>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> owner@vger.kernel.org] On Behalf Of Sage Weil
>>> Sent: Thursday, May 19, 2016 12:20 PM
>>> To: Ramesh Chander <Ramesh.Chander@sandisk.com>
>>> Cc: ceph-devel@vger.kernel.org
>>> Subject: Re: Min alloc size according to media type
>>>
>>> On Thu, 19 May 2016, Ramesh Chander wrote:
>>>> Hi Sage,
>>>>
>>>> I am doing changes in Bluestore related to minimum allocation size
>>>> according to ssd and hdd. This change involves:
>>>>
>>>> 1. There are three min alloc sizes now:
>>>>                 a. min_alloc_size: old one, default changed to 0
>>>>                 b. min_alloc_size_hdd: for rotational media, default 64k
>>>>                 c. min_alloc_size_ssd: for ssd, default 4k.
>>>>
>>>> 2. Making changes in BlockDevice to maintain its own min_alloc_size.
>>>> It allows to maintain different min_alloc_size for different devices.
>>>>
>>>> 3. Making changes in allocator(stupid, bitmap) interfaces to take
>>>> min_alloc_size from the corresponding devices.
>>>
>>> This makes sense if some devices are hdd and some are ssd (e.g., main
>>> vs db/wal), but in practice the only separation currently possible is
>>> to have a separate device for WAL and for rocksdb, both of which hare
>>> managed by bluefs and not bluestore directly.  Ane bluefs currently
>>> has a min_alloc_size of 1MB since all files are generally big (usually
>>> 4MB each), there are no random writes, etc.
>>>
>>> Unless we want to make bluestore smart enough to push object data on a
>>> fast device (i.e., do ssd/hdd tiering internally), I'm not sure we
>>> need per- device min_alloc_size.
>>
>> I think this is / will be valuable -- in the future. I don't see that this item significantly simplifies the future problem.
>>
>>
>>>
>>>> I have following questions regarding this parameter and use of it in
>>>> bluestore:
>>>>
>>>> 1. I assume this parameter is transient and does not have effect on
>>>> different values (say changed from 4k to 64k or vice versa) across
>>>> reboots or different ceph versions?
>>>>                 Is it ondisk anywhere in metadata or in freelist manager
>>>>                 in direct or indirect manner? Because having on disk
>>>>                 presence could cause confusions by having new options
>>>>                 when existing users move to build with this change.
>>>
>>> Currently it is transient everywhere, and so far I've been trying to
>>> keep it that way.  However, we might want to change this: if we make
>>> min_alloc_size fixed at mkfs time, we could possibly collapse down the
>>> size of the allocation
>>> bitmap(s) by a factor of 16 on HDD (1 bit per min_alloc_size instead
>>> of per block).  I'm not sure that it's worth it, though... thoughts?
>>
>> Collapsing the bitmap provides little DRAM savings and probably not much CPU time savings (though some additional (low risk) coding might be required to make this statement true), so I don't see much point in it.
>> Seems like extra complexity with little value.
>>
>>>
>>>> 2. While figuring out the min_alloc_size for devices, I give
>>>> preferences to old config parameter so that existing configs
>>>>                 are not changed by this code change. Is this right
>>>> or this is not required?
>>>
>>> Don't worry about legacy at all since bluestore has no users.  :)
>>>
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at http://vger.kernel.org/majordomo-info.html
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
