From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: RBD fio Performance concerns
Date: Wed, 21 Nov 2012 10:34:52 -0600
Message-ID: <50AD02AC.60802@inktank.com>
References: <CAOLwVUmJGZNaZsySsw8eQmLy1ZCha+AAGCp-5i42=mr0aKHMyA@mail.gmail.com> <3210b770-431e-44ed-8d86-4610de89dd92@mailpro> <CAOLwVUn5EAC4QaWgU+TkodcJea7ayKUANUpfzWUG+cTBunao5g@mail.gmail.com> <50ACF8C8.7020908@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:36714 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab2KUQe4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 11:34:56 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so5166205iay.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Nov 2012 08:34:54 -0800 (PST)
In-Reply-To: <50ACF8C8.7020908@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>

Responding to my own message. :)

Talked to Sage a bit offline about this.  I think there are two opposin=
g=20
forces:

On one hand, random IO may be spreading reads/writes out across more=20
OSDs than sequential IO that presumably would be hitting a single OSD=20
more regularly.

On the other hand, you'd expect that sequential writes would be getting=
=20
coalesced either at the RBD layer or on the OSD, and that the=20
drive/controller/filesystem underneath the OSD would be doing some kind=
=20
of readahead or prefetching.

On the third hand, maybe coalescing/prefetching is in fact happening bu=
t=20
we are IOP limited by some per-osd limitation.

It could be interesting to do the test with a single OSD and see what=20
happens.

Mark

On 11/21/2012 09:52 AM, Mark Nelson wrote:
> Hi Guys,
>
> I'm late to this thread but thought I'd chime in.  Crazy that you are
> getting higher performance with random reads/writes vs sequential!  I=
t
> would be interesting to see what kind of throughput smalliobench repo=
rts
> (should be packaged in bobtail) and also see if this behavior happens
> with cephfs.  It's still too early in the morning for me right now to
> come up with a reasonable explanation for what's going on.  It might =
be
> worth running blktrace and seekwatcher to see what the io patterns on
> the underlying disk look like in each case.  Maybe something unexpect=
ed
> is going on.
>
> Mark
>
> On 11/19/2012 02:57 PM, S=E9bastien Han wrote:
>> Which iodepth did you use for those benchs?
>>
>>
>>> I really don't understand why I can't get more rand read iops with =
4K
>>> block ...
>>
>> Me neither, hope to get some clarification from the Inktank guys. It
>> doesn't make any sense to me...
>> --
>> Bien cordialement.
>> S=E9bastien HAN.
>>
>>
>> On Mon, Nov 19, 2012 at 8:11 PM, Alexandre DERUMIER
>> <aderumier@odiso.com> wrote:
>>>>> @Alexandre: is it the same for you? or do you always get more IOP=
S
>>>>> with seq?
>>>
>>> rand read 4K : 6000 iops
>>> seq read 4K : 3500 iops
>>> seq read 4M : 31iops (1gigabit client bandwith limit)
>>>
>>> rand write 4k: 6000iops  (tmpfs journal)
>>> seq write 4k: 1600iops
>>> seq write 4M : 31iops (1gigabit client bandwith limit)
>>>
>>>
>>> I really don't understand why I can't get more rand read iops with =
4K
>>> block ...
>>>
>>> I try with high end cpu for client, it doesn't change nothing.
>>> But test cluster use  old 8 cores E5420  @ 2.50GHZ (But cpu is arou=
nd
>>> 15% on cluster during read bench)
>>>
>>>
>>> ----- Mail original -----
>>>
>>> De: "S=E9bastien Han" <han.sebastien@gmail.com>
>>> =C0: "Mark Kampe" <mark.kampe@inktank.com>
>>> Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, "ceph-devel"
>>> <ceph-devel@vger.kernel.org>
>>> Envoy=E9: Lundi 19 Novembre 2012 19:03:40
>>> Objet: Re: RBD fio Performance concerns
>>>
>>> @Sage, thanks for the info :)
>>> @Mark:
>>>
>>>> If you want to do sequential I/O, you should do it buffered
>>>> (so that the writes can be aggregated) or with a 4M block size
>>>> (very efficient and avoiding object serialization).
>>>
>>> The original benchmark has been performed with 4M block size. And a=
s
>>> you can see I still get more IOPS with rand than seq... I just trie=
d
>>> with 4M without direct I/O, still the same. I can print fio results=
 if
