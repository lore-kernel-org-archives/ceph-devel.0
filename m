From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: RBD fio Performance concerns
Date: Mon, 19 Nov 2012 16:42:15 +0100
Message-ID: <CAOLwVU=ed5fdg96Nk7gvvJqdK5vpnweZ7zJTGYVWcYikqY_j1Q@mail.gmail.com>
References: <CAOLwVUknn4hH20P+iRbrqeNTQbFxcVFqWo=ZUM5-RQTNgqyWSQ@mail.gmail.com>
 <d4bdfae3-9a87-4815-994f-cfc20be355a7@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:62344 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab2KSPmh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 10:42:37 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so1187330lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 07:42:35 -0800 (PST)
In-Reply-To: <d4bdfae3-9a87-4815-994f-cfc20be355a7@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>

> If I remember, you use fio with 4MB block size for sequential.
> So it's normal that you have less ios, but more bandwith.

That's correct for some of the benchmarks. However even with 4K for
seq, I still get less IOPS. See below my last fio:

# fio rbd-bench.fio
seq-read: (g=3D0): rw=3Dread, bs=3D4K-4K/4K-4K, ioengine=3Dlibaio, iode=
pth=3D256
rand-read: (g=3D1): rw=3Drandread, bs=3D4K-4K/4K-4K, ioengine=3Dlibaio,=
 iodepth=3D256
seq-write: (g=3D2): rw=3Dwrite, bs=3D4K-4K/4K-4K, ioengine=3Dlibaio, io=
depth=3D256
rand-write: (g=3D3): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioengine=3Dlibai=
o, iodepth=3D256
fio 1.59
Starting 4 processes
Jobs: 1 (f=3D1): [___w] [57.6% done] [0K/405K /s] [0 /99  iops] [eta 02=
m:59s]
seq-read: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D15096
  read : io=3D801892KB, bw=3D13353KB/s, iops=3D3338 , runt=3D 60053msec
    slat (usec): min=3D8 , max=3D45921 , avg=3D296.69, stdev=3D1584.90
    clat (msec): min=3D18 , max=3D133 , avg=3D76.37, stdev=3D16.63
     lat (msec): min=3D18 , max=3D133 , avg=3D76.67, stdev=3D16.62
    bw (KB/s) : min=3D    0, max=3D14406, per=3D31.89%, avg=3D4258.24, =
stdev=3D6239.06
  cpu          : usr=3D0.87%, sys=3D5.57%, ctx=3D165281, majf=3D0, minf=
=3D279
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
0.1%, >=3D64=3D100.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.1%
     issued r/w/d: total=3D200473/0/0, short=3D0/0/0

     lat (msec): 20=3D0.01%, 50=3D9.46%, 100=3D90.45%, 250=3D0.10%
rand-read: (groupid=3D1, jobs=3D1): err=3D 0: pid=3D16846
  read : io=3D6376.4MB, bw=3D108814KB/s, iops=3D27203 , runt=3D 60005ms=
ec
    slat (usec): min=3D8 , max=3D12723 , avg=3D33.54, stdev=3D59.87
    clat (usec): min=3D4642 , max=3D55760 , avg=3D9374.10, stdev=3D970.=
40
     lat (usec): min=3D4671 , max=3D55788 , avg=3D9408.00, stdev=3D971.=
21
    bw (KB/s) : min=3D105496, max=3D109136, per=3D100.00%, avg=3D108815=
=2E48, stdev=3D648.62
  cpu          : usr=3D8.26%, sys=3D49.11%, ctx=3D1486259, majf=3D0, mi=
nf=3D278
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
0.1%, >=3D64=3D100.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.1%
     issued r/w/d: total=3D1632349/0/0, short=3D0/0/0

     lat (msec): 10=3D83.39%, 20=3D16.56%, 50=3D0.04%, 100=3D0.01%
seq-write: (groupid=3D2, jobs=3D1): err=3D 0: pid=3D18653
  write: io=3D44684KB, bw=3D753502 B/s, iops=3D183 , runt=3D 60725msec
    slat (usec): min=3D8 , max=3D1246.8K, avg=3D5402.76, stdev=3D40024.=
97
    clat (msec): min=3D25 , max=3D4868 , avg=3D1384.22, stdev=3D470.19
     lat (msec): min=3D25 , max=3D4868 , avg=3D1389.62, stdev=3D470.17
    bw (KB/s) : min=3D    7, max=3D 2165, per=3D104.03%, avg=3D764.65, =
stdev=3D353.97
  cpu          : usr=3D0.05%, sys=3D0.35%, ctx=3D5478, majf=3D0, minf=3D=
