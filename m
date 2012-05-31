From: Wido den Hollander <wido@widodh.nl>
Subject: Re: "rbd rm image" slow with big images ?
Date: Thu, 31 May 2012 21:39:28 +0200
Message-ID: <4FC7C8F0.9040700@widodh.nl>
References: <b4c574f6-49bf-4d36-b8f2-526bcccb4c71@mailpro> <4FC7B528.30609@widodh.nl> <4FC7B57C.8000403@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:46293 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933182Ab2EaTjb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 15:39:31 -0400
In-Reply-To: <4FC7B57C.8000403@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On 05/31/2012 08:16 PM, Stefan Priebe wrote:
> One note:
> he has written:
> "then just delete it, without having writed nothing in image "

That is true, but RBD doesn't know that.

There is no record of which object got created and which didn't, so the 
removal process has to issue a removal for each RBD object that might exist.

That is the nature of RBD. It makes it simple and reliable.

Wido

>
>
> Am 31.05.2012 20:15, schrieb Wido den Hollander:
>> Hi,
>>
>> On 05/31/2012 09:12 AM, Alexandre DERUMIER wrote:
>>> Hi,
>>>
>>> I trying to delete some rbd images with rbd rm,
>>> and it seem to be "slow" with big images.
>>>
>>>
>>>
>>> I'm testing it with just create a new image (1TB):
>>>
>>> # time rbd -p pool1 create --size 1000000 image2
>>>
>>> real 0m0.031s
>>> user 0m0.015s
>>> sys 0m0.010s
>>>
>>>
>>> then just delete it, without having writed nothing in image
>>>
>>>
>>> # time rbd -p pool1 rm image2
>>> Removing image: 100% complete...done.
>>>
>>> real 1m45.558s
>>> user 0m14.683s
>>> sys 0m17.363s
>>>
>>>
>>>
>>> same test with 100GB
>>>
>>> # time rbd -p pool1 create --size 100000 image2
>>>
>>> real 0m0.032s
>>> user 0m0.016s
>>> sys 0m0.007s
>>>
>>> # time rbd -p pool1 rm image2
>>> Removing image: 100% complete...done.
>>>
>>> real 0m10.499s
>>> user 0m1.488s
>>> sys 0m1.720s
>>>
>>>
>>> I'm using journal in tmpfs, 3 servers, 15 osds with 1disk 15K (xfs)
>>> network bandwith,diskio,cpu are low.
>>>
>>> Is it the normal behaviour ? Maybe some xfs tuning could help ?
>>
>> It's in the nature of RBD.
>>
>> A RBD image consists of multiple 4MB (default) RADOS objects.
>>
>> Let's say you have a disk of 40GB, that will contain 10.000 4MB RADOS
>> objects, you can find those objects by doing: rados -p rbd ls
>>
>> Now, when you create a new image only the header is writting, but no
>> object is written.
>>
>> When you start writing to a RBD image you will be writing to one of the
>> 4MB objects. When it doesn't exist it will be created.
>>
>> So when you install your VM it will create objects, but not all of them.
>>
>> RBD knows which RADOS objects to access by three parameters:
>>
>> * Image name
>> * Image size
>> * Stripe size (4MB)
>>
>> So when your VM access for byte Y until Z on the disk, RBD knows which
>> object to access by calculating this.
>>
>> Now, when you start removing the image there is no way of knowing which
>> object exists and which doesn't, so RBD will try to remove all objects.
>>
>> In the case of a fresh image this results in 10.000 RADOS remove
>> operations for non-existent objects and that is slow.
>>
>> Wido
>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
