From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Qemu fails to open RBD image when auth_supported is not set to
 'none'
Date: Thu, 05 Jul 2012 15:39:32 +0200
Message-ID: <4FF59914.2080605@widodh.nl>
References: <4FE881A1.5070504@widodh.nl> <4FE8879B.7020103@widodh.nl> <4FF1F4AE.4080907@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:36201 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038Ab2GENje (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 09:39:34 -0400
Received: from [IPv6:2a00:f10:113:0:f9de:ef22:514a:2c6d] (unknown [IPv6:2a00:f10:113:0:f9de:ef22:514a:2c6d])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPA id DB0644029E
	for <ceph-devel@vger.kernel.org>; Thu,  5 Jul 2012 15:39:32 +0200 (CEST)
In-Reply-To: <4FF1F4AE.4080907@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 02-07-12 21:21, Wido den Hollander wrote:
>
>
> On 06/25/2012 05:45 PM, Wido den Hollander wrote:
>> On 06/25/2012 05:20 PM, Wido den Hollander wrote:
>>> Hi,
>>>
>>> I just tried to start a VM with libvirt with the following disk:
>>>
>>> <disk type='network' device='disk'>
>>>    <driver name='qemu' type='raw' cache='none'/>
>>>    <source protocol='rbd'
>>> name='rbd/8489c04f-aab8-4796-a22a-ebaa7be247a7'>
>>>      <host name='31.25.XX.XX' port='6789'/>
>>>    </source>
>>>    <target dev='vda' bus='virtio'/>
>>> </disk>
>>>
>>> That fails with: "Operation not supported"
>>>
>>> I tried qemu-img:
>>>
>>> qemu-img info
>>> rbd:rbd/8489c04f-aab8-4796-a22a-ebaa7be247a7:mon_host=31.25.XX.XX\\:6789
>>>
>>> Same result.
>>>
>>> I then tried:
>>>
>>> qemu-img info
>>> rbd:rbd/8489c04f-aab8-4796-a22a-ebaa7be247a7:mon_host=31.25.XX.XX\\:6789:auth_supported=none
>>>
>>>
>>>
>>>
>>> And that worked :)
>>>
>>> This host does not have a local ceph.conf, all the parameters have to
>>> come from the command line.
>>>
>>> I know that recently auth_supported defaults to "cephx", but that now
>>> break the libvirt integration since it doesn't set auth_supported to
>>> explicitly none when no auth section is present.
>>>
>>> Should this be something that gets fixed in librados or in libvirt?
>>
>> Thought about it, this is something in libvirt :)
>>
>>>
>>> If it's libvirt, I'll write a patch for it :)
>>
>> Just did so, very simple patch:
>> https://www.redhat.com/archives/libvir-list/2012-June/msg01119.html
>
> libvirt 0.9.13 just got out. The good news is that the RBD storage pool
> is in this release, but the patch above did not make it in time.

The patch just made it into libvirt: 
http://libvirt.org/git/?p=libvirt.git;a=commit;h=ccb94785007d33365d49dd566e194eb0a022148d

You will need this libvirt patch if you are going to run RBD without 
cephx enabled

Wido

>
> We'll have to wait for 0.9.14 to get that one in.
>
>>
>> Wido
>>
>>>
>>> Wido
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

