From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: RBD fio Performance concerns
Date: Mon, 19 Nov 2012 15:56:35 +0100
Message-ID: <CAOLwVUknn4hH20P+iRbrqeNTQbFxcVFqWo=ZUM5-RQTNgqyWSQ@mail.gmail.com>
References: <50A537EA.5090409@inktank.com> <CAOLwVUmQa4C_vs_Mbi3b2LeO=wx8_EMVWX5Pyu0y-JnG8nyz+Q@mail.gmail.com>
 <50A6C54E.9010805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55299 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab2KSO46 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 09:56:58 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so1036541lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 06:56:56 -0800 (PST)
In-Reply-To: <50A6C54E.9010805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hello Mark,

=46irst of all, thank you again for another accurate answer :-).

> I would have expected write aggregation and cylinder affinity to
> have eliminated some seeks and improved rotational latency resulting
> in better than theoretical random write throughput.  Against those
> expectations 763/850 IOPS is not so impressive.  But, it looks to
> me like you were running fio in a 1G file with 100 parallel requests.
> The default RBD stripe width is 4M.  This means that those 100
> parallel requests were being spread across 256 (1G/4M) objects.
> People in the know tell me that writes to a single object are
> serialized, which means that many of those (potentially) parallel
> writes were to the same object, and hence serialized.  This would
> increase the average request time for the colliding operations,
> and reduce the aggregate throughput correspondingly.  Use a
> bigger file (or a narrower stripe) and this will get better.


I followed your advice and used a bigger file (10G) and an iodepth of
128 and I've been able to reach ~27k iops for rand reads but I
couldn't reach more than 870 iops in randwrites... It's kind of
expected. But the thing a still don't understand is: why the
sequential read/writes are lower than the randoms onces? Or maybe do I
just need to care about the bandwidth for those values?

Thank you.

Regards.
--
Bien cordialement.
S=E9bastien HAN.


On Fri, Nov 16, 2012 at 11:59 PM, Mark Kampe <mark.kampe@inktank.com> w=
rote:
> On 11/15/2012 12:23 PM, S=E9bastien Han wrote:
>
>> First of all, I would like to thank you for this well explained,
>> structured and clear answer. I guess I got better IOPS thanks to the=
 10K
>> disks.
>
>
> 10K RPM would bring your per-drive throughput (for 4K random writes)
> up to 142 IOPS and your aggregate cluster throughput up to 1700.
> This would predict a corresponding RADOSbench throughput somewhere
> above 425 (how much better depending on write aggregation and cylinde=
r
> affinity).  Your RADOSbench 708 now seems even more reasonable.
>
>> To be really honest I wasn't so concerned about the RADOS benchmarks
>> but more about the RBD fio benchmarks and the amont of IOPS that com=
es
>> out of it, which I found =E0 bit to low.
>
>
> Sticking with 4K random writes, it looks to me like you were running
> fio with libaio (which means direct, no buffer cache).  Because it
> is direct, every I/O operation is really happening and the best
> sustained throughput you should expect from this cluster is
> the aggregate raw fio 4K write throughput (1700 IOPS) divided
> by two copies =3D 850 random 4K writes per second.  If I read the
> output correctly you got 763 or about 90% of back-of-envelope.
>
> BUT, there are some footnotes (there always are with performance)
>
> If you had been doing buffered I/O you would have seen a lot more
> (up front) benefit from page caching ... but you wouldn't have been
> measuring real (and hence sustainable) I/O throughput ... which is
> ultimately limited by the heads on those twelve disk drives, where
> all of those writes ultimately wind up.  It is easy to be fast
> if you aren't really doing the writes :-)
>
> I would have expected write aggregation and cylinder affinity to
> have eliminated some seeks and improved rotational latency resulting
> in better than theoretical random write throughput.  Against those
> expectations 763/850 IOPS is not so impressive.  But, it looks to
> me like you were running fio in a 1G file with 100 parallel requests.
> The default RBD stripe width is 4M.  This means that those 100
> parallel requests were being spread across 256 (1G/4M) objects.
> People in the know tell me that writes to a single object are
> serialized, which means that many of those (potentially) parallel
> writes were to the same object, and hence serialized.  This would
> increase the average request time for the colliding operations,
> and reduce the aggregate throughput correspondingly.  Use a
> bigger file (or a narrower stripe) and this will get better.
>
> Thus, getting 763 random 4K write IOPs out of those 12 drives
> still sounds about right to me.
>
>
>> On 15 nov. 2012, at 19:43, Mark Kampe <mark.kampe@inktank.com> wrote=
:
>>
>>> Dear Sebastien,
>>>
>>> Ross Turn forwarded me your e-mail.  You sent a great deal
>>> of information, but it was not immediately obvious to me
>>> what your specific concern was.
>>>
>>> You have 4 servers, 3 OSDs per, 2 copy, and you measured a
>>> radosbench (4K object creation) throughput of 2.9MB/s
>>> (or 708 IOPS).  I infer that you were disappointed by
>>> this number, but it looks right to me.
>>>
>>> Assuming typical 7200 RPM drives, I would guess that each
>>> of them would deliver a sustained direct 4K random write
>>> performance in the general neighborhood of:
>>>     4ms seek (short seeks with write-settle-downs)
>>>     4ms latency (1/2 rotation)
>>>     0ms write (4K/144MB/s ~ 30us)
>>>     -----
>>>     8ms or about 125 IOPS
>>>
>>> Your twelve drives should therefore have a sustainable
>>> aggregate direct 4K random write throughput of 1500 IOPS.
>>>
>>> Each 4K object create involves four writes (two copies,
>>> each getting one data write and one data update).  Thus
>>> I would expect a (crude) 4K create rate of 375 IOPS (1500/4).
>>>
>>> You are getting almost twice the expected raw IOPS ...
>>> and we should expect that a large number of parallel
>>> operations would realize some write/seek aggregation
>>> benefits ... so these numbers look right to me.
>>>
>>> Is this the number you were concerned about, or have I
>>> misunderstood?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