>>> it's needed.
>>>
>>>> We do direct writes for benchmarking, not because it is a reasonab=
le
>>>> way to do I/O, but because it bypasses the buffer cache and enable=
s
>>>> us to directly measure cluster I/O throughput (which is what we ar=
e
>>>> trying to optimize). Applications should usually do buffered I/O,
>>>> to get the (very significant) benefits of caching and write
>>>> aggregation.
>>>
>>> I know why I use direct I/O. It's synthetic benchmarks, it's far aw=
ay
>>> from a real life scenario and how common applications works. I just
>>> try to see the maximum I/O throughput that I can get from my RBD. A=
ll
>>> my applications use buffered I/O.
>>>
>>> @Alexandre: is it the same for you? or do you always get more IOPS
>>> with seq?
>>>
>>> Thanks to all of you..
>>>
>>>
>>> On Mon, Nov 19, 2012 at 5:54 PM, Mark Kampe <mark.kampe@inktank.com=
>
>>> wrote:
>>>> Recall:
>>>> 1. RBD volumes are striped (4M wide) across RADOS objects
>>>> 2. distinct writes to a single RADOS object are serialized
>>>>
>>>> Your sequential 4K writes are direct, depth=3D256, so there are
>>>> (at all times) 256 writes queued to the same object. All of
>>>> your writes are waiting through a very long line, which is adding
>>>> horrendous latency.
>>>>
>>>> If you want to do sequential I/O, you should do it buffered
>>>> (so that the writes can be aggregated) or with a 4M block size
>>>> (very efficient and avoiding object serialization).
>>>>
>>>> We do direct writes for benchmarking, not because it is a reasonab=
le
>>>> way to do I/O, but because it bypasses the buffer cache and enable=
s
>>>> us to directly measure cluster I/O throughput (which is what we ar=
e
>>>> trying to optimize). Applications should usually do buffered I/O,
>>>> to get the (very significant) benefits of caching and write
>>>> aggregation.
>>>>
>>>>
>>>>> That's correct for some of the benchmarks. However even with 4K f=
or
>>>>> seq, I still get less IOPS. See below my last fio:
>>>>>
>>>>> # fio rbd-bench.fio
>>>>> seq-read: (g=3D0): rw=3Dread, bs=3D4K-4K/4K-4K, ioengine=3Dlibaio=
, iodepth=3D256
>>>>> rand-read: (g=3D1): rw=3Drandread, bs=3D4K-4K/4K-4K, ioengine=3Dl=
ibaio,
>>>>> iodepth=3D256
>>>>> seq-write: (g=3D2): rw=3Dwrite, bs=3D4K-4K/4K-4K, ioengine=3Dliba=
io,
>>>>> iodepth=3D256
>>>>> rand-write: (g=3D3): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioengine=3D=
libaio,
>>>>> iodepth=3D256
>>>>> fio 1.59
>>>>> Starting 4 processes
>>>>> Jobs: 1 (f=3D1): [___w] [57.6% done] [0K/405K /s] [0 /99 iops] [e=
ta
>>>>> 02m:59s]
>>>>> seq-read: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D15096
>>>>> read : io=3D801892KB, bw=3D13353KB/s, iops=3D3338 , runt=3D 60053=
msec
>>>>> slat (usec): min=3D8 , max=3D45921 , avg=3D296.69, stdev=3D1584.9=
0
>>>>> clat (msec): min=3D18 , max=3D133 , avg=3D76.37, stdev=3D16.63
>>>>> lat (msec): min=3D18 , max=3D133 , avg=3D76.67, stdev=3D16.62
>>>>> bw (KB/s) : min=3D 0, max=3D14406, per=3D31.89%, avg=3D4258.24,
>>>>> stdev=3D6239.06
>>>>> cpu : usr=3D0.87%, sys=3D5.57%, ctx=3D165281, majf=3D0, minf=3D27=
9
>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=
=3D0.1%,
>>>>>> =3D64=3D100.0%
>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
>>>>>> =3D64=3D0.0%
>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%,
>>>>>> =3D64=3D0.1%
>>>>> issued r/w/d: total=3D200473/0/0, short=3D0/0/0
>>>>>
>>>>> lat (msec): 20=3D0.01%, 50=3D9.46%, 100=3D90.45%, 250=3D0.10%
>>>>> rand-read: (groupid=3D1, jobs=3D1): err=3D 0: pid=3D16846
>>>>> read : io=3D6376.4MB, bw=3D108814KB/s, iops=3D27203 , runt=3D 600=
05msec
>>>>> slat (usec): min=3D8 , max=3D12723 , avg=3D33.54, stdev=3D59.87
>>>>> clat (usec): min=3D4642 , max=3D55760 , avg=3D9374.10, stdev=3D97=
0.40
>>>>> lat (usec): min=3D4671 , max=3D55788 , avg=3D9408.00, stdev=3D971=
=2E21
>>>>> bw (KB/s) : min=3D105496, max=3D109136, per=3D100.00%, avg=3D1088=
15.48,
>>>>> stdev=3D648.62
>>>>> cpu : usr=3D8.26%, sys=3D49.11%, ctx=3D1486259, majf=3D0, minf=3D=
278
>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=
=3D0.1%,
>>>>>> =3D64=3D100.0%
>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
>>>>>> =3D64=3D0.0%
>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%,
>>>>>> =3D64=3D0.1%
>>>>> issued r/w/d: total=3D1632349/0/0, short=3D0/0/0
>>>>>
>>>>> lat (msec): 10=3D83.39%, 20=3D16.56%, 50=3D0.04%, 100=3D0.01%
>>>>> seq-write: (groupid=3D2, jobs=3D1): err=3D 0: pid=3D18653
>>>>> write: io=3D44684KB, bw=3D753502 B/s, iops=3D183 , runt=3D 60725m=
sec
>>>>> slat (usec): min=3D8 , max=3D1246.8K, avg=3D5402.76, stdev=3D4002=
4.97
>>>>> clat (msec): min=3D25 , max=3D4868 , avg=3D1384.22, stdev=3D470.1=
9
>>>>> lat (msec): min=3D25 , max=3D4868 , avg=3D1389.62, stdev=3D470.17
>>>>> bw (KB/s) : min=3D 7, max=3D 2165, per=3D104.03%, avg=3D764.65,
>>>>> stdev=3D353.97
>>>>> cpu : usr=3D0.05%, sys=3D0.35%, ctx=3D5478, majf=3D0, minf=3D21
>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=
=3D0.3%,
>>>>>> =3D64=3D99.4%
>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
>>>>>> =3D64=3D0.0%
>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%,
>>>>>> =3D64=3D0.1%
>>>>> issued r/w/d: total=3D0/11171/0, short=3D0/0/0
>>>>>
>>>>> lat (msec): 50=3D0.21%, 100=3D0.44%, 250=3D0.97%, 500=3D1.49%, 75=
0=3D4.60%
>>>>> lat (msec): 1000=3D12.73%, 2000=3D66.36%, >=3D2000=3D13.20%
>>>>> rand-write: (groupid=3D3, jobs=3D1): err=3D 0: pid=3D20446
>>>>> write: io=3D208588KB, bw=3D3429.5KB/s, iops=3D857 , runt=3D 60822=
msec
>>>>> slat (usec): min=3D10 , max=3D1693.9K, avg=3D1148.15, stdev=3D152=
10.37
>>>>> clat (msec): min=3D22 , max=3D5639 , avg=3D297.37, stdev=3D430.27
>>>>> lat (msec): min=3D22 , max=3D5639 , avg=3D298.52, stdev=3D430.84
>>>>> bw (KB/s) : min=3D 0, max=3D 7728, per=3D31.44%, avg=3D1078.21,
>>>>> stdev=3D2000.45
>>>>> cpu : usr=3D0.34%, sys=3D1.61%, ctx=3D37183, majf=3D0, minf=3D19
>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=
=3D0.1%,
>>>>>> =3D64=3D99.9%
>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
>>>>>> =3D64=3D0.0%
>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%,
>>>>>> =3D64=3D0.1%
>>>>> issued r/w/d: total=3D0/52147/0, short=3D0/0/0
>>>>>
>>>>> lat (msec): 50=3D2.82%, 100=3D25.63%, 250=3D46.12%, 500=3D10.36%,=
 750=3D5.10%
