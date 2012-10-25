From: Wido den Hollander <wido@widodh.nl>
Subject: Re: some questions about rbd
Date: Thu, 25 Oct 2012 09:27:02 +0200
Message-ID: <5088E9C6.9080403@widodh.nl>
References: <CAB6Jr7QLS1=G0vPavT70knKUteDczF4yho1Bha_Tgsv1tsXusA@mail.gmail.com> <CAB6Jr7Q3NcJAFiENv5w=p+DVtZoPksWtQH+cgF4ysHAxMzn6ng@mail.gmail.com> <50861B39.8010008@inktank.com> <CAB6Jr7QYrugfTModh85JFtkga2zPN_6tKJ1cSMA78+H85ksbcw@mail.gmail.com> <5086386D.2030002@inktank.com> <5086D830.5010505@inktank.com> <CAB6Jr7Qkak1_1UzpSiCWoiUNUR7HOK7QxYz+nemSM=oyvnKETQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:45474 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757919Ab2JYH1H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 03:27:07 -0400
In-Reply-To: <CAB6Jr7Qkak1_1UzpSiCWoiUNUR7HOK7QxYz+nemSM=oyvnKETQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jie sun <0maidou0@gmail.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 10/25/2012 08:25 AM, jie sun wrote:
> I'm are about to support a service that vm cloud mount new device dynamically.
> I'm afraid that sometimes the vm crashed(not totally crashed but just
> can't be connected with, or the host can't be connected so that I
> can't remove the vm at all) but the block device is still in use, and
> the daemon that write or read block device is still alive.
> Maybe in the situation that we meet a spiteful client and do some
> operations not allowed.
>
> Is it necessary to consider these situations? The wather of the image
> is on the mon or the osd? Can you tell me what is the priciple of the
> watcher? some tcp connection(the vm to the osd)?
>

If I were you I'd switch to using the build in RBD functionalities of 
Qemu instead of mounting a block device and running your virtual machine 
from that device.

That would also be a lot easier since you don't have to map/unmap a device.

You can also kill a VM much easier since it is not that much tied into 
the kernel.

You should take a look at libvirt and Qemu.

Wido

> Thank you!
>
>
> 2012/10/24 Josh Durgin <josh.durgin@inktank.com>:
>> Currently there's no way to force deletion of a RADOS object that
>> has watchers. Clients with an rbd image open watch the header
>> object, hence the error you saw.
>>
>> There's a feature request open for this at the RADOS level:
>> http://www.tracker.newdream.net/issues/2339
>>
>> I'm curious about why you want to delete an image even
>> if a vm is still using it. What's the context in which this
>> becomes necessary?
>>
>> Josh
>>
>>
>> On 10/22/2012 11:25 PM, Dan Mick wrote:
>>>
>>> I don't think we support that; I'm not sure how hard it would be.
>>> Somehow we'd have to keep knowledge of the open image handle around to
>>> fail further I/O requests, it seems.  Josh?
>>>
>>> On 10/22/2012 10:44 PM, jie sun wrote:
>>>>
>>>> Yes. I want to delete the image by force, even the vm is still using it.
>>>>
>>>> 2012/10/23 Dan Mick <dan.mick@inktank.com>:
>>>>>
>>>>>
>>>>>
>>>>> On 10/22/2012 08:10 PM, jie sun wrote:
>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I create a image and map it to a virtual machine,and then mkfs and
>>>>>> mount
>>>>>> it.
>>>>>>
>>>>>> I want to remove the image from mon server forcely, but it says
>>>>>> "Removing image: 99% complete...failed.
>>>>>>     delete error: image still has watchers
>>>>>>     This means the image is still open or the client using it crashed.
>>>>>> Try again after closing/unmapping it or waiting 30s for the crashed
>>>>>> client to timeout."
>>>>>>
>>>>>> I want to know is there any other way to remove it by force?
>>>>>
>>>>>
>>>>>
>>>>> Are you saying the vm still has the device open and is trying to use it?
>>>>> But even so, you want the image to be deleted?
>>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

