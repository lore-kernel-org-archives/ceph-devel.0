From: Wido den Hollander <wido@widodh.nl>
Subject: Re: What would a good OSD node hardware configuration look like?
Date: Wed, 07 Nov 2012 09:21:59 +0100
Message-ID: <509A1A27.9090303@widodh.nl>
References: <5097F3BD.2000904@conversis.de> <50985677.6090708@inktank.com> <50987AB9.9030905@conversis.de> <50996548.1030602@inktank.com> <5099BAEB.3060905@conversis.de> <509A0F35.2000801@widodh.nl> <CAJH6TXgRUUZ5h9gB_Zi-31aMj0r00HCjZ8jRZZCGd8_LSXaBqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:49373 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab2KGIWB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 03:22:01 -0500
In-Reply-To: <CAJH6TXgRUUZ5h9gB_Zi-31aMj0r00HCjZ8jRZZCGd8_LSXaBqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org



On 07-11-12 09:17, Gandalf Corvotempesta wrote:
> 2012/11/7 Wido den Hollander <wido@widodh.nl>:
>> Except that SSDs will mainly fail due to the amount of write cycles they had
>> to endure.
>>
>> So in RAID-1 your SSDs will fail at almost the same time.
>>
>> With for example 8 OSDs in a server you better spread them out 50/50 over
>> two SSDs.
>
> But the OS should be installed on SSD, to allow the use of the whole
> SATA/SAS disk as OSDs.
> Without RAID-1 between SSDs, a disk failure will result it the whole node down.
> --

True. You might want to use a small internal USB stick like those from 
Transcend for installing your OS. They are available in 4GB and 8GB.

Let syslog handle your logging to an external device and you have almost 
no write I/O on that thing.

This way you can use the SSDs completely for journaling and shrink them 
using HPA with hdparm.

Still, I think that in the distributed nature it shouldn't matter if you 
loose a node. If loosing a node is a to big impact to your cluster, go 
with smaller nodes.

Wido

> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
