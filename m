From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Recommended number of pools, one Q. ever wanted to ask
Date: Tue, 28 Feb 2012 16:51:11 +0100
Message-ID: <4F4CF7EF.7010505@widodh.nl>
References: <4F4C9FE9.7000808@filoo.de> <4F4CA17F.4070007@widodh.nl> <4F4CA380.2010004@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:42884 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965614Ab2B1PvN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 10:51:13 -0500
In-Reply-To: <4F4CA380.2010004@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: ceph-devel@vger.kernel.org

Hi,

On 02/28/2012 10:50 AM, Oliver Francke wrote:
> Well,
>
> On 02/28/2012 10:42 AM, Wido den Hollander wrote:
>> Hi,
>>
>> On 02/28/2012 10:35 AM, Oliver Francke wrote:
>>> Hi *,
>>>
>>> well, there was once a comment on our layout in means of "too many
>>> pools".
>>> Our setup is to have a pool per customer, to simplify the view on used
>>> storage
>>> capacity.
>>> So, if we have - in a couple of months, we hope - more then some hundred
>>> customers, this setup was not recommended, cause the whole system is not
>>> designed for handling that. ( Sage)
>>>
>>> What does "not recommended" mean? Is it, that per OSD the used memory
>>> will be
>>> too high?
>>
>> Yes. Every new pool you create will consume some memory on the OSD. So
>> if you start creating a lot of pools, you will also start consuming
>> more and more memory.
>>
>> I haven't followed this lately, but that is the current information I
>> have.
>>
>> The number of objects in a pool is also not a problem, you can have
>> millions without any issues. It's the number of pools which will haunt
>> you later on.
>
> thnx for the quick reply, so if we can imagine, that the number of pool
> per OSD is
> the limiting factor, we shall not have more than let's say ~100, means,
> we shall be
> safe.

IIRC the number of pools is a problem, but for every pool you have a 
number of Placement Groups (PG's) (pg_num). Each PG eats a small amount 
of memory.

As the number of OSD's increases you also want to increase the number of 
PG's, this improves performance.

But as you have more PG's per pool, you start increasing memory usage. 
Now, PG's will be spread out over your OSD's, but it could still 
increase the usage.

This probably won't be a problem with 500 pools, or maybe a thousand 
pools (but it could), but going above that could be a problem.

Wido

>
>>
>> Wido
>
> best regards,
>
> Oliver.
>
>>
>>> Is this a general performance issue?
>>>
>>> Well, if we read "pool", this gave us the basic idea/concept to put all
>>> per-customers
>>> data into it.
>>>
>>> Please sched some light in 8-)
>>>
>>> Kind regards,
>>>
>>> Oliver.
>>>
>>
>
>

