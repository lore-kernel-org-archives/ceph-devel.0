From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Throughput increase by LACP bonding
Date: Tue, 03 Jul 2012 13:50:49 +0200
Message-ID: <4FF2DC99.2090000@widodh.nl>
References: <loom.20120703T093148-928@post.gmane.org> <4FF2A834.3080400@widodh.nl> <20120703105624.GA10864@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:37576 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567Ab2GCLux (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 07:50:53 -0400
In-Reply-To: <20120703105624.GA10864@hmsreliant.think-freely.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Madhusudhana U <madhusudhana.u.acharya@gmail.com>, ceph-devel@vger.kernel.org



On 03-07-12 12:56, Neil Horman wrote:
> On Tue, Jul 03, 2012 at 10:07:16AM +0200, Wido den Hollander wrote:
>>
>>
>> On 03-07-12 09:42, Madhusudhana U wrote:
>>> Hi all,
>>> I am trying to increase the throughput in the cluster by enabling
>>> LACP on both in clients and all ceph cluster nodes. Each client and
>>> ceph nodes has two 1G Ethernet interface which I want to aggregate
>>> and make it 2G. LACP has been configured at switch side too. But even after
>>> the configuration, I am not seeing any through put increase in ceph tell osd
>>> bench command and also dd. They are taking the same amount as earlier. I am
>>> constantly seeing around 100MB/sec throughput in both DD and ceph bench
>>> commands. Can someone suggest me how i can increase the throughput of the
>>> cluster ? Below are my configurations.
>>
>> Can you verify if both NIC's are actually doing something? Use
>> bwm-ng for example?
>>
>> Wido
>>
> I would imagine they aren't, as the output hash function for 802.3ad trunking is
> based on source and destination address, so if your test just writes from a
> single client to a single OSD, it will just use one link.

He mentioned "both in clients and ..." So I figured he had multiple clients.

But yes, you are right about the hashing. He should be using multiple 
clients to use both NIC's in the Ceph nodes.

Wido

> Neil
>
>>>
>>> 	No of OSD's 	: 5
>>> 	No of MON's 	: 3
>>> 	No of MDS's	: 2
>>> 	Linux Kernel	: 3.4.4
>>> 	Ceph version	: 0.47.3
>>>          Hard disks      : 2x160G SAS drives (raid 0 configuration)
>>>          CPU             : Intel(R) Xeon(R) Quad CPU E5506  @ 2.13GHz
>>>          Memory          : 6G
>>>
>>> Thanks
>>> __M
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

