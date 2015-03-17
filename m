From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Fwd: Fwd: Reduce read latency and bandwidth for ec pool
Date: Tue, 17 Mar 2015 11:18:34 -0700
Message-ID: <55086FFA.2060008@redhat.com>
References: <CANE=7sUo7tMT=kyuN86vs5b13nnqY9wpOuNuf=_z=P7UXKc+sg@mail.gmail.com>	<CANE=7sVcY5sCaHUSFn+MDkAYzeewa767ziXXLqNiSCXhnG4s-g@mail.gmail.com>	<5507DC67.2030800@dachary.org>	<CANE=7sV1CQA=ZV5ELihrE4DZNGN5=4c07uP4Pv2w8LLpzqWabA@mail.gmail.com>	<CANE=7sWb3EXwwpEN_suc0JVNrm46YggVhO7sekG51w5reiMocg@mail.gmail.com>	<5507DF9E.5050903@dachary.org>	<CANE=7sUR-Wdsat=3mBHW4SWrxSJPOC4svrZkwBMYQnWQFJ5VCw@mail.gmail.com>	<5507E82A.9010306@dachary.org> <CANE=7sWF+fm-UNA+krFUEMwTKzCJHJeaaCY_aq4yHLXvhV=Yzw@mail.gmail.com> <5507ECBF.9030404@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55336 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbbCQSTk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Mar 2015 14:19:40 -0400
In-Reply-To: <5507ECBF.9030404@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Xinze Chi <xmdxcxz@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/17/2015 01:58 AM, Loic Dachary wrote:
>
>
> On 17/03/2015 09:45, Xinze Chi wrote:
>> Sorry, I have not measure it.
>>
>> But I think it should really reduce latency when hit miss in cache
>> pool and do_proxy_read.
>
> Interesting. I bet Jason or Josh have an opinion about this.

Yes, it sounds like a great idea! It seems like we'd need this
for other potential optimizations in the future anyway:

  * partial-object promotes for cache tiers
  * client-side ec to eliminate another network hop

This would also enable efficient reads from replicas for
EC pools in general. That could be useful for rbd parent snapshots
stored in a cache tier.

This makes me wonder if it would be useful to add write-once
append-only rbd images that could be stored directly on EC pools, for
use as parent images.

Josh

>
>>
>> 2015-03-17 16:39 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>
>>>
>>> On 17/03/2015 09:05, Xinze Chi wrote:
>>>> RBD.
>>>
>>> Did you measure that RBD does a significant amount of reads that wo=
uld be optimized in this way ?
>>>
>>>> Maybe we could use tier pool.
>>>>
>>>> Thanks
>>>>
>>>> 2015-03-17 16:02 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>>>
>>>>>
>>>>> On 17/03/2015 08:52, Xinze Chi wrote:
>>>>>> ---------- Forwarded message ----------
>>>>>> From: Xinze Chi <xmdxcxz@gmail.com>
>>>>>> Date: 2015-03-17 15:52 GMT+08:00
>>>>>> Subject: Re: Fwd: Reduce read latency and bandwidth for ec pool
>>>>>> To: Loic Dachary <loic@dachary.org>
>>>>>>
>>>>>>
>>>>>> Yes, In my VDI environment, client read 4k every time. If we can=
 read
>>>>>> object from only shard. It would reduce the latency and bandwidt=
h a
>>>>>> lot.
>>>>>
>>>>> I'm curious about your workload. Are you using RadosGW ? RBD ?
>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>> 2015-03-17 15:48 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 17/03/2015 08:27, Xinze Chi wrote:
>>>>>>>> hi, loic:
>>>>>>>>
>>>>>>>>     I have an idea which could reduce read latency and bandwid=
th for ec pool.
>>>>>>>>
>>>>>>>>     But, I don't know whether it is feasible.
>>>>>>>>
>>>>>>>>     Such as ec pool stripe_width =3D 16384 =3D 4 * 4096,  K =3D=
 4, M =3D2
>>>>>>>>
>>>>>>>>     So ceph will partition the total of 16384 bytes to 4 data =
chunk,
>>>>>>>> and encoding 2 parity chunk
>>>>>>>>
>>>>>>>>     shard_0 include 0 - (4096-1) in original data;
>>>>>>>>     shard_1 include 4096 - (4096*2 - 1) in original data;
>>>>>>>>     shard_2 include 4096*2 - (4096 * 3 -1) in original data;
>>>>>>>>     shard_3 include 4096*3 - (4096 * 4 - 1) in original data
>>>>>>>>     shard_4 include parity chunk
>>>>>>>>     shard_5 include parity chunk
>>>>>>>>
>>>>>>>>      Now if client read (offset 0, len 4096) from object, it s=
hould
>>>>>>>> read 4 shard (from 0-3) and decode all this 4 chunk.
>>>>>>>>
>>>>>>>>      But, this example, maybe we can compute the destination s=
hard
>>>>>>>> based on ec pool config ,read offset and read len , we only re=
ad
>>>>>>>>
>>>>>>>> shard_0 and return it to client, because shard_0 has include a=
ll data
>>>>>>>> as client need.
>>>>>>>
>>>>>>> That optimization makes sense to me. I guess you're interested =
in having small objects in the pool and only read a few bytes at a time=
 ?
>>>>>>>
>>>>>>> Cheers
>>>>>>>
>>>>>>>>
>>>>>>>>      Wait for your comment.
>>>>>>>>
>>>>>>>>      Thanks.
>>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>>>>>
>>>>>
>>>>> --
>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
