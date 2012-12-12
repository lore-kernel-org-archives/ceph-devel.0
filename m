From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: ceph osd create XX
Date: Wed, 12 Dec 2012 22:43:28 +0100
Message-ID: <50C8FA80.7060808@profihost.ag>
References: <50C8F7AC.9070600@profihost.ag> <CAPYLRzjntgh+CHXbtoRvLHhvjo1wqT9F16vshsiBhLcYebUB-Q@mail.gmail.com> <50C8F939.6080400@profihost.ag> <CAPYLRzjvZWx4T4T9OHPwaY_4cuOuZW2pgPDpwVR-1Afvi=-LeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:40550 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815Ab2LLVn3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 16:43:29 -0500
In-Reply-To: <CAPYLRzjvZWx4T4T9OHPwaY_4cuOuZW2pgPDpwVR-1Afvi=-LeA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,

i don't get it. I was using this doc:
http://ceph.com/docs/master/rados/operations/add-or-rm-osds/

There is written that i have to use the osd-num for ceph osd create. 
Which UUID is now meant?

I've already added osd.61,62,63 and 64 to ceph.conf

Greets,
Stefan
Am 12.12.2012 22:41, schrieb Gregory Farnum:
> Yeah; 61 is not a valid UUID and you can't specify anything else on that line.
>
> On Wed, Dec 12, 2012 at 1:38 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> HI Greg,
>>
>> sorry just a copy & paste error.
>>
>> [cloud1-ceph1: ~]# ceph osd create 61
>> (22) Invalid argument
>>
>>
>>> Read those two lines again. Very slowly. :)
>>>
>>> The correct syntax is
>>> ceph osd create <uuid>
>>>
>>> The uuid is optional, but you don't specify IDs; it gives you an ID back.
>>
>>
>> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