21
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
0.3%, >=3D64=3D99.4%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.1%
     issued r/w/d: total=3D0/11171/0, short=3D0/0/0

     lat (msec): 50=3D0.21%, 100=3D0.44%, 250=3D0.97%, 500=3D1.49%, 750=
=3D4.60%
     lat (msec): 1000=3D12.73%, 2000=3D66.36%, >=3D2000=3D13.20%
rand-write: (groupid=3D3, jobs=3D1): err=3D 0: pid=3D20446
  write: io=3D208588KB, bw=3D3429.5KB/s, iops=3D857 , runt=3D 60822msec
    slat (usec): min=3D10 , max=3D1693.9K, avg=3D1148.15, stdev=3D15210=
=2E37
    clat (msec): min=3D22 , max=3D5639 , avg=3D297.37, stdev=3D430.27
     lat (msec): min=3D22 , max=3D5639 , avg=3D298.52, stdev=3D430.84
    bw (KB/s) : min=3D    0, max=3D 7728, per=3D31.44%, avg=3D1078.21, =
stdev=3D2000.45
  cpu          : usr=3D0.34%, sys=3D1.61%, ctx=3D37183, majf=3D0, minf=3D=
19
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
0.1%, >=3D64=3D99.9%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.1%
     issued r/w/d: total=3D0/52147/0, short=3D0/0/0

     lat (msec): 50=3D2.82%, 100=3D25.63%, 250=3D46.12%, 500=3D10.36%, =
750=3D5.10%
     lat (msec): 1000=3D2.91%, 2000=3D5.75%, >=3D2000=3D1.33%

Run status group 0 (all jobs):
   READ: io=3D801892KB, aggrb=3D13353KB/s, minb=3D13673KB/s, maxb=3D136=
73KB/s,
mint=3D60053msec, maxt=3D60053msec

Run status group 1 (all jobs):
   READ: io=3D6376.4MB, aggrb=3D108814KB/s, minb=3D111425KB/s,
maxb=3D111425KB/s, mint=3D60005msec, maxt=3D60005msec

Run status group 2 (all jobs):
  WRITE: io=3D44684KB, aggrb=3D735KB/s, minb=3D753KB/s, maxb=3D753KB/s,
mint=3D60725msec, maxt=3D60725msec

Run status group 3 (all jobs):
  WRITE: io=3D208588KB, aggrb=3D3429KB/s, minb=3D3511KB/s, maxb=3D3511K=
B/s,
mint=3D60822msec, maxt=3D60822msec

Disk stats (read/write):
  rbd1: ios=3D1832984/63270, merge=3D0/0, ticks=3D16374236/17012132,
in_queue=3D33434120, util=3D99.79%

Cheers!
--
Bien cordialement.
S=E9bastien HAN.


On Mon, Nov 19, 2012 at 4:28 PM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:
>>>why the
>>>sequential read/writes are lower than the randoms onces? Or maybe do=
 I
>>>just need to care about the bandwidth for those values?
>
> If I remember, you use fio with 4MB block size for sequential.
> So it's normal that you have less ios, but more bandwith.
>
>
>
> ----- Mail original -----
>
> De: "S=E9bastien Han" <han.sebastien@gmail.com>
> =C0: "Mark Kampe" <mark.kampe@inktank.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=E9: Lundi 19 Novembre 2012 15:56:35
> Objet: Re: RBD fio Performance concerns
>
> Hello Mark,
>
> First of all, thank you again for another accurate answer :-).
>
>> I would have expected write aggregation and cylinder affinity to
>> have eliminated some seeks and improved rotational latency resulting
>> in better than theoretical random write throughput. Against those
>> expectations 763/850 IOPS is not so impressive. But, it looks to
>> me like you were running fio in a 1G file with 100 parallel requests=
=2E
>> The default RBD stripe width is 4M. This means that those 100
>> parallel requests were being spread across 256 (1G/4M) objects.
>> People in the know tell me that writes to a single object are
>> serialized, which means that many of those (potentially) parallel
>> writes were to the same object, and hence serialized. This would
>> increase the average request time for the colliding operations,
>> and reduce the aggregate throughput correspondingly. Use a
>> bigger file (or a narrower stripe) and this will get better.
>
>
> I followed your advice and used a bigger file (10G) and an iodepth of
> 128 and I've been able to reach ~27k iops for rand reads but I
> couldn't reach more than 870 iops in randwrites... It's kind of
> expected. But the thing a still don't understand is: why the
> sequential read/writes are lower than the randoms onces? Or maybe do =
I
> just need to care about the bandwidth for those values?
>
> Thank you.
>
> Regards.
> --
> Bien cordialement.
> S=E9bastien HAN.
>
>
> On Fri, Nov 16, 2012 at 11:59 PM, Mark Kampe <mark.kampe@inktank.com>=
 wrote:
>> On 11/15/2012 12:23 PM, S=E9bastien Han wrote:
>>
>>> First of all, I would like to thank you for this well explained,
>>> structured and clear answer. I guess I got better IOPS thanks to th=
e 10K
>>> disks.
>>
>>
>> 10K RPM would bring your per-drive throughput (for 4K random writes)
>> up to 142 IOPS and your aggregate cluster throughput up to 1700.
>> This would predict a corresponding RADOSbench throughput somewhere
>> above 425 (how much better depending on write aggregation and cylind=
er
>> affinity). Your RADOSbench 708 now seems even more reasonable.
>>
>>> To be really honest I wasn't so concerned about the RADOS benchmark=
s
>>> but more about the RBD fio benchmarks and the amont of IOPS that co=
mes
>>> out of it, which I found =E0 bit to low.
>>
>>
>> Sticking with 4K random writes, it looks to me like you were running
>> fio with libaio (which means direct, no buffer cache). Because it
>> is direct, every I/O operation is really happening and the best
>> sustained throughput you should expect from this cluster is
>> the aggregate raw fio 4K write throughput (1700 IOPS) divided
>> by two copies =3D 850 random 4K writes per second. If I read the
>> output correctly you got 763 or about 90% of back-of-envelope.
>>
>> BUT, there are some footnotes (there always are with performance)
>>
>> If you had been doing buffered I/O you would have seen a lot more
>> (up front) benefit from page caching ... but you wouldn't have been
>> measuring real (and hence sustainable) I/O throughput ... which is
>> ultimately limited by the heads on those twelve disk drives, where
>> all of those writes ultimately wind up. It is easy to be fast
>> if you aren't really doing the writes :-)
>>
>> I would have expected write aggregation and cylinder affinity to
>> have eliminated some seeks and improved rotational latency resulting
>> in better than theoretical random write throughput. Against those
>> expectations 763/850 IOPS is not so impressive. But, it looks to
>> me like you were running fio in a 1G file with 100 parallel requests=
=2E
>> The default RBD stripe width is 4M. This means that those 100
>> parallel requests were being spread across 256 (1G/4M) objects.
>> People in the know tell me that writes to a single object are
>> serialized, which means that many of those (potentially) parallel
>> writes were to the same object, and hence serialized. This would
>> increase the average request time for the colliding operations,
>> and reduce the aggregate throughput correspondingly. Use a
>> bigger file (or a narrower stripe) and this will get better.
>>
>> Thus, getting 763 random 4K write IOPs out of those 12 drives
>> still sounds about right to me.
>>
>>
>>> On 15 nov. 2012, at 19:43, Mark Kampe <mark.kampe@inktank.com> wrot=
e:
>>>
>>>> Dear Sebastien,
>>>>
>>>> Ross Turn forwarded me your e-mail. You sent a great deal
>>>> of information, but it was not immediately obvious to me
>>>> what your specific concern was.
>>>>
>>>> You have 4 servers, 3 OSDs per, 2 copy, and you measured a
>>>> radosbench (4K object creation) throughput of 2.9MB/s
>>>> (or 708 IOPS). I infer that you were disappointed by
>>>> this number, but it looks right to me.
>>>>
>>>> Assuming typical 7200 RPM drives, I would guess that each
>>>> of them would deliver a sustained direct 4K random write
>>>> performance in the general neighborhood of:
>>>> 4ms seek (short seeks with write-settle-downs)
>>>> 4ms latency (1/2 rotation)
>>>> 0ms write (4K/144MB/s ~ 30us)
>>>> -----
>>>> 8ms or about 125 IOPS
>>>>
>>>> Your twelve drives should therefore have a sustainable
>>>> aggregate direct 4K random write throughput of 1500 IOPS.
>>>>
>>>> Each 4K object create involves four writes (two copies,
>>>> each getting one data write and one data update). Thus
>>>> I would expect a (crude) 4K create rate of 375 IOPS (1500/4).
>>>>
>>>> You are getting almost twice the expected raw IOPS ...
>>>> and we should expect that a large number of parallel
>>>> operations would realize some write/seek aggregation
>>>> benefits ... so these numbers look right to me.
>>>>
>>>> Is this the number you were concerned about, or have I
>>>> misunderstood?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
