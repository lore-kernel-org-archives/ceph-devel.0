From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: speed decrease since firefly,giant,hammer the 2nd try
Date: Tue, 10 Feb 2015 22:11:32 +0100
Message-ID: <54DA7404.4060201@profihost.ag>
References: <54DA541E.9000608@profihost.ag> <54DA578F.3000900@redhat.com> <54DA5853.3070504@profihost.ag> <54DA5E9F.3060305@redhat.com> <54DA6904.6000305@profihost.ag> <54DA6BB9.7000306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:17842 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbbBJVLb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 16:11:31 -0500
In-Reply-To: <54DA6BB9.7000306@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 10.02.2015 um 21:36 schrieb Mark Nelson:
>
>
> On 02/10/2015 02:24 PM, Stefan Priebe wrote:
>> Am 10.02.2015 um 20:40 schrieb Mark Nelson:
>>> On 02/10/2015 01:13 PM, Stefan Priebe wrote:
>>>> Am 10.02.2015 um 20:10 schrieb Mark Nelson:
>>>>> On 02/10/2015 12:55 PM, Stefan Priebe wrote:
>>>>>> Hello,
>>>>>>
>>>>>> last year in june i already reported this but there was no real
>>>>>> result.
>>>>>> (http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-July/041070.html)
>>>>>>
>>>>>>
>>>>>>
>>>>>> I then had the hope that this will be fixed itself when hammer is
>>>>>> released. Now i tried hammer an the results are bad as before.
>>>>>>
>>>>>> Since firefly librbd1 / librados2 are 20% slower for 4k random iop/s
>>>>>> than dumpling - this is also the reason why i still stick to
>>>>>> dumpling.
>>>>>>
>>>>>> I've now modified my test again to be a bit more clear.
>>>>>>
>>>>>> Ceph cluster itself completely dumpling.
>>>>>>
>>>>>> librbd1 / librados from dumpling (fio inside qemu): 23k iop/s for
>>>>>> random
>>>>>> 4k writes
>>>>>>
>>>>>> - stopped qemu
>>>>>> - cp -ra firefly_0.80.8/usr/lib/librados.so.2.0.0 /usr/lib/
>>>>>> - cp -ra firefly_0.80.8/usr/lib/librbd.so.1.0.0 /usr/lib/
>>>>>> - start qemu
>>>>>>
>>>>>> same fio, same qemu, same vm, same host, same ceph dumpling storage,
>>>>>> different librados / librbd: 16k iop/s for random 4k writes
>>>>>>
>>>>>> What's wrong with librbd / librados2 since firefly?
>>>>>
>>>>> Hi Stephen,
>>>>>
>>>>> Just off the top of my head, some questions to investigate:
>>>>>
>>>>> What happens to single op latencies?
>>>>
>>>> How to test this?
>>>
>>> try your random 4k write test using libaio, direct IO, and iodepth=1.
>>> Actually it would be interesting to know how it is with higher IO depths
>>> as well (I assume this is what you are doing now?) Basically I want to
>>> know if single-op latency changes and whether or not it gets hidden or
>>> exaggerated with lots of concurrent IO.
>>
>> dumpling:
>> ioengine=libaio and iodepth=32 with 32 threads:
>>
>> Jobs: 32 (f=32): [wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww] [100.0% done]
>> [0K/85224K /s] [0 /21.4K iops] [eta 00m:00s]
>>
>> ioengine=libaio and iodepth=1 with 32 threads:
>>
>> Jobs: 32 (f=32): [wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww] [100.0% done]
>> [0K/79064K /s] [0 /19.8K iops] [eta 00m:00s]
>>
>> firefly:
>> ioengine=libaio and iodepth=32 with 32 threads:
>>
>> Jobs: 32 (f=32): [wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww] [100.0% done]
>> [0K/55781K /s] [0 /15.4K iops] [eta 00m:00s]
>>
>> ioengine=libaio and iodepth=1 with 32 threads:
>>
>> Jobs: 32 (f=32): [wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww] [100.0% done]
>> [0K/46055K /s] [0 /11.6K iops] [eta 00m:00s]
>>
>
> Sorry, please do this with only 1 thread.  If you can include the
> latency results too that would be great.

Sorry here again.

Cache on:

dumpling:
file1: (g=0): rw=randwrite, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=1
2.0.8
Starting 1 thread
Jobs: 1 (f=1): [w] [100.0% done] [0K/42892K /s] [0 /10.8K iops] [eta 
00m:00s]
file1: (groupid=0, jobs=1): err= 0: pid=3203
   write: io=1273.1MB, bw=43483KB/s, iops=10870 , runt= 30001msec
     slat (usec): min=5 , max=183 , avg= 8.99, stdev= 1.78
     clat (usec): min=0 , max=6378 , avg=81.15, stdev=44.09
      lat (usec): min=59 , max=6390 , avg=90.35, stdev=44.22
     clat percentiles (usec):
      |  1.00th=[   59],  5.00th=[   62], 10.00th=[   64], 20.00th=[   66],
      | 30.00th=[   69], 40.00th=[   71], 50.00th=[   74], 60.00th=[   80],
      | 70.00th=[   87], 80.00th=[   95], 90.00th=[  105], 95.00th=[  114],
      | 99.00th=[  135], 99.50th=[  145], 99.90th=[  179], 99.95th=[  237],
      | 99.99th=[ 2320]
     bw (KB/s)  : min=36176, max=46816, per=99.96%, avg=43465.49, 
stdev=2169.33
     lat (usec) : 2=0.01%, 4=0.01%, 20=0.01%, 50=0.01%, 100=85.24%
     lat (usec) : 250=14.71%, 500=0.01%, 750=0.01%, 1000=0.01%
     lat (msec) : 2=0.01%, 4=0.01%, 10=0.01%
   cpu          : usr=2.95%, sys=12.29%, ctx=329519, majf=0, minf=133
   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      issued    : total=r=0/w=326130/d=0, short=r=0/w=0/d=0

Run status group 0 (all jobs):
   WRITE: io=1273.1MB, aggrb=43482KB/s, minb=43482KB/s, maxb=43482KB/s, 
mint=30001msec, maxt=30001msec

Disk stats (read/write):
   sdb: ios=166/325241, merge=0/0, ticks=8/24624, in_queue=24492, 
util=81.64%


firefly:
file1: (g=0): rw=randwrite, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=1
2.0.8
Starting 1 thread
Jobs: 1 (f=1): [w] [100.0% done] [0K/44588K /s] [0 /11.2K iops] [eta 
00m:00s]
file1: (groupid=0, jobs=1): err= 0: pid=2904
   write: io=1212.1MB, bw=41401KB/s, iops=10350 , runt= 30001msec
     slat (usec): min=5 , max=464 , avg= 8.95, stdev= 2.34
     clat (usec): min=0 , max=4410 , avg=85.81, stdev=41.82
      lat (usec): min=59 , max=4418 , avg=94.96, stdev=41.97
     clat percentiles (usec):
      |  1.00th=[   59],  5.00th=[   63], 10.00th=[   65], 20.00th=[   68],
      | 30.00th=[   72], 40.00th=[   76], 50.00th=[   80], 60.00th=[   85],
      | 70.00th=[   94], 80.00th=[  102], 90.00th=[  112], 95.00th=[  122],
      | 99.00th=[  145], 99.50th=[  155], 99.90th=[  189], 99.95th=[  239],
      | 99.99th=[ 2192]
     bw (KB/s)  : min=34352, max=45992, per=99.91%, avg=41363.80, 
stdev=3314.63
     lat (usec) : 2=0.01%, 50=0.01%, 100=77.26%, 250=22.69%, 500=0.02%
     lat (usec) : 750=0.01%, 1000=0.01%
     lat (msec) : 2=0.01%, 4=0.01%, 10=0.01%
   cpu          : usr=2.92%, sys=11.63%, ctx=313889, majf=0, minf=133
   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      issued    : total=r=0/w=310521/d=0, short=r=0/w=0/d=0

Run status group 0 (all jobs):
   WRITE: io=1212.1MB, aggrb=41401KB/s, minb=41401KB/s, maxb=41401KB/s, 
mint=30001msec, maxt=30001msec

Disk stats (read/write):
   sdb: ios=166/309726, merge=0/0, ticks=16/24772, in_queue=24688, 
util=82.30%

sorry the old cache off results were wrong here are new ones also with 
only one thread:

dumpling:
Jobs: 1 (f=1): [w] [100.0% done] [0K/2140K /s] [0 /535  iops] [eta 00m:00s]
file1: (groupid=0, jobs=1): err= 0: pid=2906
   write: io=64424KB, bw=2147.5KB/s, iops=536 , runt= 30001msec
     slat (usec): min=14 , max=848 , avg=30.27, stdev= 8.70
     clat (usec): min=914 , max=74110 , avg=1826.25, stdev=604.49
      lat (usec): min=1395 , max=74138 , avg=1857.26, stdev=604.48
     clat percentiles (usec):
      |  1.00th=[ 1592],  5.00th=[ 1656], 10.00th=[ 1688], 20.00th=[ 1736],
      | 30.00th=[ 1768], 40.00th=[ 1784], 50.00th=[ 1816], 60.00th=[ 1832],
      | 70.00th=[ 1864], 80.00th=[ 1896], 90.00th=[ 1928], 95.00th=[ 1960],
      | 99.00th=[ 2064], 99.50th=[ 2384], 99.90th=[ 5024], 99.95th=[ 5600],
      | 99.99th=[11712]
     bw (KB/s)  : min= 1768, max= 2240, per=100.00%, avg=2149.53, 
stdev=56.30
     lat (usec) : 1000=0.01%
     lat (msec) : 2=97.67%, 4=2.11%, 10=0.20%, 20=0.01%, 100=0.01%
   cpu          : usr=0.72%, sys=2.12%, ctx=19289, majf=0, minf=133
   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      issued    : total=r=0/w=16106/d=0, short=r=0/w=0/d=0

Run status group 0 (all jobs):
   WRITE: io=64424KB, aggrb=2147KB/s, minb=2147KB/s, maxb=2147KB/s, 
mint=30001msec, maxt=30001msec

Disk stats (read/write):
   sdb: ios=168/16067, merge=0/0, ticks=164/29004, in_queue=29144, 
util=96.93%

firefly:

file1: (g=0): rw=randwrite, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=1
2.0.8
Starting 1 thread
Jobs: 1 (f=1): [w] [100.0% done] [0K/2141K /s] [0 /535  iops] [eta 00m:00s]
file1: (groupid=0, jobs=1): err= 0: pid=3034
   write: io=63100KB, bw=2103.3KB/s, iops=525 , runt= 30001msec
     slat (usec): min=17 , max=388 , avg=33.26, stdev= 6.55
     clat (usec): min=1392 , max=54698 , avg=1862.25, stdev=478.79
      lat (usec): min=1507 , max=54716 , avg=1896.28, stdev=478.69
     clat percentiles (usec):
      |  1.00th=[ 1624],  5.00th=[ 1688], 10.00th=[ 1720], 20.00th=[ 1768],
      | 30.00th=[ 1800], 40.00th=[ 1832], 50.00th=[ 1848], 60.00th=[ 1880],
      | 70.00th=[ 1896], 80.00th=[ 1928], 90.00th=[ 1960], 95.00th=[ 1992],
      | 99.00th=[ 2096], 99.50th=[ 2512], 99.90th=[ 5344], 99.95th=[ 5984],
      | 99.99th=[11840]
     bw (KB/s)  : min= 1760, max= 2160, per=100.00%, avg=2104.68, 
stdev=49.36
     lat (msec) : 2=95.18%, 4=4.57%, 10=0.23%, 20=0.01%, 100=0.01%
   cpu          : usr=0.88%, sys=2.09%, ctx=18938, majf=0, minf=133
   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      issued    : total=r=0/w=15775/d=0, short=r=0/w=0/d=0

Run status group 0 (all jobs):
   WRITE: io=63100KB, aggrb=2103KB/s, minb=2103KB/s, maxb=2103KB/s, 
mint=30001msec, maxt=30001msec

Disk stats (read/write):
   sdb: ios=170/15740, merge=0/0, ticks=268/28856, in_queue=29116, 
util=96.45%

>>>>> How's CPU usage? (Does perf report show anything useful?)
>>>>> Can you get trace data?
>>>>
>>>> I'm not familiar with trace or perf - what should do exactly?
>>>
>>> you may need extra packages.  Basically on VM host, during the test with
>>> each library you'd do:
>>>
>>> sudo perf record -a -g dwarf -F 99
>>> (ctrl+c after a while)
>>> sudo perf report --stdio > foo.txt
>>>
>>> if you are on a kernel that doesn't have libunwind support:
>>>
>>> sudo perf record -a -g
>>> (ctrl+c after a while)
>>> sudo perf report --stdio > foo.txt
>>>
>>> Then look and see what's different.  This may not catch anything though.
>>
>> Don't have unwind.
>
> Too bad, oh well.
>
>> Output is only full of hex values.
>
> You'll at least need the correct debug symbols either compiled into the
> library or available wherever your OS puts them.  Sometimes the perf
> cache needs to be manually edited so they point to the right place, it's
> super annoying.

mhm i installed librbd1-dbg and librados2-dbg - but the output still 
looks useless to me. Should i upload it somewhere?

Stefan