>>>>> lat (msec): 1000=3D2.91%, 2000=3D5.75%, >=3D2000=3D1.33%
>>>>>
>>>>> Run status group 0 (all jobs):
>>>>> READ: io=3D801892KB, aggrb=3D13353KB/s, minb=3D13673KB/s, maxb=3D=
13673KB/s,
>>>>> mint=3D60053msec, maxt=3D60053msec
>>>>>
>>>>> Run status group 1 (all jobs):
>>>>> READ: io=3D6376.4MB, aggrb=3D108814KB/s, minb=3D111425KB/s,
>>>>> maxb=3D111425KB/s, mint=3D60005msec, maxt=3D60005msec
>>>>>
>>>>> Run status group 2 (all jobs):
>>>>> WRITE: io=3D44684KB, aggrb=3D735KB/s, minb=3D753KB/s, maxb=3D753K=
B/s,
>>>>> mint=3D60725msec, maxt=3D60725msec
>>>>>
>>>>> Run status group 3 (all jobs):
>>>>> WRITE: io=3D208588KB, aggrb=3D3429KB/s, minb=3D3511KB/s, maxb=3D3=
511KB/s,
>>>>> mint=3D60822msec, maxt=3D60822msec
>>>>>
>>>>> Disk stats (read/write):
>>>>> rbd1: ios=3D1832984/63270, merge=3D0/0, ticks=3D16374236/17012132=
,
>>>>> in_queue=3D33434120, util=3D99.79%
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
