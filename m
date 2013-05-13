From: Greg <itooo@itooo.com>
Subject: Re: [ceph-users] RBD vs RADOS benchmark performance
Date: Mon, 13 May 2013 16:52:57 +0200
Message-ID: <5190FE49.1030307@itooo.com>
References: <518D2B76.9040706@itooo.com> <1368423516.6771.2.camel@localhost> <5190DBD9.9070500@itooo.com> <5190F0DE.8010604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.dedibox.com ([88.190.254.28]:54297 "EHLO mail.dedibox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab3EMOxA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 May 2013 10:53:00 -0400
In-Reply-To: <5190F0DE.8010604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org, Olivier Bonvalet <ceph.list@daevel.fr>, ceph-users@ceph.com

Le 13/05/2013 15:55, Mark Nelson a =C3=A9crit :
> On 05/13/2013 07:26 AM, Greg wrote:
>> Le 13/05/2013 07:38, Olivier Bonvalet a =C3=A9crit :
>>> Le vendredi 10 mai 2013 =C3=A0 19:16 +0200, Greg a =C3=A9crit :
>>>> Hello folks,
>>>>
>>>> I'm in the process of testing CEPH and RBD, I have set up a small
>>>> cluster of  hosts running each a MON and an OSD with both journal =
and
>>>> data on the same SSD (ok this is stupid but this is simple to=20
>>>> verify the
>>>> disks are not the bottleneck for 1 client). All nodes are connecte=
d=20
>>>> on a
>>>> 1Gb network (no dedicated network for OSDs, shame on me :).
>>>>
>>>> Summary : the RBD performance is poor compared to benchmark
>>>>
>>>> A 5 seconds seq read benchmark shows something like this :
>>>>>     sec Cur ops   started  finished avg MB/s  cur MB/s  last lat
>>>>> avg lat
>>>>>       0       0         0         0         0 0 -         0
>>>>>       1      16        39        23   91.9586        92 0.966117
>>>>> 0.431249
>>>>>       2      16        64        48   95.9602       100 0.513435
>>>>> 0.53849
>>>>>       3      16        90        74   98.6317       104 0.25631
>>>>> 0.55494
>>>>>       4      11        95        84   83.9735        40 1.80038
>>>>> 0.58712
>>>>>   Total time run:        4.165747
>>>>> Total reads made:     95
>>>>> Read size:            4194304
>>>>> Bandwidth (MB/sec):    91.220
>>>>>
>>>>> Average Latency:       0.678901
>>>>> Max latency:           1.80038
>>>>> Min latency:           0.104719
>>>> 91MB read performance, quite good !
>>>>
>>>> Now the RBD performance :
>>>>> root@client:~# dd if=3D/dev/rbd1 of=3D/dev/null bs=3D4M count=3D1=
00
>>>>> 100+0 records in
>>>>> 100+0 records out
>>>>> 419430400 bytes (419 MB) copied, 13.0568 s, 32.1 MB/s
>>>> There is a 3x performance factor (same for write: ~60M benchmark, =
~20M
>>>> dd on block device)
>>>>
>>>> The network is ok, the CPU is also ok on all OSDs.
>>>> CEPH is Bobtail 0.56.4, linux is 3.8.1 arm (vanilla release + some
>>>> patches for the SoC being used)
>>>>
>>>> Can you show me the starting point for digging into this ?
>>> You should try to increase read_ahead to 512K instead of the defaul=
ts
>>> 128K (/sys/block/*/queue/read_ahead_kb). I have seen a huge differe=
nce
>>> on reads with that.
>>>
>> Olivier,
>>
>> thanks a lot for pointing this out, it indeed makes a *huge*=20
>> difference !
>>> # dd if=3D/mnt/t/1 of=3D/dev/zero bs=3D4M count=3D100
>>> 100+0 records in
>>> 100+0 records out
>>> 419430400 bytes (419 MB) copied, 5.12768 s, 81.8 MB/s
>> (caches dropped before each test of course)
>>
>> Mark, this is probably something you will want to investigate and
>> explain in a "tweaking" topic of the documentation.
>>
>> Regards,
>
> Out of curiosity, has your rados bench performance improved as well?=20
> We've also seen improvements for sequential read throughput when=20
> increasing read_ahead_kb. (it may decrease random iops in some cases=20
> though!)  The reason I didn't think to mention it here though is=20
> because I was just focused on the difference between rados bench and=20
> rbd.  It would be interesting to know if rbd has improved more=20
> dramatically than rados bench.
Mark, the read ahead is set on the RBD block device (on the client), so=
=20
it doesn't improve benchmark results as the benchmark doesn't use the=20
block layer.

1 question remains : why did I have poor performance with 1 single=20
writing thread ?

Regards,
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
