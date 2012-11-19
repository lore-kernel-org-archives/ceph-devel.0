From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: RBD fio Performance concerns
Date: Mon, 19 Nov 2012 21:57:59 +0100
Message-ID: <CAOLwVUn5EAC4QaWgU+TkodcJea7ayKUANUpfzWUG+cTBunao5g@mail.gmail.com>
References: <CAOLwVUmJGZNaZsySsw8eQmLy1ZCha+AAGCp-5i42=mr0aKHMyA@mail.gmail.com>
 <3210b770-431e-44ed-8d86-4610de89dd92@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:56219 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab2KSU6W convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 15:58:22 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so1440378lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 12:58:21 -0800 (PST)
In-Reply-To: <3210b770-431e-44ed-8d86-4610de89dd92@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>

Which iodepth did you use for those benchs?


> I really don't understand why I can't get more rand read iops with 4K=
 block ...

Me neither, hope to get some clarification from the Inktank guys. It
doesn't make any sense to me...
--
Bien cordialement.
S=E9bastien HAN.


On Mon, Nov 19, 2012 at 8:11 PM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:
>>>@Alexandre: is it the same for you? or do you always get more IOPS w=
ith seq?
>
> rand read 4K : 6000 iops
> seq read 4K : 3500 iops
> seq read 4M : 31iops (1gigabit client bandwith limit)
>
> rand write 4k: 6000iops  (tmpfs journal)
> seq write 4k: 1600iops
> seq write 4M : 31iops (1gigabit client bandwith limit)
>
>
> I really don't understand why I can't get more rand read iops with 4K=
 block ...
>
> I try with high end cpu for client, it doesn't change nothing.
> But test cluster use  old 8 cores E5420  @ 2.50GHZ (But cpu is around=
 15% on cluster during read bench)
