From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: flashcache
Date: Wed, 16 Jan 2013 15:53:20 -0600
Message-ID: <50F72150.7080002@inktank.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com> <alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:62484 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757308Ab3APVxS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 16:53:18 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so3437452iea.8
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 13:53:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

On 01/16/2013 03:29 PM, Sage Weil wrote:
> On Wed, 16 Jan 2013, Gandalf Corvotempesta wrote:
>> In a ceph cluster, flashcache with writeback is considered safe?
>> In case of SSD failure, the flashcache contents should be already been
>> replicated (by ceph) in other servers, right?
>
> This sort of configuration effectively bundles the disk and SSD into a
> single unit, where the failure of either results in the loss of both.
>  From Ceph's perspective, it doesn't matter if the thing it is sitting on
> is a single disk, an SSD+disk flashcache thing, or a big RAID array.  All
> that changes is the probability of failure.
>
> The thing to watch out for *knowing* that the whole is lost when one part
> fails (vs plowing ahead with a corrupt fs).
>
>> I'm planning to use this configuration: Supermicro with 12 spinning
>> disks e 2 SSD.
>> 6 spinning disks will have ceph journal on SSD1, the other 6 disks
>> will have ceph journal on disks2.
>>
>> One OSD for each spinning disk (a single XFS filesystem for the whole disk).
>> XFS metadata to a parition of SSD1
>> XFS flashcache to another partition of SSD1
>>
>> So, 3 partitions for each OSD on the SSD.
>> How big should be these partitions? Any advice?
>>
>> No raid at all, except for 1 RAID-1 volume made with a 10GB partitions
>> on each SSD, for the OS. Log files will be replicated to a remote
>> server, so writes on OS partitions are very very low.
>>
>> Any hint? Adivice? Critics?

Looks like a fun configuration to test!  Having said that, I have no 
idea how stable flashcache is.  It's certainly not something we've used 
in production before!  Keep that in mind.

With only 2 SSDs for 12 spinning disks, you'll need to make sure the 
SSDs are really fast.  I use Intel 520s for testing which are great, but 
I wouldn't use them in  production.  The S3700 might be a good bet at 
larger sizes, but it looks like the 100GB version is a lot slower than 
the 200GB version, and that's still a bit slower than the 400GB version. 
  Assuming you have 10GbE, you'll probably be capped by the SSDs for 
large block sequential workloads.  Having said that, I still think this 
has potential to be a nice setup.  Just be aware that we usually don't 
stick that much stuff on the SSDs!

>
> I would worry that there is a lot of stuff piling onto the SSD and it may
> become your bottleneck.  My guess is that another 1-2 SSDs will be a
> better 'balance', but only experiementation will really tell us that.
>

It'd be amazing if supermicro could cram another 2 SSD slots in the 
back.  Maybe by that time we'll all be using PCIE flash storage though. :)

> Otherwise, those seem to all be good things to put on teh SSD!
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

