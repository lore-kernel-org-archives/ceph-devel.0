From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: mon disk access pattern
Date: Mon, 18 Jun 2012 08:39:38 +0200
Message-ID: <4FDECD2A.5090607@profihost.ag>
References: <4FDACD90.2080807@profihost.ag> <4FDB05A7.3080202@widodh.nl> <4FDB1DCC.6090701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45054 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab2FRGjk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 02:39:40 -0400
In-Reply-To: <4FDB1DCC.6090701@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 15.06.2012 13:34, schrieb Mark Nelson:
> On 06/15/2012 04:51 AM, Wido den Hollander wrote:
>> Hi,
>>
>> On 15-06-12 07:52, Stefan Priebe - Profihost AG wrote:
>>> Hello list,
>>>
>>> i read somewhere that the mon has "special" disk access patterns - even
>>> though it does not write much data.
>>
>> "special"? Where did you read that? The monitor has about 1 ~ 2GB of
>> storage.
>>
>> So if your monitor has something like 4GB ~ 8GB of RAM, your kernel
>> should cache almost all your monitor data.
>>
>
> I think at some point someone mentioned to me that the mon can cause a
> lot of syncs, so running them on the OSDs without syncfs might be
> detrimental. For the majority of our internal performance testing I've
> kept them off the OSDs just to be sure.

My main idea behind that was what type of disk i need for a performant 
mon system. SATA, SAS, SSD? Raid?

Stefan
