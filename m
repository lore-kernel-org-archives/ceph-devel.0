From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Sun, 01 Jul 2012 23:01:44 +0200
Message-ID: <4FF0BAB8.3070503@profihost.ag>
References: <4FED8792.1090905@profihost.ag> <4FED964D.3080201@inktank.com> <4FEDA777.1060309@profihost.ag> <Pine.LNX.4.64.1206290819170.30691@cobra.newdream.net> <4FEE1B91.8080404@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37500 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab2GAVBn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Jul 2012 17:01:43 -0400
In-Reply-To: <4FEE1B91.8080404@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,
  Hello sage,

i've made some further tests.

Sequential 4k writes over 200GB: 300% CPU usage of kvm process 34712 iops

Random 4k writes over 200GB: 170% CPU usage of kvm process 5500 iops

When i make random 4k writes over 100MB: 450% CPU usage of kvm process 
and !! 25059 iops !!

Random 4k writes over 1GB: 380% CPU usage of kvm process 14387 iops

So the range where the random I/O happen seem to be important and the 
cpu usage just seem to reflect the iops.

So i'm not sure if the problem is really the client rbd driver. Mark i 
hope you can make some tests next week.

Greets
Stefan


Am 29.06.2012 23:18, schrieb Stefan Priebe:
> Am 29.06.2012 17:28, schrieb Sage Weil:
>> On Fri, 29 Jun 2012, Stefan Priebe - Profihost AG wrote:
>>> Am 29.06.2012 13:49, schrieb Mark Nelson:
>>>> I'll try to replicate your findings in house.  I've got some other
>>>> things I have to do today, but hopefully I can take a look next
>>>> week. If
>>>> I recall correctly, in the other thread you said that sequential writes
>>>> are using much less CPU time on your systems?
>>>
>>> Random 4k writes: 10% idle
>>> Seq 4k writes: !! 99,7% !! idle
>>> Seq 4M writes: 90% idle
>>
>> I take it 'rbd cache = true'?
> Yes
>
>> It sounds like librbd (or the guest file
>> system) is coalescing the sequential writes into big writes.  I'm a bit
>> surprised that the 4k ones have lower CPU utilization, but there are lots
>> of opportunity for noise there, so I would


n't read too far into it yet.
> 90 to 99,7 is OK the 9% goes to flush, kworker and xfs processes. It was
> the overall system load. Not just ceph-osd.
>
>>>>   Do you see better scaling in that case?
>>>
>>> 3 osd nodes:
>>> 1 VM:
>>> Rand 4k writes: 7000 iops
> <-- this one is WRONG! sorry it is 14100 iops
>
>
>>> Seq 4k writes: 19900 iops
>>>
>>> 2 VMs:
>>> Rand 4k writes: 6000 iops each
>>> Seq 4k writes: 4000 iops VM 1
>>> Seq 4k writes: 18500 iops VM 2
>>>
>>>
>>> 4 osd nodes:
>>> 1 VM:
>>> Rand 4k writes: 14400 iops      <------ ????
>>
>> Can you double-check this number?
> Triple checked BUT i see the the Rand 4k writes with 3 osd nodes was
> wrong. Sorry.
>
>>> Seq 4k writes: 19000 iops
>>>
>>> 2 VMs:
>>> Rand 4k writes: 7000 iops each
>>> Seq 4k writes: 18000 iops each
>>
>> With the exception of that one number above, it really sounds like the
>> bottleneck is in the client (VM or librbd+librados) and not in the
>> cluster.  Performance won't improve when you add OSDs if the limiting
>> factor is the clients ability to dispatch/stream/sustatin IOs.  That also
>> seems concistent with the fact that limiting the # of CPUs on the OSDs
>> doesn't affect much.
> ACK
>
>> Aboe, with 2 VMs, for instance, your total iops for the cluster doubled
>> (36000 total).  Can you try with 4 VMs and see if it continues to
>> scale in
>> that dimension?  At some point you will start to saturate the OSDs,
>> and at
>> that point adding more OSDs should show aggregate throughput going up.
>  From where did you get that value? It scales to VMs on some points but
> it does not scale with OSDs.
>
> Stefan