>
>
> ----- Mail original -----
>
> De: "S=E9bastien Han" <han.sebastien@gmail.com>
> =C0: "Mark Kampe" <mark.kampe@inktank.com>
> Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, "ceph-devel" <ceph-de=
vel@vger.kernel.org>
> Envoy=E9: Lundi 19 Novembre 2012 19:03:40
> Objet: Re: RBD fio Performance concerns
>
> @Sage, thanks for the info :)
> @Mark:
>
>> If you want to do sequential I/O, you should do it buffered
>> (so that the writes can be aggregated) or with a 4M block size
>> (very efficient and avoiding object serialization).
>
> The original benchmark has been performed with 4M block size. And as
> you can see I still get more IOPS with rand than seq... I just tried
> with 4M without direct I/O, still the same. I can print fio results i=
f
> it's needed.
>
>> We do direct writes for benchmarking, not because it is a reasonable
>> way to do I/O, but because it bypasses the buffer cache and enables
>> us to directly measure cluster I/O throughput (which is what we are
>> trying to optimize). Applications should usually do buffered I/O,
>> to get the (very significant) benefits of caching and write aggregat=
ion.
>
> I know why I use direct I/O. It's synthetic benchmarks, it's far away
> from a real life scenario and how common applications works. I just
> try to see the maximum I/O throughput that I can get from my RBD. All
> my applications use buffered I/O.
>
> @Alexandre: is it the same for you? or do you always get more IOPS wi=
th seq?
>
> Thanks to all of you..
>
>
> On Mon, Nov 19, 2012 at 5:54 PM, Mark Kampe <mark.kampe@inktank.com> =
wrote:
>> Recall:
>> 1. RBD volumes are striped (4M wide) across RADOS objects
>> 2. distinct writes to a single RADOS object are serialized
>>
>> Your sequential 4K writes are direct, depth=3D256, so there are
>> (at all times) 256 writes queued to the same object. All of
>> your writes are waiting through a very long line, which is adding
>> horrendous latency.
>>
>> If you want to do sequential I/O, you should do it buffered
>> (so that the writes can be aggregated) or with a 4M block size
>> (very efficient and avoiding object serialization).
>>
>> We do direct writes for benchmarking, not because it is a reasonable
>> way to do I/O, but because it bypasses the buffer cache and enables
>> us to directly measure cluster I/O throughput (which is what we are
>> trying to optimize). Applications should usually do buffered I/O,
>> to get the (very significant) benefits of caching and write aggregat=
ion.
>>
>>
>>> That's correct for some of the benchmarks. However even with 4K for
>>> seq, I still get less IOPS. See below my last fio:
>>>
>>> # fio rbd-bench.fio
>>> seq-read: (g=3D0): rw=3Dread, bs=3D4K-4K/4K-4K, ioengine=3Dlibaio, =
iodepth=3D256
>>> rand-read: (g=3D1): rw=3Drandread, bs=3D4K-4K/4K-4K, ioengine=3Dlib=
aio,
>>> iodepth=3D256
>>> seq-write: (g=3D2): rw=3Dwrite, bs=3D4K-4K/4K-4K, ioengine=3Dlibaio=
, iodepth=3D256
>>> rand-write: (g=3D3): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioengine=3Dl=
ibaio,
>>> iodepth=3D256
>>> fio 1.59
>>> Starting 4 processes
>>> Jobs: 1 (f=3D1): [___w] [57.6% done] [0K/405K /s] [0 /99 iops] [eta
>>> 02m:59s]
>>> seq-read: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D15096
>>> read : io=3D801892KB, bw=3D13353KB/s, iops=3D3338 , runt=3D 60053ms=
ec
>>> slat (usec): min=3D8 , max=3D45921 , avg=3D296.69, stdev=3D1584.90
>>> clat (msec): min=3D18 , max=3D133 , avg=3D76.37, stdev=3D16.63
>>> lat (msec): min=3D18 , max=3D133 , avg=3D76.67, stdev=3D16.62
>>> bw (KB/s) : min=3D 0, max=3D14406, per=3D31.89%, avg=3D4258.24,
>>> stdev=3D6239.06
>>> cpu : usr=3D0.87%, sys=3D5.57%, ctx=3D165281, majf=3D0, minf=3D279
>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
0.1%,
>>> >=3D64=3D100.0%
>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%,
>>> >=3D64=3D0.0%
>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
>>> >=3D64=3D0.1%
>>> issued r/w/d: total=3D200473/0/0, short=3D0/0/0
>>>
>>> lat (msec): 20=3D0.01%, 50=3D9.46%, 100=3D90.45%, 250=3D0.10%
>>> rand-read: (groupid=3D1, jobs=3D1): err=3D 0: pid=3D16846
>>> read : io=3D6376.4MB, bw=3D108814KB/s, iops=3D27203 , runt=3D 60005=
msec
>>> slat (usec): min=3D8 , max=3D12723 , avg=3D33.54, stdev=3D59.87
>>> clat (usec): min=3D4642 , max=3D55760 , avg=3D9374.10, stdev=3D970.=
40
>>> lat (usec): min=3D4671 , max=3D55788 , avg=3D9408.00, stdev=3D971.2=
1
>>> bw (KB/s) : min=3D105496, max=3D109136, per=3D100.00%, avg=3D108815=
=2E48,
>>> stdev=3D648.62
>>> cpu : usr=3D8.26%, sys=3D49.11%, ctx=3D1486259, majf=3D0, minf=3D27=
8
>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
0.1%,
>>> >=3D64=3D100.0%
>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%,
>>> >=3D64=3D0.0%
>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
>>> >=3D64=3D0.1%
>>> issued r/w/d: total=3D1632349/0/0, short=3D0/0/0
>>>
>>> lat (msec): 10=3D83.39%, 20=3D16.56%, 50=3D0.04%, 100=3D0.01%
>>> seq-write: (groupid=3D2, jobs=3D1): err=3D 0: pid=3D18653
>>> write: io=3D44684KB, bw=3D753502 B/s, iops=3D183 , runt=3D 60725mse=
c
>>> slat (usec): min=3D8 , max=3D1246.8K, avg=3D5402.76, stdev=3D40024.=
97
>>> clat (msec): min=3D25 , max=3D4868 , avg=3D1384.22, stdev=3D470.19
>>> lat (msec): min=3D25 , max=3D4868 , avg=3D1389.62, stdev=3D470.17
>>> bw (KB/s) : min=3D 7, max=3D 2165, per=3D104.03%, avg=3D764.65,
>>> stdev=3D353.97
>>> cpu : usr=3D0.05%, sys=3D0.35%, ctx=3D5478, majf=3D0, minf=3D21
>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
0.3%,
>>> >=3D64=3D99.4%
>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%,
>>> >=3D64=3D0.0%
>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
>>> >=3D64=3D0.1%
>>> issued r/w/d: total=3D0/11171/0, short=3D0/0/0
>>>
>>> lat (msec): 50=3D0.21%, 100=3D0.44%, 250=3D0.97%, 500=3D1.49%, 750=3D=
4.60%
>>> lat (msec): 1000=3D12.73%, 2000=3D66.36%, >=3D2000=3D13.20%
>>> rand-write: (groupid=3D3, jobs=3D1): err=3D 0: pid=3D20446
>>> write: io=3D208588KB, bw=3D3429.5KB/s, iops=3D857 , runt=3D 60822ms=
ec
>>> slat (usec): min=3D10 , max=3D1693.9K, avg=3D1148.15, stdev=3D15210=
=2E37
>>> clat (msec): min=3D22 , max=3D5639 , avg=3D297.37, stdev=3D430.27
>>> lat (msec): min=3D22 , max=3D5639 , avg=3D298.52, stdev=3D430.84
>>> bw (KB/s) : min=3D 0, max=3D 7728, per=3D31.44%, avg=3D1078.21,
>>> stdev=3D2000.45
>>> cpu : usr=3D0.34%, sys=3D1.61%, ctx=3D37183, majf=3D0, minf=3D19
>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
0.1%,
>>> >=3D64=3D99.9%
>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%,
>>> >=3D64=3D0.0%
>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
>>> >=3D64=3D0.1%
>>> issued r/w/d: total=3D0/52147/0, short=3D0/0/0
>>>
>>> lat (msec): 50=3D2.82%, 100=3D25.63%, 250=3D46.12%, 500=3D10.36%, 7=
50=3D5.10%
>>> lat (msec): 1000=3D2.91%, 2000=3D5.75%, >=3D2000=3D1.33%
>>>
>>> Run status group 0 (all jobs):
>>> READ: io=3D801892KB, aggrb=3D13353KB/s, minb=3D13673KB/s, maxb=3D13=
673KB/s,
>>> mint=3D60053msec, maxt=3D60053msec
>>>
>>> Run status group 1 (all jobs):
>>> READ: io=3D6376.4MB, aggrb=3D108814KB/s, minb=3D111425KB/s,
>>> maxb=3D111425KB/s, mint=3D60005msec, maxt=3D60005msec
>>>
>>> Run status group 2 (all jobs):
>>> WRITE: io=3D44684KB, aggrb=3D735KB/s, minb=3D753KB/s, maxb=3D753KB/=
s,
>>> mint=3D60725msec, maxt=3D60725msec
>>>
>>> Run status group 3 (all jobs):
>>> WRITE: io=3D208588KB, aggrb=3D3429KB/s, minb=3D3511KB/s, maxb=3D351=
1KB/s,
>>> mint=3D60822msec, maxt=3D60822msec
>>>
>>> Disk stats (read/write):
>>> rbd1: ios=3D1832984/63270, merge=3D0/0, ticks=3D16374236/17012132,
>>> in_queue=3D33434120, util=3D99.79%
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
