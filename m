From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Mon, 02 Jul 2012 15:19:48 +0200
Message-ID: <4FF19FF4.10104@profihost.ag>
References: <4FED8792.1090905@profihost.ag> <4FED964D.3080201@inktank.com> <4FEDA777.1060309@profihost.ag> <Pine.LNX.4.64.1206290819170.30691@cobra.newdream.net> <4FEE1B91.8080404@profihost.ag> <4FF0BAB8.3070503@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44072 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab2GBNTv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 09:19:51 -0400
In-Reply-To: <4FF0BAB8.3070503@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

i just want to report back some test results.

Just some results from a sheepdog test using the same hardware.

Sheepdog:

1 VM:
   write: io=12544MB, bw=142678KB/s, iops=35669, runt= 90025msec
   read : io=14519MB, bw=165186KB/s, iops=41296, runt= 90003msec
   write: io=16520MB, bw=185842KB/s, iops=45, runt= 91026msec
   read : io=102936MB, bw=1135MB/s, iops=283, runt= 90684msec

2 VMs:
   write: io=7042MB, bw=80062KB/s, iops=20015, runt= 90062msec
   read : io=8672MB, bw=98661KB/s, iops=24665, runt= 90004msec
   write: io=14008MB, bw=157443KB/s, iops=38, runt= 91107msec
   read : io=43924MB, bw=498462KB/s, iops=121, runt= 90234msec

   write: io=6048MB, bw=68772KB/s, iops=17192, runt= 90055msec
   read : io=9151MB, bw=104107KB/s, iops=26026, runt= 90006msec
   write: io=12716MB, bw=142693KB/s, iops=34, runt= 91253msec
   read : io=59616MB, bw=675648KB/s, iops=164, runt= 90353msec


Ceph:
2 VMs:
   write: io=2234MB, bw=25405KB/s, iops=6351, runt= 90041msec
   read : io=4760MB, bw=54156KB/s, iops=13538, runt= 90007msec
   write: io=56372MB, bw=638402KB/s, iops=155, runt= 90421msec
   read : io=86572MB, bw=981225KB/s, iops=239, runt= 90346msec

   write: io=2222MB, bw=25275KB/s, iops=6318, runt= 90011msec
   read : io=4747MB, bw=54000KB/s, iops=13500, runt= 90008msec
   write: io=55300MB, bw=626733KB/s, iops=153, runt= 90353msec
   read : io=84992MB, bw=965283KB/s, iops=235, runt= 90162msec

So ceph has pretty good values for sequential stuff but for random I/O 
it would be really cool to improve it.

Right now my testsystem has a theoretical 4k random I/Os bandwith of 
350.000 iops - 14 disks with 25 000 iops each (test with fio too).

Greets
Stefan


Am 01.07.2012 23:01, schrieb Stefan Priebe:
> Hello list,
>   Hello sage,
>
> i've made some further tests.
>
> Sequential 4k writes over 200GB: 300% CPU usage of kvm process 34712 iops
>
> Random 4k writes over 200GB: 170% CPU usage of kvm process 5500 iops
>
> When i make random 4k writes over 100MB: 450% CPU usage of kvm process
> and !! 25059 iops !!
>
> Random 4k writes over 1GB: 380% CPU usage of kvm process 14387 iops
>
> So the range where the random I/O happen seem to be important and the
> cpu usage just seem to reflect the iops.
>
> So i'm not sure if the problem is really the client rbd driver. Mark i
> hope you can make some tests next week.
>
> Greets
> Stefan
>
>
> Am 29.06.2012 23:18, schrieb Stefan Priebe:
>> Am 29.06.2012 17:28, schrieb Sage Weil:
>>> On Fri, 29 Jun 2012, Stefan Priebe - Profihost AG wrote:
>>>> Am 29.06.2012 13:49, schrieb Mark Nelson:
>>>>> I'll try to replicate your findings in house.  I've got some other
>>>>> things I have to do today, but hopefully I can take a look next
>>>>> week. If
>>>>> I recall correctly, in the other thread you said that sequential
>>>>> writes
>>>>> are using much less CPU time on your systems?
>>>>
>>>> Random 4k writes: 10% idle
>>>> Seq 4k writes: !! 99,7% !! idle
>>>> Seq 4M writes: 90% idle
>>>
>>> I take it 'rbd cache = true'?
>> Yes
>>
>>> It sounds like librbd (or the guest file
>>> system) is coalescing the sequential writes into big writes.  I'm a bit
>>> surprised that the 4k ones have lower CPU utilization, but there are
>>> lots
>>> of opportunity for noise there, so I would
>
>
> n't read too far into it yet.
>> 90 to 99,7 is OK the 9% goes to flush, kworker and xfs processes. It was
>> the overall system load. Not just ceph-osd.
>>
>>>>>   Do you see better scaling in that case?
>>>>
>>>> 3 osd nodes:
>>>> 1 VM:
>>>> Rand 4k writes: 7000 iops
>> <-- this one is WRONG! sorry it is 14100 iops
>>
>>
>>>> Seq 4k writes: 19900 iops
>>>>
>>>> 2 VMs:
>>>> Rand 4k writes: 6000 iops each
>>>> Seq 4k writes: 4000 iops VM 1
>>>> Seq 4k writes: 18500 iops VM 2
>>>>
>>>>
>>>> 4 osd nodes:
>>>> 1 VM:
>>>> Rand 4k writes: 14400 iops      <------ ????
>>>
>>> Can you double-check this number?
>> Triple checked BUT i see the the Rand 4k writes with 3 osd nodes was
>> wrong. Sorry.
>>
>>>> Seq 4k writes: 19000 iops
>>>>
>>>> 2 VMs:
>>>> Rand 4k writes: 7000 iops each
>>>> Seq 4k writes: 18000 iops each
>>>
>>> With the exception of that one number above, it really sounds like the
>>> bottleneck is in the client (VM or librbd+librados) and not in the
>>> cluster.  Performance won't improve when you add OSDs if the limiting
>>> factor is the clients ability to dispatch/stream/sustatin IOs.  That
>>> also
>>> seems concistent with the fact that limiting the # of CPUs on the OSDs
>>> doesn't affect much.
>> ACK
>>
>>> Aboe, with 2 VMs, for instance, your total iops for the cluster doubled
>>> (36000 total).  Can you try with 4 VMs and see if it continues to
>>> scale in
>>> that dimension?  At some point you will start to saturate the OSDs,
>>> and at
>>> that point adding more OSDs should show aggregate throughput going up.
>>  From where did you get that value? It scales to VMs on some points but
>> it does not scale with OSDs.
>>
>> Stefan
>

